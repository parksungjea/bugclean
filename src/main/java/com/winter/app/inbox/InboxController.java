package com.winter.app.inbox;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.winter.app.employee.EmployeeController;
import com.winter.app.employee.EmployeeVO;
import com.winter.app.util.pagination.Pagination;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/receive/*")
@Slf4j
public class InboxController {
	@Autowired
	private InboxService inboxService;
	
	@GetMapping("inbox")
	public String getInbox(Pagination pagination , Model model) throws Exception{
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails= (UserDetails)principal;
		
		EmployeeVO employeeVO = (EmployeeVO)userDetails;
		
		
		Pagination pagination2 = new Pagination();
		pagination2.setKind(pagination.getKind());
		pagination2.setSearch(pagination.getSearch());
		
		Pagination pagination3 = new Pagination();
		pagination3.setKind(pagination.getKind());
		pagination3.setSearch(pagination.getSearch());
		
		Pagination pagination4 = new Pagination();
		pagination4.setKind(pagination.getKind());
		pagination4.setSearch(pagination.getSearch());
		
		Pagination pagination5 = new Pagination();
		pagination5.setKind(pagination.getKind());
		pagination5.setSearch(pagination.getSearch());
		
		
		Map<String, Object> allList = inboxService.getAllList(employeeVO, pagination);
		Map<String, Object> waitList = inboxService.getWaitList(employeeVO, pagination2);
		Map<String, Object> progressList = inboxService.getProgressList(employeeVO, pagination3);
		Map<String, Object> doneList = inboxService.getDoneList(employeeVO, pagination4);
		Map<String, Object> referList = inboxService.getReferList(employeeVO, pagination5);

		model.addAttribute("allList", allList);
		model.addAttribute("waitList", waitList);
		model.addAttribute("progressList", progressList);
		model.addAttribute("doneList", doneList);
		model.addAttribute("referList", referList);
		
		return "employee/inbox";
	}
}
