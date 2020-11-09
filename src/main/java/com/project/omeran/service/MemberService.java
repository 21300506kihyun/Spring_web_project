package com.project.omeran.service;

import com.project.omeran.dto.UserVO;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.project.omeran.dto.MallVO;
import com.project.omeran.dto.MemberVO;

public interface MemberService {
	public String getEmail(String id);
	
	// 로그인 체크
	public boolean loginCheck(UserVO vo, String id, String pw, HttpSession session);
	
	// 로그아웃 
	public void logout(HttpSession session, UserVO vo);
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;
	

	void insertBoard(Map<String, Object> map) throws Exception;
	
	void updateBoard(Map<String, Object> map) throws Exception;


	// FAQ 
	int getFaqCount(String keyword);
	List<Map<String, Object>> getFaqList(int startIndex, int cntPerPage, String keyword);	
	void deleteFaq(int faq_id);
	void updateFaq(Map<String, Object> map);
	
	// 쇼핑몰 상품 관련
	
	int mall_getProductCount(String keyword);
	List<Map<String, Object>> mall_getProductList(int startIndex, int cntPerPage, String keyword);
	Map<String, Object> mall_getProductDetail(int p_id);
	
	public void insertUserInfo(UserVO userVO) throws Exception;
	public int idCheck(UserVO userVO) throws Exception;


	// Admin 
	// 상품관리
	public List<Map<String, Object>> getAllProductList(HttpSession session);
	public List<Map<String, Object>> getProductList(String state_id, HttpSession session);

	public List<Map<String, Object>> getStateList(String category);

	public void productSimpleUpdate(int productId, int price, int discount_price, String stateId);

	public void productDelete(int productId);

	public void adminProductCreateNew(Map<String, String> paramMap);

	public Map<String, Object> admin_getProductInfoById(int p_id);

	public void adminProduct_modifyDetail(Map<String, String> paramMap);

	
	// SuperAdmin
	public int superAdmin_getMallCount(Map<String, String> paramMap);

	public List<MallVO> superAdmin_getMalls(Map<String, String> paramMap);

	public void superAdminMain_simpleDelete(int mall_id);

	public void superAdmin_createNewMall(Map<String, String> paramMap);

	public List<Map<String, Object>> superAdmin_getAllMalls_name_id();

	public void superAdmin_createNewAdmin(Map<String, String> paramMap);

	public Map<String, Object> superAdmin_getMallInfoById(int mall_id);

	public void superAdmin_modifyMall(Map<String, String> paramMap);

}

