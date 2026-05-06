package com.lh.blog.service;

import com.lh.blog.pojo.Files;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface FilesService extends IService<Files> {
    Map<String, Object> queryFilesByPage(int curr);
}
