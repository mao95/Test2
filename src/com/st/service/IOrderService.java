package com.st.service;

import java.util.Date;
import java.util.List;

import com.st.pojo.Oorder;
import com.st.pojo.Page;

public interface IOrderService {
	void pay(Oorder oorder);
	Page getOrder(Page page);
	Oorder getOneOrder(Oorder oorder);
	Page getAllOrder(Page page);
	Page queryOrderByDate(Page page, Date start, Date end);
	List<Oorder> latestOrders();
}
