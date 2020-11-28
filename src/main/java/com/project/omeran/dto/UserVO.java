package com.project.omeran.dto;

public class UserVO {

	private int u_id;
	private String user_id;
	private String password;
	private String user_name;
	private int grade;
	private String telephone;
	private int gender;
	private String email;
	private int is_sms;
	private int is_email;
	private String user_memo;
	private String signin_date;
	private String modify_date;
	private int user_category;
	private String recommander_id;
	private int mall_id;
	private String mall_name;
	//주소 부분
	private String postcode;
	private String address;
	private String detailAddress;
	
	// MemberVO랑 합치기
	private boolean loginValidity;
	
	
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getIs_sms() {
		return is_sms;
	}
	public void setIs_sms(int is_sms) {
		this.is_sms = is_sms;
	}
	public int getIs_email() {
		return is_email;
	}
	public void setIs_email(int is_email) {
		this.is_email = is_email;
	}
	public String getUser_memo() {
		return user_memo;
	}
	public void setUser_memo(String user_memo) {
		this.user_memo = user_memo;
	}
	public String getSignin_date() {
		return signin_date;
	}
	public void setSignin_date(String signin_date) {
		this.signin_date = signin_date;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public int getUser_category() {
		return user_category;
	}
	public void setUser_category(int user_category) {
		this.user_category = user_category;
	}
	public String getRecommander_id() {
		return recommander_id;
	}
	public void setRecommander_id(String recommander_id) {
		this.recommander_id = recommander_id;
	}
	public boolean isLoginValidity() {
		return loginValidity;
	}
	public void setLoginValidity(boolean loginValidity) {
		this.loginValidity = loginValidity;
	}
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
	@Override
	public String toString() {
		return "UserVO [u_id=" + u_id + ", user_id=" + user_id + ", password=" + password + ", user_name=" + user_name
				+ ", grade=" + grade + ", telephone=" + telephone + ", gender=" + gender + ", email=" + email
				+ ", is_sms=" + is_sms + ", is_email=" + is_email + ", user_memo=" + user_memo + ", signin_date="
				+ signin_date + ", modify_date=" + modify_date + ", user_category=" + user_category
				+ ", recommander_id=" + recommander_id + ", mall_id=" + mall_id + ", mall_name=" + mall_name
				+ ", loginValidity=" + loginValidity + "]";
	}
	
	
	//주소 부분

	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	
}
