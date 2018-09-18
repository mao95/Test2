package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.mapper.TypeMapper;
import com.st.pojo.Page;
import com.st.pojo.Type;
import com.st.service.ITypeService;

@Service
public class TypeServiceImpl implements ITypeService{
	
	@Autowired
	TypeMapper typeMapper;

	@Override
	public int insert(Type type) {
		return typeMapper.insert(type);
	}

	@Override
	public Page selectAllType(Page page) {
		List<Type> list = typeMapper.selectAllType(page);
		page.setList(list);
		page.setTotalRows(typeMapper.allTypeCount());
		return page;
	}

	@Override
	public int moType(Type type) {
		return typeMapper.moType(type);
	}

	@Override
	public Page queryByName(Page page) {
		List<Type> list = typeMapper.queryByName(page);
		page.setList(list);
		page.setTotalRows(typeMapper.byNameCount(page));
		return page;
	}

	@Override
	public Page queryByBigType(Page page) {
		List<Type> list = typeMapper.queryByBigType(page);
		page.setList(list);
		page.setTotalRows(typeMapper.byBigTypeCount(page));
		return page;
	}

	@Override
	public List<Type> queryBigType() {
		return typeMapper.queryBigType();
	}

	@Override
	public List<Type> querySmallType(Type type) {
		return typeMapper.querySmallType(type);	
	}

	@Override
	public List<Type> queryType() {
		return typeMapper.queryType();
	}

}
