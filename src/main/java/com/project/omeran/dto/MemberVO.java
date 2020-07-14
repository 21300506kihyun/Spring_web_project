package com.project.omeran.dto;

import java.sql.Timestamp;

public class MemberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String userEmail;
	private Timestamp registerDate;
	private Timestamp modifyDate;
	private Timestamp recentVisit;
	private int u_id;
	private int status;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public Timestamp getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Timestamp registerDate) {
		this.registerDate = registerDate;
	}
	public Timestamp getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Timestamp modifyDate) {
		this.modifyDate = modifyDate;
	}
	public Timestamp getRecentVisit() {
		return recentVisit;
	}
	public void setRecentVisit(Timestamp recentVisit) {
		this.recentVisit = recentVisit;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", userEmail="
				+ userEmail + ", registerDate=" + registerDate + ", modifyDate=" + modifyDate + ", recentVisit="
				+ recentVisit + ", u_id=" + u_id + ", status=" + status + "]";
	}
	
	
}
