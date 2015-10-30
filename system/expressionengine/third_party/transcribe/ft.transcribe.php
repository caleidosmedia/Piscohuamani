<?php if( ! defined('BASEPATH')) exit('No direct script access allowed');

class Transcribe_ft extends EE_Fieldtype
{
	public $info = array(
		'name'    => 'Transcribe',
		'version' => '1.5.1'
	);

	public function __construct()
	{
		if(version_compare(APP_VER, '2.9.0', '<'))
		{
			parent::EE_Fieldtype();
		}
		else
		{
			parent::__construct();
		}

		$this->EE->lang->loadfile('transcribe');
	}

	public function display_field( $data )
	{
		// get current avaliable languages
		$languages = $this->EE->db->get('transcribe_languages');
		$languages = $languages->result();

		$selected = '';
		$languages_dropdown = array();

		foreach( $languages as $language )
			$languages_dropdown[$language->id] = $language->name;


		// get current language assigned to an entry
		if( $this->EE->input->get_post('entry_id') )
		{
			$this->EE->db->where('entry_id', $this->EE->input->get_post('entry_id'));
			$selected = $this->EE->db->get('transcribe_entries_languages')->row()->language_id;
		}


		return $this->EE->load->view('publish_field', array('languages_dropdown' => $languages_dropdown, 'selected' => $selected), TRUE);
	}

	public function save( $data )
	{

		$test = $this->EE->input->post('transcribe_language', TRUE);

		if( $this->EE->input->post('transcribe_language', TRUE) )
		{
			// set validation rules
			$this->EE->form_validation->set_rules('transcribe_language', 'transcribe_language', 'required|integer');

			// process submission
			if( $this->EE->form_validation->run() )
			{
				return $this->EE->input->post('transcribe_language', TRUE);
			}
		}


		return FALSE;

	}


	/**
	 * We can access the entry_id here... so we can update our table
	 *
	 * @method post_save
	 * @param  int $data Should be data returned from save function could be FALSE as well
	 * @return none
	 */
	public function post_save($data)
	{
		// do we have a language?
		if($data)
		{
			$relationship = uniqid();

			$entry_data = array(
			'entry_id' => $this->settings['entry_id'],
			'language_id' => $data,
			'relationship_id' => $relationship
			);

			$exists = $this->EE->db->get_where('transcribe_entries_languages', array('entry_id' => $params['entry_id']), 1);
			$exists = $exists->row();

			if( empty($exists) )
			{
				$this->EE->db->insert('transcribe_entries_languages', $entry_data);
			}
			else
			{
				$this->EE->db->where('entry_id', $entry_data['entry_id']);
				$this->EE->db->update('transcribe_entries_languages', $entry_data);
			}
		}
	}



	// replacing the channel tags.
	function replace_tag($data, $params = array(), $tagdata = FALSE)
	{
		return $data;
	}
}

/* End of File: ft.transcribe.php */
