package com.lh.blog.service;

import com.lh.blog.pojo.Contents;
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
public interface ContentsService extends IService<Contents> {
    Map<String, Object> querycontentsByPage(int curr);


    Map<String, Object> queryusercontentsByPage(int curr,int uid);
    Map<String, Object> queryNewcontentsByPage(int curr);
    Contents queryConByCid(int cid);

    Contents queryUpConByCid(int cid);
    Contents queryDuConByCid(int cid);

    List<Contents> queryConByType(int mid);
    List<Contents> queryConByUser(int uid);

    Map<String, Object> querycontentsByPageIndex(int curr);

    int queryRedCount();

//    int queryDayRedCount();
    int queryDayCount();

}
