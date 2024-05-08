package com.winter.app.draft;

import java.awt.Dialog.ModalExclusionType;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.winter.app.board.BoardFileVO;
import com.winter.app.employee.DepartmentVO;
import com.winter.app.employee.EmployeeVO;
import com.winter.app.employee.PositionVO;
import com.winter.app.employee.RnRVO;
import com.winter.app.util.pagination.Pagination;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/draft/*")
public class DraftController {
	@Autowired
	private DraftService draftService;
	
	
	
	@GetMapping("basisdraft")
	public String getBasisDraft(Map<String, Object> map, Model model, HttpSession session, MultipartFile [] attach)
			throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;

		Map<String, Object> empMap = draftService.getEmployeeDetail(employeeVO);
		model.addAttribute("empMap", empMap);

		List<Map<String, Object>> ar = draftService.getBasisDraft();
		model.addAttribute("list", ar);

		List<DepartmentVO> depar = draftService.getDepartmentList();
		model.addAttribute("dep", depar);

		DraftVO draftVO = draftService.getDraftDocNum();
		model.addAttribute("draftVO", draftVO);

		List<DepartmentVO> depHighAr = draftService.getDepartmentHighList();
		model.addAttribute("depHighAr", depHighAr);

//		 employeeVO = draftService.getCEO();
//		 model.addAttribute("CEO", employeeVO);

		APListVO apListVO = new APListVO();
		apListVO.setEmployee_num(employeeVO.getEmployee_num());
		List<APListVO> allist = draftService.getAPList(apListVO);
		model.addAttribute("allist", allist);

		return "draft/basisdraft";
	}
	
	@GetMapping("getdraftdetail")
	public String getDraftDetail(Model model, DraftVO draftVO)throws Exception{
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		
		model.addAttribute("employeeNum", employeeVO.getEmployee_num());
		

		//기안서 부분
		draftVO.setEmployee_num(employeeVO.getEmployee_num());
		Map<String, Object> map = draftService.getDraftDetail(draftVO);
		model.addAttribute("draftmap", map);

		//기안서 결재라인부분
		List<Map<String, Object>> approvalAr = draftService.getSignCheckDetail(draftVO);
		model.addAttribute("approvalar", approvalAr);
		int ddd=0;
		if(map.get("NOW_APPROVAL") == null) {
		}else {
			ddd =  Integer.parseInt(map.get("NOW_APPROVAL").toString());			
		}

		
		if(ddd >= approvalAr.size()) {
			String nowemp = approvalAr.get(approvalAr.size()-1).get("EMPLOYEE_NUM").toString();
			nowemp +=1;
			model.addAttribute("nowemp", nowemp);			
		}else {
				String nowemp = approvalAr.get(ddd).get("EMPLOYEE_NUM").toString();
				model.addAttribute("nowemp", nowemp);			
		}
		//기안서 참조 부분
		String name = draftService.getRefDetail(draftVO);
		model.addAttribute("refname", name);
		//기안서 파일 부분
		List<DraftFileVO> fileAr = draftService.getDraftFileDetail(draftVO);
		model.addAttribute("filear", fileAr);
		//조직도리스트
		List<Map<String, Object>> ar = draftService.getBasisDraft();
		model.addAttribute("list", ar);

		List<DepartmentVO> depar = draftService.getDepartmentList();
		model.addAttribute("dep", depar);
		//기안자 
		Map<String, Object> empMap = draftService.getEmployeeDetail(employeeVO);
		model.addAttribute("empMap", empMap);
		
		return "draft/draftdetail";
	}
	
	@PostMapping("draftdelete")
	public int draftDelete(DraftVO draftVO) throws Exception{
		System.out.println("deleteDraftNum : "+ draftVO.getDraft_num());
		int result = draftService.draftDelete(draftVO);
		return result;
	}
	
	////////////////////////////////////////////////
	
	@PostMapping("setdetaildraft")
	public String setDetailDraft(DraftVO draftVO, MultipartFile [] attach, Model model, String [] SignEmp, String nowemp) throws Exception {

		//현재 기안서의 결재 라인 불러오기
		List<Map<String, Object>> approvalAr = draftService.getSignCheckDetail(draftVO);
		//
		if(draftVO.getDraft_category() == 0) {
		String msg="실패";
		// 기안서 값들 db에 저장
		draftService.updateSignCheckDetail(approvalAr, draftVO,nowemp);
		int result = draftService.setDetailDraft(draftVO,approvalAr);
		if(result>0) {
			msg="성공";
		}

		model.addAttribute("result", msg);
		model.addAttribute("path", "/receive/inbox");
		}else if(draftVO.getDraft_category() == 1) {
			
		}else if(draftVO.getDraft_category() == 2) {
			
		}
		return "commons/result";
	}

	@PostMapping("setbasisdraft")
	public String setBasisDraft(DraftVO draftVO, MultipartFile [] attach, Model model, String[] refempnum,
			String[] approvalemp_num, Long[] sign_rank) throws Exception {
		
		
		
		if(draftVO.getDraft_category() == 0) {
		int result=0;
		String msg="실패";
		// 기안서 값들 db에 저장
		result = draftService.setBasisDraft(draftVO);
		// 결재라인 db에 저장
		draftService.setSignCheck(approvalemp_num, sign_rank, draftVO);
		//참조값을 db에 저장
		draftService.setRef(draftVO, refempnum);
		//파일첨부
		draftService.setDraftFile(attach, draftVO);
		
		
		if(result>0) {
			msg="성공";
		}
		
		model.addAttribute("result", msg);
		model.addAttribute("path", "/draft/mydraftlist");			
			
		}else if(draftVO.getDraft_category() == 1) {
			
		}else if(draftVO.getDraft_category() == 2) {
			
		}
		
		
		return "commons/result";
	}

	@PostMapping("getapprovalline")
	public String getApprovalLine(String[] dep, String[] name, String[] orgCode, String[] refCode,
			Map<String, Object> map, Model model, HttpSession session) throws Exception {

//		model.addAttribute("aplvdep", dep);
//		model.addAttribute("aplvname", name);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		Map<String, Object> empMap = draftService.getEmployeeDetail(employeeVO);
		model.addAttribute("empMap", empMap);

		List<Map<String, Object>> ar = draftService.getBasisDraft();
		model.addAttribute("list", ar);

		List<DepartmentVO> depar = draftService.getDepartmentList();
		model.addAttribute("dep", depar);

		DraftVO draftVO = draftService.getDraftDocNum();
		model.addAttribute("draftVO", draftVO);

		List<DepartmentVO> depHighAr = draftService.getDepartmentHighList();
		model.addAttribute("depHighAr", depHighAr);

//		 employeeVO = draftService.getCEO();
//		 model.addAttribute("CEO", employeeVO);		 

		List<Map<String, Object>> ALar = draftService.setApprovalLine(orgCode, empMap);
		model.addAttribute("approvalMap", ALar);
		APListVO apListVO = new APListVO();
		apListVO.setEmployee_num(employeeVO.getEmployee_num());
		List<APListVO> allist = draftService.getAPList(apListVO);
		model.addAttribute("allist", allist);

		return "ajax/approvalline";
	}

	// 즐겨찾기에 저장 버튼을 눌렀을때 실행하는 메서드
	// (approval_line테이블에 값 넣어놓고 al_Line테이블에 값 넣어놓고 넣어둔 값 다시 꺼내오는 역할)
	@PostMapping("getaplist")
	public String getAPList(String[] empCode, String lineName, Model model) throws Exception {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;

		Map<String, Object> empMap = draftService.getEmployeeDetail(employeeVO);
		model.addAttribute("empMap", empMap);
		List<Map<String, Object>> ar = draftService.getBasisDraft();
		model.addAttribute("list", ar);

		List<DepartmentVO> depar = draftService.getDepartmentList();
		model.addAttribute("dep", depar);

		DraftVO draftVO = draftService.getDraftDocNum();
		model.addAttribute("draftVO", draftVO);

///////////////////////////////////////////////////////////////////////////////////////////
//		 for(int i=0; i<empCode.length;i++) {
//			System.out.println("empCode : "+empCode[i]); 
//		 }

		// approval_line테이블에 값 넣기
		List<Map<String, Object>> ALar = draftService.setApprovalLine(empCode, empMap);

		APListVO apListVO = new APListVO();
		Long approval_line_code = Long.parseLong(ALar.get(0).get("APPROVAL_LINE_CODE").toString());
		apListVO.setApproval_line_code(approval_line_code);

		String employee_num = ALar.get(0).get("EMPLOYEE_NUM").toString();
		apListVO.setEmployee_num(employee_num);
		apListVO.setLine_name(lineName);

		List<APListVO> apar = draftService.setAPList(apListVO);
		model.addAttribute("allist", apar);

		return "ajax/allist";

	}

	// 즐겨찾기 이름 누를때마다 값 적용해주는 메서드
	@PostMapping("getaldetail")
	@ResponseBody
	public List<ApprovalLineVO> getALDetail(ApprovalLineVO approvalLineVO) throws Exception {
		List<ApprovalLineVO> ar = draftService.getALDetail(approvalLineVO);

		return ar;

	}

	@GetMapping("draftLine")
	public void getDraftLine() throws Exception {

	}

	@GetMapping("draftlist")
	public void getDraftList() throws Exception {

	}

	@GetMapping("mydraftlist")
	public String getMyDraftList(Pagination pagination, Model model) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		
		List<Map<String, Object>> mapAr = draftService.getMyDraftList(pagination ,employeeVO);
		if(mapAr == null) {
			pagination = (Pagination)mapAr.get(0).get("Pagination");	
		}
		model.addAttribute("pager", pagination);
		model.addAttribute("list",mapAr);
		
		return "draft/mydraftlist";
	}

	@GetMapping("myrejectiondraftlist")
	public void getMyReJectionList(Pagination pagination, Model model) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		
		List<Map<String, Object>> mapAr = draftService.getMyReJectionList(pagination ,employeeVO);
		if(mapAr == null) {
			pagination = (Pagination)mapAr.get(0).get("Pagination");	
		}
		model.addAttribute("pager", pagination);
		model.addAttribute("list",mapAr);
	}

	@GetMapping("myapprovinglist")
	public void getMyApprovingList(Pagination pagination, Model model) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		
		List<Map<String, Object>> mapAr = draftService.getMyApprovaingList(pagination ,employeeVO);
		if(mapAr == null) {
			pagination = (Pagination)mapAr.get(0).get("Pagination");	
		}
		model.addAttribute("pager", pagination);
		model.addAttribute("list",mapAr);
	}

	@GetMapping("myapprovedlist")
	public void getMyApprovedList(Pagination pagination, Model model) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		
		List<Map<String, Object>> mapAr = draftService.getMyApprovedList(pagination ,employeeVO);
		if(mapAr == null) {
			pagination = (Pagination)mapAr.get(0).get("Pagination");	
		}
		model.addAttribute("pager", pagination);
		model.addAttribute("list",mapAr);
	}

	@GetMapping("mytemporarylist")
	public void getMyTemporaryList(Pagination pagination, Model model) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		EmployeeVO employeeVO = (EmployeeVO) userDetails;
		
		List<Map<String, Object>> mapAr = draftService.getMyTemporaryList(pagination ,employeeVO);
		if(mapAr == null) {
			pagination = (Pagination)mapAr.get(0).get("Pagination");	
		}
		model.addAttribute("pager", pagination);
		model.addAttribute("list",mapAr);
	}

}
