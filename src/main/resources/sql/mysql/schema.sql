SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `cms4j` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cms4j` ;

-- -----------------------------------------------------
-- Table `cms4j`.`cms_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_category` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_category` (
  `catid` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '栏目ID' ,
  `upid` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '上级栏目ID' ,
  `catname` VARCHAR(255) NOT NULL COMMENT '栏目名称' ,
  `articles` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '文章数' ,
  `allowcomment` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否允许评论' ,
  `displayorder` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '显示顺序' ,
  `notinheritedarticle` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否继承上下文文章管理权限' ,
  `notinheritedblock` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否继承上下文模块管理权限' ,
  `url` VARCHAR(255) NOT NULL DEFAULT 0 COMMENT '自定义链接地址' ,
  `uid` MEDIUMINT(8) NOT NULL DEFAULT 0 COMMENT '添加人id' ,
  `username` VARCHAR(255) NOT NULL COMMENT '添加人用户名' ,
  `addtime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '添加时间' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否关闭' ,
  `shownav` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否在头部导航中显示' ,
  `description` TEXT NOT NULL COMMENT 'SEO描述' ,
  `keyword` TEXT NOT NULL COMMENT 'SEO关键字' ,
  `allowpublish` TINYINT(1) NOT NULL COMMENT '是否允许发布文章' ,
  `showtype` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '显示方式0列表1摘要2正文3相册' ,
  `createtime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '0' ,
  `modifytime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '0' ,
  PRIMARY KEY (`catid`) ,
  INDEX `fk_upid_catid` (`upid` ASC) )
ENGINE = InnoDB
COMMENT = '栏目表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_user` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_user` (
  `uid` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id' ,
  `email` VARCHAR(40) NOT NULL COMMENT '电子邮箱' ,
  `username` VARCHAR(15) NOT NULL COMMENT '用户名' ,
  `password` CHAR(32) NOT NULL COMMENT '密码' ,
  `salt` CHAR(6) NOT NULL COMMENT '密码加强' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '用户状态0未审核1已审核' ,
  `emailstatus` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '邮箱验证状态 未认证= 0 认证= 1' ,
  `avatarstatus` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否有头像 0没有 1有' ,
  `photourl` VARCHAR(255) NOT NULL COMMENT '头像地址' ,
  `regtime` TIMESTAMP NOT NULL COMMENT '注册时间' ,
  `timeoffset` CHAR(4) NOT NULL COMMENT '时区' ,
  `newprompt` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '有新提醒' ,
  `adminid` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '所属管理组id' ,
  `groupid` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '所属用户组id' ,
  `groupexpiry` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '用户组有效期' ,
  `createtime` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  `modifytime` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  PRIMARY KEY (`uid`) )
ENGINE = InnoDB
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_article` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_article` (
  `aid` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子ID' ,
  `catid` MEDIUMINT(8) NOT NULL ,
  `uid` MEDIUMINT(8) NOT NULL ,
  `isfirst` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否是首贴' ,
  `username` VARCHAR(15) NOT NULL COMMENT '用户名' ,
  `subject` VARCHAR(80) NOT NULL COMMENT '标题' ,
  `posttime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '发帖时间' ,
  `message` MEDIUMTEXT NOT NULL COMMENT '帖子内容' ,
  `postip` INT(10) NOT NULL COMMENT '发帖ip' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '帖子审核状态' ,
  `anonymous` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否使用匿名发帖' ,
  `attachment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否有附件' ,
  `rate` SMALLINT(6) NOT NULL DEFAULT 0 COMMENT '评分分数' ,
  `ratetimes` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '评分次数' ,
  `deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已删除' ,
  `tags` VARCHAR(255) NOT NULL DEFAULT 0 COMMENT '帖子标签' ,
  `comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否存在点评' ,
  `count` TINYINT(3) NOT NULL DEFAULT 0 COMMENT '浏览次数' ,
  `createtime` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  `modifytime` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  PRIMARY KEY (`aid`) ,
  INDEX `fk_cms_artical_cms_category1` (`catid` ASC) ,
  INDEX `fk_cms_artical_cms_user1` (`uid` ASC) )
ENGINE = InnoDB
COMMENT = '文章表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_user_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_user_log` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_user_log` (
  `uid` MEDIUMINT(8) NOT NULL ,
  `regip` INT(10) NOT NULL COMMENT '注册ip' ,
  `lastip` INT(10) NOT NULL COMMENT '最近访问ip' ,
  `lasttime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '最近访问时间' ,
  `lastacttime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '最近活动时间' ,
  `createtime` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  `modifytime` TIMESTAMP NOT NULL DEFAULT 549567296 ,
  PRIMARY KEY (`uid`) ,
  INDEX `fk_cms_member_status_cms_user` (`uid` ASC) )
ENGINE = InnoDB
COMMENT = '用户状态表';


-- -----------------------------------------------------
-- Table `cms4j`.`cms_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_comment` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_comment` (
  `cid` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论ID' ,
  `aid` MEDIUMINT(8) NOT NULL ,
  `username` VARCHAR(255) NOT NULL COMMENT '用户名' ,
  `postip` INT(10) NOT NULL COMMENT '评论IP' ,
  `posttime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '评论时间' ,
  `status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '0=未审核 1=已审核  2=可删除' ,
  `message` TEXT NOT NULL COMMENT '评论内容' ,
  `createtime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '表格创建时间' ,
  `modifytime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '表格修改时间' ,
  PRIMARY KEY (`cid`) ,
  INDEX `fk_cms_comment_cms_artical1` (`aid` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cms4j`.`cms_manage_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cms4j`.`cms_manage_log` ;

CREATE  TABLE IF NOT EXISTS `cms4j`.`cms_manage_log` (
  `logid` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理日志ID' ,
  `uid` MEDIUMINT(8) NOT NULL ,
  `username` VARCHAR(255) NOT NULL COMMENT '用户名' ,
  `action` TINYINT(1) NOT NULL COMMENT '0=创建菜单 1=修改菜单 2=移动菜单 3=删除菜单 4=发表文章 5=修改文章 6=审核文章 7=删除文章 8=添加用户 9=修改用户信息 10=审核用户 11=删除用户' ,
  `createtime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '表格创建时间' ,
  `modifytime` TIMESTAMP NOT NULL DEFAULT 549567296 COMMENT '表格修改时间' ,
  PRIMARY KEY (`logid`) ,
  INDEX `fk_cms_log_cms_user1` (`uid` ASC) )
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
