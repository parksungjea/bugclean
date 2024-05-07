package com.winter.app.inbox;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.winter.app.draft.DraftFileVO;
import com.winter.app.draft.DraftVO;
import com.winter.app.employee.EmployeeService;
import com.winter.app.employee.EmployeeVO;
import com.winter.app.util.pagination.Pagination;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class InboxService {
	@Autowired
	private InboxDAO inboxDAO;

	public Map<String, Object> getAllList(EmployeeVO employeeVO, Pagination pagination) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pager", pagination);
		map.put("vo", employeeVO);
		Long total = inboxDAO.getAllTotalCount(map);
		
		pagination.makeRow();
		pagination.makeNum(total);
		
		List<Map<String, Object>> getAllList = inboxDAO.getAllList(map);
		//System.out.println("get all list >>>" + getAllList);
		for(Map<String, Object> ar: getAllList) {
			ar.put("DRAFT_DATE",( ar.get("DRAFT_DATE")).toString().substring(0,10) );
		}
		
		
		Map<String, Object> togetherMap = new HashMap<>();
		
		togetherMap.put("getAllList", getAllList);
		togetherMap.put("pager", pagination);
		

		return togetherMap;
	}
	public Map<String, Object> getWaitList(EmployeeVO employeeVO, Pagination pagination) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pager", pagination);
		map.put("vo", employeeVO);
		Long total = inboxDAO.getWaitTotalCount(map);
		pagination.makeRow();
		pagination.makeNum(total);
		
		List<Map<String, Object>> getWaitList = inboxDAO.getWaitList(map);
		for(Map<String, Object> ar: getWaitList) {
			ar.put("DRAFT_DATE",( ar.get("DRAFT_DATE")).toString().substring(0,10) );
		}
		
		Map<String, Object> togetherMap = new HashMap<>();
		
		togetherMap.put("getWaitList", getWaitList);
		togetherMap.put("pager", pagination);
		
		return togetherMap;
	}
	public Map<String, Object> getProgressList(EmployeeVO employeeVO, Pagination pagination) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pager", pagination);
		map.put("vo", employeeVO);
		Long total = inboxDAO.getProgressTotalCount(map);
		pagination.makeRow();
		pagination.makeNum(total);
		
		List<Map<String, Object>> getProgressList = inboxDAO.getProgressList(map);
		for(Map<String, Object> ar: getProgressList) {
			ar.put("DRAFT_DATE",( ar.get("DRAFT_DATE")).toString().substring(0,10) );
		}
		
		Map<String, Object> togetherMap = new HashMap<>();
		
		togetherMap.put("getProgressList", getProgressList);
		togetherMap.put("pager", pagination);
		
		return togetherMap;
	}
	public Map<String, Object> getDoneList(EmployeeVO employeeVO, Pagination pagination) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pager", pagination);
		map.put("vo", employeeVO);
		Long total = inboxDAO.getDoneTotalCount(map);
		
		//System.out.println("total==========="+total);
		pagination.makeRow();
		pagination.makeNum(total);
		
		List<Map<String, Object>> getDoneList = inboxDAO.getDoneList(map);
		for(Map<String, Object> ar: getDoneList) {
			ar.put("DRAFT_DATE",( ar.get("DRAFT_DATE")).toString().substring(0,10) );
		}
		
		Map<String, Object> togetherMap = new HashMap<>();
		
		togetherMap.put("getDoneList", getDoneList);
		togetherMap.put("pager", pagination);
		
		return togetherMap;
	}
	public Map<String, Object> getReferList(EmployeeVO employeeVO, Pagination pagination) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pager", pagination);
		map.put("vo", employeeVO);
		Long total = inboxDAO.getReferTotalCount(map);
		pagination.makeRow();
		pagination.makeNum(total);
		
		List<Map<String, Object>> getReferList = inboxDAO.getReferList(map);
		for(Map<String, Object> ar: getReferList) {
			ar.put("DRAFT_DATE",( ar.get("DRAFT_DATE")).toString().substring(0,10) );
		}
		
		Map<String, Object> togetherMap = new HashMap<>();
		
		togetherMap.put("getReferList", getReferList);
		togetherMap.put("pager", pagination);
		
		return togetherMap;
	}
	
}
