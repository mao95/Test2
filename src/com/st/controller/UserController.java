package com.st.controller;

import java.io.ByteArrayOutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.st.pojo.Address;
import com.st.pojo.Cart;
import com.st.pojo.Page;
import com.st.pojo.User;
import com.st.service.IUserService;
import com.st.util.VerifyCode;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	IUserService iUserService;	
	
//	@RequestMapping("/loginView.action")
//	public String loginView() {
//		return "login";
//	}
	@RequestMapping("/login.action")
	public ModelAndView login(User user,String remember,HttpSession session,String verify,HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String scode=(String) session.getAttribute("code");
		verify=verify.toLowerCase();
		scode=scode.toLowerCase();
		if(scode.equals(verify)) {
			User tempUser=iUserService.selectByName(user);
			if(tempUser==null) {
				mav.addObject("error", "账户不存在");
				mav.setViewName("login");
			}
			else {
				if(tempUser.getState()==0) {
					mav.addObject("error", "账号异常，请咨询管理员");
					mav.setViewName("login");
				}else {
					int counter=tempUser.getCounter();
					Date currentDate=new Date();
					Date lastDate=tempUser.getErrorDate();
					long currentMs=currentDate.getTime();
					long lastMs=lastDate.getTime();
					long Dvalue=currentMs-lastMs;
					if(counter>=5&&Dvalue<=300000) {
						mav.addObject("error", "错误次数太多，稍后再试");
						mav.setViewName("login");
					}
					else {
						String username=user.getUsername();
						String password=user.getPassword();
						User reUser=iUserService.login(user);
						if(reUser==null) {	
							System.out.println(Dvalue);
							if(Dvalue<=60000) {
								iUserService.inCounter(tempUser);
							}
							else {
								iUserService.reCounter(tempUser);
							}
							tempUser.setErrorDate(currentDate);
							iUserService.moErrorDate(tempUser);
							mav.addObject("error", "密码错误");
							mav.setViewName("login");
						}
						else {
							if("true".equals(remember)) {
								Cookie ckUsername= new Cookie("username", username);
								Cookie ckPassword= new Cookie("password", password);
								ckUsername.setPath(request.getContextPath());
								ckPassword.setPath(request.getContextPath());
								ckUsername.setMaxAge(100000);
								ckPassword.setMaxAge(100000);
								response.addCookie(ckUsername);
								response.addCookie(ckPassword);
							}
							iUserService.reCounter(reUser);
							session.setAttribute("user", reUser);
							mav.setViewName("redirect:../index.jsp");
						}
					}
				}		
			}		
		}
		else {
			mav.addObject("error", "验证码错误");
			mav.setViewName("login");
		}
		
		return mav;
	}
	@RequestMapping("/exit.action")
	public String exit(HttpSession session) {
		session.removeAttribute("user");
		return "index";
	}
	@RequestMapping("/register.action")
	public ModelAndView register(User user,String repassword) {
		int res=iUserService.register(user,repassword);
		ModelAndView modelAndView=new ModelAndView();
		if(res==-100) {
			modelAndView.addObject("error", "密码输入不合法");
			modelAndView.setViewName("register");
		}
		else if(res==-200){
			modelAndView.addObject("error", "两次密码输入不一致");
			modelAndView.setViewName("register");
		}
		else if(res==-300){
			modelAndView.addObject("error", "用户名已存在");
			modelAndView.setViewName("register");
		}
		else {
			modelAndView.setViewName("redirect:../login.jsp");
		}
		return modelAndView;
	}
	
	@RequestMapping("/verify.action")
	public void verify(HttpServletResponse response,HttpSession session) {
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		String code = VerifyCode.getCodeImg(output);
		session.setAttribute("code", code);

		try {
			// 从response上获取一个输出流
			ServletOutputStream out = response.getOutputStream();
			// 将图片写入到输入流中
			output.writeTo(out);

		} catch (Exception e) {
			// TODO: handle exception
		}		
	}
	
	@RequestMapping("/indexView.action")
	public String indexView() {
		return "WEB-INF/user/index";
	}
	
	@RequestMapping("/selfInfoView.action")
	public String selfInfoView() {
		return "WEB-INF/user/selfInfo";
	}
	
	@RequestMapping("/update.action")
	public ModelAndView update(User user) {
		ModelAndView mav = new ModelAndView();
		int res=iUserService.update(user);
		if(res>0) {
			mav.setViewName("redirect:selfInfoView.action");
		}
		else {
			mav.addObject("error", "修改失败");
			mav.setViewName("WEB-INF/user/selfInfo");
		}
		return mav;
	}
	@RequestMapping("/moPWView.action")
	public String moPWView() {
		return "WEB-INF/user/moPW";
	}
	@RequestMapping("/moPW.action")
	public ModelAndView moPW(User user,String repassword) {
		ModelAndView mav = new ModelAndView();
		int res=iUserService.modifyPW(user.getPassword(), repassword, user.getUid());
		if(res>0) {
			mav.setViewName("WEB-INF/user/index");
		}
		else if(res==-100){
			mav.addObject("error", "两次密码都必须输入");
			mav.setViewName("WEB-INF/user/moPW");
		}
		else if(res==-200){
			mav.addObject("error", "两次密码不一致");
			mav.setViewName("WEB-INF/user/moPW");
		}
		else {
			mav.addObject("error", "未知错误");
			mav.setViewName("WEB-INF/user/moPW");
		}
		return mav;
	}
	
	@RequestMapping("/querySelf.action")
	public @ResponseBody User querySelf(HttpSession session){
		User user = (User) session.getAttribute("user");
		User reUser = iUserService.selectByName(user);
		return reUser;
	}
	
	@RequestMapping("/manageAddressView.action")
	public String manageAddressView() {
		return "WEB-INF/user/address";
	}
	
	@RequestMapping("/deleteAddress.action")
	public ModelAndView deleteAddress(int aid) {
		int res=iUserService.deleteAddress(aid);
		ModelAndView mav = new ModelAndView();
		if(res>0) {
			mav.setViewName("redirect:manageAddressView.action");
		}
		else {
			mav.addObject("error", "删除失败");
			mav.setViewName("WEB-INF/user/address");//能否做弹出框提示错误
		}
		return mav;
	}
	
	@RequestMapping("/inAddress.action")
	public ModelAndView inAddress(Address address) {
		int res=iUserService.inAddress(address);
		ModelAndView mav = new ModelAndView();
		if(res>0) {
			mav.setViewName("redirect:manageAddressView.action");
		}
		else {
			mav.addObject("error", "添加失败");
			mav.setViewName("WEB-INF/user/address");//能否做弹出框提示错误
		}
		return mav;
	}
	
	@RequestMapping("/moAddress.action")
	public ModelAndView moAddress(Address address) {
		int res=iUserService.moAddress(address);
		ModelAndView mav = new ModelAndView();
		if(res>0) {
			mav.setViewName("redirect:manageAddressView.action");
		}
		else {
			mav.addObject("error", "修改失败");
			mav.setViewName("WEB-INF/user/address");//能否做弹出框提示错误
		}
		return mav;
	}
	
	@RequestMapping("/selectAllAddress.action")
	public @ResponseBody Page selectAllAddress(Page page,Address address) {
		page.setWhere(address);
		page = iUserService.selectAllAddress(page);
		return page;
	}
	
	@RequestMapping("/showAllAddress.action")
	public @ResponseBody List<Address> showAllAddress(int  uid) {
		List<Address> list = iUserService.queryAddress(uid);
		return list;
	}
	
	@RequestMapping("/inCart.action")
	@ResponseBody
	public int inCart(Cart cart,HttpSession session) {
		User user = (User) session.getAttribute("user");
		cart.setUid(user.getUid());
		iUserService.inCart(cart);
		List<Cart> list = iUserService.queryAllCart(cart);
		int res = list.size();
		return res;
	}
	
	@RequestMapping("/recharge.action")
	public ModelAndView recharge(HttpSession session,double money) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("user");
		int res= iUserService.recharge(user,money);
		if(res>0) {
			mav.setViewName("redirect:selfInfoView.action");
		}else {
			mav.addObject("error", "充值失败");
			mav.setViewName("WEB-INF/user/selfInfo");
		}
		return mav;
	}
	
	@RequestMapping("/initIndex.action")
	@ResponseBody
	public HashMap<String, Object> initIndex(HttpSession session){
		User user = (User) session.getAttribute("user");
		return iUserService.initIndex(user);
	}
}
