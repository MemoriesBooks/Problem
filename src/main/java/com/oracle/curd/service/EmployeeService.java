package com.oracle.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.curd.bean.Employee;
import com.oracle.curd.bean.EmployeeExample;
import com.oracle.curd.bean.EmployeeExample.Criteria;
import com.oracle.curd.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDepartment(null);
	}
	public void saveEmp(Employee emp){
		employeeMapper.insertSelective(emp);
	}
	public boolean checkEmp(String name){
		//创建EmployeeExample增加查询条件
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(name);
		long count = employeeMapper.countByExample(example);
		return count==0;
	}
	public Employee getEmp(Integer id){
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	public void updateEmp(Employee employee){
		employeeMapper.updateByPrimaryKey(employee);
	}
	public void deleteEmp(Integer id){
		employeeMapper.deleteByPrimaryKey(id);
	}
	public void deleteEmpBatch(List<Integer> ids){
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
}
