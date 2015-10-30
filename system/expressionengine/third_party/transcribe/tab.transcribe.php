<?php if( ! defined('BASEPATH')) exit('No direct script access allowed');

require_once PATH_THIRD . 'transcribe/mod.transcribe.php';

class Transcribe_tab {

	private $EE;

	public function Transcribe_tab()
	{
		$this->EE =& get_instance();
		$this->transcribe = new Transcribe();
	}

	public function publish_tabs( $channel_id, $entry_id='' )
	{
		$settings = array();
		$selected = array();
		$relationship_id = $this->EE->input->get('relationship') ? $this->EE->input->get('relationship') : uniqid();

		$this->EE->lang->loadfile('transcribe');

		// get available languages
		$languages = $this->EE->db->get('transcribe_languages');
		$languages = $languages->result();

		$languages_dropdown = array();

		foreach( $languages as $language )
		{
			$languages_dropdown[$language->id] = $language->name;
		}

		// get language of current entry
		if( !empty($entry_id) )
		{
			$this->EE->db->where('entry_id', $entry_id);
			$entry_language = $this->EE->db->get('transcribe_entries_languages', 1);
			$entry_language = $entry_language->row();

			if( !empty($entry_language) )
			{
				$selected[] = $entry_language->language_id;
				$relationship_id = $entry_language->relationship_id;
			}
		}
		// determine language based on parent_id from structure
		else if( $this->EE->input->get('parent_id') )
		{
			$parent_id = $this->EE->input->get('parent_id');

			$this->EE->db->where('entry_id', $parent_id);
			$entry_language = $this->EE->db->get('transcribe_entries_languages', 1);
			$entry_language = $entry_language->row();

			if( !empty($entry_language) )
			{
				$selected[] = $entry_language->language_id;
			}
		}
		else
		{
			if( $this->EE->input->get('language') )
			{
				$selected[] = $this->EE->input->get('language');
			}
			else
			{
				$language_id = $this->EE->db->get_where('transcribe_settings', array('site_id' => $this->EE->config->config['site_id']), 1)->row('language_id');
				$selected[] = $language_id;
			}
		}

		$this->EE->session->set_cache('transcribe', 'relationship_id', $relationship_id);

		$settings[] = array(
			'field_id' => 'transcribe_language',
			'field_label' => $this->EE->lang->line('transcribe_language_field_label'),
			'field_required' => 'n',
			'field_data' => $selected,
			'field_list_items' => $languages_dropdown,
			'field_fmt' => '',
			'field_instructions' => '',
			'field_show_fmt' => 'n',
			'field_pre_populate' => 'n',
			'field_text_direction' => 'ltr',
			'field_type' => 'select',
			'field_visibility' => 'y',
		);


		// dropdown to edit/create a related entry for a language
		if( !empty($entry_id) )
		{
			$html_output = array();

			// get currently defined relationships
			$relationships = $this->EE->db->get_where('transcribe_entries_languages', array('relationship_id' => $relationship_id));
			$relationships = $relationships->result();

			$existing_translations = array();
			foreach( $relationships as $key => $relationship )
				$existing_translations[$key] = $relationship->language_id;

			$html_output[] = '<ul style="padding:5px 0px 0px 2px;">';
			foreach( $languages as $language )
			{
				// determine entry_id, if any
				$key = array_search($language->id, $existing_translations);
				$entry_id = ($key === FALSE) ? '' : $relationships[$key]->entry_id;

				// generate edit/create link
				$link = array();
				$link[] = BASE.AMP.'C=content_publish'.AMP.'M=entry_form'.AMP.'channel_id='.$channel_id;
				$link[] = (empty($entry_id) ? '' : AMP.'entry_id='.$entry_id);
				$link[] = 'relationship='.$relationship_id;
				$link[] = 'language='.$language->id;
				$link = implode(AMP, $link);

				$html_output[] = '<li style="padding:4px 0px;"><a href="'.$link.'" style="text-decoration:none;">'.$language->name.(empty($entry_id) ? ' (does not exist)' : '').'</a></li>';
			}
			$html_output[] = '</ul>';

			$settings[] = array(
				'field_id' => 'transcribe_related_entries',
				'field_label' => $this->EE->lang->line('transcribe_related_entries_field_label'),
				'field_required' => 'n',
				'field_instructions' => $this->EE->lang->line('transcribe_related_entries_field_instructions'),
				'field_type' => 'text',
				'string_override' => implode('', $html_output),
				'field_visibility' => 'y',
			);
		}
		else
		{
			$settings[] = array(
				'field_id' => 'transcribe_related_entries',
				'field_label' => $this->EE->lang->line('transcribe_related_entries_field_label'),
				'field_required' => 'n',
				'field_instructions' => $this->EE->lang->line('transcribe_related_entries_field_instructions'),
				'field_type' => 'text',
				'string_override' => '',
				'field_visibility' => 'y',
			);
		}

		//Relate existing entries here only if it's not being related from another entry
		// only show options for the same channel

		$entry_relationship = $this->EE->input->get('relationship', TRUE);
		$entry_langauge = $this->EE->input->get('language', TRUE);

		if( empty($entry_relationship) && empty($entry_langauge) )
		{
			$relate_entries = array();
			$entries = $this->EE->db
				->select('ct.title, te.entry_id, tl.abbreviation, te.relationship_id')
				->from('transcribe_entries_languages AS te')
				->join('channel_titles AS ct', 'ct.entry_id = te.entry_id')
				->join('transcribe_languages AS tl', 'tl.id = te.language_id')
				->where('ct.channel_id ', $this->EE->input->get('channel_id', TRUE))
				->order_by('ct.title')
				->limit(1000)
				->get();

			$relations['none'] = $this->EE->lang->line('transcribe_none');

			if( empty($entry_id) )
				$entry_id = $this->EE->input->get('entry_id', TRUE);

			foreach($entries->result() as $row)
					if($row->entry_id != $entry_id)
						$relations[$row->entry_id.'__'.$row->relationship_id] = $row->title;

			$settings[] = array(
				'field_id' => 'transcribe_relate_entry',
				'field_label' => $this->EE->lang->line('transcribe_relate_entry'),
				'field_required' => 'n',
				'field_data' => '',
				'field_list_items' => $relations,
				'field_fmt' => '',
				'field_instructions' => '',
				'field_show_fmt' => 'n',
				'field_pre_populate' => 'n',
				'field_text_direction' => 'ltr',
				'field_type' => 'select',
				'field_visibility' => 'y',
			);
		}

		// check the config to see if we have Transcribe URI enabled

		$transcribe_uri_enabled = $this->EE->config->item('transcribe_uri_facade');

		if( !empty($transcribe_uri_enabled) )
		{
			$uri = '';
			if( empty($entry_id) )
				$entry_id = $this->EE->input->get('entry_id', TRUE);
			if( !empty($entry_id) )
			{
				$query = $this->EE->db->select('uri')
										->from('transcribe_uris')
										->where('entry_id', $entry_id)->get();
				if( $query->num_rows() == 1 )
					$uri = $query->row('uri');

			}

			$settings[] = array(
				'field_id' => 'transcribe_uri',
				'field_label' => $this->EE->lang->line('transcribe_uri'),
				'field_required' => 'n',
				'field_data' => $uri,
				'field_list_items' => '',
				'field_fmt' => '',
				'field_instructions' => '',
				'field_show_fmt' => 'n',
				'field_pre_populate' => 'n',
				'field_text_direction' => 'ltr',
				'field_type' => 'text',
				'field_visibility' => 'y',
				'field_maxl' => 100,
			);
		}

		return $settings;
	}

	public function validate_publish( $params )
	{
		// if all is good we return FALSE
		$errors = FALSE;

		if(!empty($params[0]['transcribe_relate_entry']))
		{
			$data = array(
				'language_id' => $params[0]['transcribe_language'],
				'transcribe_relate_entry' => $params[0]['transcribe_relate_entry'],
			);

			$channel_id = $this->EE->input->get('channel_id', TRUE);

			if( $data['transcribe_relate_entry'] !='none' && !empty($data['language_id']) )
			{
				$id_rel = explode('__', $data['transcribe_relate_entry']);

				$entries = $this->EE->db
					->select('te.entry_id, te.language_id, te.relationship_id')
					->from('transcribe_entries_languages AS te')
					->join('channel_titles AS ct', 'ct.entry_id = te.entry_id')
					->where('te.relationship_id ', $id_rel['1'])
					->get();

				foreach($entries->result() as $row)
				{
					if($row->language_id == $data['language_id'])
					{
						$link = array();
						$link[] = BASE.AMP.'C=content_publish'.AMP.'M=entry_form'.AMP.'channel_id='.$channel_id;
						$link[] = (empty($row->entry_id) ? '' : AMP.'entry_id='.$row->entry_id);
						$link[] = 'relationship='.$row->relationship_id;
						$link[] = 'language='.$row->language_id;
						$link = implode(AMP, $link);

						$entry_exists = lang('transcribe_entry_exists_for_lang');
						$entry_exists .= ' <a href="'.$link.'">'.lang('transcribe_view_entry').'</a>';

						$errors = array($entry_exists => 'transcribe_relate_entry');
					}
				}
			}
		}

		return $errors;
	}

	public function publish_data_db( $params )
	{
		// please note we have the following 2 params being passed in
		// $params['mod_data']['transcribe_related_entries]
		// $params['mod_data']['transcribe_relate_entries]
		// the 'transcribe_relate_entries' is the one used to actually relate an entry to existing entries.

		$data = array(
			'entry_id' => $params['entry_id'],
			'language_id' => $params['mod_data']['transcribe_language'],
			'relationship_id' => $this->EE->session->cache['transcribe']['relationship_id'],
		);

		if( !empty($params['mod_data']['transcribe_relate_entry']) )
		{
			$transcribe_relate_entry = $params['mod_data']['transcribe_relate_entry'];

			//checking if we are relating the entry to a new set of entrie(s)
			//transcribe_relate_entry

			if( $transcribe_relate_entry !='none' && !empty($data['language_id']) )
			{
				$id_rel = explode('__', $transcribe_relate_entry);
				$data['relationship_id'] = $id_rel['1'];
			}
		}

		// determine if we are updating or inserting data
		$exists = $this->EE->db->get_where('transcribe_entries_languages', array('entry_id' => $params['entry_id']), 1);
		$exists = $exists->row();

		if( empty($exists) )
		{
			$this->EE->db->insert('transcribe_entries_languages', $data);
		}
		else
		{
			$this->EE->db->where('entry_id', $params['entry_id']);
			$this->EE->db->update('transcribe_entries_languages', $data);
		}

		// next we need to check all of the children entries to see if they are in a different language... if Structure is installed
		// this allows us to keep branches nested properly

		if( isset($this->EE->api_channel_entries->data['revision_post']['structure__parent_id']) )
		{
			$site_id = $this->EE->config->item('site_id');
			$this->structure_sql = new Sql_structure();

			if( empty($this->EE->TMPL))
			{
				// if its not definde we'll load the template library since Structure get_selective_data needs is
				require APPPATH.'libraries/Template.php';

				$this->EE->TMPL = new EE_Template();
			}

			// have to set this param so Structure returns all resutls
			$this->EE->TMPL->tagparams['override_hidden_state'] = 'yes';

			// get_selective_data in structure sql file.. will return array of all children, grand children, great grand children etc.
			$pages = $this->structure_sql->get_selective_data($site_id, $params['entry_id'], $params['entry_id'], 'sub', 99, 99, 'not big_old_random_status_5_pound_bass', array(), array(), FALSE, FALSE, 'no', 'no'); // Get parent and all children

			if( is_array($pages) && !empty($pages) )
			{
				foreach($pages as $page)
					$entry_ids[] = $page['entry_id'];

				$entry_languages = $this->transcribe->_get_language($entry_ids);

				foreach($entry_languages as $entry)
				{
					if( $entry['language_id'] != $this->EE->api_channel_entries->data['revision_post']['transcribe__transcribe_language'])
					{
						$entry['language_id'] = $this->EE->api_channel_entries->data['revision_post']['transcribe__transcribe_language'];
						$this->EE->db->reconnect();
						$this->EE->db->where('entry_id', $entry['entry_id']);
						$this->EE->db->update('transcribe_entries_languages', $entry);
					}
				}
			}
		}

		// is Transcribe uri enabled turned on?
		$transcribe_uri_enabled = $this->EE->config->item('transcribe_uri_facade');

		if( !empty($transcribe_uri_enabled) )
		{
			// is a Transcribe URI defined?
			if( !empty($params['mod_data']['transcribe_uri']) )
			{
				// check to see if we have an entry for this entry id already
				$uri_exists = $this->EE->db->get_where('transcribe_uris', array('entry_id' => $params['entry_id']), 1);
				$uri_exists = $uri_exists->row();

				// if so we'll go ahead and add it to the db.
				$uri_data['entry_id'] = $params['entry_id'];
				$uri_data['uri'] = $params['mod_data']['transcribe_uri'];

				if( empty($uri_exists) )
				{
					$this->EE->db->insert('transcribe_uris', $uri_data);
				}
				else
				{
					$this->EE->db->where('entry_id', $params['entry_id']);
					$this->EE->db->update('transcribe_uris', $uri_data);
				}
			}
		}
	}

	public function publish_data_delete_db( $params )
	{
		$this->EE->db->where_in('entry_id', $params['entry_ids']);
		$this->EE->db->delete('transcribe_entries_languages');
	}
}

/* End of File: tab.transcribe.php */
