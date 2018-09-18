package com.st.pojo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Oorder {
	private String onumber;
	private Integer uid;
	@JsonFormat( pattern="yyyy年MM月dd日 HH:mm:ss",timezone="GMT+8")
	private Date time;
	private Double totalPrice;
	private List<Iorder> list;
	private Address address;
	private Integer aid;
	
	
	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public List<Iorder> getList() {
		return list;
	}
	public void setList(List<Iorder> list) {
		this.list = list;
	}
	public String getOnumber() {
		return onumber;
	}
	public void setOnumber(String onumber) {
		this.onumber = onumber;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
}
