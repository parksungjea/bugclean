package com.winter.app.customer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.winter.app.chat.ChatDAO;
import com.winter.app.employee.EmployeeVO;
import com.winter.app.sitesch.SiteSchDAO;
import com.winter.app.util.pagination.Pagination;

@Service
public class CustomerService {

	@Autowired
	CustomerDAO customerDAO;
	@Autowired
	ChatDAO chatDAO;
	@Autowired
	SiteSchDAO schDAO;
	
	public List<EmployeeVO> getSales() throws Exception{
		
		return schDAO.getSales();
	}
	
	public Map<String,Object> getEmpName() throws Exception{
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setUsername(userDetails.getUsername());
		Map<String,Object> map = chatDAO.getEmpName(employeeVO);
		return map;
	}
	
	public Map<String, Object> getCompanyList(Pagination pagination) throws Exception{
		
		
		Long totalCount = customerDAO.getCompanyTotalCount(pagination);
		pagination.setPerPage(5L);
		pagination.makeNum(totalCount);
		pagination.makeRow();
		List<CustomerVO> ar = customerDAO.getCompanyList(pagination);
		
		for(int i=0;i<ar.size();i++) {
			EmployeeVO employeeVO = new EmployeeVO();
			employeeVO = customerDAO.getEmployeeName(ar.get(i));
			ar.get(i).setEmployee_Name(employeeVO.getName());
			
		}
		Map<String, Object> companyMap = new HashMap<>();
		companyMap.put("ar", ar);
		companyMap.put("company_pager", pagination);
		return companyMap;
	}
	
	public Map<String, Object> getPersonList(Pagination pagination) throws Exception{
		Long totalCount = customerDAO.getPersonTotalCount(pagination);
		pagination.setPerPage(5L);
		pagination.makeNum(totalCount);
		pagination.makeRow();
		
		List<CustomerVO> ar = customerDAO.getPersonList(pagination);
		
		for(int i=0;i<ar.size();i++) {
			
			EmployeeVO employeeVO = new EmployeeVO();
			employeeVO = customerDAO.getEmployeeName(ar.get(i));
			ar.get(i).setEmployee_Name(employeeVO.getName());
			
		}
		Map<String, Object> personMap = new HashMap<>();
		personMap.put("ar", ar);
		personMap.put("person_pager", pagination);

		
		return personMap;
	}
	
	public CustomerVO getDetail(CustomerVO customerVO) throws Exception{
		customerVO = customerDAO.getDetail(customerVO);
		EmployeeVO employeeVO = customerDAO.getEmployeeName(customerVO);
		customerVO.setEmployee_Name(employeeVO.getName());
		
		return customerVO;
	}
	
	public int createCustomer(CustomerVO customerVO) throws Exception{

		if(customerVO.getCustomer_Type().equals("개인")) { 
			customerVO.setBusiness_Name("개인");
			
		}

		return customerDAO.createCustomer(customerVO);
	}

	public int updateCustomer( CustomerVO customerVO) throws Exception{
		return customerDAO.updateCustomer(customerVO);
	}
	
	public int deleteCustomer(CustomerVO customerVO) throws Exception{
		return customerDAO.deleteCustomer(customerVO);
	}
	
}
