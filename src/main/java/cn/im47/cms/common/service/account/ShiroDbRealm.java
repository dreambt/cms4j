package cn.im47.cms.common.service.account;

import cn.im47.cms.common.entity.account.Group;
import cn.im47.cms.common.entity.account.User;
import cn.im47.cms.common.service.account.impl.UserManagerImpl;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.utils.Encodes;

import javax.annotation.PostConstruct;
import java.io.Serializable;

/**
 * 自实现用户与权限查询.
 * User: baitao.jibt@gmail.com
 * Date: 12-3-18
 * Time: 下午13:59
 */
public class ShiroDbRealm extends AuthorizingRealm {

    protected UserManager userManager;

    /**
     * 认证回调函数, 登录时调用.
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        CaptchaUsernamePasswordToken token = (CaptchaUsernamePasswordToken) authcToken;
        User user = userManager.findUserByEmail(token.getUsername());

        //验证码 验证
        String captcha = null;
        Session session = SecurityUtils.getSubject().getSession();

        Object obj_captcha = session.getAttribute("PATCHCA");
        Object obj_count = session.getAttribute("LOGIN_FAILED_COUNT");
        int failed_count = (obj_count == null || !(obj_count instanceof Integer)) ? 0 : (Integer) obj_count;
        if (obj_captcha instanceof String) {
            captcha = (String) obj_captcha;
        }

        if (captcha == null || failed_count > 2 || !captcha.equalsIgnoreCase(token.getCaptcha())) {
            session.setAttribute("LOGIN_FAILED_COUNT", ++failed_count);
            throw new AuthenticationException("请检查您输入的账户、密码、验证码是否正确.");
        }

        if (null != user) {
            // 已标记为删除的账户
            if (user.isDeleted()) {
                session.setAttribute("LOGIN_FAILED_COUNT", ++failed_count);
                throw new UnknownAccountException("请检查您输入的账户、密码、验证码是否正确.");
            }

            // 未审核的账户
            if (!user.isStatus()) {
                session.setAttribute("LOGIN_FAILED_COUNT", ++failed_count);
                throw new DisabledAccountException("未经审核的账户不允许登录.");
            }

            byte[] salt = Encodes.decodeHex(user.getSalt());
            return new SimpleAuthenticationInfo(new ShiroUser(user.getId(), user.getEmail(), user.getUsername(), user.getGroupList().get(0).getGroupName()), user.getPassword(),
                    ByteSource.Util.bytes(salt), getName());
        } else {
            return null;
        }
    }

    /**
     * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        User user = userManager.get(shiroUser.getId());

        if (null != user) {
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

            //基于Permission的权限信息
            for (Group group : user.getGroupList()) {
                //基于Permission的权限信息
                info.addStringPermissions(group.getPermissionList());
            }

            // 更新用户登录时间
            userManager.updateLastTime(user.getId());

            // 清空登录失败计数
            Session session = SecurityUtils.getSubject().getSession();
            session.setAttribute("LOGIN_FAILED_COUNT", 0);
            return info;
        } else {
            return null;
        }
    }

    /**
     * 更新用户授权信息缓存.
     */
    public void clearCachedAuthorizationInfo(String principal) {
        SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
        clearCachedAuthorizationInfo(principals);
    }

    /**
     * 设定Password校验的Hash算法与迭代次数.
     */
    @PostConstruct
    public void initCredentialsMatcher() {
        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(UserManagerImpl.HASH_ALGORITHM);
        matcher.setHashIterations(UserManagerImpl.HASH_INTERATIONS);

        setCredentialsMatcher(matcher);
    }

    /**
     * 清除所有用户授权信息缓存.
     */
    public void clearAllCachedAuthorizationInfo() {
        Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
        if (cache != null) {
            for (Object key : cache.keys()) {
                cache.remove(key);
            }
        }
    }

    @Autowired
    public void setUserManager(UserManager userManager) {
        this.userManager = userManager;
    }

    /**
     * 自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息.
     */
    public static class ShiroUser implements Serializable {
        private static final long serialVersionUID = -1373760761780840081L;
        private Long id;
        private String loginName;
        private String name;
        private String groupName;

        public ShiroUser(Long id, String loginName, String name, String groupName) {
            this.id = id;
            this.loginName = loginName;
            this.name = name;
            this.groupName = groupName;
        }

        public Long getId() {
            return id;
        }

        public String getLoginName() {
            return loginName;
        }

        public String getName() {
            return name;
        }

        public String getGroupName() {
            return groupName;
        }

        /**
         * 本函数输出将作为默认的<shiro:principal/>输出.
         */
        @Override
        public String toString() {
            return loginName;
        }

        /**
         * 重载equals,只计算loginName;
         */
        @Override
        public int hashCode() {
            return HashCodeBuilder.reflectionHashCode(this, "loginName");
        }

        /**
         * 重载equals,只比较loginName
         */
        @Override
        public boolean equals(Object obj) {
            return EqualsBuilder.reflectionEquals(this, obj, "loginName");
        }
    }
}
