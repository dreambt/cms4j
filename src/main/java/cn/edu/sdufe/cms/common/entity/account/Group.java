package cn.edu.sdufe.cms.common.entity.account;

import cn.edu.sdufe.cms.common.entity.IdEntity;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import java.util.List;

/**
 * 权限组.
 * <p/>
 * 注释见{@link User}.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-20
 * Time: 下午19:55
 */
@Entity
@Table(name = "cms_group")
public class Group extends IdEntity {

    private String groupName;
    //private List<User> userList = Lists.newArrayList();
    private List<String> permissionList = Lists.newArrayList();

    public Group() {
    }

    public Group(Long id, String groupName) {
        super.setId(id);
        this.groupName = groupName;
    }

    @NotBlank
    @Column(nullable = false, unique = true)
    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

//    @ManyToMany(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY, mappedBy = "groupList")
//    @Fetch(FetchMode.SUBSELECT)
//    public List<User> getUserList() {
//        return userList;
//    }
//
//    public void setUserList(List<User> userList) {
//        this.userList = userList;
//    }

    @ElementCollection
    @CollectionTable(name = "cms_group_permission", joinColumns = {@JoinColumn(name = "group_id")})
    @Column(name = "permission")
    public List<String> getPermissionList() {
        return permissionList;
    }

    public void setPermissionList(List<String> permissionList) {
        this.permissionList = permissionList;
    }

    @Transient
    public String getPermissionNames() {
        List<String> permissionNameList = Lists.newArrayList();
        for (String permission : permissionList) {
            permissionNameList.add(Permission.parse(permission).getDisplayName());
        }
        return StringUtils.join(permissionNameList, ",");
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}