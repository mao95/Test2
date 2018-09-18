package com.st.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.st.pojo.Iorder;
import com.st.pojo.Oorder;
import com.st.pojo.Page;
import com.st.pojo.User;

public interface OrderMapper {
	int insertO(Oorder oorder);
	int insertI(Iorder iorder);
	List<Oorder> getOrder(Page page);
	int count(Page page);
	Oorder getOneOrder(Oorder oorder);
	List<Oorder> getAllOrder(Page page);
	int allOrderCount();
	List<Oorder> queryOrderByDate(@Param("page") Page page,@Param("start") Date start,@Param("end") Date end);
	int countByDate(@Param("start") Date start,@Param("end") Date end);
	List<Oorder> latestOrders();
	List<Oorder> selectByUid(User user);
}

