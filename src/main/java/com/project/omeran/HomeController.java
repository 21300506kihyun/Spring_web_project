package com.project.omeran;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "index";
	}
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String home_2() {
		
		return "index";
	}
	@RequestMapping(value = "/p2", method = RequestMethod.GET)
	public String home2() {
		
		return "p2";
	}
	@RequestMapping(value = "/p3", method = RequestMethod.GET)
	public String home3() {
		
		return "p3";
	}
	@RequestMapping(value = "/p4", method = RequestMethod.GET)
	public String home4() {
		
		return "p4";
	}
	@RequestMapping(value = "/p5", method = RequestMethod.GET)
	public String home5() {
		
		return "p5";
	}

	
}
