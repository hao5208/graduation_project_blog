package com.lh.blog.dao;

import com.lh.blog.pojo.Users;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author lh
 * @since 2024-03-19
 */
public interface UsersMapper extends BaseMapper<Users> {
    @Select("SELECT count(*) FROM users WHERE created >= CURDATE()")
    int queryDayCount();
}
