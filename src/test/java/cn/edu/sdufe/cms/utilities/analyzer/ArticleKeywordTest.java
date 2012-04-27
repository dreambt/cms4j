package cn.edu.sdufe.cms.utilities.analyzer;

import org.junit.Assert;
import org.junit.Test;

/**
 * 类功能
 * User: pengfei.dongpf@gmail.com
 * Date: 12-3-23
 * Time: 下午1:49
 */
public class ArticleKeywordTest {
    @Test
    public void testTestAnalyzer() throws Exception {
        ArticleKeyword articleKeyword = new ArticleKeyword();
        String text1 = "<html><head><title>2012年山东财经大学在职中级金融学博士生班</title></head>";
        String text2 = "<p><span style=\"font-size:16px\">证券发行上市保荐制度是我国证券发行制度的一次革命性变革，它是中国证监会根据我国“新兴加转轨”的市场特点，从资本市场发展的全局出发，推出的旨在进一步保护投资者特别是公众投资者的合法权益、提高上市公司质量的重要举措。</span><span style=\"font-size:16px\"><br />&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-size:16px\">保荐制度直接导致了证券公司必须通过对保荐人的争抢来注册保荐机构资格，否则其承销项目将不会获得审发。根据证监会的规定，每家承销商必须拥有两个（含两个）以上的保荐人才能够获取该资格。</span></p><p><span style=\"font-size:16px\">&nbsp;</span></p><p><span style=\"font-size:16px\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-size:16px\">保荐人考试的通过率总体而言还是相当低的，";
        Assert.assertNotNull(articleKeyword.getArticleKeyword(text1, text2, 0));
    }
}
