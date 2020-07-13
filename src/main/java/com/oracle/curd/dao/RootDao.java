package com.oracle.curd.dao;

import org.apache.ibatis.annotations.Param;

import com.oracle.curd.bean.Root;

public interface RootDao {
	//管理员dao登录接口层
	public Root findRoot(@Param("rootcode") String rootcode,@Param("password") String rootpassword);
	
}
