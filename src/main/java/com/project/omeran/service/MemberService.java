package com.project.omeran.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.project.omeran.dto.MemberVO;

public interface MemberService {
	public String getEmail(String id);
	
	// 로그인 체크
	public boolean loginCheck(MemberVO vo, String id, String pw, HttpSession session);
	
	// 로그아웃 
	public void logout(HttpSession session, MemberVO vo);
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;
	

	void insertBoard(Map<String, Object> map) throws Exception;
	
	void updateBoard(Map<String, Object> map) throws Exception;



	// FAQ Search
	List<Map<String, Object>> getFaqList(String keyword);


}

