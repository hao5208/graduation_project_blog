import com.lh.blog.service.impl.CommentsServiceImpl;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestMp {
    @Test
    public void test() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");

        CommentsServiceImpl service=(CommentsServiceImpl)applicationContext.getBean("commentsServiceImpl");
       // service.list().stream().forEach(System.out::println);
        //service.getCommentsWithTitles(1).stream().forEach(System.out::println);
        service.queryCommentsByPage2(1);
//        service.queryAll2();
    }
}
