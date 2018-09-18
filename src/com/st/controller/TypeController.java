package com.st.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.pojo.Page;
import com.st.pojo.Type;
import com.st.service.ITypeService;

@Controller
public class TypeController {
	
	@Autowired
	ITypeService iTypeService;
	
	@RequestMapping("/manager/addType.action")
	public ModelAndView addType(Type type) {
		ModelAndView mav = new ModelAndView();
		int res=iTypeService.insert(type);
		if(res>0) {
			mav.setViewName("redirect:manageType.action");
		}
		else {
			mav.addObject("error", "添加失败");
			mav.setViewName("WEB-INF/manager/manageType");
		}
		return mav;
	}
	
	@RequestMapping("/selectAllType.action")
	public @ResponseBody Page selectAllType(Page page) {
		return iTypeService.selectAllType(page);
	}
	
	@RequestMapping("/queryByName.action")
	public @ResponseBody Page queryByName(Page page,Type type) {
		page.setWhere(type);
		return iTypeService.queryByName(page);
	}
	
	@RequestMapping("/queryByBigType.action")
	public @ResponseBody Page queryByBigType(Page page,Type type) {
		page.setWhere(type);
		return iTypeService.queryByBigType(page);
	}
	
	@RequestMapping("/queryType.action")
	public @ResponseBody List<Type> queryType() {
		return iTypeService.queryType();
	}
	
	@RequestMapping("/queryBigType.action")
	public @ResponseBody List<Type> queryBigType() {
		return iTypeService.queryBigType();
	}
	
	@RequestMapping("/querySmallType.action")
	public @ResponseBody List<Type> querySmallType(Type type) {
		return iTypeService.querySmallType(type);
	}
	
	@RequestMapping("manager/moType.action")
	public ModelAndView moType(Type type) {
		System.out.println(type.getPid());
		ModelAndView mav = new ModelAndView();
		int res = iTypeService.moType(type);
		if(res>0) {
			mav.setViewName("redirect:manageType.action");
		}
		else {
			mav.addObject("error", "修改失败");
			mav.setViewName("WEB-INF/manager/manageType");
		}
		return mav;
	}

}
