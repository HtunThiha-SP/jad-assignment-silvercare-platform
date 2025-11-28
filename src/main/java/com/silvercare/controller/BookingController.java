package com.silvercare.controller;

import java.util.*;

import com.silvercare.dao.BookingDao;
import com.silvercare.dto.BookingDto;

public class BookingController {
	public static List<BookingDto> getAllBookingsByUserId(int userId) {
		return BookingDao.selectBookingsByUserId(userId);
	}
}
