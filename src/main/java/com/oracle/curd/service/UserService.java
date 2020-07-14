package com.oracle.curd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.curd.bean.Record;
import com.oracle.curd.bean.User;
import com.oracle.curd.dao.UserDao;

/**
 * 业务层接口实体方法
 */
@Service
public class UserService {
	// 注入UserDao
	@Autowired
	private UserDao userDao;

	// 登录查找用户
	public User findUser(String usercode, String password) {
		User user1 = new User();
		user1.setUser_code(usercode);
		user1.setUser_password(password);
		System.out.println(user1);
		User user = this.userDao.findUser(user1);
		System.out.println("user:" + user);
		return user;
	}

	// 注册新用户
	public void addUser(String usercode, String username, String userpassword, String userage, String usersex) {
		userDao.addUser(usercode, username, userpassword, userage, usersex);

	}

	public void addRecord(Record r) {
		System.out.println(r);
		userDao.addRecord(r);
	}
}
