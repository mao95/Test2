package com.st.mapper;

import com.st.pojo.Manager;

public interface ManagerMapper {
	
	Manager login(Manager manager);
	int moPW(Manager manager);
}
