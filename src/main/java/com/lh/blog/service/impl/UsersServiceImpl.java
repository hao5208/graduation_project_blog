package com.lh.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.lh.blog.pojo.Users;
import com.lh.blog.dao.UsersMapper;
import com.lh.blog.service.UsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements UsersService {


    @Autowired
    private UsersMapper mapper;
    @Override
    public int login(Users user) {
        Users u=mapper.selectOne(new QueryWrapper<Users>().eq("username",user.getUsername()));
        if (u==null){
            return 1;
        }else {
            if (user.getPassword().equals(u.getPassword())){
                if (u.getStatus()==1){
                    //更新登录时间
                    mapper.updateById(new Users(u.getUid(), new Date()));
                    System.out.println(new Date()+"----------------------------------------------------------------");
                    return 3;
                }else {
                    return 0;
                }
            }else {
                return 2;
            }
        }

    }

    @Override
    public int seluid(String username) {
        Users u=mapper.selectOne(new QueryWrapper<Users>().eq("username",username));
        return u.getUid();
    }

    @Override
    public Users seluser(String username) {
        return mapper.selectOne(new QueryWrapper<Users>().eq("username",username));
    }

    @Override
    public int queryDayCount() {
        return mapper.queryDayCount();
    }
}
