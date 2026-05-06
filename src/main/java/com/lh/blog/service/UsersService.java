package com.lh.blog.service;

import com.lh.blog.pojo.Users;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface UsersService extends IService<Users> {
    public int login(Users user);

    public int seluid(String username);

    public Users seluser(String username);

    int queryDayCount();
}
