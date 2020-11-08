package com.project.omeran.dto;

import java.util.Date;

public class MallVO {
	private int mall_id;
	private String mall_name;
	private Date create_date;
	private Date mod_date;
	private String farm_name;
	private String farm_address;
	private String farm_detail;
	private String tel;
	private String fax;
	private String regist_num;
	private String business_num;
	private String account_num;
	public int getMall_id() {
		return mall_id;
	}
	public void setMall_id(int mall_id) {
		this.mall_id = mall_id;
	}
	public String getMall_name() {
		return mall_name;
	}
	public void setMall_name(String mall_name) {
		this.mall_name = mall_name;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public String getFarm_name() {
		return farm_name;
	}
	public void setFarm_name(String farm_name) {
		this.farm_name = farm_name;
	}
	public String getFarm_address() {
		return farm_address;
	}
	public void setFarm_address(String farm_address) {
		this.farm_address = farm_address;
	}
	public String getFarm_detail() {
		return farm_detail;
	}
	public void setFarm_detail(String farm_detail) {
		this.farm_detail = farm_detail;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getRegist_num() {
		return regist_num;
	}
	public void setRegist_num(String regist_num) {
		this.regist_num = regist_num;
	}
	public String getBusiness_num() {
		return business_num;
	}
	public void setBusiness_num(String business_num) {
		this.business_num = business_num;
	}
	public String getAccount_num() {
		return account_num;
	}
	public void setAccount_num(String account_num) {
		this.account_num = account_num;
	}
	@Override
	public String toString() {
		return "MallVO [mall_id=" + mall_id + ", mall_name=" + mall_name + ", create_date=" + create_date
				+ ", mod_date=" + mod_date + ", farm_name=" + farm_name + ", farm_address=" + farm_address
				+ ", farm_detail=" + farm_detail + ", tel=" + tel + ", fax=" + fax + ", regist_num=" + regist_num
				+ ", business_num=" + business_num + ", account_num=" + account_num + "]";
	}
	
	
}
