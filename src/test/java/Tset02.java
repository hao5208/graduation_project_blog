import com.lh.blog.dao.CommentsMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.InputStream;

public class Tset02 {
    @Test
    public void Test02()throws Exception{
        //1.获得读取MyBatis配置文件的流对象
        InputStream is = Resources.getResourceAsStream("mybatis.xml");

        //2.构建SqlSession连接对象的工厂
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(is);

        //3.通过工厂获得连接对象
        SqlSession sqlSession = factory.openSession();

        CommentsMapper map=sqlSession.getMapper(CommentsMapper.class);


        //map.selectCommentWithArticleTitle(1).stream().forEach(System.out::println);

        //int a=map.deleteByPrimaryKey(52);
//        map.selectByPageTitle(2).stream().forEach(System.out::println);
        sqlSession.commit();
        //System.out.println(a);
    }
}
