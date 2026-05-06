package com.lh.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lh.blog.pojo.Contents;
import com.lh.blog.pojo.Files;
import com.lh.blog.dao.FilesMapper;
import com.lh.blog.service.FilesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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
public class FilesServiceImpl extends ServiceImpl<FilesMapper, Files> implements FilesService {
    int pagesize=10;
@Autowired
private FilesMapper mapper;
    @Override
    public Map<String, Object> queryFilesByPage(int curr) {
        PageHelper.startPage(curr, pagesize);
        PageInfo<Contents> info = new PageInfo(mapper.queryFilesByPage());
        Map<String,Object> map = new HashMap<>();
        //总页数
        map.put("pages",info.getPages());
        //总记录
        map.put("counts",info.getTotal());
        //数据
        map.put("records",info.getList());

        return map;
    }
}
