package com.oracle.curd.dao;

import org.apache.ibatis.annotations.Param;

import com.oracle.curd.bean.User;
import com.oracle.curd.bean.Record;

public interface UserDao {
	// 用户登录注册层
	public User findUser(User user);// 登录方法@Param是为属性取另一个名字，方便数据库语法中赋值

	public void addUser(@Param("usercode") String usercode, @Param("username") String username,
			@Param("userpassword") String password, @Param("userage") String userage, @Param("usersex") String usersex);// 注册方法
	// 添加登录日志信息

	public void addRecord(Record r);
}
