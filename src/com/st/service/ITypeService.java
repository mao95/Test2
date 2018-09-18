package com.st.service;

import java.util.List;

import com.st.pojo.Page;
import com.st.pojo.Type;

public interface ITypeService {
	int insert(Type type);
	Page selectAllType(Page page);
	int moType(Type type);
	Page queryByName(Page page);
	Page queryByBigType(Page page);
	List<Type> queryBigType();
	List<Type> querySmallType(Type type);
	List<Type> queryType();
}
