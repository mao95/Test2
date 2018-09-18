package com.st.service.impl;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.st.mapper.AddressMapper;
import com.st.mapper.CartMapper;
import com.st.mapper.OrderMapper;
import com.st.mapper.UserMapper;
import com.st.pojo.Address;
import com.st.pojo.Cart;
import com.st.pojo.Oorder;
import com.st.pojo.Page;
import com.st.pojo.User;
import com.st.service.IUserService;
import com.st.util.MD5Util;

@Service
public class UserServiceImpl implements IUserService {
	
	@Autowired
	UserMapper userMapper;
	@Autowired
	AddressMapper addressMapper;
	@Autowired
	CartMapper cartMapper;
	@Autowired
	OrderMapper orderMapper;

	@Override
	public User login(User user) {
		user.setPassword(MD5Util.getMD5(user.getPassword()));
		return userMapper.login(user);
	}

	@Override
	public int register(User user,String repassword) {
		User reUser = userMapper.selectByName(user);
		if(reUser!=null) {
			return -300;
		}
		if("".equals(repassword)||"".equals(user.getUsername())) {
			return -100;
		}
		if(repassword.equals(user.getPassword())) {
			user.setPassword(MD5Util.getMD5(user.getPassword()));
			return userMapper.register(user);
		}
		else {
			return -200;
		}
	}

	@Override
	public int update(User user) {
		return userMapper.update(user);
	}

	@Override
	public int modifyPW(String password, String repassword, int uid) {
		if("".equals(repassword)||"".equals(password)) {
			return -100;  //两次密码都必须输入
		}
		if(repassword.equals(password)) {
			password=MD5Util.getMD5(password);
			return userMapper.modifyPW(password, uid);
		}
		else {
			return -200; //两次密码不一致
		}
	}

	@Override
	public int inCounter(User user) {
		return userMapper.inCounter(user);
	}

	@Override
	public int reCounter(User user) {
		return userMapper.reCounter(user);
	}

	@Override
	public User selectByName(User user) {
		return userMapper.selectByName(user);
	}

	@Override
	public int moErrorDate(User user) {
		return userMapper.moErrorDate(user);
	}

	@Override
	public List<Address> queryAddress(int uid) {
		return addressMapper.selectByUid(uid);
	}

	@Override
	public int deleteAddress(int aid) {
		return addressMapper.delete(aid);
	}

	@Override
	public int inAddress(Address address) {
		return addressMapper.insert(address);
	}

	@Override
	public int moAddress(Address address) {
		return addressMapper.update(address);
	}

	@Override
	public int moState(User user) {
		return userMapper.moState(user);
	}

	@Override
	public Page selectAllAddress(Page page) {
		List<Address> list = addressMapper.selectAllAddress(page);
		page.setList(list);
		page.setTotalRows(addressMapper.allAddressCount(page));		
		return page;
	}

	@Override
	public int inCart(Cart cart) {
		return cartMapper.insert(cart);
	}

	@Override
	public List<Cart> queryAllCart(Cart cart) {
		return cartMapper.queryByUid(cart);
	}

	@Override
	public int recharge(User user, double money) {
		return userMapper.recharge(user,money);
	}

	@Override
	public HashMap<String, Object> initIndex(User user) {
		HashMap<String, Object> hashMap = new HashMap<>();
		User reUser = userMapper.selectByName(user);
		hashMap.put("balance", reUser.getBalance());
		List<Oorder> list = orderMapper.selectByUid(reUser);
		hashMap.put("totalOrder", list.size());
		Double totalConsume=0.0;
		for (Oorder oorder : list) {
			totalConsume+=oorder.getTotalPrice();
		}
		hashMap.put("totalConsume", totalConsume);
		return hashMap;
	}

}
