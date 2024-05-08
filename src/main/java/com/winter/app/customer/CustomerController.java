package com.winter.app.customer;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.winter.app.employee.EmployeeVO;
import com.winter.app.util.pagination.Pagination;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/customer/*")
@Slf4j
public class CustomerController {

		
	@Autowired
	CustomerService customerService;
	
	
	
	@GetMapping({"list","sales_list"})
	public String getList(Pagination pagination,Model model) throws Exception{
		/*
		 * Map<String,Object> personMap = new HashMap<>(); personMap=
		 * customerService.getPersonList(pagination);
		 */
		Map<String, Object> personMap = new HashMap<>(customerService.getPersonList(pagination));
	    model.addAttribute("personMap", personMap);
		Map<String, Object> map = customerService.getEmpName();
	    model.addAttribute("info",map);
	    Pagination pagination2 = new Pagination();
	    pagination2.setKind( pagination.getKind());
	    pagination2.setSearch(pagination.getSearch()) ;
	    pagination2.setPage(pagination.getPage());
	    
		/*
		 * Map<String,Object> companyMap = new HashMap<>(); companyMap =
		 * customerService.getCompanyList(pagination);
		 */
		Map<String, Object> companyMap = new HashMap<>(customerService.getCompanyList(pagination2));
	    model.addAttribute("companyList", companyMap);
		
		/*
		 * System.out.println("company map ==> " + companyMap);
		 * System.out.println("company pager==>"+companyMap.get("pager") );
		 * System.out.println("person map ==> " + personMap);
		 */
		
		List<EmployeeVO> ar = customerService.getSales();
		model.addAttribute("sales_List", ar);
		return "customer/list";
	}
	
	@GetMapping("create")
	public void createCustomer(Model model) throws Exception{
		List<EmployeeVO> ar = customerService.getSales();
		
		model.addAttribute("list", ar);
		
	}
	@PostMapping("/create")
	public String createCustomer(CustomerVO customerVO) throws Exception{

		customerService.createCustomer(customerVO);
		
		return "redirect:/customer/sales_list";
	}
	
	@PostMapping("update")
	@ResponseBody
	public int updateCustomer(@RequestBody CustomerVO customerVO,Model model) throws Exception{
		
			int result = customerService.updateCustomer(customerVO);
			model.addAttribute("result", result);
			
		return result;
	}
	
	@GetMapping("detail")
	public void getDetail(CustomerVO customerVO,Model model) throws Exception{
		
		
		CustomerVO vo = customerService.getDetail(customerVO);
		
		model.addAttribute("vo", vo);
		
	}
	
	@GetMapping("delete")
	public String deleteCustomer(CustomerVO customerVO) throws Exception{

			customerService.deleteCustomer(customerVO);
		
		return "redirect:/customer/sales_list";
	}
	
	
}
