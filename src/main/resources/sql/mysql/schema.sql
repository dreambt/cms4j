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
  `category` VARCHAR(20) NOT NULL,
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
(25, 24, '成果转化', 62, 'DIGEST', '', '成果转化', 1, 1, 1, '2012-04-07 08:58:46', '2012-04-07 08:58:46', 0),
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
(18, 1, 3, '山东金融信息工程技术研究中心网站正式启用', '&lt;p&gt;山东省金融信息工程技术研究中心网站正式启用&lt;img src=&quot;http://img.baidu.com/hi/jx2/j_0002.gif&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;', '1334474546620.png', '山东省金融信息工程技术研究中心网站正式启用', '', 0, 0, 0, 0, 1, 1, '2012-04-13 07:14:32', '2012-04-13 07:14:32', 0),
(19, 1, 3, '山东省金融信息工程技术研究中心学术骨干座谈会顺利召开', '&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;为进一步推进学术骨干申请国家自然科学基金的申请工作，提升金融信息工程技术研究中心团队的凝聚力，加强计算机专业骨干与金融专业骨干的沟通协调，2月17日（周五），由中心主任徐如志主持的学术骨干座谈会暨2012国家自然基金项目申报交流会顺利召开。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-align:center&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334987813620-J7B19s.JPG&quot; width=&quot;600&quot; height=&quot;397&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; style=&quot;text-indent:2em;&quot; /&gt;\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;徐如志教授，优秀的青年教师杨峰、聂秀山分别从时局政策、评委组织工作、组建课题小组、申请书撰写等方面向与会的二十多位学术骨干介绍了申请国家自然基金项目的经验。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;金融学院的安起光教授就加强计算机和金融学科之间、学术骨干之间的信息交流和项目合作的问题上提出了诸多建设性的意见，并得到大家的认同。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;科技处的马玉林也对本中心的多次工作给予了肯定，并希望全体与会人员再接再励，争取在2012年获得更多高水平的国家自然基金项目立项。\r\n&lt;/p&gt;', '1334987813620-J7B19s.JPG', '&nbsp;&nbsp;&nbsp;&nbsp;为进一步推进学术骨干申请国家自然科学基金的申请工作，提升金融信息工程技术研究中心团队的凝聚力，加强计算机专业骨干与金融专业骨干的沟通协调，2月17日（周五），由中心主任徐如志主持的学术骨干座谈会暨2012国家自然基金项目申报交流会顺利召开。 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;徐如志教授，优秀的青年教师杨峰、', '', 0, 0, 0, 1, 1, 1, '2012-04-21 06:33:09', '2012-04-21 06:05:29', 0),
(20, 1, 3, '山东省金融办领导与专家来本中心座谈交流', '&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;2012年2月16日下午，山东省金融办综合处王广庆处长、银行处柏涛副处长一行莅临本中心参观指导工作。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-align:center&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334988471768-7JYS5h.JPG&quot; width=&quot;600&quot; height=&quot;397&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; style=&quot;text-indent:2em;&quot; /&gt;\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;中心主任徐如志就新山东财经大学的学科特色，中心的成立背景，目标定位和服务对象，近期开展的工作以及未来的工作方向等问题逐一向金融办的领导进行了汇报。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;\r\n&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;王广庆处长对本中心一年多来所做的努力给予了充分的肯定，并对本中心未来的工作方向提出了中肯的、专业的建议。他指出，本中心将计算机和山财大优势学科金融、财税相结合，与本地企业合作，为中小金融机构服务，发展潜力巨大，前景广阔。他还鼓励本中心的工作人员积极了解时局政策，努力将金融信息工程中心打造成一个&ldquo;产学研&rdquo;相结合的优质平台，为社会创造出更多的计算机、金融双料人才。\r\n&lt;/p&gt;', '1334988471768-7JYS5h.JPG', '&nbsp;&nbsp;&nbsp;&nbsp;2012年2月16日下午，山东省金融办综合处王广庆处长、银行处柏涛副处长一行莅临本中心参观指导工作。 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;中心主任徐如志就新山东财经大学的学科特色，中心的成立背景，目标定位和服务对象，近期开展的工作以及未来的工作方向等问题逐一向金融办的领导进行了汇报。 &nbsp;&nbsp;&nbsp;&nbsp;王广庆处长对本中', '', 0, 0, 0, 1, 1, 1, '2012-04-21 06:45:37', '2012-04-21 06:31:35', 0),
(21, 1, 4, '四部委联手助力中小企业', '&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;四部委联手助力中小企业，涉及税收优惠、债券股票融资、创投基金、服务平台、鼓励出口等多个方面。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;为切实改善中小企业融资环境，更好地服务实体经济，包括国家发改委、财政部、工信部和商务部在内的多个部委密集出台了一系列针对中小企业的扶持政策。从税收、财政、金融以及在市场准入等方面解决各项难题，进一步促进中小企业的健康发展。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong&gt;财政部：税收优惠财政扶持&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;在今年的全国财政工作会议上，财政部部长谢旭人表示，2012年要大力支持中小企业发展，落实好小微企业的企业所得税优惠以及提高增值税、营业税起征点等税费减免政策，推动产业结构优化升级。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;税收优惠的具体措施包括，自2011年11月1日起，大幅提高增值税和营业税起征点；自2012年1月1日至2015年12月31日，将小型微型企业减半征收企业所得税政策，延长执行期限并扩大范围；2011年11月1日至2014年10月31日，免征金融机构与小型微型企业签订的借款合同印花税；延长金融企业中小企业贷款损失准备金税前扣除政策；对符合条件的国家中小企业公共服务示范平台中的技术类服务平台纳入现行科技开发用品进口税收优惠政策范围等等。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong style=&quot;text-indent:2em;&quot;&gt;发改委：引导民资发展方向&lt;/strong&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;去年，国家发展改革委公布《关于鼓励和引导民营企业发展战略性新兴产业的实施意见》使民营资本投资战略性新兴产业得到实质性落实，民营企业迎来了更大发展空间。在资金保障方面，意见要求，引导民资设立创业投资和产业投资基金，支持民企充分利用新型金融工具融资。积极支持和帮助符合条件的民营企业发行债券、上市融资、开展新型贷款抵押和担保方式试点等，改进对民营企业投资战略性新兴产业相关项目的融资服务。&lt;/span&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;截至2011年底，全国共有24个省市设立了战略性新兴产业专项资金。近日，发改委新批复了41只创投基金的设立方案，吸引社会资本70多亿元。发改委财政金融司处长刘健钧表示，创投基金是中小企业的发动机。没有它，中小企业&ldquo;巧妇难为无米之炊&rdquo;。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong style=&quot;text-indent:2em;&quot;&gt;工信部：六项服务营造氛围&lt;/strong&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;4月20日，工业和信息化部中小企业司司长郑昕表示，根据当前中小企业存在的突出问题，工信部把2012年定为&ldquo;中小企业服务年&rdquo;。主旨是&ldquo;服务企业、助力成长&rdquo;，要围绕着今年所定的&ldquo;稳中求进、科学发展&rdquo;的主线全面地为企业开展&ldquo;三送&rdquo;服务，&ldquo;送政策&rdquo;、&ldquo;送服务&rdquo;、&ldquo;送温暖&rdquo;。一共开展了六项服务，包括：政策咨询服务；还有针对中小企业存在的若干问题提供的融资服务；创业创新服务；转型升级服务；管理提升服务以及舆论服务，要在全社会为中小企业发展营造一个良好的氛围。&lt;/span&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;据悉，工信部将编制出台中小企业服务体系建设十二五规划，出台《关于加快推进中小企业服务体系建设的指导意见》，并会同有关部门研究制定支持中小企业公共服务平台发展的税收优惠政策。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong style=&quot;text-indent:2em;&quot;&gt;商务部：鼓励&ldquo;出海闯关&rdquo;&lt;/strong&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;&lt;span style=&quot;text-indent:2em;&quot;&gt;金融危机和欧债危机之后，全球需求端极度萎缩，各类保护主义风潮渐起以及新一轮全球产业洗牌渐趋形成，很多中小企业都需要寻找新的突破，到海外寻找商机。&lt;/span&gt;&lt;br /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;近期，商务部表示，将鼓励在资本总量、人才结构等方面有条件的中小企业&ldquo;走出去&rdquo;，并给予全面周到的法律咨询服务和所在国国情介绍，以控制风险。与此同时，国家支持中小企业&ldquo;走出去&rdquo;的实施细则也将很快出台。中小企业如何下好&ldquo;走出去&rdquo;这盘棋无论是对于其自身，还是中国整体战略转型，都具有重大的战略意义。&lt;/p&gt;', '', '四部委联手助力中小企业，涉及税收优惠、债券股票融资、创投基金、服务平台、鼓励出口等多个方面。 为切实改善中小企业融资环境，更好地服务实体经济，包括国家发改委、财政部、工信部和商务部在内的多个部委密集出台了一系列针对中小企业的扶持政策。从税收、财政、金融以及在市场准入等方面解决各项难题，进一步促进中小', '', 0, 0, 0, 8, 1, 1, '2012-04-21 07:18:45', '2012-04-21 06:34:51', 0),
(22, 1, 4, '信息化金融服务破解中小企业融资难题', '&lt;p style=&quot;line-height:23px;text-indent:2em;text-align:left;margin-top:auto;margin-bottom:auto;&quot;&gt;交通银行金融研究中心预计，今年在货币政策总体适度放松的大环境下，社会融资总规模将扩大到13万亿元至14万亿元，如果考虑到资金流转率，这个数字将达到百万亿元级。然而，大量中小企业的融资困境并未获得明显改善。&lt;/p&gt;&lt;p style=&quot;line-height:23px;text-indent:2em;text-align:left;margin-top:auto;margin-bottom:auto;&quot;&gt;专家指出，基于传统的融资模式，当前很多发展势头良好的中小企业往往受困于融资渠道问题而裹足不前，丧失了进一步扩大规模的机会。在这种情况下，寻求多元化融资渠道，探索创新的融资模式，成为企业的必然选择，这为创新型金融服务企业带来了市场机会。&lt;/p&gt;&lt;p style=&quot;line-height:23px;text-indent:2em;text-align:left;margin-top:auto;margin-bottom:auto;&quot;&gt;近日，快钱公司启用全新品牌形象，成为首家为企业提供信息化金融服务的支付企业，它致力于帮助企业快速获取和优化现金流。快钱CEO关国光说，&ldquo;信息化金融时代的到来，使得以信息技术优化流动资金管理成为可能。我们依托业已建立的信息化支付清算平台，持续打造包括电子收付款、应收应付账款融资等创新产品组合，形成一套流动资金管理解决方案，解决中小企业融资难题，助力中小企业快速获取及优化现金流，提升企业流动资金管理效率。&rdquo;&lt;/p&gt;&lt;p style=&quot;line-height:23px;text-indent:2em;text-align:left;margin-top:auto;margin-bottom:auto;&quot;&gt;当前企业面临的资金难题表现在两个方面，一是资金归集速度慢，尤其是在&lt;a href=&quot;http://youhui.163.com/&quot; title=&quot;连锁&quot;&gt;&lt;span style=&quot;color:#000&quot;&gt;连锁&lt;/span&gt;&lt;/a&gt;、零售等传统行业里较为明显；二是应收账款无法及时回收，账期拉长影响企业扩张速度。此外，很多企业的信息流和资金流是手工对账，财务管理效率低下，拉高了企业经营成本。一些创新型金融服务企业利用信息化支付清算平台，推出包括电子收付款、应收应付账款融资等创新产品组合，形成一套流动资金管理解决方案。&lt;/p&gt;', '', '交通银行金融研究中心预计，今年在货币政策总体适度放松的大环境下，社会融资总规模将扩大到13万亿元至14万亿元，如果考虑到资金流转率，这个数字将达到百万亿元级。然而，大量中小企业的融资困境并未获得明显改善。 专家指出，基于传统的融资模式，当前很多发展势头良好的中小企业往往受困于融资渠道问题而裹足不前，', '', 0, 0, 0, 0, 1, 1, '2012-04-21 07:18:50', '2012-04-21 07:15:17', 0),
(23, 1, 4, '考虑放宽中小金融机构准入门槛', '&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;随着温州金融综合改革试验区的成立，业内对我国金融改革的关注日渐升温。温州金融改革有怎样的背景？我国需要发展什么样的金融服务体系？如何引导民间资本进入金融领域？记者就此采访了中国人民银行研究局局长张健华。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong&gt;构建基层金融服务体系&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;记者：温州金融综合改革试验区日前获国务院批准，创建温州金融综合改革试验区的背景和意义是什么？&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;张健华：温州具有民营经济发达、民间资金充裕、民间金融活跃的优势。但与此同时，温州又存在&ldquo;两多、两难&rdquo;问题，即民间资金多但投资难，中小企业多但融资难。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;放宽准入，推动形成有效竞争的基层金融服务体系，是破解温州&ldquo;两多、两难&rdquo;问题的重要方向。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;在温州开展金融综合改革试验，应结合温州的特点，在加强监管、有效防范风险的前提下，放宽中小金融机构的市场准入，构建竞争性的基层金融服务体系，有效破解&ldquo;两多、两难&rdquo;问题，进一步提升金融服务实体经济的能力，推动温州经济转型升级。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong&gt;加快发展社区型金融机构&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;记者：近年来我国银行业发展迅猛，但与大型金融机构相比，我国基层金融服务似有不足，未来应如何发展？&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;张健华：经过多年改革发展，我国金融服务于实体经济的能力得到了很大改善，但基层(主要是县域)金融服务竞争不足、服务能力偏弱。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;从国内金融改革和发展趋势看，前5家大型银行在银行业存款类金融机构存款市场中所占的份额从2002年的约80%降为2011年的约50%，贷款份额则从约80%降到不足50%，垄断现象并不明显。但必须指出，在中小城市社区和广大农村地区，金融服务虽有很大改善，竞争依然不足，存在高层说的垄断现象。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;我国不仅地域和经济总量大，又存在巨大的地区差异和城乡差别，要想实现基层金融服务的充分竞争，只靠大中机构恐怕不够，要考虑发展主要服务小微企业和当地居民的社区型金融机构。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong&gt;放宽中小金融机构准入门槛&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;记者：近期以来，市场关于放宽金融机构准入门槛的呼声越来越高，如何看待市场的这一呼声？&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;张健华：金融作为现代服务业，是国民经济的命脉，其特殊性在于风险相对较大，但本质上仍属于竞争性行业，都是在竞争格局中向社会提供商品和服务。竞争最终会使供求基本平衡，多数供给和需求得到满足，还会降低价格，减少企业欺压客户的可能性，压缩寻租空间。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;从金融消费者保护的角度看，其重要目标是基层的消费者拥有更多的、和大中城市消费者平等的选择权。这些基本权利包括：消费者能够在存款和其他形式产品之间，境内产品和境外产品之间，以及不同金融机构之间进行选择。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;无论是提供产品还是服务，市场经济的一项基本规律就是准入自由，从而形成并动态维持竞争格局。应考虑放宽金融业特别是社区型中小金融机构的准入，以构建有效竞争的格局。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong&gt;打破垄断引导民资进入&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;记者：国务院支持民间投资健康发展的新36条明确规定，允许民间资本兴办金融机构。我们应怎样引导民间资本进入金融领域？&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;张健华：我国目前各项法规对于民间资本进入金融服务领域并无任何形式上的限制，但在实践中，即使是小型金融机构，民间资本也很难直接发起设立。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;金融业外部效应大，准入门槛高，但与市场经济的自由准入原则并不相悖。从国际经验看，金融机构设立时，很少有国家按股东性质限制准入。一般而言，只要有符合监管要求的足够资本、拥有合格的经营管理人才、具备相应风险控制制度及管理信息系统，就应该允许设立。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;我国目前要求大型金融机构设立小机构来扩大基层金融服务的初衷虽好，但并不一定符合市场化的改革方向。大银行如真心想扩大基层业务，直接设立分支机构比投资办独立的村镇银行更具经济合理性。让大银行作为发起股东履行对村镇银行的日常监管责任并承担村镇银行经营失败时的风险处置责任，亦超出了公司法规定的股东责任范围。&lt;/p&gt;', '', '随着温州金融综合改革试验区的成立，业内对我国金融改革的关注日渐升温。温州金融改革有怎样的背景？我国需要发展什么样的金融服务体系？如何引导民间资本进入金融领域？记者就此采访了中国人民银行研究局局长张健华。 构建基层金融服务体系 记者：温州金融综合改革试验区日前获国务院批准，创建温州金融综合改革试验区的', '', 0, 0, 0, 0, 1, 1, '2012-04-21 07:18:52', '2012-04-21 07:16:35', 0),
(24, 1, 4, '第三方支付助推中小银行基金销售', '&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;尽管近年来基金市场乏善可陈，销售陷入困顿，但通过第三方机构支付实现的基金交易量却取得了飞速增长。&ldquo;基金&rdquo;这块大蛋糕成了第三方支付企业垂涎的对象。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;近日，由通联支付网络股份有限公司主办的、以&ldquo;通金融服务、联银行资源&rdquo;为主题的基金销售与理财服务高层研讨会在厦门召开。会上，第三方支付企业如何帮助中小银行开展基金销售业务并提高整体理财服务能力，如何提升中小银行在基金销售中的占比，成为业内专家讨论的热点。中小银行看好基金销售&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;数据显示，中小银行的基金销售收入占比不足全国性银行的1%，但全国有代销资质的银行中，中小银行在数量上占了71%，数量上的优势还来不及转化为收入上的优势，对中小银行来说，基金销售业务未来的市场发展空间巨大。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;同时，基金销售业务作为银行的一项重要中间业务，对于中小银行而言不仅是收入的重要来源，也会带来多方面的效益。比如这项业务将为客户提供更多理财服务、可增加现有客户的忠诚度以及有利于拓展新客户、提升市场竞争力等。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;其实，不光是巨大的市场容量为中小银行开展基金销售业务提供了一个广阔的发展平台，客户日渐增长的投资需求以及银行长期的战略发展定位，都要求中小银行大力发展基金销售业务。但由于中小银行在基金销售方面起步较晚，因此在业务开展上还需要基金公司、第三方支付机构等各方的支持与协助。第三方支付企业将大有作为&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;面对中小银行的这种切实需求，目前获得基金支付业务牌照的第三方支付企业将大有作为。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;通联支付金融服务事业部副总裁周盛在会上向邀请嘉宾以及参会银行解析了通联支付在基金销售业务中的角色和定位以及为中小银行提供的服务价值。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;周盛表示，具有基金支付资质的第三方支付企业参与基金销售业务，能有效地降低各环节相应的成本，比如节约了投资者购买基金的时间成本、利用现有平台减少中小银行与基金公司的链接成本；同时通过平台可以实现将各银行的接口统一链接，从而可以扩大银行卡支付的范围，解决中小银行的业务区域局限。此外，第三方支付企业的参与优化了基金销售行业的专业化分工，有利于行业创新业务的发展。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;line-height:2em;&quot;&gt;&lt;strong&gt;基金支付成为下一个&ldquo;蓝海&rdquo;&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;业内人士指出，基金支付业务或许将成为第三方支付行业的下一个蓝海。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;据了解，目前国内获准开展基金支付业务的第三方支付企业仅有四家，而通联支付是第二家获得该牌照的支付企业。该公司成立于2008年10月，是目前国内注册资本最为雄厚的第三方支付企业。2011年5月，该公司成为第一批获得第三方支付牌照的企业之一，目前也是支付机构中惟一一家当选中国支付清算协会副会长级会员的单位。&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;如今，基金支付业务这片蓝海已经打开，获准开展基金支付业务的四家第三方支付企业正&ldquo;摩拳擦掌&rdquo;，纷纷进军这一市场。谁能抢得先机、谁能最准确地把握市场的需求，谁能找到最合适的经营模式，谁就能在未来的市场竞争中抢得先机。&lt;/p&gt;', '', '尽管近年来基金市场乏善可陈，销售陷入困顿，但通过第三方机构支付实现的基金交易量却取得了飞速增长。&ldquo;基金&rdquo;这块大蛋糕成了第三方支付企业垂涎的对象。 近日，由通联支付网络股份有限公司主办的、以&ldquo;通金融服务、联银行资源&rdquo;为主题的基金销售与理财服务高层研讨会在厦门召开。会上，第三方支付企业如何帮助中小银行开', '', 0, 0, 0, 0, 1, 0, '2012-04-21 07:19:55', '2012-04-21 07:19:55', 0),
(25, 1, 3, '校长刘兴云到计算科学与技术学院进行调研', '&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;4月13日上午，校长刘兴云到计算机科学与技术学院（以下简称计算机学院）进行工作调研,&amp;nbsp;校办主任张书学陪同调研。听取计算机学院领导班子的工作汇报，了解学校合并后计算机学院工作开展情况、存在的问题和今后学院的工作思路。&lt;/p&gt;&lt;p style=&quot;text-align:center&quot;&gt;&lt;img src=&quot;/CMS/static/uploads/gallery/gallery-big/1334996709146-INhhrZ.jpg&quot; width=&quot;600&quot; height=&quot;400&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; style=&quot;text-indent:2em;&quot; /&gt;&lt;/p&gt;&lt;p style=&quot;text-indent:2em;text-align:left;&quot;&gt;徐如志院长汇报了计算机学院围绕学校的总体部署抓稳定，坚持稳中求进，确保教学和学生管理工作有序进行；抓班子，落实党政联席会议制度，坚持集体决策和分工负责；抓基础，以人才培养和学科建设为核心，积极推进学院各项工作。张彩明院长汇报了数字媒体重点实验室建设存在的问题和数字媒体专业建设规划以及对人才评价体系的建议。孙青书记汇报了计算机学院在思想建设、和谐院系建设方面开展的工作，介绍了党总支在学院工作中如何保驾护航，讲政治、顾大局，积极推进计算机学院师生在思想认识和行动上的快速融合。学院其他领导也就各自分管工作提出意见和建议。&lt;br /&gt;&lt;/p&gt;&lt;div style=&quot;text-indent:2em;text-align:left;&quot;&gt;刘校长介绍了最近学校在去筹和部省共建方面取得的进展，认真听取了计算机学院各位领导的发言，对计算机学院合校后的工作给予了充分肯定。对计算机学院领导班子当前的工作状态以及稳中求进的工作态度表示欣慰。对计算机学院的工作提出了五点要求。&lt;/div&gt;&lt;div style=&quot;text-indent:2em;text-align:left;&quot;&gt;一是理清思路，特色发展。计算机学院要立足学校的财经学科优势，找准学科发展定位和学科发展方向，积极服务财经、服务社会，为我校的财经学科提供有力支撑，在此基础上办出特色办出水平。&lt;/div&gt;&lt;div style=&quot;text-indent:2em;text-align:left;&quot;&gt;二是抓住龙头，突出重点。要充分发挥计算机学院在科研和师资队伍方面的优势，以学科建设为龙头，进一步凝练学科方向，突出重点，为博士点建设早作准备，强调要抓好学科专业建设和人才储备工作。&lt;/div&gt;&lt;div style=&quot;text-indent:2em;text-align:left;&quot;&gt;三是教学为重，改革方法。教学工作是学校的中心工作，教师要把主要精力放在教学上。计算机学院除了本专业的课程外，还承担全校的计算机基础课教学，对全校的教学质量和人才培养质量有重要影响。要采取措施、鼓励教师搞好教学，同时要利用信息技术改革教学方法，争取在教改方面走在前列。&lt;/div&gt;&lt;div style=&quot;text-indent:2em;text-align:left;&quot;&gt;四是注重科研，搞好服务。计算机学科在加强理论研究的同时，积极开展社会服务和应用研究，数字媒体专业要加强与文化创意产业的结合，寻求政府和社会支持；计算机科学与技术专业要重点面向财经领域为财经信息化提供服务。&lt;/div&gt;&lt;div style=&quot;text-indent:2em;text-align:left;&quot;&gt;五是加强团结，求同存异。计算机学院强强合并后领导班子成员都能以事业为重，对工作中出现的意见分歧和认识上的差异能够坦诚布公，求同存异，稳中求进，这是难能可贵的。希望计算机学院领导班子进一步加强沟通、加强团结，带领计算机学院在学科建设和社会服务方面取得更大突破。&lt;/div&gt;', '1334996709146-INhhrZ.jpg', '4月13日上午，校长刘兴云到计算机科学与技术学院（以下简称计算机学院）进行工作调研,&nbsp;校办主任张书学陪同调研。听取计算机学院领导班子的工作汇报，了解学校合并后计算机学院工作开展情况、存在的问题和今后学院的工作思路。 徐如志院长汇报了计算机学院围绕学校的总体部署抓稳定，坚持稳中求进，确保教学和学生管理', '', 0, 0, 0, 0, 1, 1, '2012-04-21 08:30:05', '2012-04-21 08:30:01', 0),
(33, 1, 13, '万海山', '&lt;p style=&quot;text-align:center;text-align:center;&quot;&gt;&lt;img src=&quot;http://localhost/CMS/static/uploads/article/article-big/1335062154948.jpg&quot; style=&quot;float:none;&quot; title=&quot;1.jpg&quot; border=&quot;0&quot; hspace=&quot;0&quot; vspace=&quot;0&quot; /&gt;&lt;br /&gt;&lt;/p&gt;&lt;p class=&quot;p0&quot; style=&quot;text-indent:32px;line-height:150%&quot;&gt;金融信息安全研究所所长，山东中孚信息产业股份有限公司副总经理。&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;1994&lt;/span&gt;年以来，一直从事信息安全产品的研究与开发，尤其是在商用密码领域，积累了丰富的实践经验和深刻的行业理解。&lt;/p&gt;&lt;p class=&quot;p0&quot; style=&quot;text-indent:32px;line-height:150%&quot;&gt;作为主要技术负责人，参与开发的&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&ldquo;&lt;/span&gt;公钥密码快速实现技术&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&rdquo;&lt;/span&gt;项目获国家科技进步三等奖。以此成果为基础，作为主要技术负责人，研发了国内第一款商用密码卡和密码机，已广泛应用于国内的电子商务和电子政务领域。作为主要技术负责人，参与开发的&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&ldquo;&lt;/span&gt;商业电子信息安全认证数字证书管理系统&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&rdquo;&lt;/span&gt;是国内最早的自主研发的大型商业化数字证书系统，并获外经贸部科技进步一等奖。同时作为项目负责人，参与了&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&ldquo;PKI&lt;/span&gt;安全体系结构的研究&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&rdquo;&lt;/span&gt;、&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&ldquo;PKI/PMI&lt;/span&gt;高速密码设备研发&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&ldquo;&lt;/span&gt;等&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;5&lt;/span&gt;个国家&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&ldquo;863&rdquo;&lt;/span&gt;重大科技攻关项目，为国内&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;PKI&lt;/span&gt;技术的发展起到重要作用。&lt;/p&gt;&lt;p class=&quot;p0&quot; style=&quot;text-indent:32px;line-height:150%&quot;&gt;获奖情况：&lt;/p&gt;&lt;ul style=&quot;list-style-type:circle&quot;&gt;&lt;li&gt;国家科技进步三等奖&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;1999&lt;/span&gt;年&lt;/li&gt;&lt;li&gt;外贸部科技进步一等奖&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;1999&lt;/span&gt;年&lt;/li&gt;&lt;li&gt;山东省中小企业科技进步奖&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;2010&lt;/span&gt;年&lt;/li&gt;&lt;li&gt;济南市科技进步一等奖&lt;span style=&quot;font-family:&amp;#39;仿 宋 _gb2312&amp;#39;&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;2011&lt;/span&gt;年&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;br /&gt;&lt;/p&gt;', '1335062154948.jpg', '金融信息安全研究所所长，山东中孚信息产业股份有限公司副总经理。1994年以来，一直从事信息安全产品的研究与开发，尤其是在商用密码领域，积累了丰富的实践经验和深刻的行业理解。 作为主要技术负责人，参与开发的&ldquo;公钥密码快速实现技术&rdquo;项目获国家科技进步三等奖。以此成果为基础，作为主要技术负责人，研发了国内', '', 0, 0, 0, 1, 0, 1, '2012-04-22 02:49:12', '2012-04-22 02:36:01', 0),
(34, 1, 19, '农村金融机构全面风险管理方案', '&lt;p&gt;农村金融机构全面风险管理方案&lt;br /&gt;&lt;/p&gt;', '', '农村金融机构全面风险管理方案', '', 0, 0, 0, 0, 0, 1, '2012-04-22 02:44:12', '2012-04-22 02:44:01', 0),
(35, 1, 19, '中小企业金融机构发展战略规划', '&lt;p&gt;中小企业金融机构发展战略规划&lt;br /&gt;&lt;/p&gt;', '', '中小企业金融机构发展战略规划', '', 0, 0, 0, 0, 0, 1, '2012-04-22 02:49:10', '2012-04-22 02:45:14', 0),
(36, 1, 19, '中小银行信用风险内部评级方案', '&lt;p&gt;中小银行信用风险内部评级方案&lt;strong&gt;&lt;/strong&gt;&lt;br /&gt;&lt;/p&gt;', '', '中小银行信用风险内部评级方案', '', 0, 0, 0, 0, 0, 1, '2012-04-22 02:49:09', '2012-04-22 02:45:34', 0),
(37, 1, 19, '中小金融机构云计算服务平台', '&lt;p&gt;中小金融机构云计算服务平台&lt;br /&gt;&lt;/p&gt;', '', '中小金融机构云计算服务平台', '', 0, 0, 0, 0, 0, 1, '2012-04-22 02:49:08', '2012-04-22 02:47:35', 0),
(38, 1, 19, '银行数据治理与应用解决方案', '&lt;p&gt;银行数据治理与应用解决方案&lt;br /&gt;&lt;/p&gt;', '', '银行数据治理与应用解决方案', '', 0, 0, 0, 1, 0, 1, '2012-04-22 03:25:39', '2012-04-22 02:47:58', 0),
(39, 1, 19, '个人金融业务精细化管理与ACR', '&lt;p&gt;个人金融业务精细化管理与ACR&lt;br /&gt;&lt;/p&gt;', '', '个人金融业务精细化管理与ACR', '', 0, 0, 0, 0, 0, 1, '2012-04-22 02:49:06', '2012-04-22 02:48:13', 0),
(40, 1, 19, '移动支付安全体系建设', '&lt;p&gt;移动支付安全体系建设&lt;br /&gt;&lt;/p&gt;', '', '移动支付安全体系建设', '', 0, 0, 0, 0, 0, 1, '2012-04-22 02:49:05', '2012-04-22 02:48:36', 0),
(41, 1, 19, '金融行业内网安全统一管控平台平台', '&lt;p&gt;金融行业内网安全统一管控平台&lt;br /&gt;&lt;/p&gt;', '', '金融行业内网安全统一管控平台', '', 0, 0, 0, 0, 0, 1, '2012-04-22 03:02:12', '2012-04-22 02:48:55', 0);

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
(10, '北京用友政务领导和专家来本中心交流', '1334987506745-13PYMV.JPG', '2012年3月27日下午，山东省金融信息工程技术研究中心与北京用友政务软件有限公司合作交流会在本中心举行。中心主任徐如志教授会见了用友政务的总经理周海樯一行。', 1, '2012-04-21 05:51:58', '2012-04-21 05:17:26'),
(11, '北京用友政务领导和专家来本中心交流', '1334987530677-Yxatk7.JPG', '2012年3月27日下午，山东省金融信息工程技术研究中心与北京用友政务软件有限公司合作交流会在本中心举行。中心主任徐如志教授会见了用友政务的总经理周海樯一行。', 0, '2012-04-21 05:52:21', '2012-04-21 05:17:41'),
(12, '研究中心学术骨干座谈会顺利召开', '1334987813620-J7B19s.JPG', '为进一步推进学术骨干申请国家自然科学基金的申请工作，提升金融信息工程技术研究中心团队的凝聚力，加强计算机专业骨干与金融专业骨干的沟通协调，2月17日（周五），由中心主任徐如志主持的学术骨干座谈会暨2012国家自然基金项目申报交流会顺利召开。', 1, '2012-04-21 06:29:56', '2012-04-21 05:57:00'),
(13, '山东省金融办领导与专家来本中心座谈交流', '1334988471768-7JYS5h.JPG', '2012年2月16日下午，山东省金融办综合处王广庆处长、银行处柏涛副处长一行莅临本中心参观指导工作。', 1, '2012-04-21 06:08:00', '2012-04-21 06:08:00'),
(14, '校长刘兴云到计算科学与技术学院进行调研', '1334996709146-INhhrZ.jpg', '4月13日上午，校长刘兴云到计算机科学与技术学院（以下简称计算机学院）进行工作调研, 校办主任张书学陪同调研。听取计算机学院领导班子的工作汇报，了解学校合并后计算机学院工作开展情况、存在的问题和今后学院的工作思路。', 1, '2012-04-21 08:30:24', '2012-04-21 08:19:01');


-- -----------------------------------------------------
-- 友情链接测试数据
-- -----------------------------------------------------
INSERT INTO `cms_link` (`id`, `title`, `url`, `category`, `status`, `last_modified_date`, `created_date`) VALUES
(1, '山东财经大学', 'http://www.sdufi.edu.cn/', 'LINK', 1, '2012-04-21 09:11:03', '2012-04-21 09:07:47'),
(2, '计算机科学与技术学院', 'http://pub.sdfi.edu.cn/computer/', 'LINK', 1, '2012-04-22 06:31:01', '2012-04-22 06:29:10'),
(3, '山东财经大学金融学院', 'http://123.232.100.72/jinrong/', 'LINK', 1, '2012-04-22 06:27:46', '2012-04-22 06:27:29'),
(10, '山东华软金盾', 'http://www.neiwang.cn/', 'COMPANY', 1, '2012-04-21 09:28:48', '2012-04-21 09:07:47'),
(11, '山东舜德数据', 'http://www.sundatasoft.com/', 'COMPANY', 1, '2012-04-21 09:28:46', '2012-04-21 09:07:47'),
(12, '戈尔特西斯(济南)', 'http://www.goitsys.com/', 'COMPANY', 1, '2012-04-21 09:28:37', '2012-04-21 09:07:47'),
(13, '山东省城商联盟', '', 'LINK', 1, '2012-04-21 09:11:07', '2012-04-21 09:07:47'),
(14, '山东省农信社', 'http://www.sdnxs.com/', 'LINK', 1, '2012-04-21 09:11:08', '2012-04-21 09:07:47'),
(15, 'SAS中国', 'http://www.sas.com', 'COMPANY', 1, '2012-04-21 09:24:59', '2012-04-21 09:07:47'),
(16, '北京用友软件', 'http://www.ufida.com.cn/', 'COMPANY', 1, '2012-04-21 09:27:18', '2012-04-21 09:26:13'),
(17, '济南银泉科技', 'http://www.yinquan.cn/', 'COMPANY', 0, '2012-04-21 09:27:50', '2012-04-21 09:27:50'),
(18, 'SAS中国', 'http://www.sas.com', 'COMPANY', 1, '2012-04-22 07:06:06', '2012-04-22 07:05:59'),
(19, '山东省财政厅', 'http://www.sdcz.gov.cn/', 'LINK', 1, '2012-04-22 07:29:07', '2012-04-22 07:28:46'),
(20, '山东中孚', 'http://www.zfsy.net/', 'COMPANY', 1, '2012-04-22 07:32:26', '2012-04-22 07:32:17'),
(21, '山东税务局', 'http://www.sd-n-tax.gov.cn/', 'LINK', 1, '2012-04-22 07:34:03', '2012-04-22 07:33:54');