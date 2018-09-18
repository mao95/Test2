package com.st.service;

import java.util.HashMap;
import java.util.List;
import com.st.pojo.Address;
import com.st.pojo.Cart;
import com.st.pojo.Page;
import com.st.pojo.User;

public interface IUserService {
	User login(User user);
	int register(User user,String repassword);
	int update(User user);
	int modifyPW(String password,String repassword,int uid);
	User selectByName(User user);
	int inCounter(User user);
	int reCounter(User user);
	int moErrorDate(User user);
	List<Address> queryAddress(int uid);
	int deleteAddress(int aid);
	int inAddress(Address address);
	int moAddress(Address address);
	int moState(User user);
	Page selectAllAddress(Page page);
	int inCart(Cart cart);
	List<Cart> queryAllCart(Cart cart);
	int recharge(User user, double money);
	HashMap<String, Object> initIndex(User user);
}
