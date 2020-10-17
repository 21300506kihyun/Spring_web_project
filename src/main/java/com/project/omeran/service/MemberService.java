package com.project.omeran.service;

import com.project.omeran.dto.UserVO;
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


	// FAQ 
	int getFaqCount(String keyword);
	List<Map<String, Object>> getFaqList(int startIndex, int cntPerPage, String keyword);	
	void deleteFaq(int faq_id);
	void updateFaq(Map<String, Object> map);
	
	// 쇼핑몰 상품 관련
	
	int getProductCount(String keyword);
	List<Map<String, Object>> getProductList(int startIndex, int cntPerPage, String keyword);
	Map<String, Object> getProductDetail(int p_id);
	
	public void insertUserInfo(UserVO userVO) throws Exception;
	public int idCheck(UserVO userVO) throws Exception;



}

