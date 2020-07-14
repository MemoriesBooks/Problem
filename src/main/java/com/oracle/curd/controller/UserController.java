package com.oracle.curd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.oracle.curd.bean.User;
import com.oracle.curd.service.UserService;

@Controller
public class UserController {
	// User
	@Autowired
	private UserService userService;

	/**
	 * UserService实例
	 */
	// 用户登录操作
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(String usercode, String password, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String verifycode = request.getParameter("verifycode");
		session = request.getSession();
		String CHECKCODE_SERVER = (String) session.getAttribute("CHECKCODE_SERVER");
		session.removeAttribute("CHECKCODE_SERVER"); // 一次性的验证码使用
		if (!CHECKCODE_SERVER.equalsIgnoreCase(verifycode)) {
			model.addAttribute("msg", "验证码输入错误");
			return "login";
		}
		
		// 调用Dao层方法
		User user = userService.findUser(usercode, password);
		System.out.println(user);
		System.out.println(usercode + password);
		if (user != null) {
			// 从dao层那边查询的数据加入Session
			session.setAttribute("USER_SESSION", user);
			// 跳转到主页面
			// return "customer";
			return "redirect:customer";
		}
		model.addAttribute("msg", "密码或账号输入错误");
		// 错误返回到登录页面
		return "login";
	}

	// 用户退出操作
	@RequestMapping(value = "enduser")
	public String enduser(HttpSession session) {
		// 清除Session
		session.invalidate();
		// 重定向到login
		return "redirect:login";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String toLogin() {
		return "login";
	}

	// 用户注册操作
	@RequestMapping(value = "createuser", produces = "text/plain;charset=utf-8")
	public String add(String usercode, String username, String userpassword, String userage, String usersex,
			Model model, HttpSession session) {
		System.out.println(username);
		model.addAttribute("msg", "注册成功");
		userService.addUser(usercode, username, userpassword, userage, usersex);
		return "login";
	}
	
	@RequestMapping(value = "customer", method = RequestMethod.GET)
	public String customer() {
		return "customer";
	}

}
