package cn.im47.cms.common.data;

import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.entity.category.Category;
import org.joda.time.DateTime;
import org.springside.modules.test.data.RandomData;

/**
 * Article相关实体测试数据生成.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-4-1
 * Time: 上午11:03
 */
public class ArticleData {

    private static final String ArticleSuffix = "Article";

    public static Article getRandomArticle() {
        String subject = RandomData.randomName(ArticleSuffix);
        String message = RandomData.randomName(ArticleSuffix);

        Article article = new Article();
        article.setId(1L);

        Category category = CategoryData.getRandomCategory();
        article.setCategory(category);
        article.setSubject(subject);
        article.setMessage(message);
        article.setDigest("");
        article.setKeyword("");
        article.setUrl("jbt");
        article.setStatus(true);
        DateTime now = new DateTime();
        article.setCreatedDate(now);
        article.setLastModifiedDate(now);
        return article;
    }

}