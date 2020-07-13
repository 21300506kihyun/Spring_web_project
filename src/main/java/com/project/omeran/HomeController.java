package com.project.omeran;

import java.io.Console;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.omeran.service.MemberService;

/**
 * Handles requests for the application home page.
 */



@Controller
public class HomeController {
	
	@Autowired
	private JavaMailSender mailSender;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	public String home() {
		
		return "index";
	}
	@RequestMapping(value = {"/index", "/p1.html"}, method = { RequestMethod.GET, RequestMethod.POST })
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
	@RequestMapping(value = "/p5", method = { RequestMethod.GET, RequestMethod.POST })
	public String home5() {
		
		return "p5";
	}
	
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "/faq", method = { RequestMethod.GET, RequestMethod.POST })
	public String faq() {
		return "faq";
	}
	
	@RequestMapping(value = "/faqWrite", method = { RequestMethod.GET, RequestMethod.POST })
	public String faqWrite() {
		return "faqWrite";
	}
	
	@Autowired
    MemberService memberService;
	
	@RequestMapping(value = "/test", method = { RequestMethod.GET, RequestMethod.POST })
	public void test() {
		System.out.println(memberService.getEmail("1"));
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


	
}