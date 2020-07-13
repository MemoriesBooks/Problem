package com.oracle.curd.intercector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.curd.service.UserService;
import com.oracle.curd.util.DateUtil;
import com.oracle.curd.bean.Record;

public class RecordInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		return true;
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		HttpSession session = request.getSession();
		String event = (String) session.getAttribute("username") + "登录了后台！";
		DateUtil today = new DateUtil();
		String event_time = today.getDate();
		String event_ip = request.getRemoteAddr();
		Record r = new Record();
		r.setEvent(event);
		r.setEvent_time(event_time);
		r.setEvent_ip(event_ip);
		UserService service = new UserService();
		service.addRecordService(r);
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}

}
