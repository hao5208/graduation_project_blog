package com.lh.blog.service;

import com.lh.blog.pojo.Comments;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface CommentsService extends IService<Comments> {
    Map<String, Object> queryCommentsByPage(int curr);
    Map<String, Object> queryUserCommentsByPage(int curr,String username);

    Map<String, Object> queryNewCommentsByPage(int curr);
//    List<Comments>getCommentsWithTitles(Integer cid);
    Map<String, Object> queryCommentsByPage2(int curr);

    Map<String, Object> queryAll2();

    List<Comments> queryAllByCid(int cid);
    int queryDayCount();
}
