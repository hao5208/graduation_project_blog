package com.lh.blog.common;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.datasource.pooled.PooledDataSourceFactory;

public class DBUtil extends PooledDataSourceFactory {
    public DBUtil(){
        this.dataSource = new DruidDataSource();//替换数据源
    }
}
