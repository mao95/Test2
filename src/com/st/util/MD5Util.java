package com.st.util;

import java.security.MessageDigest;

import sun.misc.BASE64Encoder;

public class MD5Util {

	// MD5加密
	public static String getMD5(String str) {
		
		String newstr = null;
		try {
			//确定计算方法
			MessageDigest md5=MessageDigest.getInstance("MD5");
			BASE64Encoder base64en = new BASE64Encoder();
			//加密后的字符串
			newstr=base64en.encode(md5.digest(str.getBytes("utf-8")));
		
		} catch (Exception e) {
			// TODO: handle exception
		}

		return newstr; 
	}
	
}
