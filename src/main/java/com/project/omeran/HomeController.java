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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.omeran.common.CommandMap;
import com.project.omeran.dto.AddressVO;
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
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();

	
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
	@RequestMapping(value = {"/","/index"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		
		// 쇼핑몰 목록 가져오기
		List<Map<String, Object>> mallList = memberService.platform_getAllMallList();
		
		mav.addObject("mallList", mallList);
		
		mav.setViewName("platformMain");
		
		return mav;
	}
	

	// 플랫폼 > 로그인 체크
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
	
	// 플랫폼 > 로그아웃 
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
	
	
	
	
	
	// 쇼핑몰 매핑
    private boolean siteNameValidityCheck(String siteName) {
		// 해당 사이트가 존재하면 true 아니면 false
		if(memberService.admin_getSiteCountBySiteName(siteName) == 0) {
			return false;
		}
		return true;
	}
    
    private ModelAndView redirectToPlatformMain() {
    	ModelAndView mav = new ModelAndView("redirect:/");
    	return mav;
    }
    
    private int getMallIdByName(String siteName, HttpSession session) {
    	int mall_id = memberService.getMallIdByName(siteName);
    	session.setAttribute("curr_mall_id", mall_id);
    	System.out.println("mallID : "+mall_id);
    	return mall_id;
    }
    
    
    // 쇼핑몰 > 로그인 체크
 	@RequestMapping(value = "/{siteName}/login.do", method = { RequestMethod.GET, RequestMethod.POST })
 	public ModelAndView mall_login(@ModelAttribute UserVO vo, HttpSession session, @RequestParam("id")String id, @RequestParam("pw")String pw,
 			HttpServletRequest request, @PathVariable("siteName") String siteName) {
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
 	
 	// 플랫폼 > 로그아웃 
 	@RequestMapping(value = "/{siteName}/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
 	public ModelAndView mall_logout(HttpSession session, @ModelAttribute UserVO vo, HttpServletRequest request, @PathVariable("siteName") String siteName) {
 		memberService.logout(session, vo);
 		ModelAndView mav = new ModelAndView();
 		
 		mav.setViewName("moveWithoutAlert");
 		String referer = request.getHeader("referer");
 		mav.addObject("url", referer);
 		return mav;
 	}

    // index
	@RequestMapping(value = {"/{siteName}/", "/{siteName}/index", "/{siteName}/p1"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mall_home(HttpSession session, @PathVariable("siteName") String siteName) {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
		
		int mall_id = getMallIdByName(siteName, session);
		
		mav.addObject("siteName", siteName);
		
		mav.setViewName("index");
		
		return mav;
	}
	
	@RequestMapping(value = "/{siteName}/p2", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView home2(HttpSession session, @PathVariable("siteName") String siteName) {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
		
		int mall_id = getMallIdByName(siteName, session);
		
		mav.addObject("siteName", siteName);
		
		mav.setViewName("p2");
		
		return mav;
	}
	@RequestMapping(value = "/{siteName}/p3", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView home3(HttpSession session, @PathVariable("siteName") String siteName) {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
		
		int mall_id = getMallIdByName(siteName, session);
		
		mav.addObject("siteName", siteName);
		
		mav.setViewName("p3");
		
		return mav;
	}
	@RequestMapping(value = "/{siteName}/p4", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView home4(HttpSession session, @PathVariable("siteName") String siteName) {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
		
		int mall_id = getMallIdByName(siteName, session);
		
		mav.addObject("siteName", siteName);
		
		mav.setViewName("p4");
		
		return mav;
	}

	
	
	// TODO: FAQ 각 사이트마다 동작하도록 
    @RequestMapping(value="/{siteName}/faq", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView viewFaq(HttpSession session, @RequestParam(value="curPage", defaultValue="1")int curPage, 
    		@RequestParam(value="faqKeyword", defaultValue="")String keyword, @PathVariable("siteName") String siteName) throws Exception{
    	ModelAndView mav = new ModelAndView();

    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	
    	int mall_id = getMallIdByName(siteName, session);
    	
    	mav.addObject("siteName", siteName);
    	
    	
    	// FAQ 리스트 개수 불러오기 (검색결과, 페이징)
    	int listCnt = memberService.getFaqCount(keyword, mall_id);
    	
    	PaginationVO pagination = new PaginationVO(listCnt, curPage);
    	
    	int startIndex = pagination.getStartIndex();
    	int cntPerPage = pagination.getPageSize();

		List<Map<String, Object>> list = memberService.getFaqList(startIndex, cntPerPage, keyword, mall_id);
    	
		mav.setViewName("faq");
		
    	mav.addObject("listCnt", listCnt);
    	mav.addObject("list", list);
    	mav.addObject("pagination", pagination);
    	mav.addObject("keyword", keyword);
    	mav.addObject("curURL", "faq");
    	
    	return mav;
    }
    
    @RequestMapping(value = "/{siteName}/faqWrite", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView faqWrite(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
    	ModelAndView mav = new ModelAndView();

    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	
    	int mall_id = getMallIdByName(siteName, session);
    	
    	mav.addObject("siteName", siteName);
    	
		if(sessionTest(session)) {
			mav.setViewName("faqWrite");
			return mav;
		}
		else {
			mav.setViewName(siteName+"/faq");
			return mav;	
		}
	}
    
    @RequestMapping(value="/{siteName}/faq.delete", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView faqDeleteAction(HttpServletRequest request, HttpSession session, 
    		@RequestParam(value="faq_id")int faq_id, @PathVariable("siteName") String siteName) throws Exception{
    	ModelAndView mav = new ModelAndView();

    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	
    	int mall_id = getMallIdByName(siteName, session);
    	mav.addObject("siteName", siteName);
    	
    	if(sessionTest(session)) {
    		memberService.deleteFaq(faq_id);
    		mav.setViewName(siteName+"/faq");
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
    
    @RequestMapping(value="/{siteName}/faqModify", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView faqModify(HttpServletRequest request, HttpSession session, @RequestParam(value="title")String title,
    		@RequestParam(value="faq_id")int faq_id, @RequestParam(value="content")String content, 
    		@PathVariable("siteName") String siteName) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	
    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	
    	int mall_id = getMallIdByName(siteName, session);
    	mav.addObject("siteName", siteName);
    	
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
    
    @RequestMapping(value="/{siteName}/faq.modify", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView faqModifyAction(HttpSession session, @RequestParam Map<String,Object> commandMap,
    		@PathVariable("siteName") String siteName) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	
    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	
    	int mall_id = getMallIdByName(siteName, session);
    	mav.addObject("siteName", siteName);
    	
    	
    	if(sessionTest(session)) {
    		mav.setViewName("faq");    		
        	memberService.updateFaq(commandMap);
        	
        	mav.setViewName("redirect:faq");
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
    
    
//    @RequestMapping(value="/testMapArgumentResolver",  method = RequestMethod.GET)
//    public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception{ 
//    	ModelAndView mv = new ModelAndView(""); 
//    	if(commandMap.isEmpty() == false){ 
//    		Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator(); 
//    		Entry<String,Object> entry = null; 
//    		while(iterator.hasNext()){ 
//    			entry = iterator.next(); 
//    			System.out.println("key : "+entry.getKey()+", value : "+entry.getValue()); 
//    		} 
//    	}
//    	return mv;
//    }
    
    // TODO: 이거 쓰는거에요..?
    @RequestMapping(value="/{siteName}/boardWrite") 
    public ModelAndView openBoardWrite(HttpSession session, CommandMap commandMap, @PathVariable("siteName") String siteName) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	
    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	int mall_id = getMallIdByName(siteName, session);
    	mav.addObject("siteName", siteName);
    	
    	mav.setViewName("boardWrite");
    	return mav; 
    }
    
    
    
    @RequestMapping(value="/{siteName}/insertBoard", method = RequestMethod.POST) 
    public ModelAndView insertBoard(HttpSession session, @RequestParam Map<String,Object> commandMap, 
    			@PathVariable("siteName") String siteName) throws Exception{
    	ModelAndView mav = new ModelAndView();
    	
    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	int mall_id = getMallIdByName(siteName, session);
    	mav.addObject("siteName", siteName);
    	
    	commandMap.put("mall_id", mall_id);
    	memberService.insertBoard(commandMap); 

    	mav.setViewName("redirect:faq"); 
    	
    	return mav; 
    }

    // TODO: 이거 쓰는거야???
    @RequestMapping(value="/{siteName}/updateBoard") 
    public ModelAndView updateBoard(HttpSession session, @RequestParam Map<String,Object> commandMap,
    			@PathVariable("siteName") String siteName) throws Exception{ //map은 key와 value로 구성 여기서는 key= title, value = title 내용
    	ModelAndView mav = new ModelAndView();
    	
    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToPlatformMain();
    	}
    	int mall_id = getMallIdByName(siteName, session);
    	mav.addObject("siteName", siteName);
    	
    	memberService.updateBoard(commandMap);

    	mav.setViewName("redirect:faq");
    	
    	return mav; 
    }

    // TODO: path variable 매핑
	/**************** 쇼핑몰 페이지 ****************/
	@RequestMapping(value="/{siteName}/mall", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewproduct(@RequestParam(value="curPage", defaultValue="1")int curPage, 
			@RequestParam(value="faqKeyword", defaultValue="")String keyword,
			@PathVariable("siteName")String siteName) throws Exception{
		ModelAndView mav = new ModelAndView("mall");
		
		// Mall id 가져오기
		int curr_mall_id = memberService.getMallIdByName(siteName);
		
		// FAQ 리스트 개수 불러오기 (검색결과, 페이징)
		int listCnt = memberService.mall_getProductCount(keyword, curr_mall_id);
		
		PaginationVO pagination = new PaginationVO(listCnt, curPage);
		
		int startIndex = pagination.getStartIndex();
		int cntPerPage = pagination.getPageSize();
	
		
		List<Map<String, Object>> list = memberService.mall_getProductList(startIndex, cntPerPage, keyword, curr_mall_id);
		
		mav.addObject("siteName", siteName);
		mav.addObject("listCnt", listCnt);
		mav.addObject("list", list);
		mav.addObject("pagination", pagination);
		mav.addObject("keyword", keyword);
		mav.addObject("curURL", "faq");
		
		return mav;
	}
	
	@RequestMapping(value="{siteName}/product_detail", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewproduct_detail(@RequestParam("p_id") int p_id,
			@PathVariable("siteName")String siteName) throws Exception{
		ModelAndView mav = new ModelAndView("product_detail");
	
		Map<String, Object> product_detail = memberService.mall_getProductDetail(p_id);
		
		mav.addObject("siteName", siteName);
		mav.addObject("detail", product_detail);
		return mav;
	}
	
	@RequestMapping(value="{siteName}/checkout", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView viewCheckout(HttpSession session, HttpServletRequest request, 
			@RequestParam("p_id") int p_id,
			@PathVariable("siteName")String siteName) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		System.out.println("session: "+ session.getAttribute("u_id"));
		if(session.getAttribute("u_id") == null) {
			mav.setViewName("moveWithAlert");
			String referer = request.getHeader("referer");
			String msg = "로그인이 필요한 서비스입니다.";
			mav.addObject("msg", msg);
			mav.addObject("url", referer);
			return mav;
		}
		else {
			mav.setViewName("checkout");
			int u_id = (int) session.getAttribute("u_id");
			
			Map<String, Object>  userVO = memberService.GetUserInfo(u_id);
			Map<String, Object>  addressVO = memberService.GetUserAddress(u_id);
			
			Map<String, Object> product_detail = memberService.mall_getProductDetail(p_id);
			
			mav.addObject("siteName", siteName);
			mav.addObject("detail", product_detail);
			mav.addObject("userInfo",userVO);
			mav.addObject("address",addressVO);
			return mav;
		}
		
	}


	/************** 회원가입 부분 ***********/

	@RequestMapping(value="/register", method = RequestMethod.GET)
	public ModelAndView register() throws Exception{
		ModelAndView mav = new ModelAndView("register");
		
		return mav;
	}

	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String register(UserVO userVO) throws Exception{
		//logger.info(userVO.getUser_id());
		//logger.info(userVO.getTelephone());
		int check = memberService.idCheck(userVO);
//		logger.info(userVO.getUser_id());
//		logger.info(userVO.getEmail());
//		logger.info(userVO.getPostcode());
//		logger.info(userVO.getAddress());
		//logger.info(Integer.toString(check));
		// memberService.insertAddress(userVO);
		
		try {  // 비밀번호암호화 한 이후 회원정보 저장
			if(check == 1) {
				logger.info("duplicate");
				return "/register";
				
			}
			else if(check == 0) {
				logger.info("회원가입 성공");
				String inputPass = userVO.getPassword();
				// TODO: 
				String pwd = pwdEncoder.encode(inputPass);
				userVO.setPassword(pwd);
				memberService.insertUserInfo(userVO);
			}
		}catch(Exception e){
				throw new RuntimeException();
		} 
		int u_id = memberService.getU_Id(userVO.getUser_id());	
		userVO.setU_id(u_id);
//		logger.info(Integer.toString(u_id));
		memberService.insertAddress(userVO);
		//int user_id = memberService.getUserId(userVO.getUser_id());	
		//addressVO.setU_id(user_id);
		//memberService.insertAddress(addressVO);
		
		
		return "redirect:/";
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
