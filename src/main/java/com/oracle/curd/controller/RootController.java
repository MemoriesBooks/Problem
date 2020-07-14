package com.oracle.curd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.oracle.curd.bean.Customer;
import com.oracle.curd.bean.Root;
import com.oracle.curd.service.CustomerService;
import com.oracle.curd.service.RootService;

@Controller
public class RootController {
	// 管理员控制层
	@Autowired
	private RootService rootService;
	@Autowired
	private CustomerService customerService;

	/**
	 * 管理员登录操作
	 */
	@RequestMapping(value = "root_login", method = RequestMethod.POST)
	public String login(String rootcode, String rootpassword, Model model, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String verifycode = request.getParameter("verifycode");
		session = request.getSession();
		String CHECKCODE_SERVER = (String) session.getAttribute("CHECKCODE_SERVER");
		session.removeAttribute("CHECKCODE_SERVER"); // 一次性的验证码使用
		if (!CHECKCODE_SERVER.equalsIgnoreCase(verifycode)) {
			model.addAttribute("msg", "验证码输入错误");
			return "root_login";
		}
		// ͨ将前端获得的rootcode,rootpassword传入到findRoot方法中，返回获得一个值
		System.out.println(rootcode + rootpassword);

		Root root = rootService.findRoot(rootcode, rootpassword);
		if (root != null) {
			// 将获得的数据存储到session中
			session.setAttribute("ROOT_SESSION", root);
			// 重定向跳转到root_check
//					return "customer";
//					List<Customer> customer=customerService.selectCustomerLiset();
//					model.addAttribute("customerList", customer);
			return "redirect:root_check";
		}
		model.addAttribute("msg", "账号或密码错误");
		// 错误跳转到管理员登录界面
		return "root_login";
	}

//			@RequestMapping(value="/enduser")
//			public String enduser(HttpSession session){
//			    //���Session
//				session.invalidate();
//				//�ض��򵽵�¼ҳ�����ת����
//				return "redirect:login";
//			}
//			@RequestMapping(value = "/login", method = RequestMethod.GET)
//			public String toLogin() {
//			    return "login";
//			}
	// 执行查询所有用户操作将所有用户信息传到前端
	@RequestMapping(value = "root_check")
	public String getAllUser(HttpServletRequest request, Model model) {
		// selectCustomerList方法
		List<Customer> customer = customerService.selectCustomerLiset();
		// 测试打印获取的数据
		System.out.print("is" + customer);
		// 将信息存到Model,request响应
		model.addAttribute("customerList", customer);
		request.setAttribute("customerList", customer);
		// 跳转到root界面
		return "root";
	}

	// 执行单个查询
	@RequestMapping(value = "getuser")
	public String find_id(String userid, Model model, HttpSession session) {
		// ͨ调用findCustomer将前端userid赋值给到此方法里
		Customer customer_user = customerService.findCustomer(userid);
		// 判断是否查找到信息
		if (customer_user != null) {
			session.setAttribute("customer_user", customer_user);
			return "redirect:customer_update";
		}

		return "root";
	}

	// 执行修改操作
	@RequestMapping(value = "/customer_update_get", method = RequestMethod.GET)
	public String update_customer(Customer customer, HttpServletRequest request, Model model) {
		// 判断是否更改信息
		if (customerService.update_customer(customer)) {

			customer = customerService.findCustomer(Integer.toString(customer.getUser_id()));
			// 重定向跳转到root_check查询所有用户
			return "redirect:root_check";
		}
		return "root";
	}

	// 执行删除操作
	@RequestMapping(value = "/deleteuser")
	public String delete(int delet_userid, Model model, HttpSession session) {
		// ͨ根据用户Id执行删除操作

		if (customerService.delete_customer(delet_userid)) {
			// 重定向跳转到root_check搜索全部用户
			return "redirect:root_check";
		}

		return "redirect:root_check";
	}

	// 退出管理员界面
	@RequestMapping(value = "/endroot")
	public String enduser(HttpSession session) {
		// 清空session中的值
		session.invalidate();
		// 跳转RequestMapping root_login
		return "redirect:root_login";
	}

	// 重定向跳转到管理员登录界面
	@RequestMapping(value = "root_login", method = RequestMethod.GET)
	public String toLogin() {
		return "root_login";
	}

	@RequestMapping(value = "user_zhuce", method = RequestMethod.GET)
	public String user_zhuce() {
		return "user_zhuce";
	}

	@RequestMapping(value = "customer_update", method = RequestMethod.GET)
	public String customer_update() {
		return "customer_update";
	}
}
