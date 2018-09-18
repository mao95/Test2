package com.st.mapper;

import java.util.List;

import com.st.pojo.Cart;

public interface CartMapper {
	int insert(Cart cart);
	int delete(Cart cart);
	List<Cart> queryByUid(Cart cart);
}
