package com.st.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.mapper.GoodsMapper;
import com.st.mapper.ManagerMapper;
import com.st.mapper.UserMapper;
import com.st.pojo.Goods;
import com.st.pojo.Manager;
import com.st.pojo.Page;
import com.st.pojo.User;
import com.st.service.IManagerService;

@Service

public class ManagerServiceImpl implements IManagerService{
	
	@Autowired
	ManagerMapper managerMapper;
	@Autowired
	UserMapper userMapper;
	@Autowired
	GoodsMapper goodsMapper;

	@Override
	public Manager login(Manager manager) {
		return managerMapper.login(manager);
	}

	@Override
	public Page selectAllUser(Page page) {
		List<User> list = userMapper.selectAllUser(page);
		page.setList(list);
		page.setTotalRows(userMapper.allUserCount());
		return page;
	}

	@Override
	public int moPW(String password, String repassword, Manager manager) {
		if("".equals(password)||"".equals(repassword)) {
			return -100;
		}
		if(repassword.equals(password)) {
			manager.setPassword(password);
			return managerMapper.moPW(manager);
		}
		else {
			return -200;
		}
	}

	@Override
	public HashMap<String, Object> initIndex() {
		List<Goods> goodsList = goodsMapper.allGoods();
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("goodsCount", goodsList.size());
		Double totalIncome=0.0;
		Integer totalSell=0;
		for (Goods goods : goodsList) {
			totalSell+=goods.getSales();
			totalIncome+=goods.getPrice()*goods.getSales();
		}
		hashMap.put("totalIncome", totalIncome);
		hashMap.put("totalSell", totalSell);
		hashMap.put("userCount", userMapper.allUserCount());
		return hashMap;
	}

}
