package com.st.mapper;

import java.util.List;

import com.st.pojo.Page;
import com.st.pojo.Type;

public interface TypeMapper {
	int insert(Type type);
	List<Type> selectAllType(Page page);
	int allTypeCount();
	int moType(Type type);
	List<Type> queryByName(Page page);
	int byNameCount(Page page);
	List<Type> queryByBigType(Page page);
	int byBigTypeCount(Page page);
	List<Type> queryBigType();
	List<Type> querySmallType(Type type);
	List<Type> queryType();
}
