-- -----------------------------------------------------
-- Table `cms_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user` ;

CREATE  TABLE IF NOT EXISTS `cms_user` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(40) NOT NULL ,
  `username` VARCHAR(40) NOT NULL ,
  `password` CHAR(40) NOT NULL ,
  `salt` CHAR(16) NOT NULL ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 ,
  `email_status` TINYINT(1) NOT NULL DEFAULT 0 ,
  `avatar_status` TINYINT(1) NOT NULL DEFAULT 0 ,
  `photourl` VARCHAR(20) NOT NULL,
  `time_offset` CHAR(4) NOT NULL,
  `lastip` INT(10) NOT NULL,
  `last_time` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  `last_act_time` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  `created_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `cms_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_group`;

create table `cms_group` (
        id MEDIUMINT(8) UNSIGNED not null AUTO_INCREMENT,
        group_name VARCHAR(40) NOT NULL ,
        PRIMARY KEY (`id`)
) ;

-- -----------------------------------------------------
-- Table `cms_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user_group`;

create table `cms_user_group` (
        user_id MEDIUMINT(8) UNSIGNED not null,
        group_id MEDIUMINT(8) UNSIGNED not null,
        foreign key(user_id) references cms_user(id),
        foreign key(group_id) references cms_group(id)
) ;

-- -----------------------------------------------------
-- Table `cms_group_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_group_permission`;

create table `cms_group_permission` (
        id MEDIUMINT(8) UNSIGNED not null AUTO_INCREMENT,
        group_id MEDIUMINT(8) UNSIGNED not null,
        permission varchar(20) not null,
        PRIMARY KEY (`id`),
        foreign key(group_id) references cms_group(id)
) ;

-- -----------------------------------------------------
-- Table `cms_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_category` ;

CREATE  TABLE `cms_category` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `father_category_id` MEDIUMINT(8) NOT NULL DEFAULT 0 ,
  `category_name` VARCHAR(255) NOT NULL ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 1 ,
  `display_order` SMALLINT(6) NOT NULL DEFAULT 0 ,
  `url` VARCHAR(255) NOT NULL DEFAULT 0 ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 ,
  `description` VARCHAR(255) NOT NULL ,
  `allow_publish` TINYINT(1) NOT NULL ,
  `show_type` VARCHAR(20) NOT NULL,
  `created_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  `modify_time` TIMESTAMP NOT NULL DEFAULT 549567296,
  PRIMARY KEY (`id`),
  foreign key(father_category_id) references cms_category(id)
);

-- -----------------------------------------------------
-- Table `cms_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_article` ;

CREATE  TABLE IF NOT EXISTS `cms_article` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `author` VARCHAR(80) NOT NULL ,
  `category_name` VARCHAR(80) NOT NULL ,
  `subject` VARCHAR(80) NOT NULL ,
  `message` TEXT NOT NULL ,
  `digest` VARCHAR(255) NOT NULL ,
  `keyword` VARCHAR(80) NOT NULL ,
  `top` TINYINT(1) NOT NULL DEFAULT 0 ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 ,
  `rate` SMALLINT(6) NOT NULL DEFAULT 0 ,
  `rate_times` TINYINT(3) NOT NULL DEFAULT 0 ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 0 ,
  `views` TINYINT(3) NOT NULL DEFAULT 0 ,
  `count` TINYINT(3) NOT NULL DEFAULT 0 ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `cms_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_comment` ;

CREATE  TABLE IF NOT EXISTS `cms_comment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `article_id` MEDIUMINT(8) NOT NULL ,
  `username` VARCHAR(50) NOT NULL ,
  `message` VARCHAR(1000) NOT NULL ,
  `post_ip` INT(10) NOT NULL ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  `created_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  foreign key(article_id) references cms_article(id)
);

-- -----------------------------------------------------
-- Table `cms_user_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user_article` ;

CREATE  TABLE IF NOT EXISTS `cms_user_article` (
  `user_id` MEDIUMINT(8) NOT NULL ,
  `article_id` MEDIUMINT(8) NOT NULL ,
  foreign key(user_id) references cms_user(id),
  foreign key(article_id) references cms_article(id)
);

-- -----------------------------------------------------
-- Table `cms_category_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_category_article` ;

CREATE  TABLE IF NOT EXISTS `cms_category_article` (
  `category_id` MEDIUMINT(8) NOT NULL ,
  `article_id` MEDIUMINT(8) NOT NULL ,
  foreign key(category_id) references cms_category(id),
  foreign key(article_id) references cms_article(id)
);

-- -----------------------------------------------------
-- Table `cms_manage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_manage_log` ;

CREATE  TABLE IF NOT EXISTS `cms_manage_log` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `user_id` MEDIUMINT(8) NOT NULL ,
  `action` VARCHAR(255) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  `created_date` TIMESTAMP NOT NULL DEFAULT 549567296,
  PRIMARY KEY (`id`),
  foreign key(user_id) references cms_user(id)
);

-- -----------------------------------------------------
-- Table `cms_archive`
-- -----------------------------------------------------

DROP TABLE IF EXISTS cms_archive;

CREATE TABLE IF NOT EXISTS cms_archive (
id INT(10) NOT NULL AUTO_INCREMENT,
title VARCHAR(10) NOT NULL,
article_count INT(5) NOT NULL,
last_modified_date TIMESTAMP NOT NULL,
created_date TIMESTAMP NOT NULL,
PRIMARY KEY (id)
);

-- -----------------------------------------------------
-- Table `cms_archive_article`
-- -----------------------------------------------------

DROP TABLE IF EXISTS cms_archive_article;

CREATE TABLE IF NOT EXISTS cms_archive_article (
archive_id INT(10) NOT NULL,
article_id INT(10) NOT NULL,
FOREIGN KEY (archive_id) REFERENCES cms_archive(id),
FOREIGN KEY (article_id) REFERENCES cms_article(id)
);

-- -----------------------------------------------------
-- Table `cms_image`
-- -----------------------------------------------------

DROP TABLE IF EXISTS cms_image;

CREATE TABLE cms_image(
id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
image_url VARCHAR(30) NOT NULL,
description VARCHAR(1000),
last_modified_date TIMESTAMP(23,10) NOT NULL,
created_date TIMESTAMP(23,10) NOT NULL,
deleted TINYINT(3) NOT NULL,
PRIMARY KEY (`id`)
);


-- -----------------------------------------------------
-- Table `cms_link`
-- -----------------------------------------------------

DROP TABLE IF EXISTS cms_link;

CREATE TABLE cms_link(
id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
url VARCHAR(80) NOT NULL,
status TINYINT(1),
last_modified_date TIMESTAMP(23,10) NOT NULL,
created_date TIMESTAMP(23,10) NOT NULL,
PRIMARY KEY (`id`)
);