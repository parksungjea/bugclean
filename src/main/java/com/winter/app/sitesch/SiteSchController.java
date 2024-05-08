package com.winter.app.sitesch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.winter.app.general.CarDetailVO;
import com.winter.app.general.CarManageVO;
import com.winter.app.customer.CustomerController;
import com.winter.app.customer.CustomerVO;
import com.winter.app.employee.EmployeeVO;
import com.winter.app.util.pagination.Pagination;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/schedule")
@Slf4j
public class SiteSchController {
	
	@Autowired
	private SiteSchService schService;
	
	
	@GetMapping("getList")
	@ResponseBody
	public List<Map<String, Object>> getList(Pagination pagination, Model model) throws Exception {

		List<Map<String, Object>> map = schService.getList(pagination);

		model.addAttribute("list",map);
		
		return map;
		
	}
	
	@GetMapping({"list","sales_list"})
	public void list( Model model,CarManageVO carManageVO ) throws Exception{
	
		List<EmployeeVO> ar = schService.getSales();
		Map<String, Object> map = schService.getEmpName();
	    model.addAttribute("info",map);
		
		List<EmployeeVO> ar_emp = schService.getSiter();
		List<CustomerVO> list = schService.getCustomerList();

		//List<CarDetailVO> ar_car = schService.getUsableList();

		model.addAttribute("customerList", list);
		model.addAttribute("list", ar);
		model.addAttribute("list_emp", ar_emp);
		//model.addAttribute("list_car", ar_car);
		
	}
	
	
	
	
	@PostMapping("create")
	@ResponseBody
	public int createSchedule(@RequestBody SiteSchVO schVO) throws Exception{
		int result = schService.createSch(schVO);
		return result;
	}
	
	@PostMapping("updateSch")
	@ResponseBody
	public int updateSch(@RequestBody SiteSchVO schVO) throws Exception{

		int result = schService.updateSch(schVO);
		
		return result;
	}
	@PostMapping("updateSchType")
	@ResponseBody
	public int updateSchType(@RequestBody SiteSchVO schVO) throws Exception{
		int result = schService.updateSchType(schVO);
		
		return result;
	}
	
	@PostMapping("getSchedule")
	@ResponseBody
	public SiteSchVO getSchedule(@RequestBody SiteSchVO schVO) throws Exception{
		SiteSchVO result = schService.getSchedule(schVO);
		
		
		return result;
	}
	
	@PostMapping("updateSchDrag")
	@ResponseBody
	public int updateSchDrag(@RequestBody SiteSchVO schVO) throws Exception{
		int result =0;
		schService.updateSchDrag(schVO);
		
		return result;
	}
	
	@PostMapping("carAllocation")
	@ResponseBody
	public int carAllocation(@RequestBody SiteSchVO schVO) throws Exception{
		int result = schService.updateManageCode(schVO);
		
		return result;
	}
	
//	@PostMapping("getSales")
//	@ResponseBody
//	public List<EmployeeVO> getSales(@RequestBody EmployeeVO employeeVO) throws Exception{
//		System.out.println(" name =  "+employeeVO.getName());
//		
//		List<EmployeeVO> ar = schService.getSales(employeeVO);
//		
//		
//		//리스트 받아왔고 이거를 패치로 div에 사원번호 뿌려주기 
//		
//		return ar;
//	}
	
	
}
