package com.st.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.st.pojo.Manager;
import com.st.pojo.Oorder;
import com.st.pojo.Page;
import com.st.pojo.User;
import com.st.service.IGoodsService;
import com.st.service.IManagerService;
import com.st.service.IOrderService;
import com.st.service.IUserService;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	@Autowired
	IManagerService iManagerService;
	@Autowired
	IUserService iUserService;
	@Autowired
	IOrderService iOrderService;
	
	@RequestMapping("/login.action")
	public ModelAndView login(Manager manager,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Manager reManager=iManagerService.login(manager);
		if(reManager!=null) {
			session.setAttribute("manager", reManager);
			mav.setViewName("redirect:indexView.action");
		}
		else {
			mav.addObject("error", "账户名或密码错误！");
			mav.setViewName("managerLogin");
		}
		return mav;
	}
	
	@RequestMapping("indexView.action")
	public String indexView() {
		return "WEB-INF/manager/index";
	}
	
	@RequestMapping("/manageUser.action")
	public String manageUser() {
		return "WEB-INF/manager/manageUser";
	}
	
	@RequestMapping("/selectAllUser.action")	
	public @ResponseBody Page selectAllUser(Page page) {
		return iManagerService.selectAllUser(page);
	}
	
	@RequestMapping("/moUser.action")
	public ModelAndView moUser(User user,String repassword) {
		ModelAndView mav = new ModelAndView();
		int res1= iUserService.modifyPW(user.getPassword(), repassword, user.getUid());
		int res2= iUserService.moState(user);
		if(res2<=0) {
			mav.addObject("error2", "状态修改失败");
		}
		if(res1==-100) {
			mav.addObject("error1", "两次密码都必须输入");
			mav.setViewName("WEB-INF/manager/manageUser");
		}
		else if (res1==-200) {
			mav.addObject("error1", "两次密码输入不一致");
			mav.setViewName("WEB-INF/manager/manageUser");
		}
		else {
			mav.setViewName("redirect:manageUser.action");
		}
		return mav;
	}
	
	@RequestMapping("/moPWView.action")
	public String moPWView() {
		return "WEB-INF/manager/moPW";
	}
	
	@RequestMapping("/moPW.action")
	public ModelAndView moPW(String password,String repassword,HttpSession session ) {
		ModelAndView mav = new ModelAndView();
		Manager manager = (Manager) session.getAttribute("manager");
		int res=iManagerService.moPW(password, repassword, manager);
		if(res==-100) {
			mav.addObject("error", "两次密码都必须输入");
			mav.setViewName("WEB-INF/manager/moPW");
		}
		else if (res==-200) {
			mav.addObject("error", "两次密码输入不一致");
			mav.setViewName("WEB-INF/manager/moPW");
		}
		else if(res<0) {
			mav.addObject("error", "未知错误");
			mav.setViewName("WEB-INF/manager/moPW");
		}
		else {
			session.removeAttribute("session");
			mav.setViewName("redirect:../managerLogin.jsp");
		}
		return mav;
	}
	
	@RequestMapping("/exit.action")
	public ModelAndView exit(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("manager");
		mav.setViewName("redirect:../managerLogin.jsp");
		return mav;
	}
	
	@RequestMapping("/manageType.action")
	public String manageType() {
		return "WEB-INF/manager/manageType";
	}
	
	@RequestMapping("/queryByName")
	public @ResponseBody User queryByName(User user) {
		return iUserService.selectByName(user);
	}
	
	@RequestMapping("/orderView.action")
	public String orderView() {
		return "WEB-INF/manager/order";
	}
	
	@RequestMapping("/getAllOrder.action")
	public @ResponseBody Page getAllOrder(Page page ) {
		return iOrderService.getAllOrder(page);
	}
	
	@RequestMapping("/queryOrderByName.action")
	public @ResponseBody Page queryOrderByName(Page page,String username) {
		User user = new User();
		user.setUsername(username);
		User reUser = iUserService.selectByName(user);
		if(reUser!=null) {
			Oorder oorder = new Oorder();
			oorder.setUid(reUser.getUid());
			page.setWhere(oorder);
			page=iOrderService.getOrder(page);			
		}
		return page;		
	}
	
	@RequestMapping("/getOneOrder.action")
	public @ResponseBody Oorder getOneOrder(Oorder oorder) {
		return iOrderService.getOneOrder(oorder);
	}
	
	@RequestMapping("/queryOrderByDate.action")
	public @ResponseBody Page queryOrderByDate(Page page,String startDate,String endDate) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date start = simpleDateFormat.parse(startDate);
			Date end = simpleDateFormat.parse(endDate);
			page=iOrderService.queryOrderByDate(page,start,end);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return page;
	}
	
	@RequestMapping("/initIndex.action")
	public @ResponseBody HashMap<String,Object> initIndex(){
		return iManagerService.initIndex();
	}
	
	@RequestMapping("/latestOrders.action")
	public @ResponseBody List<Oorder> latestOrders(){
		return iOrderService.latestOrders();
	}
	
}
