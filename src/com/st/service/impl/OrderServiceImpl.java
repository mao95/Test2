package com.st.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.mapper.GoodsMapper;
import com.st.mapper.OrderMapper;
import com.st.mapper.UserMapper;
import com.st.pojo.Goods;
import com.st.pojo.Iorder;
import com.st.pojo.Oorder;
import com.st.pojo.Page;
import com.st.service.IOrderService;

@Service
public class OrderServiceImpl implements IOrderService{
	
	@Autowired
	UserMapper userMapper;
	@Autowired
	GoodsMapper goodsMapper;
	@Autowired
	OrderMapper orderMapper;

	@Override
	public void pay(Oorder oorder) {
		double price=0.0;
		for (Iorder iorder : oorder.getList()) {
			Goods goods =goodsMapper.selectByGid(iorder.getGid());
			iorder.setSinglePrice(goods.getPrice());
			iorder.setGname(goods.getName());
			iorder.setImg(goods.getImg());
			double temp=iorder.getAmount()*iorder.getSinglePrice();
			iorder.setTotalPrice(temp);
			price+=temp;
			try {
				goodsMapper.sell(iorder.getGid(), iorder.getAmount());//库存减少
			}catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("库存不足！");
			}
			
		}
		oorder.setTotalPrice(price);
		try {
			userMapper.pay(oorder.getUid(), oorder.getTotalPrice());//扣除用户余额
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("余额不足，请及时充值！");
		}
		try {
			orderMapper.insertO(oorder);//插入订单
			for (Iorder iorder : oorder.getList()) {
				iorder.setOnumber(oorder.getOnumber());
				orderMapper.insertI(iorder);//插入订单详情
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("未知错误，购买失败!");
		}
		
	}

	@Override
	public Page getOrder(Page page) {
		List<Oorder> list = orderMapper.getOrder(page);
		System.out.println(list);
		page.setList(list);
		page.setTotalRows(orderMapper.count(page));
		return page;
	}

	@Override
	public Oorder getOneOrder(Oorder oorder) {
		return orderMapper.getOneOrder(oorder);
	}

	@Override
	public Page getAllOrder(Page page) {
		List<Oorder> list = orderMapper.getAllOrder(page);
		page.setList(list);
		page.setTotalRows(orderMapper.allOrderCount());
		return page;
	}

	@Override
	public Page queryOrderByDate(Page page, Date start, Date end) {
		List<Oorder> list = orderMapper.queryOrderByDate(page, start, end);
		page.setList(list);
		page.setTotalRows(orderMapper.countByDate(start, end));
		return page;
	}

	@Override
	public List<Oorder> latestOrders() {
		return orderMapper.latestOrders();
	}

}
