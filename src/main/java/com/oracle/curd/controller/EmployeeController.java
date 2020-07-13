package com.oracle.curd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oracle.curd.bean.Employee;
import com.oracle.curd.bean.Msg;
import com.oracle.curd.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	@RequestMapping(value="/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
		//在查询之前引入PageHelper分页插件，只需要指定当前的页码，每一页查询的数量即可
		PageHelper.startPage(pn, 5);
		//紧跟着startPage()方法的查询就是分页的查询
		List<Employee> emps = employeeService.getAll();
		//使用PageInfo包装查询过的结果，pageInfo中包含我们需要的分页的信息，例如当前的页码、是否存在前一页、是否存在后一页等等信息
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee emp,BindingResult result){
		if(result.hasErrors()){
			//定义一个Map集合保存错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error:errors){
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			System.out.println("执行保存"+emp);
			employeeService.saveEmp(emp);
			return Msg.success();
			
		}
	}
	@RequestMapping(value="/checkEmp")
	@ResponseBody
	public Msg checkEmp(@RequestParam(value="empName")String empName){
		//定义正则表达式
		String reg = "^[0-9a-zA-Z][0-9a-zA-Z_.-]{2,16}[0-9a-zA-Z]$";
		if(!empName.matches(reg)){
			return Msg.fail().add("va_msg", "用户名格式不正确");
		}
		boolean b = employeeService.checkEmp(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
		}
	}
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable(value="id") Integer id){
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
		
	}
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee){
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			String[] str_ids = ids.split("-");
			List<Integer> list = new ArrayList<Integer>();
			for(String s:str_ids){
				list.add(Integer.parseInt(s));
			}
			employeeService.deleteEmpBatch(list);
		}else{
			employeeService.deleteEmp(Integer.parseInt(ids));
			
		}
		return Msg.success();
	}
	
}
