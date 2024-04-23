package com.winter.app.customer;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.winter.app.employee.EmployeeVO;

@Mapper
public interface CustomerDAO {

	List<CustomerVO> getCompanyList() throws Exception;
	List<CustomerVO> getPersonList() throws Exception;
	
	EmployeeVO getEmployeeName(CustomerVO customerVO) throws Exception;
	
	
	CustomerVO getDetail(CustomerVO customerVO) throws Exception;
	
	int createCustomer(CustomerVO customerVO) throws Exception;
	
	int updateCustomer(CustomerVO customerVO) throws Exception;
	
	int deleteCustomer(CustomerVO customerVO) throws Exception;
	
}
