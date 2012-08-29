package cn.im47.cms.common.data;

import cn.im47.cms.common.entity.article.Article;
import cn.im47.cms.common.entity.article.Category;
import cn.im47.cms.common.entity.article.Comment;
import com.google.common.collect.Lists;
import org.joda.time.LocalDateTime;
import org.springside.modules.test.data.RandomData;

import java.util.List;

/**
 * Article相关实体测试数据生成.
 * <p/>
 * User: baitao.jibt (dreambt@gmail.com)
 * Date: 12-4-1
 * Time: 上午11:03
 */
public class ArticleData {

    private static final String ArticleSuffix = "Article";

    private static List<Comment> defaultCommentList = null;

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
        LocalDateTime now = new LocalDateTime();
        article.setCreatedDate(now);
        article.setLastModifiedDate(now);
        return article;
    }

    public static List<Comment> getDefaultCommentList() {
        if (defaultCommentList == null) {
            defaultCommentList = Lists.newArrayList();
            Comment comment = new Comment();
            comment.setUsername("纪柏涛");
            comment.setPostIP(134744072L);
            comment.setStatus(true);
            comment.setDeleted(false);
            comment.setMessage("看完这个文章以后，我的心久久不能平静，震撼啊！为什么会有如此好的文章！我纵横网络多年，自以为再也不会有任何文章能打动我，没想到今天看到了如此精妙绝伦的这样一篇文章。朋飞，是你让我深深地理解了‘人外有人，天外有天’这句话。谢谢侬！在看完这文章以后，我没有立即回复，因为我生怕我庸俗不堪的回复会玷污了这少有的文章。但是我还是回复了，因为觉得如果不能在如此精彩的文章后面留下自己的网名，那我死也不会瞑目的！能够在如此精彩的文章后面留下自己的网名是多么骄傲的一件事啊！朋飞，请原谅我的自私！我知道无论用多么华丽的辞藻来形容楼主您文章的精彩程度都是不够的，都是虚伪的，所以我只想说一句：您的文章太好看了！我愿意一辈子的看下去！这篇文章构思新颖，题材独具匠心，段落清晰，情节诡异，跌宕起伏，主线分明，引人入胜，平淡中显示出不凡的文学功底，可谓是字字珠玑，句句经典，是我辈应当学习之典范。就小说艺术的角度而言，这篇文章不算太成功，但它的实验意义却远远大于成功本身。正所谓：“一马奔腾，射雕引弓，天地都在我心中！”朋飞真不愧为无厘界新一代的开山怪！本来我已经对这个世界失望了，觉得这个世界没有前途了，心里充满了悲哀。但是看了你的这个文章，又让我对世界产生了希望。是你让我的心里重新燃起希望之火，是你让我的心死灰复燃，是你拯救了我一颗拨凉拨凉的心！本来我决定不会看任何文章了，但是看了你的文章，我告诉自己这个文章是一定要回的！这是百年难得一见的好文章啊！苍天有眼啊，让我在有生之年得以观得如此精彩绝伦的文章！");
            defaultCommentList.add(comment);
            comment.setUsername("董鹏飞");
            defaultCommentList.add(comment);
            comment.setUsername("邓小兰");
            defaultCommentList.add(comment);
        }
        return defaultCommentList;
    }

    public static Comment getRandomDefaultComment() {
        return RandomData.randomOne(getDefaultCommentList());
    }

}