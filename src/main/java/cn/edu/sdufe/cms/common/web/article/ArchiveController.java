package cn.edu.sdufe.cms.common.web.article;

import cn.edu.sdufe.cms.common.service.article.ArchiveManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 归类功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-2
 * Time: 上午11:43
 */
@Controller
@RequestMapping(value = "/archive")
public class ArchiveController {

    private ArchiveManager archiveManager;

    /**
     * 显示所有归类信息
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "listAll")
    public String articleListOfArchive(Model model) {
        model.addAttribute("archives", archiveManager.getAllArchive());
        return "article/list";
    }

    @RequestMapping(value = "listByArchiveId/{id}")
    public String articleListByArchiveId(Model model, @PathVariable("id") Long id) {
        model.addAttribute("archive", archiveManager.getArchiveByArchiveId(id));
        return "article/listByArchiveId";
    }

    @Autowired
    public void setArchiveManager(@Qualifier("archiveManager") ArchiveManager archiveManager) {
        this.archiveManager = archiveManager;
    }
}
