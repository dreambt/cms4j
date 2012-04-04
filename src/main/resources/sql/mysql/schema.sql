CREATE SCHEMA IF NOT EXISTS `cms4j` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cms4j` ;

-- -----------------------------------------------------
-- Table `cms4j`.`cms_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_category` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_category` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT COMMENT '栏目ID' ,
  `father_category_id` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '上级栏目ID' ,
  `category_name` VARCHAR(255) NOT NULL COMMENT '栏目名称' ,
  `display_order` MEDIUMINT(8) NOT NULL DEFAULT 1 COMMENT '是否允许评论' ,
  `show_type` VARCHAR(20) NOT NULL DEFAULT 0 COMMENT '显示方式0列表1摘要2正文3相册' ,
  `url` VARCHAR(80) NOT NULL DEFAULT 0 COMMENT '自定义链接地址' ,
  `description` TEXT NOT NULL COMMENT 'SEO描述' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '文章数' ,
  `allow_publish` TINYINT(1) NOT NULL COMMENT '是否允许发布文章' ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否关闭' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_upid_catid` (`father_category_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '栏目表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_article` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子ID' ,
  `author` VARCHAR(15) NOT NULL COMMENT '用户名' ,
  `category_name` VARCHAR(80) NOT NULL ,
  `subject` VARCHAR(80) NOT NULL COMMENT '标题' ,
  `message` MEDIUMTEXT NOT NULL COMMENT '帖子内容' ,
  `digest` VARCHAR(255) NOT NULL ,
  `keyword` VARCHAR(255) NOT NULL DEFAULT 0 COMMENT '帖子标签' ,
  `top` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否是首贴' ,
  `rate` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '评分分数' ,
  `rate_times` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '评分次数' ,
  `views` TINYINT(3) NOT NULL ,
  `count` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '浏览次数' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否存在点评' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '帖子审核状态' ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已删除' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '文章表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_user` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_user` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id' ,
  `email` VARCHAR(40) NOT NULL COMMENT '电子邮箱' ,
  `username` VARCHAR(40) NOT NULL COMMENT '用户名' ,
  `password` VARCHAR(40) NOT NULL COMMENT '密码' ,
  `salt` VARCHAR(16) NOT NULL COMMENT '密码加强' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '用户状态0未审核1已审核' ,
  `email_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '邮箱验证状态 未认证= 0 认证= 1' ,
  `avatar_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否有头像 0没有 1有' ,
  `photourl` VARCHAR(40) NOT NULL DEFAULT '/default.jpg' COMMENT '头像地址' ,
  `time_offset` VARCHAR(4) NOT NULL DEFAULT '0800' COMMENT '时区' ,
  `lastip` INT(10) NOT NULL ,
  `last_time` DATETIME NOT NULL DEFAULT 0 COMMENT '注册时间' ,
  `last_act_time` DATETIME NOT NULL DEFAULT 0 ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_comment` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_comment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID' ,
  `article_id` MEDIUMINT(8) NOT NULL ,
  `username` VARCHAR(255) NOT NULL COMMENT '用户名' ,
  `message` TEXT NOT NULL COMMENT '评论内容' ,
  `post_ip` INT(10) NOT NULL COMMENT '评论IP' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=未审核 1=已审核  2=可删除' ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_comment_cms_artical1` (`article_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_manage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_manage_log` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_manage_log` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理日志ID' ,
  `user_id` MEDIUMINT(8) NOT NULL ,
  `action` TINYINT(1) NOT NULL COMMENT '0=创建菜单 1=修改菜单 2=移动菜单 3=删除菜单 4=发表文章 5=修改文章 6=审核文章 7=删除文章 8=添加用户 9=修改用户信息 10=审核用户 11=删除用户' ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_log_cms_user1` (`user_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_group` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_group` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_name` VARCHAR(40) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_user_group` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_user_group` (
  `user_id` MEDIUMINT(8) NOT NULL ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_user_group_cms_user1` (`user_id` ASC) ,
  INDEX `fk_cms_user_group_cms_group1` (`group_id` ASC) ,
  PRIMARY KEY (`user_id`, `group_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_group_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_group_permission` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_group_permission` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  `permission` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_group_permission_cms_group1` (`group_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_user_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_user_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_user_article` (
  `user_id` MEDIUMINT(8) UNSIGNED NOT NULL ,
  `article_id` MEDIUMINT(8) UNSIGNED NOT NULL ,
  INDEX `fk_cms_user_article_cms_user1` (`user_id` ASC) ,
  INDEX `fk_cms_user_article_cms_article1` (`article_id` ASC) ,
  PRIMARY KEY (`user_id`, `article_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_category_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_category_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_category_article` (
  `category_id` MEDIUMINT(8) NOT NULL ,
  `article_id` MEDIUMINT(8) UNSIGNED NOT NULL ,
  INDEX `fk_cms_category_article_cms_category1` (`category_id` ASC) ,
  INDEX `fk_cms_category_article_cms_article1` (`article_id` ASC) ,
  PRIMARY KEY (`category_id`, `article_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_archive` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_archive` (
  `id` MEDIUMINT(8) NOT NULL ,
  `title` VARCHAR(40) NOT NULL ,
  `article_count` TINYINT(3) NOT NULL ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_archive_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_archive_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_archive_article` (
  `archive_id` MEDIUMINT(8) NOT NULL ,
  `category_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_archive_article_cms_archive1` (`archive_id` ASC) ,
  INDEX `fk_cms_archive_article_cms_category1` (`category_id` ASC) ,
  PRIMARY KEY (`archive_id`, `category_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_image` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_image` (
  `id` MEDIUMINT(8) NOT NULL ,
  `title` VARCHAR(40) NOT NULL ,
  `image_url` VARCHAR(80) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `modify_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `create_time` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;



-- -----------------------------------------------------
-- 用户测试数据
-- -----------------------------------------------------
INSERT INTO `cms_user`(`id`, `email`, `username`, `password`, `salt`, `status`, `email_status`, `avatar_status`, `photourl`, `time_offset`, `lastip`, `last_time`, `last_act_time`, `modify_time`, `create_time`, `deleted`) VALUES (1,'dreambt@126.com','纪柏涛','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f',1,1,0,'male.gif','0800',134744072,'1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00',1);

-- -----------------------------------------------------
-- 用户组测试数据
-- -----------------------------------------------------
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (1,'后台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (2,'前台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (3,'自由撰稿人');

-- -----------------------------------------------------
-- 用户-用户组测试数据
-- -----------------------------------------------------
INSERT INTO `cms_user_group`(`user_id`, `group_id`) VALUES (1,1);

-- -----------------------------------------------------
-- 用户组权限测试数据
-- -----------------------------------------------------
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (1,1,"user:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (2,1,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (3,1,"user:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (4,1,"user:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (5,1,"user:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (6,1,"group:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (7,1,"group:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (8,1,"group:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (9,1,"group:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (10,1,"group:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (11,1,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (12,1,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (13,1,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (14,1,"article:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (15,1,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (16,1,"comment:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (17,1,"comment:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (18,1,"comment:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (19,1,"comment:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (20,1,"comment:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (21,1,"category:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (22,1,"category:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (23,1,"category:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (24,1,"category:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (25,1,"category:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (32,1,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (33,1,"user:save");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (36,2,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (37,2,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (38,2,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (39,2,"article:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (40,2,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (41,2,"comment:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (42,2,"comment:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (43,2,"comment:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (44,2,"comment:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (45,2,"comment:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (62,3,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (63,1,"user:save");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (66,3,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (67,3,"article:edit");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (68,3,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (70,3,"article:list");

-- -----------------------------------------------------
-- 分类测试数据
-- -----------------------------------------------------
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (1,1,'首页',1,'NONE','index','无',0,0,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (2,1,'新闻报道',10,'NONE','','本中心的最新新闻资讯',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (3,2,'校内新闻',11,'LIST','','444',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (4,2,'校外报道',12,'LIST','','555',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (5,1,'培训课程',20,'DIGEST','','本中心长期提供培训课程',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (6,1,'活动相册',30,'GALLERY','','活动相册',0,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `modify_time`, `create_time`, `deleted`) VALUES (7,1,'关于我们',40,'NONE','about','关于我们',0,0,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);


