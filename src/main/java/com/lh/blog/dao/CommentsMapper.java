package com.lh.blog.dao;

import com.github.pagehelper.IPage;
import com.lh.blog.pojo.Comments;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.sql.Wrapper;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface CommentsMapper extends BaseMapper<Comments> {
//@Select("select a.*,b.* from comments a,contents b where a.cid=b.cid")
    List<Comments> selectByPager();
    List<Comments> selectUserByPager(String username);
    List<Comments> selectNewByPager();

    List<Comments> queryAll1();

    List<Comments> queryAllByCid(int cid);

    @Select("SELECT count(*) FROM comments WHERE created >= CURDATE()")
    int queryDayCount();

}
