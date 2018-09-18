package com.st.service;

import java.util.HashMap;

import com.st.pojo.Goods;
import com.st.pojo.Page;

public interface IGoodsService {
	int insert(HashMap<String, Object> goods);
	int update(HashMap<String, Object> goods);
	int delete(int gid);
	Page selectAllGoods(Page page);
	Page queryLike(Page page);
	Goods selectByGid(int gid);
	
}
