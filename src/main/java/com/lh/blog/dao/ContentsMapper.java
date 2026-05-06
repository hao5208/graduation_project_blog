package com.lh.blog.dao;

import com.lh.blog.pojo.Comments;
import com.lh.blog.pojo.Contents;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface ContentsMapper extends BaseMapper<Contents> {
List<Contents> queryConByPager();
    List<Contents> queryuserConByPager(int uid);
List<Contents> queryNewContents();
Contents queryConByCid(int cid);

Contents queryUpConByCid(int cid);
Contents queryDuConByCid(int cid);

    List<Contents> queryConByType(int mid);

    List<Contents> queryConByUser(int uid);


    List<Contents> queryConByPagerIndex();

    @Select("SELECT sum(readingcount) FROM contents")
    int queryRedCount();

//    @Select("SELECT sum(readingcount) FROM contents WHERE created >= CURDATE()")
//    int queryDayRedCount();

    @Select("SELECT count(*) FROM contents WHERE created >= CURDATE()")
    int queryDayCount();
}
