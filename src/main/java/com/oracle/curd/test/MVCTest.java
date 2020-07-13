package com.oracle.curd.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.oracle.curd.bean.Employee;
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatch-servlet.xml"})
public class MVCTest {

	//创建一个虚拟的MVC请求，获取处理的结果
	MockMvc mockMvc;
	//创建一个SpringMVC的IOC容器
	@Autowired
	WebApplicationContext context;
	@Before
	public void initMockMVc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception{
		//模拟get请求并获取返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		//请求成功之后，获取请求域中的数据
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
		System.out.println("当前页码:"+pageInfo.getPageNum());
		System.out.println("总页码:"+pageInfo.getPages());
		System.out.println("总记录数:"+pageInfo.getTotal());
		System.out.println("当前连续显示的页码:");
		int[] nums = pageInfo.getNavigatepageNums();
		for(int num:nums){
			System.out.print(" "+num);
		}
		System.out.println();
		List<Employee> emps = pageInfo.getList();
		for(Employee emp:emps){
			System.out.println(emp.getEmpId()+":"+emp.getEmpName());
		}
	}
}
