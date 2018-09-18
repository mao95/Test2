package com.st.mapper;

import java.util.HashMap;
import java.util.List;

import com.st.pojo.Goods;
import com.st.pojo.Page;

public interface GoodsMapper {
	int insert(HashMap<String, Object> goods);
	int update(HashMap<String, Object> goods);
	int delete(int gid);
	List<Goods> selectAllGoods(Page page);
	int allGoodsCount();
	List<Goods> queryLike(Page page);
	int likeGoodsCount(Page page);
	Goods selectByGid(int gid);
	int sell(int gid,int count);
	List<Goods> allGoods();
}
