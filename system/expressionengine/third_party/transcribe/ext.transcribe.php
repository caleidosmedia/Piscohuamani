<?php if( ! defined('BASEPATH')) exit('No direct script access allowed');

require_once PATH_THIRD . 'transcribe/mod.transcribe.php';
require_once PATH_THIRD . 'transcribe/libraries/Cache.php';
use Transcribe\Cache;

class Transcribe_ext {

	public $name = 'Transcribe';
	public $version = '1.6.1';
	public $description = '';
	public $settings_exist = 'n';
	public $docs_url = '';
	public $settings = array();

	public $entry_sql;

	private $EE;
	private $site_id;

	public function __construct( $settings='' )
	{
		$this->EE =& get_instance();
		$this->transcribe = new Transcribe();

		$this->settings = $settings;
		$this->site_id = $this->EE->config->config['site_id'];
	}

	public function activate_extension()
	{
		$hooks['channel_entries_query_result'] = 'transcribe_channel_entries_query_results';
		$hooks['channel_entries_tagdata'] = 'transcribe_channel_entries_tagdata';

		if(version_compare(APP_VER, '2.7.3', '<='))
		{
			$hooks['channel_module_create_pagination'] = 'transcribe_channel_module_create_pagination';
		}

		$hooks['sessions_start'] = 'transcribe_session_start';
		$hooks['cp_menu_array'] = 'transcribe_cp_menu_array';
		$hooks['edit_entries_additional_where'] = 'transcribe_edit_entries_additional_where';
		$hooks['entry_submission_start'] = 'transcribe_submission_start';

		// added for 280
		$hooks['channel_search_modify_search_query'] = 'transcribe_channel_search_modify_search_query';

		if(version_compare(APP_VER, '2.7.0', '>='))
		{
			$hooks['channel_form_submit_entry_end'] = 'transcribe_safecracker_submit_entry_end';
		}
		else
		{
			$hooks['safecracker_submit_entry_end'] = 'transcribe_safecracker_submit_entry_end';
		}

		// matrix hooks
		$hooks['matrix_data_query'] = 'transcribe_matrix_data_query';
		// playa hooks
		$hooks['playa_fetch_rels_query'] = 'transcribe_playa_fetch_rels_query';
		// structure hooks
		$hooks['structure_index_view_data'] = 'transcribe_structure_index_view_data';
		$hooks['structure_get_data_end'] = 'transcribe_structure_get_data_end';
		$hooks['structure_get_selective_data_results'] = 'transcribe_structure_get_selective_data_results';
		$hooks['structure_allow_dupes'] = 'transcribe_structure_allow_dupes';

		foreach ($hooks as $hook => $ext_method)
		{
			$this->EE->db->insert('extensions', array(
				'class'		=> __CLASS__,
				'method'	=> $ext_method,
				'hook'		=> $hook,
				'settings'	=> serialize($this->settings),
				'priority'	=> 9,
				'version'	=> $this->version,
				'enabled'	=> 'y'
			));
		}
	}

	/**
	 * Extension at channel_entries_query_results hook
	 *
	 * Receives a query result of entries which we then modify to pull the
	 * proper translation of the query result if they exist. If nothing exists
	 * we return the query results with no change to what was passed into the
	 * function.
	 */
	public function transcribe_channel_entries_query_results( $object, $query_results )
	{
		$disable_transcribe = $this->EE->TMPL->fetch_param('transcribe');
		if( !empty($disable_transcribe) AND $disable_transcribe == 'disable' ) return $query_results;

		if (REQ == 'CP') return FALSE;

		// is transcribe enabled for this site?
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $query_results;

		// is_search boolean
		$is_search = FALSE;

		// get currently selected language
		if(!empty($this->EE->config->_global_vars['transcribe:lang_id']))
			$config_lang_id = $this->EE->config->_global_vars['transcribe:lang_id'];

		if(empty($config_lang_id))
		{
			$language_id = $this->transcribe->_set_current_language();
			$language_id = $language_id['id'];
		}
		else
		{
			$language_id = $config_lang_id;
		}

		$search_id = $this->EE->uri->query_string;

		$pattern = '/\/.+/';
		$replacement = '';
		$search_id = preg_replace($pattern, $replacement, $search_id);

		if( !empty($this->EE->TMPL->module_data['Search']) )
			$search_result = $this->EE->db->get_where('search', array('search_id' => $search_id), 1)->row();

		$is_channel = strstr($object->EE->TMPL->tagproper, '{exp:channel:entries');

		// set the current page for use later
		$cur_page = $this->EE->pagination->cur_page;
		$current_offset = $object->pagination->offset;
		$per_page = $object->pagination->per_page;

		// is this a search query?
		if( !empty($this->EE->TMPL->module_data['Search'])  && !empty($search_result) && empty($is_channel) && version_compare(APP_VER, '2.7.3', '<='))
		{
			// the following is to get the first search results to display properly.
			// rewriting the search query here to only reflect entries from our current language.
			$search_query = unserialize(stripslashes($search_result->query));

			// check to see if the query has already been modified
			$already_modified = strstr($search_query, 'transcribe_entries_languages');

			if( $already_modified != FALSE && ($this->EE->pagination->cur_page == 1 || $this->EE->pagination->cur_page == 0) )
			{
				// This means we need to go aehad and filter the first results.  All other pages are filtered base on the search query being changed in the pagination below.
				$is_search = TRUE;

				$search_result->query = unserialize(stripslashes($search_result->query));
				$object->sql = $search_result->query;
				$this->EE->session->set_cache('transcribe', 'entries_sql', $search_query);

				$current_count = count($query_results);
				$search_limit = "LIMIT $current_count";

				preg_match('/IN \(([0-9,]+)\)/', $search_result->query, $matches);
				$entry_ids = explode(',', $matches[1]);

				$all_entry_ids = array();
				foreach($entry_ids as $id) $all_entry_ids[]['entry_id'] = $id;

				// save ORDER BY for later use
				preg_match('/ORDER BY (.*)$/', $search_result->query, $matches);
				if( !empty($matches) )
					$order_by = $matches[1];

				if( !empty($_SESSION['search']) )
				{
					// don't love this approach, but due to the way the search module is built this is needed if we want our excerpts
					unset($_SESSION['search']);
					$url = $this->EE->functions->fetch_site_index(TRUE).$this->EE->uri->uri_string;
					$this->EE->functions->redirect($url);
				}
			}
			else
			{
				$object->pagination->page_links = NULL;
				$url = $this->EE->functions->fetch_site_index(1);

				// this injects the language segment when it's suppose to be present on pagination and autopath stuff.
				$object->pagination->basepath = $this->transcribe->_set_base($object->pagination->basepath);

				// return the results.. should be filtered from pagination code block below
				return $query_results;
			}
		}
		else
		{
			$this->EE->db->select('el.id', 1);
			$this->EE->db->from('transcribe_entries_languages as el');
			$this->EE->db->where_not_in('language_id ', 0);
			$query = $this->EE->db->get();

			if( $query->num_rows() == 0 )
				return $query_results;

			if( empty($this->entry_sql) AND !empty($object->sql) )
			{
				$this->EE->session->set_cache('transcribe', 'entries_sql', $object->sql);
			}

			// retrieve all entry_id's without the query limit (limit results after grabbing the translations)
			$current_queries = array_reverse($this->EE->db->queries);

			$select_entries_sql = NULL;

			foreach( $current_queries as $query )
			{
				// check for relationship
				if( strpos($query, 'SELECT rel_id, rel_parent_id, rel_child_id, rel_type, rel_data') !== FALSE )
				{
					return $query_results;
				}
				elseif( strpos($query, 'SELECT `rel_id`, `rel_parent_id`, `rel_child_id`, `rel_type`, `reverse_rel_data`' ) !== FALSE )
				{
					// we have a reverse relationship
					return $query_results;
				}
				elseif( (strpos($query, 'SELECT t.entry_id FROM ' . $this->EE->db->dbprefix('channel_titles') . ' AS t') !== FALSE) OR (strpos($query, 'SELECT DISTINCT(t.entry_id) FROM ' . $this->EE->db->dbprefix('channel_titles') . ' AS t') !== FALSE) )
				{

					// in ee 2.80 they added the class to the end of this.. we need to remove it here.
					if(version_compare(APP_VER, '2.8.0', '>='))
					{

						if(strpos($query, "#APP/modules/") !== FALSE)
							$query = substr($query, 0, strpos($query, "#APP/modules/"));

						if(strpos($query, "#APP/third_party/") !== FALSE)
							$query = substr($query, 0, strpos($query, "#APP/third_party/"));
					}

					// we have regular results
					// save LIMIT for use later
					preg_match('/LIMIT ([0-9,\s]+)$/', $query, $matches);

					if( !empty($matches) )
					{
						$limit = $matches[1];
						$values = explode(',', $matches[1]);
						$limit = array(
							'offset' => trim($values[0]),
							'limit' => trim($values[1]),
						);
					}

					// remove limit from query
					$select_entries_sql = preg_replace('/LIMIT [0-9,\s]+$/', '', $query);

					// save ORDER BY for later use
					preg_match('/ORDER BY (.*)$/', $select_entries_sql, $matches);
					if( !empty($matches) )
						$order_by = $matches[1];

					if(!empty($select_entries_sql))
					{
						$all_entry_ids = $this->EE->db->query($select_entries_sql);
						$all_entry_ids = $all_entry_ids->result_array();
					}


					break;
				}
			}

		}

		if( empty($all_entry_ids))
		{
			$query_results = $this->rewrite_channel_and_comment_urls($query_results, $language_id);
			return $query_results;
		}

		// cache all entry id's for later use
		$original_entry_ids = array();
		foreach( $all_entry_ids as $row )
			$original_entry_ids[] = $row['entry_id'];

		$entry_ids_hardcoded= $this->EE->TMPL->fetch_param('entry_id');


		// get languages to be added in
		$add_langs = $this->_get_add_in_langs();
		$all_languages = $this->_get_all_languages();

		// get entry id's for all entries in this result set with the current language id
		$this->EE->db->select('el.entry_id, el.language_id, el.relationship_id');
		$this->EE->db->from('transcribe_entries_languages AS tel');
		$this->EE->db->join('transcribe_entries_languages AS el', 'el.relationship_id = tel.relationship_id', 'INNER');
		$this->EE->db->join('channel_titles as t', 't.entry_id = el.entry_id');
		$this->EE->db->join('channels as w', 'w.channel_id = t.channel_id', 'left');
		$this->EE->db->join('channel_data as wd', 'wd.entry_id = t.entry_id', 'left');
		$this->EE->db->join('members as m', 'm.member_id = t.author_id', 'left');
		$this->EE->db->join('member_data as md', 'md.member_id = m.member_id', 'left');

		// if entry ids are passed...pull in statuses here
		if( !empty($entry_ids_hardcoded) )
		{
			if( ($channel_status = $this->EE->TMPL->fetch_param('status')) !== FALSE )
			{
				// have to use the following string replace and not str to lower since custom statuses can have upper case chars
				$status = str_replace(array('Open', 'Closed'), array('open', 'closed'), $channel_status);
				$and_or = $this->EE->functions->sql_andor_string($status, 't.status');

				// first characters are always AND.. remove them
				$status_where = str_replace(substr($and_or, 0, 3), '', $and_or);

				$this->EE->db->where($status_where, NULL, FALSE);
			}
			else
			{
				$this->EE->db->where('t.status', 'open');
			}

		}

		$this->EE->db->where_in('tel.entry_id', $original_entry_ids);


		// adding multiple langage entry ids here.
		if(empty($all_languages))
		{
			// standard operation is just the current language
			$this->EE->db->where('el.language_id', $language_id);
		}
		else
		{
			// we want to go ahead and add additional languages
			// first this is first... add the current language
			$lang_ids[] = $language_id;

			// loop over the add in langauges and add them to an array to be used in where in.
			foreach($add_langs as $add_in_lang)
			{
				if(!empty($all_languages[$add_in_lang]) && $all_languages[$add_in_lang]->id != $language_id)
				{
					$lang_ids[] = $all_languages[$add_in_lang]->id;
				}
			}

			// lang_ids is all languages we want to add in.
			$this->EE->db->where_in('el.language_id', $lang_ids);
			// this SQL statement should remove related entries from the added in language from the results as well... which is intended.
		}

		// end adding in multiple languages
		if( !empty($order_by) )
		{
			$this->EE->db->order_by($order_by, '', FALSE);
		}

		if( !empty($limit) )
		{
			// added this due to a limit issue where we didn't
			$this->EE->db->distinct();
			$this->EE->db->limit($limit['limit'], $limit['offset']);
		}

		$new_ids = $this->EE->db->get();
		$new_ids = $new_ids->result_array();

		// go ahead and save this query for pagination later if we are running multiple languages
		if(!empty($all_languages))
		{
			$entries_query = $this->EE->db->last_query();

			if(version_compare(APP_VER, '2.8.0', '>='))
			{
				$app_pos = strpos($entries_query, "#APP/");
				$ext_pos = strpos($entries_query, "#ext.transcribe.php");

				if ($app_pos > 0)
				{
					$entries_query = substr($entries_query, 0, $app_pos);
				}
				elseif ($ext_pos > 0)
				{
					$entries_query = substr($entries_query, 0, $ext_pos);
				}
			}

			// save to cache so we can use it later
			Cache::set(array('entries_query'), $entries_query);
		}

		// loop over the data and organize it in entry id key relationship
		foreach($new_ids as $row)
		{
			$new_ids_relationship[$row['entry_id']] = $row['relationship_id'];
		}

		if(!empty($new_ids_relationship))
		{
			// since by default the enry ids for our current language are going to be first from the query...
			//  and array_unique preserves the first keys (entry_ids) we'll filter out the duplicate non primary language ones with an array_unique
			//  in the event that more the one language is suppose to be added in, we will filter out entries related in the langauges in the order
			// the are passsed in as params to the channel_entries loop
			$new_ids_relationship = array_unique($new_ids_relationship);

			// flip them into our entry_ids array and re index the values
			$entry_ids = array_values(array_flip($new_ids_relationship));
		}
		else
		{
			// build a new array of entry id's to re-run the channel entries query with the current language
			$entry_ids = array();
		}

		$entry_ids = array_unique($entry_ids);


		if( empty($entry_ids_hardcoded) )
			$entry_ids = array_intersect($entry_ids, $original_entry_ids);

		// if there are no entries to select, return an empty result
		if( empty($entry_ids) )
		{
			// wow why was this so hard to do
			$object->return_data = $object->EE->TMPL->no_results;
			return array();
		}

		// modify the original query to get the correct entries for the current language
		$sql_split = preg_split('/IN \([0-9,]+\)/', $this->EE->session->cache['transcribe']['entries_sql']);
		$sql = $sql_split[0] . 'IN (' . implode(',', $entry_ids) . ')' . $sql_split[1];

		if( $is_search )
		{
			$sql .= ' '. $search_limit;
			$sql= str_replace('MDBMPREFIX', $this->EE->db->dbprefix, $sql);
		}

		$results = $this->EE->db->query($sql);

		if( !empty($object->enable['categories']) )
		{
			// rebuild category data.
			$object->query = $results;
			$object->fetch_categories();
		}

		$results = $results->result_array();

		$results = $this->rewrite_channel_and_comment_urls($results, $language_id);

		// pagination check
		if(!empty($object->enable['pagination']) && $object->enable['pagination'] == true )
		{
			// standard operation... just the currnet language
			if(empty($all_languages))
			{
				$this->EE->db->select('COUNT(entry_id) AS count');
				$this->EE->db->from('transcribe_entries_languages');
				$this->EE->db->where_in('entry_id', $original_entry_ids);
				$this->EE->db->where('language_id', $language_id);
				$entries_count = $this->EE->db->get();
				$entries_count = $entries_count->row();
			}
			else
			{
				// we have more then one langauge active here... we need to run the results generation query and remove the limit
				// limit is always set with pagination...
				$entries_query = Cache::get(array('entries_query'));

				preg_match('/LIMIT ([0-9,\s]+)$/', $entries_query, $matches);

				if(!empty($matches))
				{
					$values = explode(',', $matches[1]);
					$entries_query = str_replace($matches['0'], '', $entries_query);
				}

				$entries_count = $this->EE->db->query($entries_query);

				$entries_count->count = $entries_count->num_rows;
				// ok, were going to be adding in entires from more then one language.... go ahead and add it in here.
				// $this->EE->db->where_in('language_id', $lang_ids);
			}

			if(version_compare(APP_VER, '2.4.0', '>='))
			{
				// reset pagination links
				$object->pagination->page_links = NULL;
				$url = $this->EE->functions->fetch_site_index(1);

				// setup pagination for EE 2.4.0+
				$object->pagination->absolute_results = $entries_count->count;
				$object->absolute_results = $entries_count->count;
				$object->pagination->total_rows = $entries_count->count;

				// update to support var names in 280
				if(version_compare(APP_VER, '2.8.0', '>='))
				{
					$object->pagination->total_items = $entries_count->count;
				}
				else
				{
					$object->EE->pagination->total_rows = $entries_count->count;
				}


				//the following is to add support for next and prev linking
				// do we have more then 0?


				if( !empty($object->pagination->per_page) && (!empty($object->pagination->total_rows) || !empty($object->pagination->total_items)) )
				{
					// we have to check for 280 since theres a bug that will put the query into the per_page element.
					if(version_compare(APP_VER, '2.8.0', '>='))
					{

						$entries_limit = $this->EE->TMPL->fetch_param('limit');
						if(!empty($entries_limit))
						{
							$object->pagination->per_page = $entries_limit;
						}

						if(!empty($entries_limit))
						{
							$object->pagination->total_pages = intval(floor($object->pagination->total_items / $entries_limit));
						}
					}
					else
					{
						$object->pagination->total_pages = intval(floor($object->pagination->total_rows / $object->pagination->per_page));
					}

				}
				else
				{

					$object->pagination->total_pages = 1;
				}

				$current_page = $object->pagination->current_page;

				if(version_compare(APP_VER, '2.8.0', '>='))
				{
					// finally we build the pagination
					if(!empty($entries_limit))
					{
						// this is where we need to rest the page links
						$reflector = new ReflectionClass($object->pagination);
						// get the protected var
						$_page_links = $reflector->getProperty('_page_links');
						// change scope so we can change it
						$_page_links->setAccessible(true);
						// change it
						$_page_links->setValue($object->pagination, '');

						$_page_array = $reflector->getProperty('_page_array');
						$_page_array->setAccessible(true);
						$_page_array->setValue($object->pagination, array());

						$object->pagination->build($entries_count->count, $entries_limit);
					}

				}
				else
				{
					// finally we build the pagination
					$object->pagination->build($entries_count->count, $sql);
				}

				// reset vars
				$object->pagination->current_page = $current_page;
				$object->pagination->cur_page = $cur_page;
				$object->pagination->offset = $current_offset;
				$object->pagination->per_page = $per_page;

				//we run into an issue with EE adding an extra next page link based on logic thats already executed. This needs to be at the bottom of the pagination data
				if($object->pagination->total_pages == $object->pagination->current_page)
					$object->pagination->page_next = '';
			}
			else
			{
				// reset pagination links
				if( !empty($object->pagination_links) )
					$object->pagination_links = '';

				// setup pagination for Pre-EE 2.4.0
				$object->absolute_results = $entries_count->count;
				$object->total_rows = $entries_count->count;
				$object->EE->pagination->total_rows = $entries_count->count;
				$this->EE->pagination->total_rows = $entries_count->count;
				$object->create_pagination($entries_count->count);
			}
		}

		$language = $this->transcribe->_set_current_language();

		// check current langauge to see if we need to do dynamic field replacement
		// this needs to be at the top so we can get channel results on search results as well.

		if( is_array($object->cfields) && count($object->cfields) > 0 )
		{
			// make sure we have fields in the given site
			if( !empty($object->cfields[$this->site_id]) )
			{
				foreach($object->cfields[$this->site_id] as $name => $id)
				{
					$suffixes = strstr($name, "__");
					if( !empty($suffixes) )
					{
						$all_suffixes_string = array_values(array_filter(explode("__", $suffixes)));
						$all_suffixes = explode('_', $all_suffixes_string['0']);

						foreach($all_suffixes as $suffix)
						{
							if($suffix == $language['abbreviation'])
							{
								// add the changed filed to session cache so we can modify queries below (ie. matrix)
								$base_name = str_replace('__'.$all_suffixes_string['0'], '', $name);
								if( !empty($object->cfields[$this->site_id][$base_name]) )
									$changes[] = array($object->cfields[$this->site_id][$base_name] => $id);

								// assign the field id to the base tag name
								$object->cfields[$this->site_id][$base_name] = $id;
							}
						}
					}
					unset($suffixes);
				}
			}

			//set changes to session var
			if( !empty($changes) )
				$this->EE->session->set_cache('transcribe', 'field_changes', $changes);
		}

		// do we have facades enabled?
		$transcribe_uri_enabled = $this->EE->config->item('transcribe_uri_facade');

		if( !empty($transcribe_uri_enabled) && !empty($entry_ids) )
		{
			$query = $this->EE->db->select('uri, entry_id')
									->from('transcribe_uris')
									->where_in('entry_id', implode(',', $entry_ids))->get();

			foreach($results as $key => $result_row)
			{
				$result[$key]['transcribe_uri'] = FALSE;
				foreach($query->result() as $row)
				{
					if($row->entry_id == $result_row['entry_id'])
					{
						$results[$key]['transcribe_uri'] = $row->uri;
					}
				}
			}


		}
		if(!empty($add_langs))
		{
			$lang_pages = array();
			// get current site_pages
			$site_pages_live = $this->EE->config->item('site_pages');

			// get lang data in format needed
			$langs_by_id = $this->_get_all_languages(TRUE);

			$entry_langauges = $this->transcribe->_get_language($entry_ids);

			// format this array so we don't loop over it once for every entry
			foreach($entry_langauges as $entry_lang_details)
				$entry_langs_by_entry_id[$entry_lang_details['entry_id']] = $entry_lang_details;

			// add the entry specific lang data
			foreach($results as $key => $result_row)
			{
				$results[$key]['transcribe_entry_lang_abbr'] = $langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->abbreviation;
				$results[$key]['transcribe_entry_lang_name'] = $langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->name;
				$results[$key]['transcribe_entry_lang_id'] = $langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->id;

				// if we have an entry in a different language we need to go aehad and get the proper page_url for it
				if($language['id'] != $langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->id)
				{
					if(empty($lang_pages[$langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->id]))
					{
						$lang_pages[$langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->id] =
						$this->get_site_pages_for_lang($langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]);
					}

					$entry_pages_data = $lang_pages[$langs_by_id[$entry_langs_by_entry_id[$result_row['entry_id']]['language_id']]->id];

					// get returned data and output the uri for the right langauge
					if(!empty($entry_pages_data[$this->site_id]['uris'][$result_row['entry_id']]))
					{
						$results[$key]['transcribe_entry_url'] = $entry_pages_data[$this->site_id]['uris'][$result_row['entry_id']];
					}


				}
				else
				{
					// default language
					if(!empty($site_pages_live[$this->site_id]['uris'][$result_row['entry_id']]))
					{
						$results[$key]['transcribe_entry_url'] = $site_pages_live[$this->site_id]['uris'][$result_row['entry_id']];
					}

				}
			}

		}
		return $results;
	}

	/*
	 * this hook was added in ee 280 for us to modify the search query.
	 * Returns modified query
	*/
	public function transcribe_channel_search_modify_search_query($query, $hash)
	{
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $query;

		// take the query and break it on the WHER
		$query_parts = explode('WHERE', $query);

		if(!empty($query_parts) && count($query_parts) == 2)
		{
			// get currently selected language
			$segments = explode('/', $this->EE->uri->uri_string);
			// if the first segment is an abbreviation for a language, set as active language
			$is_abbreviation = $this->EE->db->get_where('transcribe_languages', array('abbreviation' => $segments[0]));
			$is_abbreviation = $is_abbreviation->row();

			if(!empty($is_abbreviation->abbreviation))
			{
				$language_id = $this->transcribe->_set_current_language($is_abbreviation->abbreviation);
			}
			else
			{
				$language_id = $this->transcribe->_set_current_language();
			}

			$query = $query_parts[0].' LEFT JOIN exp_transcribe_entries_languages ON exp_channel_titles.entry_id = exp_transcribe_entries_languages.entry_id WHERE exp_transcribe_entries_languages.language_id = '.$language_id['id'].' AND '.$query_parts[1];
		}
		return $query;
	}


	public function get_site_pages_for_lang($lang_data)
	{
		$return = FALSE;
		if( $this->EE->db->table_exists('structure') )
		{
			$this->sql = new Sql_structure();

			// get site pages
			$site_pages = $this->sql->get_site_pages(TRUE);

			// format site pages how it's needed
			$site_pages = array($this->site_id=> $site_pages);
		}

		if(!empty($site_pages))
		{
			// we need to go ahead and reset the site pages to have the whole tree in it for now.
			// first we save off the current operational tree
			$site_pages_live = $this->EE->config->item('site_pages');

			// save the live langauge so we can toggel it back
			$live_language = $this->transcribe->_set_current_language();

			// now we set it to the full version
			$this->EE->config->set_item('site_pages', $site_pages);


			// get array keys and langauge they belong to
			$site_pages_entry_ids = array_keys($site_pages[$this->site_id]['uris']);
			$site_pages_entry_languages = $this->transcribe->_get_language($site_pages_entry_ids);

			// remove the ones that don't belong to our language

			foreach($site_pages_entry_languages as $entry)
			{
				if( $entry['language_id']!= $lang_data->id )
				{
					unset($site_pages[$this->site_id]['uris'][$entry['entry_id']]);
					unset($site_pages[$this->site_id]['templates'][$entry['entry_id']]);
					continue;
				}
			}

			$return = $this->_get_related_structure_url($site_pages, $lang_data->abbreviation);

			// cleanup time... change langauge back to what live is.
			$this->transcribe->_set_current_language($live_language['abbreviation']);

			// restore current site pages
			$this->EE->config->set_item('site_pages', $site_pages_live);
		}

		return $return;
	}


	/**
	 * Extension at channel_entries_tagdata hook
	 *
	 * Modify the row's tagata by replacing variables that generate paths with
	 * transcribe's uri path translator
	 */
	public function transcribe_channel_entries_tagdata( $tagdata, $row, $object )
	{
		//checking to see if Transcribe is enabled for this site
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $tagdata;

		// replace variable tag: url_title_path
		$tagdata = preg_replace("/\{url_title_path=\'([^']*)'\}/", "{exp:transcribe:uri path='$1'}{url_title}", $tagdata);

		// replace variable tag: entry_id_path
		$tagdata = preg_replace("/\{entry_id_path=\'([^']*)'\}/", "{exp:transcribe:uri path='$1'}{entry_id}", $tagdata);

		return $tagdata;
	}

	/**
	 * Extension at channel_module_create_pagination hook
	 *
	 * Override the urls in $object to display the translated url for the
	 * current language
	 */
	public function transcribe_channel_module_create_pagination( $object )
	{
		// check the current version of EE... if it's 280 or greater we remove the hook for this function
		if(version_compare(APP_VER, '2.8.0', '>='))
		{
			// we're on 280 or greater.. need to remove this hook.
			$this->EE->db->delete('extensions ', array('method' => 'transcribe_channel_module_create_pagination'));
		}

		$disable_transcribe = $this->EE->TMPL->fetch_param('transcribe');
		if( !empty($disable_transcribe) AND $disable_transcribe == 'disable' ) return false;

		// checking to see if Transcribe is enabled for this site
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return FALSE;

		// If SELF does not exists in site_index config item, set
		// site_index to empty. If the language abbreviation is there it
		// will auto-append SELF in the pagination library.

		$object->EE->config->config['site_index'] = (strpos($object->EE->config->config['site_index'], SELF) === FALSE) ? '' : $object->EE->config->config['site_index'];

		// is this a search query?
		if( !empty($this->EE->TMPL->module_data['Search']) )
		{
			$search_id = $this->EE->uri->query_string;

			$pattern = '/\/.+/';
			$replacement = '';
			$search_id = preg_replace($pattern, $replacement, $search_id);

			$search_result = $this->EE->db->get_where('search', array('search_id' => $search_id), 1)->row();

			if( !empty($search_result) )
			{
				// rewriting the search query here to only reflect entries from our current language.
				$search_query = unserialize(stripslashes($search_result->query));

				// check to see if the query has already been modified
				$already_modified = strstr($search_query, 'transcribe_entries_languages');

				if( $already_modified === FALSE )
				{
					// this means query is not modified and we can continue

					$search_parts = explode('WHERE', $search_query);

					$num_parts = count($search_parts);

					// this will only work when there is no subquery with a where clause... not an issue currently.
					if($num_parts == 2 && !empty($_SESSION['transcribe']['id']))
					{
						$transcribe_join = ' JOIN MDBMPREFIXtranscribe_entries_languages AS te ON t.entry_id = te.entry_id WHERE te.language_id = '.$_SESSION['transcribe']['id'];

						$new_search_query = $search_parts[0].$transcribe_join.' AND'.$search_parts[1];

						// get results to modify the number of pages for the initial results
						$sql = str_replace('MDBMPREFIX', 'exp_', $new_search_query);

						$query = $this->EE->db->query($sql);
						$object->total_rows = $query->num_rows();

						$new_search_query = addslashes(serialize($new_search_query));

						// query has now been rewritten, insert it into the db.
						$this->EE->db->where('search_id', $search_id);
						$this->EE->db->update('search', array('query'  => $new_search_query, 'total_results' => $object->total_rows));
						$_SESSION['search'] = TRUE;
					}

				}

				return false;
			}
		}

		// normal pagination
		$site_url = $this->EE->functions->fetch_site_index(0);
		$uri_string = $this->transcribe->_uri_reverse_lookup( str_replace($site_url, '', $object->basepath) );

		$object->basepath = $this->transcribe->reduce_slashes($site_url . '/' . $uri_string);

		return $object;
	}


	public function transcribe_submission_start()
	{
		$this->_get_transcribe_settings();

		if( empty($this->transcribe_settings->enable_transcribe) ) return FALSE;

		if(isset($this->EE->api_channel_entries->data['revision_post']['structure__parent_id']))
		{
			if( !empty($this->EE->api_channel_entries->data['revision_post']['structure__parent_id']) )
			{
				// This means we have a Strucuture parent... Lets check the parent language id and compare it to our current language id.
				$entry_language = $this->transcribe->_get_language(array($this->EE->api_channel_entries->data['revision_post']['structure__parent_id']));
				$entry_language = $entry_language['0'];

				// are the langauges the same... if not we'll set the parent id to 0
				if( $entry_language['language_id'] != $this->EE->input->post('transcribe__transcribe_language') )
				{
					// if not we need to set the parent id to 0 which will make it a top level page in the other language.
					$this->EE->api_channel_entries->data['revision_post']['structure__parent_id'] = 0;

					if( !empty($this->EE->api_channel_entries->data['structure__parent_id']))
						$this->EE->api_channel_entries->data['structure__parent_id'] = 0;
				}
			}
		}
	}

	/**
	 * Extension at session_start hook
	 *
	 * Process the url to load the proper template group and template name
	 * depending on the current language or the language passed in the first
	 * segment.
	 */
	public function transcribe_session_start( $object )
	{
		if (REQ == 'CP') return FALSE;

		// were going to need to do a str_replace on the url string before we explode the segments.
		// might want to switch this so use segment_array
		$route = '';
		$segments = explode('/', $this->EE->uri->uri_string);

		// following code will check if this is being executed on an Action ID.. if so we'll go ahead and kill the processing.
		$act = $this->EE->input->get_post('ACT');

		if($act)
		{
			$action_id = $this->EE->db->get_where('actions', array( 'class'=>'Transcribe', 'method'=>'language_switcher' ), 1);
			$action_id = $action_id->row('action_id');

			// we need to check if this is a dev deamon form submission.
			if(is_numeric($act))
			{
				$submitted_action_id_data = $this->EE->db->get_where('actions', array('action_id' => $act));

				// do we have a result?
				if($submitted_action_id_data->num_rows() == 1)
				{
					$submitted_action_id_data = $submitted_action_id_data->row();

					// is it the forms class?... if so we don't want this to process... we need to have transcribe continue to run for the Forms module.
					if($submitted_action_id_data->class != 'Forms')
					{
						if($act != $action_id)
						{
							// before we return false we want to set the language.
							// if the first segment is an abbreviation for a language, set as active language
							$is_abbreviation = $this->EE->db->get_where('transcribe_languages', array('abbreviation' => $segments[0]));
							$is_abbreviation = $is_abbreviation->row();

							if( !empty($is_abbreviation->abbreviation) )
							{
								$current_language = $this->transcribe->_set_current_language($is_abbreviation->abbreviation);
							}
							else
							{
								$no_abbr_lang = $this->EE->config->item('transcribe_no_abbr');

								if( !empty($no_abbr_lang) )
								{
									if( is_array($no_abbr_lang) )
									{
										$no_abbr_lang = $no_abbr_lang[$this->EE->config->item('site_short_name')];
									}
										$current_language = $this->transcribe->_set_current_language($no_abbr_lang);
								}
								else
								{
									$current_language = $this->transcribe->_set_current_language();
								}

							}

							$this->EE->config->_global_vars['transcribe:language_abbreviation'] = $current_language['abbreviation'];
							$this->EE->config->_global_vars['transcribe:lang_id'] = $current_language['id'];
							$this->EE->config->_global_vars['transcribe:language_name'] = $current_language['name'];
							$this->EE->db->save_queries = TRUE;
							// end setting the language.

							return FALSE;
						}
					}
				}
			}
		}

		$this->EE->db->save_queries = TRUE;

		// variable to detect if were changing languages
		$switching_lang = $this->EE->input->get_post('lang', TRUE);

		// start session if it hasn't been already
		if( session_id() == '' ) session_start();

		// the following is a seed for betterwork flow to work in the CP as intended.
		// do we have bwf
		$bwf = $this->EE->input->get('bwf_token_id');

		if(!empty($bwf))
		{
			// we have better work flow
			// get the entry id and check the language it's in
			$bwf_entry_id = $this->EE->input->get('bwf_entry_id');

			if(!empty($bwf_entry_id))
			{
				// go ahead and query our langauges tables
				$result = $this->EE->db->get_where('transcribe_entries_languages', array('entry_id' => $bwf_entry_id));
				if($result->num_rows > 0)
				{
					// this means we have a langage associated with this entry
					// go ahead and get all languages
					$all_languages = $this->EE->db->get('transcribe_languages');
					$all_languages = $all_languages->result();

					foreach($all_languages as $lang)
					{
						// look for a language match
						if(($lang->id == $result->row('language_id')) && ($lang->force_prefix == 1))
						{
							// if it's a match on the language id and we have force_prefix... we'll go ahead and trick the system into thinking it's the language we want
							// force our langauge segment onto the stack
							array_unshift($segments, $lang->abbreviation);
							$segments[0] = $lang->abbreviation;
							break;
						}
					}
				}
			}
		}



		// if the first segment is an abbreviation for a language, set as active language
		$is_abbreviation = $this->EE->db->get_where('transcribe_languages', array('abbreviation' => $segments[0]));
		$is_abbreviation = $is_abbreviation->row();

		//set the browser segments to early parse order variables
		$browser_segments = array_map('strtolower', $this->EE->uri->segment_array());

		if(!empty($is_abbreviation->abbreviation))
			unset($browser_segments['1']);

		for( $i = 1; $i<=10; $i++ )
		{
			$this->EE->config->_global_vars['transcribe:segment_'.$i] = FALSE;
		}

		$i = 1;

		foreach($browser_segments as $brow_seg)
		{
			$this->EE->config->_global_vars['transcribe:segment_'.$i] = $brow_seg;
			$i++;
		}

		if(count($browser_segments) > 0)
		{
			$this->EE->config->_global_vars['transcribe:last_segment'] = $brow_seg;
		}

		//set the current lang details.
		if( !empty($is_abbreviation->abbreviation) )
				Cache::set(array('current_lang', $is_abbreviation->abbreviation), $is_abbreviation);


		// checking to see if Transcribe is enabled for this site
		// we might want to move this check to the top of the function eventually.
		$this->_get_transcribe_settings();
		if( empty($this->transcribe_settings->enable_transcribe) ) return FALSE;

		// translate URI segments for site_pages. Structure needs this corrected in order to pull the proper template
		$this->transcribe->_fix_structure_site_pages();

		// set language module wide with _set_current_language call
		if( empty($switching_lang) )
		{
			if( !empty($is_abbreviation->abbreviation) )
			{
				$current_language = $this->transcribe->_set_current_language($is_abbreviation->abbreviation);
			}
			else
			{
				$no_abbr_lang = $this->EE->config->item('transcribe_no_abbr');

				if( !empty($no_abbr_lang) )
				{
					if( is_array($no_abbr_lang) )
					{
						$no_abbr_lang = $no_abbr_lang[$this->EE->config->item('site_short_name')];
					}
						$current_language = $this->transcribe->_set_current_language($no_abbr_lang);
				}
				else
				{
					$current_language = $this->transcribe->_set_current_language();
				}

			}
			$this->EE->config->_global_vars['transcribe:language_abbreviation'] = $current_language['abbreviation'];
			$this->EE->config->_global_vars['transcribe:lang_id'] = $current_language['id'];
			$this->EE->config->_global_vars['transcribe:language_name'] = $current_language['name'];
		}
		else
		{
			// set the language were switching to to be our current language
			$current_language = $this->transcribe->_set_current_language($switching_lang);
		}

		// update url for Structure
		if( $structure_exists = $this->EE->db->table_exists('structure') )
		{
			$remove_trailing_slash = $this->EE->db->select('var_value')->from('structure_settings')->where('var', 'add_trailing_slash')->where('site_id', $this->site_id)->get()->row();

			$site_pages = $this->EE->config->item('site_pages');

			if( !empty($this->transcribe_settings->force_prefix) )
			{
				if( $this->transcribe_settings->force_prefix == 1 || ($this->transcribe_settings->force_prefix == 2 && !empty($current_language['force_prefix'])) )
				{

					$site_pages[$this->site_id]['url'] = $this->EE->uri->config->config['site_url'].'/'.$this->EE->config->config['site_index'];

					$site_pages[$this->site_id]['url'] = $this->transcribe->reduce_slashes($site_pages[$this->site_id]['url']);
				}
			}

			// removing all pages items for other languages here.
			$site_pages_entry_ids = array_keys($site_pages[$this->site_id]['uris']);

			$site_pages_entry_languages = $this->transcribe->_get_language($site_pages_entry_ids);

			// are we switching languages
			if( empty($switching_lang) )
			{
				foreach($site_pages_entry_languages as $entry)
				{
					if( $entry['language_id']!= $current_language['id'] )
					{
						unset($site_pages[$this->site_id]['uris'][$entry['entry_id']]);
						unset($site_pages[$this->site_id]['templates'][$entry['entry_id']]);
						continue;
					}
				}

				$site_pages = $this->_get_related_structure_url($site_pages);
				$this->EE->config->set_item('site_pages', $site_pages);

			}
			else
			{
				// were switching languages
				// pull a list of all the languages in the system with posts.
				$sql = array();
				$sql[] = "SELECT *";
				$sql[] = "FROM " . $this->EE->db->dbprefix('transcribe_languages');
				$sql[] = "WHERE (SELECT COUNT(*) FROM " . $this->EE->db->dbprefix('transcribe_entries_languages') . " WHERE language_id = " . $this->EE->db->dbprefix('transcribe_languages') . ".id) > 0";
				$languages = $this->EE->db->query(implode(' ', $sql))->result_array();

				// loop through langauges and update the whole pages tree here shoudl break this out into a function soon
				foreach($languages as $row)
				{
					$site_pages = $this->EE->config->item('site_pages');

					// following foreach is from above... might want to make it a function
					// go through he pages array and make it only have the ones for the langauge were switching to.
					foreach($site_pages_entry_languages as $entry)
					{
						if( $entry['language_id']!= $row['id'] )
						{
							unset($site_pages[$this->site_id]['uris'][$entry['entry_id']]);
							unset($site_pages[$this->site_id]['templates'][$entry['entry_id']]);
							continue;
						}
					}

					$pages = $this->_get_related_structure_url($site_pages, $row['abbreviation']);

					//reset site_pages
					$site_pages = $this->EE->config->item('site_pages');

					foreach($pages[$this->site_id]['uris'] as $key => $uri_string)
					{
						$site_pages[$this->site_id]['uris'][$key] = $uri_string;
					}

					// set the updated tree back to the site_pages array with the language data updated for this langauge.
					$this->EE->config->set_item('site_pages', $site_pages);
				}
			}// end change langauge here.
		}

		if( !empty($is_abbreviation) ) array_shift($segments);

		// set global vars for parent
		$this->_set_structure_vars($segments);

		// check to see if it's in the site_pages array (structure)
		$site_pages = $this->EE->config->item('site_pages');


		if(!empty($remove_trailing_slash->var_value) && $remove_trailing_slash->var_value == 'n')
			$needle = '/'.implode('/', $segments);
		else
			$needle = '/'.implode('/', $segments).'/';


		if( !empty($site_pages) AND in_array($needle, $site_pages[$this->site_id]['uris']) )
		{
			// removing the injected segment.
			$this->EE->uri->uri_string = (empty($segments) ? '' : '/' . implode('/', $segments));

			$this->EE->uri->segments = array();
			$this->EE->uri->rsegments = array();
			$this->EE->uri->_explode_segments();
			$this->EE->uri->_reindex_segments();

			return FALSE;
		}

		// check if a template exists for segment_1/segment_2
		if( !empty($segments) AND !empty($segments[1]) )
		{
			$route = $this->transcribe->_template_for_route( implode('/', array($segments[0], $segments[1])) );

			if( !empty($route) )
				$segments = array_slice($segments, 2);
		}

		// check if a template exists for segment_1
		if( empty($route) AND !empty($segments) )
		{
			$route = $this->transcribe->_template_for_route($segments[0]);

			if( !empty($route) )
				$segments = array_slice($segments, 1);
		}

		// check if a template exists for blank route (structure)
		$structure_installed = $this->EE->db->query('SHOW TABLES LIKE "%structure%"');
		$structure_installed = $structure_installed->num_rows();
		if( empty($route) && ( $structure_installed = 0) )
		{
			$route = $this->transcribe->_template_for_route('');
		}

		// now if the transcribe segments is turned on lets go ahead and do a check for that segment facade
		$transcribe_uri_enabled = $this->EE->config->item('transcribe_uri_facade');

		if( !empty($transcribe_uri_enabled) && !empty($segments) )
		{
			// facade is turned on lets translate the segments.
			foreach($segments as $key => $segment)
			{
				$new_uri = $this->EE->db->select('ct.url_title')
							->from('transcribe_uris as tu')
							->join('channel_titles as ct', 'ct.entry_id = tu.entry_id')
							->join('transcribe_entries_languages as el', 'el.entry_id = tu.entry_id')
							->where('tu.uri', $segment)
							->where('el.language_id', $current_language['id'])
							->get();

				if( $new_uri->num_rows() == 1 )
				{
					// we have a facade
					$last = end(array_keys($segments));
					$segments[$key] = $new_uri->row('url_title');
				}
			}

		}

		$this->EE->uri->uri_string = $route . (empty($segments) ? '' : '/' . implode('/', $segments));

		$this->EE->uri->segments = array();
		$this->EE->uri->rsegments = array();
		$this->EE->uri->_explode_segments();
		$this->EE->uri->_reindex_segments();
	}

	// STRUCTURE HOOK FUNCTIONS
	public function transcribe_structure_index_view_data( $data )
	{
		// checking to see if Transcribe is enabled for this site
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $data;

		// get translations
		$sql = array();
		$sql[] = "SELECT *";
		$sql[] = "FROM " . $this->EE->db->dbprefix('transcribe_languages');
		$sql[] = "WHERE (SELECT COUNT(*) FROM " . $this->EE->db->dbprefix('transcribe_entries_languages') . " WHERE language_id = " . $this->EE->db->dbprefix('transcribe_languages') . ".id) > 0";
		$languages = $this->EE->db->query(implode(' ', $sql))->result();

		// loop over each language
		foreach($languages as $row)
		{
			$language_id = $row->id;
			$language_name = $row->name;

			// create a tag for each language
			$data['tabs']['transcribe-'.$language_id] = $language_name;

			if( !empty($data['data']['page-ui']) )
			{
				foreach($data['data']['page-ui'] as $key => $entry)
				{
					// assign the elements to each associated language
					if( !empty($entry['language_id']) )
						if( $entry['language_id'] == $language_id )
							$data['data']['transcribe-'.$language_id][$key] = $entry;
				}
			}
		}

		unset($data['tabs']['page-ui']);

		// cleanup languages without entries in them so they don't display in Structure.
		foreach($data['tabs'] as $tab_key => $language)
		{
			if(empty($data['data'][$tab_key]))
			{
				unset($data['data'][$tab_key]);
				unset($data['tabs'][$tab_key]);
			}
		}

		return $data;
	}

	public function transcribe_structure_get_data_end( $data )
	{
		//checking to see if Transcribe is enabled for thie site
		$settings = $this->transcribe->_get_settings();

		if( empty($settings->enable_transcribe) ) return $data;

		// get only entry_id's
		$entry_ids = array();
		foreach($data as $row) $entry_ids[] = $row['entry_id'];

		if( !empty($entry_ids) )
		{
			$result = $this->EE->db->select('entry_id, language_id')->where_in('entry_id', $entry_ids)->get('transcribe_entries_languages')->result();

			if( !empty($result) )
			{
				foreach($result as $row)
					$data[$row->entry_id]['language_id'] = $row->language_id;

				foreach($data as $row)
				{
					if( empty($row['language_id']) && !empty($row['entry_id']) )
						unset($data[$row['entry_id']]);

					// if entry is a listing, make the associated entry also a listing (if associated)
					if( !empty($row['listing_cid']) && !empty($row['entry_id']) )
					{
						// find related entries
						$related_entries = $this->EE->db->select('tel2.entry_id, tel2.language_id')
							->from('transcribe_entries_languages as tel')
							->join('transcribe_entries_languages as tel2', 'tel2.relationship_id = tel.relationship_id', 'inner')
							->where('tel.entry_id', $row['entry_id'])
							->where('tel2.entry_id !=', $row['entry_id'])
							->get()->result();

						foreach($related_entries as $entry)
							$data[$entry->entry_id]['listing_cid'] = $row['listing_cid'];
					}
				}
			}
		}

		return $data;
	}

	public function transcribe_structure_get_selective_data_results( $results )
	{
		if (REQ == 'CP') return $results;
		//checking to see if Transcribe is enabled for thie site
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $results;

		// get current language
		$language = $this->transcribe->_set_current_language();

		// get only entry_id's
		$entry_ids = array();
		foreach($results as $row) $entry_ids[] = $row['entry_id'];

		if( !empty($entry_ids) )
		{
			$result = $this->EE->db->select('entry_id, language_id')->where_in('entry_id', $entry_ids)->where('language_id', $language['id'])->get('transcribe_entries_languages')->result();

			$result_entry_ids = array();
			foreach($result as $row) $result_entry_ids[] = $row->entry_id;

			if( !empty($result) )
			{
				foreach($results as $key => $row)
				{
					if( $key != 0 AND !in_array($row['entry_id'], $result_entry_ids) )
						unset($results[$key]);
				}
			}
		}

		return $results;
	}

	/**
	 * Gets current branch data and set's some of the Structure global vars
	 * @param bool $is_abbreviation flags if first segment is a lang abbreviation
	 * @param array $segments current URL segments
	 */
	public function _set_structure_vars($segments)
	{
		$data = $this->transcribe->get_branch_data($segments);

		if( !empty($data) )
		{
			// parent page global vars
			$count = count($data);

			// if data is set we'll go ahead and assign it
			if(!empty($data[$count-2]))
			{
				$this->EE->config->_global_vars['transcribe:parent:entry_id'] = $data[$count-2]['entry_id'];
				$this->EE->config->_global_vars['transcribe:parent:title'] = $data[$count-2]['title'];
				$this->EE->config->_global_vars['transcribe:parent:uri'] = '/'.implode('/', array_slice($segments, 0, $count-1));
				$this->EE->config->_global_vars['transcribe:parent:slug'] = $segments[$count-2];
			}
		}
	}


	//*********************************
	//** Allow dups function will return true if we can allow this url to be a duplicate
	//*********************************
	public function transcribe_structure_allow_dupes($uri)
	{
		// return true if this url hasn't been used in this language yet.
		// we get passed in the uri for the current entry

		$return = TRUE;
		$site_pages = $this->EE->config->item('site_pages');
		$lang_id = $this->EE->input->post('transcribe__transcribe_language');


		// removing all pages items for other languages here.
		$site_pages_entry_ids = array_keys($site_pages[$this->site_id]['uris']);

		$site_pages_entry_languages = $this->transcribe->_get_language($site_pages_entry_ids);

		if( !empty($lang_id) )
		{
			foreach($site_pages_entry_languages as $entry)
			{
				if( $entry['language_id']!= $lang_id )
				{
					unset($site_pages[$this->site_id]['uris'][$entry['entry_id']]);
					unset($site_pages[$this->site_id]['templates'][$entry['entry_id']]);
					continue;
				}
			}

		}

		// we need to trim the uri to make sure it's a match
		$uri = ltrim($uri, "/");
		$uri = rtrim($uri, "/");

		// check the uri to see if we already have it in this langauge
		// if we do, we'll go ahead and return false
		// otherwise we'll return true
		foreach($site_pages[$this->site_id]['uris'] as $key => $pages_uri)
		{
			// trim slashes to make sure we have a match.
			$pages_uri = ltrim($pages_uri, "/");
			$pages_uri = rtrim($pages_uri, "/");

			if($pages_uri == $uri)
			{
				if($key != $this->EE->input->get_post('entry_id'))
					$return = FALSE;
			}
		}

		return $return;
	}


	public function transcribe_matrix_data_query($object, $params, $sql, $select_mode = FALSE)
	{
		if (REQ == 'CP') return $this->EE->db->query($sql);

		//checking to see if Transcribe is enabled for thie site
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $this->EE->db->query($sql);

		// remove all whitspace and new lines
		$sql = preg_replace('/\s\s+/', ' ', $sql);

		$changes = $this->EE->session->cache('transcribe', 'field_changes');

		//grab matrix changes from last call
		$matrix_changes = $this->EE->session->cache('transcribe', 'matrix_col_changes');

		if(!empty($changes))
		{
			foreach($changes as $change)
			{

				foreach($change as $orignal_field_id => $new_field_id)
				{
					if( $orignal_field_id == $object->field_id )
					{
						$object->field_id = $new_field_id;
						// loop through tha matrix fields for our current site
						foreach( $object->cache['fields'][$this->site_id] as $field)
						{

							if( $orignal_field_id == $field['field_id'] )
							{
								// get the col_ids to replace
								// we already have the field ids to replace from our session var
								$col_ids_to_change[$orignal_field_id] = $field['field_settings']['col_ids'];
							}

							if( $new_field_id == $field['field_id'])
							{
								// now were going to get the new col_ids
								$col_ids_to_use[$orignal_field_id] = $field['field_settings']['col_ids'];
								$old_field_id_to_use = $orignal_field_id;
								$new_field_id_to_use = $new_field_id;


								// modify the query.
								// we'll need to go ahead and modify the query to grab the data from the other matrix
								$sql = str_replace('field_id = '.$old_field_id_to_use, 'field_id = '.$new_field_id_to_use, $sql);
								$object->field_id = $new_field_id_to_use;

								// order gratest to least
								arsort($col_ids_to_change[$old_field_id_to_use]);

								// assign changes to arrays... will be asigned to a cache var later
								foreach($col_ids_to_change as $id => $col_changes)
									$matrix_changes['col_ids_to_change'][$id] = $col_changes;

								foreach($col_ids_to_use as $id => $col_changes)
									$matrix_changes['col_ids_to_use'][$id] = $col_changes;

								$matrix_changes['fields'][$new_field_id_to_use] = $old_field_id_to_use;

								foreach($col_ids_to_change[$old_field_id_to_use] as $col_id => $replace_id)
								{
									// the following code is left in and commented out for debugging if need be.

//									$sql_before = $sql;
//									echo $sql_before;

									$sql = preg_replace("/\scol_id_$replace_id(\s|,)/",' col_id_'.$col_ids_to_use[$old_field_id_to_use][$col_id].' as col_id_'.$replace_id.'$1', $sql);


//										$sql = str_replace(' col_id_'.$replace_id, ' col_id_'.$col_ids_to_use[$old_field_id_to_use][$col_id].' as col_id_'.$replace_id, $sql);
//										echo "SQL BEFORE: $sql_before";
//										echo "\n";
//										echo 'SEARCH: col_id_'.$replace_id.',';
//										echo "\n";
//										echo 'REPLACE: col_id_'.$col_ids_to_use[$old_field_id_to_use][$col_id].' as col_id_'.$replace_id;
//										echo "\n";
//										echo "SQL AFTER: $sql";
//										echo "\n\n\n\n\n\n\n";
								}
							}
						}
					}
				}
			}
		}

		// asign matrix col changes to cache
		if(!empty($matrix_changes))
			$this->EE->session->set_cache('transcribe', 'matrix_col_changes', $matrix_changes);

		return $this->EE->db->query($sql);
	}

	public function _get_add_in_langs()
	{
		$add_langs = FALSE;
		// if we have more then one langauge enabled... We'll grab it here.
		$add_langs = $this->EE->TMPL->fetch_param('transcribe_add_lang');

		if(!empty($add_langs))
		{
			// turn this into an array
			$add_langs = explode('|', $add_langs);
		}


		return $add_langs;
	}

	public function _get_all_languages($id = false)
	{
		$return = FALSE;
		// transcribe_add_lang
		$add_langs = $this->EE->TMPL->fetch_param('transcribe_add_lang');

		// turn langauges into an array of elements
		if(!empty($add_langs))
		{
			$all_languages = Cache::get(array('all_languages'));

			if(empty($all_languages))
			{
				// get all languages from the db.
				$all_languages = $this->EE->db->get('transcribe_languages');
				$all_languages = $all_languages->result();

				// put these in the format we need later
				foreach($all_languages as $lang_data)
				{
					$formatted_all_langs[$lang_data->abbreviation] = $lang_data;
				}

				$all_languages = $formatted_all_langs;
				Cache::set(array('all_languages'), $all_languages);
			}

			// do we need to reformat?
			if(!empty($id))
			{
				foreach($all_languages as $lang_data)
				{
					$formatted_all_langs[$lang_data->id] = $lang_data;
				}

				$all_languages = $formatted_all_langs;
			}

			$return = $all_languages;
		}

		return $return;
		// end more then one language enabled function
	}

	public function transcribe_playa_fetch_rels_query($object, $sql, $data = array())
	{

		if (REQ == 'CP') return $this->EE->db->query($sql);

		//checking to see if Transcribe is enabled for thie site
		$settings = $this->transcribe->_get_settings();
		if( empty($settings->enable_transcribe) ) return $this->EE->db->query($sql);

		// get cached changes
		$changes = $this->EE->session->cache('transcribe', 'matrix_col_changes');

		// clearn up the query from the hook
		$sql = preg_replace('/\s\s+/', ' ', $sql);

		if( !empty($data['field_ids']))
		{
			foreach($data['field_ids'] as $id => $field_id)
			{
				if( !empty($changes['fields'][$field_id]) )
				{
					$current_field_id =& $changes['fields'][$field_id];

					foreach($changes['col_ids_to_change'][$current_field_id] as $id => $replace_id)
					{
						// the following code is left in and commented out for debugging if need be.
//						$sql_before = $sql;

						$sql = str_replace('parent_col_id = '.$replace_id.' ', 'parent_col_id = '.$changes['col_ids_to_use'][$current_field_id][$id].' ', $sql);
//						echo "SQL BEFORE: $sql_before";
//						echo "\n";
//						echo 'SEARCH: parent_col_id = "'.$replace_id.'" ';
//						echo "\n";
//						echo 'REPLACE:  parent_col_id = "'.$changes['col_ids_to_use'][$current_field_id][$id].'" ';
//						echo "\n";
//						echo "SQL AFTER: $sql";
//						echo "\n\n\n\n\n\n\n";
					}
				}
			}
		}

		return $this->EE->db->query($sql);
	}


	/**
	 * Removes URL parameters from the url before processing segments
	 */
	private function _remove_params()
	{
		$pattern = '/[\?|\&].*$/';
		preg_match($pattern, $this->EE->uri->uri_string, $matches);
		$this->url_params = (isset($matches[0])) ? $matches[0] : '';
		$this->EE->uri->uri_string = preg_replace($pattern, '', $this->EE->uri->uri_string);
	}

	/**
	 * Restores URL parameters to the url after processing segments
	 */
	private function _restore_params()
	{
		$this->EE->uri->uri_string .= $this->url_params;
	}

	/*
	 * This function is here to restore pages array before safe cracker saves it.
	 */
	public function transcribe_safecracker_submit_entry_end($object)
	{
		if( class_exists('Sql_structure'))
		{
			$this->sql = new Sql_structure();

			$site_pages = $this->EE->config->item('site_pages');

			// get all site pages for thsi site id and set it
			$site_pages[$this->site_id] = $this->sql->get_site_pages(TRUE);

			// set the site pages here
			$this->EE->config->set_item('site_pages', $site_pages);
		}
	}

	public function update_extension( $current='' )
	{
		if( $current == '' OR $current == $this->version )
		{
			return FALSE;
		}

		if( $current < '1.1')
		{
			$hooks['channel_entries_row'] = 'transcribe_channel_entries_row';
		}

		if($current < '1.1.1')
		{
			$hooks['matrix_data_query'] = 'transcribe_matrix_data_query';
			$remove_extension[] = 'transcribe_channel_entries_row';
		}

		if($current < '1.1.1.1')
		{
			$hooks['playa_fetch_rels_query'] = 'transcribe_playa_fetch_rels_query';

		}

		if($current < '1.1.1.2')
		{
			if(version_compare(APP_VER, '2.4.0', '>='))
			{
				$hooks['cp_menu_array'] = 'transcribe_cp_menu_array';
				$hooks['edit_entries_additional_where'] = 'transcribe_edit_entries_additional_where';
			}
		}

		if($current < '1.1.1.3')
		{
			$hooks['structure_allow_dupes'] = 'transcribe_structure_allow_dupes';
		}

		if($current < '1.5.1')
		{
			$hooks['entry_submission_start'] = 'transcribe_submission_start';
		}

		if($current < '1.5.2')
		{
			if(version_compare(APP_VER, '2.6.0', '>='))
			{
				$hooks['safecracker_submit_entry_end'] = 'transcribe_safecracker_submit_entry_end';
			}
			else
			{
				$hooks['channel_form_submit_entry_end'] = 'transcribe_safecracker_submit_entry_end';
			}
		}

		if($current < '1.6')
		{
			// add the hook needed here... We're going to go ahead and remove the old hook in his code if it's not needed anymore.
			$hooks['channel_search_modify_search_query'] = 'transcribe_channel_search_modify_search_query';
		}


		if(!empty($hooks))
		{
			foreach ($hooks as $hook => $ext_method)
			{
				$this->EE->db->insert('extensions', array(
					'class'		=> __CLASS__,
					'method'	=> $ext_method,
					'hook'		=> $hook,
					'settings'	=> serialize($this->settings),
					'priority'	=> 9,
					'version'	=> $this->version,
					'enabled'	=> 'y'
				));
			}
		}

		if(!empty($remove_extension))
		{
			foreach( $remove_extension as $method)
			{
				$this->EE->db->where('method', $method);
				$this->EE->db->delete('extensions');
			}
		}


		$this->EE->db->where('class', __CLASS__);
		$this->EE->db->update('extensions', array('version' => $this->version));
	}

	public function disable_extension()
	{
		$this->EE->db->where('class', __CLASS__);
		$this->EE->db->delete('extensions');
	}

	//this funnction used to rewrite the comment and channel urls for use in the templates
	private function rewrite_channel_and_comment_urls($results, $language_id)
	{
		$force = $this->transcribe->_get_settings();

		$language = $this->EE->db->get_where('transcribe_languages', array('id' => $language_id));
		$language = $language->row_array();
		if( !empty($force->force_prefix))
		{
			if( $force->force_prefix == 1 || ($force->force_prefix == 2 && !empty($language['force_prefix'])) )
			{
				foreach( $results as $key => $row)
				{
					$site_url = $this->EE->config->item('site_url');

					// channel_url
					$results[$key]['channel_url'] = str_replace($site_url, $site_url.$language['abbreviation'].'/', $results[$key]['channel_url']);
//					$results[$key]['channel_url'] = $this->EE->functions->remove_double_slashes($results[$key]['channel_url']);

					$results[$key]['channel_url'] = $this->transcribe->reduce_slashes($results[$key]['channel_url']);

					// comment_url
					$results[$key]['comment_url'] = str_replace($site_url, $site_url.$language['abbreviation'].'/', $results[$key]['comment_url']);
//					$results[$key]['comment_url'] = $this->EE->functions->remove_double_slashes($results[$key]['channel_url']);

					$results[$key]['comment_url'] = $this->transcribe->reduce_slashes($results[$key]['channel_url']);

					// search_results_url
					if( !empty($results[$key]['search_results_url']) )
					{
						$results[$key]['search_results_url'] = str_replace($site_url, $site_url.$language['abbreviation'].'/', $results[$key]['search_results_url']);
//						$results[$key]['search_results_url'] = $this->EE->functions->remove_double_slashes($results[$key]['search_results_url']);

						$results[$key]['search_results_url'] = $this->transcribe->reduce_slashes($results[$key]['search_results_url']);
					}
				}
			}
		}

		return $results;
	}


	/*
	 * This function takes the current listing parent url and if it's not in the current language it will go ahead and
	 * grab the coorosponding URL for the listing in the current language.
	 */
	private function _get_related_structure_url($site_pages, $force_lang = FALSE)
	{
		if(empty($force_lang))
		{
			$language = $this->transcribe->_set_current_language();
		}
		else
		{
			$language = $this->transcribe->_set_current_language($force_lang);
		}

		$lang_abbr = $language['abbreviation'];
		$language_id = $language['id'];

		// do we have file level caching for this one?
		$file_cache_site_pages = $this->EE->config->item('transcribe_file_cache_site_pages');

		if(!empty($file_cache_site_pages))
		{
			$modified_site_data = $this->read_cache('site_pages_urls_updated'.$language_id);
		}


		if(!empty($modified_site_data))
		{
			$age = time() - $modified_site_data['stored_time'];
			// is it younger then 15 min?
			if($age < 900)
			{
				return $modified_site_data['site_pages'];
			}
		}

		$listing_data = $this->EE->db->select('*')
									->where('site_id', $this->site_id)->get('structure_listings');

		$listing_data = $listing_data->result_array();

		$site_pages_orignal = $this->EE->config->item('site_pages');

		// getting relationship ids in 2 foreach loops so we have a lighter query
		foreach($listing_data as $listing)
		{
			$ids[] = $listing['entry_id'];
			$ids[] = $listing['parent_id'];
		}

		// get more ids and set the language abbreviation segment to /
		foreach($site_pages[$this->site_id]['uris'] as $key => $string)
		{
			$ids[] = $key;
			if( $string == '/'.$lang_abbr )
				$site_pages[$this->site_id]['uris'][$key] = '/';
		}

		if(!empty($ids))
		{
			$ids = array_unique($ids);
			$ids = implode(',', $ids);
			$this->EE->db->select('entry_id, relationship_id, language_id');
			$this->EE->db->where_in($ids);
			$relationships = $this->EE->db->get('transcribe_entries_languages');
			$relationships = $relationships->result_array();

			//setting relationship data
			foreach($relationships as $relationship)
				$rel_data[$relationship['entry_id']] = $relationship;

			// get the current parent id
			foreach($listing_data as $listing)
			{
				foreach($relationships as $rel)
				{
					if( $rel['entry_id'] == $listing['parent_id'] && empty($x) )
					{
						// we now have the current parent id... but this doesn't mean that the entry is the correct langage
						$current_parent['entry_id'] = $listing['parent_id'];
						$current_parent['rel'] = $rel['relationship_id'];
						break;
					}
				}

				if( !empty($current_parent) )
				{
					// loop through relationships again and grab the entry_ids that we need to check for
					foreach($relationships as $rel)
					{
						// get the entry ids we need here
						if( $rel['relationship_id'] == $current_parent['rel'])
						{
							//we have a match is it in our current language?
							if( !empty($site_pages[$this->site_id]['uris'][$rel['entry_id']]) )
							{
								//this is the segemnt we want to replace with
								$replace_with[$rel['entry_id']]['rel'] = $rel['relationship_id'];
								$replace_with[$rel['entry_id']]['uri'] = $site_pages[$this->site_id]['uris'][$rel['entry_id']];
								break;
							}
						}
					}
				}
			}

			if(!empty($replace_with))
			{
				foreach($replace_with as $listing_parent)
				{
					// clear this array from previous iterations
					// commented out due to issues it presented for others... left in on purpose
		          $segments_to_replace = array();

					// get the segemnts we need to replace
					foreach($relationships as $rel)
					{
						if( $rel['relationship_id'] == $listing_parent['rel'] )
						{
							if(!empty($site_pages_orignal[$this->site_id]['uris'][$rel['entry_id']]))
							{
								if(!in_array($site_pages_orignal[$this->site_id]['uris'][$rel['entry_id']], $segments_to_replace))
								{
									$segments_to_replace[$rel['entry_id']] = $site_pages_orignal[$this->site_id]['uris'][$rel['entry_id']];
								}

							}

						}
					}

					foreach($listing_data as $listing)
					{
						// is the listing in our current language?
						if(!empty($site_pages[$this->site_id]['uris'][$listing['entry_id']]))
						{
							//if so lets go ahead and get rid of the segments to replace
							foreach($segments_to_replace as $replace_entry_id => $replace_string)
							{
								//check to make sure it's not in our current language
								if( empty($site_pages[$this->site_id]['uris'][$replace_entry_id] ) && $replace_string != '/' )
								{
									// is this a listing on the home page?
									if($listing_parent['uri'] == '/')
										$site_pages[$this->site_id]['uris'][$listing['entry_id']] = str_replace($replace_string, '', $site_pages[$this->site_id]['uris'][$listing['entry_id']]);
									else
										$site_pages[$this->site_id]['uris'][$listing['entry_id']] = str_replace($replace_string, $listing_parent['uri'], $site_pages[$this->site_id]['uris'][$listing['entry_id']]);
								}
							}
						}
					}
				}
			}
		}

		if(!empty($file_cache_site_pages))
		{
			// calulating this can be really taxing to User experience... so let's cache it if caching it is enabled in the config.
			$store['site_pages'] = $site_pages;
			$store['stored_time'] = time();

			$this->write_cache('site_pages_urls_updated'.$language_id, $store);
		}


		return $site_pages;
	}


	// this function based on CI DB caching function... modified for use in Transcribe
	function write_cache($name, $object)
	{
		$this->EE->load->helper('file');
		if ( ! $this->check_cache_path())
		{
			return FALSE;
		}

		$dir_path = $cache_path = APPPATH.'cache/transcribe/';

		$filename = md5($name);

		if ( ! @is_dir($dir_path))
		{
			if ( ! @mkdir($dir_path, DIR_WRITE_MODE))
			{
				return FALSE;
			}

			@chmod($dir_path, DIR_WRITE_MODE);
		}

		if (write_file($dir_path.$filename, serialize($object)) === FALSE)
		{
			return FALSE;
		}

		@chmod($dir_path.$filename, FILE_WRITE_MODE);
		return TRUE;
	}

	// this function based on CI DB caching function... modified for Transcribe
	function check_cache_path()
	{
		$path = APPPATH.'cache/';

		// Add a trailing slash to the path if needed
		$path = preg_replace("/(.+?)\/*$/", "\\1/",  $path);

		if ( ! is_dir($path) OR ! is_really_writable($path))
		{
			// If the path is wrong we'll turn off caching
			return FALSE;
		}

		return TRUE;
	}

	// this function based on CI DB cache... modified for use with Transcribe

	function read_cache($name)
	{
		$this->EE->load->helper('file');

		if ( ! $this->check_cache_path())
		{
			return FALSE;
		}

		// $filepath = $this->db->cachedir.$segment_one.'+'.$segment_two.'/'.md5($name);
		$filepath = APPPATH.'cache/transcribe/'.md5($name);

		if (FALSE === ($cachedata = read_file($filepath)))
		{
			return FALSE;
		}

		return unserialize($cachedata);
	}

	private function _get_transcribe_settings()
	{
		$this->transcribe_settings = $this->transcribe->_get_settings();
	}



	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# Hooks for Adding "Filter by Language" in Content Edit Screen  #
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# 																#
	# Credit where credit is due:									#
	# The basis of this technique was published by Rob Sanchez	 	#
	# in March 2012 - https://github.com/rsanchez/filter_by_author  #
	# 																#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

	/**
	 * Checks for a language ID and retrieves a list of related entry_ids which are added as a where_in clause
	 *
	 * @author Bryan Nielsen
	 * @param array $filter_data the original filter data from the search query
	 * @return array    addtional wheres for the query
	 */
	public function transcribe_edit_entries_additional_where($filter_data)
	{
		$_hook_wheres = $this->EE->extensions->last_call;

		if ($this->EE->input->post('language_id'))
		{
			// Run query and get entry ids that are in requested language id
			// Then add where_in clause with those entry ids
			$query = $this->EE->db->select('entry_id')->get_where('transcribe_entries_languages', array('language_id' => $this->EE->input->post('language_id')));

			if($query->num_rows() > 0) {
				$entry_ids = array();
				foreach($query->result() as $row)
				{
					$entry_ids[] = $row->entry_id;
				}
				$_hook_wheres['entry_id'] = $entry_ids;
			}
		}

		return $_hook_wheres;
	}

	/**
	 * Adds the Filter by language dropdown to the edit entries screen via JS
	 *
	 * @author Bryan Nielsen
	 * @param array $menu the menu array
	 * @return array    the menu array
	 */
	public function transcribe_cp_menu_array($menu)
	{
		if ($this->EE->extensions->last_call !== FALSE)
		{
			$menu = $this->EE->extensions->last_call;
		}

		//confirm we're on the edit entries screen
		if ($this->EE->input->get('C') === 'content_edit' && ! $this->EE->input->get('M') && version_compare(APP_VER, '2.4.0', '>=') )
		{
			$this->EE->load->library('javascript');

			$this->EE->lang->loadfile('transcribe');
			$languages = array('' => lang('transcribe_select_language_default'));

			//get list of available languages
			$query = $this->EE->db->select('id, name')->get('transcribe_languages');

			foreach ($query->result() as $row)
			{
				$languages[$row->id] = $row->name;
			}

			//add the dropdown filter
			if(version_compare(APP_VER, '2.6.0', '>='))
				$json_data = json_encode(NBS.NBS.form_dropdown('language_id', $languages, NULL, 'id="language_id"'));
			else
				$json_data = $this->EE->javascript->generate_json(NBS.NBS.form_dropdown('language_id', $languages, NULL, 'id="language_id"'));

			$this->EE->javascript->output('
				$("form#filterform div.group").append('.$json_data.');
				$("#language_id").on("change", function() {
					$("#search_button").trigger("click");
				});
			');
		}

		return $menu;
	}
}

/* End of File: ext.transcribe.php */
