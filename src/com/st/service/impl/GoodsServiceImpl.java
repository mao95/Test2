package com.st.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.mapper.GoodsMapper;
import com.st.pojo.Goods;
import com.st.pojo.Page;
import com.st.service.IGoodsService;

@Service
public class GoodsServiceImpl implements IGoodsService {

	@Autowired
	GoodsMapper goodsMapper;
	
	@Override
	public int insert(HashMap<String, Object> goods) {
		return goodsMapper.insert(goods);
	}
	
	@Override
	public int delete(int gid) {
		return goodsMapper.delete(gid);
	}

	@Override
	public Page selectAllGoods(Page page) {
		List<Goods> list = (List<Goods>) goodsMapper.selectAllGoods(page);
		page.setList(list);
		page.setTotalRows(goodsMapper.allGoodsCount());
		return page;
	}

	@Override
	public Page queryLike(Page page) {
		List<Goods> list = goodsMapper.queryLike(page);
		page.setList(list);
		page.setTotalRows(goodsMapper.likeGoodsCount(page));
		return page;
	}

	@Override
	public int update(HashMap<String, Object> goods) {
		return goodsMapper.update(goods);
	}

	@Override
	public Goods selectByGid(int gid) {
		return goodsMapper.selectByGid(gid);
	}

}
