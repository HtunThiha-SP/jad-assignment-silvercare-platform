package com.silvercare.controller;


import com.silvercare.dao.CartDao;
import com.silvercare.dto.CartDto;
import com.silvercare.util.OperationResponse;

import java.util.*;

public class CartController {
	public static List<CartDto> getCartItemsByUserId(int userId) {
		return CartDao.selectCartItemsByUserId(userId);
	}
	
	public static void addCartItem(String serviceName, int userId) {
		CartDao.insertCartItem(serviceName, userId);
	}
}
