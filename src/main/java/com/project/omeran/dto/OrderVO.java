package com.project.omeran.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class OrderVO {
	private int order_id;
	private int customer_id;
	private int product_id;
	private int pay_amount;
	private String state_id;
	private Date order_date;
	private int order_amount;
	private String payment_way;
	private Date buy_start;
	private Date buy_end;
	private Date mod_date;
	private Date buy_duration;
	private int address_id;
	private String order_log;
	private int mall_id;
	
	private String user_name;
	private String telephone;
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getPay_amount() {
		return pay_amount;
	}
	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}
	public String getState_id() {
		return state_id;
	}
	public void setState_id(String state_id) {
		this.state_id = state_id;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getOrder_amount() {
		return order_amount;
	}
	public void setOrder_amount(int order_amount) {
		this.order_amount = order_amount;
	}
	public String getPayment_way() {
		return payment_way;
	}
	public void setPayment_way(String payment_way) {
		this.payment_way = payment_way;
	}
	public Date getBuy_start() {
		return buy_start;
	}
	public void setBuy_start(Date buy_start) {
		this.buy_start = buy_start;
	}
	public Date getBuy_end() {
		return buy_end;
	}
	public void setBuy_end(Date buy_end) {
		this.buy_end = buy_end;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public Date getBuy_duration() {
		return buy_duration;
	}
	public void setBuy_duration(Date buy_duration) {
		this.buy_duration = buy_duration;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	public String getOrder_log() {
		return order_log;
	}
	public void setOrder_log(String order_log) {
		this.order_log = order_log;
	}
	public int getMall_id() {
		return mall_id;
	}
	public void setMall_id(int mall_id) {
		this.mall_id = mall_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	
	
	
}
