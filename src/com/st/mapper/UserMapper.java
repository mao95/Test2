package com.st.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.st.pojo.Page;
import com.st.pojo.User;

public interface UserMapper {
	User login(User user);
	int register(User user);
	int update(User user);
	int modifyPW(@Param("password") String password,@Param("uid") int uid);
	User selectByName(User user);
	int inCounter(User user);
	int reCounter(User user);
	int moErrorDate(User user);
	List<User> selectAllUser(Page page);
	int allUserCount();
	int moState(User user);
	int pay(int uid,double price);
	int countUsers();
	int recharge(@Param("user") User user,@Param("money") double money);
}
