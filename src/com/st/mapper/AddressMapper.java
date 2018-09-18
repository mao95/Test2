package com.st.mapper;

import java.util.List;

import com.st.pojo.Address;
import com.st.pojo.Page;

public interface AddressMapper {
	int insert(Address address);
	List<Address> selectByUid(int uid);
	int update(Address address);
	int delete(int aid);
	List<Address> selectAllAddress(Page page);
	int allAddressCount(Page page);
}
