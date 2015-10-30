<?php
echo form_open('C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=transcribe'.AMP.'method=languages');

foreach( $languages as $language )
{
	$this->table->clear();
	$cp_table_template['heading_cell_start'] = '<th style="width:50%">';

	$this->table->set_template($cp_table_template);
	$this->table->set_heading(array(
		lang('transcribe_col_label_param'),
		lang('transcribe_col_label_value'),
	));

	$this->table->add_row(array(
		lang('transcribe_label_language'),
		form_input('language['.$language->id.'][name]', $language->name),
	));

	$this->table->add_row(array(
		lang('transcribe_label_abbreveation'),
		form_input('language['.$language->id.'][abbreviation]', $language->abbreviation),
	));
	
	$this->table->add_row(array(
		lang('transcribe_col_use_url_prefix'),
		form_dropdown('language[' . $language->id . '][force_prefix]', $force_prefix_options, (empty($language->force_prefix) ? NULL : $language->force_prefix)),
	));
	
	$this->table->add_row(array(
		lang('transcribe_language_enabled'),
		form_dropdown('language[' . $language->id . '][enabled]', $enabled_options, (empty($language->enabled) ? NULL : $language->enabled)),
	));
				


	echo $this->table->generate();
}

echo form_submit(array( 'name'=>'submit', 'value'=>lang('transcribe_button_submit'), 'class'=>'submit' ));
echo '<a href="'.$base_url.AMP.'method=create'.'" style="margin-left:4px;">'.lang('transcribe_create_new_language').'</a>';
echo form_close();
