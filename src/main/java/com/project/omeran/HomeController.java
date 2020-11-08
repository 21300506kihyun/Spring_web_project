package com.project.omeran;

import java.io.Console;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

//import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// session Test
	public boolean sessionTest(HttpSession session) {
		if(session.getAttribute("loginValidity") != null) {
			if((boolean)session.getAttribute("loginValidity") == true) {
				if((int)session.getAttribute("status") == -1) {
					return true;									
				}
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
	public ModelAndView login(@ModelAttribute MemberVO vo, HttpSession session, @RequestParam("id")String id, @RequestParam("pw")String pw,
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
	public ModelAndView logout(HttpSession session, @ModelAttribute MemberVO vo, HttpServletRequest request) {
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


    
    /*********** [ 관리자 페이지 ] ***********/
    public String isOpen = "sideOpen";

    @RequestMapping(value = "/adminSidebar.toggle", method = { RequestMethod.GET, RequestMethod.POST })
    public void toggleSidebar(String isSideOpen, HttpSession session) {
    	isOpen = isSideOpen;
    }
    
    public ModelAndView goHome() {
    	ModelAndView mav = new ModelAndView(home());
    	return mav;
    }
    
    public void variableInjection(ModelAndView mav) {
    	mav.addObject("isOpen", isOpen);
    }
    
    public List<Map<String, Object>> getProductListFromDB(String state) {
    	List<Map<String, Object>> productList;
    	if(state == null || state.equals("ALL")) {
    		productList = memberService.getAllProductList();
    	}
    	else {
    		productList = memberService.getProductList(state);
    	}
    	return productList;
    }
    
    public List<Map<String, Object>> setCommaPrice(List<Map<String, Object>> ListMap){
    	int price, discount_price;
    	String commaPrice, commaDiscountPrice;
    	
    	for(Map<String, Object> map : ListMap) {
    		price = (int)map.get("price");
    		discount_price = (int)map.get("discount_price");
    		commaPrice = String.format("%,d", price);
    		commaDiscountPrice = String.format("%,d", discount_price);
    		map.put("commaPrice", commaPrice);
    		map.put("commaDiscountPrice", commaDiscountPrice);
    	}
    	return ListMap;
    }
    
    public List<Map<String, Object>> calculateDiscountRate(List<Map<String, Object>> ListMap){
    	int price, discount_price;
    	String discountRate;
    	
    	for(Map<String, Object> map : ListMap) {
    		price = (int)map.get("price");
    		discount_price = (int)map.get("discount_price");
    		discountRate = String.format("%.0f", 100 - ((float)discount_price/price)*100);
    		map.put("discountRate", discountRate);
    		// System.out.println("price: "+price+" discount_price: "+discount_price+" -> "+discountRate);
    	}
    	return ListMap;
    }
    
    public List<Map<String, Object>> manufactureProductList(List<Map<String, Object>> ListMap){
    	// 원가, 판매가 콤마 표시
    	ListMap = setCommaPrice(ListMap);
		
		// 할인율 계산
    	ListMap = calculateDiscountRate(ListMap);
    	return ListMap;
    }
    
    public List<Map<String, Object>> getStateList(String category){
    	return memberService.getStateList(category); 
    }
    
    public boolean isNumber(String str) {
    	boolean isNum = true;
    	for(int i=0; i<str.length(); i++) {
    		if(!Character.isDigit(str.charAt(i))) {
    			isNum = false;
    			break;
    		}
    	}
    	return isNum;
    }
    
    public void adminProduct_simpleUpdate(Map<String, String> paramMap, List<String> paramList) {
    	System.out.println(paramMap);
    	System.out.println(paramList);
    	
    	int price, discount_price, isDelete = -9, productId;
		String updateStateId;
		
		if(paramMap.get("adminProduct_isDelete") != null) {
			isDelete = Integer.parseInt(paramMap.get("adminProduct_isDelete"));    		
		}
		
		if(paramList != null) {
			for(String listItem : paramList) {
				System.out.println("listItem: " + listItem);
				
				String listItemDetail[] = listItem.split(",");
				if(listItemDetail[0].equals("-1")) {
					continue;
				}
				
				productId = Integer.parseInt(listItemDetail[0]);
				price = Integer.parseInt(listItemDetail[1]);
				discount_price = Integer.parseInt(listItemDetail[2]);
				updateStateId = listItemDetail[3];
				
				// 삭제하기 
				if(isDelete == 1) {
					memberService.productDelete(productId);
					System.out.println("DELETE Product WHERE "+productId);
				}
				// 수정하기 
				else {
					// price
					if(paramMap.get("adminProduct_originPrice") != null) {
						if(!paramMap.get("adminProduct_originPrice").equals("") && isNumber(paramMap.get("adminProduct_originPrice"))) {
							price = Integer.parseInt(paramMap.get("adminProduct_originPrice"));
						}
					}
					// discount_price
					if(paramMap.get("adminProduct_sellingPrice") != null) {
						if(!paramMap.get("adminProduct_sellingPrice").equals("") && isNumber(paramMap.get("adminProduct_sellingPrice"))) {
							discount_price = Integer.parseInt(paramMap.get("adminProduct_sellingPrice"));
						}
					}
					
					// state_id
					if(paramMap.get("adminProduct_sellingPrice") != null) {
						if(!paramMap.get("adminProduct_status").equals("")) {
							updateStateId = paramMap.get("adminProduct_status");
						}
					}
					memberService.productSimpleUpdate(productId, price, discount_price, updateStateId);
					System.out.println("UPDATE QUERY "+price +" AND " + discount_price + " AND " + updateStateId);
				}
			}
		}
    }
    
    // 관리자 페이지: 대시보드 
    @RequestMapping(value = {"/admin", "/adminDashboard"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDashboard(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "대시보드");
			session.setAttribute("adminNowPage", "대시보드");
			
			variableInjection(mav);
			
			mav.setViewName("adminDashboard");
			return mav;
		}
		else {
			return goHome();
		}
	}
    
    // 관리자 페이지: 상품관리 
    @RequestMapping(value = "/adminProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminProduct(
			HttpSession session,
			@RequestParam Map<String, String> paramMap,
			@RequestParam(value="adminProduct_productItem[]", required=false) List<String> paramList
			) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			// 간단히 modify & delete 하기
			adminProduct_simpleUpdate(paramMap, paramList);
			
			
			

			session.setAttribute("adminSideState", "상품관리");
			session.setAttribute("adminNowPage", "상품관리");

			variableInjection(mav);
			
			// DB에서 상품 정보 가져오기 
			List<Map<String, Object>> productList, stateListP;
			int cntAll = 0, cntP001 = 0, cntP002 = 0, cntP003 = 0;
			
			productList = getProductListFromDB(null);
			stateListP = getStateList("P");
			
			// 탭메뉴 개수 표시용 
			cntAll = productList.size();
			for(int i=0; i<cntAll; i++) {
	    		String stateID = (String)productList.get(i).get("state_id");
	    		if(stateID.equals("P001")) {
	    			cntP001++;
	    		}
	    		else if(stateID.equals("P002")) {
	    			cntP002++;
	    		}
	    		else if(stateID.equals("P003")) {
	    			cntP003++;
	    		}
	    	}
			
			// 정보 가공하기
			productList = manufactureProductList(productList);
			
			mav.addObject("productList", productList);
			mav.addObject("cntAll", cntAll);
			mav.addObject("cntP001", cntP001);
			mav.addObject("cntP002", cntP002);
			mav.addObject("cntP003", cntP003);
			mav.addObject("stateListP", stateListP);
			
			mav.setViewName("adminProduct");
			return mav;
		}
		else {
			return goHome();
		}
	}
    
	 	// 관리자 페이지: 상품관리 01 탭
	    @RequestMapping(value = "/adminProduct.tap01", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap01(HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			List<Map<String, Object>> productList, stateListP;
			productList = getProductListFromDB("ALL");
			stateListP = getStateList("P");
			
			// 정보 가공하기
			productList = manufactureProductList(productList);
			
			mav.addObject("productList", productList);
			mav.addObject("stateListP", stateListP);
			
			
			mav.setViewName("adminProductContent");
			
			return mav;
		}
	    
		// 관리자 페이지: 상품관리 02 탭
	    @RequestMapping(value = "/adminProduct.tap02", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap02(HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			List<Map<String, Object>> productList, stateListP;
			productList = getProductListFromDB("P001");
			stateListP = getStateList("P");

			// 정보 가공하기
			productList = manufactureProductList(productList);
			
			mav.addObject("productList", productList);
			mav.addObject("stateListP", stateListP);
			
			mav.setViewName("adminProductContent");
			
			return mav;
		}
	 	// 관리자 페이지: 상품관리 03 탭
	    @RequestMapping(value = "/adminProduct.tap03", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap03(HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			List<Map<String, Object>> productList, stateListP;
			productList = getProductListFromDB("P002");
			stateListP = getStateList("P");

			// 정보 가공하기
			productList = manufactureProductList(productList);
			
			mav.addObject("productList", productList);
			mav.addObject("stateListP", stateListP);
			
			mav.setViewName("adminProductContent");
			
			return mav;
		}
	 	// 관리자 페이지: 상품관리 04 탭
	    @RequestMapping(value = "/adminProduct.tap04", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap04(HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			List<Map<String, Object>> productList, stateListP;
			productList = getProductListFromDB("P003");
			stateListP = getStateList("P");

			// 정보 가공하기
			productList = manufactureProductList(productList);
			
			mav.addObject("productList", productList);
			mav.addObject("stateListP", stateListP);
			
			mav.setViewName("adminProductContent");
			
			
			return mav;
		}
	 	// 관리자 페이지: 상품관리 05 탭 (휴지통: 미사용)
	    @RequestMapping(value = "/adminProduct.tap05", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap05(HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			mav.setViewName("adminProductContent");
			
			mav.addObject("testData", "testData05");
			
			return mav;
		}
	    
	// 관리자 페이지: 상품 추가
	@RequestMapping(value="/adminProductNew", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView adminProductNew(HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "상품관리");
			session.setAttribute("adminNowPage", "상품추가");
			
			variableInjection(mav);
			
			mav.setViewName("adminProductDetail");
			
			return mav;
		}
		else {
			return goHome();
		}
	}
    
    // 관리자 페이지: 주문관리 
    @RequestMapping(value = "/adminOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminOrder(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "주문관리");
			session.setAttribute("adminNowPage", "주문관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminOrder");
			return mav;
		}
		else {
			return goHome();
		}
	}
    
    // 관리자 페이지: 배송관리 
    @RequestMapping(value = "/adminDelivery", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDelivery(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "배송관리");
			session.setAttribute("adminNowPage", "배송관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminDelivery");
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminDelivery");
//			return mav;	
		}
	}
    
    // 관리자 페이지: 고객관리 
    @RequestMapping(value = "/adminConsumer", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminConsumer(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "고객관리");
			session.setAttribute("adminNowPage", "고객관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminConsumer");
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminConsumer");
//			return mav;	
		}
	}
    
    // 관리자 페이지: 배송자관리 
    @RequestMapping(value = "/adminDeliveryman", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDeliveryman(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "배송자관리");
			session.setAttribute("adminNowPage", "배송자관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminDeliveryman");
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminDeliveryman");
//			return mav;	
		}
	}
    
    // 관리자 페이지: 사이트관리  
    @RequestMapping(value = "/adminSite", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminSite(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(sessionTest(session)) {
			session.setAttribute("adminSideState", "사이트관리");
			session.setAttribute("adminNowPage", "사이트관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminSite");
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminSite");
//			return mav;	
		}
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
	public String register(UserVO userVO) throws Exception{
		logger.info("post register");
		logger.info(userVO.getUser_id());
		logger.info(userVO.getTelephone());
		int check = memberService.idCheck(userVO);
		logger.info(userVO.getUser_id());
		logger.info(userVO.getEmail());
		logger.info(Integer.toString(check));
		try {  // 비밀번호암호화 한 이후 회원정보 저장
			if(check == 1) {
				logger.info("duplicate");
				return "/register";
				
			}
			else if(check == 0) {
				logger.info("회원가입 성공");
				String inputPass = userVO.getPassword();
				logger.info("111111");
				String pwd = pwdEncoder.encode(inputPass);
				logger.info("222222");
				userVO.setPassword(pwd);
				logger.info("3333333");
				memberService.insertUserInfo(userVO);
				logger.info("444444");
				}
		}catch(Exception e){
				throw new RuntimeException();
		} 
		
		
		
		return "redirect:/mall";
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
