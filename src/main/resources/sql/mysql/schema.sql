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
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
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
  `views` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '浏览次数' ,
  `allow_comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否存在点评' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '帖子审核状态' ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
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
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
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
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
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
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
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
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `article_count` TINYINT(3) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
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
  `id` MEDIUMINT(8) NOT NULL  AUTO_INCREMENT ,
  `title` VARCHAR(40) NOT NULL ,
  `image_url` VARCHAR(80) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `last_modified_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间' ,
  `created_date` TIMESTAMP NOT NULL DEFAULT 0 COMMENT '创建时间' ,
  `deleted` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARSET=UTF8 COLLATE=utf8_general_ci;

-- -----------------------------------------------------
-- Table `cms4j`.`cms_link`
-- -----------------------------------------------------

DROP TABLE IF EXISTS 'cms4j'.'cms_link';

CREATE TABLE IF NOT EXISTS 'cms4j'.'cms_link'(
id INT(8) NOT NULL AUTO_INCREMENT,
title VARCHAR(20) NOT NULL,
url VARCHAR(80) NOT NULL,
deleted TINYINT(1) NOT NULL,
create_time TIMESTAMP,
modify_time TIMESTAMP,
PRIMARY KEY (id)
);



-- -----------------------------------------------------
-- 用户测试数据
-- -----------------------------------------------------
INSERT INTO `cms_user`(`id`, `email`, `username`, `password`, `salt`, `status`, `email_status`, `avatar_status`, `photourl`, `time_offset`, `lastip`, `last_time`, `last_act_time`, `last_modified_date`, `created_date`, `deleted`) VALUES (1,'dreambt@126.com','纪柏涛','691b14d79bf0fa2215f155235df5e670b64394cc','7efbd59d9741d34f',1,1,0,'male.gif','0800',134744072,'1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00','1987-06-01 00:00:00',1);

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
INSERT INTO `cms_category`(`id`, `father_category_id`, `category_name`, `display_order`, `show_type`, `url`, `description`, `allow_comment`, `allow_publish`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1,1,'首页',1,'NONE','index','无',0,0,'2012-03-22 23:58:00','2012-03-22 23:58:00',0),
(2,1,'新闻报道',10,'NONE','','本中心的最新新闻资讯',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0),
(3,2,'校内新闻',11,'LIST','','444',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0),
(4,2,'校外报道',12,'LIST','','555',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0),
(5,1,'培训课程',20,'DIGEST','','本中心长期提供培训课程',1,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0),
(6,1,'活动相册',30,'GALLERY','','活动相册',0,1,'2012-03-22 23:58:00','2012-03-22 23:58:00',0),
(7,1,'关于我们',40,'NONE','about','关于我们',0,0,'2012-03-22 23:58:00','2012-03-22 23:58:00',0);


-- -----------------------------------------------------
-- 文章测试数据
-- -----------------------------------------------------
INSERT INTO `cms_article` (`id`, `author`, `category_name`, `subject`, `message`, `digest`, `keyword`, `top`, `rate`, `rate_times`, `views`, `allow_comment`, `status`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, '纪柏涛', '培训课程', '关于证书培训', '<p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px">山东金融信息技术培训中心依托山东财经大学的资源优势，以培养高层次水平与国际化视野的金融财务和投资理财专业人才，进一步推动中国金融资本市场的发展为办学目标，为全国各地的有志青年提供高标准的金融培训课程，权威的备考资料和周到的考试服务。</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px">随着国</span><span style="font-size:16px">内金融理财市场的蓬勃发展和对于高端金融人才的强劲需求，我们开设特许金融分析师（</span><span style="font-size:16px">CFA</span><span style="font-size:16px">）、金融风险管理师（</span><span style="font-size:16px">FRM</span><span style="font-size:16px">）、国家理财规划师（</span><span style="font-size:16px">ChFP</span><span style="font-size:16px">）、期货从业资格、银行从业资格、保荐代表人等一系列国内外权威的金融投资职业资格顶尖课程。同时，我们还为国内外知名银行、保险、基金、证券等金融投资机构提供各种有针对性的企业内训课程</span><span style="font-size:16px">和职业发展课程，并建立起长期战略合作关系。</span></p><p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px">我们的优势：完善的课程体系，强大的师资队伍，独特的教学方法，一流的学习环境在广大学员中有口皆碑。</span></p><p style="line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px">我们的目标：帮助每一位考生顺利地通过金融投资领域相关考试，打造金融培训领域的新标杆。</span></p><p style="line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px">　　我们的学员：全国各大银行、证券、保险类等公司机构金融行业从业人员；　　　　　　　　全国各地高校金融类相关专业学生；国内其他有志于从事金融行业的各界人士</span></p><p style="line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px">　　我们的团队：管理队伍为80%以上拥有硕士以上学位的金融界精英及业内资深教授，核心成员来自山东财经大学。</span></p><p style="line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px">　　我们的理念：您的成功是我们最大的心愿！</span></p><p><br /></p><ul style="list-style-type:disc"><li><span style="font-size:16px">报名及详情咨询</span></li></ul><p><span style="font-size:16px">联系人：张老师</span><span style="font-size:16px">&nbsp;&nbsp;</span><span style="font-size:16px">赵老师</span></p><p><span style="font-size:16px">电话：</span><span style="font-size:16px">0531-82917317&nbsp;82917318</span></p><p><span style="font-size:16px">传真：</span><span style="font-size:16px">0531-82917319</span></p><span style="font-size:16px;font-family:&#39;times new roman&#39;,&#39;serif&#39;">Email:<span style="color:#000"><a href="mailto:jrgc@sdfi.edu.cn">jrgc@sdfi.edu.cn</a></span></span>', '    山东金融信息技术培训中心依托山东财经大学的资源优势，以培养高层次水平与国际化视野的金融财务和投资理财专业人才，进一步推动中国金融资本市场的发展为办学目标，为全国各地的有志青年提供高标准的金融培训课程，权威的备考资料和周到的考试服务。       随着国内金融理财市场的蓬勃发展和对于高端金融人', '', 0, 0, 7, 0, 1, 1, '2012-04-04 01:58:23', '2012-04-04 01:58:18', 0),
(2, '纪柏涛', '培训课程', 'CFA 特许金融分析师', '<ul style="list-style-type:disc"><li><span style="font-size:16px;font-family:宋体;color:black">特许金融分析师</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">是什么？</span></li></ul><p><span style="font-size:16px;color:black">&nbsp;</span></p><p><span style="font-size:16px;color:black">&nbsp;&nbsp;&nbsp;&nbsp;CFA</span><span style="font-size:16px;font-family:宋体;color:black">全称</span><span style="font-size:16px;color:black">Chartered&nbsp;Financial&nbsp;Analyst&nbsp;</span><span style="font-size:16px;font-family:宋体;color:black">（特许金融分析师），是全球投资业里最为严格与含金量最高的资格认证，为全球投资业在道德操守、专业标准及知识体系等方面设立了规范与标准。</span></p><p><span style="font-size:16px;color:black">&nbsp;&nbsp;&nbsp;&nbsp;CFA</span><span style="font-size:16px;font-family:宋体;color:black">由总部位于美国的</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">协会进行资格评审和认定，自从六十年代中期第一次考试以来，</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">考试已经历经了近</span><span style="font-size:16px;color:black">40</span><span style="font-size:16px;font-family:宋体;color:black">个年头。目前，</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">已经毫无异议地成为全球金融第一认证体系</span><span style="font-size:16px;color:black">,CFA</span><span style="font-size:16px;font-family:宋体;color:black">所推广的金融理念已经成为行业标准，</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">资格已广泛地被全球顶尖金融结构采用成为主要人力资源评估标准。</span></p><p><span style="font-size:16px;font-family:宋体;color:black">《金融时报》杂志于</span><span style="font-size:16px;color:black">2006</span><span style="font-size:16px;font-family:宋体;color:black">年将</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">专业资格比喻成投资专才的</span><span style="font-size:16px;color:black">“</span><span style="font-size:16px;font-family:宋体;color:black">黄金标准</span><span style="font-size:16px;color:black">”</span><span style="font-size:16px;font-family:宋体;color:black">。</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px;font-family:宋体;color:black">　</span><span style="font-size:16px;color:black">&nbsp;&nbsp;CFA</span><span style="font-size:16px;font-family:宋体;color:black">协会是一家全球非营利专业机构，负责在全世界范围内主办</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">考试课程，并为投资业界制定自愿的、以道德为基础的专业及投资表现报告准则。</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">协会在全球</span><span style="font-size:16px;color:black">125</span><span style="font-size:16px;font-family:宋体;color:black">个国家及地区拥有接近</span><span style="font-size:16px;color:black">100</span><span style="font-size:16px;font-family:宋体;color:black">，</span><span style="font-size:16px;color:black">000</span><span style="font-size:16px;font-family:宋体;color:black">名会员，其中包括</span><span style="font-size:16px;color:black">85</span><span style="font-size:16px;font-family:宋体;color:black">，</span><span style="font-size:16px;color:black">000</span><span style="font-size:16px;font-family:宋体;color:black">名</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">特许状持有者以及遍布</span><span style="font-size:16px;color:black">53</span><span style="font-size:16px;font-family:宋体;color:black">个国家和地区的</span><span style="font-size:16px;color:black">132</span><span style="font-size:16px;font-family:宋体;color:black">个会员协会。</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">协会的宗旨是通过建立最高的职业道德、教育水平、及专业风范，引领全球的投资行业。</span></p><p><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><span style="font-size:16px">CFA</span><span style="font-size:16px;font-family:宋体">资格证书的价值何在？</span></li></ul><p><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">在投资金融界被誉为</span><span style="font-size:16px;color:black">“</span><span style="font-size:16px;font-family:宋体;color:black">金领阶层</span><span style="font-size:16px;color:black">”</span><span style="font-size:16px;font-family:宋体;color:black">，在西方一直被视做进军华尔街的</span><span style="font-size:16px;color:black">“</span><span style="font-size:16px;font-family:宋体;color:black">入场券</span><span style="font-size:16px;color:black">”</span><span style="font-size:16px;font-family:宋体;color:black">。美国、加拿大、英国等国家的许多投资管理机构甚至已经把</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">资格作为对其雇员入职的基本要求。</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">的全球公认性会使你的雇主马上认知你对金融市场知识的掌握程度和深度。你会有效学习如何分析股票，债券，衍生工具和财务比例从而加强你在金融投资行业的工作能力。通常，你获得</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">之后的价值会体现在雇主给你的收入水平上。因此，长久以来</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">一直被视为金融投资界的</span><span style="font-size:16px;color:black">MBA</span><span style="font-size:16px;font-family:宋体;color:black">，在全球金融市场更为抢手。希望在金融投资界领域的人，</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">资格是一个非常明智的选择。</span></p><p><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><span style="font-size:16px;font-family:宋体">需要满足什么条件才可以报考</span><span style="font-size:16px">CFA?</span></li></ul><p style="text-indent:32px"><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">考试分为一、二、三级共三个阶段，考过前一阶段，才能参加下一阶段考试。第一级考试每年</span><span style="font-size:16px;color:black">6</span><span style="font-size:16px;font-family:宋体;color:black">月和</span><span style="font-size:16px;color:black">12</span><span style="font-size:16px;font-family:宋体;color:black">月各举行一次；第二级及第三级考试每年均于</span><span style="font-size:16px;color:black">6</span><span style="font-size:16px;font-family:宋体;color:black">月同时举行一次。</span></p><p style="text-indent:32px;"><span style="font-size:16px;font-family:宋体;color:black">参加第一阶段考试者，需具备以下条件：</span><span style="font-size:16px;color:black">&nbsp;</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体;color:black">　　</span><span style="font-size:16px;color:black">1</span><span style="font-size:16px;font-family:宋体;color:black">）拥有学士学位或相当的专业水准以上，对专业没有任何限制；</span><span style="font-size:16px;color:black">&nbsp;</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体;color:black">　　</span><span style="font-size:16px;color:black">2</span><span style="font-size:16px;font-family:宋体;color:black">）大学学习年限与全职工作经验合计满四年；</span><span style="font-size:16px;color:black">&nbsp;</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体;color:black">　　</span><span style="font-size:16px;color:black">3</span><span style="font-size:16px;font-family:宋体;color:black">）如果申请人不具备学士学位，而是具备相当的专业水准，也可被接受为候选人。</span><span style="font-size:16px;color:black">CFA</span><span style="font-size:16px;font-family:宋体;color:black">协会用工作经历来考核申请人的专业水准，一般来讲，</span><span style="font-size:16px;color:black">4</span><span style="font-size:16px;font-family:宋体;color:black">年的工作经历即被视为替代学士学位。这</span><span style="font-size:16px;color:black">4</span><span style="font-size:16px;font-family:宋体;color:black">年的工作经历，不一定要从事投资领域相关工作，只要是合法、全职、专业性的工作经历都可被接受；</span><span style="font-size:16px;color:black">&nbsp;</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体;color:black">　　</span><span style="font-size:16px;color:black">4</span><span style="font-size:16px;font-family:宋体;color:black">）在校大学四年级学生，可在最后一个学年参加考试。</span><span style="font-size:16px;color:black">&nbsp;</span><span style="font-size:16px;">&nbsp;</span></p><p style="text-indent:32px"><br /><span style="font-size:16px"></span></p><ul style="list-style-type:disc"><li><span style="font-size:16px">CFA</span><span style="font-size:16px;font-family:宋体">的考试科目？</span></li></ul><p style="text-autospace:ideograph-other"><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;CFA</span><span style="font-size:16px;font-family:宋体">的课程以投资行业的实务为基础。</span><span style="font-size:16px">CFA&nbsp;</span><span style="font-size:16px;font-family:宋体">协会定期对全球的特许金融分析师进行职业分析，以确定课程中的投资知识体系和技能在特许金融分析师的工作实践中是否重要。</span></p><p style="text-indent:32px;text-autospace:ideograph-other"><span style="font-size:16px;font-family:宋体">考生的</span><span style="font-size:16px">Body&nbsp;of&nbsp;KnowledgeTM&nbsp;(</span><span style="font-size:16px;font-family:宋体">知识体系</span><span style="font-size:16px">)</span><span style="font-size:16px;font-family:宋体">主要由四部分主要内容组成：道德和职业标准、投资评估和管理的工具和因素（含定量分析方法、经济学、财务报表分析及公司金融）、资产评估（包括股票、固定收益产品、衍生产品及另类投资产品）</span><span style="font-size:16px">,&nbsp;</span><span style="font-size:16px;font-family:宋体">投资组合管理及投资表现报告。</span><span style="font-size:16px"><br /><br /></span><span style="font-size:16px;font-family:宋体">　　</span><span style="font-size:16px">CFA</span><span style="font-size:16px;font-family:宋体">一级考试课程着重于投资评估和管理的工具和因素，包括资产评估和投资组合管理技巧的入门介绍。</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体">　　</span><span style="font-size:16px">CFA</span><span style="font-size:16px;font-family:宋体">二级考试课程着重于资产评估及其工具和因素的应用（包括经济、财务报表分析和定量分析方法）。</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体">　　</span><span style="font-size:16px">CFA</span><span style="font-size:16px;font-family:宋体">三级考试课程着重于投资组合管理，包括应用因素和工具的战略，以及个人或机构管理股票证券、固定收益证券、衍生工具和另类投资的资产评估模式。</span></p><p style="text-autospace:ideograph-other"><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px;font-family:宋体">【报名及详情咨询】</span></p><p><span style="font-size:16px;font-family:宋体">联系人：张老师</span><span style="font-size:16px">&nbsp;</span><span style="font-size:16px;font-family:宋体">赵老师</span></p><p><span style="font-size:16px;font-family:宋体">电话：</span><span style="font-size:16px">0531-82917317&nbsp;82917318</span></p><p><span style="font-size:16px;font-family:宋体">传真：</span><span style="font-size:16px">0531-82917319</span></p><p><span style="font-size:16px">Email:&nbsp;<a href="mailto:jrgc@sdfi.edu.cn"><span style="color:#000">jrgc@sdfi.edu.cn</span></a></span></p>', '特许金融分析师CFA是什么？       CFA全称Chartered Financial Analyst （特许金融分析师），是全球投资业里最为严格与含金量最高的资格认证，为全球投资业在道德操守、专业标准及知识体系等方面设立了规范与标准。     CFA由总部位于美国的CFA协会进行资格评审和认定', '', 0, 0, 0, 2, 1, 1, '2012-04-04 10:18:37', '2012-04-04 10:18:05', 0),
(3, '纪柏涛', '培训课程', 'CIO信息总监高级研修班', '<p style="text-align:left;line-height:19px;text-autospace:ideograph-other;text-align:left;"><span style="font-size:16px;font-family:宋体">【教学背景】</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体">　</span><span style="font-size:16px">&nbsp;&nbsp;</span><span style="font-size:16px;font-family:宋体">信息技术正深刻地改变着人类的生产和生活方式，人类即将全面进入信息化社会。在与全球经济不断融合的过程中，中国开始步入改革的深化阶段。不管是企业改革还是政府改革，信息化都将在这个现代化进程中起着举足轻重的作用，信息化已成为组织管理变革和流程创新的必然选择。</span></p><p style="text-align:left;line-height:19px;text-autospace:ideograph-other;text-align:left;"><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;CIO</span><span style="font-size:16px;font-family:宋体">（</span><span style="font-size:16px">Chief&nbsp;Information&nbsp;Officer</span><span style="font-size:16px;font-family:宋体">：信息总监）作为信息化的直接领导者，其素质、地位和职责直接关系到企业信息化或政府信息化的成败。</span><span style="font-size:16px">CEO-CFO-CIO</span><span style="font-size:16px;font-family:宋体">共同构成了现代企业管理的三驾马车。中国信息化过程中存在着诸多的问题，有很多</span><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">投资没有产生相应的效益，甚至是失败，其中一个关键的原因就是缺乏</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">这样的人才。随着信息化的不断深入发展，中国将需要大量的</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">人才。</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">应当是具备技术背景、业务常识和管理头脑的复合型人才，应该从战略层面上考虑组织的变革和发展。不管是</span><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">出身，还是业务出身，</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">都应该有一个跨学科的系统的教育和培训。</span></p><p style="text-align:left;line-height:19px;text-autospace:ideograph-other;text-align:left;"><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;“</span><span style="font-size:16px;font-family:宋体">山东财经大学</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">（信息总监）班</span><span style="font-size:16px">”</span><span style="font-size:16px;font-family:宋体">就是要采用</span><span style="font-size:16px">MBA</span><span style="font-size:16px;font-family:宋体">案例教学方式，集合山财和业界的顶级专家教授资源，共同培养中国优秀的</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">人才，把</span><span style="font-size:16px">“</span><span style="font-size:16px;font-family:宋体">山财</span><span style="font-size:16px">CIO”</span><span style="font-size:16px;font-family:宋体">打造成培养中国优秀</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">的摇篮！</span><span style="font-size:16px"><br /><br /></span><span style="font-size:16px;font-family:宋体">【招生对象】</span><span style="font-size:16px"><br />1</span><span style="font-size:16px;font-family:宋体">、准备以信息化来提升企业管理水平的总裁、</span><span style="font-size:16px">CEO</span><span style="font-size:16px;font-family:宋体">；</span><span style="font-size:16px"><br />2</span><span style="font-size:16px;font-family:宋体">、负责信息化建设的</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">、信息总监、信息中心主任；</span><span style="font-size:16px"><br />3</span><span style="font-size:16px;font-family:宋体">、企事业单位业务部门中高层管理者；</span><span style="font-size:16px"><br />4</span><span style="font-size:16px;font-family:宋体">、其他从事信息化工作的中高层管理人员。</span><span style="font-size:16px"><br /><br /></span><span style="font-size:16px;font-family:宋体">【学习收益】</span><span style="font-size:16px"><br />1</span><span style="font-size:16px;font-family:宋体">、系统地学习信息化的基本理论与实施方法，拓展自己的事业；</span><span style="font-size:16px"><br />2</span><span style="font-size:16px;font-family:宋体">、结识更多的企业</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">或其他高层管理人员，建立自己重要的人际关系网；</span><span style="font-size:16px"><br />3</span><span style="font-size:16px;font-family:宋体">、通过学员讲课、沙龙活动和案例研讨等，使学员之间可以充分交流和学习；</span></p><p style="text-align:left;line-height:19px;text-autospace:ideograph-other;text-align:left;"><span style="font-size:16px">4</span><span style="font-size:16px;font-family:宋体">、结识很多业界的顶级专家，将自己单位信息化建设中存在的问题向专家咨询；</span><span style="font-size:16px">5</span><span style="font-size:16px;font-family:宋体">、参加山东财经大学</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">论坛活动，通过</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">同学会与各届</span><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">班学员交流。</span><span style="font-size:16px"><br /><br /></span><span style="font-size:16px;font-family:宋体">【核心课程】</span><span style="font-size:16px"><br /><br /></span></p><table style="border-collapse:collapse" border="0" cellpadding="0" cellspacing="0"><tbody><tr style="height:21px"><td colspan="3" style="width:466px;border:solid black 1px;background:#ffff99;padding:0cm 7px 0cm 7px;height:21px" width="466"><p style="background:none repeat scroll 0% 0% #ffff99;vertical-align:middle;text-align:left;"><span style="font-size:16px;background:#ffff99">★</span><span style="font-size:16px;font-family:宋体;background:#ffff99">战略与管理</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息化内涵与作用</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">管理创新</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">战略规划</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">CIO</span><span style="font-size:16px;font-family:宋体">机制与领导力</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">项目管理</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">服务管理</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">治理</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息安全管理</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">知识管理</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">国学思维与管理哲学</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">&nbsp;</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">&nbsp;</span></p></td></tr><tr style="height:21px"><td colspan="3" style="width:466px;border:solid black 1px;border-top:none;background:#ffff99;padding:0cm 7px 0cm 7px;height:21px" width="466"><p style="background:none repeat scroll 0% 0% #ffff99;vertical-align:middle;text-align:left;"><span style="font-size:16px;background:#ffff99">★</span><span style="font-size:16px;font-family:宋体;background:#ffff99">业务与流程</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">ERP</span><span style="font-size:16px;font-family:宋体">的原理与实施</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">CRM</span><span style="font-size:16px;font-family:宋体">的原理与实施</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">SCM</span><span style="font-size:16px;font-family:宋体">的原理与实施</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">电子商务</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">电子政务</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">业务流程管理</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">业务分析与需求管理</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">&nbsp;</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">&nbsp;</span></p></td></tr><tr style="height:21px"><td colspan="3" style="width:466px;border:solid black 1px;border-top:none;background:#ffff99;padding:0cm 7px 0cm 7px;height:21px" width="466"><p style="background:none repeat scroll 0% 0% #ffff99;vertical-align:middle;text-align:left;"><span style="font-size:16px;background:#ffff99">★</span><span style="font-size:16px;font-family:宋体;background:#ffff99">技术与架构</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息技术及应用趋势</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">数据规划与信息架构</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">应用集成与信息门户</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息化总体架构</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">商业智能与决策支持</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">&nbsp;</span></p></td></tr><tr style="height:21px"><td colspan="3" style="width:466px;border:solid black 1px;border-top:none;background:#ffff99;padding:0cm 7px 0cm 7px;height:21px" width="466"><p style="background:none repeat scroll 0% 0% #ffff99;vertical-align:middle;text-align:left;"><span style="font-size:16px;background:#ffff99">★</span><span style="font-size:16px;font-family:宋体;background:#ffff99">绩效与案例</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息化案例研究</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">IT</span><span style="font-size:16px;font-family:宋体">投资与绩效管理</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息系统审计</span></p></td></tr><tr style="height:21px"><td style="width:197px;border:solid black 1px;border-top:none;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">信息工程监理</span></p></td><td style="width:72px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="72"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">沙盘模拟演练</span></p></td><td style="width:197px;border-top:none;border-left:none;border-bottom:solid black 1px;border-right:solid black 1px;padding:0cm 7px 0cm 7px;height:21px" width="197"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px">&nbsp;</span></p></td></tr><tr style="height:21px"><td colspan="3" style="width:466px;padding:0cm 7px 0cm 7px;height:21px" width="466"><p style="text-align:left;text-autospace:ideograph-other;vertical-align:middle;text-align:left;"><span style="font-size:16px;font-family:宋体">（在以上课程基础上将增加制造业信息化和电子政务等行业信息化专题讲座以及各种座谈会和沙龙活动等内容）</span></p></td></tr></tbody></table><p><span style="font-size:16px"><br /><br /></span></p><p style="text-align:left;"><span style="font-size:16px;font-family:宋体">【报名及详情咨询】</span></p><p style="text-align:left;"><span style="font-size:16px;font-family:宋体">联系人：张老师</span><span style="font-size:16px">&nbsp;</span><span style="font-size:16px;font-family:宋体">赵老师</span></p><p style="text-align:left;"><span style="font-size:16px;font-family:宋体">电话：</span><span style="font-size:16px">0531-82917317&nbsp;82917318</span></p><p style="text-align:left;"><span style="font-size:16px;font-family:宋体">传真：</span><span style="font-size:16px">0531-82917319</span></p><p style="text-align:left;"><span style="font-size:16px">Email:&nbsp;<a href="mailto:jrgc@sdfi.edu.cn"><span style="color:#000">jrgc@sdfi.edu.cn</span></a></span></p><p><br /></p>', '【教学背景】   信息技术正深刻地改变着人类的生产和生活方式，人类即将全面进入信息化社会。在与全球经济不断融合的过程中，中国开始步入改革的深化阶段。不管是企业改革还是政府改革，信息化都将在这个现代化进程中起着举足轻重的作用，信息化已成为组织管理变革和流程创新的必然选择。     CIO（Chief ', '', 0, 0, 0, 2, 1, 0, '2012-04-04 10:21:22', '2012-04-04 10:20:49', 0),
(4, '纪柏涛', '培训课程', 'FRM金融风险管理师', '<ul style="list-style-type:disc"><li><span style="font-size:16px;font-family:宋体">什么是</span><span style="font-size:16px">FRM</span><span style="font-size:16px;font-family:宋体">？</span></li></ul><p><span style="font-size:16px">FRM&nbsp;</span><span style="font-size:16px;font-family:宋体">（</span><span style="font-size:16px">Financial&nbsp;Risk&nbsp;Manager</span><span style="font-size:16px;font-family:宋体">）是全球</span><span style="font-size:16px"><a href="http://baike.baidu.com/view/1180190.htm"><span style="font-family:宋体;color:#000">金融风险管理</span></a></span><span style="font-size:16px;font-family:宋体">领域顶级的权威国际资格认证，由</span><span style="font-size:16px"><a href="http://baike.baidu.com/view/2398.htm"><span style="font-family:宋体;color:#000">美国</span></a>“</span><span style="font-size:16px;font-family:宋体">全球风险管理协会</span><span style="font-size:16px">”</span><span style="font-size:16px;font-family:宋体">（</span><span style="font-size:16px">GlobalAssociation&nbsp;of&nbsp;Risk&nbsp;Professionals&nbsp;</span><span style="font-size:16px;font-family:宋体">，简称</span><span style="font-size:16px">GARP</span><span style="font-size:16px;font-family:宋体">）设立。</span></p><p><span style="font-size:16px">GARP</span><span style="font-size:16px;font-family:宋体">是一个拥有来自超过</span><span style="font-size:16px">195</span><span style="font-size:16px;font-family:宋体">个国家的</span><span style="font-size:16px">150000</span><span style="font-size:16px;font-family:宋体">名会员的世界最大的金融协会组织之一，主要分别服务于</span><span style="font-size:16px">5000</span><span style="font-size:16px;font-family:宋体">多家银行、证券公司、学术研究机构、政府管理机构、资产管理机构、保险公司及非金融性公司等。其主要职能是通过信息交换，实施教育计划，提高全世界金融风险管理领域的标准。</span></p><p><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><span style="font-size:16px">FRM</span><span style="font-size:16px;font-family:宋体">影响力如何？</span></li></ul><p><span style="font-size:16px;font-family:宋体">风险管理涵盖众多领域，包括数量分析、市场风险、信用风险、操作风险、基金投资风险、会计、法律、等内容。在今日错综复杂、瞬息万变的金融市场上，风险往往难以掌握。</span></p><p><span style="font-size:16px;font-family:宋体">在金融市场困境或有危机发生时，有效管理风险往往成为企业成功的重要关键。而这一攸关企业组织及其投资人命运的重要决策，需要众多的金融风险管理专业人士</span><span style="font-size:16px">(Financial&nbsp;RiskProfessionals)</span><span style="font-size:16px;font-family:宋体">的参与，故</span><span style="font-size:16px">FRM</span><span style="font-size:16px;font-family:宋体">日益受到重视，全球报考人数以每年超过</span><span style="font-size:16px">38%</span><span style="font-size:16px;font-family:宋体">成长，已俨然成为全球瞩目的国际风险管理证照。在国内正日益受到国家金融监管机构以及各家金融机构的重视</span><span style="font-size:16px">,</span><span style="font-size:16px;font-family:宋体">对金融风险专业人员的需求日益壮大。</span><span style="font-size:16px">&nbsp;2011</span><span style="font-size:16px;font-family:宋体">年全球共有</span><span style="font-size:16px">23324</span><span style="font-size:16px;font-family:宋体">人参加</span><span style="font-size:16px">FRM</span><span style="font-size:16px;font-family:宋体">考试。</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><span style="font-size:16px;font-family:宋体">谁在考</span><span style="font-size:16px">FRM?</span></li></ul><p><span style="font-size:16px;font-family:宋体">金融机构风控人员，金融单位稽核、资产管理者、基金经理人、金融交易员（经纪人）、投资银行业者、商业银行、风险科技业者、风险顾问业者、企业财会与稽核部门、</span><span style="font-size:16px">CFO&nbsp;</span><span style="font-size:16px;font-family:宋体">、</span><span style="font-size:16px">&nbsp;MIS&nbsp;</span><span style="font-size:16px;font-family:宋体">、</span><span style="font-size:16px">&nbsp;CIO&nbsp;</span><span style="font-size:16px;font-family:宋体">。其中大部分为服务于大型企业与金融业工作者为主。</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><span style="font-size:16px">FRM</span><span style="font-size:16px;font-family:宋体">考试的形式及要求？</span></li></ul><p style="line-height:18px;text-autospace:ideograph-other"><a name="(1)考试的形式"><span style="font-size:16px">1)&nbsp;</span></a><span style="font-size:16px;font-family:宋体">考试的形式</span><span style="font-size:16px"><br />FRM</span><span style="font-size:16px;font-family:宋体">考试是一次性考试，一次考试通过并达到其它要求即可取得证书。考试时间为五小时，全部是标准化试题，</span><span style="font-size:16px">140</span><span style="font-size:16px;font-family:宋体">道单项选择题。</span><span style="font-size:16px">GARP</span><span style="font-size:16px;font-family:宋体">建议应考人员复习备考时间约为</span><span style="font-size:16px">14</span><span style="font-size:16px;font-family:宋体">周。</span><span style="font-size:16px"><br />2010</span><span style="font-size:16px;font-family:宋体">年起，</span><span style="font-size:16px">FRM</span><span style="font-size:16px;font-family:宋体">考试将分为</span><span style="font-size:16px">PARTⅠ</span><span style="font-size:16px;font-family:宋体">和</span><span style="font-size:16px">PARTⅡ</span><span style="font-size:16px;font-family:宋体">两级，</span><span style="font-size:16px">PARTⅠ</span><span style="font-size:16px;font-family:宋体">考试时间为上午四小时，全部是标准化试题，</span><span style="font-size:16px">100</span><span style="font-size:16px;font-family:宋体">道单项选择题；</span><span style="font-size:16px">PARTⅡ</span><span style="font-size:16px;font-family:宋体">考试时间为下午四小时，全部是标准化试题，</span><span style="font-size:16px">80</span><span style="font-size:16px;font-family:宋体">道单项选择题。可以同时报考</span><span style="font-size:16px">PARTⅠ</span><span style="font-size:16px;font-family:宋体">和</span><span style="font-size:16px">PARTⅡ</span><span style="font-size:16px;font-family:宋体">两级考试，但是考生只有通过</span><span style="font-size:16px">PARTⅠ</span><span style="font-size:16px;font-family:宋体">，其</span><span style="font-size:16px">PARTⅡ</span><span style="font-size:16px;font-family:宋体">的考试成绩才会被评阅，两级都通过后并达到其他要求方可取得证书。</span><span style="font-size:16px"><br /><br /><a name="（2）对英文水平的要求">2)</a></span><span style="font-size:16px;font-family:宋体">对英文水平的要求</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体">一般大学英语四级即可，另需具备一定的英文的阅读能力，掌握专业词汇。（金程推荐您使用金融风险管理专业词典）</span></p><p style="line-height:18px;text-autospace:ideograph-other"><a name="（3）考试对数学的要求"><span style="font-size:16px">3)&nbsp;</span></a><span style="font-size:16px;font-family:宋体">对数学的要求</span><span style="font-size:16px"><br /></span><span style="font-size:16px;font-family:宋体">一般为经济学专业考研数学难度。主要是概率与统计的内容偏多。</span></p><p style="line-height:18px;text-autospace:ideograph-other"><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><span style="font-size:16px;font-family:宋体">报名及详情咨询</span></li></ul><p><span style="font-size:16px;font-family:宋体">联系人：张老师</span><span style="font-size:16px">&nbsp;</span><span style="font-size:16px;font-family:宋体">赵老师</span></p><p><span style="font-size:16px;font-family:宋体">电话：</span><span style="font-size:16px">0531-82917317&nbsp;82917318</span></p><p><span style="font-size:16px;font-family:宋体">传真：</span><span style="font-size:16px">0531-82917319</span></p><p><span style="font-size:16px">Email:&nbsp;<a href="mailto:jrgc@sdfi.edu.cn"><span style="color:#000">jrgc@sdfi.edu.cn</span></a></span></p>', '什么是FRM？ FRM （Financial Risk Manager）是全球金融风险管理领域顶级的权威国际资格认证，由美国“全球风险管理协会”（GlobalAssociation of Risk Professionals ，简称GARP）设立。 GARP是一个拥有来自超过195个国家的15000', '', 0, 0, 0, 0, 1, 0, '2012-04-04 10:22:03', '2012-04-04 10:21:30', 0),
(5, '纪柏涛', '培训课程', '关于企业高管培训', '<p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px;font-family:宋体">企业经营者是各自所在企业的最高决策或执行人士，其经营管理水平直接决定着企业的发展前景，更关乎着整个社会经济的发展。</span></p><p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px;font-family:宋体">山东省金融信息技术培训中心依托山东财经大学的资源优势，以培养高层次水平与国际化视野的企业高级管理人才，进一步推动中国企业可持续性发展为办学目标，为各企业高级管理者提供高标准的金融、管理、财务培训课程。</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px;font-family:宋体">依据目前中国企业面临的种种困境和社会关注的经济热点问题，我们开设了私募股权基金与企业上市研修班、职业经理高级研修班、经营方略总裁高级研修班、财务总监高级研修班、信息总监高级研修班和企业海外并购高级研修班等一系列专业、权威的顶级课程。</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-size:16px;font-family:宋体">我们的优势：完善的课程体系，强大的师资队伍，独特的教学方法，一流的学习环境在广大学员中有口皆碑。</span></p><p style="text-indent:32px;line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px;font-family:宋体">我们的目标：为学员提供一个学习、交流的优质平台</span></p><p style="text-indent:32px;line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px;font-family:宋体">我们的学员：省内外各企业投资者、董事长、经理、高级主管；各地政府高级官员、主管领导；银行及投融资机构高管；会计师事务所、证券、投资等行业高级管理人员和专业人员。</span></p><p style="line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px;font-family:宋体">　　我们的团队：管理队伍为</span><span style="font-size:16px">80%</span><span style="font-size:16px;font-family:宋体">以上拥有硕士以上学位的金融界精英及业内资深教授，核心成员来自山东财经大学。</span></p><p style="line-height:24px;text-autospace:ideograph-other"><span style="font-size:16px;font-family:宋体">　　我们的理念：您的成功是我们最大的心愿！</span></p><p><span style="font-size:16px">&nbsp;</span></p><p><span style="font-size:16px">&nbsp;</span></p><ul style="list-style-type:disc"><li><p><span style="font-size:16px;font-family:宋体">报名及详情咨询</span></p></li></ul><p><span style="font-size:16px;font-family:宋体">联系人：张老师</span><span style="font-size:16px">&nbsp;&nbsp;</span><span style="font-size:16px;font-family:宋体">赵老师</span></p><p><span style="font-size:16px;font-family:宋体">电话：</span><span style="font-size:16px">0531-82917317&nbsp;82917318</span></p><p><span style="font-size:16px;font-family:宋体">传真：</span><span style="font-size:16px">0531-82917319</span></p><p><span style="font-size:16px">Email:&nbsp;<a href="mailto:jrgc@sdfi.edu.cn"><span style="color:#000">jrgc@sdfi.edu.cn</span></a></span></p>', '    企业经营者是各自所在企业的最高决策或执行人士，其经营管理水平直接决定着企业的发展前景，更关乎着整个社会经济的发展。     山东省金融信息技术培训中心依托山东财经大学的资源优势，以培养高层次水平与国际化视野的企业高级管理人才，进一步推动中国企业可持续性发展为办学目标，为各企业高级管理者提供高', '', 0, 0, 0, 2, 1, 0, '2012-04-04 10:31:38', '2012-04-04 10:31:05', 0),
(6, '纪柏涛', '培训课程', '关于学历培训', '<p><span style="font-family:宋体">山东金融信息技术研究中心与国外多所知名大学合作，推出在</span>MBA<span style="font-family:宋体">、在职研究生、在职博士的培养课程。其办学目的是</span><span style="font-family:宋体;color:black">推动和促进双赢的全球高等教育交流和合作。本学历培训项目的得到了国内母校和政府的有力支持，它将发展成为一个外语环境的教育和研究中心。</span></p><p><span style="font-family:宋体;color:black">&nbsp;</span></p><p><span style="font-family:宋体;color:black">在</span><span style="font-family:宋体">完成教育和科研等各项任务后，学员将获得由国外大学和山东财经大学联合授予的学位。硕、博士生在对方大学里进行</span>1<span style="font-family:宋体">－</span>2<span style="font-family:宋体">年科研与学习，其余时间将在本校完成课程。为了避免课程重复，每所大学认可在对方大学里完成的课程和研究成果。</span></p>', '山东金融信息技术研究中心与国外多所知名大学合作，推出在MBA、在职研究生、在职博士的培养课程。其办学目的是推动和促进双赢的全球高等教育交流和合作。本学历培训项目的得到了国内母校和政府的有力支持，它将发展成为一个外语环境的教育和研究中心。   在完成教育和科研等各项任务后，学员将获得由国外大学和山东财', '', 0, 0, 0, 0, 1, 0, '2012-04-04 10:32:01', '2012-04-04 10:31:28', 0),
(7, '纪柏涛', '培训课程', 'a', '<p>a</p>', 'a', '', 0, 0, 0, 7, 1, 1, '2012-04-04 10:17:22', '2012-04-04 10:16:44', 0),
(8, '纪柏涛', '培训课程', 'b', '<p>b1</p>', 'b1', '', 0, 0, 0, 14, 1, 1, '2012-04-04 10:17:39', '2012-04-04 10:17:01', 0),
(9, '纪柏涛', '培训课程', 'd', '<p>d</p>', 'd', '', 0, 0, 0, 3, 1, 1, '2012-04-04 11:14:50', '2012-04-04 11:14:12', 0),
(10, '纪柏涛', '培训课程', 'e', '<p>e</p>', 'e', '', 0, 0, 0, 3, 1, 1, '2012-04-04 11:14:55', '2012-04-04 11:14:17', 1),
(11, '纪柏涛', '培训课程', 'e', '<p>e</p>', 'e', '', 0, 0, 0, 3, 1, 1, '2012-04-04 11:14:55', '2012-04-04 11:14:17', 1),
(12, '纪柏涛', '校内新闻', 'f', '<p>f</p>', 'f', '', 0, 0, 0, 4, 1, 1, '2012-04-04 11:15:02', '2012-04-04 11:14:25', 0),
(13, '纪柏涛', '校内新闻', 'g', '<p>g</p>', 'g', '', 0, 0, 0, 3, 1, 1, '2012-04-04 11:16:03', '2012-04-04 11:15:26', 0),
(14, '纪柏涛', '校内新闻', 'h', '<p>h</p>', 'h', '', 0, 0, 0, 4, 1, 1, '2012-04-04 11:16:10', '2012-04-04 11:15:33', 0),
(15, '纪柏涛', '培训课程', 'r', '<p>r</p>', 'r', '', 0, 0, 0, 4, 1, 1, '2012-04-04 11:16:16', '2012-04-04 11:15:39', 0);

-- -----------------------------------------------------
-- 文章-分类测试数据
-- -----------------------------------------------------
INSERT INTO `cms_category_article` (`category_id`, `article_id`) VALUES
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(5, 10),
(5, 11),
(3, 12),
(3, 13),
(3, 14),
(5, 15);

-- -----------------------------------------------------
-- 文章-作者测试数据
-- -----------------------------------------------------
INSERT INTO `cms_user_article` (`user_id`, `article_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15);

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
INSERT INTO `cms_image` (`id`, `title`, `image_url`, `description`, `last_modified_date`, `created_date`, `deleted`) VALUES
(1, 'a1a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(2, 'a2a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(3, 'a3a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(4, 'a4a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(5, 'a5a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(6, 'a6a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(7, 'a7a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(8, 'a8a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(9, 'a9a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(10, '0aa', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(11, '1aa', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(12, '2aa', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(13, 'a3a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(14, 'a4a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(15, 'a5a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(16, 'a6a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(17, 'a7a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(18, 'a8a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(19, 'a9a', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(20, '0aa', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0),
(21, '1aa', '13335361515150Ji9VY.jpg', 'aa', '2012-04-04 10:42:31', '2012-04-04 10:42:31', 0);

