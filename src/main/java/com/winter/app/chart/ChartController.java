package com.winter.app.chart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chart")
public class ChartController {

	@Autowired
	private ChartService chartService;
	
	@PostMapping("getPrice")
	@ResponseBody
	public Long getPrice(@RequestBody String month) throws Exception{
		month = month.substring(5,month.length()-1);
		if(month.length() == 1) {
			month = "0"+month;
		}
		Long result = chartService.getPrice(month);
		return result;
	}
	
	@GetMapping("/main")
	public void getMain() {
		
	}
	
}
