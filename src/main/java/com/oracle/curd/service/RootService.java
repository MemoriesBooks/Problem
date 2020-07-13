package com.oracle.curd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.curd.bean.Root;
import com.oracle.curd.dao.RootDao;

@Service
public class RootService {

	@Autowired // 自动装配
	private RootDao rootDao;

	// 登录查找管理员
	public Root findRoot(String rootcode, String rootpassword) {
		// TODO Auto-generated method stub
		Root root = this.rootDao.findRoot(rootcode, rootpassword);
		return root;
	}

}
