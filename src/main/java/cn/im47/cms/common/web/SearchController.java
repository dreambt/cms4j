package cn.im47.cms.common.web;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 搜索控制器
 * User: baitao.jibt@gmail.com
 * Date: 12-3-20
 * Time: 上午12:06
 */
@RequestMapping(value = "/search")
public class SearchController {

    @RequestMapping(value = "{keyWords}/{value}", method = RequestMethod.GET)
    public String search(@PathVariable("keyWords") String keyWords, @PathVariable("value") String value) {
        // TODO 搜索
        return "searchResult";
    }

}
