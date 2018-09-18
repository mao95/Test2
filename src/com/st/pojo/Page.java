package com.st.pojo;

import java.util.List;

public class Page {
	private Integer currentPage=1;//当前页面索引
	private Integer totalRows;//总记录数
	private Integer pageRows=2;//每一页的记录数
	private Integer pageCount;//总页数
	private Integer startRow=0;//当前页面初始记录
	private Object where;//携带筛选条件
	private List list;//当前页面商品信息
	
	
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
		this.startRow=(this.currentPage-1)*this.pageRows;
	}
	public Integer getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(Integer totalRows) {
		this.totalRows = totalRows;
		this.pageCount=(this.totalRows+this.pageRows-1)/this.pageRows;
	}
	public Integer getPageRows() {
		return pageRows;
	}
	public void setPageRows(Integer pageRows) {
		this.pageRows = pageRows;
		this.startRow=(this.currentPage-1)*this.pageRows;
	}
	public Integer getPageCount() {
		return pageCount;
	}
	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
	public Integer getStartRow() {
		return startRow;
	}
	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	
	public Object getWhere() {
		return where;
	}
	public void setWhere(Object where) {
		this.where = where;
	}	
}
