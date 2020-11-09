package com.project.omeran;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.omeran.dto.MallVO;
import com.project.omeran.dto.PaginationVO;
import com.project.omeran.service.MemberService;

@Controller
public class AdminController {
	
	@Autowired
	MemberService memberService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
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
		return "index";
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
    
	
	
	/*********** [ 슈퍼 관리자 페이지: method ] ***********/
	
    public Map<String, String> superAdmin_paramMap_defaultSetting(Map<String, String> paramMap){
    	System.out.println("SETTING: "+paramMap);
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
		PaginationVO pagination = new PaginationVO(entireMallSize, superAdminMain_curPage);
		
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
		System.out.println("before SETTING: "+paramMap);
		paramMap = superAdmin_paramMap_defaultSetting(paramMap);
    	System.out.println("after SETTING: "+paramMap);
		
    	
    	// Get Mall List as (paging, superAdmin_searchText)
		List<MallVO> mallVOs = memberService.superAdmin_getMalls(paramMap);
		
		
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
    
    
	/*********** [ 슈퍼 관리자 페이지: requestMapping ] ***********/
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
				
				mav.setViewName("superAdminManageContent");
				
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

	    	
    	@RequestMapping(value = {"/superAdminDetailMall"}, method = { RequestMethod.GET, RequestMethod.POST })
    	public ModelAndView superAdminDetailMall(HttpSession session, 
    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
    		ModelAndView mav = new ModelAndView();
    		if(admin_sessionTest(session) == -2) {
    			
    			int mall_id = Integer.parseInt(paramMap.get("mall_id"));
    			Map<String, Object> mallInfo = memberService.superAdmin_getMallInfoById(mall_id);
    			System.out.println("mallInfo: "+mallInfo);
    			
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
    	
	    	// 쇼핑몰 정보 수정 기능
	    	@RequestMapping(value = {"/superAdminModifyMall"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdminModifyMall(HttpSession session, 
	    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    		System.out.println("mall modify: "+paramMap);
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			// INSERT INTO MallTable
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
			
			// TODO: 관리자 목록 가져오기 JOIN MallTable
			
			session.setAttribute("adminSideState", "쇼핑몰 관리자 관리");
			session.setAttribute("adminNowPage", "쇼핑몰 관리자 관리");
			
			variableInjection(mav);
			
			mav.setViewName("superAdminBasic");
			mav.addObject("pageContent", "superAdminMallManagerContent");
			
			return mav;
		}
		else {
			return goHome();
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
    	
    		// TODO: form 체크하기
    		// TODO: 아이디 중복체크하기
	    	// 새로운 쇼핑몰 관리자 생성 기능
	    	@RequestMapping(value = {"/superAdminCreateNewAdmin"}, method = { RequestMethod.GET, RequestMethod.POST })
	    	public ModelAndView superAdminCreateNewAdmin(HttpSession session, 
	    			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
	    		System.out.println("create new Admin: "+paramMap);
	    		
	    		if(admin_sessionTest(session) == -2) {
	    			// INSERT INTO MallTable
	    			memberService.superAdmin_createNewAdmin(paramMap);
	    			
	    			// Map 초기화
	    			paramMap.clear();
	    			return superAdminMain(session, paramMap);
	    		}
	    		else {
	    			return goHome();
	    		}
	    	}

	// TODO: 페이지 구현.
	// 플랫폼 유저 관리 메뉴
	@RequestMapping(value = {"/superAdminUser"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView superAdminUser(HttpSession session, 
			@RequestParam(required=false, defaultValue= "{}") Map<String, String> paramMap) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(admin_sessionTest(session) == -2) {
			
			session.setAttribute("adminSideState", "플랫폼 유저 관리");
			session.setAttribute("adminNowPage", "플랫폼 유저 관리");
			
			variableInjection(mav);
			
			mav.setViewName("superAdminBasic");
			mav.addObject("pageContent", "superAdminUserContent");
			
			return mav;
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
			System.out.println("HELLO CHECK");
			
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
    @RequestMapping(value = "/{siteName}/adminOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminOrder(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(admin_sessionTest(session) <= -1) {
			session.setAttribute("adminSideState", "주문관리");
			session.setAttribute("adminNowPage", "주문관리");
			
			variableInjection(mav);
			
			mav.setViewName("adminOrder");
			mav.addObject("siteName", siteName);
			return mav;
		}
		else {
			return goHome();
		}
	}
    
    // 관리자 페이지: 배송관리 
    @RequestMapping(value = "/{siteName}/adminDelivery", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView adminDelivery(HttpSession session, @PathVariable("siteName") String siteName) throws Exception {
		ModelAndView mav = new ModelAndView();
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
