<?php if( ! defined('BASEPATH')) exit('No direct script access allowed');

class Transcribe_mcp {

	private $EE;
	private $base_url;
	private $data = array();

	public function __construct()
	{
		$this->EE =& get_instance();
		$this->base_url = BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=transcribe';
		$this->data['base_url'] = $this->base_url;

		// update breadcrumbs
		$this->EE->cp->set_breadcrumb($this->base_url.AMP.'method=index', $this->EE->lang->line('transcribe_module_name'));

		// setup navigation
		$this->EE->cp->set_right_nav(array(
			'transcribe_nav_home' => $this->base_url.AMP.'method=index',
			'transcribe_nav_templates' => $this->base_url.AMP.'method=templates',
			'transcribe_nav_languages' => $this->base_url.AMP.'method=languages',
			'transcribe_nav_settings' => $this->base_url.AMP.'method=settings',
		));
	}

	public function index()
	{
		// load libraries
		$this->EE->load->library('table');

		if( $this->EE->input->post('translation') )
		{
			$language_id = $this->EE->input->post('language');
			$site_id = $this->EE->input->post('site');
			$postdata = $this->EE->input->post('translation');

			foreach( $postdata as $key => $data )
			{
				// if variable name is blank, skip it
				if( empty($data['variable']['name']) AND empty($data['variable']['select']) ) continue;

				// update variable
				if( empty($data['variable']['id']) )
				{
					if( empty($data['variable']['select']) )
					{
						// variable not exists
						$this->EE->db->insert('transcribe_variables', array('name' => $data['variable']['name']));
						$variable_id = $this->EE->db->insert_id();
					}
					else
					{
						// selected variable through select box
						$variable_id = $data['variable']['select'];
					}
				}
				else
				{
					$this->EE->db->where('id', $data['variable']['id']);
					$this->EE->db->update('transcribe_variables', array('name' => $data['variable']['name']));
				}

				// update translation
				if( empty($data['translation']['id']) )
				{
					// translation not exists
					if( empty($variable_id) && !empty($data['variable']['id']) )
						$variable_id = $data['variable']['id'];

					$this->EE->db->insert('transcribe_translations', array(
						'content' => $data['translation']['content'],
						'variable_id' => $variable_id
					));
					$translation_id = $this->EE->db->insert_id();
				}
				else
				{
					$this->EE->db->where('id', $data['translation']['id']);
					$this->EE->db->update('transcribe_translations', array('content' => $data['translation']['content']));
				}

				// if we have created a new variable, create the variable -> translation link with the language
				if( !empty($variable_id) AND !empty($translation_id) )
				{
					$this->EE->db->insert('transcribe_variables_languages', array(
						'variable_id' => $variable_id,
						'translation_id' => $translation_id,
						'language_id' => $language_id,
						'site_id' => $site_id,
					));
				}
			}

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('transcribe_variables_save_success'));
			$this->EE->functions->redirect($this->base_url.AMP.'method=index'.AMP.'language='.$language_id);
		}

		// get lanugages
		$languages = $this->EE->db->get('transcribe_languages');
		$languages = $languages->result();

		if( empty($languages) ) $this->EE->functions->redirect($this->base_url.AMP.'method=create');

		$languages_dropdown = array($this->EE->lang->line('transcribe_select_language_default'));
		foreach( $languages as $language )
		{
			$languages_dropdown[$language->id] = $language->name;
		}
		$this->data['languages_dropdown'] = $languages_dropdown;

		// get sites
		$sites = $this->EE->db->get('sites');
		$sites = $sites->result();

		$sites_dropdown = array($this->EE->lang->line('transcribe_select_site_default'));
		foreach( $sites as $site )
		{
			$sites_dropdown[$site->site_id] = $site->site_label;
		}
		$this->data['sites_dropdown'] = $sites_dropdown;

		// show first translation by default
		$selected_language_id = $this->EE->input->get('language');
		$selected_language_id = empty($selected_language_id) ? $this->EE->input->get_post('language') : $selected_language_id;
		$selected_language_id = empty($selected_language_id) ? $languages[0]->id : $selected_language_id;
		$this->data['selected_language_id'] = $selected_language_id;

		// limit to current site by default
		$selected_site_id = $this->EE->input->get('site');
		$selected_site_id = empty($selected_site_id) ? $this->EE->input->get_post('site') : $selected_site_id;
		$selected_site_id = empty($selected_site_id) ? $this->EE->config->config['site_id'] : $selected_site_id;
		$this->data['selected_site_id'] = $selected_site_id;

		// get total number of variables for this language to use in pagination
		$this->EE->db->select('transcribe_variables.id AS variable_id');
		$this->EE->db->join('transcribe_variables', 'transcribe_variables.id = transcribe_variables_languages.variable_id');
		$this->EE->db->join('transcribe_translations', 'transcribe_translations.id = transcribe_variables_languages.translation_id');
		$this->EE->db->where('transcribe_variables_languages.language_id', $selected_language_id);
		$this->EE->db->where('transcribe_variables_languages.site_id', $selected_site_id);

		$this->EE->load->library('pagination');
		$config = array();
		$config['base_url'] = $this->base_url.AMP.'method=index';

		if( $this->EE->input->get_post('language') )
			$config['base_url'] .= AMP.'language='.$this->EE->input->get_post("language");

		if( $this->EE->input->get_post('site') )
			$config['base_url'] .= AMP.'site='.$this->EE->input->get_post("site");

		$config['page_query_string'] = TRUE;
		$config['total_rows'] = $this->EE->db->get('transcribe_variables_languages')->num_rows();

		$config['per_page'] = 50;

		$this->EE->pagination->initialize($config);

		$this->data['pagination'] = $this->EE->pagination->create_links();

		// get current pagination page
		$current_page = $this->EE->input->get('per_page', 1);

		// get language variables and translations
		$this->EE->db->select('transcribe_variables.id AS variable_id, transcribe_variables.name');
		$this->EE->db->select('transcribe_translations.id AS translation_id, transcribe_translations.content');
		$this->EE->db->join('transcribe_variables', 'transcribe_variables.id = transcribe_variables_languages.variable_id');
		$this->EE->db->join('transcribe_translations', 'transcribe_translations.id = transcribe_variables_languages.translation_id');
		$this->EE->db->where('transcribe_variables_languages.language_id', $selected_language_id);
		$this->EE->db->where('transcribe_variables_languages.site_id', $selected_site_id);
		$this->EE->db->order_by('transcribe_variables.name');

		$selected_language_variables = $this->EE->db->get('transcribe_variables_languages', $config['per_page'], $current_page);
		$selected_language_variables = $selected_language_variables->result();

		$this->data['selected_language_variables'] = $selected_language_variables;

		// get unused variables for dropdown
		$this->EE->db->select('transcribe_variables.*');
		$this->EE->db->join('transcribe_variables_languages', 'transcribe_variables_languages.variable_id = transcribe_variables.id AND '.$this->EE->db->dbprefix('transcribe_variables_languages').'.language_id = '.$selected_language_id.' AND '.$this->EE->db->dbprefix('transcribe_variables_languages').'.site_id = '.$selected_site_id, 'LEFT');
		$this->EE->db->where('transcribe_variables_languages.id IS NULL');
		$this->EE->db->group_by('transcribe_variables.id');
		$this->EE->db->order_by('transcribe_variables.name');
		$unused_variables = $this->EE->db->get('transcribe_variables');
		$unused_variables = $unused_variables->result();

		$unused_variables_dropdown = array('Textfield:');
		foreach( $unused_variables as $variable )
		{
			$unused_variables_dropdown[$variable->id] = $variable->name;
		}
		$this->data['unused_variables_dropdown'] = $unused_variables_dropdown;

		$this->EE->cp->add_js_script(array('ui' => array('core', 'position', 'widget')));

		// Set page title
		if(version_compare(APP_VER, '2.6.0', '<'))
		{
			$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('transcribe_page_title_index'));
		}
		else
		{
			$this->EE->view->cp_page_title = $this->EE->lang->line('transcribe_page_title_index');
		}

		return $this->EE->load->view('index', $this->data, TRUE);
	}

	public function templates()
	{
		// load libraries
		$this->EE->load->library('table');

		if( $this->EE->input->post('templates') )
		{
			$language_id = $this->EE->input->post('language');
			$site_id = $this->EE->input->post('site');
			$postdata = $this->EE->input->post('templates');

			// update group translation
			$this->EE->db->where(array(
				'language_id' => $language_id,
				'site_id' => $site_id,
			));
			$this->EE->db->delete('transcribe_template_groups_languages');

			$groups_batch = array();
			foreach( $postdata['groups'] as $group ) {
				if( !empty($group['content']) )
				{
					$groups_batch[] = array(
						'content' => $group['content'],
						'template_group_id' => $group['group_id'],
						'language_id' => $language_id,
						'site_id' => $site_id,
					);
				}
			}
			if( !empty($groups_batch) )
				$this->EE->db->insert_batch('transcribe_template_groups_languages', $groups_batch);

			// update templates translation
			$this->EE->db->where(array(
				'language_id' => $language_id,
				'site_id' => $site_id,
			));
			$this->EE->db->delete('transcribe_templates_languages');

			$templates_batch = array();
			foreach( $postdata['templates'] as $template ) {
				if( !empty($template['content']) )
				{
					$templates_batch[] = array(
						'content' => $template['content'],
						'template_id' => $template['template_id'],
						'language_id' => $language_id,
						'site_id' => $site_id,
					);
				}
			}
			if( !empty($templates_batch) )
				$this->EE->db->insert_batch('transcribe_templates_languages', $templates_batch);

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('transcribe_templates_save_success'));
			$this->EE->functions->redirect($this->base_url.AMP.'method=templates'.AMP.'language='.$language_id);
		}

		// get lanugages
		$languages = $this->EE->db->get('transcribe_languages');
		$languages = $languages->result();

		if( empty($languages) ) $this->EE->functions->redirect($this->base_url.AMP.'method=create');

		$languages_dropdown = array($this->EE->lang->line('transcribe_select_language_default'));
		foreach( $languages as $language )
		{
			$languages_dropdown[$language->id] = $language->name;
		}
		$this->data['languages_dropdown'] = $languages_dropdown;

		// get sites
		$sites = $this->EE->db->get('sites');
		$sites = $sites->result();

		$sites_dropdown = array($this->EE->lang->line('transcribe_select_site_default'));
		foreach( $sites as $site )
		{
			$sites_dropdown[$site->site_id] = $site->site_label;
		}
		$this->data['sites_dropdown'] = $sites_dropdown;

		// show first translation by default
		$selected_language_id = $this->EE->input->get('language');
		$selected_language_id = empty($selected_language_id) ? $this->EE->input->post('language') : $selected_language_id;
		$selected_language_id = empty($selected_language_id) ? $languages[0]->id : $selected_language_id;
		$this->data['selected_language_id'] = $selected_language_id;

		// limit to current site by default
		$selected_site_id = $this->EE->input->get('site');
		$selected_site_id = empty($selected_site_id) ? $this->EE->input->post('site') : $selected_site_id;
		$selected_site_id = empty($selected_site_id) ? $this->EE->config->config['site_id'] : $selected_site_id;
		$this->data['selected_site_id'] = $selected_site_id;

		// get template groups
		$this->EE->db->select('template_groups.group_id, template_groups.group_name, transcribe_template_groups_languages.content, transcribe_template_groups_languages.language_id');
		$this->EE->db->where('template_groups.site_id', $selected_site_id);
		$this->EE->db->join('transcribe_template_groups_languages', 'transcribe_template_groups_languages.template_group_id = template_groups.group_id AND '.$this->EE->db->dbprefix('transcribe_template_groups_languages').'.language_id = '.$selected_language_id, 'LEFT');
		$template_groups = $this->EE->db->get('template_groups');
		$template_groups = $template_groups->result();
		$this->data['template_groups'] = $template_groups;

		// get template groups
		$this->EE->db->select('templates.template_id, templates.group_id, templates.template_name, transcribe_templates_languages.content, transcribe_templates_languages.language_id');
		$this->EE->db->where('templates.site_id', $selected_site_id);
		$this->EE->db->join('transcribe_templates_languages', 'transcribe_templates_languages.template_id = templates.template_id AND '.$this->EE->db->dbprefix('transcribe_templates_languages').'.language_id = '.$selected_language_id, 'LEFT');
		$templates = $this->EE->db->get('templates');
		$templates = $templates->result();
		$this->data['templates'] = $templates;

		// Set page title

		if(version_compare(APP_VER, '2.6.0', '<'))
		{
			$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('transcribe_page_title_templates'));
		}
		else
		{
			$this->EE->view->cp_page_title = $this->EE->lang->line('transcribe_page_title_templates');
		}

		return $this->EE->load->view('templates', $this->data, TRUE);
	}

	public function languages()
	{
		if( $this->EE->input->post('submit') )
		{
			$languages = $this->EE->input->post('language');

			foreach( $languages as $key => $language )
			{
				$this->EE->db->where('id', $key);
				$this->EE->db->update('transcribe_languages', array(
					'name' => $language['name'],
					'abbreviation' => $language['abbreviation'],
					'force_prefix' => $language['force_prefix'],
					'enabled' => $language['enabled']
				));
			}

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('transcribe_languages_save_success'));
			$this->EE->functions->redirect($this->base_url.AMP.'method=languages');
		}

		// get lanugages
		$languages = $this->EE->db->get('transcribe_languages');
		$languages = $languages->result();

		$yes_no_options = array('0' => $this->EE->lang->line('transcribe_select_no'), '1' => $this->EE->lang->line('transcribe_select_yes'));

		$this->data['force_prefix_options'] = $yes_no_options;
		$this->data['enabled_options'] = $yes_no_options;

		if( empty($languages) ) $this->EE->functions->redirect($this->base_url.AMP.'method=create');

		$this->data['languages'] = $languages;

		// load libraries
		$this->EE->load->library('table');

		// Set page title
		if(version_compare(APP_VER, '2.6.0', '<'))
		{
			$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('transcribe_page_title_languages'));
		}
		else
		{
			$this->EE->view->cp_page_title = $this->EE->lang->line('transcribe_page_title_languages');
		}

		return $this->EE->load->view('languages', $this->data, TRUE);
	}

	public function create()
	{
		// load libraries
		$this->EE->load->library('form_validation');
		$this->EE->load->library('table');

		// setup validation
		$this->EE->form_validation->set_rules('language', 'language', 'required');
		$this->EE->form_validation->set_rules('abbreviation', 'abbreviation', 'required');

		if( $this->EE->input->post('submit') )
		{
			if( $this->EE->form_validation->run() )
			{
				// get langauge count
				$language_count = $this->EE->db->count_all_results('transcribe_languages');

				$language_name = $this->EE->input->post('language');
				$abbreviation = $this->EE->input->post('abbreviation');
				$assign_entries = $this->EE->input->post('assign_entries');

				$this->EE->db->insert('transcribe_languages', array('name' => $language_name, 'abbreviation' => $abbreviation));
				$language_id = $this->EE->db->insert_id();

				if( $assign_entries == 'yes' )
				{
					$this->EE->db->select('entry_id');
					$entries = $this->EE->db->get_where('channel_titles', array('site_id' => $this->EE->config->config['site_id']));
					$entries = $entries->result();

					foreach( $entries as $entry )
					{
						$this->EE->db->insert('transcribe_entries_languages', array(
							'entry_id' => $entry->entry_id,
							'language_id' => $language_id,
							'relationship_id' => uniqid(),
						));
					}
				}

				$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('transcribe_language_create_success'));
				if( empty($language_count) )
					$this->EE->functions->redirect($this->base_url.AMP.'method=settings');
				else
					$this->EE->functions->redirect($this->base_url.AMP.'method=index'.AMP.'language='.$language_id);
			}
			else
			{
				$this->EE->session->set_flashdata('message_failure', validation_errors());
				$this->EE->functions->redirect($this->base_url.AMP.'method=create');
			}
		}

		$language_count = $this->EE->db->count_all_results('transcribe_languages');
		$this->data['have_languages'] = empty($language_count) ? FALSE : TRUE;

		// Set page title
		if(version_compare(APP_VER, '2.6.0', '<'))
		{
			$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('transcribe_page_title_create'));
		}
		else
		{
			$this->EE->view->cp_page_title = $this->EE->lang->line('transcribe_page_title_create');
		}

		return $this->EE->load->view('create', $this->data, TRUE);
	}

	public function settings()
	{
		if( $this->EE->input->post('submit') )
		{
			$settings = $this->EE->input->post('default');
			$force_prefix = $this->EE->input->post('force_prefix', TRUE);
			$enable_transcribe = $this->EE->input->post('enable_transcribe', TRUE);

			foreach( $settings as $site_id => $language_id )
			{
				// does setting exist?
				$exists = $this->EE->db->get_where('transcribe_settings', array('site_id' => $site_id), 1);
				$exists = $exists->row();

				if( empty($exists) )
				{
					$this->EE->db->insert('transcribe_settings', array(
						'site_id' => $site_id,
						'language_id' => $language_id,
						'force_prefix'=> $force_prefix[$site_id],
						'enable_transcribe'=> $enable_transcribe[$site_id],
					));
				}
				else
				{
					$this->EE->db->where('id', $exists->id);
					$this->EE->db->update('transcribe_settings', array(
						'site_id' => $site_id,
						'language_id' => $language_id,
						'force_prefix'=> $force_prefix[$site_id],
						'enable_transcribe'=> $enable_transcribe[$site_id],
					));
				}
			}

			$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('transcribe_settings_save_success'));
			$this->EE->functions->redirect($this->base_url.AMP.'method=settings');
		}

		// load libraries
		$this->EE->load->library('table');

		// get available sites
		$sites = $this->EE->db->get('sites');
		$sites = $sites->result();
		$this->data['sites'] = $sites;

		// get available languages
		$languages = $this->EE->db->get('transcribe_languages');
		$languages = $languages->result();

		if( empty($languages) ) $this->EE->functions->redirect($this->base_url.AMP.'method=create');

		$languages_dropdown = array('' => $this->EE->lang->line('transcribe_select_none'));
		foreach( $languages as $language )
		{
			$languages_dropdown[$language->id] = $language->name;
		}

		// setting options
		$this->data['languages_dropdown'] = $languages_dropdown;
		$this->data['force_prefix_options'] = array('0' => $this->EE->lang->line('transcribe_select_no'), '1' => $this->EE->lang->line('transcribe_select_yes'), '2' => $this->EE->lang->line('transcribe_per_language'));
		$this->data['enable_transcribe_options'] = array('0' => $this->EE->lang->line('transcribe_select_no'), '1' => $this->EE->lang->line('transcribe_select_yes'));

		// build array of current defaults [site_id] => language_id
		$site_settings = $this->EE->db->get('transcribe_settings');
		$site_settings = $site_settings->result();

		$site_defaults = array();

		foreach( $site_settings as $setting )
		{

			$site_defaults[$setting->site_id]['lang'] = $setting->language_id;
			$site_defaults[$setting->site_id]['force_prefix'] = $setting->force_prefix;
			$site_defaults[$setting->site_id]['enable_transcribe'] = $setting->enable_transcribe;

		}

		$this->data['site_defaults'] = $site_defaults;

		// Set page title
		if(version_compare(APP_VER, '2.6.0', '<'))
		{
			$this->EE->cp->set_variable('cp_page_title', $this->EE->lang->line('transcribe_page_title_settings'));
		}
		else
		{
			$this->EE->view->cp_page_title = $this->EE->lang->line('transcribe_page_title_settings');
		}


		return $this->EE->load->view('settings', $this->data, TRUE);
	}

	public function delete_var_confirm()
	{
		$translation_id = (int)$this->EE->input->get('ID');

		if( !empty($translation_id) )
		{
			$this->EE->db->select('transcribe_variables.id AS variable_id, transcribe_variables.name');
			$this->EE->db->select('transcribe_translations.id AS translation_id, transcribe_translations.content');
			$this->EE->db->join('transcribe_variables', 'transcribe_variables.id = transcribe_variables_languages.variable_id');
			$this->EE->db->join('transcribe_translations', 'transcribe_translations.id = transcribe_variables_languages.translation_id');
			$this->EE->db->where('transcribe_translations.id', $translation_id);
			$this->data['var']  = $this->EE->db->get('transcribe_variables_languages')->row();
			$this->data['delete_link'] = '<a class="submit" href="'.BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=transcribe'.AMP.'method=delete_var'.AMP.'ID='.$translation_id.'">'.lang('delete').'</a>';
			if( ob_get_length() > 0 )
				ob_end_clean();

			print $this->EE->load->view('modal_delete', $this->data, TRUE);
			exit;
		}
	}

	public function delete_var()
	{
		$translation_id = (int)$this->EE->input->get('ID');


		// get the variable id
		$variable_id = $this->EE->db->select('variable_id')
									->where('id', $translation_id)
									->get('transcribe_translations')->row();

		// delete db rows for the translation of this var
		$this->EE->db->delete('transcribe_variables_languages ', array('translation_id' => $translation_id));
		$this->EE->db->delete('transcribe_translations ', array('id' => $translation_id));

		// are there other variables with this id?
		$other_variables = $this->EE->db->select('id')
										->where('variable_id', $variable_id->variable_id)->get('transcribe_translations');

		// if not lets go ahead and delete the variable
		if($other_variables->num_rows() == 0)
			$this->EE->db->delete('transcribe_variables ', array('id' => $variable_id->variable_id));


		$this->EE->session->set_flashdata('message_success', $this->EE->lang->line('var_deleted'));


		$this->EE->functions->redirect(BASE.AMP.'C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=transcribe'.AMP.'method=index');
	}
}

/* End of File: mcp.transcribe.php */
