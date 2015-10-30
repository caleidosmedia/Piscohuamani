<?php
echo form_open('C=addons_modules'.AMP.'M=show_module_cp'.AMP.'module=transcribe'.AMP.'method=settings');

$this->table->clear();
$cp_table_template['heading_cell_start'] = '<th style="width:25%">';


$this->table->set_template($cp_table_template);
$this->table->set_heading(array(
	lang('transcribe_col_label_site'),
	lang('transcribe_col_label_default'),
	lang('transcribe_col_use_url_prefix'),
	lang('transcribe_col_enable_for_site'),
));

foreach( $sites as $site )
{
	$this->table->add_row(array(
		$site->site_label,
		form_dropdown('default[' . $site->site_id . ']', $languages_dropdown, (empty($site_defaults[$site->site_id]['lang']) ? NULL : $site_defaults[$site->site_id]['lang'])),
		form_dropdown('force_prefix[' . $site->site_id . ']', $force_prefix_options, (empty($site_defaults[$site->site_id]['force_prefix']) ? NULL : $site_defaults[$site->site_id]['force_prefix'])),
		form_dropdown('enable_transcribe[' . $site->site_id . ']', $enable_transcribe_options, (empty($site_defaults[$site->site_id]['enable_transcribe']) ? NULL : $site_defaults[$site->site_id]['enable_transcribe'])),
	));

}

echo $this->table->generate();

echo form_submit(array( 'name'=>'submit', 'value'=>lang('transcribe_button_submit'), 'class'=>'submit' ));
echo form_close();
