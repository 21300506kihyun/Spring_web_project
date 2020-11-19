package com.project.omeran;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.omeran.dto.MallVO;
import com.project.omeran.dto.OrderVO;
import com.project.omeran.dto.PaginationVO;
import com.project.omeran.dto.UserVO;
import com.project.omeran.service.MemberService;

@Controller
public class AdminController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	Map<String, String> EmptyMap = new HashMap<String, String>();
	
	
	// super admin test (0: 고객, 1: 몰 관리자, 2: 배송자, -2: 플랫폼 관리자)
	private int admin_sessionTest(HttpSession session) {
		if(session.getAttribute("loginValidity") != null) {
			if((boolean)session.getAttribute("loginValidity") == true) {
				return (int)session.getAttribute("user_category");
			} 
		}
		return 0;
	}
	
	private String home() {
		return "redirect:/index";
	}
	
	private String isOpen = "sideOpen";
	
	@RequestMapping(value = "/adminSidebar.toggle", method = { RequestMethod.GET, RequestMethod.POST })
    private void platFormToggleSidebar(String isSideOpen, HttpSession session) {
    	isOpen = isSideOpen;
    }

    @RequestMapping(value = "/{siteName}/adminSidebar.toggle", method = { RequestMethod.GET, RequestMethod.POST })
    private void toggleSidebar(String isSideOpen, HttpSession session, @PathVariable("siteName") String siteName) {
    	isOpen = isSideOpen;
    }
    
    private ModelAndView goHome() {
    	ModelAndView mav = new ModelAndView(home());
    	return mav;
    }
    
    private ModelAndView redirectToHome() {
    	ModelAndView mav = new ModelAndView("redirect:/index");
    	return mav;
    }
     
    //TODO: 404 페이지 하나 만들어서 안들어가지도록 하기
    private ModelAndView go404() {
    	ModelAndView mav = new ModelAndView("page404");
    	return mav;
    }
    
    private void variableInjection(ModelAndView mav) {
    	mav.addObject("isOpen", isOpen);
    }
    
    private List<Map<String, Object>> getProductListFromDB(String state, HttpSession session) {
    	List<Map<String, Object>> productList;
    	if(state == null || state.equals("ALL")) {
    		productList = memberService.getAllProductList(session);
    	}
    	else {
    		productList = memberService.getProductList(state, session);
    	}
    	return productList;
    }
    
    private Map<String, Object> admin_getProductInfoById(int p_id){
    	Map<String, Object> productInfo;
    	
    	productInfo = memberService.admin_getProductInfoById(p_id);
    	
    	return productInfo;
    }
    
    private List<Map<String, Object>> setCommaPrice(List<Map<String, Object>> ListMap){
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
    
    private List<Map<String, Object>> calculateDiscountRate(List<Map<String, Object>> ListMap){
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
    
    private List<Map<String, Object>> manufactureProductList(List<Map<String, Object>> ListMap){
    	// 원가, 판매가 콤마 표시
    	ListMap = setCommaPrice(ListMap);
		
		// 할인율 계산
    	ListMap = calculateDiscountRate(ListMap);
    	return ListMap;
    }
    
    private List<Map<String, Object>> getStateList(String category){
    	return memberService.getStateList(category); 
    }
    
    private boolean isNumber(String str) {
    	boolean isNum = true;
    	for(int i=0; i<str.length(); i++) {
    		if(!Character.isDigit(str.charAt(i))) {
    			isNum = false;
    			break;
    		}
    	}
    	return isNum;
    }
    
    private void adminProduct_simpleUpdate(Map<String, String> paramMap, List<String> paramList) {
    	if(paramMap == null || paramList == null) {
    		return ;
    	}
    	
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
	
    private static String UPLOAD_PATH = "/uploadFolder";
	
	private String saveFile(MultipartFile file) {
		// 파일 이름 변경
	    UUID uuid = UUID.randomUUID();
	    String saveName = uuid + "_" + file.getOriginalFilename();

	    logger.info("saveName: {}",saveName);

	    // 저장할 File 객체를 생성(껍데기 파일)ㄴ
	    File saveFile = new File(UPLOAD_PATH,saveName); // 저장할 폴더 이름, 저장할 파일 이름

	    try {
	        file.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }

	    return saveName;
	}
	
	private String saveFileAs(MultipartFile file, String fileName) {
		// 파일 이름 변경
	    String saveName = fileName;

	    logger.info("saveName: {}",saveName);

	    // 저장할 File 객체를 생성(껍데기 파일)ㄴ
	    File saveFile = new File(UPLOAD_PATH,saveName); // 저장할 폴더 이름, 저장할 파일 이름

	    try {
	        file.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }

	    return saveName;
	}
    
	private boolean siteNameValidityCheck(String siteName) {
		// 해당 사이트가 존재하면 true 아니면 false
		if(memberService.admin_getSiteCountBySiteName(siteName) >= 1) {
			return true;
		}
		return false;
	}
	
	
	
	
	
	
	
	
	
	
	
	/*********** [ 슈퍼 관리자 페이지: method ] ***********/
	
    public Map<String, String> superAdmin_paramMap_defaultSetting(Map<String, String> paramMap){
//    	System.out.println("SETTING: "+paramMap);
    	if(paramMap.get("superAdmin_searchText") == null) {
    		paramMap.put("superAdmin_serarchText", "");
    	}
    	if(paramMap.get("startIndex") == null) {
    		paramMap.put("startIndex", "0");
    	}
    	if(paramMap.get("cntPerPage") == null) {
    		paramMap.put("cntPerPage", "10");
    	}

    	return paramMap;
    }
    
    private int superAdminMain_curPage = 1;
    private int superAdminMallManger_curPage = 1;
    private int superAdminCustomer_curPage = 1;
    
    private ModelAndView superAdminMain_getMallList(HttpSession session, Map<String, String>paramMap) {
    	ModelAndView mav = new ModelAndView();
    	// set superAdminMain_curPage as currPage
    	if(paramMap.get("currentPage") != null) {
			superAdminMain_curPage = Integer.parseInt(String.valueOf(paramMap.get("currentPage")));
		}
		else {
			superAdminMain_curPage = 1;				
		}
    	
		// Calculate Pagination
		int entireMallSize = memberService.superAdmin_getMallCount(paramMap);
		System.out.println("size: "+entireMallSize);
		
		List<MallVO> mallVOs = null;
		PaginationVO pagination = new PaginationVO(entireMallSize, superAdminMain_curPage);
		
		if(entireMallSize != 0) {
			// 만약 삭제로 인해서 페이지가 줄어들어서 현재 페이지가 없는 페이지가 되는 경우,
			if(pagination.getEndPage() < superAdminMain_curPage) {
				superAdminMain_curPage = pagination.getEndPage();
				pagination = new PaginationVO(entireMallSize, superAdminMain_curPage);
			}
			
			int startIndex = pagination.getStartIndex();
			int cntPerPage = pagination.getPageSize();
			
			
			// Set paramMap: SQL 날리기 위한 준비
			paramMap.put("startIndex", String.valueOf(startIndex));
			paramMap.put("cntPerPage", String.valueOf(cntPerPage));
			
			// paramMap에 없는 값은 Default Setting
//			System.out.println("before SETTING: "+paramMap);
			paramMap = superAdmin_paramMap_defaultSetting(paramMap);
//			System.out.println("after SETTING: "+paramMap);
			
			// Get Mall List as (paging, superAdmin_searchText)
			mallVOs = memberService.superAdmin_getMalls(paramMap);
		}
		
		
		mav.addObject("mallList", mallVOs);
		mav.addObject("pagination", pagination);
		
		return mav;
    }
    
    private void superAdminMain_simpleDelete(List<String> paramList) {
    	// System.out.println("ParamList: "+paramList);
    	
    	if(paramList != null) {
    		for(String listItem : paramList) {
    			String listItemDetail[] = listItem.split(",");
    			if(listItemDetail[0].equals("-1")) {
    				continue;
    			}
    			
    			int mall_id = Integer.parseInt(listItemDetail[0]);
    			System.out.println("mallId: "+mall_id);
    			
    			memberService.superAdminMain_simpleDelete(mall_id);
    		}
    		
    	}
		
    }
    
    
    private ModelAndView superAdminMallManger_getMallManager(HttpSession session, Map<String, String>paramMap) {
    	ModelAndView mav = new ModelAndView();
    	// set superAdminMain_curPage as currPage
    	if(paramMap.get("currentPage") != null) {
    		superAdminMallManger_curPage = Integer.parseInt(String.valueOf(paramMap.get("currentPage")));
		}
		else {
			superAdminMallManger_curPage = 1;				
		}
    	
		// Calculate Pagination
		int entireAdminSize = memberService.superAdmin_getAdminCount(paramMap);
//		System.out.println("entireAdminSize: "+entireAdminSize);
		
		List<UserVO> userVOs = null;
		PaginationVO pagination = new PaginationVO(entireAdminSize, superAdminMallManger_curPage);
		
		if(entireAdminSize != 0) {
			// 만약 삭제로 인해서 페이지가 줄어들어서 현재 페이지가 없는 페이지가 되는 경우,
			if(pagination.getEndPage() < superAdminMallManger_curPage) {
				superAdminMallManger_curPage = pagination.getEndPage();
				pagination = new PaginationVO(entireAdminSize, superAdminMallManger_curPage);
			}
			
			int startIndex = pagination.getStartIndex();
			int cntPerPage = pagination.getPageSize();
			
			
			// Set paramMap: SQL 날리기 위한 준비
			paramMap.put("startIndex", String.valueOf(startIndex));
			paramMap.put("cntPerPage", String.valueOf(cntPerPage));
			
			
			// paramMap에 없는 값은 Default Setting
//			System.out.println("before SETTING: "+paramMap);
			paramMap = superAdmin_paramMap_defaultSetting(paramMap);
//			System.out.println("after SETTING: "+paramMap);
			
			
			// Get Mall List as (paging, superAdmin_searchText)
			userVOs = memberService.superAdmin_getAdminList(paramMap);
		}
		
//		System.out.println("userVOs: "+userVOs);
		
		mav.addObject("userVOs", userVOs);
		mav.addObject("pagination", pagination);
		
		return mav;
    }
    
    // 관리자 관리하기 Simple Delete
    private void superAdminManager_simpleDelete(List<String> paramList) {
    	if(paramList != null) {
			for(String listItem : paramList) {
//				System.out.println("listItem: " + listItem);
				
				String listItemDetail[] = listItem.split(",");
				if(listItemDetail[0].equals("-1")) {
					continue;
				}
				
				memberService.superAdmin_manager_simpleDelete(Integer.parseInt(listItem));
			}
		}
    }
    
    // 관리자 관리하기 Simple Modify
    private void superAdminManager_simpleModify(Map<String, String> paramMap, List<String> paramList) {
    	if(paramList != null) {
			for(String listItem : paramList) {
//				System.out.println("listItem: " + listItem);
				
				String listItemDetail[] = listItem.split(",");
				if(listItemDetail[0].equals("-1")) {
					continue;
				}
				
				paramMap.put("u_id", listItem);
				
				// memberService.Modify
				memberService.superAdmin_manager_simpleModify(paramMap);
			}
		}
    }
    
    // 플랫폼 유저 관리하기
    private ModelAndView superAdminCustomer_getCustomer(HttpSession session, Map<String, String>paramMap) {
    	ModelAndView mav = new ModelAndView();
    	// set superAdminMain_curPage as currPage
    	if(paramMap.get("currentPage") != null) {
    		superAdminCustomer_curPage = Integer.parseInt(String.valueOf(paramMap.get("currentPage")));
		}
		else {
			superAdminCustomer_curPage = 1;				
		}
    	
		// Calculate Pagination
		int entireCustomerSize = memberService.superAdmin_getCustomerCount(paramMap);
		
		List<UserVO> userVOs = null;
		PaginationVO pagination = new PaginationVO(entireCustomerSize, superAdminCustomer_curPage);
		
		if(entireCustomerSize != 0) {
			// 만약 삭제로 인해서 페이지가 줄어들어서 현재 페이지가 없는 페이지가 되는 경우,
			if(pagination.getEndPage() < superAdminCustomer_curPage) {
				superAdminCustomer_curPage = pagination.getEndPage();
				pagination = new PaginationVO(entireCustomerSize, superAdminCustomer_curPage);
			}
			
			int startIndex = pagination.getStartIndex();
			int cntPerPage = pagination.getPageSize();
			
			
			// Set paramMap: SQL 날리기 위한 준비
			paramMap.put("startIndex", String.valueOf(startIndex));
			paramMap.put("cntPerPage", String.valueOf(cntPerPage));
			
			
			// paramMap에 없는 값은 Default Setting
			System.out.println("before SETTING: "+paramMap);
			paramMap = superAdmin_paramMap_defaultSetting(paramMap);
			System.out.println("after SETTING: "+paramMap);
			
			
			// Get Mall List as (paging, superAdmin_searchText)
			userVOs = memberService.superAdmin_getCustomerList(paramMap);
		}
		
//		System.out.println("userVOs: "+userVOs);
		
		mav.addObject("userVOs", userVOs);
		mav.addObject("pagination", pagination);
		
		return mav;
    }
    
    // 플랫폼 유저 관리하기 Simple Delete
    private void superAdminCustomer_simpleDelete(List<String> paramList) {
    	if(paramList != null) {
			for(String listItem : paramList) {
//				System.out.println("listItem: " + listItem);
				
				String listItemDetail[] = listItem.split(",");
				if(listItemDetail[0].equals("-1")) {
					continue;
				}
				
				memberService.superAdmin_customer_simpleDelete(Integer.parseInt(listItem));
			}
		}
    }
    
    // 플랫폼 유저 관리하기 Simple Modify
    private void superAdminCustomer_simpleModify(Map<String, String> paramMap, List<String> paramList) {
    	if(paramList != null) {
			for(String listItem : paramList) {
//				System.out.println("listItem: " + listItem);
				
				String listItemDetail[] = listItem.split(",");
				if(listItemDetail[0].equals("-1")) {
					continue;
				}
				
				paramMap.put("u_id", listItem);
				
				// memberService.Modify
				memberService.superAdmin_customer_simpleModify(paramMap);
			}
		}
    }
    
    
    
    
    
    
    
    
    
	/*********** [ 슈퍼 관리자 페이지: requestMapping ] ***********/
    // 아이디 체크
    @ResponseBody 
    @RequestMapping(value = {"/superAdmin_idCheck.do"}, method = { RequestMethod.GET, RequestMethod.POST })
   	public int superAdmin_idCheck(String user_id) throws Exception {
   		System.out.println("idCheck: "+user_id);
   		UserVO userVO = new UserVO();
   		userVO.setUser_id(user_id);
   		
   		return memberService.idCheck(userVO);
   	}
    
    @ResponseBody 
    @RequestMapping(value = {"/superAdmin_mallNameCheck.do"}, method = { RequestMethod.GET, RequestMethod.POST })
   	public int superAdmin_mallNameCheck(String mall_name) throws Exception {
   		System.out.println("mallNameCheck: "+mall_name);
   		MallVO mallVO = new MallVO();
   		mallVO.setMall_name(mall_name);
   		
   		return memberService.mallNameCheck(mallVO);
   	}
    
    
    // 슈퍼 관리자 페이지 
    @RequestMapping(value = {"/superAdmin", "/superAdminMain"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView superAdminMain(HttpSession session, 
			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(admin_sessionTest(session) == -2) {
			mav = superAdminMain_getMallList(session, paramMap);
			
			session.setAttribute("adminSideState", "가입 쇼핑몰 관리");
			session.setAttribute("adminNowPage", "가입 쇼핑몰 관리");
			
			variableInjection(mav);
			
			mav.setViewName("superAdminMain");
			return mav;
		}
		else {
			return goHome();
		}
	}
    
	    // 검색 및 페이징
	    @RequestMapping(value = {"/superAdmin.search"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView superAdminMain_content(HttpSession session,
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    	ModelAndView mav = new ModelAndView();
	    	if(admin_sessionTest(session) == -2) {
		    	mav = superAdminMain_getMallList(session, paramMap);
		    	
				variableInjection(mav);
				
				mav.setViewName("superAdminMainContent");
				
				return mav;
	    	}
	    	else {
	    		return go404();
	    	}
	    }
    
		// 간단히 삭제하기
	    @RequestMapping(value = {"/superAdmin.delete"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView superAdminMain_delete(HttpSession session,
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap,
				@RequestParam(value="superAdminMain_mallList[]", required=false) List<String> paramList) throws Exception {
	    	ModelAndView mav = new ModelAndView();
	    	System.out.println(paramMap);
	    	System.out.println(paramList);
	    	if(admin_sessionTest(session) == -2) {
	    		superAdminMain_simpleDelete(paramList);
	    		
	    		mav = superAdminMain_content(session, paramMap);
				
				return mav;
	    	}
	    	else {
	    		return go404();
	    	}
	    }
    
    
		// 새로운 쇼핑몰 생성 페이지 
	    @RequestMapping(value = {"/superAdminNewMall"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView superAdmin_NewMall(HttpSession session, 
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
			ModelAndView mav = new ModelAndView();
			if(admin_sessionTest(session) == -2) {
				
				session.setAttribute("adminSideState", "가입 쇼핑몰 관리");
				session.setAttribute("adminNowPage", "신규 쇼핑몰 생성");
				
				variableInjection(mav);
				
				mav.setViewName("superAdminNewMall");
				return mav;
			}
			else {
				return goHome();
			}
		}
	    
	    	// 새로운 쇼핑몰 생성 기능
	    	@RequestMapping(value = {"/superAdminCreateNewMall"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdminCreateNewMall(HttpSession session, 
	    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    		System.out.println("create new: "+paramMap);
	    		// 몰 이름 중복체크
	    		if(superAdmin_mallNameCheck(paramMap.get("superAdmin_mallName")) >= 1) {
	    			ModelAndView mav = new ModelAndView();
	    			mav.setViewName("moveWithAlert");
	    			String referer = "superAdminNewMall";
	    			String msg = "죄송합니다. 쇼핑몰 이름이 중복되었습니다. 다시 한 번 확인해주세요.";
	    			mav.addObject("msg", msg);
	    			mav.addObject("url", referer);
	    			return mav;
	    		}
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			
	    			// INSERT INTO MallTable
	    			memberService.superAdmin_createNewMall(paramMap);
	    			
	    			// Map 초기화
	    			paramMap.clear();
	    			return superAdminMain(session, paramMap);
	    		}
	    		else {
	    			return goHome();
	    		}
	    	}

	    
	    // 쇼핑몰 디테일 뷰 및 수정 페이지
    	@RequestMapping(value = {"/superAdminDetailMall"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView superAdminDetailMall(HttpSession session, 
    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
    		ModelAndView mav = new ModelAndView();
    		if(admin_sessionTest(session) == -2) {
    			
    			int mall_id = Integer.parseInt(paramMap.get("mall_id"));
    			Map<String, Object> mallInfo = memberService.superAdmin_getMallInfoById(mall_id);
//    			System.out.println("mallInfo: "+mallInfo);
    			
    			session.setAttribute("adminSideState", "가입 쇼핑몰 관리");
    			session.setAttribute("adminNowPage", "쇼핑몰 관리하기");
    			
    			variableInjection(mav);
    			
    			mav.setViewName("superAdminBasic");
    			mav.addObject("pageContent", "superAdminDetailMallContent");
    			mav.addObject("mallInfo", mallInfo);
    			
    			return mav;
    		}
    		else {
    			return goHome();
    		}
    	}
    	
	    	// 쇼핑몰 디테일 수정 기능
	    	@RequestMapping(value = {"/superAdminModifyMall"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdminModifyMall(HttpSession session, 
	    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
//	    		System.out.println("mall modify: "+paramMap);
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			memberService.superAdmin_modifyMall(paramMap);
	    			
	    			// Map 초기화
	    			paramMap.clear();
	    			return superAdminMain(session, paramMap);
	    		}
	    		else {
	    			return goHome();
	    		}
	    	}
    	
	    	
	// 쇼핑몰 관리자 관리 메뉴
	@RequestMapping(value = {"/superAdminMallManager"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView superAdminMallManager(HttpSession session, 
			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(admin_sessionTest(session) == -2) {
			
			mav = superAdminMallManger_getMallManager(session, paramMap);
			
			session.setAttribute("adminSideState", "쇼핑몰 관리자 관리");
			session.setAttribute("adminNowPage", "쇼핑몰 관리자 관리");
			
			variableInjection(mav);
			
			mav.setViewName("superAdminMallManager");
			
			return mav;
		}
		else {
			return goHome();
		}
	}
	
		// 검색 및 페이징
	    @RequestMapping(value = {"/superAdminMallManager.search"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView superAdminMallManager_content(HttpSession session,
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    	ModelAndView mav = new ModelAndView();
	    	if(admin_sessionTest(session) == -2) {
	    		mav = superAdminMallManger_getMallManager(session, paramMap);
		    	
				variableInjection(mav);
				
				mav.setViewName("superAdminMallManagerContent");
				
				return mav;
	    	}
	    	else {
	    		return go404();
	    	}
	    }
	    

    	// 새로운 관리자 생성 페이지
    	@RequestMapping(value = {"/superAdminNewAdmin"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView superAdmin_NewAdmin(HttpSession session, 
    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
    		ModelAndView mav = new ModelAndView();
    		if(admin_sessionTest(session) == -2) {
    			
    			// 쇼핑몰 목록 가져오기
    			List<Map<String, Object>> mallList = memberService.superAdmin_getAllMalls_name_id();
    			
    			session.setAttribute("adminSideState", "쇼핑몰 관리자 관리");
    			session.setAttribute("adminNowPage", "신규 쇼핑몰 관리자 생성");
    			
    			variableInjection(mav);
    			
    			mav.setViewName("superAdminNewAdmin");
    			
    			mav.addObject("mallList", mallList);
    			return mav;
    		}
    		else {
    			return goHome();
    		}
    	}
    	
	    	// 새로운 쇼핑몰 관리자 생성 기능
	    	@RequestMapping(value = {"/superAdminCreateNewAdmin"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdminCreateNewAdmin(HttpSession session, 
	    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    		// ID 이름 중복체크
	    		if(superAdmin_idCheck(paramMap.get("superAdmin_id")) >= 1) {
	    			ModelAndView mav = new ModelAndView();
	    			mav.setViewName("moveWithAlert");
	    			String referer = "superAdminNewAdmin";
	    			String msg = "죄송합니다. ID가 중복되었습니다. 다시 한 번 확인해주세요.";
	    			mav.addObject("msg", msg);
	    			mav.addObject("url", referer);
	    			return mav;
	    		}
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			// System.out.println(":: " + paramMap);
	    			String EncodedPW = pwdEncoder.encode(paramMap.get("superAdmin_password"));
	    			
	    			paramMap.put("superAdmin_password", EncodedPW);
	    			paramMap.put("superAdmin_passwordCheck", EncodedPW);
	    			memberService.superAdmin_createNewAdmin(paramMap);
	    			
	    			// Map 초기화
	    			paramMap.clear();
	    			return superAdminMallManager(session, paramMap);
	    		}
	    		else {
	    			return goHome();
	    		}
	    	}
	    	
	    	
	    	
    	// 관리자 디테일 뷰 및 수정 페이지
    	@RequestMapping(value = {"/superAdminDetailAdmin"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView superAdminDetailAdmin(HttpSession session, 
    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
    		ModelAndView mav = new ModelAndView();
//    		System.out.println(paramMap);
    		if(admin_sessionTest(session) == -2) {
    			int u_id = Integer.parseInt(paramMap.get("u_id"));
    			Map<String, Object> userInfo = memberService.superAdmin_getUserInfoById(u_id);
//    			System.out.println("userInfo: "+userInfo);
    			
    			// 쇼핑몰 목록 가져오기
    			List<Map<String, Object>> mallList = memberService.superAdmin_getAllMalls_name_id();
    			
    			session.setAttribute("adminSideState", "쇼핑몰 관리자 관리");
    			session.setAttribute("adminNowPage", "관리자 관리하기");
    			
    			variableInjection(mav);
    			
    			mav.setViewName("superAdminBasic");
    			mav.addObject("pageContent", "superAdminDetailAdminContent");
    			mav.addObject("mallList", mallList);
    			mav.addObject("userInfo", userInfo);
    			
    			return mav;
    		}
    		else {
    			return goHome();
    		}
    	}
	    	
	    	// 관리자 디테일 수정 기능
	    	@RequestMapping(value = {"/superAdmin_modifyDetailAdmin"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdmin_modifyDetailAdmin(HttpSession session, 
	    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
//	    		System.out.println("admin modify: "+paramMap);
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			if(paramMap.get("superAdmin_password") == "") {
//	    				System.out.println("null");
	    				memberService.superAdmin_modifyDetailAdmin_withoutPW(paramMap);
	    			} 
	    			else {
//	    				System.out.println("not null");
	    				String EncodedPW = pwdEncoder.encode(paramMap.get("superAdmin_password"));
		    			
		    			paramMap.put("superAdmin_password", EncodedPW);
		    			paramMap.put("superAdmin_passwordCheck", EncodedPW);
	    				memberService.superAdmin_modifyDetailAdmin_withPW(paramMap);
	    			}
	    			
	    			// Map 초기화
	    			paramMap.clear();
	    			return superAdminMallManager(session, paramMap);
	    		}
	    		else {
	    			return goHome();
	    		}
	    	}
	    	
	    	
	    	@RequestMapping(value = {"/superAdminManager_simpleUpdate"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdminManager_simpleUpdate(HttpSession session,
	    			@RequestParam(required=false, defaultValue = "{}") Map<String, String> paramMap,
	    			@RequestParam(value="superAdminManager_uids[]", required=false) List<String> paramList) throws Exception {
	    		System.out.println("paramList: "+paramList);
	    		System.out.println("paramMap: "+paramMap);
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			if(Integer.parseInt(paramMap.get("superAdmin_isDelete")) == 1) {
	    				superAdminManager_simpleDelete(paramList);
	    			}
	    			else {
	    				superAdminManager_simpleModify(paramMap, paramList);
	    			}
	    			
	    			return superAdminMallManager_content(session, paramMap);
	    		}
	    		else {
	    			return goHome();
	    		}
	    	}
	    	
	    	
	    	
	// 플랫폼 유저 관리 메뉴
	@RequestMapping(value = {"/superAdminCustomer"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView superAdminCustomer(HttpSession session, 
			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(admin_sessionTest(session) == -2) {
			
			mav = superAdminCustomer_getCustomer(session, paramMap);
			
			session.setAttribute("adminSideState", "플랫폼 유저 관리");
			session.setAttribute("adminNowPage", "플랫폼 유저 관리");
			
			variableInjection(mav);
			
			mav.setViewName("superAdminCustomer");
			 
			return mav;
		}
		else {
			return goHome();
		}
	}
	
		// 검색 및 페이징
	    @RequestMapping(value = {"/superAdminCustomer.content"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView superAdminCustomer_content(HttpSession session,
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    	ModelAndView mav = new ModelAndView();
	    	if(admin_sessionTest(session) == -2) {
	    		mav = superAdminCustomer_getCustomer(session, paramMap);
		    	
				variableInjection(mav);
				
				mav.setViewName("superAdminCustomerContent");
				
				return mav;
	    	}
	    	else {
	    		return go404();
	    	}
	    }
	    
	    // Simple update
	    @RequestMapping(value = {"/superAdminCustomer_simpleUpdate"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView superAdminCustomer_simpleUpdate(HttpSession session,
    			@RequestParam(required=false, defaultValue = "{}") Map<String, String> paramMap,
    			@RequestParam(value="superAdminCustomer_uids[]", required=false) List<String> paramList) throws Exception {
    		System.out.println("paramList: "+paramList);
    		System.out.println("paramMap: "+paramMap);
    		
    		if(admin_sessionTest(session) == -2) {
    			if(Integer.parseInt(paramMap.get("superAdmin_isDelete")) == 1) {
    				superAdminCustomer_simpleDelete(paramList);
    			}
    			else {
    				superAdminCustomer_simpleModify(paramMap, paramList);
    			}
    			
    			return superAdminCustomer_content(session, paramMap);
    		}
    		else {
    			return goHome();
    		}
    	}
	    
	 // 관리자 디테일 뷰 및 수정 페이지
	@RequestMapping(value = {"/superAdminCustomerDetail"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView superAdminCustomerDetail(HttpSession session, 
			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView();
//    		System.out.println(paramMap);
		if(admin_sessionTest(session) == -2) {
			int u_id = Integer.parseInt(paramMap.get("u_id"));
			Map<String, Object> userInfo = memberService.superAdmin_getUserInfoById(u_id);
//    			System.out.println("userInfo: "+userInfo);
			
			// 쇼핑몰 목록 가져오기
//			List<Map<String, Object>> mallList = memberService.superAdmin_getAllMalls_name_id();
			
			session.setAttribute("adminSideState", "플랫폼 유저 관리");
			session.setAttribute("adminNowPage", "플랫폼 유저 상세정보");
			
			variableInjection(mav);
			
			mav.setViewName("superAdminBasic");
			mav.addObject("pageContent", "superAdminCustomerDetail");
			mav.addObject("userInfo", userInfo);
			
			return mav;
		}
		else {
			return goHome();
		}
	}
    	
    	@RequestMapping(value = {"/superAdmin_modifyDetailCustomer"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView superAdmin_modifyDetailCustomer(HttpSession session, 
    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
    		
    		if(admin_sessionTest(session) == -2) {
    			if(paramMap.get("superAdmin_isEmail") != null) {
    				if(paramMap.get("superAdmin_isEmail").equals("on")) {
        				paramMap.put("superAdmin_isEmail", "1");
        			}
    			}
    			else {
    				paramMap.put("superAdmin_isEmail", "0");
    			}
    			
    			if(paramMap.get("superAdmin_isSMS") != null) {
    				if(paramMap.get("superAdmin_isSMS").equals("on")) {
    					paramMap.put("superAdmin_isSMS", "1");
    				}
    			}
    			else {
    				paramMap.put("superAdmin_isSMS", "0");
    			}
    			
    			if(paramMap.get("superAdmin_password") == "") {
    				memberService.superAdmin_modifyDetailCustomer_withoutPW(paramMap);
    			} 
    			else {
    				String EncodedPW = pwdEncoder.encode(paramMap.get("superAdmin_password"));

	    			paramMap.put("superAdmin_password", EncodedPW);
	    			paramMap.put("superAdmin_passwordCheck", EncodedPW);
    				memberService.superAdmin_modifyDetailCustomer_withPW(paramMap);
    			}
    			
    			// Map 초기화
    			paramMap.clear();
    			return superAdminCustomer(session, paramMap);
    		}
    		else {
    			return goHome();
    		}
    	}
	

    
    
    
    
    
    
    
	
	
	
	
    
    /*********** [ 관리자 페이지 ] ***********/
    // 관리자 페이지: 대시보드 
    @RequestMapping(value = {"/{siteName}/admin", "/{siteName}/adminDashboard"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDashboard(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
    	ModelAndView mav = new ModelAndView();

    	if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
    	
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "대시보드");
			session.setAttribute("adminNowPage", "대시보드");
			
			variableInjection(mav);
			
			mav.addObject("siteName", siteName);
			
			mav.setViewName("adminDashboard");
			return mav;
		}
		else {
			return goHome();
		}
	}
    
    // 관리자 페이지: 상품관리 
    @RequestMapping(value = "/{siteName}/adminProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminProduct(
			HttpSession session,
			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap,
			@RequestParam(value="adminProduct_productItem[]", required=false) List<String> paramList,
			@PathVariable("siteName") String siteName
			) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			// 간단히 modify & delete 하기
			adminProduct_simpleUpdate(paramMap, paramList);

			session.setAttribute("adminSideState", "상품관리");
			session.setAttribute("adminNowPage", "상품관리");

			variableInjection(mav);
			
			// DB에서 상품 정보 가져오기 
			List<Map<String, Object>> productList, stateListP;
			int cntAll = 0, cntP001 = 0, cntP002 = 0, cntP003 = 0;
			
			productList = getProductListFromDB(null, session);
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
			
			mav.addObject("siteName", siteName);
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
	    @RequestMapping(value = "/{siteName}/adminProduct_tap01", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap01(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
	    	System.out.println("Tap 01"+siteName);
			ModelAndView mav = new ModelAndView();
			
			if(!siteNameValidityCheck(siteName)) {
	    		return redirectToHome();
	    	}
			
			if(admin_sessionTest(session) <= -1) {
				List<Map<String, Object>> productList, stateListP;
				productList = getProductListFromDB("ALL", session);
				stateListP = getStateList("P");
				
				// 정보 가공하기
				productList = manufactureProductList(productList);
				
				mav.addObject("productList", productList);
				mav.addObject("stateListP", stateListP);
				
				
				mav.setViewName("adminProductContent");
				
				return mav;
			}
			else {
				return go404();
			}
		}
	    
		// 관리자 페이지: 상품관리 02 탭
	    @RequestMapping(value = "/{siteName}/adminProduct_tap02", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap02(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
	    	System.out.println("Tap 02"+siteName);
			ModelAndView mav = new ModelAndView();
			
			if(!siteNameValidityCheck(siteName)) {
	    		return redirectToHome();
	    	}
			
			if(admin_sessionTest(session) <= -1) {
				List<Map<String, Object>> productList, stateListP;
				productList = getProductListFromDB("P001", session);
				stateListP = getStateList("P");
				
				// 정보 가공하기
				productList = manufactureProductList(productList);
				
				mav.addObject("productList", productList);
				mav.addObject("stateListP", stateListP);
				
				mav.setViewName("adminProductContent");
				
				return mav;
			}
			else {
				return go404();
			}
			
		}
	 	// 관리자 페이지: 상품관리 03 탭
	    @RequestMapping(value = "/{siteName}/adminProduct_tap03", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap03(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			if(!siteNameValidityCheck(siteName)) {
	    		return redirectToHome();
	    	}

			if(admin_sessionTest(session) <= -1) {
				List<Map<String, Object>> productList, stateListP;
				productList = getProductListFromDB("P002", session);
				stateListP = getStateList("P");
				
				// 정보 가공하기
				productList = manufactureProductList(productList);
				
				mav.addObject("productList", productList);
				mav.addObject("stateListP", stateListP);
				
				mav.setViewName("adminProductContent");
				
				return mav;
			}
			else {
				return go404();
			}
			
		}
	 	// 관리자 페이지: 상품관리 04 탭
	    @RequestMapping(value = "/{siteName}/adminProduct_tap04", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap04(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			if(!siteNameValidityCheck(siteName)) {
	    		return redirectToHome();
	    	}
			
			if(admin_sessionTest(session) <= -1) {
				List<Map<String, Object>> productList, stateListP;
				productList = getProductListFromDB("P003", session);
				stateListP = getStateList("P");
				
				// 정보 가공하기
				productList = manufactureProductList(productList);
				
				mav.addObject("productList", productList);
				mav.addObject("stateListP", stateListP);
				
				mav.setViewName("adminProductContent");
				
				return mav;
			}
			else {
				return go404();
			}
			
		}
	 	// 관리자 페이지: 상품관리 05 탭 (휴지통: 미사용)
	    @RequestMapping(value = "/{siteName}/adminProduct_tap05", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminProduct_tap05(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			if(!siteNameValidityCheck(siteName)) {
	    		return redirectToHome();
	    	}
			
			if(admin_sessionTest(session) <= -1) {
				mav.setViewName("adminProductContent");
				
				mav.addObject("testData", "testData05");
				
				return mav;
			}
			else {
				return go404();
			}
		}
	    
	// 관리자 페이지: 상품 추가
	@RequestMapping(value="/{siteName}/adminProductNew", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView adminProductNew(HttpSession session, @PathVariable("siteName") String siteName) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "상품관리");
			session.setAttribute("adminNowPage", "상품추가");
			
			variableInjection(mav);
			
			mav.setViewName("adminProductNew");
			mav.addObject("siteName", siteName);
			
			return mav;
		}
		else {
			return goHome();
		}
	}
		// 상품 추가하기 INSERT 
		@RequestMapping(value="/{siteName}/adminProductCreateNew", method= {RequestMethod.GET, RequestMethod.POST})
		public ModelAndView adminProductCreateNew(
				HttpSession session, 
				MultipartFile adminProductDetail_productImage,
				@RequestParam Map<String, String> paramMap,
				@PathVariable("siteName") String siteName) throws Exception {
			ModelAndView mav = new ModelAndView();
			
			if(!siteNameValidityCheck(siteName)) {
	    		return redirectToHome();
	    	}
			
			if(admin_sessionTest(session) <= -1) {
				System.out.println("paramMap: " + paramMap);
				System.out.println("업로드된 파일!: "+adminProductDetail_productImage);
				UPLOAD_PATH = (String)paramMap.get("adminProductDetail_contextPath") + "/uploadFolder";
				String filePath = saveFile(adminProductDetail_productImage);
				
				System.out.println("result: " + filePath);
				
				paramMap.put("filePath", filePath);
				paramMap.put("state_id", "P002");	// 판매대기
				paramMap.put("mall_id", String.valueOf(session.getAttribute("mall_id")));	// 판매대기
				
				System.out.println("paramMap: " + paramMap);
				
				memberService.adminProductCreateNew(paramMap);
				
			
				mav = adminProduct(session, null, null, siteName);
				
				mav.setViewName("redirect:adminProduct");
				
				return mav;
			}
			else {
				return goHome();
			}
		}
		
		
	// 관리자 페이지: 상품 상세정보
	@RequestMapping(value="/{siteName}/adminProductDetail", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView adminProductDetail(HttpSession session, 
			@RequestParam Map<String, String> paramMap,
			@PathVariable("siteName") String siteName) throws Exception{
		System.out.println("detail: "+paramMap);
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "상품관리");
			session.setAttribute("adminNowPage", "상품 상세정보");
			
			int p_id = Integer.parseInt(paramMap.get("p_id"));
			
			Map<String, Object> productInfo = admin_getProductInfoById(p_id);
			System.out.println("productInfo: "+productInfo);
			
			
			variableInjection(mav);
			
			mav.setViewName("adminProductDetail");
			mav.addObject("productInfo", productInfo);
			mav.addObject("siteName", siteName);
			
			return mav;
		}
		else {
			return goHome();
		}
	}
	
			// 상품 상세정보 수정하기
			@RequestMapping(value="/{siteName}/adminProductModifyDetail", method= {RequestMethod.GET, RequestMethod.POST})
			public ModelAndView adminProductModifyDetail(
					HttpSession session, 
					MultipartFile adminProductDetail_productImage,
					@RequestParam Map<String, String> paramMap,
					@PathVariable("siteName") String siteName) throws Exception {
				ModelAndView mav = new ModelAndView();
				
				if(!siteNameValidityCheck(siteName)) {
		    		return redirectToHome();
		    	}
				
				if(admin_sessionTest(session) <= -1) {
					String adminProductDetail_fileTest = paramMap.get("adminProductDetail_fileTest");
					
					System.out.println("paramMap: " + paramMap);
					System.out.println("업로드된 파일!: "+adminProductDetail_productImage);
					UPLOAD_PATH = (String)paramMap.get("adminProductDetail_contextPath") + "/uploadFolder";
					
					// 1. 만약 파일이 null 이 아니라면 (즉, 새로운 파일이 올라왔으면)
					if(adminProductDetail_fileTest.equals("afterNewUpload")) {
						// save file as 를 통해서 해당 이름으로 파일을 저장하기
						String fileName = (String)paramMap.get("adminProductDetail_productImageName");
						System.out.println("File SaveAs: "+fileName);
						String filePath = saveFileAs(adminProductDetail_productImage, fileName);
					}
					else {
						System.out.println("Do Not Anything");
					}
					
					// 2. 입력된 정보를 통해 UPDATE 구문 작성하기
					memberService.adminProduct_modifyDetail(paramMap);
				
					mav = adminProduct(session, null, null, siteName);
					
					mav.setViewName("redirect:adminProduct");
					mav.addObject("siteName", siteName);
					
					return mav;
				}
				else {
					return goHome();
				}
			}
	
		
    
    // 관리자 페이지: 주문관리 
	private int adminOrder_currTap = 1;
	private int adminOrder_curPage = 1;
	
	private Map<String, String> admin_paramMap_defaultSetting(Map<String, String> paramMap, HttpSession session){
		if(paramMap.get("mall_id") == null) {
			paramMap.put("mall_id", String.valueOf(session.getAttribute("mall_id")));
		}
		if(paramMap.get("search_keyword") == null) {
    		paramMap.put("search_keyword", "");
    	}
    	if(paramMap.get("startIndex") == null) {
    		paramMap.put("startIndex", "0");
    	}
    	if(paramMap.get("cntPerPage") == null) {
    		paramMap.put("cntPerPage", "10");
    	}
    	
    	// state_id 설정
    	if(adminOrder_currTap == 1) {
    		paramMap.put("state_id", "O001");
    	}
    	else if(adminOrder_currTap == 2) {
    		paramMap.put("state_id", "O002");
    	}
    	else if(adminOrder_currTap == 3) {
    		paramMap.put("state_id", "O003");
    	}
    	else if(adminOrder_currTap == 4) {
    		paramMap.put("state_id", "O004");
    	}
    	else if(adminOrder_currTap == 5) {
    		paramMap.put("state_id", "O005");
    	}
		
		return paramMap;
	}
	
	
	
	private ModelAndView adminOrder_getOrderList(HttpSession session, Map<String, String>paramMap) {
    	ModelAndView mav = new ModelAndView();
    	// set superAdminMain_curPage as currPage
    	if(paramMap.get("currentPage") != null) {
    		adminOrder_curPage = Integer.parseInt(String.valueOf(paramMap.get("currentPage")));
		}
		else {
			adminOrder_curPage = 1;				
		}
    	
		// Calculate Pagination
		int entireOrderSize = memberService.adminOrder_getOrderCount(paramMap);
		System.out.println("Order size: "+entireOrderSize);
		
		List<Map<String, String>> OrderList = null;
		List<Integer> orderCnt = null;
		PaginationVO pagination = new PaginationVO(entireOrderSize, adminOrder_curPage);
		
		if(entireOrderSize != 0) {
			// 상태마다 주문이 몇개 있는지 가져오기
			int mallID = (int)session.getAttribute("mall_id");
			int orderCnt01 = memberService.adminOrder_getOrderCountByState("O001", mallID);
			int orderCnt02 = memberService.adminOrder_getOrderCountByState("O002", mallID);
			int orderCnt03 = memberService.adminOrder_getOrderCountByState("O003", mallID);
			int orderCnt04 = memberService.adminOrder_getOrderCountByState("O004", mallID);
			int orderCnt05 = memberService.adminOrder_getOrderCountByState("O005", mallID);
			orderCnt = new ArrayList<Integer>() {{
				add(orderCnt01);
				add(orderCnt02);
				add(orderCnt03);
				add(orderCnt04);
				add(orderCnt05);
			}};
			
			
			// 만약 삭제로 인해서 페이지가 줄어들어서 현재 페이지가 없는 페이지가 되는 경우,
			if(pagination.getEndPage() < adminOrder_curPage) {
				superAdminMain_curPage = pagination.getEndPage();
				pagination = new PaginationVO(entireOrderSize, adminOrder_curPage);
			}
			
			int startIndex = pagination.getStartIndex();
			int cntPerPage = pagination.getPageSize();
			
			
			// Set paramMap: SQL 날리기 위한 준비
			paramMap.put("startIndex", String.valueOf(startIndex));
			paramMap.put("cntPerPage", String.valueOf(cntPerPage));
			
			// paramMap에 없는 값은 Default Setting(searchKeyword, paging, tap)
			paramMap = admin_paramMap_defaultSetting(paramMap, session);
			System.out.println("after SETTING: "+paramMap);
			
			// Get Mall List as (paging, superAdmin_searchText, tap)
			OrderList = memberService.adminOrder_getOrders(paramMap);
		
			System.out.println("order info: "+ OrderList);
		}
		
		
		mav.addObject("OrderList", OrderList);
		mav.addObject("pagination", pagination);
		mav.addObject("orderCnt", orderCnt);
		
		return mav;
    }
	
	
	private List<UserVO> admin_getDeliverymanList(int mall_id) {
		return memberService.admin_getDeliverymanList(mall_id);
	}
	
	
    @RequestMapping(value = "/{siteName}/adminOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminOrder(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "주문관리");
			session.setAttribute("adminNowPage", "주문관리");
			
			variableInjection(mav);
			
			// adminOrder_currTap = 1;
			mav = adminOrderContent(session, EmptyMap);
			
			mav.setViewName("adminOrder");
			mav.addObject("siteName", siteName);
			System.out.println("TAP: "+adminOrder_currTap);
			mav.addObject("currentTap", adminOrder_currTap);
			return mav;
		}
		else {
			return goHome();
		}
	}
    
	    // 주문관리 컨텐츠
	    @RequestMapping(value = {"/{siteName}/adminOrderContent"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminOrderContent(HttpSession session,
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    	ModelAndView mav = new ModelAndView();
	    	System.out.println("currentTap: "+adminOrder_currTap);
	    	System.out.println("adminOrderContent: "+paramMap);
	    	if(admin_sessionTest(session) <= -1) {
	    		System.out.println("adminOrderContent2: "+paramMap);
	    		
	    		mav = adminOrder_getOrderList(session, paramMap);
	    		
	    		// get state list by "Order"
	    		mav.addObject("stateList", getStateList("O"));
	    		
	    		// get delivery man List
	    		List<UserVO> deliverymanList = admin_getDeliverymanList((int)session.getAttribute("mall_id"));
	    		mav.addObject("deliverymanList", deliverymanList);
		    	
				variableInjection(mav);
				
				mav.setViewName("adminOrderContent");
				
				return mav;
	    	}
	    	else {
	    		return go404();
	    	}
	    }
	    
	    //admin Order Tap Menus
	    @RequestMapping(value = {"/{siteName}/adminOrder_tap"}, method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView adminOrderContent_tap01(HttpSession session, 
				@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception{
	    	ModelAndView mav = new ModelAndView();
	    	if(admin_sessionTest(session) <= -1) {
	    		adminOrder_currTap = Integer.parseInt(paramMap.get("tap"));
				mav = adminOrderContent(session, paramMap);
				return mav;
	    	}
	    	else {
	    		return go404();
	    	}
	    }
    
	    // Simple update
	    @RequestMapping(value = {"/{siteName}/adminOrder_simpleUpdate"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView adminOrder_simpleUpdate(HttpSession session,
    			@RequestParam(required=false, defaultValue = "{}") Map<String, String> paramMap,
    			@RequestParam(value="adminOrder_orderIDs[]", required=false) List<String> paramList,
    			@PathVariable("siteName") String siteName) throws Exception {
    		System.out.println("paramList: "+paramList);
    		System.out.println("paramMap: "+paramMap);
    		
    		if(admin_sessionTest(session) <= -1) {
    			
    			if(paramList != null) {
    	    		for(String listItem : paramList) {
    	    			String listItemDetail[] = listItem.split(",");
    	    			if(listItemDetail[0].equals("-1")) {
    	    				continue;
    	    			}
    	    			
    	    			int order_id = Integer.parseInt(listItemDetail[0]);
    	    			System.out.println("order_id: "+order_id);
    	    			
    	    			paramMap.put("order_id", String.valueOf(order_id));
    	    			
    	    			memberService.adminOrder_simpleUpdate(paramMap);
    	    		}
    	    		
    	    	}
    			
    			return adminOrder(session, siteName);
    		}
    		else {
    			return go404();
    		}
    	}
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
    // 관리자 페이지: 배송관리 
    @RequestMapping(value = "/{siteName}/adminDelivery", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDelivery(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "배송관리");
			session.setAttribute("adminNowPage", "배송관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminDelivery");
			mav.addObject("siteName", siteName);
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminDelivery");
//			return mav;	
		}
	}
    
    // 관리자 페이지: 고객관리 
    @RequestMapping(value = "/{siteName}/adminConsumer", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminConsumer(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "고객관리");
			session.setAttribute("adminNowPage", "고객관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminConsumer");
			mav.addObject("siteName", siteName);
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminConsumer");
//			return mav;	
		}
	}
    
    // 관리자 페이지: 배송자관리 
    @RequestMapping(value = "/{siteName}/adminDeliveryman", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDeliveryman(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "배송자관리");
			session.setAttribute("adminNowPage", "배송자관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminDeliveryman");
			mav.addObject("siteName", siteName);
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminDeliveryman");
//			return mav;	
		}
	}
    
    // 관리자 페이지: 사이트관리  
    @RequestMapping(value = "/{siteName}/adminSite", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminSite(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(!siteNameValidityCheck(siteName)) {
    		return redirectToHome();
    	}
		
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "사이트관리");
			session.setAttribute("adminNowPage", "사이트관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminSite");
			mav.addObject("siteName", siteName);
			return mav;
		}
		else {
			return goHome();
//			mav.setViewName("adminSite");
//			return mav;	
		}
	}
	
	
}
