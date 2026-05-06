package com.lh.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lh.blog.dao.ContentsMapper;
import com.lh.blog.pojo.Comments;
import com.lh.blog.dao.CommentsMapper;
import com.lh.blog.pojo.Contents;
import com.lh.blog.service.CommentsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
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
public class CommentsServiceImpl extends ServiceImpl<CommentsMapper, Comments> implements CommentsService {
    int pagesize=10;
    @Autowired
    private CommentsMapper mapper;
    @Autowired
    private ContentsMapper mapper2;
    @Override
    public Map<String, Object> queryCommentsByPage(int curr) {
        PageHelper.startPage(curr,pagesize);
       // PageInfo info = new PageInfo(list());
        PageInfo<Comments> info = new PageInfo(mapper.selectByPager());
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }

    @Override
    public Map<String, Object> queryUserCommentsByPage(int curr,String username) {
        PageHelper.startPage(curr,pagesize);
        // PageInfo info = new PageInfo(list());
        PageInfo<Comments> info = new PageInfo(mapper.selectUserByPager(username));
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }

    @Override
    public Map<String, Object> queryNewCommentsByPage(int curr) {
        PageHelper.startPage(curr,pagesize);
        // PageInfo info = new PageInfo(list());
        PageInfo<Comments> info = new PageInfo(mapper.selectNewByPager());
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        //数据
        map.put("records",info.getList());
        System.out.println("-------------------------------");
        System.out.println(info.getList());
        return map;
    }

    @Override
    public Map<String, Object> queryCommentsByPage2(int curr) {

        PageHelper.startPage(curr,pagesize);
        PageInfo<Comments> info = new PageInfo(mapper.selectByPager());
        System.out.println(info.getList());
        return null;
    }

    @Override
    public Map<String, Object> queryAll2() {
        PageHelper.startPage(2,pagesize);
        PageInfo<Comments> info = new PageInfo(mapper.queryAll1());
        System.out.println(info.getList());
        return null;
    }

    @Override
    public List<Comments> queryAllByCid(int cid) {
        return mapper.queryAllByCid(cid);
    }

    @Override
    public int queryDayCount() {
        return mapper.queryDayCount();
    }


}
