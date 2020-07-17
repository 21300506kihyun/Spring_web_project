package com.project.omeran.dao;



import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.project.omeran.dto.MemberVO;


public interface MemberDAO {
	public String getEmail(@Param("id")String id);
	
	// 로그인 체크 
	public Map<String, String> getUserInfoStr(@Param("id")String id, @Param("pw")String pw);
	public Map<String, Integer> getUserInfoInt(@Param("id")String id, @Param("pw")String pw);
	public Map<String, Timestamp> getUserInfoTime(@Param("id")String id, @Param("pw")String pw);
	
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


}

