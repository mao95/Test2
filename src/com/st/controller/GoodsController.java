package com.st.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.st.pojo.Goods;
import com.st.pojo.Iorder;
import com.st.pojo.Oorder;
import com.st.pojo.Page;
import com.st.pojo.User;
import com.st.service.IGoodsService;
import com.st.service.IOrderService;

@Controller
public class GoodsController {
	
	@Autowired
	IGoodsService iGoodsService;
	@Autowired
	IOrderService iOrderService;
	
	@RequestMapping("/manager/manageGoods.action")
	public String manageGoods() {
		return "WEB-INF/manager/manageGoods";
	}
	
	@RequestMapping("/manager/addGoods.action")
	public ModelAndView addGoods(@RequestParam HashMap<String, Object> goods,MultipartFile pic,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(!("".equals(pic.getOriginalFilename()))){
			String savePath=request.getServletContext().getRealPath("/upLoad");
			String fileName=pic.getOriginalFilename();
			String suffix=fileName.substring(fileName.lastIndexOf("."));
			fileName=new Date().getTime() +suffix;
			InputStream inputStream=null;
			OutputStream outputStream=null;
			try {
				inputStream = pic.getInputStream();
				outputStream = new FileOutputStream(savePath+"/"+fileName);
				IOUtils.copy(inputStream, outputStream);
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				if(inputStream!=null) {
					try {
						inputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if(outputStream!=null) {
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			goods.put("img", fileName);
		}
		else {
			goods.put("img", "");
		}
		int res= iGoodsService.insert(goods);
		if(res>0) {
			mav.setViewName("redirect:manageGoods.action");
		}
		else {
			mav.setViewName("redirect:manageGoods.action?error=添加失败");//试试能否返回
		}
		return mav;
	}
	
	@RequestMapping("/manager/updateGoods.action")
	public ModelAndView updateGoods(@RequestParam HashMap<String, Object> goods,MultipartFile pic,HttpServletRequest request) {
		if(!("".equals(pic.getOriginalFilename()))){
			String savePath=request.getServletContext().getRealPath("/upLoad");
			String fileName=pic.getOriginalFilename();
			String suffix=fileName.substring(fileName.lastIndexOf("."));
			fileName=new Date().getTime() +suffix;
			InputStream inputStream=null;
			OutputStream outputStream=null;
			try {
				inputStream = pic.getInputStream();
				outputStream = new FileOutputStream(savePath+"/"+fileName);
				IOUtils.copy(inputStream, outputStream);
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				if(inputStream!=null) {
					try {
						inputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if(outputStream!=null) {
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			goods.put("img", fileName);
		}
		else {
			goods.put("img", "");
		}
		ModelAndView mav = new ModelAndView();
		int res= iGoodsService.update(goods);
		if(res>0) {
			mav.setViewName("redirect:manageGoods.action");
		}
		else {
			mav.setViewName("redirect:manageGoods.action?error=修改失败");//试试能否返回
		}
		return mav;
	}
	
	@RequestMapping("/selectAllGoods.action")
	public @ResponseBody Page selectAllGoods(Page page){
		return iGoodsService.selectAllGoods(page);
	}
	
	@RequestMapping("/queryLike.action")
	public @ResponseBody Page queryLike(Page page,Goods goods){
		page.setWhere(goods);
		return iGoodsService.queryLike(page);
	}
	
	@RequestMapping("/manager/deleteGoods.action")
	public ModelAndView deleteGoods(int gid) {
		ModelAndView mav = new ModelAndView();
		int res = iGoodsService.delete(gid);
		if(res>0) {
			mav.setViewName("redirect:manageGoods.action");
		}
		else {
			mav.setViewName("redirect:manageGoods.action?error=删除失败");
		}
		return mav;
	}

	@RequestMapping("/search.action")
	public String search() {
		return "WEB-INF/goods/search";
	}
	
	@RequestMapping("/getGoodsView.action")
	public String getGoodsView() {
		return "WEB-INF/goods/goods";
	}
	
	@RequestMapping("/getGoods.action")
	public @ResponseBody Goods getGoods(int gid) {
		return iGoodsService.selectByGid(gid);
	}
	
	@RequestMapping("/getCart.action")
	public String getCart() {
		return "WEB-INF/user/cart";
	}
	
	@RequestMapping("/user/pay.action")
	public ModelAndView pay(Oorder oorder,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Integer> list= new ArrayList<>();
		for (Iorder iorder : oorder.getList()) {
			list.add(iorder.getGid());
		}
		User user = (User) session.getAttribute("user");
		oorder.setUid(user.getUid());
		try {
			iOrderService.pay(oorder);
		}catch (Exception e) {
			mav.addObject("error", e.getMessage());
			mav.setViewName("error");
			return mav;
		}
		mav.addObject("list", list);
		mav.setViewName("WEB-INF/user/order");
		return mav;
	}
	
	@RequestMapping("/user/getOrder.action")
	public @ResponseBody Page getOrder(Page page,HttpSession session){
		User user = (User) session.getAttribute("user");
		int uid = user.getUid();
		Oorder oorder = new Oorder();
		oorder.setUid(uid);
		page.setWhere(oorder);
		page=iOrderService.getOrder(page);
		return page;
	}
	
	@RequestMapping("/user/orderView.action")
	public String orderView() {
		return "WEB-INF/user/order";
	}
	
	@RequestMapping("/user/getOneOrder.action")
	public @ResponseBody Oorder getOneOrder(Oorder oorder) {
		return iOrderService.getOneOrder(oorder);
	}
	
	
	
	
	
}
