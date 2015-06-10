-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-06-2015 a las 21:28:35
-- Versión del servidor: 5.6.20
-- Versión de PHP: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `piscohuamani`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_accessories`
--

CREATE TABLE IF NOT EXISTS `exp_accessories` (
`accessory_id` int(10) unsigned NOT NULL,
  `class` varchar(75) NOT NULL DEFAULT '',
  `member_groups` varchar(255) NOT NULL DEFAULT 'all',
  `controllers` text,
  `accessory_version` varchar(12) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_accessories`
--

INSERT INTO `exp_accessories` (`accessory_id`, `class`, `member_groups`, `controllers`, `accessory_version`) VALUES
(1, 'Expressionengine_info_acc', '1|5', 'addons|addons_accessories|addons_extensions|addons_fieldtypes|addons_modules|addons_plugins|admin_content|admin_system|content|content_edit|content_files|content_files_modal|content_publish|design|homepage|members|myaccount|tools|tools_communicate|tools_data|tools_logs|tools_utilities', '1.0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_actions`
--

CREATE TABLE IF NOT EXISTS `exp_actions` (
`action_id` int(4) unsigned NOT NULL,
  `class` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `csrf_exempt` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Volcado de datos para la tabla `exp_actions`
--

INSERT INTO `exp_actions` (`action_id`, `class`, `method`, `csrf_exempt`) VALUES
(1, 'Comment', 'insert_new_comment', 0),
(2, 'Comment_mcp', 'delete_comment_notification', 0),
(3, 'Comment', 'comment_subscribe', 0),
(4, 'Comment', 'edit_comment', 0),
(5, 'Email', 'send_email', 0),
(6, 'Search', 'do_search', 1),
(7, 'Channel', 'submit_entry', 0),
(8, 'Channel', 'filemanager_endpoint', 0),
(9, 'Channel', 'smiley_pop', 0),
(10, 'Channel', 'combo_loader', 0),
(11, 'Member', 'registration_form', 0),
(12, 'Member', 'register_member', 0),
(13, 'Member', 'activate_member', 0),
(14, 'Member', 'member_login', 0),
(15, 'Member', 'member_logout', 0),
(16, 'Member', 'send_reset_token', 0),
(17, 'Member', 'process_reset_password', 0),
(18, 'Member', 'send_member_email', 0),
(19, 'Member', 'update_un_pw', 0),
(20, 'Member', 'member_search', 0),
(21, 'Member', 'member_delete', 0),
(22, 'Rte', 'get_js', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_captcha`
--

CREATE TABLE IF NOT EXISTS `exp_captcha` (
`captcha_id` bigint(13) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `word` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_categories`
--

CREATE TABLE IF NOT EXISTS `exp_categories` (
`cat_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(6) unsigned NOT NULL,
  `parent_id` int(4) unsigned NOT NULL,
  `cat_name` varchar(100) NOT NULL,
  `cat_url_title` varchar(75) NOT NULL,
  `cat_description` text,
  `cat_image` varchar(120) DEFAULT NULL,
  `cat_order` int(4) unsigned NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `exp_categories`
--

INSERT INTO `exp_categories` (`cat_id`, `site_id`, `group_id`, `parent_id`, `cat_name`, `cat_url_title`, `cat_description`, `cat_image`, `cat_order`) VALUES
(1, 1, 1, 0, 'Full Time', 'full_time', '', '', 2),
(2, 1, 1, 0, 'Part Time', 'part_time', '', '', 3),
(3, 1, 1, 0, 'Faculty', 'faculty_stuff_whatever', '', '', 1),
(4, 1, 2, 0, 'Business', 'business', '', '', 1),
(5, 1, 2, 0, 'Local News', 'local_news', '', '', 3),
(6, 1, 2, 0, 'Entretainment', 'entretainment', '', '', 2),
(7, 1, 2, 0, 'Sports', 'sports', '', '', 4),
(8, 1, 2, 7, 'NHL', 'nhl', '', '', 3),
(9, 1, 2, 7, 'NBA', 'nba', '', '', 2),
(10, 1, 2, 7, 'MLB', 'mlb', '', '', 1),
(11, 1, 2, 10, 'Scouting', 'scouting', '', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_category_fields`
--

CREATE TABLE IF NOT EXISTS `exp_category_fields` (
`field_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `field_label` varchar(50) NOT NULL DEFAULT '',
  `field_type` varchar(12) NOT NULL DEFAULT 'text',
  `field_list_items` text NOT NULL,
  `field_maxl` smallint(3) NOT NULL DEFAULT '128',
  `field_ta_rows` tinyint(2) NOT NULL DEFAULT '8',
  `field_default_fmt` varchar(40) NOT NULL DEFAULT 'none',
  `field_show_fmt` char(1) NOT NULL DEFAULT 'y',
  `field_text_direction` char(3) NOT NULL DEFAULT 'ltr',
  `field_required` char(1) NOT NULL DEFAULT 'n',
  `field_order` int(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_category_field_data`
--

CREATE TABLE IF NOT EXISTS `exp_category_field_data` (
  `cat_id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `exp_category_field_data`
--

INSERT INTO `exp_category_field_data` (`cat_id`, `site_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 2),
(5, 1, 2),
(6, 1, 2),
(7, 1, 2),
(8, 1, 2),
(9, 1, 2),
(10, 1, 2),
(11, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_category_groups`
--

CREATE TABLE IF NOT EXISTS `exp_category_groups` (
`group_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  `sort_order` char(1) NOT NULL DEFAULT 'a',
  `exclude_group` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `field_html_formatting` char(4) NOT NULL DEFAULT 'all',
  `can_edit_categories` text,
  `can_delete_categories` text
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_category_groups`
--

INSERT INTO `exp_category_groups` (`group_id`, `site_id`, `group_name`, `sort_order`, `exclude_group`, `field_html_formatting`, `can_edit_categories`, `can_delete_categories`) VALUES
(1, 1, 'Staff', 'a', 0, 'all', '', ''),
(2, 1, 'News', 'a', 0, 'all', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_category_posts`
--

CREATE TABLE IF NOT EXISTS `exp_category_posts` (
  `entry_id` int(10) unsigned NOT NULL,
  `cat_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channels`
--

CREATE TABLE IF NOT EXISTS `exp_channels` (
`channel_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_name` varchar(40) NOT NULL,
  `channel_title` varchar(100) NOT NULL,
  `channel_url` varchar(100) NOT NULL,
  `channel_description` varchar(255) DEFAULT NULL,
  `channel_lang` varchar(12) NOT NULL,
  `total_entries` mediumint(8) NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `cat_group` varchar(255) DEFAULT NULL,
  `status_group` int(4) unsigned DEFAULT NULL,
  `deft_status` varchar(50) NOT NULL DEFAULT 'open',
  `field_group` int(4) unsigned DEFAULT NULL,
  `search_excerpt` int(4) unsigned DEFAULT NULL,
  `deft_category` varchar(60) DEFAULT NULL,
  `deft_comments` char(1) NOT NULL DEFAULT 'y',
  `channel_require_membership` char(1) NOT NULL DEFAULT 'y',
  `channel_max_chars` int(5) unsigned DEFAULT NULL,
  `channel_html_formatting` char(4) NOT NULL DEFAULT 'all',
  `channel_allow_img_urls` char(1) NOT NULL DEFAULT 'y',
  `channel_auto_link_urls` char(1) NOT NULL DEFAULT 'n',
  `channel_notify` char(1) NOT NULL DEFAULT 'n',
  `channel_notify_emails` varchar(255) DEFAULT NULL,
  `comment_url` varchar(80) DEFAULT NULL,
  `comment_system_enabled` char(1) NOT NULL DEFAULT 'y',
  `comment_require_membership` char(1) NOT NULL DEFAULT 'n',
  `comment_use_captcha` char(1) NOT NULL DEFAULT 'n',
  `comment_moderate` char(1) NOT NULL DEFAULT 'n',
  `comment_max_chars` int(5) unsigned DEFAULT '5000',
  `comment_timelock` int(5) unsigned NOT NULL DEFAULT '0',
  `comment_require_email` char(1) NOT NULL DEFAULT 'y',
  `comment_text_formatting` char(5) NOT NULL DEFAULT 'xhtml',
  `comment_html_formatting` char(4) NOT NULL DEFAULT 'safe',
  `comment_allow_img_urls` char(1) NOT NULL DEFAULT 'n',
  `comment_auto_link_urls` char(1) NOT NULL DEFAULT 'y',
  `comment_notify` char(1) NOT NULL DEFAULT 'n',
  `comment_notify_authors` char(1) NOT NULL DEFAULT 'n',
  `comment_notify_emails` varchar(255) DEFAULT NULL,
  `comment_expiration` int(4) unsigned NOT NULL DEFAULT '0',
  `search_results_url` varchar(80) DEFAULT NULL,
  `show_button_cluster` char(1) NOT NULL DEFAULT 'y',
  `rss_url` varchar(80) DEFAULT NULL,
  `enable_versioning` char(1) NOT NULL DEFAULT 'n',
  `max_revisions` smallint(4) unsigned NOT NULL DEFAULT '10',
  `default_entry_title` varchar(100) DEFAULT NULL,
  `url_title_prefix` varchar(80) DEFAULT NULL,
  `live_look_template` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `exp_channels`
--

INSERT INTO `exp_channels` (`channel_id`, `site_id`, `channel_name`, `channel_title`, `channel_url`, `channel_description`, `channel_lang`, `total_entries`, `total_comments`, `last_entry_date`, `last_comment_date`, `cat_group`, `status_group`, `deft_status`, `field_group`, `search_excerpt`, `deft_category`, `deft_comments`, `channel_require_membership`, `channel_max_chars`, `channel_html_formatting`, `channel_allow_img_urls`, `channel_auto_link_urls`, `channel_notify`, `channel_notify_emails`, `comment_url`, `comment_system_enabled`, `comment_require_membership`, `comment_use_captcha`, `comment_moderate`, `comment_max_chars`, `comment_timelock`, `comment_require_email`, `comment_text_formatting`, `comment_html_formatting`, `comment_allow_img_urls`, `comment_auto_link_urls`, `comment_notify`, `comment_notify_authors`, `comment_notify_emails`, `comment_expiration`, `search_results_url`, `show_button_cluster`, `rss_url`, `enable_versioning`, `max_revisions`, `default_entry_title`, `url_title_prefix`, `live_look_template`) VALUES
(1, 1, 'news', 'News', 'http://piscohuamani.dev:8888/index.php', NULL, 'en', 0, 0, 0, 0, '2', 1, 'open', NULL, NULL, NULL, 'y', 'y', NULL, 'all', 'y', 'n', 'n', NULL, NULL, 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', NULL, 0, NULL, 'y', NULL, 'n', 10, '', '', 0),
(2, 1, 'page', 'Page', 'http://piscohuamani.dev:8888/index.php', NULL, 'en', 0, 0, 0, 0, '', 1, 'open', NULL, NULL, NULL, 'y', 'y', NULL, 'all', 'y', 'n', 'n', NULL, NULL, 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', NULL, 0, NULL, 'y', NULL, 'n', 10, '', '', 0),
(4, 1, 'legal_age_advice', 'Legal Age advice', 'http://piscohumanai.dev:8888/', NULL, 'en', 0, 0, 0, 0, '', NULL, 'open', 2, NULL, NULL, 'y', 'y', NULL, 'all', 'y', 'n', 'n', NULL, NULL, 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', NULL, 0, NULL, 'y', NULL, 'n', 10, '', '', 0),
(5, 1, 'home_hero_image', 'Home Hero Image', 'http://piscohumanai.dev:8888/', NULL, 'en', 1, 0, 1433286000, 0, '', NULL, 'open', 3, NULL, NULL, 'y', 'y', NULL, 'all', 'y', 'n', 'n', NULL, NULL, 'y', 'n', 'n', 'n', 5000, 0, 'y', 'xhtml', 'safe', 'n', 'y', 'n', 'n', NULL, 0, NULL, 'y', NULL, 'n', 10, '', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channel_data`
--

CREATE TABLE IF NOT EXISTS `exp_channel_data` (
  `entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `field_id_1` text,
  `field_ft_1` tinytext,
  `field_id_2` int(10) DEFAULT '0',
  `field_dt_2` varchar(50) DEFAULT NULL,
  `field_ft_2` tinytext,
  `field_id_6` text,
  `field_ft_6` tinytext,
  `field_id_7` text,
  `field_ft_7` tinytext,
  `field_id_8` text,
  `field_ft_8` tinytext,
  `field_id_9` text,
  `field_ft_9` tinytext,
  `field_id_10` text,
  `field_ft_10` tinytext,
  `field_id_11` text,
  `field_ft_11` tinytext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `exp_channel_data`
--

INSERT INTO `exp_channel_data` (`entry_id`, `site_id`, `channel_id`, `field_id_1`, `field_ft_1`, `field_id_2`, `field_dt_2`, `field_ft_2`, `field_id_6`, `field_ft_6`, `field_id_7`, `field_ft_7`, `field_id_8`, `field_ft_8`, `field_id_9`, `field_ft_9`, `field_id_10`, `field_ft_10`, `field_id_11`, `field_ft_11`) VALUES
(2, 1, 5, '', NULL, 0, NULL, NULL, '', NULL, '', NULL, '', NULL, '{filedir_1}foto-home.png', 'none', 'MAKING PISCO SINCE 1890', 'none', 'Discover the tradition', 'none');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channel_entries_autosave`
--

CREATE TABLE IF NOT EXISTS `exp_channel_entries_autosave` (
`entry_id` int(10) unsigned NOT NULL,
  `original_entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_topic_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL DEFAULT 'n',
  `view_count_one` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_two` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_three` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_four` int(10) unsigned NOT NULL DEFAULT '0',
  `allow_comments` varchar(1) NOT NULL DEFAULT 'y',
  `sticky` varchar(1) NOT NULL DEFAULT 'n',
  `entry_date` int(10) NOT NULL,
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL DEFAULT '0',
  `comment_expiration_date` int(10) NOT NULL DEFAULT '0',
  `edit_date` bigint(14) DEFAULT NULL,
  `recent_comment_date` int(10) DEFAULT NULL,
  `comment_total` int(4) unsigned NOT NULL DEFAULT '0',
  `entry_data` text
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channel_fields`
--

CREATE TABLE IF NOT EXISTS `exp_channel_fields` (
`field_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `field_name` varchar(32) NOT NULL,
  `field_label` varchar(50) NOT NULL,
  `field_instructions` text,
  `field_type` varchar(50) NOT NULL DEFAULT 'text',
  `field_list_items` text NOT NULL,
  `field_pre_populate` char(1) NOT NULL DEFAULT 'n',
  `field_pre_channel_id` int(6) unsigned DEFAULT NULL,
  `field_pre_field_id` int(6) unsigned DEFAULT NULL,
  `field_ta_rows` tinyint(2) DEFAULT '8',
  `field_maxl` smallint(3) DEFAULT NULL,
  `field_required` char(1) NOT NULL DEFAULT 'n',
  `field_text_direction` char(3) NOT NULL DEFAULT 'ltr',
  `field_search` char(1) NOT NULL DEFAULT 'n',
  `field_is_hidden` char(1) NOT NULL DEFAULT 'n',
  `field_fmt` varchar(40) NOT NULL DEFAULT 'xhtml',
  `field_show_fmt` char(1) NOT NULL DEFAULT 'y',
  `field_order` int(3) unsigned NOT NULL,
  `field_content_type` varchar(20) NOT NULL DEFAULT 'any',
  `field_settings` text
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `exp_channel_fields`
--

INSERT INTO `exp_channel_fields` (`field_id`, `site_id`, `group_id`, `field_name`, `field_label`, `field_instructions`, `field_type`, `field_list_items`, `field_pre_populate`, `field_pre_channel_id`, `field_pre_field_id`, `field_ta_rows`, `field_maxl`, `field_required`, `field_text_direction`, `field_search`, `field_is_hidden`, `field_fmt`, `field_show_fmt`, `field_order`, `field_content_type`, `field_settings`) VALUES
(1, 1, 1, 'name', 'Nombre', 'Ingrese su nombre', 'text', '', '0', 0, 0, 6, 50, 'y', 'ltr', 'y', 'n', 'none', 'n', 1, 'any', 'YTo3OntzOjE4OiJmaWVsZF9jb250ZW50X3R5cGUiO3M6MzoiYWxsIjtzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(2, 1, 1, 'date_of_birth', 'Edad', '', 'date', '', '0', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 2, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(9, 1, 3, 'upload_image', 'Upload Image', '', 'file', '', '0', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 1, 'any', 'YToxMDp7czoxODoiZmllbGRfY29udGVudF90eXBlIjtzOjM6ImFsbCI7czoxOToiYWxsb3dlZF9kaXJlY3RvcmllcyI7czozOiJhbGwiO3M6MTM6InNob3dfZXhpc3RpbmciO3M6MToibiI7czoxMjoibnVtX2V4aXN0aW5nIjtiOjA7czoxODoiZmllbGRfc2hvd19zbWlsZXlzIjtzOjE6Im4iO3M6MTk6ImZpZWxkX3Nob3dfZ2xvc3NhcnkiO3M6MToibiI7czoyMToiZmllbGRfc2hvd19zcGVsbGNoZWNrIjtzOjE6Im4iO3M6MjY6ImZpZWxkX3Nob3dfZm9ybWF0dGluZ19idG5zIjtzOjE6Im4iO3M6MjQ6ImZpZWxkX3Nob3dfZmlsZV9zZWxlY3RvciI7czoxOiJuIjtzOjIwOiJmaWVsZF9zaG93X3dyaXRlbW9kZSI7czoxOiJuIjt9'),
(6, 1, 2, 'en_month', 'en-month', '', 'select', 'January\nFebruary\nMarch\nApril\nMay\nJune\nJuly\nAugust\nSeptember\nOctober\nNovember\nDecember', 'n', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 2, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(7, 1, 2, 'es_month', 'es-month', '', 'select', 'Enero\nFebrero\nMarzo\nAbril\nMayo\nJunio\nJulio\nAgosto\nSetiembre\nOctubre\nNoviembre\nDiciembre', 'n', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 3, 'any', 'YTo2OntzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(8, 1, 2, 'birthday', 'BIRTHDAY', '', 'date_dropdown', '', '0', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'xhtml', 'n', 4, 'any', 'YTo5OntzOjI0OiJkYXRlX2Ryb3Bkb3duX3llYXJfcmFuZ2UiO3M6OToiMTkwMC0yMDIwIjtzOjI1OiJkYXRlX2Ryb3Bkb3duX3Nob3dfcGlja2VyIjtzOjE6IjAiO3M6MjM6ImRhdGVfZHJvcGRvd25fc2hvd190aW1lIjtzOjE6IjAiO3M6MTg6ImZpZWxkX3Nob3dfc21pbGV5cyI7czoxOiJuIjtzOjE5OiJmaWVsZF9zaG93X2dsb3NzYXJ5IjtzOjE6Im4iO3M6MjE6ImZpZWxkX3Nob3dfc3BlbGxjaGVjayI7czoxOiJuIjtzOjI2OiJmaWVsZF9zaG93X2Zvcm1hdHRpbmdfYnRucyI7czoxOiJuIjtzOjI0OiJmaWVsZF9zaG93X2ZpbGVfc2VsZWN0b3IiO3M6MToibiI7czoyMDoiZmllbGRfc2hvd193cml0ZW1vZGUiO3M6MToibiI7fQ=='),
(10, 1, 3, 'hero_text', 'Hero text', '', 'text', '', '0', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 2, 'any', 'YTo3OntzOjE4OiJmaWVsZF9jb250ZW50X3R5cGUiO3M6MzoiYWxsIjtzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30='),
(11, 1, 3, 'sub_hero_text', 'sub hero text', '', 'text', '', '0', 0, 0, 6, 128, 'n', 'ltr', 'n', 'n', 'none', 'n', 3, 'any', 'YTo3OntzOjE4OiJmaWVsZF9jb250ZW50X3R5cGUiO3M6MzoiYWxsIjtzOjE4OiJmaWVsZF9zaG93X3NtaWxleXMiO3M6MToibiI7czoxOToiZmllbGRfc2hvd19nbG9zc2FyeSI7czoxOiJuIjtzOjIxOiJmaWVsZF9zaG93X3NwZWxsY2hlY2siO3M6MToibiI7czoyNjoiZmllbGRfc2hvd19mb3JtYXR0aW5nX2J0bnMiO3M6MToibiI7czoyNDoiZmllbGRfc2hvd19maWxlX3NlbGVjdG9yIjtzOjE6Im4iO3M6MjA6ImZpZWxkX3Nob3dfd3JpdGVtb2RlIjtzOjE6Im4iO30=');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channel_form_settings`
--

CREATE TABLE IF NOT EXISTS `exp_channel_form_settings` (
`channel_form_settings_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '0',
  `channel_id` int(6) unsigned NOT NULL DEFAULT '0',
  `default_status` varchar(50) NOT NULL DEFAULT 'open',
  `require_captcha` char(1) NOT NULL DEFAULT 'n',
  `allow_guest_posts` char(1) NOT NULL DEFAULT 'n',
  `default_author` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `exp_channel_form_settings`
--

INSERT INTO `exp_channel_form_settings` (`channel_form_settings_id`, `site_id`, `channel_id`, `default_status`, `require_captcha`, `allow_guest_posts`, `default_author`) VALUES
(1, 1, 4, '', 'n', 'n', 0),
(2, 1, 1, '', 'n', 'n', 0),
(3, 1, 2, '', 'n', 'n', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channel_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_channel_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `channel_id` int(6) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_channel_titles`
--

CREATE TABLE IF NOT EXISTS `exp_channel_titles` (
`entry_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `forum_topic_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL,
  `url_title` varchar(75) NOT NULL,
  `status` varchar(50) NOT NULL,
  `versioning_enabled` char(1) NOT NULL DEFAULT 'n',
  `view_count_one` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_two` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_three` int(10) unsigned NOT NULL DEFAULT '0',
  `view_count_four` int(10) unsigned NOT NULL DEFAULT '0',
  `allow_comments` varchar(1) NOT NULL DEFAULT 'y',
  `sticky` varchar(1) NOT NULL DEFAULT 'n',
  `entry_date` int(10) NOT NULL,
  `year` char(4) NOT NULL,
  `month` char(2) NOT NULL,
  `day` char(3) NOT NULL,
  `expiration_date` int(10) NOT NULL DEFAULT '0',
  `comment_expiration_date` int(10) NOT NULL DEFAULT '0',
  `edit_date` bigint(14) DEFAULT NULL,
  `recent_comment_date` int(10) DEFAULT NULL,
  `comment_total` int(4) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_channel_titles`
--

INSERT INTO `exp_channel_titles` (`entry_id`, `site_id`, `channel_id`, `author_id`, `forum_topic_id`, `ip_address`, `title`, `url_title`, `status`, `versioning_enabled`, `view_count_one`, `view_count_two`, `view_count_three`, `view_count_four`, `allow_comments`, `sticky`, `entry_date`, `year`, `month`, `day`, `expiration_date`, `comment_expiration_date`, `edit_date`, `recent_comment_date`, `comment_total`) VALUES
(2, 1, 5, 1, NULL, '127.0.0.1', 'hero image', 'hero_image', 'open', 'y', 0, 0, 0, 0, 'y', 'n', 1433286000, '2015', '06', '02', 0, 0, 20150602230248, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_comments`
--

CREATE TABLE IF NOT EXISTS `exp_comments` (
`comment_id` int(10) unsigned NOT NULL,
  `site_id` int(4) DEFAULT '1',
  `entry_id` int(10) unsigned DEFAULT '0',
  `channel_id` int(4) unsigned DEFAULT '1',
  `author_id` int(10) unsigned DEFAULT '0',
  `status` char(1) DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  `url` varchar(75) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `comment_date` int(10) DEFAULT NULL,
  `edit_date` int(10) DEFAULT NULL,
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_comment_subscriptions`
--

CREATE TABLE IF NOT EXISTS `exp_comment_subscriptions` (
`subscription_id` int(10) unsigned NOT NULL,
  `entry_id` int(10) unsigned DEFAULT NULL,
  `member_id` int(10) DEFAULT '0',
  `email` varchar(75) DEFAULT NULL,
  `subscription_date` varchar(10) DEFAULT NULL,
  `notification_sent` char(1) DEFAULT 'n',
  `hash` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_content_types`
--

CREATE TABLE IF NOT EXISTS `exp_content_types` (
`content_type_id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT ''
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_content_types`
--

INSERT INTO `exp_content_types` (`content_type_id`, `name`) VALUES
(1, 'grid'),
(2, 'channel');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_cp_log`
--

CREATE TABLE IF NOT EXISTS `exp_cp_log` (
`id` int(10) NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) unsigned NOT NULL,
  `username` varchar(32) NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `act_date` int(10) NOT NULL,
  `action` varchar(200) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `exp_cp_log`
--

INSERT INTO `exp_cp_log` (`id`, `site_id`, `member_id`, `username`, `ip_address`, `act_date`, `action`) VALUES
(1, 1, 1, 'admin', '::1', 1429833583, 'Logged in'),
(2, 1, 1, 'admin', '::1', 1430240051, 'Logged in'),
(3, 1, 1, 'admin', '::1', 1430242446, 'Logged in'),
(4, 1, 1, 'admin', '::1', 1430250073, 'Logged in'),
(5, 1, 1, 'admin', '::1', 1430250623, 'Field Group Created:&nbsp;User'),
(6, 1, 1, 'admin', '::1', 1430256230, 'Logged in'),
(7, 1, 1, 'admin', '::1', 1430261154, 'Logged in'),
(8, 1, 1, 'admin', '::1', 1430262805, 'Status Group Created:&nbsp;Drafts'),
(9, 1, 1, 'admin', '::1', 1430263052, 'Category Group Created:&nbsp;&nbsp;Staff'),
(10, 1, 1, 'admin', '::1', 1430263071, 'Category Group Created:&nbsp;&nbsp;News'),
(11, 1, 1, 'admin', '::1', 1430264041, 'Channel Created:&nbsp;&nbsp;News'),
(12, 1, 1, 'admin', '::1', 1430264164, 'Channel Created:&nbsp;&nbsp;Page'),
(13, 1, 1, 'admin', '127.0.0.1', 1432748814, 'Logged in'),
(14, 1, 1, 'admin', '127.0.0.1', 1432749459, 'Field Group Created:&nbsp;Legal Age advice'),
(15, 1, 1, 'admin', '127.0.0.1', 1432750737, 'Custom Field Deleted:&nbsp;day'),
(16, 1, 1, 'admin', '127.0.0.1', 1432759413, 'Logged in'),
(17, 1, 1, 'admin', '127.0.0.1', 1432760359, 'Custom Field Deleted:&nbsp;en-month'),
(18, 1, 1, 'admin', '127.0.0.1', 1432762042, 'Channel Created:&nbsp;&nbsp;Legal Age advice'),
(19, 1, 1, 'admin', '127.0.0.1', 1432762649, 'Channel Deleted:&nbsp;&nbsp;Legal Age advice'),
(20, 1, 1, 'admin', '127.0.0.1', 1432762670, 'Custom Field Deleted:&nbsp;day'),
(21, 1, 1, 'admin', '127.0.0.1', 1432762766, 'Channel Created:&nbsp;&nbsp;Legal Age advice'),
(22, 1, 1, 'admin', '127.0.0.1', 1432768566, 'Logged in'),
(23, 1, 1, 'admin', '127.0.0.1', 1432828433, 'Logged in'),
(24, 1, 1, 'admin', '127.0.0.1', 1433176881, 'Logged in'),
(25, 1, 1, 'admin', '127.0.0.1', 1433192068, 'Logged in'),
(26, 1, 1, 'admin', '127.0.0.1', 1433281678, 'Logged in'),
(27, 1, 1, 'admin', '127.0.0.1', 1433282040, 'Field Group Created:&nbsp;Hero Image'),
(28, 1, 1, 'admin', '127.0.0.1', 1433282427, 'Channel Created:&nbsp;&nbsp;Home Hero Image'),
(29, 1, 1, 'admin', '::1', 1433543298, 'Logged in'),
(30, 1, 1, 'admin', '::1', 1433544474, 'Logged in'),
(31, 1, 1, 'admin', '::1', 1433545254, 'Logged in'),
(32, 1, 1, 'admin', '::1', 1433547768, 'Logged in');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_cp_search_index`
--

CREATE TABLE IF NOT EXISTS `exp_cp_search_index` (
`search_id` int(10) unsigned NOT NULL,
  `controller` varchar(20) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `access` varchar(50) DEFAULT NULL,
  `keywords` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_date_dropdown_search`
--

CREATE TABLE IF NOT EXISTS `exp_date_dropdown_search` (
`search_id` int(7) unsigned NOT NULL,
  `entry_id` int(7) unsigned NOT NULL DEFAULT '0',
  `hour` varchar(4) NOT NULL DEFAULT '',
  `minute` varchar(4) NOT NULL DEFAULT '',
  `day` varchar(4) NOT NULL DEFAULT '',
  `month` varchar(4) NOT NULL DEFAULT '',
  `year` varchar(4) NOT NULL DEFAULT '',
  `date` int(10) unsigned NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_date_dropdown_settings`
--

CREATE TABLE IF NOT EXISTS `exp_date_dropdown_settings` (
`settings_id` int(7) unsigned NOT NULL,
  `site_id` int(7) unsigned NOT NULL DEFAULT '0',
  `var` varchar(200) NOT NULL DEFAULT '',
  `value` text NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `exp_date_dropdown_settings`
--

INSERT INTO `exp_date_dropdown_settings` (`settings_id`, `site_id`, `var`, `value`) VALUES
(1, 1, 'license_key', ''),
(2, 1, 'report_date', '1432760903'),
(3, 1, 'report_stats', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_developer_log`
--

CREATE TABLE IF NOT EXISTS `exp_developer_log` (
`log_id` int(10) unsigned NOT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  `viewed` char(1) NOT NULL DEFAULT 'n',
  `description` text,
  `function` varchar(100) DEFAULT NULL,
  `line` int(10) unsigned DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `deprecated_since` varchar(10) DEFAULT NULL,
  `use_instead` varchar(100) DEFAULT NULL,
  `template_id` int(10) unsigned NOT NULL DEFAULT '0',
  `template_name` varchar(100) DEFAULT NULL,
  `template_group` varchar(100) DEFAULT NULL,
  `addon_module` varchar(100) DEFAULT NULL,
  `addon_method` varchar(100) DEFAULT NULL,
  `snippets` text,
  `hash` char(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_email_cache`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache` (
`cache_id` int(6) unsigned NOT NULL,
  `cache_date` int(10) unsigned NOT NULL DEFAULT '0',
  `total_sent` int(6) unsigned NOT NULL,
  `from_name` varchar(70) NOT NULL,
  `from_email` varchar(75) NOT NULL,
  `recipient` text NOT NULL,
  `cc` text NOT NULL,
  `bcc` text NOT NULL,
  `recipient_array` mediumtext NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL,
  `plaintext_alt` mediumtext NOT NULL,
  `mailinglist` char(1) NOT NULL DEFAULT 'n',
  `mailtype` varchar(6) NOT NULL,
  `text_fmt` varchar(40) NOT NULL,
  `wordwrap` char(1) NOT NULL DEFAULT 'y',
  `priority` char(1) NOT NULL DEFAULT '3'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_email_cache_mg`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache_mg` (
  `cache_id` int(6) unsigned NOT NULL,
  `group_id` smallint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_email_cache_ml`
--

CREATE TABLE IF NOT EXISTS `exp_email_cache_ml` (
  `cache_id` int(6) unsigned NOT NULL,
  `list_id` smallint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_email_console_cache`
--

CREATE TABLE IF NOT EXISTS `exp_email_console_cache` (
`cache_id` int(6) unsigned NOT NULL,
  `cache_date` int(10) unsigned NOT NULL DEFAULT '0',
  `member_id` int(10) unsigned NOT NULL,
  `member_name` varchar(50) NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `recipient` varchar(75) NOT NULL,
  `recipient_name` varchar(50) NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_email_tracker`
--

CREATE TABLE IF NOT EXISTS `exp_email_tracker` (
`email_id` int(10) unsigned NOT NULL,
  `email_date` int(10) unsigned NOT NULL DEFAULT '0',
  `sender_ip` varchar(45) NOT NULL,
  `sender_email` varchar(75) NOT NULL,
  `sender_username` varchar(50) NOT NULL,
  `number_recipients` int(4) unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_entry_versioning`
--

CREATE TABLE IF NOT EXISTS `exp_entry_versioning` (
`version_id` int(10) unsigned NOT NULL,
  `entry_id` int(10) unsigned NOT NULL,
  `channel_id` int(4) unsigned NOT NULL,
  `author_id` int(10) unsigned NOT NULL,
  `version_date` int(10) NOT NULL,
  `version_data` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_extensions`
--

CREATE TABLE IF NOT EXISTS `exp_extensions` (
`extension_id` int(10) unsigned NOT NULL,
  `class` varchar(50) NOT NULL DEFAULT '',
  `method` varchar(50) NOT NULL DEFAULT '',
  `hook` varchar(50) NOT NULL DEFAULT '',
  `settings` text NOT NULL,
  `priority` int(2) NOT NULL DEFAULT '10',
  `version` varchar(10) NOT NULL DEFAULT '',
  `enabled` char(1) NOT NULL DEFAULT 'y'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_extensions`
--

INSERT INTO `exp_extensions` (`extension_id`, `class`, `method`, `hook`, `settings`, `priority`, `version`, `enabled`) VALUES
(1, 'Rte_ext', 'myaccount_nav_setup', 'myaccount_nav_setup', '', 10, '1.0.1', 'y'),
(2, 'Rte_ext', 'cp_menu_array', 'cp_menu_array', '', 10, '1.0.1', 'y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_fieldtypes`
--

CREATE TABLE IF NOT EXISTS `exp_fieldtypes` (
`fieldtype_id` int(4) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `version` varchar(12) NOT NULL,
  `settings` text,
  `has_global_settings` char(1) DEFAULT 'n'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `exp_fieldtypes`
--

INSERT INTO `exp_fieldtypes` (`fieldtype_id`, `name`, `version`, `settings`, `has_global_settings`) VALUES
(1, 'select', '1.0', 'YTowOnt9', 'n'),
(2, 'text', '1.0', 'YTowOnt9', 'n'),
(3, 'textarea', '1.0', 'YTowOnt9', 'n'),
(4, 'date', '1.0', 'YTowOnt9', 'n'),
(5, 'file', '1.0', 'YTowOnt9', 'n'),
(6, 'grid', '1.0', 'YTowOnt9', 'n'),
(7, 'multi_select', '1.0', 'YTowOnt9', 'n'),
(8, 'checkboxes', '1.0', 'YTowOnt9', 'n'),
(9, 'radio', '1.0', 'YTowOnt9', 'n'),
(10, 'relationship', '1.0', 'YTowOnt9', 'n'),
(11, 'rte', '1.0', 'YTowOnt9', 'n'),
(12, 'date_dropdown', '1.4.1', 'YTozOntzOjI0OiJkYXRlX2Ryb3Bkb3duX3llYXJfcmFuZ2UiO3M6OToiMTkwMC0yMDIwIjtzOjI1OiJkYXRlX2Ryb3Bkb3duX3Nob3dfcGlja2VyIjtzOjk6IjE5MDAtMjAyMCI7czoyMzoiZGF0ZV9kcm9wZG93bl9zaG93X3RpbWUiO3M6OToiMTkwMC0yMDIwIjt9', 'n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_field_formatting`
--

CREATE TABLE IF NOT EXISTS `exp_field_formatting` (
`formatting_id` int(10) unsigned NOT NULL,
  `field_id` int(10) unsigned NOT NULL,
  `field_fmt` varchar(40) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=45 ;

--
-- Volcado de datos para la tabla `exp_field_formatting`
--

INSERT INTO `exp_field_formatting` (`formatting_id`, `field_id`, `field_fmt`) VALUES
(1, 1, 'none'),
(2, 1, 'br'),
(3, 1, 'markdown'),
(4, 1, 'xhtml'),
(5, 2, 'none'),
(6, 2, 'br'),
(7, 2, 'markdown'),
(8, 2, 'xhtml'),
(36, 9, 'xhtml'),
(35, 9, 'markdown'),
(34, 9, 'br'),
(33, 9, 'none'),
(23, 6, 'markdown'),
(22, 6, 'br'),
(21, 6, 'none'),
(24, 6, 'xhtml'),
(25, 7, 'none'),
(26, 7, 'br'),
(27, 7, 'markdown'),
(28, 7, 'xhtml'),
(29, 8, 'none'),
(30, 8, 'br'),
(31, 8, 'markdown'),
(32, 8, 'xhtml'),
(37, 10, 'none'),
(38, 10, 'br'),
(39, 10, 'markdown'),
(40, 10, 'xhtml'),
(41, 11, 'none'),
(42, 11, 'br'),
(43, 11, 'markdown'),
(44, 11, 'xhtml');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_field_groups`
--

CREATE TABLE IF NOT EXISTS `exp_field_groups` (
`group_id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `exp_field_groups`
--

INSERT INTO `exp_field_groups` (`group_id`, `site_id`, `group_name`) VALUES
(1, 1, 'User'),
(2, 1, 'Legal Age advice'),
(3, 1, 'Hero Image');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_files`
--

CREATE TABLE IF NOT EXISTS `exp_files` (
`file_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned DEFAULT '1',
  `title` varchar(255) DEFAULT NULL,
  `upload_location_id` int(4) unsigned DEFAULT '0',
  `rel_path` varchar(255) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` int(10) DEFAULT '0',
  `description` text,
  `credit` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `uploaded_by_member_id` int(10) unsigned DEFAULT '0',
  `upload_date` int(10) DEFAULT NULL,
  `modified_by_member_id` int(10) unsigned DEFAULT '0',
  `modified_date` int(10) DEFAULT NULL,
  `file_hw_original` varchar(20) NOT NULL DEFAULT ''
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_files`
--

INSERT INTO `exp_files` (`file_id`, `site_id`, `title`, `upload_location_id`, `rel_path`, `mime_type`, `file_name`, `file_size`, `description`, `credit`, `location`, `uploaded_by_member_id`, `upload_date`, `modified_by_member_id`, `modified_date`, `file_hw_original`) VALUES
(1, 1, 'foto-home.png', 2, '/Applications/MAMP/htdocs/Piscohuamani/frontend/app/assets/img/foto-home.png', 'image/png', 'foto-home.png', 1114849, NULL, NULL, NULL, 1, 1433283949, 1, 1433283949, '740 1441'),
(2, 1, 'foto-home.png', 1, '/Applications/MAMP/htdocs/Piscohuamani/app/uploads/foto-home.png', 'image/png', 'foto-home.png', 1114849, NULL, NULL, NULL, 1, 1433286131, 1, 1433286131, '740 1441');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_file_categories`
--

CREATE TABLE IF NOT EXISTS `exp_file_categories` (
  `file_id` int(10) unsigned DEFAULT NULL,
  `cat_id` int(10) unsigned DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT '0',
  `is_cover` char(1) DEFAULT 'n'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_file_dimensions`
--

CREATE TABLE IF NOT EXISTS `exp_file_dimensions` (
`id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `upload_location_id` int(4) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT '',
  `short_name` varchar(255) DEFAULT '',
  `resize_type` varchar(50) DEFAULT '',
  `width` int(10) DEFAULT '0',
  `height` int(10) DEFAULT '0',
  `watermark_id` int(4) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_file_watermarks`
--

CREATE TABLE IF NOT EXISTS `exp_file_watermarks` (
`wm_id` int(4) unsigned NOT NULL,
  `wm_name` varchar(80) DEFAULT NULL,
  `wm_type` varchar(10) DEFAULT 'text',
  `wm_image_path` varchar(100) DEFAULT NULL,
  `wm_test_image_path` varchar(100) DEFAULT NULL,
  `wm_use_font` char(1) DEFAULT 'y',
  `wm_font` varchar(30) DEFAULT NULL,
  `wm_font_size` int(3) unsigned DEFAULT NULL,
  `wm_text` varchar(100) DEFAULT NULL,
  `wm_vrt_alignment` varchar(10) DEFAULT 'top',
  `wm_hor_alignment` varchar(10) DEFAULT 'left',
  `wm_padding` int(3) unsigned DEFAULT NULL,
  `wm_opacity` int(3) unsigned DEFAULT NULL,
  `wm_hor_offset` int(4) unsigned DEFAULT NULL,
  `wm_vrt_offset` int(4) unsigned DEFAULT NULL,
  `wm_x_transp` int(4) DEFAULT NULL,
  `wm_y_transp` int(4) DEFAULT NULL,
  `wm_font_color` varchar(7) DEFAULT NULL,
  `wm_use_drop_shadow` char(1) DEFAULT 'y',
  `wm_shadow_distance` int(3) unsigned DEFAULT NULL,
  `wm_shadow_color` varchar(7) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_global_variables`
--

CREATE TABLE IF NOT EXISTS `exp_global_variables` (
`variable_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `variable_name` varchar(50) NOT NULL,
  `variable_data` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_grid_columns`
--

CREATE TABLE IF NOT EXISTS `exp_grid_columns` (
`col_id` int(10) unsigned NOT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `col_order` int(3) unsigned DEFAULT NULL,
  `col_type` varchar(50) DEFAULT NULL,
  `col_label` varchar(50) DEFAULT NULL,
  `col_name` varchar(32) DEFAULT NULL,
  `col_instructions` text,
  `col_required` char(1) DEFAULT NULL,
  `col_search` char(1) DEFAULT NULL,
  `col_width` int(3) unsigned DEFAULT NULL,
  `col_settings` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_html_buttons`
--

CREATE TABLE IF NOT EXISTS `exp_html_buttons` (
`id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `tag_name` varchar(32) NOT NULL,
  `tag_open` varchar(120) NOT NULL,
  `tag_close` varchar(120) NOT NULL,
  `accesskey` varchar(32) NOT NULL,
  `tag_order` int(3) unsigned NOT NULL,
  `tag_row` char(1) NOT NULL DEFAULT '1',
  `classname` varchar(20) DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `exp_html_buttons`
--

INSERT INTO `exp_html_buttons` (`id`, `site_id`, `member_id`, `tag_name`, `tag_open`, `tag_close`, `accesskey`, `tag_order`, `tag_row`, `classname`) VALUES
(1, 1, 0, 'b', '<strong>', '</strong>', 'b', 1, '1', 'btn_b'),
(2, 1, 0, 'i', '<em>', '</em>', 'i', 2, '1', 'btn_i'),
(3, 1, 0, 'blockquote', '<blockquote>', '</blockquote>', 'q', 3, '1', 'btn_blockquote'),
(4, 1, 0, 'a', '<a href="[![Link:!:http://]!]"(!( title="[![Title]!]")!)>', '</a>', 'a', 4, '1', 'btn_a'),
(5, 1, 0, 'img', '<img src="[![Link:!:http://]!]" alt="[![Alternative text]!]" />', '', '', 5, '1', 'btn_img');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_layout_publish`
--

CREATE TABLE IF NOT EXISTS `exp_layout_publish` (
`layout_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_group` int(4) unsigned NOT NULL DEFAULT '0',
  `channel_id` int(4) unsigned NOT NULL DEFAULT '0',
  `field_layout` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_members`
--

CREATE TABLE IF NOT EXISTS `exp_members` (
`member_id` int(10) unsigned NOT NULL,
  `group_id` smallint(4) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `password` varchar(128) NOT NULL,
  `salt` varchar(128) NOT NULL DEFAULT '',
  `unique_id` varchar(40) NOT NULL,
  `crypt_key` varchar(40) DEFAULT NULL,
  `authcode` varchar(10) DEFAULT NULL,
  `email` varchar(75) NOT NULL,
  `url` varchar(150) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `occupation` varchar(80) DEFAULT NULL,
  `interests` varchar(120) DEFAULT NULL,
  `bday_d` int(2) DEFAULT NULL,
  `bday_m` int(2) DEFAULT NULL,
  `bday_y` int(4) DEFAULT NULL,
  `aol_im` varchar(50) DEFAULT NULL,
  `yahoo_im` varchar(50) DEFAULT NULL,
  `msn_im` varchar(50) DEFAULT NULL,
  `icq` varchar(50) DEFAULT NULL,
  `bio` text,
  `signature` text,
  `avatar_filename` varchar(120) DEFAULT NULL,
  `avatar_width` int(4) unsigned DEFAULT NULL,
  `avatar_height` int(4) unsigned DEFAULT NULL,
  `photo_filename` varchar(120) DEFAULT NULL,
  `photo_width` int(4) unsigned DEFAULT NULL,
  `photo_height` int(4) unsigned DEFAULT NULL,
  `sig_img_filename` varchar(120) DEFAULT NULL,
  `sig_img_width` int(4) unsigned DEFAULT NULL,
  `sig_img_height` int(4) unsigned DEFAULT NULL,
  `ignore_list` text,
  `private_messages` int(4) unsigned NOT NULL DEFAULT '0',
  `accept_messages` char(1) NOT NULL DEFAULT 'y',
  `last_view_bulletins` int(10) NOT NULL DEFAULT '0',
  `last_bulletin_date` int(10) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `join_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_visit` int(10) unsigned NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `total_entries` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `total_forum_topics` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_posts` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_forum_post_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_email_date` int(10) unsigned NOT NULL DEFAULT '0',
  `in_authorlist` char(1) NOT NULL DEFAULT 'n',
  `accept_admin_email` char(1) NOT NULL DEFAULT 'y',
  `accept_user_email` char(1) NOT NULL DEFAULT 'y',
  `notify_by_default` char(1) NOT NULL DEFAULT 'y',
  `notify_of_pm` char(1) NOT NULL DEFAULT 'y',
  `display_avatars` char(1) NOT NULL DEFAULT 'y',
  `display_signatures` char(1) NOT NULL DEFAULT 'y',
  `parse_smileys` char(1) NOT NULL DEFAULT 'y',
  `smart_notifications` char(1) NOT NULL DEFAULT 'y',
  `language` varchar(50) NOT NULL,
  `timezone` varchar(50) NOT NULL,
  `time_format` char(2) NOT NULL DEFAULT '12',
  `date_format` varchar(8) NOT NULL DEFAULT '%n/%j/%y',
  `include_seconds` char(1) NOT NULL DEFAULT 'n',
  `cp_theme` varchar(32) DEFAULT NULL,
  `profile_theme` varchar(32) DEFAULT NULL,
  `forum_theme` varchar(32) DEFAULT NULL,
  `tracker` text,
  `template_size` varchar(2) NOT NULL DEFAULT '28',
  `notepad` text,
  `notepad_size` varchar(2) NOT NULL DEFAULT '18',
  `quick_links` text,
  `quick_tabs` text,
  `show_sidebar` char(1) NOT NULL DEFAULT 'n',
  `pmember_id` int(10) NOT NULL DEFAULT '0',
  `rte_enabled` char(1) NOT NULL DEFAULT 'y',
  `rte_toolset_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_members`
--

INSERT INTO `exp_members` (`member_id`, `group_id`, `username`, `screen_name`, `password`, `salt`, `unique_id`, `crypt_key`, `authcode`, `email`, `url`, `location`, `occupation`, `interests`, `bday_d`, `bday_m`, `bday_y`, `aol_im`, `yahoo_im`, `msn_im`, `icq`, `bio`, `signature`, `avatar_filename`, `avatar_width`, `avatar_height`, `photo_filename`, `photo_width`, `photo_height`, `sig_img_filename`, `sig_img_width`, `sig_img_height`, `ignore_list`, `private_messages`, `accept_messages`, `last_view_bulletins`, `last_bulletin_date`, `ip_address`, `join_date`, `last_visit`, `last_activity`, `total_entries`, `total_comments`, `total_forum_topics`, `total_forum_posts`, `last_entry_date`, `last_comment_date`, `last_forum_post_date`, `last_email_date`, `in_authorlist`, `accept_admin_email`, `accept_user_email`, `notify_by_default`, `notify_of_pm`, `display_avatars`, `display_signatures`, `parse_smileys`, `smart_notifications`, `language`, `timezone`, `time_format`, `date_format`, `include_seconds`, `cp_theme`, `profile_theme`, `forum_theme`, `tracker`, `template_size`, `notepad`, `notepad_size`, `quick_links`, `quick_tabs`, `show_sidebar`, `pmember_id`, `rte_enabled`, `rte_toolset_id`) VALUES
(1, 1, 'admin', 'home', '62c4561df8e7ae45efd793a112e613dd51beaddd86683824f273f3ef60ed0905d81f6cec2cc7a5fd201aacd4882909f636ae526cc11d4577932d8b016477e5b4', '#Am@PS>+Er/J~Na-z,_FP]$VA]/VMS{)A[]iIqscpitBFUwQ&4%JXv`mFG{.4+ZKNJbuQ/&6s?-_WY=WLQ/3MN3r`G/M,s5''9aEmIokU\\w`9]/,dS!dfVfq%BUNI&l*d', 'c14fc8a60a1349b265d2e4c09a7cc4c8ab7618db', '11ac985338bac30814dd68b19620b2d004352cd8', NULL, 'jose.lee@ayuinc.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'y', 0, 0, '::1', 1429833350, 1433288489, 1433547769, 1, 0, 0, 0, 1433286168, 0, 0, 0, 'n', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'english', 'America/Lima', '12', '%n/%j/%y', 'n', NULL, NULL, NULL, NULL, '28', NULL, '18', 'Vista publica|http://piscohuamani.dev:8888/|1', 'View Email Console Log|C=tools_logs&M=view_email_log|1', 'n', 0, 'y', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_member_bulletin_board`
--

CREATE TABLE IF NOT EXISTS `exp_member_bulletin_board` (
`bulletin_id` int(10) unsigned NOT NULL,
  `sender_id` int(10) unsigned NOT NULL,
  `bulletin_group` int(8) unsigned NOT NULL,
  `bulletin_date` int(10) unsigned NOT NULL,
  `hash` varchar(10) NOT NULL DEFAULT '',
  `bulletin_expires` int(10) unsigned NOT NULL DEFAULT '0',
  `bulletin_message` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_member_data`
--

CREATE TABLE IF NOT EXISTS `exp_member_data` (
  `member_id` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `exp_member_data`
--

INSERT INTO `exp_member_data` (`member_id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_member_fields`
--

CREATE TABLE IF NOT EXISTS `exp_member_fields` (
`m_field_id` int(4) unsigned NOT NULL,
  `m_field_name` varchar(32) NOT NULL,
  `m_field_label` varchar(50) NOT NULL,
  `m_field_description` text NOT NULL,
  `m_field_type` varchar(12) NOT NULL DEFAULT 'text',
  `m_field_list_items` text NOT NULL,
  `m_field_ta_rows` tinyint(2) DEFAULT '8',
  `m_field_maxl` smallint(3) NOT NULL,
  `m_field_width` varchar(6) NOT NULL,
  `m_field_search` char(1) NOT NULL DEFAULT 'y',
  `m_field_required` char(1) NOT NULL DEFAULT 'n',
  `m_field_public` char(1) NOT NULL DEFAULT 'y',
  `m_field_reg` char(1) NOT NULL DEFAULT 'n',
  `m_field_cp_reg` char(1) NOT NULL DEFAULT 'n',
  `m_field_fmt` char(5) NOT NULL DEFAULT 'none',
  `m_field_order` int(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_title` varchar(100) NOT NULL,
  `group_description` text NOT NULL,
  `is_locked` char(1) NOT NULL DEFAULT 'y',
  `can_view_offline_system` char(1) NOT NULL DEFAULT 'n',
  `can_view_online_system` char(1) NOT NULL DEFAULT 'y',
  `can_access_cp` char(1) NOT NULL DEFAULT 'y',
  `can_access_content` char(1) NOT NULL DEFAULT 'n',
  `can_access_publish` char(1) NOT NULL DEFAULT 'n',
  `can_access_edit` char(1) NOT NULL DEFAULT 'n',
  `can_access_files` char(1) NOT NULL DEFAULT 'n',
  `can_access_fieldtypes` char(1) NOT NULL DEFAULT 'n',
  `can_access_design` char(1) NOT NULL DEFAULT 'n',
  `can_access_addons` char(1) NOT NULL DEFAULT 'n',
  `can_access_modules` char(1) NOT NULL DEFAULT 'n',
  `can_access_extensions` char(1) NOT NULL DEFAULT 'n',
  `can_access_accessories` char(1) NOT NULL DEFAULT 'n',
  `can_access_plugins` char(1) NOT NULL DEFAULT 'n',
  `can_access_members` char(1) NOT NULL DEFAULT 'n',
  `can_access_admin` char(1) NOT NULL DEFAULT 'n',
  `can_access_sys_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_access_content_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_access_tools` char(1) NOT NULL DEFAULT 'n',
  `can_access_comm` char(1) NOT NULL DEFAULT 'n',
  `can_access_utilities` char(1) NOT NULL DEFAULT 'n',
  `can_access_data` char(1) NOT NULL DEFAULT 'n',
  `can_access_logs` char(1) NOT NULL DEFAULT 'n',
  `can_admin_channels` char(1) NOT NULL DEFAULT 'n',
  `can_admin_upload_prefs` char(1) NOT NULL DEFAULT 'n',
  `can_admin_design` char(1) NOT NULL DEFAULT 'n',
  `can_admin_members` char(1) NOT NULL DEFAULT 'n',
  `can_delete_members` char(1) NOT NULL DEFAULT 'n',
  `can_admin_mbr_groups` char(1) NOT NULL DEFAULT 'n',
  `can_admin_mbr_templates` char(1) NOT NULL DEFAULT 'n',
  `can_ban_users` char(1) NOT NULL DEFAULT 'n',
  `can_admin_modules` char(1) NOT NULL DEFAULT 'n',
  `can_admin_templates` char(1) NOT NULL DEFAULT 'n',
  `can_edit_categories` char(1) NOT NULL DEFAULT 'n',
  `can_delete_categories` char(1) NOT NULL DEFAULT 'n',
  `can_view_other_entries` char(1) NOT NULL DEFAULT 'n',
  `can_edit_other_entries` char(1) NOT NULL DEFAULT 'n',
  `can_assign_post_authors` char(1) NOT NULL DEFAULT 'n',
  `can_delete_self_entries` char(1) NOT NULL DEFAULT 'n',
  `can_delete_all_entries` char(1) NOT NULL DEFAULT 'n',
  `can_view_other_comments` char(1) NOT NULL DEFAULT 'n',
  `can_edit_own_comments` char(1) NOT NULL DEFAULT 'n',
  `can_delete_own_comments` char(1) NOT NULL DEFAULT 'n',
  `can_edit_all_comments` char(1) NOT NULL DEFAULT 'n',
  `can_delete_all_comments` char(1) NOT NULL DEFAULT 'n',
  `can_moderate_comments` char(1) NOT NULL DEFAULT 'n',
  `can_send_email` char(1) NOT NULL DEFAULT 'n',
  `can_send_cached_email` char(1) NOT NULL DEFAULT 'n',
  `can_email_member_groups` char(1) NOT NULL DEFAULT 'n',
  `can_email_mailinglist` char(1) NOT NULL DEFAULT 'n',
  `can_email_from_profile` char(1) NOT NULL DEFAULT 'n',
  `can_view_profiles` char(1) NOT NULL DEFAULT 'n',
  `can_edit_html_buttons` char(1) NOT NULL DEFAULT 'n',
  `can_delete_self` char(1) NOT NULL DEFAULT 'n',
  `mbr_delete_notify_emails` varchar(255) DEFAULT NULL,
  `can_post_comments` char(1) NOT NULL DEFAULT 'n',
  `exclude_from_moderation` char(1) NOT NULL DEFAULT 'n',
  `can_search` char(1) NOT NULL DEFAULT 'n',
  `search_flood_control` mediumint(5) unsigned NOT NULL,
  `can_send_private_messages` char(1) NOT NULL DEFAULT 'n',
  `prv_msg_send_limit` smallint(5) unsigned NOT NULL DEFAULT '20',
  `prv_msg_storage_limit` smallint(5) unsigned NOT NULL DEFAULT '60',
  `can_attach_in_private_messages` char(1) NOT NULL DEFAULT 'n',
  `can_send_bulletins` char(1) NOT NULL DEFAULT 'n',
  `include_in_authorlist` char(1) NOT NULL DEFAULT 'n',
  `include_in_memberlist` char(1) NOT NULL DEFAULT 'y',
  `include_in_mailinglists` char(1) NOT NULL DEFAULT 'y'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `exp_member_groups`
--

INSERT INTO `exp_member_groups` (`group_id`, `site_id`, `group_title`, `group_description`, `is_locked`, `can_view_offline_system`, `can_view_online_system`, `can_access_cp`, `can_access_content`, `can_access_publish`, `can_access_edit`, `can_access_files`, `can_access_fieldtypes`, `can_access_design`, `can_access_addons`, `can_access_modules`, `can_access_extensions`, `can_access_accessories`, `can_access_plugins`, `can_access_members`, `can_access_admin`, `can_access_sys_prefs`, `can_access_content_prefs`, `can_access_tools`, `can_access_comm`, `can_access_utilities`, `can_access_data`, `can_access_logs`, `can_admin_channels`, `can_admin_upload_prefs`, `can_admin_design`, `can_admin_members`, `can_delete_members`, `can_admin_mbr_groups`, `can_admin_mbr_templates`, `can_ban_users`, `can_admin_modules`, `can_admin_templates`, `can_edit_categories`, `can_delete_categories`, `can_view_other_entries`, `can_edit_other_entries`, `can_assign_post_authors`, `can_delete_self_entries`, `can_delete_all_entries`, `can_view_other_comments`, `can_edit_own_comments`, `can_delete_own_comments`, `can_edit_all_comments`, `can_delete_all_comments`, `can_moderate_comments`, `can_send_email`, `can_send_cached_email`, `can_email_member_groups`, `can_email_mailinglist`, `can_email_from_profile`, `can_view_profiles`, `can_edit_html_buttons`, `can_delete_self`, `mbr_delete_notify_emails`, `can_post_comments`, `exclude_from_moderation`, `can_search`, `search_flood_control`, `can_send_private_messages`, `prv_msg_send_limit`, `prv_msg_storage_limit`, `can_attach_in_private_messages`, `can_send_bulletins`, `include_in_authorlist`, `include_in_memberlist`, `include_in_mailinglists`) VALUES
(1, 1, 'Super Admins', '', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', '', 'y', 'y', 'y', 0, 'y', 20, 60, 'y', 'y', 'y', 'y', 'y'),
(2, 1, 'Banned', '', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', '', 'n', 'n', 'n', 60, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(3, 1, 'Guests', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'n', 'n', 'n', 'n', '', 'y', 'n', 'y', 15, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(4, 1, 'Pending', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'n', 'n', 'n', 'n', '', 'y', 'n', 'y', 15, 'n', 20, 60, 'n', 'n', 'n', 'n', 'n'),
(5, 1, 'Members', '', 'y', 'n', 'y', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'n', 'y', 'y', 'y', 'n', '', 'y', 'n', 'y', 10, 'y', 20, 60, 'y', 'n', 'n', 'y', 'y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_member_homepage`
--

CREATE TABLE IF NOT EXISTS `exp_member_homepage` (
  `member_id` int(10) unsigned NOT NULL,
  `recent_entries` char(1) NOT NULL DEFAULT 'l',
  `recent_entries_order` int(3) unsigned NOT NULL DEFAULT '0',
  `recent_comments` char(1) NOT NULL DEFAULT 'l',
  `recent_comments_order` int(3) unsigned NOT NULL DEFAULT '0',
  `recent_members` char(1) NOT NULL DEFAULT 'n',
  `recent_members_order` int(3) unsigned NOT NULL DEFAULT '0',
  `site_statistics` char(1) NOT NULL DEFAULT 'r',
  `site_statistics_order` int(3) unsigned NOT NULL DEFAULT '0',
  `member_search_form` char(1) NOT NULL DEFAULT 'n',
  `member_search_form_order` int(3) unsigned NOT NULL DEFAULT '0',
  `notepad` char(1) NOT NULL DEFAULT 'r',
  `notepad_order` int(3) unsigned NOT NULL DEFAULT '0',
  `bulletin_board` char(1) NOT NULL DEFAULT 'r',
  `bulletin_board_order` int(3) unsigned NOT NULL DEFAULT '0',
  `pmachine_news_feed` char(1) NOT NULL DEFAULT 'n',
  `pmachine_news_feed_order` int(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `exp_member_homepage`
--

INSERT INTO `exp_member_homepage` (`member_id`, `recent_entries`, `recent_entries_order`, `recent_comments`, `recent_comments_order`, `recent_members`, `recent_members_order`, `site_statistics`, `site_statistics_order`, `member_search_form`, `member_search_form_order`, `notepad`, `notepad_order`, `bulletin_board`, `bulletin_board_order`, `pmachine_news_feed`, `pmachine_news_feed_order`) VALUES
(1, 'l', 1, 'l', 2, 'n', 0, 'r', 1, 'n', 0, 'r', 2, 'r', 0, 'l', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_member_search`
--

CREATE TABLE IF NOT EXISTS `exp_member_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `search_date` int(10) unsigned NOT NULL,
  `keywords` varchar(200) NOT NULL,
  `fields` varchar(200) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `total_results` int(8) unsigned NOT NULL,
  `query` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_message_attachments`
--

CREATE TABLE IF NOT EXISTS `exp_message_attachments` (
`attachment_id` int(10) unsigned NOT NULL,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_name` varchar(50) NOT NULL DEFAULT '',
  `attachment_hash` varchar(40) NOT NULL DEFAULT '',
  `attachment_extension` varchar(20) NOT NULL DEFAULT '',
  `attachment_location` varchar(150) NOT NULL DEFAULT '',
  `attachment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_size` int(10) unsigned NOT NULL DEFAULT '0',
  `is_temp` char(1) NOT NULL DEFAULT 'y'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_message_copies`
--

CREATE TABLE IF NOT EXISTS `exp_message_copies` (
`copy_id` int(10) unsigned NOT NULL,
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `recipient_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_received` char(1) NOT NULL DEFAULT 'n',
  `message_read` char(1) NOT NULL DEFAULT 'n',
  `message_time_read` int(10) unsigned NOT NULL DEFAULT '0',
  `attachment_downloaded` char(1) NOT NULL DEFAULT 'n',
  `message_folder` int(10) unsigned NOT NULL DEFAULT '1',
  `message_authcode` varchar(10) NOT NULL DEFAULT '',
  `message_deleted` char(1) NOT NULL DEFAULT 'n',
  `message_status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_message_data`
--

CREATE TABLE IF NOT EXISTS `exp_message_data` (
`message_id` int(10) unsigned NOT NULL,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message_date` int(10) unsigned NOT NULL DEFAULT '0',
  `message_subject` varchar(255) NOT NULL DEFAULT '',
  `message_body` text NOT NULL,
  `message_tracking` char(1) NOT NULL DEFAULT 'y',
  `message_attachments` char(1) NOT NULL DEFAULT 'n',
  `message_recipients` varchar(200) NOT NULL DEFAULT '',
  `message_cc` varchar(200) NOT NULL DEFAULT '',
  `message_hide_cc` char(1) NOT NULL DEFAULT 'n',
  `message_sent_copy` char(1) NOT NULL DEFAULT 'n',
  `total_recipients` int(5) unsigned NOT NULL DEFAULT '0',
  `message_status` varchar(25) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_message_folders`
--

CREATE TABLE IF NOT EXISTS `exp_message_folders` (
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `folder1_name` varchar(50) NOT NULL DEFAULT 'InBox',
  `folder2_name` varchar(50) NOT NULL DEFAULT 'Sent',
  `folder3_name` varchar(50) NOT NULL DEFAULT '',
  `folder4_name` varchar(50) NOT NULL DEFAULT '',
  `folder5_name` varchar(50) NOT NULL DEFAULT '',
  `folder6_name` varchar(50) NOT NULL DEFAULT '',
  `folder7_name` varchar(50) NOT NULL DEFAULT '',
  `folder8_name` varchar(50) NOT NULL DEFAULT '',
  `folder9_name` varchar(50) NOT NULL DEFAULT '',
  `folder10_name` varchar(50) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `exp_message_folders`
--

INSERT INTO `exp_message_folders` (`member_id`, `folder1_name`, `folder2_name`, `folder3_name`, `folder4_name`, `folder5_name`, `folder6_name`, `folder7_name`, `folder8_name`, `folder9_name`, `folder10_name`) VALUES
(1, 'InBox', 'Sent', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_message_listed`
--

CREATE TABLE IF NOT EXISTS `exp_message_listed` (
`listed_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `listed_member` int(10) unsigned NOT NULL DEFAULT '0',
  `listed_description` varchar(100) NOT NULL DEFAULT '',
  `listed_type` varchar(10) NOT NULL DEFAULT 'blocked'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_modules`
--

CREATE TABLE IF NOT EXISTS `exp_modules` (
`module_id` int(4) unsigned NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `module_version` varchar(12) NOT NULL,
  `has_cp_backend` char(1) NOT NULL DEFAULT 'n',
  `has_publish_fields` char(1) NOT NULL DEFAULT 'n'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `exp_modules`
--

INSERT INTO `exp_modules` (`module_id`, `module_name`, `module_version`, `has_cp_backend`, `has_publish_fields`) VALUES
(1, 'Comment', '2.3.2', 'y', 'n'),
(2, 'Email', '2.0', 'n', 'n'),
(3, 'Emoticon', '2.0', 'n', 'n'),
(4, 'Jquery', '1.0', 'n', 'n'),
(5, 'Rss', '2.0', 'n', 'n'),
(6, 'Search', '2.2.2', 'n', 'n'),
(7, 'Channel', '2.0.1', 'n', 'n'),
(8, 'Member', '2.1', 'n', 'n'),
(9, 'Stats', '2.0', 'n', 'n'),
(10, 'Rte', '1.0.1', 'y', 'n'),
(11, 'Date_dropdown', '1.4.1', 'n', 'n'),
(12, 'Multi_language', '2.0.1', 'y', 'n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_module_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_module_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `module_id` mediumint(5) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_multi_language`
--

CREATE TABLE IF NOT EXISTS `exp_multi_language` (
`phrase_id` int(7) unsigned NOT NULL,
  `phrase_index` varchar(200) NOT NULL DEFAULT '',
  `phrase_en` text NOT NULL,
  `phrase_es` text NOT NULL,
  `phrase_it` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_online_users`
--

CREATE TABLE IF NOT EXISTS `exp_online_users` (
`online_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `in_forum` char(1) NOT NULL DEFAULT 'n',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  `anon` char(1) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=47 ;

--
-- Volcado de datos para la tabla `exp_online_users`
--

INSERT INTO `exp_online_users` (`online_id`, `site_id`, `member_id`, `in_forum`, `name`, `ip_address`, `date`, `anon`) VALUES
(30, 1, 1, 'n', 'home', '127.0.0.1', 1433288490, ''),
(32, 1, 1, 'n', 'home', '127.0.0.1', 1433288490, ''),
(31, 1, 1, 'n', 'home', '127.0.0.1', 1433288490, ''),
(44, 1, 0, 'n', '', '127.0.0.1', 1433309433, ''),
(43, 1, 1, 'n', 'home', '127.0.0.1', 1433288490, ''),
(42, 1, 1, 'n', 'home', '127.0.0.1', 1433288490, ''),
(45, 1, 0, 'n', '', '::1', 1433542433, ''),
(46, 1, 0, 'n', '', '::1', 1433964415, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_password_lockout`
--

CREATE TABLE IF NOT EXISTS `exp_password_lockout` (
`lockout_id` int(10) unsigned NOT NULL,
  `login_date` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `username` varchar(50) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `exp_password_lockout`
--

INSERT INTO `exp_password_lockout` (`lockout_id`, `login_date`, `ip_address`, `user_agent`, `username`) VALUES
(1, 1430240048, '::1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36', 'admin'),
(2, 1430240050, '::1', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36', 'admin'),
(3, 1432768568, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36', 'admin'),
(4, 1433544335, '::1', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36', 'admin-huamani'),
(5, 1433544348, '::1', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36', 'admin-huamani');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_relationships`
--

CREATE TABLE IF NOT EXISTS `exp_relationships` (
`relationship_id` int(6) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `child_id` int(10) unsigned NOT NULL DEFAULT '0',
  `field_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grid_field_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grid_col_id` int(10) unsigned NOT NULL DEFAULT '0',
  `grid_row_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_remember_me`
--

CREATE TABLE IF NOT EXISTS `exp_remember_me` (
  `remember_me_id` varchar(40) NOT NULL DEFAULT '0',
  `member_id` int(10) DEFAULT '0',
  `ip_address` varchar(45) DEFAULT '0',
  `user_agent` varchar(120) DEFAULT '',
  `admin_sess` tinyint(1) DEFAULT '0',
  `site_id` int(4) DEFAULT '1',
  `expiration` int(10) DEFAULT '0',
  `last_refresh` int(10) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_reset_password`
--

CREATE TABLE IF NOT EXISTS `exp_reset_password` (
`reset_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `resetcode` varchar(12) NOT NULL,
  `date` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_revision_tracker`
--

CREATE TABLE IF NOT EXISTS `exp_revision_tracker` (
`tracker_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `item_table` varchar(20) NOT NULL,
  `item_field` varchar(20) NOT NULL,
  `item_date` int(10) NOT NULL,
  `item_author_id` int(10) unsigned NOT NULL,
  `item_data` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_rte_tools`
--

CREATE TABLE IF NOT EXISTS `exp_rte_tools` (
`tool_id` int(10) unsigned NOT NULL,
  `name` varchar(75) DEFAULT NULL,
  `class` varchar(75) DEFAULT NULL,
  `enabled` char(1) DEFAULT 'y'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `exp_rte_tools`
--

INSERT INTO `exp_rte_tools` (`tool_id`, `name`, `class`, `enabled`) VALUES
(1, 'Blockquote', 'Blockquote_rte', 'y'),
(2, 'Bold', 'Bold_rte', 'y'),
(3, 'Headings', 'Headings_rte', 'y'),
(4, 'Image', 'Image_rte', 'y'),
(5, 'Italic', 'Italic_rte', 'y'),
(6, 'Link', 'Link_rte', 'y'),
(7, 'Ordered List', 'Ordered_list_rte', 'y'),
(8, 'Underline', 'Underline_rte', 'y'),
(9, 'Unordered List', 'Unordered_list_rte', 'y'),
(10, 'View Source', 'View_source_rte', 'y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_rte_toolsets`
--

CREATE TABLE IF NOT EXISTS `exp_rte_toolsets` (
`toolset_id` int(10) unsigned NOT NULL,
  `member_id` int(10) DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `tools` text,
  `enabled` char(1) DEFAULT 'y'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_rte_toolsets`
--

INSERT INTO `exp_rte_toolsets` (`toolset_id`, `member_id`, `name`, `tools`, `enabled`) VALUES
(1, 0, 'Default', '3|2|5|1|9|7|6|4|10', 'y');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_search`
--

CREATE TABLE IF NOT EXISTS `exp_search` (
  `search_id` varchar(32) NOT NULL,
  `site_id` int(4) NOT NULL DEFAULT '1',
  `search_date` int(10) NOT NULL,
  `keywords` varchar(60) NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `total_results` int(6) NOT NULL,
  `per_page` tinyint(3) unsigned NOT NULL,
  `query` mediumtext,
  `custom_fields` mediumtext,
  `result_page` varchar(70) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_search_log`
--

CREATE TABLE IF NOT EXISTS `exp_search_log` (
`id` int(10) NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `member_id` int(10) unsigned NOT NULL,
  `screen_name` varchar(50) NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `search_date` int(10) NOT NULL,
  `search_type` varchar(32) NOT NULL,
  `search_terms` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_security_hashes`
--

CREATE TABLE IF NOT EXISTS `exp_security_hashes` (
`hash_id` int(10) unsigned NOT NULL,
  `date` int(10) unsigned NOT NULL,
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `hash` varchar(40) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `exp_security_hashes`
--

INSERT INTO `exp_security_hashes` (`hash_id`, `date`, `session_id`, `hash`) VALUES
(14, 1433192069, '8c7393276135ad6b74cf021f59cf04d7de7ffe54', 'a46f8468e1cae0fac08a797ae55144ac65df2d3f'),
(16, 1433281679, '2c219e08db7d9c5938477d425893aec4a5a1de26', '6d142c5e32c3d8a0348bb8d1e46bb558e69df67e'),
(15, 1433195809, '5db7ec8f206157a5fcdf0074cc7728ab706b7e2d', '892659b613ebc052d308facc0a815a9aaf5a678f'),
(17, 1433543299, 'cfc96a8a151e65ed3b9b8a192c250d5af8bb05f4', '65b2ca868d32ec862cccf509877c98e1054dbebb'),
(18, 1433544475, 'ad09cd19a26fd0312e17a70708fbe64001085950', 'd5508d2fac332d97c1c1208c77aaae140b628716'),
(19, 1433545254, 'd557151e3da8478ec88860cb79a30d0e57e70482', 'e0ba804fd1e4d78b5919a54d6fdb0c5ce3a228ba'),
(20, 1433547769, 'a26e0a162ba1329f7ecb9694d63213508a59c150', 'a4371725164eaee54ebc69e811db4a3e092a18fe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_sessions`
--

CREATE TABLE IF NOT EXISTS `exp_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `admin_sess` tinyint(1) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `fingerprint` varchar(40) NOT NULL,
  `sess_start` int(10) unsigned NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_sites`
--

CREATE TABLE IF NOT EXISTS `exp_sites` (
`site_id` int(5) unsigned NOT NULL,
  `site_label` varchar(100) NOT NULL DEFAULT '',
  `site_name` varchar(50) NOT NULL DEFAULT '',
  `site_description` text,
  `site_system_preferences` mediumtext NOT NULL,
  `site_mailinglist_preferences` text NOT NULL,
  `site_member_preferences` text NOT NULL,
  `site_template_preferences` text NOT NULL,
  `site_channel_preferences` text NOT NULL,
  `site_bootstrap_checksums` text NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_sites`
--

INSERT INTO `exp_sites` (`site_id`, `site_label`, `site_name`, `site_description`, `site_system_preferences`, `site_mailinglist_preferences`, `site_member_preferences`, `site_template_preferences`, `site_channel_preferences`, `site_bootstrap_checksums`) VALUES
(1, 'piscohuamani', 'default_site', NULL, 'YTo4OTp7czoxMDoic2l0ZV9pbmRleCI7czo5OiJpbmRleC5waHAiO3M6ODoic2l0ZV91cmwiO3M6MzA6Imh0dHA6Ly9sb2NhbGhvc3QvUGlzY29odWFtYW5pLyI7czoxNjoidGhlbWVfZm9sZGVyX3VybCI7czozNzoiaHR0cDovL2xvY2FsaG9zdC9QaXNjb2h1YW1hbmkvdGhlbWVzLyI7czoxNToid2VibWFzdGVyX2VtYWlsIjtzOjE5OiJqb3NlLmxlZUBheXVpbmMuY29tIjtzOjE0OiJ3ZWJtYXN0ZXJfbmFtZSI7czowOiIiO3M6MjA6ImNoYW5uZWxfbm9tZW5jbGF0dXJlIjtzOjc6ImNoYW5uZWwiO3M6MTA6Im1heF9jYWNoZXMiO3M6MzoiMTUwIjtzOjExOiJjYXB0Y2hhX3VybCI7czo0NjoiaHR0cDovL2xvY2FsaG9zdC9lZV90cmFpbm5pbmcvaW1hZ2VzL2NhcHRjaGFzLyI7czoxMjoiY2FwdGNoYV9wYXRoIjtzOjQ5OiJDOlxob21lXGVlX3RyYWlubmluZ1xyZXBvX2dpdGh1YlxpbWFnZXNcY2FwdGNoYXNcIjtzOjEyOiJjYXB0Y2hhX2ZvbnQiO3M6MToieSI7czoxMjoiY2FwdGNoYV9yYW5kIjtzOjE6InkiO3M6MjM6ImNhcHRjaGFfcmVxdWlyZV9tZW1iZXJzIjtzOjE6Im4iO3M6MTc6ImVuYWJsZV9kYl9jYWNoaW5nIjtzOjE6Im4iO3M6MTg6ImVuYWJsZV9zcWxfY2FjaGluZyI7czoxOiJuIjtzOjE4OiJmb3JjZV9xdWVyeV9zdHJpbmciO3M6MToibiI7czoxMzoic2hvd19wcm9maWxlciI7czoxOiJuIjtzOjE4OiJ0ZW1wbGF0ZV9kZWJ1Z2dpbmciO3M6MToibiI7czoxNToiaW5jbHVkZV9zZWNvbmRzIjtzOjE6Im4iO3M6MTM6ImNvb2tpZV9kb21haW4iO3M6MDoiIjtzOjExOiJjb29raWVfcGF0aCI7czowOiIiO3M6MjA6IndlYnNpdGVfc2Vzc2lvbl90eXBlIjtzOjE6ImMiO3M6MTU6ImNwX3Nlc3Npb25fdHlwZSI7czoyOiJjcyI7czoyMToiYWxsb3dfdXNlcm5hbWVfY2hhbmdlIjtzOjE6InkiO3M6MTg6ImFsbG93X211bHRpX2xvZ2lucyI7czoxOiJ5IjtzOjE2OiJwYXNzd29yZF9sb2Nrb3V0IjtzOjE6InkiO3M6MjU6InBhc3N3b3JkX2xvY2tvdXRfaW50ZXJ2YWwiO3M6MToiMSI7czoyMDoicmVxdWlyZV9pcF9mb3JfbG9naW4iO3M6MToieSI7czoyMjoicmVxdWlyZV9pcF9mb3JfcG9zdGluZyI7czoxOiJ5IjtzOjI0OiJyZXF1aXJlX3NlY3VyZV9wYXNzd29yZHMiO3M6MToibiI7czoxOToiYWxsb3dfZGljdGlvbmFyeV9wdyI7czoxOiJ5IjtzOjIzOiJuYW1lX29mX2RpY3Rpb25hcnlfZmlsZSI7czowOiIiO3M6MTc6Inhzc19jbGVhbl91cGxvYWRzIjtzOjE6InkiO3M6MTU6InJlZGlyZWN0X21ldGhvZCI7czo3OiJyZWZyZXNoIjtzOjk6ImRlZnRfbGFuZyI7czo3OiJlbmdsaXNoIjtzOjg6InhtbF9sYW5nIjtzOjI6ImVuIjtzOjEyOiJzZW5kX2hlYWRlcnMiO3M6MToieSI7czoxMToiZ3ppcF9vdXRwdXQiO3M6MToibiI7czoxMzoibG9nX3JlZmVycmVycyI7czoxOiJuIjtzOjEzOiJtYXhfcmVmZXJyZXJzIjtzOjM6IjUwMCI7czoxMToiZGF0ZV9mb3JtYXQiO3M6ODoiJW4vJWovJXkiO3M6MTE6InRpbWVfZm9ybWF0IjtzOjI6IjEyIjtzOjEzOiJzZXJ2ZXJfb2Zmc2V0IjtzOjA6IiI7czoyMToiZGVmYXVsdF9zaXRlX3RpbWV6b25lIjtzOjEyOiJBbWVyaWNhL0xpbWEiO3M6MTM6Im1haWxfcHJvdG9jb2wiO3M6NDoibWFpbCI7czoxMToic210cF9zZXJ2ZXIiO3M6MDoiIjtzOjEzOiJzbXRwX3VzZXJuYW1lIjtzOjA6IiI7czoxMzoic210cF9wYXNzd29yZCI7czowOiIiO3M6MTE6ImVtYWlsX2RlYnVnIjtzOjE6Im4iO3M6MTM6ImVtYWlsX2NoYXJzZXQiO3M6NToidXRmLTgiO3M6MTU6ImVtYWlsX2JhdGNobW9kZSI7czoxOiJuIjtzOjE2OiJlbWFpbF9iYXRjaF9zaXplIjtzOjA6IiI7czoxMToibWFpbF9mb3JtYXQiO3M6NToicGxhaW4iO3M6OToid29yZF93cmFwIjtzOjE6InkiO3M6MjI6ImVtYWlsX2NvbnNvbGVfdGltZWxvY2siO3M6MToiNSI7czoyMjoibG9nX2VtYWlsX2NvbnNvbGVfbXNncyI7czoxOiJ5IjtzOjg6ImNwX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MjE6ImVtYWlsX21vZHVsZV9jYXB0Y2hhcyI7czoxOiJuIjtzOjE2OiJsb2dfc2VhcmNoX3Rlcm1zIjtzOjE6InkiO3M6MTk6ImRlbnlfZHVwbGljYXRlX2RhdGEiO3M6MToieSI7czoyNDoicmVkaXJlY3Rfc3VibWl0dGVkX2xpbmtzIjtzOjE6Im4iO3M6MTY6ImVuYWJsZV9jZW5zb3JpbmciO3M6MToibiI7czoxNDoiY2Vuc29yZWRfd29yZHMiO3M6MDoiIjtzOjE4OiJjZW5zb3JfcmVwbGFjZW1lbnQiO3M6MDoiIjtzOjEwOiJiYW5uZWRfaXBzIjtzOjA6IiI7czoxMzoiYmFubmVkX2VtYWlscyI7czowOiIiO3M6MTY6ImJhbm5lZF91c2VybmFtZXMiO3M6MDoiIjtzOjE5OiJiYW5uZWRfc2NyZWVuX25hbWVzIjtzOjA6IiI7czoxMDoiYmFuX2FjdGlvbiI7czo4OiJyZXN0cmljdCI7czoxMToiYmFuX21lc3NhZ2UiO3M6MzQ6IlRoaXMgc2l0ZSBpcyBjdXJyZW50bHkgdW5hdmFpbGFibGUiO3M6MTU6ImJhbl9kZXN0aW5hdGlvbiI7czoyMToiaHR0cDovL3d3dy55YWhvby5jb20vIjtzOjE2OiJlbmFibGVfZW1vdGljb25zIjtzOjE6InkiO3M6MTI6ImVtb3RpY29uX3VybCI7czo0NToiaHR0cDovL2xvY2FsaG9zdC9lZV90cmFpbm5pbmcvaW1hZ2VzL3NtaWxleXMvIjtzOjE5OiJyZWNvdW50X2JhdGNoX3RvdGFsIjtzOjQ6IjEwMDAiO3M6MTc6Im5ld192ZXJzaW9uX2NoZWNrIjtzOjE6InkiO3M6MTc6ImVuYWJsZV90aHJvdHRsaW5nIjtzOjE6Im4iO3M6MTc6ImJhbmlzaF9tYXNrZWRfaXBzIjtzOjE6InkiO3M6MTQ6Im1heF9wYWdlX2xvYWRzIjtzOjI6IjEwIjtzOjEzOiJ0aW1lX2ludGVydmFsIjtzOjE6IjgiO3M6MTI6ImxvY2tvdXRfdGltZSI7czoyOiIzMCI7czoxNToiYmFuaXNobWVudF90eXBlIjtzOjc6Im1lc3NhZ2UiO3M6MTQ6ImJhbmlzaG1lbnRfdXJsIjtzOjA6IiI7czoxODoiYmFuaXNobWVudF9tZXNzYWdlIjtzOjUwOiJZb3UgaGF2ZSBleGNlZWRlZCB0aGUgYWxsb3dlZCBwYWdlIGxvYWQgZnJlcXVlbmN5LiI7czoxNzoiZW5hYmxlX3NlYXJjaF9sb2ciO3M6MToieSI7czoxOToibWF4X2xvZ2dlZF9zZWFyY2hlcyI7czozOiI1MDAiO3M6MTc6InRoZW1lX2ZvbGRlcl9wYXRoIjtzOjQwOiJDOi9ob21lL2VlX3RyYWlubmluZy9yZXBvX2dpdGh1Yi90aGVtZXMvIjtzOjEwOiJpc19zaXRlX29uIjtzOjE6InkiO3M6MTE6InJ0ZV9lbmFibGVkIjtzOjE6InkiO3M6MjI6InJ0ZV9kZWZhdWx0X3Rvb2xzZXRfaWQiO3M6MToiMSI7czoxMjoiY2FjaGVfZHJpdmVyIjtzOjQ6ImZpbGUiO30=', 'YTozOntzOjE5OiJtYWlsaW5nbGlzdF9lbmFibGVkIjtzOjE6InkiO3M6MTg6Im1haWxpbmdsaXN0X25vdGlmeSI7czoxOiJuIjtzOjI1OiJtYWlsaW5nbGlzdF9ub3RpZnlfZW1haWxzIjtzOjA6IiI7fQ==', 'YTo0NDp7czoxMDoidW5fbWluX2xlbiI7czoxOiI0IjtzOjEwOiJwd19taW5fbGVuIjtzOjE6IjUiO3M6MjU6ImFsbG93X21lbWJlcl9yZWdpc3RyYXRpb24iO3M6MToibiI7czoyNToiYWxsb3dfbWVtYmVyX2xvY2FsaXphdGlvbiI7czoxOiJ5IjtzOjE4OiJyZXFfbWJyX2FjdGl2YXRpb24iO3M6NToiZW1haWwiO3M6MjM6Im5ld19tZW1iZXJfbm90aWZpY2F0aW9uIjtzOjE6Im4iO3M6MjM6Im1icl9ub3RpZmljYXRpb25fZW1haWxzIjtzOjA6IiI7czoyNDoicmVxdWlyZV90ZXJtc19vZl9zZXJ2aWNlIjtzOjE6InkiO3M6MjI6InVzZV9tZW1iZXJzaGlwX2NhcHRjaGEiO3M6MToibiI7czoyMDoiZGVmYXVsdF9tZW1iZXJfZ3JvdXAiO3M6MToiNSI7czoxNToicHJvZmlsZV90cmlnZ2VyIjtzOjY6Im1lbWJlciI7czoxMjoibWVtYmVyX3RoZW1lIjtzOjc6ImRlZmF1bHQiO3M6MTQ6ImVuYWJsZV9hdmF0YXJzIjtzOjE6InkiO3M6MjA6ImFsbG93X2F2YXRhcl91cGxvYWRzIjtzOjE6Im4iO3M6MTA6ImF2YXRhcl91cmwiO3M6NDU6Imh0dHA6Ly9sb2NhbGhvc3QvZWVfdHJhaW5uaW5nL2ltYWdlcy9hdmF0YXJzLyI7czoxMToiYXZhdGFyX3BhdGgiO3M6NDg6IkM6XGhvbWVcZWVfdHJhaW5uaW5nXHJlcG9fZ2l0aHViXGltYWdlc1xhdmF0YXJzXCI7czoxNjoiYXZhdGFyX21heF93aWR0aCI7czozOiIxMDAiO3M6MTc6ImF2YXRhcl9tYXhfaGVpZ2h0IjtzOjM6IjEwMCI7czoxMzoiYXZhdGFyX21heF9rYiI7czoyOiI1MCI7czoxMzoiZW5hYmxlX3Bob3RvcyI7czoxOiJuIjtzOjk6InBob3RvX3VybCI7czo1MToiaHR0cDovL2xvY2FsaG9zdC9lZV90cmFpbm5pbmcvaW1hZ2VzL21lbWJlcl9waG90b3MvIjtzOjEwOiJwaG90b19wYXRoIjtzOjU0OiJDOlxob21lXGVlX3RyYWlubmluZ1xyZXBvX2dpdGh1YlxpbWFnZXNcbWVtYmVyX3Bob3Rvc1wiO3M6MTU6InBob3RvX21heF93aWR0aCI7czozOiIxMDAiO3M6MTY6InBob3RvX21heF9oZWlnaHQiO3M6MzoiMTAwIjtzOjEyOiJwaG90b19tYXhfa2IiO3M6MjoiNTAiO3M6MTY6ImFsbG93X3NpZ25hdHVyZXMiO3M6MToieSI7czoxMzoic2lnX21heGxlbmd0aCI7czozOiI1MDAiO3M6MjE6InNpZ19hbGxvd19pbWdfaG90bGluayI7czoxOiJuIjtzOjIwOiJzaWdfYWxsb3dfaW1nX3VwbG9hZCI7czoxOiJuIjtzOjExOiJzaWdfaW1nX3VybCI7czo1OToiaHR0cDovL2xvY2FsaG9zdC9lZV90cmFpbm5pbmcvaW1hZ2VzL3NpZ25hdHVyZV9hdHRhY2htZW50cy8iO3M6MTI6InNpZ19pbWdfcGF0aCI7czo2MjoiQzpcaG9tZVxlZV90cmFpbm5pbmdccmVwb19naXRodWJcaW1hZ2VzXHNpZ25hdHVyZV9hdHRhY2htZW50c1wiO3M6MTc6InNpZ19pbWdfbWF4X3dpZHRoIjtzOjM6IjQ4MCI7czoxODoic2lnX2ltZ19tYXhfaGVpZ2h0IjtzOjI6IjgwIjtzOjE0OiJzaWdfaW1nX21heF9rYiI7czoyOiIzMCI7czoxOToicHJ2X21zZ191cGxvYWRfcGF0aCI7czo1NToiQzpcaG9tZVxlZV90cmFpbm5pbmdccmVwb19naXRodWJcaW1hZ2VzXHBtX2F0dGFjaG1lbnRzXCI7czoyMzoicHJ2X21zZ19tYXhfYXR0YWNobWVudHMiO3M6MToiMyI7czoyMjoicHJ2X21zZ19hdHRhY2hfbWF4c2l6ZSI7czozOiIyNTAiO3M6MjA6InBydl9tc2dfYXR0YWNoX3RvdGFsIjtzOjM6IjEwMCI7czoxOToicHJ2X21zZ19odG1sX2Zvcm1hdCI7czo0OiJzYWZlIjtzOjE4OiJwcnZfbXNnX2F1dG9fbGlua3MiO3M6MToieSI7czoxNzoicHJ2X21zZ19tYXhfY2hhcnMiO3M6NDoiNjAwMCI7czoxOToibWVtYmVybGlzdF9vcmRlcl9ieSI7czoxMToidG90YWxfcG9zdHMiO3M6MjE6Im1lbWJlcmxpc3Rfc29ydF9vcmRlciI7czo0OiJkZXNjIjtzOjIwOiJtZW1iZXJsaXN0X3Jvd19saW1pdCI7czoyOiIyMCI7fQ==', 'YTo3OntzOjIyOiJlbmFibGVfdGVtcGxhdGVfcm91dGVzIjtzOjE6InkiO3M6MTE6InN0cmljdF91cmxzIjtzOjE6Im4iO3M6ODoic2l0ZV80MDQiO3M6MDoiIjtzOjE5OiJzYXZlX3RtcGxfcmV2aXNpb25zIjtzOjE6Im4iO3M6MTg6Im1heF90bXBsX3JldmlzaW9ucyI7czoxOiI1IjtzOjE1OiJzYXZlX3RtcGxfZmlsZXMiO3M6MToieSI7czoxODoidG1wbF9maWxlX2Jhc2VwYXRoIjtzOjUwOiIvQXBwbGljYXRpb25zL01BTVAvaHRkb2NzL1Bpc2NvaHVhbWFuaS8vdGVtcGxhdGVzLyI7fQ==', 'YTo5OntzOjIxOiJpbWFnZV9yZXNpemVfcHJvdG9jb2wiO3M6MzoiZ2QyIjtzOjE4OiJpbWFnZV9saWJyYXJ5X3BhdGgiO3M6MDoiIjtzOjE2OiJ0aHVtYm5haWxfcHJlZml4IjtzOjU6InRodW1iIjtzOjE0OiJ3b3JkX3NlcGFyYXRvciI7czoxMDoidW5kZXJzY29yZSI7czoxNzoidXNlX2NhdGVnb3J5X25hbWUiO3M6MToieSI7czoyMjoicmVzZXJ2ZWRfY2F0ZWdvcnlfd29yZCI7czo4OiJjYXRlZ29yeSI7czoyMzoiYXV0b19jb252ZXJ0X2hpZ2hfYXNjaWkiO3M6MToibiI7czoyMjoibmV3X3Bvc3RzX2NsZWFyX2NhY2hlcyI7czoxOiJ5IjtzOjIzOiJhdXRvX2Fzc2lnbl9jYXRfcGFyZW50cyI7czoxOiJ5Ijt9', 'YToyOntzOjc6ImVtYWlsZWQiO2E6MDp7fXM6Mzg6IkM6XHhhbXBwXGh0ZG9jc1xQaXNjb2h1YW1hbmlcaW5kZXgucGhwIjtzOjMyOiIwN2RmM2NmNWUwYmVjZDUyMmQ5YjNjOTJmMGNkMTM2MyI7fQ==');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_snippets`
--

CREATE TABLE IF NOT EXISTS `exp_snippets` (
`snippet_id` int(10) unsigned NOT NULL,
  `site_id` int(4) NOT NULL,
  `snippet_name` varchar(75) NOT NULL,
  `snippet_contents` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_specialty_templates`
--

CREATE TABLE IF NOT EXISTS `exp_specialty_templates` (
`template_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `enable_template` char(1) NOT NULL DEFAULT 'y',
  `template_name` varchar(50) NOT NULL,
  `data_title` varchar(80) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `exp_specialty_templates`
--

INSERT INTO `exp_specialty_templates` (`template_id`, `site_id`, `enable_template`, `template_name`, `data_title`, `template_data`) VALUES
(1, 1, 'y', 'offline_template', '', '<html>\n<head>\n\n<title>System Offline</title>\n\n<style type="text/css">\n\nbody {\nbackground-color:	#ffffff;\nmargin:				50px;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n\na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#999999 1px solid;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n</style>\n\n</head>\n\n<body>\n\n<div id="content">\n\n<h1>System Offline</h1>\n\n<p>This site is currently offline</p>\n\n</div>\n\n</body>\n\n</html>'),
(2, 1, 'y', 'message_template', '', '<html>\n<head>\n\n<title>{title}</title>\n\n<meta http-equiv=''content-type'' content=''text/html; charset={charset}'' />\n\n{meta_refresh}\n\n<style type="text/css">\n\nbody {\nbackground-color:	#ffffff;\nmargin:				50px;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size:			11px;\ncolor:				#000;\nbackground-color:	#fff;\n}\n\na {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nletter-spacing:		.09em;\ntext-decoration:	none;\ncolor:			  #330099;\nbackground-color:	transparent;\n}\n\na:visited {\ncolor:				#330099;\nbackground-color:	transparent;\n}\n\na:active {\ncolor:				#ccc;\nbackground-color:	transparent;\n}\n\na:hover {\ncolor:				#000;\ntext-decoration:	underline;\nbackground-color:	transparent;\n}\n\n#content  {\nborder:				#000 1px solid;\nbackground-color: 	#DEDFE3;\npadding:			22px 25px 14px 25px;\n}\n\nh1 {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-weight:		bold;\nfont-size:			14px;\ncolor:				#000;\nmargin-top: 		0;\nmargin-bottom:		14px;\n}\n\np {\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		12px;\nmargin-bottom: 		14px;\ncolor: 				#000;\n}\n\nul {\nmargin-bottom: 		16px;\n}\n\nli {\nlist-style:			square;\nfont-family:		Verdana, Arial, Tahoma, Trebuchet MS, Sans-serif;\nfont-size: 			12px;\nfont-weight: 		normal;\nmargin-top: 		8px;\nmargin-bottom: 		8px;\ncolor: 				#000;\n}\n\n</style>\n\n</head>\n\n<body>\n\n<div id="content">\n\n<h1>{heading}</h1>\n\n{content}\n\n<p>{link}</p>\n\n</div>\n\n</body>\n\n</html>'),
(3, 1, 'y', 'admin_notify_reg', 'Notification of new member registration', 'New member registration site: {site_name}\n\nScreen name: {name}\nUser name: {username}\nEmail: {email}\n\nYour control panel URL: {control_panel_url}'),
(4, 1, 'y', 'admin_notify_entry', 'A new channel entry has been posted', 'A new entry has been posted in the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nPosted by: {name}\nEmail: {email}\n\nTo read the entry please visit:\n{entry_url}\n'),
(5, 1, 'y', 'admin_notify_mailinglist', 'Someone has subscribed to your mailing list', 'A new mailing list subscription has been accepted.\n\nEmail Address: {email}\nMailing List: {mailing_list}'),
(6, 1, 'y', 'admin_notify_comment', 'You have just received a comment', 'You have just received a comment for the following channel:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nLocated at:\n{comment_url}\n\nPosted by: {name}\nEmail: {email}\nURL: {url}\nLocation: {location}\n\n{comment}'),
(7, 1, 'y', 'mbr_activation_instructions', 'Enclosed is your activation code', 'Thank you for your new member registration.\n\nTo activate your new account, please visit the following URL:\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}\n\n{site_url}'),
(8, 1, 'y', 'forgot_password_instructions', 'Login information', '{name},\n\nTo reset your password, please go to the following page:\n\n{reset_url}\n\nThen log in with your username: {username}\n\nIf you do not wish to reset your password, ignore this message. It will expire in 24 hours.\n\n{site_name}\n{site_url}'),
(9, 1, 'y', 'validated_member_notify', 'Your membership account has been activated', '{name},\n\nYour membership account has been activated and is ready for use.\n\nThank You!\n\n{site_name}\n{site_url}'),
(10, 1, 'y', 'decline_member_validation', 'Your membership account has been declined', '{name},\n\nWe''re sorry but our staff has decided not to validate your membership.\n\n{site_name}\n{site_url}'),
(11, 1, 'y', 'mailinglist_activation_instructions', 'Email Confirmation', 'Thank you for joining the "{mailing_list}" mailing list!\n\nPlease click the link below to confirm your email.\n\nIf you do not want to be added to our list, ignore this email.\n\n{unwrap}{activation_url}{/unwrap}\n\nThank You!\n\n{site_name}'),
(12, 1, 'y', 'comment_notification', 'Someone just responded to your comment', '{name_of_commenter} just responded to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comment at the following URL:\n{comment_url}\n\n{comment}\n\nTo stop receiving notifications for this comment, click here:\n{notification_removal_url}'),
(13, 1, 'y', 'comments_opened_notification', 'New comments have been added', 'Responses have been added to the entry you subscribed to at:\n{channel_name}\n\nThe title of the entry is:\n{entry_title}\n\nYou can see the comments at the following URL:\n{comment_url}\n\n{comments}\n{comment}\n{/comments}\n\nTo stop receiving notifications for this entry, click here:\n{notification_removal_url}'),
(14, 1, 'y', 'private_message_notification', 'Someone has sent you a Private Message', '\n{recipient_name},\n\n{sender_name} has just sent you a Private Message titled ‘{message_subject}’.\n\nYou can see the Private Message by logging in and viewing your inbox at:\n{site_url}\n\nContent:\n\n{message_content}\n\nTo stop receiving notifications of Private Messages, turn the option off in your Email Settings.\n\n{site_name}\n{site_url}'),
(15, 1, 'y', 'pm_inbox_full', 'Your private message mailbox is full', '{recipient_name},\n\n{sender_name} has just attempted to send you a Private Message,\nbut your inbox is full, exceeding the maximum of {pm_storage_limit}.\n\nPlease log in and remove unwanted messages from your inbox at:\n{site_url}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_stats`
--

CREATE TABLE IF NOT EXISTS `exp_stats` (
`stat_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `total_members` mediumint(7) NOT NULL DEFAULT '0',
  `recent_member_id` int(10) NOT NULL DEFAULT '0',
  `recent_member` varchar(50) NOT NULL,
  `total_entries` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_topics` mediumint(8) NOT NULL DEFAULT '0',
  `total_forum_posts` mediumint(8) NOT NULL DEFAULT '0',
  `total_comments` mediumint(8) NOT NULL DEFAULT '0',
  `last_entry_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_forum_post_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_comment_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_visitor_date` int(10) unsigned NOT NULL DEFAULT '0',
  `most_visitors` mediumint(7) NOT NULL DEFAULT '0',
  `most_visitor_date` int(10) unsigned NOT NULL DEFAULT '0',
  `last_cache_clear` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_stats`
--

INSERT INTO `exp_stats` (`stat_id`, `site_id`, `total_members`, `recent_member_id`, `recent_member`, `total_entries`, `total_forum_topics`, `total_forum_posts`, `total_comments`, `last_entry_date`, `last_forum_post_date`, `last_comment_date`, `last_visitor_date`, `most_visitors`, `most_visitor_date`, `last_cache_clear`) VALUES
(1, 1, 1, 1, 'home', 1, 0, 0, 0, 1433286000, 0, 0, 1433964415, 13, 1433282029, 1434147233);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_statuses`
--

CREATE TABLE IF NOT EXISTS `exp_statuses` (
`status_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(4) unsigned NOT NULL,
  `status` varchar(50) NOT NULL,
  `status_order` int(3) unsigned NOT NULL,
  `highlight` varchar(30) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `exp_statuses`
--

INSERT INTO `exp_statuses` (`status_id`, `site_id`, `group_id`, `status`, `status_order`, `highlight`) VALUES
(1, 1, 1, 'open', 1, '009933'),
(2, 1, 1, 'closed', 2, '990000'),
(3, 1, 1, 'Featured', 3, '000000'),
(4, 1, 2, 'open', 1, '009933'),
(5, 1, 2, 'closed', 2, '990000'),
(6, 1, 2, 'First Draft', 3, '000000'),
(7, 1, 2, 'Second Draft', 4, '122B70'),
(8, 1, 2, 'In review', 5, '000000'),
(9, 1, 2, 'Final', 6, '000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_status_groups`
--

CREATE TABLE IF NOT EXISTS `exp_status_groups` (
`group_id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_status_groups`
--

INSERT INTO `exp_status_groups` (`group_id`, `site_id`, `group_name`) VALUES
(1, 1, 'Statuses'),
(2, 1, 'Drafts');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_status_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_status_no_access` (
  `status_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_templates`
--

CREATE TABLE IF NOT EXISTS `exp_templates` (
`template_id` int(10) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_id` int(6) unsigned NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `save_template_file` char(1) NOT NULL DEFAULT 'n',
  `template_type` varchar(16) NOT NULL DEFAULT 'webpage',
  `template_data` mediumtext,
  `template_notes` text,
  `edit_date` int(10) NOT NULL DEFAULT '0',
  `last_author_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cache` char(1) NOT NULL DEFAULT 'n',
  `refresh` int(6) unsigned NOT NULL DEFAULT '0',
  `no_auth_bounce` varchar(50) NOT NULL DEFAULT '',
  `enable_http_auth` char(1) NOT NULL DEFAULT 'n',
  `allow_php` char(1) NOT NULL DEFAULT 'n',
  `php_parse_location` char(1) NOT NULL DEFAULT 'o',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `protect_javascript` char(1) NOT NULL DEFAULT 'n'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `exp_templates`
--

INSERT INTO `exp_templates` (`template_id`, `site_id`, `group_id`, `template_name`, `save_template_file`, `template_type`, `template_data`, `template_notes`, `edit_date`, `last_author_id`, `cache`, `refresh`, `no_auth_bounce`, `enable_http_auth`, `allow_php`, `php_parse_location`, `hits`, `protect_javascript`) VALUES
(1, 1, 1, 'index', 'y', 'webpage', '<!DOCTYPE html>\n<html lang="en">\n	<meta charset="utf-8">\n  	<title>HUAMANÍ</title>\n  	<meta name="description" content="">\n  	<meta name="keywords" content=""> \n  	<meta name="author" content="@PiscoHumani">\n  	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">\n  	<link rel="shortcut icon" href="../../assets/img/favicon.png">\n  	<link href="../../frontend/app/assets/css/style.css" rel="stylesheet"> <!-- App styles -->\n  	<link href="../../frontend/app/assets/css/ebm.css" rel="stylesheet">\n <!-- 	<script src="//use.typekit.net/wml8szi.js"></script> \n    <script>try{Typekit.load();}catch(e){}</script> -->\n    <body>\n			<div class="site-wrapper"> <!-- Body -->\n		    <div class="fondo minhp-100" style="background-image: url(../../app/assets/img/texturas/textura-oscura.png)">\n		    	<div class="logo-title">\n		    		<img src="/app/assets/img/iconos-logos/logo-landing-pisco-huamani.png" alt="">\n		    	</div>\n		    	<h3 class="text-white text-center family-museosans"> HELLO THERE, <br>ARE YOU OF LEGAL DRINKIG AGE?</h3>\n		    	<div id="formulario">\n		    		<div class="date">\n		    			<input id="day" class="text-center text-white" type="text" pattern="[0-9]*" maxlength="2" class="month" placeholder="DAY" name="month" required onkeypress=''validate(event)''>\n		    			<input id="month" class="text-center" type="text" pattern="[0-9]*" maxlength="2" class="day" placeholder="MONTH" name="day" requiered onkeypress=''validate(event)''>\n		    			<input id="year" class="text-center" type="text" pattern="[0-9]*" maxlength="4" class="year" placeholder="YEAR" name="year" requiered onkeypress=''validate(event)''>\n		    		</div>\n		    		<div class="action row">\n    					<select name="LOCATION" required class="col-md-4 thin text-white" style="background-image: url(assets/img/texturas/textura-oscura.png);">\n								<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>\n							   \n							    <option value="AF">Afghanistan</option>>\n								<option value="AX">Åland Islands</option>>\n								<option value="AL">Albania</option>>\n								<option value="DZ">Algeria</option>>\n								<option value="AS">American Samoa</option>>\n								<option value="AD">Andorra</option>>\n								<option value="AO">Angola</option>>\n								<option value="AI">Anguilla</option>>\n								<option value="AQ">Antarctica</option>>\n								<option value="AG">Antigua and Barbuda</option>>\n								<option value="AR">Argentina</option>>\n								<option value="AM">Armenia</option>>\n								<option value="AW">Aruba</option>>\n								<option value="AU">Australia</option>>\n								<option value="AT">Austria</option>>\n								<option value="AZ">Azerbaijan</option>>\n								<option value="BS">Bahamas</option>>\n								<option value="BH">Bahrain</option>>\n								<option value="BD">Bangladesh</option>>\n								<option value="BB">Barbados</option>>\n								<option value="BY">Belarus</option>>\n								<option value="BE">Belgium</option>>\n								<option value="BZ">Belize</option>>\n								<option value="BJ">Benin</option>>\n								<option value="BM">Bermuda</option>>\n								<option value="BT">Bhutan</option>>\n								<option value="BO">Bolivia, Plurinational State of</option>>\n								<option value="BQ">Bonaire, Sint Eustatius and Saba</option>>\n								<option value="BA">Bosnia and Herzegovina</option>>\n								<option value="BW">Botswana</option>>\n								<option value="BV">Bouvet Island</option>>\n								<option value="BR">Brazil</option>>\n								<option value="IO">British Indian Ocean Territory</option>>\n								<option value="BN">Brunei Darussalam</option>>\n								<option value="BG">Bulgaria</option>>\n								<option value="BF">Burkina Faso</option>>\n								<option value="BI">Burundi</option>>\n								<option value="KH">Cambodia</option>>\n								<option value="CM">Cameroon</option>>\n								<option value="CA">Canada</option>>\n								<option value="CV">Cape Verde</option>>\n								<option value="KY">Cayman Islands</option>>\n								<option value="CF">Central African Republic</option>>\n								<option value="TD">Chad</option>>\n								<option value="CL">Chile</option>>\n								<option value="CN">China</option>>\n								<option value="CX">Christmas Island</option>>\n								<option value="CC">Cocos (Keeling) Islands</option>>\n								<option value="CO">Colombia</option>>\n								<option value="KM">Comoros</option>>\n								<option value="CG">Congo</option>>\n								<option value="CD">Congo, the Democratic Republic of the</option>>\n								<option value="CK">Cook Islands</option>>\n								<option value="CR">Costa Rica</option>>\n								<option value="CI">Côte d''Ivoire</option>>\n								<option value="HR">Croatia</option>>\n								<option value="CU">Cuba</option>>\n								<option value="CW">Curaçao</option>>\n								<option value="CY">Cyprus</option>>\n								<option value="CZ">Czech Republic</option>>\n								<option value="DK">Denmark</option>>\n								<option value="DJ">Djibouti</option>>\n								<option value="DM">Dominica</option>>\n								<option value="DO">Dominican Republic</option>>\n								<option value="EC">Ecuador</option>>\n								<option value="EG">Egypt</option>>\n								<option value="SV">El Salvador</option>>\n								<option value="GQ">Equatorial Guinea</option>>\n								<option value="ER">Eritrea</option>>\n								<option value="EE">Estonia</option>>\n								<option value="ET">Ethiopia</option>>\n								<option value="FK">Falkland Islands (Malvinas)</option>>\n								<option value="FO">Faroe Islands</option>>\n								<option value="FJ">Fiji</option>>\n								<option value="FI">Finland</option>>\n								<option value="FR">France</option>>\n								<option value="GF">French Guiana</option>>\n								<option value="PF">French Polynesia</option>>\n								<option value="TF">French Southern Territories</option>>\n								<option value="GA">Gabon</option>>\n								<option value="GM">Gambia</option>>\n								<option value="GE">Georgia</option>>\n								<option value="DE">Germany</option>>\n								<option value="GH">Ghana</option>>\n								<option value="GI">Gibraltar</option>>\n								<option value="GR">Greece</option>>\n								<option value="GL">Greenland</option>>\n								<option value="GD">Grenada</option>>\n								<option value="GP">Guadeloupe</option>>\n								<option value="GU">Guam</option>>\n								<option value="GT">Guatemala</option>>\n								<option value="GG">Guernsey</option>>\n								<option value="GN">Guinea</option>>\n								<option value="GW">Guinea-Bissau</option>>\n								<option value="GY">Guyana</option>>\n								<option value="HT">Haiti</option>>\n								<option value="HM">Heard Island and McDonald Islands</option>>\n								<option value="VA">Holy See (Vatican City State)</option>>\n								<option value="HN">Honduras</option>>\n								<option value="HK">Hong Kong</option>>\n								<option value="HU">Hungary</option>>\n								<option value="IS">Iceland</option>>\n								<option value="IN">India</option>>\n								<option value="ID">Indonesia</option>>\n								<option value="IR">Iran, Islamic Republic of</option>>\n								<option value="IQ">Iraq</option>>\n								<option value="IE">Ireland</option>>\n								<option value="IM">Isle of Man</option>>\n								<option value="IL">Israel</option>>\n								<option value="IT">Italy</option>>\n								<option value="JM">Jamaica</option>>\n								<option value="JP">Japan</option>>\n								<option value="JE">Jersey</option>>\n								<option value="JO">Jordan</option>>\n								<option value="KZ">Kazakhstan</option>>\n								<option value="KE">Kenya</option>>\n								<option value="KI">Kiribati</option>>\n								<option value="KP">Korea, Democratic People''s Republic of</option>>\n								<option value="KR">Korea, Republic of</option>>\n								<option value="KW">Kuwait</option>>\n								<option value="KG">Kyrgyzstan</option>>\n								<option value="LA">Lao People''s Democratic Republic</option>>\n								<option value="LV">Latvia</option>>\n								<option value="LB">Lebanon</option>>\n								<option value="LS">Lesotho</option>>\n								<option value="LR">Liberia</option>>\n								<option value="LY">Libya</option>>\n								<option value="LI">Liechtenstein</option>>\n								<option value="LT">Lithuania</option>>\n								<option value="LU">Luxembourg</option>>\n								<option value="MO">Macao</option>>\n								<option value="MK">Macedonia, the former Yugoslav Republic of</option>>\n								<option value="MG">Madagascar</option>>\n								<option value="MW">Malawi</option>>\n								<option value="MY">Malaysia</option>>\n								<option value="MV">Maldives</option>>\n								<option value="ML">Mali</option>>\n								<option value="MT">Malta</option>>\n								<option value="MH">Marshall Islands</option>>\n								<option value="MQ">Martinique</option>>\n								<option value="MR">Mauritania</option>>\n								<option value="MU">Mauritius</option>>\n								<option value="YT">Mayotte</option>>\n								<option value="MX">Mexico</option>>\n								<option value="FM">Micronesia, Federated States of</option>>\n								<option value="MD">Moldova, Republic of</option>>\n								<option value="MC">Monaco</option>>\n								<option value="MN">Mongolia</option>>\n								<option value="ME">Montenegro</option>>\n								<option value="MS">Montserrat</option>>\n								<option value="MA">Morocco</option>>\n								<option value="MZ">Mozambique</option>>\n								<option value="MM">Myanmar</option>>\n								<option value="NA">Namibia</option>>\n								<option value="NR">Nauru</option>>\n								<option value="NP">Nepal</option>>\n								<option value="NL">Netherlands</option>>\n								<option value="NC">New Caledonia</option>>\n								<option value="NZ">New Zealand</option>>\n								<option value="NI">Nicaragua</option>>\n								<option value="NE">Niger</option>>\n								<option value="NG">Nigeria</option>>\n								<option value="NU">Niue</option>>\n								<option value="NF">Norfolk Island</option>>\n								<option value="MP">Northern Mariana Islands</option>>\n								<option value="NO">Norway</option>>\n								<option value="OM">Oman</option>>\n								<option value="PK">Pakistan</option>>\n								<option value="PW">Palau</option>>\n								<option value="PS">Palestinian Territory, Occupied</option>>\n								<option value="PA">Panama</option>>\n								<option value="PG">Papua New Guinea</option>>\n								<option value="PY">Paraguay</option>>\n								<option value="PE">Peru</option>>\n								<option value="PH">Philippines</option>>\n								<option value="PN">Pitcairn</option>>\n								<option value="PL">Poland</option>>\n								<option value="PT">Portugal</option>>\n								<option value="PR">Puerto Rico</option>>\n								<option value="QA">Qatar</option>>\n								<option value="RE">Réunion</option>>\n								<option value="RO">Romania</option>>\n								<option value="RU">Russian Federation</option>>\n								<option value="RW">Rwanda</option>>\n								<option value="BL">Saint Barthélemy</option>>\n								<option value="SH">Saint Helena, Ascension and Tristan da Cunha</option>>\n								<option value="KN">Saint Kitts and Nevis</option>>\n								<option value="LC">Saint Lucia</option>>\n								<option value="MF">Saint Martin (French part)</option>>\n								<option value="PM">Saint Pierre and Miquelon</option>>\n								<option value="VC">Saint Vincent and the Grenadines</option>>\n								<option value="WS">Samoa</option>>\n								<option value="SM">San Marino</option>>\n								<option value="ST">Sao Tome and Principe</option>>\n								<option value="SA">Saudi Arabia</option>>\n								<option value="SN">Senegal</option>>\n								<option value="RS">Serbia</option>>\n								<option value="SC">Seychelles</option>>\n								<option value="SL">Sierra Leone</option>>\n								<option value="SG">Singapore</option>>\n								<option value="SX">Sint Maarten (Dutch part)</option>>\n								<option value="SK">Slovakia</option>>\n								<option value="SI">Slovenia</option>>\n								<option value="SB">Solomon Islands</option>>\n								<option value="SO">Somalia</option>>\n								<option value="ZA">South Africa</option>>\n								<option value="GS">South Georgia and the South Sandwich Islands</option>>\n								<option value="SS">South Sudan</option>>\n								<option value="ES">Spain</option>>\n								<option value="LK">Sri Lanka</option>>\n								<option value="SD">Sudan</option>>\n								<option value="SR">Suriname</option>>\n								<option value="SJ">Svalbard and Jan Mayen</option>>\n								<option value="SZ">Swaziland</option>>\n								<option value="SE">Sweden</option>>\n								<option value="CH">Switzerland</option>>\n								<option value="SY">Syrian Arab Republic</option>>\n								<option value="TW">Taiwan, Province of China</option>>\n								<option value="TJ">Tajikistan</option>>\n								<option value="TZ">Tanzania, United Republic of</option>>\n								<option value="TH">Thailand</option>>\n								<option value="TL">Timor-Leste</option>>\n								<option value="TG">Togo</option>>\n								<option value="TK">Tokelau</option>>\n								<option value="TO">Tonga</option>>\n								<option value="TT">Trinidad and Tobago</option>>\n								<option value="TN">Tunisia</option>>\n								<option value="TR">Turkey</option>>\n								<option value="TM">Turkmenistan</option>>\n								<option value="TC">Turks and Caicos Islands</option>>\n								<option value="TV">Tuvalu</option>>\n								<option value="UG">Uganda</option>>\n								<option value="UA">Ukraine</option>>\n								<option value="AE">United Arab Emirates</option>>\n								<option value="GB">United Kingdom</option>>\n								<option value="US">United States</option>>\n								<option value="UM">United States Minor Outlying Islands</option>>\n								<option value="UY">Uruguay</option>>\n								<option value="UZ">Uzbekistan</option>>\n								<option value="VU">Vanuatu</option>>\n								<option value="VE">Venezuela, Bolivarian Republic of</option>>\n								<option value="VN">Viet Nam</option>>\n								<option value="VG">Virgin Islands, British</option>>\n								<option value="VI">Virgin Islands, U.S.</option>>\n								<option value="WF">Wallis and Futuna</option>>\n								<option value="EH">Western Sahara</option>>\n								<option value="YE">Yemen</option>>\n								<option value="ZM">Zambia</option>>\n								<option value="ZW">Zimbabwe</option>>\n							  </select>\n					\n\n							<div class="btn-group col-md-4 p-0" role="group" aria-label="...">\n							  <button type="button" class="col-md-6 btn btn-default btn-language" data-value="en">ENGLISH</button>\n							  <button type="button" class="col-md-6 btn btn-default btn-laguange" data-value="es">ESPAÑOL</button>\n							</div>\n							<a href="index.html" class="enter"><button type="button" class="col-md-4 btn btn-default">ENTER <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></button></a>\n		    		</div>\n		    		<div class="checkbox">\n						  <!--input type="checkbox" required id="ejemplo-1" value="1" name="" />-->\n						  <div class="box">\n						  	<span class="close text-white" data-dismiss="modal">&times;</span>\n						  </div>\n						  <label for="ejemplo-1" class="text-white p-0">Remember me</label>\n						</div>\n		    	</div>\n		    </div>\n			</div>\n		</body>\n	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>\n	<script src="../../frontend/js/b3/dropdown.js"></script>\n	<script src="../../frontend/app/assets/js/forms-control.js"></script>\n	<script src="../../frontend/js/app/utils.js"></script>\n	<script src="../../frontend/js/app/gate.js"></script>\n	<script>\n\n	</script>\n</html>', '', 1433287692, 1, 'n', 0, '', 'n', 'n', 'o', 784, 'n'),
(2, 1, 2, 'footer', 'y', 'webpage', '\n	<!-- jQuery -->\n	<!-- <script src="{site_url}js/jquery/jquery.min.js"></script> -->\n\n	<!-- B3 3.1.0 JavaScripts -->\n	<!-- <script src="{site_url}js/b3/affix.js"></script> -->\n	<!-- <script src="{site_url}js/b3/alert.js"></script> -->\n	<!-- <script src="{site_url}js/b3/button.js"></script> -->\n	<!-- <script src="{site_url}js/b3/carousel.js"></script> -->\n	<!-- <script src="{site_url}js/b3/collapse.js"></script> -->\n	<!-- <script src="{site_url}js/b3/dropdown.js"></script> -->\n	<!-- <script src="{site_url}js/b3/modal.js"></script> -->\n	<!-- <script src="{site_url}js/b3/scrollspy.js"></script> -->\n	<!-- <script src="{site_url}js/b3/tab.js"></script> -->\n	<!-- <script src="{site_url}js/b3/tooltip.js"></script> -->\n	<!-- <script src="{site_url}js/b3/transition.js"></script> -->\n	<!-- <script src="{site_url}js/b3/z_popover.js"></script> -->\n\n	<!-- FDN 5 JavaScripts -->\n	<!-- <script src="{site_url}js/fdn/foundation.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.abide.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.accordion.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.alert.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.clearing.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.dropdown.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.equalizer.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.interchange.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.joyride.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.magelian.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.offcanvas.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.orbit.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.reveal.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.slider.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.tab.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.tooltip.js"></script> -->\n	<!-- <script src="{site_url}js/fdn/foundation.topbar.js"></script> -->\n\n	<!-- APP CUSTOM JavaScripts -->\n	<!-- <script src="{site_url}js/app/app.js"></script> -->\n\n	</body>\n</html>', NULL, 1432750824, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(3, 1, 2, 'header', 'y', 'webpage', '<!DOCTYPE html>\n<html lang="en">\n  <head>\n    <meta charset="utf-8">\n\n    <title></title>\n    <!-- Project SEO -->\n    <meta name="description" content="">\n    <meta name="keywords" content="" /> \n    <meta name="author" content="Ayu Consulting S.A.C" />\n\n    <!-- Responsiveness -->\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n\n    <!-- Open Graph -->\n    <!-- <meta property="og:type" content="website">\n    <meta property="og:url" content="">\n    <meta property="og:title" content="">\n    <meta property="og:site_name" content="">\n    <meta property="og:description" content="">\n    <meta property="og:image" content=""> -->\n\n    <!-- Twitter Cards -->\n    <!-- <meta name="twitter:card" content="">\n    <meta name="twitter:title" content="">\n    <meta name="twitter:url" content="">\n    <meta name="twitter:description" content="">\n    <meta name="twitter:site" content="">\n    <meta name="twitter:creator" content="">\n    <meta name="twitter:image" content=""> -->\n\n    <!-- FAVICON -->\n    <!-- <link rel="shortcut icon" href="favicon.ico"> -->\n\n    <!-- Apple Mobile -->\n    <!-- <meta name="apple-mobile-web-app-title" content="">\n    <meta name="apple-mobile-web-app-capable" content="yes">\n    <meta name="apple-mobile-web-app-status-bar-style" content="black"> -->\n\n    <!-- Apple icons -->\n    <!-- <link rel="apple-touch-icon" sizes="156x156" href=""> -->\n    <!-- <link rel="apple-touch-icon" sizes="128x128" href=""> -->\n    <!-- <link rel="apple-touch-icon" sizes="76x76" href=""> -->\n    <!-- <link rel="apple-touch-icon" href=""> -->\n\n    <!-- WebFonts -->\n\n\n    <!-- APP STYLES -->\n    <link rel="stylesheet" href="{site_url}stylesheets/main.css">\n    <!-- <link rel="stylesheet" href="{site_url}stylesheets/main.min.css"> -->\n\n  </head>\n  <body>\n    \n  ', NULL, 1432750824, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(4, 1, 2, 'index', 'y', 'webpage', '<!DOCTYPE html>\n<html lang="en">\n	<meta charset="utf-8">\n  	<title>HUAMANÍ</title>\n  	<meta name="description" content="">\n  	<meta name="keywords" content=""> \n  	<meta name="author" content="@MadeByGus">\n  	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">\n  	<link rel="shortcut icon" href="assets/img/favicon.png">\n  	<link href="assets/css/style.css" rel="stylesheet"> <!-- App styles -->\n  	<link href="assets/css/ebm.css" rel="stylesheet">\n  	<script src="//use.typekit.net/wml8szi.js"></script>\n    <script>try{Typekit.load();}catch(e){}</script>\n    <body>\n			<div class="site-wrapper"> <!-- Body -->\n		    <div class="fondo minhp-100" style="background-image: url(assets/img/texturas/textura-oscura.png)">\n		    	<div class="logo-title">\n		    		<img src="assets/img/iconos-logos/logo-landing-pisco-huamani.png" alt="">\n		    	</div>\n		    	<h3 class="text-white text-center family-museosans"> HELLO THERE, <br>ARE YOU OF LEGAL DRINKIG AGE?</h3>\n		    	<div id="formulario">\n		    		<div class="date">\n		    			<input id="day" class="text-center text-white" type="text" pattern="[0-9]*" maxlength="2" class="month" placeholder="DAY" name="month" required>\n		    			<input id="month" class="text-center" type="text" pattern="[0-9]*" maxlength="2" class="day" placeholder="MONTH" name="day" requiered>\n		    			<input id="year" class="text-center" type="text" pattern="[0-9]*" maxlength="4" class="year" placeholder="YEAR" name="year" requiered>\n		    		</div>\n		    		<div class="action row">\n		    			<div class="dropdown text-white col-md-4 p-0">\n							  <button class="btn btn-default text-white dropdown-toggle text-left" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">\n							    LOCATION\n							    <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>\n							  </button>\n							  <ul class="dropdown-menu p-0 m-0" role="menu" aria-labelledby="dropdownMenu1" style="background-image: url(assets/img/texturas/textura-oscura.png);">\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Arequipa</a></li>\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Cajamarca</a></li>\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Lima</a></li>\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Piura</a></li>\n							  </ul>\n							</div>\n							<div class="btn-group col-md-4 p-0" role="group" aria-label="...">\n							  <button type="button" class="col-md-6 btn btn-default">ENGLISH</button>\n							  <button type="button" class="col-md-6 btn btn-default">ESPAÑOL</button>\n							</div>\n							<a href="index.html" class="enter"><button type="button" class="col-md-4 btn btn-default">ENTER <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></button></a>\n		    		</div>\n		    		<div class="checkbox row">\n						  <input type="checkbox" id="ejemplo-1" value="1" name="" />\n						  <label for="ejemplo-1" class="text-white p-0">Remember me</label>\n						</div>\n		    	</div>\n		    </div>\n			</div>\n		</body>\n	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>\n	<script src="assets/js/b3/dropdown.js"></script>\n</html>', NULL, 1433287692, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(5, 1, 3, 'index', 'y', 'webpage', '<!DOCTYPE html>\n<html lang="en">\n	<meta charset="utf-8">\n  	<title>HUAMANÍ</title>\n  	<meta name="description" content="">\n  	<meta name="keywords" content=""> \n  	<meta name="author" content="@MadeByGus">\n  	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">\n  	<link rel="shortcut icon" href="../../assets/img/favicon.png">\n  	<link href="../../app/assets/css/style.css" rel="stylesheet"> <!-- App styles -->\n  	<link href="../../app/assets/css/ebm.css" rel="stylesheet">\n  	<script src="//use.typekit.net/wml8szi.js"></script>\n    <script>try{Typekit.load();}catch(e){}</script>\n    <body>\n			<div class="site-wrapper"> <!-- Body -->\n		    <div class="fondo minhp-100" style="background-image: url(../../app/assets/img/texturas/textura-oscura.png)">\n		    	<div class="logo-title">\n		    		<img src="../../app/assets/img/iconos-logos/logo-landing-pisco-huamani.png" alt="">\n		    	</div>\n		    	<h3 class="text-white text-center family-museosans"> HELLO THERE, <br>ARE YOU OF LEGAL DRINKIG AGE?</h3>\n		    	<div id="formulario">\n		    		<div class="date">\n		    			<input id="day" class="text-center text-white" type="text" pattern="[0-9]*" maxlength="2" class="month" placeholder="DAY" name="month" required>\n		    			<input id="month" class="text-center" type="text" pattern="[0-9]*" maxlength="2" class="day" placeholder="MONTH" name="day" requiered>\n		    			<input id="year" class="text-center" type="text" pattern="[0-9]*" maxlength="4" class="year" placeholder="YEAR" name="year" requiered>\n		    		</div>\n		    		<div class="action row">\n		    			<div class="dropdown text-white col-md-4 p-0">\n							  <button class="btn btn-default text-white dropdown-toggle text-left" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">\n							    LOCATION\n							    <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>\n							  </button>\n							  <ul class="dropdown-menu p-0 m-0" role="menu" aria-labelledby="dropdownMenu1" style="background-image: url(../../app/assets/img/texturas/textura-oscura.png);">\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Arequipa</a></li>\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Cajamarca</a></li>\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Lima</a></li>\n							    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Piura</a></li>\n							  </ul>\n							</div>\n							<div class="btn-group col-md-4 p-0" role="group" aria-label="...">\n							  <button type="button" class="col-md-6 btn btn-default">ENGLISH</button>\n							  <button type="button" class="col-md-6 btn btn-default">ESPAÑOL</button>\n							</div>\n							<a href="index.html" class="enter"><button type="button" class="col-md-4 btn btn-default">ENTER <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></button></a>\n		    		</div>\n		    		<div class="checkbox">\n						  <!--input type="checkbox" required id="ejemplo-1" value="1" name="" />-->\n						  <div class="box">\n						  	<span class="close text-white" data-dismiss="modal">&times;</span>\n						  </div>\n						  <label for="ejemplo-1" class="text-white p-0">Remember me</label>\n						</div>\n		    	</div>\n		    </div>\n			</div>\n		</body>\n	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>\n	<script src="../../app/assets/js/b3/dropdown.js"></script>\n</html>', '', 1433287692, 1, 'n', 0, '5', 'n', 'n', 'o', 17, 'n'),
(6, 1, 4, 'form-datepicker', 'y', 'webpage', '{embed="inc_dob/.header" title="Date of Birth - Datepicker"}\n\n<script>\n	$(document).ready(function() {\n		var dob = $(''#date_of_birth'');\n	\n		function parseDate(input) {\n			if (typeof input !== "undefined" && input) {\n				var parts = input.match(/(\\d+)/g);\n				var d = new Date(parts[0], parts[1] - 1, parts[2]);\n				var day = d.getDate();\n				if (day < 10) day = ''0'' + day;\n				var month = d.getMonth() + 1;\n				if (month < 10) month = ''0'' + month;\n				var year = d.getFullYear();\n				$(''#date_of_birth_dummy'').val(day + ''-'' + month + ''-'' + year);\n			}\n		}\n		parseDate(dob.val());//Run our parseDate function on page load for saved entries\n		\n		$("#date_of_birth_dummy").datepicker({\n			dateFormat: "dd-mm-yy",//Change our date format for Datepicker\n			changeMonth: true,//Add Month change option to Datepicker\n			changeYear: true,//Add Year change option to Datepicker\n			yearRange: ''1913:2013'',//Set our year range Datepicker\n			onSelect: function(date, inst) {\n				var day = (inst.currentDay.length == 1) ? "0" + inst.currentDay : inst.currentDay,\n					month = (inst.currentMonth < 9) ? "0" + (inst.currentMonth + 1) : (inst.currentMonth + 1),\n					year = inst.currentYear;\n				//Expected ExpressionEngine Date field format is YYYY-MM-DD hh:mm PM\n				dob.val(year + ''-'' + month + ''-'' + day + '' 12:00 AM'');\n			}\n		});\n	});\n</script>\n</head>\n<body>\n\n<h2>Safecracker Form with Date of Birth</h2>\n\n{exp:safecracker channel="person" return="dob/form-datepicker/ENTRY_ID" entry_id="{segment_3}" error_handling="off"}\n\n	<fieldset>\n		<legend>Personal Info</legend>\n		<p>\n			<label for="title">Your Full Name <em>*</em></label>\n			<input type="text" name="title" id="title" value="{title}" size="50" maxlength="100" onkeyup="liveUrlTitle();">\n		</p>\n\n		<p>\n			<label for="url_title">URL Title</label>\n			<input type="text" name="url_title" id="url_title" value="{url_title}" maxlength="75" size="50">\n		</p>\n	</fieldset>\n	\n	<fieldset>\n		<legend>Datepicker Date of Birth</legend>\n		<p>\n			<label>Date of Birth Dummy Field<em>*</em></label>\n			<input type="text" name="date_of_birth_dummy" value="{date_of_birth}" id="date_of_birth_dummy" />\n		</p>\n\n\n		<p>	\n			<label>Date of Birth (hidden field) <em>*</em></label>\n			<input type="text" name="date_of_birth" value="{date_of_birth}" id="date_of_birth" />\n			<!-- Hide this field when using in production by setting type="hidden"-->\n		</p>\n		\n	</fieldset>\n	<p>\n		<input type="submit" name="submit" value="Submit">\n	</p>\n\n{/exp:safecracker}\n\n{embed="inc_dob/.footer"}', NULL, 1432754481, 1, 'n', 0, '', 'n', 'n', 'o', 1, 'n'),
(7, 1, 4, 'form-select-fields', 'y', 'webpage', '{embed="inc_dob/.header" title="Date of Birth - Select Fields"}\n\n<script>\n	$(document).ready(function() {\n		var dateToArray = new Array();\n		var dob = $(''#date_of_birth'');\n	\n		function dateFormat() {\n			$(".dateOfBirth").each(function(i) {\n				dateToArray[i] = $(this).val();\n			});\n		}\n	\n		function parseDate(input) {\n			if (typeof input !== "undefined" && input) {\n				var parts = input.match(/(\\d+)/g);\n				var d = new Date(parts[0], parts[1] - 1, parts[2]);\n				var day = d.getDate();\n				if (day < 10) day = ''0'' + day;\n				var month = d.getMonth() + 1;\n				if (month < 10) month = ''0'' + month;\n				var year = d.getFullYear();\n				$("#day").val(day);\n				$("#month").val(month);\n				$("#year").val(year);\n			}\n		}\n		parseDate(dob.val());\n		dateFormat();\n		\n		$(''.dateOfBirth'').change(function() {\n			dateFormat();\n			var dateConcat = "";\n			for (var i = dateToArray.length - 1; i >= 0; i--) {\n				if (i != 0) {\n					dateConcat += dateToArray[i] + "-";\n				} else dateConcat += dateToArray[i];\n			}\n			//Expected ExpressionEngine Date field format is YYYY-MM-DD hh:mm PM\n			$(''#date_of_birth'').val(dateConcat + '' 12:00 AM'');\n		});\n	});\n\n</script>\n</head>\n<body>\n\n<h2>Safecracker Form with Date of Birth Select Menus</h2>\n\n{exp:safecracker channel="person" return="dob/form-select-fields/ENTRY_ID" entry_id="{segment_3}" error_handling="off"}\n\n	<fieldset>\n		<legend>Personal Info</legend>\n		<p>\n			<label for="title">Your Full Name <em>*</em></label>\n			<input type="text" name="title" id="title" value="{title}" size="50" maxlength="100" onkeyup="liveUrlTitle();">\n		</p>\n	\n		<p>\n			<label for="url_title">URL Title</label>\n			<input type="text" name="url_title" id="url_title" value="{url_title}" maxlength="75" size="50">\n			</p>\n	</fieldset>\n	\n	<fieldset>\n		<legend>Date of Birth</legend>\n		<p>\n			<label>Date of Birth <em>*</em></label>\n		\n			<span>\n				<select id="day" name="day" class="dateOfBirth">\n					<option value="">-- Day --</option>\n					<option value="01">01</option>\n					<option value="02">02</option>\n					<option value="03">03</option>\n					<option value="04">04</option>\n					<option value="05">05</option>\n					<option value="06">06</option>\n					<option value="07">07</option>\n					<option value="08">08</option>\n					<option value="09">09</option>\n					<option value="10">10</option>\n					<option value="11">11</option>\n					<option value="12">12</option>\n					<option value="13">13</option>\n					<option value="14">14</option>\n					<option value="15">15</option>\n					<option value="16">16</option>\n					<option value="17">17</option>\n					<option value="18">18</option>\n					<option value="19">19</option>\n					<option value="20">20</option>\n					<option value="21">21</option>\n					<option value="22">22</option>\n					<option value="23">23</option>\n					<option value="24">24</option>\n					<option value="25">25</option>\n					<option value="26">26</option>\n					<option value="27">27</option>\n					<option value="28">28</option>\n					<option value="29">29</option>\n					<option value="30">30</option>\n					<option value="31">31</option>\n				</select>\n			</span>\n			\n			<span>\n				<select id="month" name="month" class="dateOfBirth">\n					<option value="">-- Month --</option>\n					<option value="01">January</option>\n					<option value="02">February</option>\n					<option value="03">March</option>\n					<option value="04">April</option>\n					<option value="05">May</option>\n					<option value="06">June</option>\n					<option value="07">July</option>\n					<option value="08">August</option>\n					<option value="09">September</option>\n					<option value="10">October</option>\n					<option value="11">November</option>\n					<option value="12">December</option>\n				</select>\n			</span>\n			\n			<span>\n				<select id="year" name="year" class="dateOfBirth">\n					<option value="">-- Year --</option>\n					<option value="1994">1994</option>\n					<option value="1995">1995</option>\n					<option value="1994">1994</option>\n					<option value="1993">1993</option>\n					<option value="1992">1992</option>\n					<option value="1991">1991</option>\n					<option value="1990">1990</option>\n					<option value="1989">1989</option>\n					<option value="1988">1988</option>\n					<option value="1987">1987</option>\n					<option value="1986">1986</option>\n					<option value="1985">1985</option>\n					<option value="1984">1984</option>\n					<option value="1983">1983</option>\n					<option value="1982">1982</option>\n					<option value="1981">1981</option>\n					<option value="1980">1980</option>\n					<option value="1979">1979</option>\n					<option value="1978">1978</option>\n					<option value="1977">1977</option>\n					<option value="1976">1976</option>\n					<option value="1975">1975</option>\n					<option value="1974">1974</option>\n					<option value="1973">1973</option>\n					<option value="1972">1972</option>\n					<option value="1971">1971</option>\n					<option value="1970">1970</option>\n					<option value="1969">1969</option>\n					<option value="1968">1968</option>\n					<option value="1967">1967</option>\n					<option value="1966">1966</option>\n					<option value="1965">1965</option>\n					<option value="1964">1964</option>\n					<option value="1963">1963</option>\n					<option value="1962">1962</option>\n					<option value="1961">1961</option>\n					<option value="1960">1960</option>\n					<option value="1959">1959</option>\n					<option value="1958">1958</option>\n					<option value="1957">1957</option>\n					<option value="1956">1956</option>\n					<option value="1955">1955</option>\n					<option value="1954">1954</option>\n					<option value="1953">1953</option>\n					<option value="1952">1952</option>\n					<option value="1951">1951</option>\n					<option value="1950">1950</option>\n					<option value="1949">1949</option>\n					<option value="1948">1948</option>\n					<option value="1947">1947</option>\n					<option value="1946">1946</option>\n					<option value="1945">1945</option>\n					<option value="1944">1944</option>\n					<option value="1943">1943</option>\n					<option value="1942">1942</option>\n					<option value="1941">1941</option>\n					<option value="1940">1940</option>\n					<option value="1939">1939</option>\n					<option value="1938">1938</option>\n					<option value="1937">1937</option>\n					<option value="1936">1936</option>\n					<option value="1935">1935</option>\n					<option value="1934">1934</option>\n					<option value="1933">1933</option>\n					<option value="1932">1932</option>\n					<option value="1931">1931</option>\n					<option value="1930">1930</option>\n					<option value="1929">1929</option>\n					<option value="1928">1928</option>\n					<option value="1927">1927</option>\n					<option value="1926">1926</option>\n					<option value="1925">1925</option>\n					<option value="1924">1924</option>\n					<option value="1923">1923</option>\n					<option value="1922">1922</option>\n					<option value="1921">1921</option>\n					<option value="1920">1920</option>\n					<option value="1919">1919</option>\n					<option value="1918">1918</option>\n					<option value="1917">1917</option>\n					<option value="1916">1916</option>\n					<option value="1915">1915</option>\n				</select>\n			</span>\n																\n		</p>\n		<div class="clear"></div>\n		\n		<p>	\n			<label>Date of Birth (hidden field) <em>*</em></label>\n			<input type="text" name="date_of_birth" value="{date_of_birth}" id="date_of_birth" />\n			<!-- Hide this field when using in production by setting type="hidden"-->\n		</p>\n		\n	</fieldset>\n	<p>\n		<input type="submit" name="submit" value="Submit">\n	</p>\n\n{/exp:safecracker}\n\n{embed="inc_dob/.footer"}', NULL, 1432754481, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(8, 1, 4, 'index', 'y', 'webpage', '', NULL, 1432761064, 1, 'n', 0, '', 'n', 'n', 'o', 2, 'n'),
(9, 1, 5, '.footer', 'y', 'webpage', '</body>\n</html>', NULL, 1432754481, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(10, 1, 5, '.header', 'y', 'webpage', '<!doctype html>\n<html lang="en">\n<head>\n	<meta charset="utf-8">	\n	<title>{embed:title}</title>\n	\n	<link href="{stylesheet=''inc_dob/dob_style''}" type="text/css" rel="stylesheet" media="screen">\n	\n	<link href="{path=css/_ee_saef_css}" type="text/css" rel="stylesheet" media="screen">\n\n	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>\n', NULL, 1432754481, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(11, 1, 5, 'dob_style', 'y', 'css', '/* reset */\nhtml,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video {\n	margin:0;\n	padding:0;\n	border:0;\n	font-size:100%;\n	font:inherit;\n	vertical-align:baseline;\n}\n\narticle,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section {\n	display:block;\n}\n/* clear*/\n.clear {\n	clear:both;\n	display:block;\n	overflow:hidden;\n	visibility:hidden;\n	width:0;\n	height:0;\n}\n\n\n\nbody {\n	font-size:16px;\n	line-height:1.5;\n	font-family:Helvetica,Arial,sans-serif;\n	color:#222;\n	margin:40px;\n	-webkit-font-smoothing:antialiased;\n	-webkit-text-size-adjust:100%;\n	background:#eaeaea;\n}\n\n/* typography */\n\nh2 {\n	font-size:22px;\n	line-height:30px;\n	color:#222222;\n	letter-spacing:-.2px;\n	margin-bottom:20px;\n}\n\n\np {\n	margin:0 0 15px;\n	line-height:21px;\n}\n\n\n/*\n-----------------\n	F O R M\n----------------\n*/\n\n/* fieldset and legend */\n\nfieldset {\n	width:620px;\n	margin:0 0 20px;\n	background-color:#fdfdfd;\n	display:block;\n	overflow:hidden;\n}\n\nfieldset,legend {\n	border:1px solid #ccc;\n	border-radius:4px;\n}\n\nlegend {\n	padding:3px 15px;\n	margin-left:20px;\n	background-color:#FFF;\n	font-size:12px;\n	color:#169fe6;\n\n}\n\n/* form paragraph */\n\nfieldset p {\n	\n	height:30px;\n	line-height:30px;\n	display:block;\n	padding:5px 0;\n	margin:0;\n	overflow:hidden;\n	position:relative;\n	background-color:#fdfdfd;\n	border-bottom:1px solid #eee;\n	border-top:1px solid #fff;\n}\n\nfieldset p:last-child {\n	border-bottom:none;\n}\n\n/* labels */\n\nlabel {\n	width:200px;\n	float:left;\n	display:block;\n	text-align:right;\n	margin:0 15px 0 0;\n	font-size:12px;\n	color:#555;\n	font-weight:700;\n}\n\nlabel em {\n	font-size:10px;\n	color:#ed1c1c;\n	text-align:left;\n	margin-left:0;\n}\n\nform span {\n	margin:0 10px 0 5px;\n	float:left;\n}\n\n/* form fields */\n\ninput[type=text] {\n	width:250px;\n	padding:3px 3px 2px;\n}\n\ninput[type=text],select {\n	padding:3px;\n	border:1px solid;\n	border-color:#abadb3 #dbdfe6 #e3e9ef #e2e3ea;\n	border-radius:3px;\n	color:#666;\n	font-size:12px;\n}\n\ninput[type=text]:hover,\nselect:hover,\ninput[type=text]:focus,\nselect:focus {\n	border:1px solid;\n	border-color:#5794bf #b7d5ea #c7e2f1 #c5daed;\n	outline:none;\n}\n\nform select {\n	padding:3px 3px 2px;\n}\n\nform select option {\n	background-color:#fff;\n}\n\n\n\n/* submit button */\n\ninput[type="submit"] {\n	padding:5px 14px 7px;\n	display:inline-block;\n	border:0;\n	font-weight:500;\n	outline:none;\n	font-size:13px;\n	cursor:pointer;\n	width:auto;\n	-webkit-transition:all 200ms ease-in-out;\n	-moz-transition:all 200ms ease-in-out;\n	-o-transition:all 200ms ease-in-out;\n	-ms-transition:all 200ms ease-in-out;\n	transition:all 200ms ease-in-out;\n	border-radius:2px;\n	box-shadow:inset 0 -1px 0 0 rgba(0,0,0,0.2);\n	letter-spacing:-.2px;\n}\n\ninput[type="submit"],input[type="submit"]:focus {\n	color:#fff;\n	background:#169fe6;\n	padding:9px 11px;\n	border:none!important;\n}\n\ninput[type="submit"]:hover {\n	background:#aaa;\n}\n', NULL, 1432754481, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n'),
(12, 1, 5, 'index', 'y', 'webpage', '	{date_dropdown_field format="%F %d %Y"}', NULL, 1433287692, 1, 'n', 0, '', 'n', 'n', 'o', 0, 'n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_template_groups`
--

CREATE TABLE IF NOT EXISTS `exp_template_groups` (
`group_id` int(6) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `group_name` varchar(50) NOT NULL,
  `group_order` int(3) unsigned NOT NULL,
  `is_site_default` char(1) NOT NULL DEFAULT 'n'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `exp_template_groups`
--

INSERT INTO `exp_template_groups` (`group_id`, `site_id`, `group_name`, `group_order`, `is_site_default`) VALUES
(1, 1, 'site', 1, 'y'),
(2, 1, 'includes', 2, 'n'),
(3, 1, 'home', 3, 'n'),
(4, 1, 'dob', 4, 'n'),
(5, 1, 'inc_dob', 5, 'n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_template_member_groups`
--

CREATE TABLE IF NOT EXISTS `exp_template_member_groups` (
  `group_id` smallint(4) unsigned NOT NULL,
  `template_group_id` mediumint(5) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_template_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_template_no_access` (
  `template_id` int(6) unsigned NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_template_routes`
--

CREATE TABLE IF NOT EXISTS `exp_template_routes` (
`route_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `order` int(10) unsigned DEFAULT NULL,
  `route` varchar(512) DEFAULT NULL,
  `route_parsed` varchar(512) DEFAULT NULL,
  `route_required` char(1) NOT NULL DEFAULT 'n'
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_template_routes`
--

INSERT INTO `exp_template_routes` (`route_id`, `template_id`, `order`, `route`, `route_parsed`, `route_required`) VALUES
(1, 5, NULL, NULL, NULL, 'n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_throttle`
--

CREATE TABLE IF NOT EXISTS `exp_throttle` (
`throttle_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL,
  `locked_out` char(1) NOT NULL DEFAULT 'n'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_update_log`
--

CREATE TABLE IF NOT EXISTS `exp_update_log` (
`log_id` int(10) unsigned NOT NULL,
  `timestamp` int(10) unsigned DEFAULT NULL,
  `message` text,
  `method` varchar(100) DEFAULT NULL,
  `line` int(10) unsigned DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `exp_update_log`
--

INSERT INTO `exp_update_log` (`log_id`, `timestamp`, `message`, `method`, `line`, `file`) VALUES
(1, 1429833534, 'Update complete. Now running version 2.9.3.', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_update_notices`
--

CREATE TABLE IF NOT EXISTS `exp_update_notices` (
`notice_id` int(10) unsigned NOT NULL,
  `message` text,
  `version` varchar(20) NOT NULL,
  `is_header` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_upload_no_access`
--

CREATE TABLE IF NOT EXISTS `exp_upload_no_access` (
  `upload_id` int(6) unsigned NOT NULL,
  `upload_loc` varchar(3) NOT NULL,
  `member_group` smallint(4) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `exp_upload_prefs`
--

CREATE TABLE IF NOT EXISTS `exp_upload_prefs` (
`id` int(4) unsigned NOT NULL,
  `site_id` int(4) unsigned NOT NULL DEFAULT '1',
  `name` varchar(50) NOT NULL,
  `server_path` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(100) NOT NULL,
  `allowed_types` varchar(3) NOT NULL DEFAULT 'img',
  `max_size` varchar(16) DEFAULT NULL,
  `max_height` varchar(6) DEFAULT NULL,
  `max_width` varchar(6) DEFAULT NULL,
  `properties` varchar(120) DEFAULT NULL,
  `pre_format` varchar(120) DEFAULT NULL,
  `post_format` varchar(120) DEFAULT NULL,
  `file_properties` varchar(120) DEFAULT NULL,
  `file_pre_format` varchar(120) DEFAULT NULL,
  `file_post_format` varchar(120) DEFAULT NULL,
  `cat_group` varchar(255) DEFAULT NULL,
  `batch_location` varchar(255) DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `exp_upload_prefs`
--

INSERT INTO `exp_upload_prefs` (`id`, `site_id`, `name`, `server_path`, `url`, `allowed_types`, `max_size`, `max_height`, `max_width`, `properties`, `pre_format`, `post_format`, `file_properties`, `file_pre_format`, `file_post_format`, `cat_group`, `batch_location`) VALUES
(1, 1, 'Uploads', '/Applications/MAMP/htdocs/Piscohuamani/app/uploads/', 'http://piscohumanai.dev:8888/', 'all', '', '', '', '', '', '', '', '', '', '', NULL),
(2, 1, 'Assets', '/Applications/MAMP/htdocs/Piscohuamani/frontend/app/assets/img/', 'http://piscohumanai.dev:8888/', 'img', '', '', '', '', '', '', '', '', '', '', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `exp_accessories`
--
ALTER TABLE `exp_accessories`
 ADD PRIMARY KEY (`accessory_id`);

--
-- Indices de la tabla `exp_actions`
--
ALTER TABLE `exp_actions`
 ADD PRIMARY KEY (`action_id`);

--
-- Indices de la tabla `exp_captcha`
--
ALTER TABLE `exp_captcha`
 ADD PRIMARY KEY (`captcha_id`), ADD KEY `word` (`word`);

--
-- Indices de la tabla `exp_categories`
--
ALTER TABLE `exp_categories`
 ADD PRIMARY KEY (`cat_id`), ADD KEY `group_id` (`group_id`), ADD KEY `cat_name` (`cat_name`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_category_fields`
--
ALTER TABLE `exp_category_fields`
 ADD PRIMARY KEY (`field_id`), ADD KEY `site_id` (`site_id`), ADD KEY `group_id` (`group_id`);

--
-- Indices de la tabla `exp_category_field_data`
--
ALTER TABLE `exp_category_field_data`
 ADD PRIMARY KEY (`cat_id`), ADD KEY `site_id` (`site_id`), ADD KEY `group_id` (`group_id`);

--
-- Indices de la tabla `exp_category_groups`
--
ALTER TABLE `exp_category_groups`
 ADD PRIMARY KEY (`group_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_category_posts`
--
ALTER TABLE `exp_category_posts`
 ADD PRIMARY KEY (`entry_id`,`cat_id`);

--
-- Indices de la tabla `exp_channels`
--
ALTER TABLE `exp_channels`
 ADD PRIMARY KEY (`channel_id`), ADD KEY `cat_group` (`cat_group`), ADD KEY `status_group` (`status_group`), ADD KEY `field_group` (`field_group`), ADD KEY `channel_name` (`channel_name`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_channel_data`
--
ALTER TABLE `exp_channel_data`
 ADD PRIMARY KEY (`entry_id`), ADD KEY `channel_id` (`channel_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_channel_entries_autosave`
--
ALTER TABLE `exp_channel_entries_autosave`
 ADD PRIMARY KEY (`entry_id`), ADD KEY `channel_id` (`channel_id`), ADD KEY `author_id` (`author_id`), ADD KEY `url_title` (`url_title`), ADD KEY `status` (`status`), ADD KEY `entry_date` (`entry_date`), ADD KEY `expiration_date` (`expiration_date`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_channel_fields`
--
ALTER TABLE `exp_channel_fields`
 ADD PRIMARY KEY (`field_id`), ADD KEY `group_id` (`group_id`), ADD KEY `field_type` (`field_type`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_channel_form_settings`
--
ALTER TABLE `exp_channel_form_settings`
 ADD PRIMARY KEY (`channel_form_settings_id`), ADD KEY `site_id` (`site_id`), ADD KEY `channel_id` (`channel_id`);

--
-- Indices de la tabla `exp_channel_member_groups`
--
ALTER TABLE `exp_channel_member_groups`
 ADD PRIMARY KEY (`group_id`,`channel_id`);

--
-- Indices de la tabla `exp_channel_titles`
--
ALTER TABLE `exp_channel_titles`
 ADD PRIMARY KEY (`entry_id`), ADD KEY `channel_id` (`channel_id`), ADD KEY `author_id` (`author_id`), ADD KEY `url_title` (`url_title`), ADD KEY `status` (`status`), ADD KEY `entry_date` (`entry_date`), ADD KEY `expiration_date` (`expiration_date`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_comments`
--
ALTER TABLE `exp_comments`
 ADD PRIMARY KEY (`comment_id`), ADD KEY `entry_id` (`entry_id`), ADD KEY `channel_id` (`channel_id`), ADD KEY `author_id` (`author_id`), ADD KEY `status` (`status`), ADD KEY `site_id` (`site_id`), ADD KEY `comment_date_idx` (`comment_date`);

--
-- Indices de la tabla `exp_comment_subscriptions`
--
ALTER TABLE `exp_comment_subscriptions`
 ADD PRIMARY KEY (`subscription_id`), ADD KEY `entry_id` (`entry_id`), ADD KEY `member_id` (`member_id`);

--
-- Indices de la tabla `exp_content_types`
--
ALTER TABLE `exp_content_types`
 ADD PRIMARY KEY (`content_type_id`), ADD KEY `name` (`name`);

--
-- Indices de la tabla `exp_cp_log`
--
ALTER TABLE `exp_cp_log`
 ADD PRIMARY KEY (`id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_cp_search_index`
--
ALTER TABLE `exp_cp_search_index`
 ADD PRIMARY KEY (`search_id`), ADD FULLTEXT KEY `keywords` (`keywords`);

--
-- Indices de la tabla `exp_date_dropdown_search`
--
ALTER TABLE `exp_date_dropdown_search`
 ADD PRIMARY KEY (`search_id`);

--
-- Indices de la tabla `exp_date_dropdown_settings`
--
ALTER TABLE `exp_date_dropdown_settings`
 ADD PRIMARY KEY (`settings_id`);

--
-- Indices de la tabla `exp_developer_log`
--
ALTER TABLE `exp_developer_log`
 ADD PRIMARY KEY (`log_id`);

--
-- Indices de la tabla `exp_email_cache`
--
ALTER TABLE `exp_email_cache`
 ADD PRIMARY KEY (`cache_id`);

--
-- Indices de la tabla `exp_email_cache_mg`
--
ALTER TABLE `exp_email_cache_mg`
 ADD PRIMARY KEY (`cache_id`,`group_id`);

--
-- Indices de la tabla `exp_email_cache_ml`
--
ALTER TABLE `exp_email_cache_ml`
 ADD PRIMARY KEY (`cache_id`,`list_id`);

--
-- Indices de la tabla `exp_email_console_cache`
--
ALTER TABLE `exp_email_console_cache`
 ADD PRIMARY KEY (`cache_id`);

--
-- Indices de la tabla `exp_email_tracker`
--
ALTER TABLE `exp_email_tracker`
 ADD PRIMARY KEY (`email_id`);

--
-- Indices de la tabla `exp_entry_versioning`
--
ALTER TABLE `exp_entry_versioning`
 ADD PRIMARY KEY (`version_id`), ADD KEY `entry_id` (`entry_id`);

--
-- Indices de la tabla `exp_extensions`
--
ALTER TABLE `exp_extensions`
 ADD PRIMARY KEY (`extension_id`);

--
-- Indices de la tabla `exp_fieldtypes`
--
ALTER TABLE `exp_fieldtypes`
 ADD PRIMARY KEY (`fieldtype_id`);

--
-- Indices de la tabla `exp_field_formatting`
--
ALTER TABLE `exp_field_formatting`
 ADD PRIMARY KEY (`formatting_id`);

--
-- Indices de la tabla `exp_field_groups`
--
ALTER TABLE `exp_field_groups`
 ADD PRIMARY KEY (`group_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_files`
--
ALTER TABLE `exp_files`
 ADD PRIMARY KEY (`file_id`), ADD KEY `upload_location_id` (`upload_location_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_file_categories`
--
ALTER TABLE `exp_file_categories`
 ADD KEY `file_id` (`file_id`), ADD KEY `cat_id` (`cat_id`);

--
-- Indices de la tabla `exp_file_dimensions`
--
ALTER TABLE `exp_file_dimensions`
 ADD PRIMARY KEY (`id`), ADD KEY `upload_location_id` (`upload_location_id`);

--
-- Indices de la tabla `exp_file_watermarks`
--
ALTER TABLE `exp_file_watermarks`
 ADD PRIMARY KEY (`wm_id`);

--
-- Indices de la tabla `exp_global_variables`
--
ALTER TABLE `exp_global_variables`
 ADD PRIMARY KEY (`variable_id`), ADD KEY `variable_name` (`variable_name`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_grid_columns`
--
ALTER TABLE `exp_grid_columns`
 ADD PRIMARY KEY (`col_id`), ADD KEY `field_id` (`field_id`);

--
-- Indices de la tabla `exp_html_buttons`
--
ALTER TABLE `exp_html_buttons`
 ADD PRIMARY KEY (`id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_layout_publish`
--
ALTER TABLE `exp_layout_publish`
 ADD PRIMARY KEY (`layout_id`), ADD KEY `site_id` (`site_id`), ADD KEY `member_group` (`member_group`), ADD KEY `channel_id` (`channel_id`);

--
-- Indices de la tabla `exp_members`
--
ALTER TABLE `exp_members`
 ADD PRIMARY KEY (`member_id`), ADD KEY `group_id` (`group_id`), ADD KEY `unique_id` (`unique_id`), ADD KEY `password` (`password`);

--
-- Indices de la tabla `exp_member_bulletin_board`
--
ALTER TABLE `exp_member_bulletin_board`
 ADD PRIMARY KEY (`bulletin_id`), ADD KEY `sender_id` (`sender_id`), ADD KEY `hash` (`hash`);

--
-- Indices de la tabla `exp_member_data`
--
ALTER TABLE `exp_member_data`
 ADD PRIMARY KEY (`member_id`);

--
-- Indices de la tabla `exp_member_fields`
--
ALTER TABLE `exp_member_fields`
 ADD PRIMARY KEY (`m_field_id`);

--
-- Indices de la tabla `exp_member_groups`
--
ALTER TABLE `exp_member_groups`
 ADD PRIMARY KEY (`group_id`,`site_id`);

--
-- Indices de la tabla `exp_member_homepage`
--
ALTER TABLE `exp_member_homepage`
 ADD PRIMARY KEY (`member_id`);

--
-- Indices de la tabla `exp_member_search`
--
ALTER TABLE `exp_member_search`
 ADD PRIMARY KEY (`search_id`), ADD KEY `member_id` (`member_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_message_attachments`
--
ALTER TABLE `exp_message_attachments`
 ADD PRIMARY KEY (`attachment_id`);

--
-- Indices de la tabla `exp_message_copies`
--
ALTER TABLE `exp_message_copies`
 ADD PRIMARY KEY (`copy_id`), ADD KEY `message_id` (`message_id`), ADD KEY `recipient_id` (`recipient_id`), ADD KEY `sender_id` (`sender_id`);

--
-- Indices de la tabla `exp_message_data`
--
ALTER TABLE `exp_message_data`
 ADD PRIMARY KEY (`message_id`), ADD KEY `sender_id` (`sender_id`);

--
-- Indices de la tabla `exp_message_folders`
--
ALTER TABLE `exp_message_folders`
 ADD PRIMARY KEY (`member_id`);

--
-- Indices de la tabla `exp_message_listed`
--
ALTER TABLE `exp_message_listed`
 ADD PRIMARY KEY (`listed_id`);

--
-- Indices de la tabla `exp_modules`
--
ALTER TABLE `exp_modules`
 ADD PRIMARY KEY (`module_id`);

--
-- Indices de la tabla `exp_module_member_groups`
--
ALTER TABLE `exp_module_member_groups`
 ADD PRIMARY KEY (`group_id`,`module_id`);

--
-- Indices de la tabla `exp_multi_language`
--
ALTER TABLE `exp_multi_language`
 ADD PRIMARY KEY (`phrase_id`);

--
-- Indices de la tabla `exp_online_users`
--
ALTER TABLE `exp_online_users`
 ADD PRIMARY KEY (`online_id`), ADD KEY `date` (`date`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_password_lockout`
--
ALTER TABLE `exp_password_lockout`
 ADD PRIMARY KEY (`lockout_id`), ADD KEY `login_date` (`login_date`), ADD KEY `ip_address` (`ip_address`), ADD KEY `user_agent` (`user_agent`);

--
-- Indices de la tabla `exp_relationships`
--
ALTER TABLE `exp_relationships`
 ADD PRIMARY KEY (`relationship_id`), ADD KEY `parent_id` (`parent_id`), ADD KEY `child_id` (`child_id`), ADD KEY `field_id` (`field_id`), ADD KEY `grid_row_id` (`grid_row_id`);

--
-- Indices de la tabla `exp_remember_me`
--
ALTER TABLE `exp_remember_me`
 ADD PRIMARY KEY (`remember_me_id`), ADD KEY `member_id` (`member_id`);

--
-- Indices de la tabla `exp_reset_password`
--
ALTER TABLE `exp_reset_password`
 ADD PRIMARY KEY (`reset_id`);

--
-- Indices de la tabla `exp_revision_tracker`
--
ALTER TABLE `exp_revision_tracker`
 ADD PRIMARY KEY (`tracker_id`), ADD KEY `item_id` (`item_id`);

--
-- Indices de la tabla `exp_rte_tools`
--
ALTER TABLE `exp_rte_tools`
 ADD PRIMARY KEY (`tool_id`), ADD KEY `enabled` (`enabled`);

--
-- Indices de la tabla `exp_rte_toolsets`
--
ALTER TABLE `exp_rte_toolsets`
 ADD PRIMARY KEY (`toolset_id`), ADD KEY `member_id` (`member_id`), ADD KEY `enabled` (`enabled`);

--
-- Indices de la tabla `exp_search`
--
ALTER TABLE `exp_search`
 ADD PRIMARY KEY (`search_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_search_log`
--
ALTER TABLE `exp_search_log`
 ADD PRIMARY KEY (`id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_security_hashes`
--
ALTER TABLE `exp_security_hashes`
 ADD PRIMARY KEY (`hash_id`), ADD KEY `session_id` (`session_id`);

--
-- Indices de la tabla `exp_sessions`
--
ALTER TABLE `exp_sessions`
 ADD PRIMARY KEY (`session_id`), ADD KEY `member_id` (`member_id`), ADD KEY `last_activity_idx` (`last_activity`);

--
-- Indices de la tabla `exp_sites`
--
ALTER TABLE `exp_sites`
 ADD PRIMARY KEY (`site_id`), ADD KEY `site_name` (`site_name`);

--
-- Indices de la tabla `exp_snippets`
--
ALTER TABLE `exp_snippets`
 ADD PRIMARY KEY (`snippet_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_specialty_templates`
--
ALTER TABLE `exp_specialty_templates`
 ADD PRIMARY KEY (`template_id`), ADD KEY `template_name` (`template_name`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_stats`
--
ALTER TABLE `exp_stats`
 ADD PRIMARY KEY (`stat_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_statuses`
--
ALTER TABLE `exp_statuses`
 ADD PRIMARY KEY (`status_id`), ADD KEY `group_id` (`group_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_status_groups`
--
ALTER TABLE `exp_status_groups`
 ADD PRIMARY KEY (`group_id`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_status_no_access`
--
ALTER TABLE `exp_status_no_access`
 ADD PRIMARY KEY (`status_id`,`member_group`);

--
-- Indices de la tabla `exp_templates`
--
ALTER TABLE `exp_templates`
 ADD PRIMARY KEY (`template_id`), ADD KEY `group_id` (`group_id`), ADD KEY `template_name` (`template_name`), ADD KEY `site_id` (`site_id`);

--
-- Indices de la tabla `exp_template_groups`
--
ALTER TABLE `exp_template_groups`
 ADD PRIMARY KEY (`group_id`), ADD KEY `site_id` (`site_id`), ADD KEY `group_name_idx` (`group_name`), ADD KEY `group_order_idx` (`group_order`);

--
-- Indices de la tabla `exp_template_member_groups`
--
ALTER TABLE `exp_template_member_groups`
 ADD PRIMARY KEY (`group_id`,`template_group_id`);

--
-- Indices de la tabla `exp_template_no_access`
--
ALTER TABLE `exp_template_no_access`
 ADD PRIMARY KEY (`template_id`,`member_group`);

--
-- Indices de la tabla `exp_template_routes`
--
ALTER TABLE `exp_template_routes`
 ADD PRIMARY KEY (`route_id`), ADD KEY `template_id` (`template_id`);

--
-- Indices de la tabla `exp_throttle`
--
ALTER TABLE `exp_throttle`
 ADD PRIMARY KEY (`throttle_id`), ADD KEY `ip_address` (`ip_address`), ADD KEY `last_activity` (`last_activity`);

--
-- Indices de la tabla `exp_update_log`
--
ALTER TABLE `exp_update_log`
 ADD PRIMARY KEY (`log_id`);

--
-- Indices de la tabla `exp_update_notices`
--
ALTER TABLE `exp_update_notices`
 ADD PRIMARY KEY (`notice_id`);

--
-- Indices de la tabla `exp_upload_no_access`
--
ALTER TABLE `exp_upload_no_access`
 ADD PRIMARY KEY (`upload_id`,`member_group`);

--
-- Indices de la tabla `exp_upload_prefs`
--
ALTER TABLE `exp_upload_prefs`
 ADD PRIMARY KEY (`id`), ADD KEY `site_id` (`site_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `exp_accessories`
--
ALTER TABLE `exp_accessories`
MODIFY `accessory_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_actions`
--
ALTER TABLE `exp_actions`
MODIFY `action_id` int(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT de la tabla `exp_captcha`
--
ALTER TABLE `exp_captcha`
MODIFY `captcha_id` bigint(13) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_categories`
--
ALTER TABLE `exp_categories`
MODIFY `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `exp_category_fields`
--
ALTER TABLE `exp_category_fields`
MODIFY `field_id` int(6) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_category_groups`
--
ALTER TABLE `exp_category_groups`
MODIFY `group_id` int(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `exp_channels`
--
ALTER TABLE `exp_channels`
MODIFY `channel_id` int(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `exp_channel_entries_autosave`
--
ALTER TABLE `exp_channel_entries_autosave`
MODIFY `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `exp_channel_fields`
--
ALTER TABLE `exp_channel_fields`
MODIFY `field_id` int(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `exp_channel_form_settings`
--
ALTER TABLE `exp_channel_form_settings`
MODIFY `channel_form_settings_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `exp_channel_titles`
--
ALTER TABLE `exp_channel_titles`
MODIFY `entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `exp_comments`
--
ALTER TABLE `exp_comments`
MODIFY `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_comment_subscriptions`
--
ALTER TABLE `exp_comment_subscriptions`
MODIFY `subscription_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_content_types`
--
ALTER TABLE `exp_content_types`
MODIFY `content_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `exp_cp_log`
--
ALTER TABLE `exp_cp_log`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `exp_cp_search_index`
--
ALTER TABLE `exp_cp_search_index`
MODIFY `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_date_dropdown_search`
--
ALTER TABLE `exp_date_dropdown_search`
MODIFY `search_id` int(7) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_date_dropdown_settings`
--
ALTER TABLE `exp_date_dropdown_settings`
MODIFY `settings_id` int(7) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `exp_developer_log`
--
ALTER TABLE `exp_developer_log`
MODIFY `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_email_cache`
--
ALTER TABLE `exp_email_cache`
MODIFY `cache_id` int(6) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_email_console_cache`
--
ALTER TABLE `exp_email_console_cache`
MODIFY `cache_id` int(6) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_email_tracker`
--
ALTER TABLE `exp_email_tracker`
MODIFY `email_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_entry_versioning`
--
ALTER TABLE `exp_entry_versioning`
MODIFY `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_extensions`
--
ALTER TABLE `exp_extensions`
MODIFY `extension_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `exp_fieldtypes`
--
ALTER TABLE `exp_fieldtypes`
MODIFY `fieldtype_id` int(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `exp_field_formatting`
--
ALTER TABLE `exp_field_formatting`
MODIFY `formatting_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=45;
--
-- AUTO_INCREMENT de la tabla `exp_field_groups`
--
ALTER TABLE `exp_field_groups`
MODIFY `group_id` int(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `exp_files`
--
ALTER TABLE `exp_files`
MODIFY `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `exp_file_dimensions`
--
ALTER TABLE `exp_file_dimensions`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_file_watermarks`
--
ALTER TABLE `exp_file_watermarks`
MODIFY `wm_id` int(4) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_global_variables`
--
ALTER TABLE `exp_global_variables`
MODIFY `variable_id` int(6) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_grid_columns`
--
ALTER TABLE `exp_grid_columns`
MODIFY `col_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_html_buttons`
--
ALTER TABLE `exp_html_buttons`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `exp_layout_publish`
--
ALTER TABLE `exp_layout_publish`
MODIFY `layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_members`
--
ALTER TABLE `exp_members`
MODIFY `member_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_member_bulletin_board`
--
ALTER TABLE `exp_member_bulletin_board`
MODIFY `bulletin_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_member_fields`
--
ALTER TABLE `exp_member_fields`
MODIFY `m_field_id` int(4) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_message_attachments`
--
ALTER TABLE `exp_message_attachments`
MODIFY `attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_message_copies`
--
ALTER TABLE `exp_message_copies`
MODIFY `copy_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_message_data`
--
ALTER TABLE `exp_message_data`
MODIFY `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_message_listed`
--
ALTER TABLE `exp_message_listed`
MODIFY `listed_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_modules`
--
ALTER TABLE `exp_modules`
MODIFY `module_id` int(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `exp_multi_language`
--
ALTER TABLE `exp_multi_language`
MODIFY `phrase_id` int(7) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_online_users`
--
ALTER TABLE `exp_online_users`
MODIFY `online_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT de la tabla `exp_password_lockout`
--
ALTER TABLE `exp_password_lockout`
MODIFY `lockout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `exp_relationships`
--
ALTER TABLE `exp_relationships`
MODIFY `relationship_id` int(6) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_reset_password`
--
ALTER TABLE `exp_reset_password`
MODIFY `reset_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_revision_tracker`
--
ALTER TABLE `exp_revision_tracker`
MODIFY `tracker_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_rte_tools`
--
ALTER TABLE `exp_rte_tools`
MODIFY `tool_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `exp_rte_toolsets`
--
ALTER TABLE `exp_rte_toolsets`
MODIFY `toolset_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_search_log`
--
ALTER TABLE `exp_search_log`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_security_hashes`
--
ALTER TABLE `exp_security_hashes`
MODIFY `hash_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `exp_sites`
--
ALTER TABLE `exp_sites`
MODIFY `site_id` int(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_snippets`
--
ALTER TABLE `exp_snippets`
MODIFY `snippet_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_specialty_templates`
--
ALTER TABLE `exp_specialty_templates`
MODIFY `template_id` int(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `exp_stats`
--
ALTER TABLE `exp_stats`
MODIFY `stat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_statuses`
--
ALTER TABLE `exp_statuses`
MODIFY `status_id` int(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `exp_status_groups`
--
ALTER TABLE `exp_status_groups`
MODIFY `group_id` int(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `exp_templates`
--
ALTER TABLE `exp_templates`
MODIFY `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `exp_template_groups`
--
ALTER TABLE `exp_template_groups`
MODIFY `group_id` int(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `exp_template_routes`
--
ALTER TABLE `exp_template_routes`
MODIFY `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_throttle`
--
ALTER TABLE `exp_throttle`
MODIFY `throttle_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_update_log`
--
ALTER TABLE `exp_update_log`
MODIFY `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `exp_update_notices`
--
ALTER TABLE `exp_update_notices`
MODIFY `notice_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `exp_upload_prefs`
--
ALTER TABLE `exp_upload_prefs`
MODIFY `id` int(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
