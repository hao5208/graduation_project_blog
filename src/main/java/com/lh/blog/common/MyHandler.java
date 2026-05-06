package com.lh.blog.common;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MyHandler extends BaseTypeHandler<String[]> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, String[] strings, JdbcType jdbcType) throws SQLException {
        ps.setString(i,String.join(",",strings));
    }

    @Override
    public String[] getNullableResult(ResultSet rs, String s) throws SQLException {
        System.out.println(s);
        String[] ss = rs.getString(s).split(",");
        return ss;
    }

    @Override
    public String[] getNullableResult(ResultSet rs, int i) throws SQLException {
        System.out.println(i);
        String[] s = rs.getString(i).split(",");
        return s;
    }

    @Override
    public String[] getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
        return new String[0];
    }
}
