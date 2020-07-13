package com.oracle.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.curd.bean.Customer;
import com.oracle.curd.dao.CustomerDao;

@Service
public class CustomerService {
	// 注入CustomerDao接口
	@Autowired
	private CustomerDao customerDao;

	// 查找全部用户
	public List<Customer> selectCustomerLiset() {
		// TODO Auto-generated method stub
		List<Customer> customer = customerDao.selectCustomerLiset();
		return customer;
	}

	// 查找单个用户
	public Customer findCustomer(String custid) {
		// TODO Auto-generated method stub
		Customer customer_user = this.customerDao.findCustomer(custid);
		return customer_user;
	}

	// 修改用户信息
	public boolean update_customer(Customer customer) {
		// TODO Auto-generated method stub
		return customerDao.update_customer(customer);
	}

	// 删除用户信息
	public boolean delete_customer(int custid) {
		// TODO Auto-generated method stub
		return customerDao.delete_customer(custid);
	}

}
