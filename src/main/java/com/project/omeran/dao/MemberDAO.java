package com.project.omeran.dao;



import com.project.omeran.dto.UserVO;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.omeran.dto.AddressVO;
import com.project.omeran.dto.MallVO;
import com.project.omeran.dto.MemberVO;
import com.project.omeran.dto.OrderVO;


public interface MemberDAO {
	public String getEmail(@Param("id")String id);
	
	// 로그인 체크 
	public Map<String, String> getUserInfo(@Param("id")String id, @Param("pw")String pw);
	
	// 회원정보 업데이트
	public void updateRecentLogin(@Param("u_id")int u_id);
	
	// 회원 정보 가져오기
	public MemberVO viewMember(MemberVO vo);

	public List<Map<String, Object>> selectBoardList(Map<String, Object> map);
	
	// FAQ load
	public int getFaqCount(@Param("keyword")String keyword, @Param("mall_id")int mall_id);
	
	public List<Map<String, Object>> getFaqList(@Param("startIndex")int startIndex, @Param("cntPerPage")int cntPerPage, 
						@Param("keyword")String keyword, @Param("mall_id")int mall_id);
	// FAQ paging
	public void insertBoard(Map<String, Object> map); // 게시글 입력
	
	public void updateBoard(Map<String, Object> map); // 게시글 수정

	public void deleteFaqBoard(@Param("faq_id")int faq_id);
	public void updateFaqBoard(Map<String, Object> map);
	
	// *********** 쇼핑몰 상품 부분 **************
	
	public int mall_getProductCount(@Param("keyword")String keyword);
	public List<Map<String, Object>> mall_getProductList(@Param("startIndex")int startIndex, @Param("cntPerPage")int cntPerPage, @Param("keyword")String keyword);
	Map<String, Object> mall_getProductDetail(@Param("p_id")int p_id);
	
	//*********** 회원가입 부분 *****************
	
	public void insertUserInfo(UserVO userVO) throws Exception;
	public int idCheck(UserVO userVO) throws Exception;
	public int getU_Id(String user_id);
	public void insertAddress(UserVO userVO);
	

	//**** [ admin ] ****//
	public int getSiteCountBySiteName(@Param("siteName")String siteName);
	
	
	public List<Map<String, Object>> getAllProductList(int mall_id);

	public List<Map<String, Object>> getProductList(@Param("state_id")String state_id, @Param("mall_id")int mall_id);

	public List<Map<String, Object>> getStateList(@Param("category")String category);

	public void productSimpleUpdate(@Param("productId")int productId, @Param("price")int price, @Param("discount_price")int discount_price, @Param("stateId")String stateId);

	public void productDelete(@Param("productId")int productId);

	public void adminProductCreateNew(Map<String, String> paramMap);

	public Map<String, Object> admin_getProductInfoById(int p_id);

	public void adminProduct_modifyDetail(Map<String, String> paramMap);

	//**** [ superAdmin ] ****//
	public int superAdmin_getMallCount(Map<String, String> paramMap);

	public List<MallVO> superAdmin_getMalls(Map<String, String> paramMap);

	public void superAdminMain_simpleDelete(int mall_id);

	public void superAdmin_createNewMall(Map<String, String> paramMap);

	public List<Map<String, Object>> superAdmin_getAllMalls_name_id();

	public void superAdmin_createNewAdmin(Map<String, String> paramMap);

	public Map<String, Object> superAdmin_getMallInfoById(int mall_id);

	public void superAdmin_modifyMallDetail(Map<String, String> paramMap);

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

	public int superAdmin_mallNameCheck(MallVO mallVO);

	public void superAdmin_modifyDetailCustomer_withoutPW(Map<String, String> paramMap);

	public void superAdmin_modifyDetailCustomer_withPW(Map<String, String> paramMap);

	// admin Order
	public int adminOrder_getOrderCount(Map<String, String> paramMap);

	public List<Map<String, String>> adminOrder_getOrders(Map<String, String> paramMap);

	public List<UserVO> admin_getDeliverymanList(int mall_id);

	public String getUserPassword(String id);

	public int adminOrder_getOrderCountByState(@Param("state_id")String state_id, @Param("mall_id")int mall_id);

	public void adminOrder_simpleUpdate(Map<String, String> paramMap);

	// admin Delivery
	public int adminDelivery_getDeliveryCount(Map<String, String> paramMap);

	public int adminDelivery_getDeliveryCountByState(@Param("state_id")String state_id, @Param("mall_id")int mall_id);

	public List<Map<String, String>> adminDelivery_getDeliverys(Map<String, String> paramMap);

	public void adminDelivery_setDeliveryman(Map<String, String> paramMap);

	public void adminDelivery_setDeliveryLocation(Map<String, String> paramMap);

	public void adminDelivery_setState_depature(Map<String, String> paramMap);

	public void adminDelivery_setState_arrival(Map<String, String> paramMap);

	public void adminDelivery_setState(Map<String, String> paramMap);

	// admin Deliveryman
	public int adminDeliveryman_getDeliverymanCount(Map<String, String> paramMap);

	public List<Map<String, String>> adminDeliveryman_getDeliverymans(Map<String, String> paramMap);

	public void adminDeliveryman_deleteById(Map<String, String> paramMap);

	public void adminDeliveryman_simpleUpdate(Map<String, String> paramMap);

	public void adminDeliveryman_createNew(Map<String, String> paramMap);

	public void adminDeliveryman_modifyDetail_withoutPW(Map<String, String> paramMap);

	public void adminDeliveryman_modifyDetail_withPW(Map<String, String> paramMap);

	public List<Map<String, Object>> adminDeliveryman_getDeliveries(int u_id);

	public List<Map<String, Object>> adminDeliveryman_getCurrDeliverise(int u_id);

	public int adminDeliveryman_getCurrDeliveryCnt(@Param("u_id") int u_id);

	// 플랫폼 메인
	public List<Map<String, Object>> platform_getAllMallList();

	// 관리자 페이지 접속을 위한 사이트 이름 유효성 체크
	public int siteNameValidityCheck(@Param("mall_id")int mall_id, @Param("siteName")String siteName);

	
	// 플랫폼 to 쇼핑몰 
	public int getMallIdByName(@Param("siteName")String siteName);



}

