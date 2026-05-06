package com.lh.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lh.blog.pojo.Contents;
import com.lh.blog.dao.ContentsMapper;
import com.lh.blog.service.ContentsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Service
public class ContentsServiceImpl extends ServiceImpl<ContentsMapper, Contents> implements ContentsService {
    int pagesize=10;
@Autowired
private ContentsMapper mapper;
    @Override
    public Map<String, Object> querycontentsByPage(int curr) {
        PageHelper.startPage(curr, pagesize);
        PageInfo<Contents> info = new PageInfo(mapper.queryConByPager());
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        map.put("curr",curr);
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }


    @Override
    public Map<String, Object> queryusercontentsByPage(int curr, int uid) {
        PageHelper.startPage(curr, pagesize);
        PageInfo<Contents> info = new PageInfo(mapper.queryuserConByPager(uid));
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        map.put("curr",curr);
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }

    @Override
    public Map<String, Object> queryNewcontentsByPage(int curr) {
        PageHelper.startPage(curr, pagesize);
        PageInfo<Contents> info = new PageInfo(mapper.queryNewContents());
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        map.put("curr",curr);
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }

    @Override
    public Contents queryConByCid(int cid) {
        return mapper.queryConByCid(cid);
    }

    @Override
    public Contents queryUpConByCid(int cid) {
        return mapper.queryUpConByCid(cid);
    }

    @Override
    public Contents queryDuConByCid(int cid) {
        return mapper.queryDuConByCid(cid);
    }

    @Override
    public List<Contents> queryConByType(int mid) {
        return mapper.queryConByType(mid);
    }

    @Override
    public List<Contents> queryConByUser(int uid) {
        return mapper.queryConByUser(uid);
    }

    @Override
    public Map<String, Object> querycontentsByPageIndex(int curr) {
        PageHelper.startPage(curr, pagesize);
        PageInfo<Contents> info = new PageInfo(mapper.queryConByPagerIndex());
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        map.put("curr",curr);
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }

    @Override
    public int queryRedCount() {
        return mapper.queryRedCount();
    }

//    @Override
//    public int queryDayRedCount() {
//        return mapper.queryDayRedCount();
//    }

    @Override
    public int queryDayCount() {
        return mapper.queryDayCount();
    }
}
