package com.project.omeran.service;

import javax.servlet.http.HttpSession;

import com.project.omeran.dto.MemberVO;

public interface MemberService {
	public String getEmail(String id);
	
	// 로그인 체크
	public boolean loginCheck(MemberVO vo, String id, String pw, HttpSession session);
	
	// 로그아웃 
	public void logout(HttpSession session, MemberVO vo);
}