package com.st.service;

import java.util.HashMap;
import com.st.pojo.Manager;
import com.st.pojo.Page;

public interface IManagerService {
	
	Manager login(Manager manager);
	int moPW(String password,String repassword,Manager manager);
	Page selectAllUser(Page page);
	HashMap<String, Object> initIndex();	
}
