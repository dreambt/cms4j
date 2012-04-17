CREATE SCHEMA IF NOT EXISTS `cms4j_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cms4j_dev` ;

-- -----------------------------------------------------
-- Table `cms_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_category` ;

CREATE  TABLE IF NOT EXISTS `cms_category` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT COMMENT '栏目ID' ,
  `father_category_id` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '上级栏目ID' ,
  `category_name` VARCHAR(255) NOT NULL COMMENT '栏目名称' ,
  `display_order` SMALLINT(6) NOT NULL DEFAULT 1 COMMENT '显示顺序' ,
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
-- Table `cms_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_article` ;

CREATE  TABLE IF NOT EXISTS `cms_article` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子ID' ,
  `user_id` MEDIUMINT(8) NOT NULL COMMENT '用户id' ,
  `category_id` MEDIUMINT(8) NOT NULL COMMENT '分类id' ,
  `subject` VARCHAR(80) NOT NULL COMMENT '标题' ,
  `message` MEDIUMTEXT NOT NULL COMMENT '帖子内容' ,
  `image_name` VARCHAR(50) NOT NULL COMMENT '文章图片',
  `digest` VARCHAR(255) NOT NULL ,
  `keyword` VARCHAR(255) NOT NULL DEFAULT 0 COMMENT '帖子标签' ,
  `top` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否是首贴' ,
  `rate` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '评分分数' ,
  `rate_times` INT(11) NOT NULL DEFAULT 0 COMMENT '评分次数' ,
  `views` INT(11) NOT NULL DEFAULT 0 COMMENT '浏览次数' ,
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
-- Table `cms_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user` ;

CREATE  TABLE IF NOT EXISTS `cms_user` (
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
-- Table `cms_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_comment` ;

CREATE  TABLE IF NOT EXISTS `cms_comment` (
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
-- Table `cms_manage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_manage_log` ;

CREATE  TABLE IF NOT EXISTS `cms_manage_log` (
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
-- Table `cms_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_group` ;

CREATE  TABLE IF NOT EXISTS `cms_group` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_name` VARCHAR(40) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_user_group` ;

CREATE  TABLE IF NOT EXISTS `cms_user_group` (
  `user_id` MEDIUMINT(8) NOT NULL ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_user_group_cms_user1` (`user_id` ASC) ,
  INDEX `fk_cms_user_group_cms_group1` (`group_id` ASC) ,
  PRIMARY KEY (`user_id`, `group_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_group_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_group_permission` ;

CREATE  TABLE IF NOT EXISTS `cms_group_permission` (
  `id` MEDIUMINT(8) NOT NULL AUTO_INCREMENT ,
  `group_id` MEDIUMINT(8) NOT NULL ,
  `permission` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cms_group_permission_cms_group1` (`group_id` ASC) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_archive` ;

CREATE  TABLE IF NOT EXISTS `cms_archive` (
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `article_count` TINYINT(3) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_archive_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_archive_article` ;

CREATE  TABLE IF NOT EXISTS `cms_archive_article` (
  `archive_id` MEDIUMINT(8) NOT NULL ,
  `category_id` MEDIUMINT(8) NOT NULL ,
  INDEX `fk_cms_archive_article_cms_archive1` (`archive_id` ASC) ,
  INDEX `fk_cms_archive_article_cms_category1` (`category_id` ASC) ,
  PRIMARY KEY (`archive_id`, `category_id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;


-- -----------------------------------------------------
-- Table `cms_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_image` ;

CREATE  TABLE IF NOT EXISTS `cms_image` (
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
-- Table `cms_link`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms_link`;

CREATE TABLE IF NOT EXISTS `cms_link` (
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
INSERT INTO `cms_user`(`id`, `group_id`, `email`, `username`, `password`, `salt`, `status`, `email_status`, `avatar_status`, `photo_url`, `time_offset`, `last_ip`, `last_time`, `last_act_time`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, 'dreambt@126.com', '纪柏涛', '691b14d79bf0fa2215f155235df5e670b64394cc', '7efbd59d9741d34f', 1, 1, 0, 'male.gif', '0800', 134744072, '1987-06-01 00:00:00', '1987-06-01 00:00:00', '2012-04-16 10:46:32', '1987-05-31 15:00:00', 0),
(2, 2, '710218922@qq.com', '赵鹏飞', 'e0187004dc8922474e31615e0f081215770d33d8', '7b804c22dd500387', 1, 0, 0, 'default.jpg', '0800', 134744072, '2012-04-16 18:00:06', '2012-04-16 18:00:06', '2012-04-16 11:20:12', '2012-04-16 10:00:19', 0),
(3, 1, '826323891@qq.com', '董鹏飞', '42e491c7dff86230fb1b2fe6f1c182292a82109e', '2aa8b8f1b5d2e8c6', 1, 0, 0, 'default.jpg', '0800', 134744072, '2012-04-16 18:47:40', '2012-04-16 18:47:40', '2012-04-16 11:22:07', '2012-04-16 10:47:44', 0),
(4, 1, '824688439@qq.com', '邓小兰', 'bac8462ba982939fca5968edb101394bcc8ac019', '5e6ec7e5a0bbedb9', 1, 0, 0, 'default.jpg', '0800', 134744072, '2012-04-16 18:49:05', '2012-04-16 18:49:05', '2012-04-16 11:22:05', '2012-04-16 10:49:04', 0),
(5, 3, 'dreambt@qq.com', '思奇', '7c51c17e02655a049c8cee5b890eb111985777c7', '414c189c02c729dc', 1, 0, 0, 'default.jpg', '0800', 134744072, '2012-04-16 18:49:17', '2012-04-16 18:49:17', '2012-04-16 11:22:05', '2012-04-16 10:49:16', 0);


-- -----------------------------------------------------
-- 用户组测试数据
-- -----------------------------------------------------
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (1,'后台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (2,'前台管理员');
INSERT INTO `cms_group`(`id`, `group_name`) VALUES (3,'自由撰稿人');


-- -----------------------------------------------------
-- 用户组权限测试数据
-- -----------------------------------------------------
-- 后台管理员
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (1,1,"user:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (2,1,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (3,1,"user:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (5,1,"user:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (6,1,"group:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (7,1,"group:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (8,1,"group:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (10,1,"group:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (11,1,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (12,1,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (13,1,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (15,1,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (18,1,"comment:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (20,1,"comment:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (21,1,"category:list");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (22,1,"link:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (26,1,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (27,1,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (28,1,"gallery:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (30,1,"gallery:list");

-- 前台管理员
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (31,2,"user:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (32,2,"user:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (33,2,"user:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (34,2,"user:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (36,2,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (37,2,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (38,2,"article:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (40,2,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (43,2,"comment:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (45,2,"comment:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (51,2,"link:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (56,2,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (57,2,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (58,2,"gallery:save");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (59,2,"gallery:list");

-- 自由撰稿人
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (62,3,"user:edit");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (66,3,"article:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (67,3,"article:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (70,3,"article:list");

INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (71,3,"gallery:create");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (72,3,"gallery:edit");
INSERT INTO `cms_group_permission`(`id`, `group_id`, `permission`) VALUES (75,3,"gallery:list");



-- -----------------------------------------------------
-- 分类测试数据
-- -----------------------------------------------------
INSERT INTO `cms_category` (`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `show_nav`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, '系统公告', 0, 'NONE', 'index', '系统公告', 0, 1, 0, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),

(2, 1, '新闻资讯', 2, 'NONE', '', '获取最新的新闻资讯', 0, 0, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(3, 2, '新闻动态', 4, 'LIST', '', '新闻动态', 1, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(4, 2, '行业资讯', 6, 'LIST', '', '行业资讯', 1, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),
(5, 2, '学术交流', 8, 'LIST', '', '学术交流', 1, 1, 1, '2012-03-22 15:58:00', '2012-03-22 15:58:00', 0),

(6, 1, '关于我们', 10, 'NONE', '', '关于我们', 0, 0, 1, '2012-04-07 08:30:17', '2012-03-22 15:58:00', 0),
(7, 6, '中心简介', 12, 'CONTENT', '3', '中心简介', 0, 1, 1, '2012-04-07 08:42:41', '2012-03-22 15:58:00', 0),
(8, 6, '组织结构', 14, 'CONTENT', '4', '组织结构', 0, 1, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0),
(9, 6, '运作机制', 16, 'CONTENT', '5', '运作机制', 0, 1, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0),

(11, 1, '专家团队', 20, 'NONE', '', '专家团队', 0, 0, 1, '2012-04-07 12:24:15', '2012-03-22 15:58:00', 0),
(12, 11, '学术带头人', 22, 'CONTENT', '6', '学术带头人', 0, 1, 1, '2012-04-07 08:49:57', '2012-04-07 08:49:57', 0),
(13, 11, '学术骨干', 24, 'CONTENT', '7', '学术骨干', 0, 1, 1, '2012-04-07 08:51:08', '2012-04-07 08:50:25', 0),
(14, 11, '专家顾问', 26, 'CONTENT', '', '专家顾问', 0, 1, 1, '2012-04-07 08:52:14', '2012-04-07 08:52:14', 0),

(15, 1, '学术研究', 30, 'NONE', '', '学术研究', 0, 0, 1, '2012-04-07 12:24:43', '2012-03-22 15:58:00', 0),
(16, 15, '研究方向', 32, 'CONTENT', '8', '研究方向', 0, 1, 1, '2012-04-07 08:52:33', '2012-04-07 08:52:33', 0),
(17, 15, '科研成果', 34, 'CONTENT', '9', '科研成果', 1, 1, 1, '2012-04-07 08:52:49', '2012-04-07 08:52:49', 0),

(18, 1, '社会服务', 40, 'NONE', '', '资讯服务', 0, 0, 1, '2012-04-07 12:25:15', '2012-03-22 15:58:00', 0),
(19, 18, '财政税务', 41, 'LIST', '', '财政税务', 1, 1, 1, '2012-04-07 08:57:31', '2012-04-07 08:57:31', 0),
(20, 18, '中小银行', 42, 'LIST', '', '中小银行', 1, 1, 1, '2012-04-07 08:57:44', '2012-04-07 08:57:44', 0),
(21, 18, '证券保险', 43, 'LIST', '', '证券保险', 1, 1, 1, '2012-04-07 08:58:00', '2012-04-07 08:58:00', 0),
(22, 18, '政府决策', 44, 'LIST', '', '政府决策', 1, 1, 1, '2012-04-07 08:58:15', '2012-04-07 08:58:15', 0),

(23, 1, '教育培训', 50, 'NONE', '', '教育培训', 0, 0, 1, '2012-04-07 12:25:16', '2012-04-07 08:31:17', 0),

(24, 1, '产学研合作', 60, 'NONE', '', '产学研合作', 0, 0, 1, '2012-04-07 08:31:51', '2012-04-07 08:31:51', 0),
(25, 24, '成果转化', 62, 'LIST', '', '成果转化', 1, 1, 1, '2012-04-07 08:58:46', '2012-04-07 08:58:46', 0),
(26, 24, '合作伙伴', 64, 'FULL', '11', '合作伙伴', 0, 1, 1, '2012-04-07 08:59:07', '2012-04-07 08:59:07', 0),
(27, 24, '对外交流', 66, 'ALBUM', '', '对外交流', 0, 1, 1, '2012-04-07 08:59:29', '2012-04-07 08:59:29', 0),

(28, 1, '网上办公', 70, 'NONE', '', '网上办公', 0, 0, 1, '2012-04-07 08:53:09', '2012-04-07 08:53:09', 0),
(29, 28, '办公系统', 72, 'LINK', 'http://oa.sdufe.edu.cn/', '办公系统', 0, 0, 1, '2012-04-07 08:53:09', '2012-04-07 08:53:09', 0),
(30, 28, '文件交换', 74, 'LINK', 'http://filex.sdufe.edu.cn/', '文件交换', 0, 0, 1, '2012-04-07 08:56:05', '2012-04-07 08:56:05', 0),
(31, 28, '联系我们', 76, 'NONE', 'about', '联系我们', 1, 0, 1, '2012-04-07 08:43:00', '2012-03-22 15:58:00', 0);

-- -----------------------------------------------------
-- 文章测试数据
-- -----------------------------------------------------
INSERT INTO `cms_article` (`id`, `user_id`, `category_id`, `subject`, `message`, `image_name`, `digest`, `keyword`, `top`, `rate`, `rate_times`, `views`, `allow_comment`, `status`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 1, 3, '北京用友政务领导和专家来本中心交流', '&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;2012&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;年&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;3&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;月&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;27&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;日下午，山东省金融信息工程技术研究中心与北京用友政务软件有限公司合作交流会在本中心举行。中心主任徐如志教授会见了用友政务的总经理周海樯一行。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;会见中，徐如志主任介绍了本中心的基本情况，着重突出了山东财经大学的优势学科，本中心将计算机技术与金融、财税结合的特点，并阐明了本中心&ldquo;产学研&rdquo;一体化的定位，表达了与社会企业开放合作的意愿。用友政务的周海樯总经理也介绍了用友政务的发展概况，业务优势，以及在企业发展中遇到的一些困惑和难题。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;双方的专家和教授就税务信息化方面的热点问题，展开了具有前瞻性和建设性的讨论。最后，双方本着合作共赢、开放发展的理念，就服务支持、客户培训、高端咨询、共建技术平台、合作研究等合作事项，进行了深入的探讨，对于未来的合作达成了初步的共识。&lt;/span&gt;&lt;/p&gt;', '1334474546620.png', '    2012年3月27日下午，山东省金融信息工程技术研究中心与北京用友政务软件有限公司合作交流会在本中心举行。中心主任徐如志教授会见了用友政务的总经理周海樯一行。     会见中，徐如志主任介绍了本中心的基本情况，着重突出了山东财经大学的优势学科，本中心将计算机技术与金融、财税结合的特点，并阐明', '', 0, 0, 0, 6, 1, 1, '2012-04-15 03:40:48', '2012-04-15 02:01:51', 0),
(2, 1, 3, '与山东中孚信息产业股份有限公司见面交流会面交流会面交', '&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;2012&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;年&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;3&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;月&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;28&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;日，山东省金融信息工程技术中心与山东中孚信息产业股份有限公司在本中心会议室举行了合作交流会。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;交流会受到双方的高度重视。本中心主任徐如志率领聂秀山副教授、赵华伟副教授及办公室主任与中孚公司的领导和专家进行了友好的交流会谈。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;交流会伊始，由徐如志主任对山东财经大学的历史沿革、本中心的创建背景、研究方向以及目标定位等方面做了说明，并对近阶段中心已取得的科研成果进行了介绍。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;会上山东中孚和本中心就&lt;/span&gt;&lt;span style=&quot;font-size:19px;background-color:white&quot;&gt;面向金融、财税部门的信息安全培训、咨询等业务的开展，成立信息安全联合实验室以及人才培养&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;等合作事项进行了建设性的探讨。&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:left;&quot;&gt;&lt;span style=&quot;font-size:19px&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;此次会议，增进了双方的友谊和了解，为今后打造更优秀的产学研一体的金融信息工程技术研究中心奠定了良好的基础。&lt;/span&gt;&lt;/p&gt;', '1334474546620.png', '&nbsp;&nbsp;&nbsp;&nbsp;2012年3月28日，山东省金融信息工程技术中心与山东中孚信息产业股份有限公司在本中心会议室举行了合作交流会。 &nbsp;&nbsp;&nbsp;&nbsp;交流会受到双方的高度重视。本中心主任徐如志率领聂秀山副教授、赵华伟副教授及办公室主任与中孚公司的领导和专家进行了友好的交流会谈。 交流会伊始，由徐如志主任对山东财经大学的历', '', 0, 0, 0, 7, 1, 1, '2012-04-15 06:05:21', '2012-04-15 03:32:49', 0),
(3, 1, 7, '中心简介', '&lt;p style=&quot;text-indent:28px;line-height:180%;text-align:left;&quot;&gt;山东省金融信息工程技术研究中心（以下简称&ldquo;中心&rdquo;）依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，为推动我国金融信息化的发展及相关技术的研究而成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训与咨询服务的组织。中心于2010年12月经山东省科技厅批准成立，是省内在金融信息化行业领域唯一的省级工程技术研究中心。&lt;/p&gt;&lt;p style=&quot;text-indent:28px;line-height:180%;text-align:left;&quot;&gt;中心下设计算金融研究所、金融风险管理研究所、金融信息安全研究所等若干个在业务上相对独立的研究所；设金融智能实验室等以理论和技术研究为主的专业实验室与研究室。主要研究金融信息化相关的金融系统分析与设计、信息安全与应急管理、金融信息处理与金融商务智能应用技术及工具。主要的研究方向包括金融服务云计算与应用集成、金融IT风险管理、金融商务智能与客户挖掘、金融信息安全及应急处置技术和金融信用评级系统等。&lt;/p&gt;&lt;p style=&quot;text-indent:28px;line-height:180%;text-align:left;&quot;&gt;目前中心与山东省城商联盟、齐鲁证券等多家金融机构、北京用友、山东舜德数据及加拿大Goitsys等多家国内外企业建立了长期的紧密合作关系。已形成一支由30余人组成的研发团队，其中&ldquo;国家千人计划&rdquo;特聘专家1人，18名博士中5人为来自清华大学、上海交通大学、澳大利亚昆士兰大学、美国Texas州立大学的博士后。独立研究及合作研发的多项成果已成功应用于交通银行、广发银行、恒丰银行、齐鲁银行、德州银行及小额贷款公司等非银行金融机构。2011年获批4项国家自然基金项目4项资助，申报国家发明专利3项。&lt;/p&gt;', '', '山东省金融信息工程技术研究中心（以下简称&ldquo;中心&rdquo;）依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，为推动我国金融信息化的发展及相关技术的研究而成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训与咨询服务的组织。中心于', '', 1, 0, 0, 8, 0, 1, '2012-04-15 07:58:49', '2012-04-15 07:00:56', 0),
(4, 1, 8, '组织结构', '&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;中心下设计算金融研究所、金融风险管理研究所、金融信息安全研究所等若干个在业务上相对独立的研究所；设金融智能实验室等以理论和技术研究为主的专业实验室与研究室。主要研究金融信息化相关的金融系统分析与设计、信息安全与应急管理、金融信息处理与金融商务智能应用技术及工具。研究方向包括金融服务云计算与应用集成、金融IT风险管理、金融商务智能与客户挖掘、金融信息安全及应急处置技术和金融信用评级系统等。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;&amp;nbsp;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/article/article-big/1334474546620.png&quot; title=&quot;1.png&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;&lt;br /&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;/p&gt;', '1334474546620.png', '中心下设计算金融研究所、金融风险管理研究所、金融信息安全研究所等若干个在业务上相对独立的研究所；设金融智能实验室等以理论和技术研究为主的专业实验室与研究室。主要研究金融信息化相关的金融系统分析与设计、信息安全与应急管理、金融信息处理与金融商务智能应用技术及工具。研究方向包括金融服务云计算与应用集成、', '', 1, 0, 0, 12, 0, 1, '2012-04-15 07:58:53', '2012-04-15 07:23:22', 0),
(5, 1, 9, '运作机制', '&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;本中心实行理事会领导下的中心主任负责制。&lt;/p&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;按照《山东省工程技术研究中心管理办法》，实行项目管理，实行&ldquo;机构开放、人员流动、内外联合、竞争创新、&lsquo;产学研&rsquo;一体化&rdquo;的运行机制。&lt;/span&gt;&lt;br /&gt;&lt;/p&gt;&lt;ul style=&quot;list-style-type:&quot;&gt;&lt;li&gt;对外实行设备资源开放、研究项目开放、学术交流开放和人才使用开放。&lt;/li&gt;&lt;li&gt;建立良好的人才流动机制，吸引省内外科技人员携带科研成果进行成果转化。&lt;/li&gt;&lt;li&gt;在机构组建、项目申报、课题研究时强化&ldquo;产学院&rdquo;结合，充分发挥各方优势。&lt;/li&gt;&lt;li&gt;根据国家现行关于技术转让、知识产权等规定，建立互利互惠的开放合作机制。以工程技术研究中心作为科技成果向生产力转化的中间环节，推动金融信息化科技成果向现实生产力的转化。&lt;/li&gt;&lt;/ul&gt;', '', '本中心实行理事会领导下的中心主任负责制。 按照《山东省工程技术研究中心管理办法》，实行项目管理，实行&ldquo;机构开放、人员流动、内外联合、竞争创新、&lsquo;产学研&rsquo;一体化&rdquo;的运行机制。 对外实行设备资源开放、研究项目开放、学术交流开放和人才使用开放。 建立良好的人才流动机制，吸引省内外科技人员携带科研成果进行成', '', 1, 0, 0, 3, 0, 1, '2012-04-15 07:58:05', '2012-04-15 07:27:53', 0),
(6, 1, 12, '学术带头人', '&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;聂培尧教授，工学博士(计算机软件与理论)，博士生/硕士生导师，山东财政学院副院长，计算机信息工程学院教授，博士生指导教师，同时兼任天津大学管理学院博士生导师，山东大学计算机学院博士生导师。英国爱丁堡Napier大学商学院客座教授，美国纽约州立大学Old&amp;nbsp;Westbury学院访问教授。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;中心主任徐如志，博士、教授、博士生导师，美国ArizonaState&amp;nbsp;University访问教授，IEEE会员，中国云计算专家委员会委员，山东省计算机学会、管理学会常务理事。&amp;nbsp;\r\n&lt;/p&gt;\r\n&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;中心副主任郭建峰，国家&ldquo;千人计划&rdquo;特聘专家，多伦多大学Rotman学院研究员；英国雷丁大学研究员，承担ICMA国际资本协会高频交易研究课题；山东财经大学计算金融研究所所长、特聘教授，山东财经大学金融学院金融学硕士生导师。\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;br /&gt;\r\n&lt;/p&gt;', '', '&nbsp;&nbsp;&nbsp;&nbsp;聂培尧教授，工学博士(计算机软件与理论)，博士生/硕士生导师，山东财政学院副院长，计算机信息工程学院教授，博士生指导教师，同时兼任天津大学管理学院博士生导师，山东大学计算机学院博士生导师。英国爱丁堡Napier大学商学院客座教授，美国纽约州立大学Old&nbsp;Westbury学院访问教授。 &nbsp;&nbsp;&nbsp;', '', 1, 0, 0, 14, 0, 1, '2012-04-15 07:54:10', '2012-04-15 07:32:34', 0),
(7, 1, 13, '学术骨干', '&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;安起光教授，山东财经大学金融学院副院长。&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;田茂圣，山东舜德数据管理软件工程有限公司总经理。&lt;/span&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;杨峰副教授，清华大学博士毕业，硕士生导师。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;赵志崑副教授，&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;工学博士，硕士生导师。澳大利亚中昆士兰大学博士后。多年来一直从事软件体系结构、智能&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;Agent&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;系统、金融信息系统等方面的研究。&lt;/span&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;张抗抗副教授，&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;工学博士，硕士生导师，美国&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;Arizona&amp;nbsp;State&amp;nbsp;University&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;访问学者。多年来一直从事服务计算、信息集成与应用集成及金融云计算综合服务平台等方面的研究。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;林培光副教授，2006年毕业于北京理工大学，获工学博士学位，硕士生导师，香港科技大学访问学者。多年来一直从事Web数据集成及其相关应用以及金融信息管理系统、金融数据挖掘等方面的研究。&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;王帅强&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;赵华伟副教授&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;聂秀山&lt;span style=&quot;background-color:white&quot;&gt;博士，&lt;/span&gt;&lt;span style=&quot;background-color:white&quot;&gt;副教授，毕业于山东大学信息科学与工程学院。近年来主持国家自然基金一项，省两化融合研究课题一项，参与国家&lt;/span&gt;&lt;span style=&quot;font-family:&amp;#39;calibri&amp;#39;,&amp;#39;sans-serif&amp;#39;;background:white&quot;&gt;973&lt;/span&gt;&lt;span style=&quot;background-color:white&quot;&gt;项目和国家自然基金项目多项。主要研究方向为金融信息安全、信息内容安全认证等。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;王倩&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;张晶&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;马孝先&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;黄方亮&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;马玉林&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;谭璐&lt;/p&gt;&lt;p style=&quot;line-height:29px;text-indent:2em;text-align:left;margin-bottom:4px;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;30&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;余人的学术团队中有&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;18&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;名博士，其中&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;5&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;人为来自清华大学、上海交通大学、澳大利亚昆士兰大学、美国&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;Texas&lt;/span&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;州立大学的博士后。此外还有多名在业界具有丰富实战经验的业务咨询顾问和国内外的专兼职专家。&lt;/span&gt;&lt;/p&gt;', '', '安起光教授，山东财经大学金融学院副院长。 田茂圣，山东舜德数据管理软件工程有限公司总经理。 杨峰副教授，清华大学博士毕业，硕士生导师。 赵志崑副教授，工学博士，硕士生导师。澳大利亚中昆士兰大学博士后。多年来一直从事软件体系结构、智能Agent系统、金融信息系统等方面的研究。 张抗抗副教授，工学博士，', '', 1, 0, 0, 2, 0, 1, '2012-04-15 07:33:59', '2012-04-15 07:31:20', 0),
(8, 1, 16, '研究方向', '&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;本中心秉承合作共赢、开放发展的理念，以服务社会、满足市场需求为导向，将计算机技术与财税、金融等优势学科充分结合，与各银行、融资机构在以下四个方向进行战略性的合作研究：&lt;/p&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;（1）金融信息系统&amp;nbsp;&mdash;&amp;nbsp;在新型分布式计算模型、分布式关键技术及其应用及产业化方面开展研究，重点开展基于SaaS和面向服务的金融信息系统软件开发方法；&lt;/p&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;（2）金融数据挖掘&amp;nbsp;&mdash;&amp;nbsp;主要研究大规模数据的分布式存储和检索方法，尤其是面向云计算平台的分布式数据存储，重点开展面向财税金融领域的数据挖掘、分析方法；&lt;/p&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;（3）金融信息安全&amp;nbsp;&mdash;&amp;nbsp;主要研究面向移动商务的物联网技术、网络信息安全、网络优化理论与技术，研究应用于金融领域的网络安全协议，以及网上银行和安全支付等关键技术；&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;（4）网络银行与移动商务&amp;nbsp;&mdash;&amp;nbsp;主要研究金融机构借助网上银行和移动商务平台，将网银与企业财务系统、海关业务系统及电子口岸系统等互联对接，并增加终端数量，扩大技术、设备兼容性等。&lt;/p&gt;', '', '本中心秉承合作共赢、开放发展的理念，以服务社会、满足市场需求为导向，将计算机技术与财税、金融等优势学科充分结合，与各银行、融资机构在以下四个方向进行战略性的合作研究： （1）金融信息系统&nbsp;&mdash;&nbsp;在新型分布式计算模型、分布式关键技术及其应用及产业化方面开展研究，重点开展基于SaaS和面向服务的金融信息系', '', 1, 0, 0, 5, 0, 1, '2012-04-15 08:00:01', '2012-04-15 07:29:45', 0),
(9, 1, 17, '科研成果', '&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;中心注重科研成果的推广转化，独立研究及与合作伙伴共同研发的成果有：&lt;/p&gt;&lt;ul style=&quot;list-style-type:disc;&quot;&gt;&lt;li&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;商业银行资产风险监控系统&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;商业银行押品风险管理系统&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;商业银行授信审批分析及监控系统&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;商业银行贷后监控管理系统&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;商业银行内部评级系统&lt;/p&gt;&lt;/li&gt;&lt;li&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;财务分析及风险预警系统&lt;/p&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p style=&quot;line-height:32px;text-indent:2em;text-align:left;margin:2px 0cm;&quot;&gt;以上科研成果已广泛应用于交通银行、广发银行、恒丰银行、齐鲁银行及小额贷款公司等非银行金融机构。&lt;br /&gt;&lt;/p&gt;', '', '中心注重科研成果的推广转化，独立研究及与合作伙伴共同研发的成果有： 商业银行资产风险监控系统 商业银行押品风险管理系统 商业银行授信审批分析及监控系统 商业银行贷后监控管理系统 商业银行内部评级系统 财务分析及风险预警系统 以上科研成果已广泛应用于交通银行、广发银行、恒丰银行、齐鲁银行及小额贷款公司', '', 1, 0, 0, 10, 0, 1, '2012-04-15 08:00:03', '2012-04-15 07:38:47', 0),
(10, 1, 22, '银监会：继续推进差异化监管政策落地', '&lt;p style=&quot;line-height:24px;text-indent:2em;text-align:left;margin:12px 0cm;&quot;&gt;中国&lt;span style=&quot;color:#000&quot;&gt;银监会&lt;/span&gt;9日启动&ldquo;&lt;span style=&quot;color:#000&quot;&gt;中国银行&lt;/span&gt;业小微企业金融服务成就展暨宣传月活动&rdquo;。银监会主席&lt;span style=&quot;color:#000&quot;&gt;尚福林&lt;/span&gt;在启动仪式上说，银监会将继续推进差异化监管政策落地，敦促银行业金融机构不折不扣地落实好服务实体经济这一基本要求，更好地服务小微企业。&lt;/p&gt;&lt;p style=&quot;line-height:24px;text-indent:2em;text-align:left;margin:12px 0cm;&quot;&gt;尚福林说，银行业的稳健发展离不开实体经济这一基础。支持实体经济发展，小微企业是重头戏。银监会下一步将继续推进差异化监管政策的落地；推动小型金融机构建设，扩大小微企业金融服务覆盖面；确保小微企业&lt;span style=&quot;color:#000&quot;&gt;贷款&lt;/span&gt;实现&ldquo;两个不低于&rdquo;（增速不低于全部贷款平均增速、增量不低于上年同期水平）目标。&lt;/p&gt;&lt;p style=&quot;line-height:24px;text-indent:2em;text-align:left;margin:12px 0cm;&quot;&gt;2008年，银监会提出&ldquo;两个不低于&rdquo;目标，确保对小微企业贷款总量倾斜。2011年，银监会先后出台《关于支持&lt;span style=&quot;color:#000&quot;&gt;商业&lt;/span&gt;银行进一步改进小企业金融服务的通知》及其补充通知，在机构准入、资本占用、存贷比考核、不良贷款容忍度和服务收费等方面，提出了更具体的差别化监管和激励政策，支持银行业金融机构进一步加大对小微企业的&lt;span style=&quot;color:#000&quot;&gt;信贷&lt;/span&gt;支持力度。&lt;/p&gt;&lt;p style=&quot;line-height:24px;text-indent:2em;text-align:left;margin:12px 0cm;&quot;&gt;为敦促银行业金融机构进一步提升小微企业金融服务水平，从4月9日起，银监会在全国范围内开展&ldquo;中国银行业小微企业金融服务成就展暨宣传月活动&rdquo;，活动主题为&ldquo;促小微，惠民生，强金融，兴百业&rdquo;。&lt;/p&gt;&lt;p style=&quot;line-height:24px;text-indent:2em;text-align:left;margin:12px 0cm;&quot;&gt;银监会统计显示，截至2011年末，全国小企业贷款余额为10．8万亿元，约占全部贷款余额的20%，连续3年实现&ldquo;两个不低于&rdquo;目标。&lt;/p&gt;&lt;p style=&quot;line-height:24px;text-indent:2em;text-align:left;margin:12px 0cm;&quot;&gt;同时，小企业贷款质量得到提升。截至2011年末，全国小企业不良贷款余额为2107亿元，比年初减少435亿元；不良贷款率为2．02%，比年初下降0．95个百分点，其中单户授信500万元以下小企业贷款不良率为5．14%。&lt;/p&gt;', '', '中国银监会9日启动&ldquo;中国银行业小微企业金融服务成就展暨宣传月活动&rdquo;。银监会主席尚福林在启动仪式上说，银监会将继续推进差异化监管政策落地，敦促银行业金融机构不折不扣地落实好服务实体经济这一基本要求，更好地服务小微企业。 尚福林说，银行业的稳健发展离不开实体经济这一基础。支持实体经济发展，小微企业是重头', '', 0, 0, 0, 0, 1, 1, '2012-04-15 07:20:03', '2012-04-15 07:19:55', 0),
(11, 1, 26, '合作伙伴', '&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;山东舜德数据管理&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;软件工程有限公司&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;山东华软金盾&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;山东省城商联盟&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;北京用友政务软件有限公司&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;加拿大&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;Goitsys&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;山东中孚&lt;/span&gt;&lt;span style=&quot;font-size:19px&quot;&gt;信息产业股份有限公司&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-size:19px&quot;&gt;山东省农信社&lt;/span&gt;&lt;/p&gt;', '', '山东舜德数据管理软件工程有限公司 山东华软金盾 山东省城商联盟 北京用友政务软件有限公司 加拿大Goitsys 山东中孚信息产业股份有限公司 山东省农信社', '', 1, 0, 0, 29, 0, 0, '2012-04-15 06:53:34', '2012-04-15 03:58:32', 0),
(12, 1, 25, '客户财务分析及预警系统', '&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;客户财务分析及预警系统用于提高商业银行客户风险识别及预警能力，为银行对客户进行客户风险识别、客户评级提供依据。通过财务报表、关注指标、趋势波动、占比结构、宏观行业（地区、机构）的分析，建立全面的客户财务风险识别及预警体系，对客户财务指标进行静态及动态预警；对客户财务报告的虚假数据进行反欺诈识别预警；建立财务综合风险评估模型，计算风险指数，预测客户财务风险变化趋势；建立现金流预测模型，对客户未来的偿债能力（一期或多期）进行预测分析；对客户在银行账户明细数据统计分析，进行现金流量及流向的监控预警。对银行发掘客户潜在风险、加强风险控制、降低贷款不良率提供强有力的支持。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统包含财务经营分析、客户风险预警、数据分析建模三大部分。系统架构如下：&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334542193946fKLjiG.jpg&quot; style=&quot;width:704px;height:499px;&quot; width=&quot;704&quot; height=&quot;499&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;该系统由山东省金融信息工程技术研究中心金融风险管理研究所与合作伙伴山东舜德数据管理公司共同研究开发，已成功应用于工商银行山东省分行、广发银行、齐鲁银行等金融机构。&lt;/p&gt;', '1334542193946fKLjiG.jpg', '客户财务分析及预警系统用于提高商业银行客户风险识别及预警能力，为银行对客户进行客户风险识别、客户评级提供依据。通过财务报表、关注指标、趋势波动、占比结构、宏观行业（地区、机构）的分析，建立全面的客户财务风险识别及预警体系，对客户财务指标进行静态及动态预警；对客户财务报告的虚假数据进行反欺诈识别预警；', '', 0, 0, 0, 0, 1, 1, '2012-04-16 02:12:03', '2012-04-16 02:11:55', 0),
(13, 1, 25, '金融内网安全与网络行为管理系统', '&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;金融内网安全与网络行为管理系统（FISBMS）可实时监测金融机构内网的运行，洞察客户端的一举一动，使得内网安全的诸多隐患得到全面的管理和监控；使得文档更加安全，内网的金融情报和用户数据信息不再担心外泄，几乎封堵了现在能够想到的所有泄密的途径，提供了目前国内最具竞争力的全面内网安全解决方案。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;FISBMS是在采用最新信息安全技术和&ldquo;全面内网安全管理&rdquo;及&ldquo;终端统一威胁管理&rdquo;先进管理理念的基础上推出的创新性的安全产品。它不但全面整合了监控软件、网管软件、加密软件、内网安全等产品的功能，同时吸取Microsoft的网络接入保护(NAP)和Cisco网络准入控制(NA)技术的精髓，创造性地推出软硬件结合的网络接入控制保护系统(NACP)。&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334544034000ufEFKZ.jpg&quot; width=&quot;731&quot; height=&quot;322&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; style=&quot;width:731px;height:322px;&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;NACP系统充分发挥了NAC实施简单、效果显著和NAP控制深入、全面防护的优势，在深刻理解用户的需求和行业发展趋势的基础上，有力规避了金融机构内网安全需要大量手动安装客户端软件、客户端易被破坏，用户体验效果差，软件不能体现自身价值等行业诟病，真正为金融用户构建了一套可信赖，易维护、可网管的全面内网安全管控平台，并据此为金融用户提供了在一个可信网络环境下网络使用的规则和制度。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;FISBMS是由山东省金融信息工程技术研究中心金融信息安全研究所与合作伙伴山东华软金盾公司共同研究开发的全新一代软硬结合的可信内网安全管控平台，属国内首创，已成功应用于工商银行、交通银行等国内各个级别的商业银行和其它金融机构。&lt;/p&gt;', '1334544034000ufEFKZ.jpg', '金融内网安全与网络行为管理系统（FISBMS）可实时监测金融机构内网的运行，洞察客户端的一举一动，使得内网安全的诸多隐患得到全面的管理和监控；使得文档更加安全，内网的金融情报和用户数据信息不再担心外泄，几乎封堵了现在能够想到的所有泄密的途径，提供了目前国内最具竞争力的全面内网安全解决方案。 FISB', '', 0, 0, 0, 0, 1, 1, '2012-04-16 02:41:27', '2012-04-16 02:41:23', 0),
(14, 1, 25, '贷后工作监控管理系统', '&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统针对贷后工作管理较薄弱、流于形式的现状，提供流程化配置管理，对日常贷后检查监控工作是否及时准确提供监督，对工作内容进行考核统计。是将贷后检查监控工作纳入信息化、自动化、流程化、标准化、可监控、可干预的一体自动工作模式。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;全面的贷后日常业务管理。强化贷后检查监控工作的管理及工作的有效性，包括对预警业务处理、上级检查业务、重大事项报告、贷款资金流向监测、客户资金监测、客户财务综合分析、保证能力检查、抵质押能力检查、督办业务处理、间隔期检查在内的各种贷后监测日常业务进行全面跟踪管理。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;及时的信息转发和全面的信息共享。根据客户的贷款额、融资额、企业规模等不同，对其在贷后监测业务中的异常情况进行不同等级的信息转发，第一时间通知相关各级部门和人员。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;预警信息和贷后检查结果信息汇总形成基于业务和工作的综合分析。对所有的日常业务处理信息，系统提供金字塔形式、多维度、多主线的综合查询分析，包括以客户为主线的所有监测业务查询、以人员为单位向岗位、机构汇总，分析工作是否及时到位，可为银行的贷后工作考核统计提供数据支持。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统架构如下：&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334544136043X7BWsW.jpg&quot; style=&quot;width:638px;height:513px;&quot; width=&quot;638&quot; height=&quot;513&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;该系统由山东省金融信息工程技术研究中心与合作伙伴山东舜德数据公司共同研究开发，已成功应用于广发银行、工商银行山东省分行等金融机构。&lt;/p&gt;', '1334544136043X7BWsW.jpg', '系统针对贷后工作管理较薄弱、流于形式的现状，提供流程化配置管理，对日常贷后检查监控工作是否及时准确提供监督，对工作内容进行考核统计。是将贷后检查监控工作纳入信息化、自动化、流程化、标准化、可监控、可干预的一体自动工作模式。 全面的贷后日常业务管理。强化贷后检查监控工作的管理及工作的有效性，包括对预警', '', 0, 0, 0, 0, 1, 1, '2012-04-16 02:43:34', '2012-04-16 02:43:31', 0),
(15, 1, 25, '商业银行经营分析系统', '&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;商业银行在经营管理、决策支持方面面临的数据呈金字塔型。本系统面向商业银行领导以及各级经营决策和经营管理人员，具有对银行经营状况进行常规的查询统计和深入的智能分析等功能。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统分析内容涉及经营管理的方方面面，并从多角度、全方位、深层次分析各种经营指标、风险预警指标。在输出形式上以仪表盘、直方图、饼图、折线图等多种方式展示分析结果。&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/13345460456044gwPbX.jpg&quot; style=&quot;width:679px;height:465px;&quot; width=&quot;679&quot; height=&quot;465&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统基于先进的金融数据建模和WEB开发框架，融合数据ETL技术、多维分析技术与FLASH数据展示技术。&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334546059770Ff6UMM.jpg&quot; style=&quot;width:651px;height:372px;&quot; width=&quot;651&quot; height=&quot;372&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;该系统由山东省金融信息工程技术研究中心与合作伙伴山东舜德数据管理公司共同研究开发，已成功应用于德州银行、临商银行及其他金融机构。&lt;/p&gt;', '13345460456044gwPbX.jpg', '商业银行在经营管理、决策支持方面面临的数据呈金字塔型。本系统面向商业银行领导以及各级经营决策和经营管理人员，具有对银行经营状况进行常规的查询统计和深入的智能分析等功能。 系统分析内容涉及经营管理的方方面面，并从多角度、全方位、深层次分析各种经营指标、风险预警指标。在输出形式上以仪表盘、直方图、饼图、', '', 0, 0, 0, 0, 1, 1, '2012-04-16 03:28:24', '2012-04-16 03:16:21', 0),
(16, 1, 25, '商业银行风险监控系统', '&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;风险监控系统围绕着风险识别，通过建立一系列风险识别工具，搭建风险监控平台，完成风险识别、预警及全过程的风险监控，成为风险管理部门的日常工作平台。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;通过风险监控系统将商业银行目前分散的、欠缺的风险监控、预警等管理工作&ldquo;落地&rdquo;，通过该系统提供一系列的工具、方法和风险管理流程，帮助银行管理人员及时、准确、有效地识别出各项业务存在的风险点和风险预警信号，实现风险关口前移；同时加强风险信息的跟踪处理及监控管理，建立起针对风险预警信号的监测、控制、反馈和化解、责任认定和追究等各环节组成的闭环处理机制，变单向风险监控预警管理为立体式监控预警管理。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统功能架构：&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334546314176lFjEhs.jpg&quot; style=&quot;width:649px;height:377px;&quot; width=&quot;649&quot; height=&quot;377&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;系统逻辑架构：&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334546332132LWaKHC.jpg&quot; style=&quot;width:685px;height:386px;&quot; width=&quot;685&quot; height=&quot;386&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;该系统由山东省金融信息工程技术研究中心金融风险管理研究所与合作伙伴山东舜德数据管理公司共同研究开发，已成功应用于交通银行、广发银行、恒丰银行、齐鲁银行、德州银行、济宁农信（省农信试点单位）。&lt;/p&gt;', '1334546314176lFjEhs.jpg', '风险监控系统围绕着风险识别，通过建立一系列风险识别工具，搭建风险监控平台，完成风险识别、预警及全过程的风险监控，成为风险管理部门的日常工作平台。 通过风险监控系统将商业银行目前分散的、欠缺的风险监控、预警等管理工作&ldquo;落地&rdquo;，通过该系统提供一系列的工具、方法和风险管理流程，帮助银行管理人员及时、准确、', '', 0, 0, 0, 0, 1, 1, '2012-04-16 03:28:23', '2012-04-16 03:26:04', 0),
(17, 1, 25, '客户信用风险评级系统', '&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;客户信用风险评级系统基于Basel&amp;nbsp;II标准框架，以风险数据分析、客户评级模型为基础，为商业银行、担保公司等金融机构的授信决策提供科学依据和决策支持。系统涵盖从数据分析、评级模型建立、模型回测验证、软件实现到应用的全面的评级体系。系统支持传统的打分卡客户评级模型，也支持根据历史数据统计分析的量化评级模型。对于历史违约样本数据不足的客户群，可采取定量加定性的传统打分卡评级模式，对于历史违约样本数据充足的客户群，可采用基于统计的量化评级模型进行评级。&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;评级对象包括商业银行、担保公司等金融机构的法人客户、小企业客户、个人客户等。&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/13345468342229V4Fjj.jpg&quot; style=&quot;width:662px;height:463px;&quot; width=&quot;662&quot; height=&quot;463&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;客户评级模型开发建模&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334546813742XUHiUG.jpg&quot; style=&quot;width:699px;height:449px;&quot; width=&quot;699&quot; height=&quot;449&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;line-height:28px;white-space:normal;background-color:#FFFFFF;text-indent:2em;text-align:left;&quot;&gt;该系统由山东省金融信息工程技术研究中心金融风险管理研究所、信用保险研究所与合作伙伴山东舜德数据管理公司共同研究开发，已成功应用于广发银行、恒丰银行、东莞银行及其它金融机构。&lt;/p&gt;', '13345468342229V4Fjj.jpg', '客户信用风险评级系统基于Basel&nbsp;II标准框架，以风险数据分析、客户评级模型为基础，为商业银行、担保公司等金融机构的授信决策提供科学依据和决策支持。系统涵盖从数据分析、评级模型建立、模型回测验证、软件实现到应用的全面的评级体系。系统支持传统的打分卡客户评级模型，也支持根据历史数据统计分析的量化评级', '', 0, 0, 0, 0, 1, 1, '2012-04-16 03:28:22', '2012-04-16 03:28:20', 0),
(18, 1, 3, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '1334474546620.png', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 0, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0);


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
(1, '教育部高教司司长张大良一行到我校调研', '1334540158151BLPVfp.jpg', '7月16日，教育部高教司司长张大良、高教司办公室主任李平一行来我校对教育规划纲要落实情况开展调研。郝书辰汇报了我校筹建山东财经大学的工作情况，并就学校的办学历史、人才培养、学科建设、师资队伍建设、科学研究及新财大下一步的工作思路等做了介绍。', 1, '2012-04-16 01:36:01', '2012-04-16 01:36:01'),
(2, '教育部高教司司长张大良一行到我校调研', '1334540137638A91Jt9.jpg', '在座谈会上，省教育厅高教处处长宋伯宁向张大良司长一行汇报了我省高等教育发展的总体状况及教育规划纲要的落实情况。听取汇报后，张大良对山东省教育系统落实教育规划纲要的工作给予充分肯定，对即将实施的“名校工程”计划表示赞赏，对我校本科教学工作给予了高度评价。他强调，高等学校要把学习贯彻胡锦涛总书记在清华大学百年校庆上的重要讲话和贯彻落实教育规划纲要紧密结合起来，为推进教育事业科学发展，全面提高高等教育质量作出新贡献。', 1, '2012-04-16 01:35:41', '2012-04-16 01:35:41'),
(3, '教育部高教司司长张大良一行到我校调研', '1334539998859TAW9l5.jpg', '会后，张大良一行在郝书辰、宋伯宁等陪同下，参观了我校明水校区。', 1, '2012-04-16 01:36:01', '2012-04-16 01:36:01'),
(4, '客户财务分析及预警系统', '1334542193946fKLjiG.jpg', '该系统由山东省金融信息工程技术研究中心金融风险管理研究所与合作伙伴山东舜德数据管理公司共同研究开发，已成功应用于工商银行山东省分行、广发银行、齐鲁银行等金融机构。', 0, '2012-04-16 02:09:56', '2012-04-16 02:09:56'),
(5, '金融内网安全与网络行为管理系统', '1334544034000ufEFKZ.jpg', '金融内网安全与网络行为管理系统（FISBMS）可实时监测金融机构内网的运行，洞察客户端的一举一动，使得内网安全的诸多隐患得到全面的管理和监控；使得文档更加安全，内网的金融情报和用户数据信息不再担心外泄，几乎封堵了现在能够想到的所有泄密的途径，提供了目前国内最具竞争力的全面内网安全解决方案。', 0, '2012-04-16 02:40:37', '2012-04-16 02:40:37'),
(6, '贷后工作监控管理系统', '1334544136043X7BWsW.jpg', '系统针对贷后工作管理较薄弱、流于形式的现状，提供流程化配置管理，对日常贷后检查监控工作是否及时准确提供监督，对工作内容进行考核统计。是将贷后检查监控工作纳入信息化、自动化、流程化、标准化、可监控、可干预的一体自动工作模式。', 0, '2012-04-16 02:42:18', '2012-04-16 02:42:18'),
(7, '商业银行经营分析系统', '13345460456044gwPbX.jpg', '商业银行在经营管理、决策支持方面面临的数据呈金字塔型。本系统面向商业银行领导以及各级经营决策和经营管理人员，具有对银行经营状况进行常规的查询统计和深入的智能分析等功能。', 0, '2012-04-16 03:14:07', '2012-04-16 03:14:07'),
(8, '商业银行经营分析系统', '1334546059770Ff6UMM.jpg', '商业银行在经营管理、决策支持方面面临的数据呈金字塔型。本系统面向商业银行领导以及各级经营决策和经营管理人员，具有对银行经营状况进行常规的查询统计和深入的智能分析等功能。', 0, '2012-04-16 03:14:20', '2012-04-16 03:14:20'),
(9, '商业银行风险监控系统', '1334546332132LWaKHC.jpg', '通过风险监控系统将商业银行目前分散的、欠缺的风险监控、预警等管理工作“落地”，通过该系统提供一系列的工具、方法和风险管理流程，帮助银行管理人员及时、准确、有效地识别出各项业务存在的风险点和风险预警信号，实现风险关口前移；同时加强风险信息的跟踪处理及监控管理，建立起针对风险预警信号的监测、控制、反馈和化解、责任认定和追究等各环节组成的闭环处理机制，变单向风险监控预警管理为立体式监控预警管理。', 0, '2012-04-16 03:18:52', '2012-04-16 03:18:52'),
(10, '妹子一枚', '1334541740573XV5Pfx.jpg', '妹子一枚', 0, '2012-04-16 02:02:21', '2012-04-16 02:02:21'),
(11, '妹子一枚', '1334541740573XV5Pfx.jpg', '妹子一枚', 0, '2012-04-16 02:02:21', '2012-04-16 02:02:21'),
(12, '妹子一枚', '1334541740573XV5Pfx.jpg', '妹子一枚', 0, '2012-04-16 02:02:21', '2012-04-16 02:02:21'),
(13, '妹子一枚', '1334541740573XV5Pfx.jpg', '妹子一枚', 0, '2012-04-16 02:02:21', '2012-04-16 02:02:21'),
(14, '妹子一枚', '1334541740573XV5Pfx.jpg', '妹子一枚', 0, '2012-04-16 02:02:21', '2012-04-16 02:02:21');


-- -----------------------------------------------------
-- 友情链接测试数据
-- -----------------------------------------------------
INSERT INTO `cms_link` (`id`, `title`, `url`, `status`, `last_modified_date`, `created_date`) VALUES
(1,'山东财经大学','http://www.sdufi.edu.cn/','1', null, null),
(2,'山东华软金盾','http://www.neiwang.cn/','1', null, null),
(3,'山东舜德数据','http://www.sundatasoft.com/','1', null, null),
(4,'戈尔特西斯','http://www.goitsys.com/','1', null, null),
(5,'山东省城商联盟','','1', null, null),
(6,'山东省农信社','http://www.sdnxs.com/','1', null, null),
(7,'山东财经大学','http://www.sdufi.edu.cn/','1', null, null),
(8,'山东华软金盾','http://www.neiwang.cn/','1', null, null),
(9,'山东舜德数据','http://www.sundatasoft.com/','1', null, null),
(10,'戈尔特西斯','http://www.goitsys.com/','1', null, null),
(11,'山东省城商联盟','','1', null, null),
(12,'山东省农信社','http://www.sdnxs.com/','1', null, null);