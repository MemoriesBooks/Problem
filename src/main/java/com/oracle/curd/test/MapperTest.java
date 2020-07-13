package com.oracle.curd.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.oracle.curd.bean.Department;
import com.oracle.curd.bean.Employee;
import com.oracle.curd.dao.DepartmentMapper;
import com.oracle.curd.dao.EmployeeMapper;

/**
 * 编写测试类，我们使用SpringJunit
 * @author zxy
 *1.导入SpringTest的JAR包
 *2.使用@ContextConfiguration指定Spring的配置文件的位置
 *3.使用@RunWith设置采用Spring的Junit进行测试
 *4.直接使用@Autowired自动装配我们需要使用的类即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	SqlSession sqlSession;
	@Test
	public void test(){
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++){
			String name = UUID.randomUUID().toString().substring(0, 5)+i;
			Employee emp = new Employee();
			emp.setEmpName(name);
			emp.setEmail(name+"@oracle.com");
			emp.setdId(1);
			if(i%2==0){
				emp.setGender("M");
			}else{
				emp.setGender("F");
			}
			employeeMapper.insertSelective(emp);
		}
		System.out.println("批量完成");
	}
}
