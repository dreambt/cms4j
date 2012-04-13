CREATE SCHEMA IF NOT EXISTS `cms4j_mybatis` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cms4j_mybatis` ;

-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_category` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_category` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT COMMENT '栏目ID' ,
  `father_category_id` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '上级栏目ID' ,
  `category_name` VARCHAR(255) NOT NULL COMMENT '栏目名称' ,
  `display_order` MEDIUMINT(8) NOT NULL DEFAULT 1 COMMENT '显示顺序' ,
  `show_type` VARCHAR(20) NOT NULL DEFAULT 0 COMMENT '显示方式' ,
  `url` VARCHAR(80) NOT NULL DEFAULT 0 COMMENT '自定义链接地址' ,
  `description` TEXT NOT NULL COMMENT 'SEO描述' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '文章数' ,
  `allow_publish` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否允许发布文章' ,
  `show_nav` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否显示在导航栏' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否关闭' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_upid_catid` (`father_category_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '栏目表';


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_article` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子ID' ,
  `user_id` MEDIUMINT(8) NOT NULL COMMENT '用户id' ,
  `category_id` VARCHAR(80) NOT NULL COMMENT '分类id' ,
  `subject` VARCHAR(80) NOT NULL COMMENT '标题' ,
  `message` MEDIUMTEXT NOT NULL COMMENT '帖子内容' ,
  `digest` VARCHAR(255) NOT NULL ,
  `keyword` VARCHAR(255) NOT NULL DEFAULT 0 COMMENT '帖子标签' ,
  `top` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否是首贴' ,
  `rate` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '评分分数' ,
  `rate_times` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '评分次数' ,
  `views` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '浏览次数' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否允许点评' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '帖子审核状态' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已删除' ,
  PRIMARY KEY (`id`),
  INDEX `fk_cms_article_user` (`user_id` ASC),
  INDEX `fk_cms_artical_category` (`category_id` ASC)
)ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '文章表';

-- DELIMITER $$
-- DROP FUNCTION IF EXISTS `nextval` $$
-- CREATE DEFINER=`cms4j`@`%` FUNCTION `nextval`(seq_name VARCHAR(50)) RETURNS TINYINT(3)
-- BEGIN
--  UPDATE cms_article
--  SET views = views + 1
--  WHERE id = seq_name;
--  RETURN views;
-- END $$
-- DELIMITER;

-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_user` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_user` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id' ,
  `group_id` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT '用户组id' ,
  `email` VARCHAR(40) NOT NULL COMMENT '电子邮箱' ,
  `username` VARCHAR(40) NOT NULL COMMENT '用户名' ,
  `password` VARCHAR(40) NOT NULL COMMENT '密码' ,
  `salt` VARCHAR(16) NOT NULL COMMENT '密码加强' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '用户状态0未审核1已审核' ,
  `email_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '邮箱验证状态 未认证= 0 认证= 1' ,
  `avatar_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否有头像 0没有 1有' ,
  `photo_url` VARCHAR(40) NOT NULL DEFAULT '/default.jpg' COMMENT '头像地址' ,
  `time_offset` VARCHAR(4) NOT NULL DEFAULT '0800' COMMENT '时区' ,
  `last_ip` INT(10) NOT NULL ,
  `last_time` DATETIME NOT NULL DEFAULT 0 COMMENT '注册时间' ,
  `last_act_time` DATETIME NOT NULL DEFAULT 0 ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`),
  INDEX `fk_cms_user_group` (`group_id` ASC)
)ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_comment` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_comment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID' ,
  `article_id` MEDIUMINT(8) NOT NULL ,
  `username` VARCHAR(255) NOT NULL COMMENT '用户名' ,
  `message` TEXT NOT NULL COMMENT '评论内容' ,
  `post_ip` INT(10) NOT NULL COMMENT '评论IP' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=未审核 1=已审核  2=可删除' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_comment_cms_artical1` (`article_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_manage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_manage_log` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_manage_log` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理日志ID' ,
  `user_id` MEDIUMINT(8) NOT NULL ,
  `action` TINYINT(1) NOT NULL COMMENT '0=创建菜单 1=修改菜单 2=移动菜单 3=删除菜单 4=发表文章 5=修改文章 6=审核文章 7=删除文章 8=添加用户 9=修改用户信息 10=审核用户 11=删除用户' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_log_cms_user1` (`user_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_group` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_group` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_name` VARCHAR(40) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_user_group` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_user_group` (
  `user_id` MEDIUMINT(8) NOT NULL ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_user_group_cms_user1` (`user_id` ASC) ,
  INDEX `fk_cms_user_group_cms_group1` (`group_id` ASC) ,
  PRIMARY KEY (`user_id`, `group_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_group_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_group_permission` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_group_permission` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  `permission` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_group_permission_cms_group1` (`group_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_archive` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_archive` (
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `article_count` TINYINT(3) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_archive_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_archive_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_archive_article` (
  `archive_id` MEDIUMINT(8) NOT NULL ,
  `category_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_archive_article_cms_archive1` (`archive_id` ASC) ,
  INDEX `fk_cms_archive_article_cms_category1` (`category_id` ASC) ,
  PRIMARY KEY (`archive_id`, `category_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_image` ;

CREATE  TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_image` (
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `image_url` VARCHAR(80) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `show_index` TINYINT(1) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;

-- -----------------------------------------------------
-- Table `cms4j_mybatis`.`cms_link`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `cms4j_mybatis`.`cms_link`;

CREATE TABLE IF NOT EXISTS `cms4j_mybatis`.`cms_link` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `url` VARCHAR(80) NOT NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=未审核 1=已审核' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (id) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;



-- -----------------------------------------------------
-- 用户测试数据
-- -----------------------------------------------------
INSERT INTO `cms_user`(`id`, `group_id`, `email`, `username`, `password`, `salt`, `status`, `email_status`, `avatar_status`, `photo_url`, `time_offset`, `last_ip`, `last_time`, `last_act_time`, `last_modified_date`, `created_date`, `deleted`) VALUES (1,1,'dreambt@126.com','纪柏涛','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f',1,1,0,'male.gif','0800',134744072,'1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00',1);


-- -----------------------------------------------------
-- 用户组测试数据
-- -----------------------------------------------------
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (1,'后台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (2,'前台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (3,'自由撰稿人');


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

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (26,1,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (27,1,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (28,1,"gallery:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (29,1,"gallery:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (30,1,"gallery:list");

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

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (56,2,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (57,2,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (58,2,"gallery:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (59,2,"gallery:delete");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (60,2,"gallery:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (62,3,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (63,3,"user:save");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (66,3,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (67,3,"article:edit");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (68,3,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (70,3,"article:list");


-- -----------------------------------------------------
-- 分类测试数据
-- -----------------------------------------------------
INSERT INTO `cms_category` (`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `show_nav`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, '公告', 1, 'NONE', 'index', '无', 0, 1, 0, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(2, 1, '中心概况', 10, 'NONE', '', '本中心的最新新闻资讯', 1, 1, 1, '2012-04-07 08:30:17', '2012-03-22 15:58:00', 0),
(3, 3, '中心简介', 11, 'LIST', '', '中心简介', 1, 1, 1, '2012-04-07 08:42:41', '2012-03-22 15:58:00', 0),
(4, 3, '组织结构', 12, 'LIST', '', '组织结构', 1, 1, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0),
(5, 1, '学术团队', 20, 'DIGEST', '', '本中心长期提供培训课程', 1, 1, 1, '2012-04-07 12:24:15', '2012-03-22 15:58:00', 0),
(6, 1, '学术研究', 30, 'NONE', '', '活动相册', 0, 1, 1, '2012-04-07 12:24:43', '2012-03-22 15:58:00', 0),
(7, 1, '资讯服务', 40, 'NONE', 'about', '关于我们', 0, 0, 1, '2012-04-07 12:25:15', '2012-03-22 15:58:00', 0),
(8, 1, '教育培训', 50, 'NONE', '', '', 0, 0, 1, '2012-04-07 12:25:16', '2012-04-07 08:31:17', 0),
(9, 1, '交流合作', 60, 'NONE', '', '', 0, 1, 1, '2012-04-07 08:31:51', '2012-04-07 08:31:51', 0),
(10, 3, '运作机制', 13, 'LIST', '', '', 0, 1, 1, '2012-04-07 08:43:22', '2012-04-07 08:43:22', 0),
(11, 6, '学术带头人', 21, 'NONE', '', '', 0, 1, 1, '2012-04-07 08:49:57', '2012-04-07 08:49:57', 0),
(12, 6, '学术骨干', 22, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:51:08', '2012-04-07 08:50:25', 0),
(13, 6, '专家指导委员会', 23, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:51:53', '2012-04-07 08:51:53', 0),
(14, 6, '专家顾问', 24, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:52:14', '2012-04-07 08:52:14', 0),
(15, 7, '研究方向', 31, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:52:33', '2012-04-07 08:52:33', 0),
(16, 7, '科研成果', 32, 'CONTENT', '', '', 0, 1, 1, '2012-04-07 08:52:49', '2012-04-07 08:52:49', 0),
(17, 7, '科研项目', 33, 'DIGEST', '', '', 1, 1, 1, '2012-04-07 08:53:09', '2012-04-07 08:53:09', 0),
(18, 7, '学术活动', 34, 'DIGEST', '', '', 1, 1, 1, '2012-04-07 08:56:05', '2012-04-07 08:56:05', 0),
(19, 8, '财政税务', 41, 'LIST', '', '', 0, 1, 1, '2012-04-07 08:57:31', '2012-04-07 08:57:31', 0),
(20, 8, '中小银行', 42, 'LIST', '', '', 0, 1, 1, '2012-04-07 08:57:44', '2012-04-07 08:57:44', 0),
(21, 8, '证券保险', 43, 'LIST', '', '', 0, 1, 1, '2012-04-07 08:58:00', '2012-04-07 08:58:00', 0),
(22, 8, '政府决策', 44, 'LIST', '', '', 0, 1, 1, '2012-04-07 08:58:15', '2012-04-07 08:58:15', 0),
(23, 10, '成果转化', 61, 'LIST', '', '', 1, 1, 1, '2012-04-07 08:58:46', '2012-04-07 08:58:46', 0),
(24, 10, '合作伙伴', 62, 'ALBUM', '', '', 0, 1, 1, '2012-04-07 08:59:07', '2012-04-07 08:59:07', 0),
(25, 10, '对外交流', 63, 'ALBUM', '', '', 0, 1, 1, '2012-04-07 08:59:29', '2012-04-07 08:59:29', 0);

-- -----------------------------------------------------
-- 文章测试数据
-- -----------------------------------------------------
INSERT INTO `cms_article` (`id`, `user_id`, `category_id`, `subject`, `message`, `digest`, `keyword`, `top`, `rate`, `rate_times`, `views`, `allow_comment`, `status`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(2, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(3, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(4, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(5, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(6, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(7, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(8, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(9, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(10, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(11, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(12, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(13, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(14, 1, '1', '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0);

-- -----------------------------------------------------
-- 评论测试数据
-- -----------------------------------------------------
INSERT INTO `cms_comment` (`id`, `article_id`, `username`, `message`, `post_ip`, `status`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(2, 1, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0),
(3, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(4, 1, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0),
(5, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(6, 2, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0),
(7, 1, 'dreambt@126.com', '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif" border="0" hspace="0" vspace="0" />美文~<br /></p>', 2130706433, 0, '2012-04-04 02:11:45', '2012-04-04 02:11:45', 0),
(8, 1, 'dreambt@126.com', '<p>拜读~<img src="http://img.baidu.com/hi/jx2/j_0008.gif" border="0" hspace="0" vspace="0" /><br /></p>', 2130706433, 0, '2012-04-04 02:11:55', '2012-04-04 02:11:55', 0);


-- -----------------------------------------------------
-- 相册测试数据
-- -----------------------------------------------------
INSERT INTO `cms_image` (`id`, `title`, `image_url`, `description`, `show_index`, `last_modified_date`, `created_date`) VALUES
(1, 'a1a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(2, 'a2a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(3, 'a3a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(4, 'a4a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(5, 'a5a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(6, 'a6a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(7, 'a7a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(8, 'a8a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(9, 'a9a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(10, '0aa', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(11, '1aa', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(12, '2aa', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(13, 'a3a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(14, 'a4a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(15, 'a5a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(16, 'a6a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(17, 'a7a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(18, 'a8a', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(19, 'a9a', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(20, '0aa', '13335361515150Ji9VY.jpg', 'aa', '0', '2012-04-04 10:42:31', '2012-04-04 10:42:31'),
(21, '1aa', '13335361515150Ji9VY.jpg', 'aa', '1', '2012-04-04 10:42:31', '2012-04-04 10:42:31');

-- -----------------------------------------------------
-- 友情链接测试数据
-- -----------------------------------------------------
INSERT INTO `cms_link` (`id`, `title`, `url`, `status`, `last_modified_date`, `created_date`) VALUES
(1,'百度一下1','http://www.baidu.com','1', null, null),
(2,'百度一下2','http://www.baidu.com','1', null, null),
(3,'百度一下3','http://www.baidu.com','1', null, null),
(4,'百度一下4','http://www.baidu.com','1', null, null),
(5,'百度一下5','http://www.baidu.com','1', null, null),
(6,'百度一下6','http://www.baidu.com','1', null, null),
(7,'百度一下7','http://www.baidu.com','1', null, null),
(8,'百度一下8','http://www.baidu.com','1', null, null),
(9,'百度一下9','http://www.baidu.com','1', null, null),
(10,'百度一下10','http://www.baidu.com','1', null, null),
(11,'百度一下11','http://www.baidu.com','1', null, null),
(12,'谷歌','http://www.google.com.hk','1',null, null);