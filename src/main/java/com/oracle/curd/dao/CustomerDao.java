package com.oracle.curd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.oracle.curd.bean.Customer;

public interface CustomerDao {
	//对用户操作dao接口层
	public List<Customer> selectCustomerLiset(); //全部用户信息,以List形式存储
	public Customer findCustomer(@Param("cust_id") String custid); //查找单个用户信息,将信息加入Customer中
	boolean update_customer(Customer customer);//修改用户信息
	boolean delete_customer(int custid); //根据id删除对应的用户
}
