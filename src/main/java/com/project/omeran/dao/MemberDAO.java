package com.project.omeran.dao;



import com.project.omeran.dto.UserVO;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.omeran.dto.MallVO;
import com.project.omeran.dto.MemberVO;


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
	public int getFaqCount(@Param("keyword")String keyword);
	
	public List<Map<String, Object>> getFaqList(@Param("startIndex")int startIndex, @Param("cntPerPage")int cntPerPage, @Param("keyword")String keyword);
	// FAQ paging
	public void insertBoard(Map<String, Object> map); // 게시글 입력
	
	public void updateBoard(Map<String, Object> map); // 게시글 수정

	public void deleteFaqBoard(@Param("faq_id")int faq_id);
	public void updateFaqBoard(Map<String, Object> map);
	
	// *********** 쇼핑몰 상품 부분 **************
	
	public int getProductCount(@Param("keyword")String keyword);
	public List<Map<String, Object>> getProductList(@Param("startIndex")int startIndex, @Param("cntPerPage")int cntPerPage, @Param("keyword")String keyword);
	Map<String, Object> getProductDetail(@Param("p_id")int p_id);
	
	//*********** 회원가입 부분 *****************
	
	public int insertUserInfo(UserVO userVO) throws Exception;
	public int idCheck(UserVO userVO) throws Exception;
	

	public List<Map<String, Object>> getAllProductList(int mall_id);

	public List<Map<String, Object>> getProductList(@Param("state_id")String state_id, @Param("mall_id")int mall_id);

	public List<Map<String, Object>> getStateList(@Param("category")String category);

	public void productSimpleUpdate(@Param("productId")int productId, @Param("price")int price, @Param("discount_price")int discount_price, @Param("stateId")String stateId);

	public void productDelete(@Param("productId")int productId);

	public void adminProductCreateNew(Map<String, String> paramMap);

	public Map<String, Object> admin_getProductInfoById(int p_id);

	public void adminProduct_modifyDetail(Map<String, String> paramMap);

	public int superAdmin_getMallCount(Map<String, String> paramMap);

	public List<MallVO> superAdmin_getMalls(Map<String, String> paramMap);

	public void superAdminMain_simpleDelete(int mall_id);

	public void superAdmin_createNewMall(Map<String, String> paramMap);

	public List<Map<String, Object>> superAdmin_getAllMalls_name_id();

	public void superAdmin_createNewAdmin(Map<String, String> paramMap);

	public Map<String, Object> superAdmin_getMallInfoById(int mall_id);

	public void superAdmin_modifyMallDetail(Map<String, String> paramMap);


}

