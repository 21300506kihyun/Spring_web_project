package com.project.omeran.service;

import com.project.omeran.dto.UserVO;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.project.omeran.dto.MallVO;
import com.project.omeran.dto.MemberVO;
import com.project.omeran.dto.OrderVO;

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
	public int admin_getSiteCountBySiteName(String siteName);
	
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
	
	
	// superAdminMallManger
	public int superAdmin_getAdminCount(Map<String, String> paramMap);

	public List<UserVO> superAdmin_getAdminList(Map<String, String> paramMap);

	public Map<String, Object> superAdmin_getUserInfoById(int u_id);

	public void superAdmin_modifyDetailAdmin_withoutPW(Map<String, String> paramMap);

	public void superAdmin_modifyDetailAdmin_withPW(Map<String, String> paramMap);

	public void superAdmin_manager_simpleDelete(int u_id);

	public void superAdmin_manager_simpleModify(Map<String, String> paramMap);

	public int superAdmin_getCustomerCount(Map<String, String> paramMap);

	public List<UserVO> superAdmin_getCustomerList(Map<String, String> paramMap);

	public void superAdmin_customer_simpleDelete(int u_id);

	public void superAdmin_customer_simpleModify(Map<String, String> paramMap);

	public int mallNameCheck(MallVO mallVO);

	public void superAdmin_modifyDetailCustomer_withoutPW(Map<String, String> paramMap);

	public void superAdmin_modifyDetailCustomer_withPW(Map<String, String> paramMap);

	
	// admin Order
	public int adminOrder_getOrderCount(Map<String, String> paramMap);

	public List<Map<String, String>> adminOrder_getOrders(Map<String, String> paramMap);

	public List<UserVO> admin_getDeliverymanList(int mall_id);

	public int adminOrder_getOrderCountByState(String state_id, int mall_id);

	public void adminOrder_simpleUpdate(Map<String, String> paramMap);

	// admin Delivery
	public int adminDelivery_getDeliveryCount(Map<String, String> paramMap);

	public int adminDelivery_getDeliveryCountByState(String state_id, int mall_id);

	public List<Map<String, String>> adminDelivery_getDeliverys(Map<String, String> paramMap);

	public void adminDelivery_simpleUpdate(Map<String, String> paramMap);

	// 배송자 관리
	public int adminDeliveryman_getDeliverymanCount(Map<String, String> paramMap);

	public List<Map<String, String>> adminDeliveryman_getDeliverymans(Map<String, String> paramMap);

	public void adminDeliveryman_deleteById(Map<String, String> paramMap);

	public void adminDeliveryman_simpleUpdate(Map<String, String> paramMap);

	public void adminDeliveryman_createNew(Map<String, String> paramMap);

	public void adminDeliveryman_modifyDetail_withoutPW(Map<String, String> paramMap);

	public void adminDeliveryman_modifyDetail_withPW(Map<String, String> paramMap);

	public List<Map<String, Object>> adminDeliveryman_getDeliveries(int u_id);

	public List<Map<String, Object>> adminDeliveryman_getCurrDeliverise(int u_id);

	public int adminDeliveryman_getCurrDeliveryCnt(int u_id);

	public List<Map<String, Object>> platform_getAllMallList();

	// 관리자 페이지 접속을 위한 사이트 이름 유효성 체크
	public int siteNameValidityCheck(int mall_id, String siteName);


	

}

