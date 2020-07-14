package com.project.omeran.service;

import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.omeran.dao.MemberDAO;
import com.project.omeran.dto.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
    MemberDAO memberDao;
    
    @Override
    public String getEmail(String id) {
        return memberDao.getEmail(id);
    }
    
    @Override
    public boolean loginCheck(MemberVO vo, String id, String pw, HttpSession session) {
    	Map<String, String> result = memberDao.getUserInfoStr(id, pw);
    	Map<String, Integer> index = memberDao.getUserInfoInt(id, pw);
    	Map<String, Timestamp> time = memberDao.getUserInfoTime(id, pw);
    	// 로그인 성공
    	if(result != null) {
    		System.out.println(result);
    		System.out.println(index);
    		System.out.println(time);
    		
    		vo.setU_id(index.get("u_id"));
    		vo.setStatus(index.get("status"));
    		
    		vo.setUserId(result.get("id"));
    		vo.setUserName(result.get("name"));
    		vo.setUserEmail(result.get("email"));
    		
    		vo.setRegisterDate(time.get("register_date"));
    		vo.setModifyDate(time.get("modify_date"));
    		vo.setRecentVisit(time.get("recent_visit"));
    		
    		vo.setLoginValidity(true);
    		// 최근 로그인 기록 업데이트
    		memberDao.updateRecentLogin(index.get("u_id"));

    		// 세션 변수 등록 
    		session.setAttribute("u_id", vo.getU_id());
    		session.setAttribute("status", vo.getStatus());
    		session.setAttribute("userId", vo.getUserId());
    		session.setAttribute("userName", vo.getUserName());
    		session.setAttribute("userEmail", vo.getUserEmail());
    		session.setAttribute("registerDate", vo.getRegisterDate());
    		session.setAttribute("modifyDate", vo.getModifyDate());
    		session.setAttribute("recentVisit", vo.getRecentVisit());
    		session.setAttribute("loginValidity", vo.isLoginValidity());

    		
    		return true;
    	}
    	else {
    		return false;
    	}
    }

	@Override
	public void logout(HttpSession session, MemberVO vo) {
		vo.setLoginValidity(false);
		session.setAttribute("loginValidity", false);
		session.setAttribute("userName", null);
		session.invalidate();
	}

}