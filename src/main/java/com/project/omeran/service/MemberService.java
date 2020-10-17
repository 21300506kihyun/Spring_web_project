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


	// FAQ 
	int getFaqCount(String keyword);
	List<Map<String, Object>> getFaqList(int startIndex, int cntPerPage, String keyword);	
	void deleteFaq(int faq_id);
	void updateFaq(Map<String, Object> map);

	// Admin 
	// 상품관리
	public List<Map<String, Object>> getAllProductList();
	public List<Map<String, Object>> getProductList(String state_id);

	public List<Map<String, Object>> getStateList(String category);

	public void productSimpleUpdate(int productId, int price, int discount_price, String stateId);

	public void productDelete(int productId);

	public void adminProductCreateNew(Map<String, String> paramMap);

}

