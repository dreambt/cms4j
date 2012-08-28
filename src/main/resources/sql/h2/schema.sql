--
-- 数据库: `cms4j_dev`
--

-- --------------------------------------------------------

--
-- 表的结构 `cms_agency`
--
DROP TABLE IF EXISTS `cms_agency`;
CREATE TABLE IF NOT EXISTS `cms_agency` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `category_id` mediumint(8) NOT NULL,
  `image_url` varchar(50) NOT NULL,
  `introduction` mediumtext NOT NULL,
  `rate` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_archive`
--
DROP TABLE IF EXISTS `cms_archive`;
CREATE TABLE IF NOT EXISTS `cms_archive` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_archive_article`
--
DROP TABLE IF EXISTS `cms_archive_article`;
CREATE TABLE IF NOT EXISTS `cms_archive_article` (
  `archive_id` mediumint(8) NOT NULL,
  `article_id` mediumint(8) NOT NULL,
  PRIMARY KEY (`archive_id`,`article_id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_article`
--
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE IF NOT EXISTS `cms_article` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) NOT NULL,
  `category_id` mediumint(8) NOT NULL,
  `subject` varchar(80) NOT NULL,
  `message` mediumtext NOT NULL,
  `image_name` varchar(50) NOT NULL,
  `digest` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `url` varchar(40) NOT NULL,
  `top` tinyint(1) NOT NULL,
  `rate` tinyint(3) NOT NULL,
  `rate_times` int(11) NOT NULL,
  `views` int(11) NOT NULL,
  `allow_comment` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_category`
--
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE IF NOT EXISTS `cms_category` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `father_category_id` mediumint(8) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `display_order` smallint(6) NOT NULL,
  `show_type` varchar(20) NOT NULL,
  `url` varchar(80) NOT NULL,
  `description` text NOT NULL,
  `allow_comment` tinyint(1) NOT NULL,
  `allow_publish` tinyint(1) NOT NULL,
  `show_nav` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_comment`
--
DROP TABLE IF EXISTS `cms_comment`;
CREATE TABLE IF NOT EXISTS `cms_comment` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` mediumint(8) NOT NULL,
  `username` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `post_ip` int(10) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_group`
--
DROP TABLE IF EXISTS `cms_group`;
CREATE TABLE IF NOT EXISTS `cms_group` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_group_permission`
--
DROP TABLE IF EXISTS `cms_group_permission`;
CREATE TABLE IF NOT EXISTS `cms_group_permission` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `group_id` mediumint(8) NOT NULL,
  `permission` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_image`
--
DROP TABLE IF EXISTS `cms_image`;
CREATE TABLE IF NOT EXISTS `cms_image` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `image_url` varchar(80) NOT NULL,
  `description` varchar(255) NOT NULL,
  `show_index` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_link`
--
DROP TABLE IF EXISTS `cms_link`;
CREATE TABLE IF NOT EXISTS `cms_link` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `url` varchar(80) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_manage_log`
--
DROP TABLE IF EXISTS `cms_manage_log`;
CREATE TABLE IF NOT EXISTS `cms_manage_log` (
  `id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) NOT NULL,
  `action` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_teacher`
--
DROP TABLE IF EXISTS `cms_teacher`;
CREATE TABLE IF NOT EXISTS `cms_teacher` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `top` tinyint(1) NOT NULL,
  `teacher_name` varchar(20) NOT NULL,
  `article_id` mediumint(8) NOT NULL,
  `agency_id` mediumint(8) NOT NULL,
  `image_url` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- --------------------------------------------------------

--
-- 表的结构 `cms_user`
--
DROP TABLE IF EXISTS `cms_user`;
CREATE TABLE IF NOT EXISTS `cms_user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` mediumint(8) unsigned NOT NULL,
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(16) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `email_status` tinyint(1) NOT NULL,
  `avatar_status` tinyint(1) NOT NULL,
  `photo_url` varchar(40) NOT NULL,
  `time_offset` varchar(4) NOT NULL,
  `last_ip` int(10) NOT NULL,
  `last_time` datetime NOT NULL,
  `last_act_time` datetime NOT NULL,
  `last_modified_date` timestamp DEFAULT NULL,
  `created_date` timestamp DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
);
