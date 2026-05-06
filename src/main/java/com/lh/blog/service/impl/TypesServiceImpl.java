package com.lh.blog.service.impl;

import com.lh.blog.pojo.Types;
import com.lh.blog.dao.TypesMapper;
import com.lh.blog.service.TypesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
public class TypesServiceImpl extends ServiceImpl<TypesMapper, Types> implements TypesService {

}
