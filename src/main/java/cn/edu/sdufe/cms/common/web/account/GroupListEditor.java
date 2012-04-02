package cn.edu.sdufe.cms.common.web.account;

import cn.edu.sdufe.cms.common.entity.account.Group;
import cn.edu.sdufe.cms.common.service.account.GroupManager;
import com.google.common.collect.Lists;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springside.modules.utils.Collections3;

import java.beans.PropertyEditorSupport;
import java.util.List;

/**
 * 用于转换用户表单中复杂对象Group的checkbox的关联。
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-3-18
 * Time: 下午8:57
 */
@Component
public class GroupListEditor extends PropertyEditorSupport {

    private GroupManager groupManager;

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        String[] ids = StringUtils.split(text, ",");
        List<Group> groups = Lists.newArrayList();
        for (String id : ids) {
            Group group = groupManager.getGroup(Long.valueOf(id));
            groups.add(group);
        }
        setValue(groups);
    }

    @Override
    public String getAsText() {
        return Collections3.extractToString((List) getValue(), "id", ",");
    }

    @Autowired
    public void setGroupManager(@Qualifier("groupManager") GroupManager groupManager) {
        this.groupManager = groupManager;
    }
}