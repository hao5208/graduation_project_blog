package com.lh.blog.dao;

import com.lh.blog.pojo.Files;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface FilesMapper extends BaseMapper<Files> {
    List<Files> queryFilesByPage();

}
