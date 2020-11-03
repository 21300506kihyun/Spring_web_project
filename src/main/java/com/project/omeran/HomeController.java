package com.project.omeran;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;
//import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
//import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.omeran.common.CommandMap;
import com.project.omeran.dto.MemberVO;
import com.project.omeran.dto.PaginationVO;
import com.project.omeran.dto.UserVO;
import com.project.omeran.service.MemberService;


/**
 * Handles requests for the application home page.
 */



@Controller
public class HomeController {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// session Test
	// TODO: 세션테스트 리턴값을 int형으로 해서 user_category값을 반환하도록 하자. 지금은 테스트 용으로 쇼핑몰 관리자/플랫폼 관리자 모두가 가능한 상황
	public boolean sessionTest(HttpSession session) {
		if(session.getAttribute("loginValidity") != null) {
			if((int)session.getAttribute("user_category") >= -2 && (int)session.getAttribute("user_category") < 1) {
				return true;									
			}
		}
		return false;
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	public String home() {
		return "index";
	}
	@RequestMapping(value = {"/index", "/p1"}, method = { RequestMethod.GET, RequestMethod.POST })
	public String home_2() {
		
		
		return "index";
	}
	@RequestMapping(value = "/p2", method = { RequestMethod.GET, RequestMethod.POST })
	public String home2() {
		
		return "p2";
	}
	@RequestMapping(value = "/p3", method = { RequestMethod.GET, RequestMethod.POST })
	public String home3() {
		
		return "p3";
	}
	@RequestMapping(value = "/p4", method = { RequestMethod.GET, RequestMethod.POST })
	public String home4() {
		
		return "p4";
	}

	
	// 로그인 체크
	@RequestMapping(value = "/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView login(@ModelAttribute UserVO vo, HttpSession session, @RequestParam("id")String id, @RequestParam("pw")String pw,
			HttpServletRequest request) {
		boolean result = memberService.loginCheck(vo, id, pw, session);
		ModelAndView mav = new ModelAndView();
		// System.out.println("login.do: "+ vo );
		
		if(result == true) {
			mav.setViewName("moveWithoutAlert");
			String referer = request.getHeader("referer");
			mav.addObject("url", referer);
		}
		else {
			mav.setViewName("moveWithAlert");
			String referer = request.getHeader("referer");
			// System.out.println("else / referer: "+referer);
			String msg = "로그인에 실패하였습니다. 정보를 다시 확인해주세요.";
			mav.addObject("msg", msg);
			mav.addObject("url", referer);
		}
		return mav;
	}
	
	// 로그아웃 
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView logout(HttpSession session, @ModelAttribute UserVO vo, HttpServletRequest request) {
		memberService.logout(session, vo);
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("moveWithoutAlert");
		String referer = request.getHeader("referer");
		mav.addObject("url", referer);
		return mav;
	}
	
	// mailForm
	@RequestMapping(value = "/mailForm")
	public String mailForm() {
		return "mailForm";
	}  
	 
	// mailSending 코드
	@RequestMapping(value = "/mailSending")
	public String mailSending(HttpServletRequest request) {
	   
	  String setfrom = request.getParameter("fromMail");   // 보내는 사람 이메일
	  String tomail  = request.getParameter("tomail");     // 받는 사람 이메일
	  String title   = request.getParameter("title");      // 제목
	  String content = "omeranmall.com을 통해 [ " + request.getParameter("fromMail") + " ] 의 계정에서 질문한 문의입니다.\n\n"
	  		+ "문의의 내용은 아래와 같습니다.\n\n\n=======[ 아래 ]======\n\n" + request.getParameter("content");    // 내용
	  
	  try {
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper messageHelper 
	                      = new MimeMessageHelper(message, true, "UTF-8");
	 
	    messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	    messageHelper.setTo(tomail);     // 받는사람 이메일
	    messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	    messageHelper.setText(content);  // 메일 내용
	     
	    mailSender.send(message);
	  } catch(Exception e){
	    System.out.println(e);
	  }
	   
	  return "redirect:index";
	}
	  
    @ResponseBody
    @RequestMapping(value = "/VerifyRecaptcha", method = RequestMethod.POST,produces="application/json")
    public int VerifyRecaptcha(HttpServletRequest request) {
        VerifyRecaptcha.setSecretKey("6LcYU6wZAAAAAEi4rXL-A97f2QL7ZAWK8YAtIMsc");
        String gRecaptchaResponse = request.getParameter("recaptcha");
        System.out.println(gRecaptchaResponse);
        //0 = 성공, 1 = 실패, -1 = 오류
        try {
            if(VerifyRecaptcha.verify(gRecaptchaResponse))
                return 0;
            else return 1;
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
    }
 
    @RequestMapping(value="/faq", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView viewFaq(@RequestParam(value="curPage", defaultValue="1")int curPage, 
    		@RequestParam(value="faqKeyword", defaultValue="")String keyword) throws Exception{
    	ModelAndView mav = new ModelAndView("faq");
    	
    	// FAQ 리스트 개수 불러오기 (검색결과, 페이징)
    	int listCnt = memberService.getFaqCount(keyword);
    	
    	PaginationVO pagination = new PaginationVO(listCnt, curPage);
    	
    	int startIndex = pagination.getStartIndex();
    	int cntPerPage = pagination.getPageSize();

		List<Map<String, Object>> list = memberService.getFaqList(startIndex, cntPerPage, keyword);
    	
    	mav.addObject("listCnt", listCnt);
    	mav.addObject("list", list);
    	mav.addObject("pagination", pagination);
    	mav.addObject("keyword", keyword);
    	mav.addObject("curURL", "faq");
    	
    	return mav;
    }
    
    @RequestMapping(value = "/faqWrite", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView faqWrite(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			mav.setViewName("faqWrite");
			return mav;
		}
		else {
			return viewFaq(1, "");			
		}
	}
    
    @RequestMapping(value="/faq.delete", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView faqDeleteAction(HttpServletRequest request, HttpSession session, @RequestParam(value="faq_id")int faq_id) throws Exception{
    	ModelAndView mav = new ModelAndView();

    	if(sessionTest(session)) {
    		memberService.deleteFaq(faq_id);
    		return viewFaq(1, "");
    	}
    	else {
    		String referer = "faq";
        	String msg = "권한이 없습니다.";
    		
    		mav.setViewName("moveWithAlert");
    		mav.addObject("msg", msg);
    		mav.addObject("url", referer);	
    	}
    	
    	return mav;
    }
    
    @RequestMapping(value="/faqModify", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView faqModify(HttpServletRequest request, HttpSession session, @RequestParam(value="title")String title,
    		@RequestParam(value="faq_id")int faq_id, @RequestParam(value="content")String content) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	
    	if(sessionTest(session)) {
    		mav.setViewName("faqModify");
    		mav.addObject("title", title);
    		mav.addObject("faq_id", faq_id);
    		mav.addObject("content", content);
    		return mav;
    	}
    	else {
    		String referer = "faq";
        	String msg = "권한이 없습니다.";
    		
    		mav.setViewName("moveWithAlert");
    		mav.addObject("msg", msg);
    		mav.addObject("url", referer);	
    	}
    	
    	return mav;
    }
    
    @RequestMapping(value="/faq.modify", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView faqModifyAction(HttpSession session, @RequestParam Map<String,Object> commandMap) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	System.out.println(".modify : "+commandMap);
    	if(sessionTest(session)) {
    		mav.setViewName("faq");    		
        	memberService.updateFaq(commandMap);
    		return viewFaq(1, "");
    	}
    	else {
    		String referer = "faq";
        	String msg = "권한이 없습니다.";
    		
    		mav.setViewName("moveWithAlert");
    		mav.addObject("msg", msg);
    		mav.addObject("url", referer);	
    	}
    	
    	return mav;
    }
    
    
    @RequestMapping(value="/testMapArgumentResolver",  method = RequestMethod.GET)
    public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception{ 
    	ModelAndView mv = new ModelAndView(""); 
    	if(commandMap.isEmpty() == false){ 
    		Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator(); 
    		Entry<String,Object> entry = null; 
    		while(iterator.hasNext()){ 
    			entry = iterator.next(); 
    			System.out.println("key : "+entry.getKey()+", value : "+entry.getValue()); 
    		} 
    	}  
    	return mv; 
    }
    
    @RequestMapping(value="/boardWrite") 
    public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{ 
    	ModelAndView mv = new ModelAndView("boardWrite"); 
    	return mv; 
    }
    
    @RequestMapping(value="/insertBoard", method = RequestMethod.POST) 
    public ModelAndView insertBoard( @RequestParam Map<String,Object> commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("redirect:/faq"); 
    	memberService.insertBoard(commandMap); 
    	return mv; 
    }


    @RequestMapping(value="updateBoard") 
    public ModelAndView updateBoard(@RequestParam Map<String,Object> commandMap) throws Exception{ //map은 key와 value로 구성 여기서는 key= title, value = title 내용
    	ModelAndView mv = new ModelAndView("redirect:/faq"); 
    	memberService.updateBoard(commandMap);
    	return mv; 
    }

	/**************** 쇼핑몰 페이지 ****************/

	@RequestMapping(value="/mall", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewproduct(@RequestParam(value="curPage", defaultValue="1")int curPage, 
			@RequestParam(value="faqKeyword", defaultValue="")String keyword) throws Exception{
		ModelAndView mav = new ModelAndView("mall");
		
		// FAQ 리스트 개수 불러오기 (검색결과, 페이징)
		int listCnt = memberService.mall_getProductCount(keyword);
		
		PaginationVO pagination = new PaginationVO(listCnt, curPage);
		
		int startIndex = pagination.getStartIndex();
		int cntPerPage = pagination.getPageSize();
	
		List<Map<String, Object>> list = memberService.mall_getProductList(startIndex, cntPerPage, keyword);
		
		mav.addObject("listCnt", listCnt);
		mav.addObject("list", list);
		mav.addObject("pagination", pagination);
		mav.addObject("keyword", keyword);
		mav.addObject("curURL", "faq");
		
		return mav;
	}
	
	@RequestMapping(value="/product_detail", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewproduct_detail(@RequestParam("p_id") int p_id) throws Exception{
		ModelAndView mav = new ModelAndView("product_detail");
	
		Map<String, Object> product_detail = memberService.mall_getProductDetail(p_id);
		
		mav.addObject("detail", product_detail);
		return mav;
	}
	
	@RequestMapping(value="/checkout", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewCheckout(@RequestParam("p_id") int p_id) throws Exception{
		ModelAndView mav = new ModelAndView("checkout");
		
	
		Map<String, Object> product_detail = memberService.mall_getProductDetail(p_id);
		
		mav.addObject("detail", product_detail);
		return mav;
	}


	/************** 회원가입 부분 ***********/
	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public ModelAndView register() throws Exception{
		ModelAndView mav = new ModelAndView("register");
		
		return mav;
	}

	@RequestMapping(value="/register", method = RequestMethod.POST)
	public ModelAndView register(UserVO userVO) throws Exception{
		memberService.insertUserInfo(userVO);
		ModelAndView mav = new ModelAndView("mall");
		
		return mav;
	}
	
	@ResponseBody 
	@RequestMapping(value="/register_idCheck",method = RequestMethod.POST)
	public int idcheck(UserVO userVO) throws Exception{
		//String a  = userVO.getUser_id();
		
		logger.info("success");
		int check = memberService.idCheck(userVO);
		return check;
	}
	
//	@ResponseBody
//	@RequestMapping(value="/register_idCheck",method = RequestMethod.POST)
//	public ModelAndView idcheck(UserVO userVO) throws Exception{
//		//String a  = userVO.getUser_id();
//		ModelAndView mav = new ModelAndView("mall");
//		
//		//mav.addObject("detail", a);
//		//int check = memberService.idCheck(userVO);
//		return mav;
//	}
}
