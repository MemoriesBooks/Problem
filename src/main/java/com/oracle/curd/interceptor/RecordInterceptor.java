package com.oracle.curd.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.curd.service.UserService;
import com.oracle.curd.util.DateUtil;
import com.oracle.curd.bean.Record;
import com.oracle.curd.bean.Root;
import com.oracle.curd.bean.User;

public class RecordInterceptor implements HandlerInterceptor {

	@Autowired
	private UserService service;

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		System.out.println("Constomer afterCompletion");
		HttpSession session = request.getSession();
		User user = new User();
		user = (User) session.getAttribute("USER_SESSION");
		Root root = new Root();
		root = (Root) session.getAttribute("ROOT_SESSION");
		String event = null;

		try {
			event = user.getUser_name() + "登录了后台！";
			System.out.println(event);
			DateUtil today = new DateUtil();
			String event_time = today.getDate();
			String event_ip = request.getRemoteAddr();
			Record r = new Record();
			r.setEvent(event);
			r.setEvent_time(event_time);
			r.setEvent_ip(event_ip);
			System.out.println(r);
			service.addRecord(r);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			event = root.getRoot_name() + "登录了后台！";
			System.out.println(event);
			DateUtil today = new DateUtil();
			String event_time = today.getDate();
			String event_ip = request.getRemoteAddr();
			Record r = new Record();
			r.setEvent(event);
			r.setEvent_time(event_time);
			r.setEvent_ip(event_ip);
			System.out.println(r);
			service.addRecord(r);
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		System.out.println("Constomer preHandle");
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		System.out.println("Constomer postHandle");
	}

}
