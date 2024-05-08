package com.winter.app;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.winter.app.board.BoardCateVO;
import com.winter.app.board.BoardService;
import com.winter.app.board.BoardVO;
import com.winter.app.employee.EmployeeVO;
import com.winter.app.general.CarManageVO;
import com.winter.app.humanResource.AttendanceVO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/")
@Slf4j
public class HomeController {
	
	@Autowired
	HomeService homeService;
    @Autowired
    BoardService boardService;

    @GetMapping("")
    public String SidebarInit(AttendanceVO attendanceVO, HttpSession session, Model model) throws Exception{
    	
    	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		EmployeeVO employeeVO=(EmployeeVO)userDetails;
		//System.out.println("employeeVO : "+employeeVO.getEmployee_num());
		
    	attendanceVO.setEmployee_num(employeeVO.getEmployee_num());
        
    	
    	//공지
    	List<BoardVO> boardVO = homeService.getList();
    	model.addAttribute("boardVO",boardVO);
    	//근태기록
    	attendanceVO = homeService.getAttendTime(attendanceVO);
    	model.addAttribute("attendanceVO",attendanceVO);
    	
    	//사이드바 게시판 항목
    	List<BoardCateVO> ar = boardService.getCateList();

        List<String> codes = new ArrayList<>();
        List<String> names = new ArrayList<>();
        for(BoardCateVO cate : ar){
            codes.add(cate.getCate_code().toString());
            names.add(cate.getCate_name());
        }

        session.setAttribute("code",codes);
        session.setAttribute("name",names);
        
        
        return "index";
    }
    
    //근태
    @Scheduled(cron = "0 0 0 * * *")
  	public void setAttendDate() throws Exception {
  		homeService.setAttendDate();
  	}
    
    @PostMapping("setAttendence")
	private String setAttendence(AttendanceVO attendanceVO, Model model) throws Exception {
		
    	//출근 여부
    	boolean isAttended = homeService.isAttended(attendanceVO);
    	
    	if(isAttended) {
    		model.addAttribute("result","attendence.update.already");
			model.addAttribute("path","/");
    	}else {		
    		int result = homeService.setAttendence(attendanceVO);
    		if(result==1){
    			model.addAttribute("result","attendence.update.success");
    			model.addAttribute("path","/");
    		}else {
    			model.addAttribute("result","attendence.update.fail");
    			model.addAttribute("path","/");
    		}
		}
		return "commons/result";
	}
    @PostMapping("setWorkOut")
	private String setWorkOut(AttendanceVO attendanceVO, Model model) throws Exception {
    	
    	boolean isAttended = homeService.isAttended(attendanceVO);
    	boolean isWorkOut = homeService.isWorkOut(attendanceVO);
    	
    	if(isWorkOut) {
    		model.addAttribute("result","attendence.update.already");
			model.addAttribute("path","/");
    	}else if(!isAttended) {
    		model.addAttribute("result","workOut.update.fail");
			model.addAttribute("path","/");
    	}else {		
    		int result = homeService.setWorkOut(attendanceVO);
    		if(result==1){
    			model.addAttribute("result","workOut.update.success");
        		model.addAttribute("path","/");
    		}else {
    			model.addAttribute("result","attendence.update.fail");
    			model.addAttribute("path","/");
    		}
		}
    	
    	return "commons/result";
	}
    
    //사번조회
    @PostMapping("getnameAsk")
    @ResponseBody
    public String getnameAsk(@RequestBody EmployeeVO employeeVO) throws Exception {
    	
    	//System.out.println("employeeVO!!!!"+employeeVO);
    	employeeVO = homeService.getnameAsk(employeeVO);
    	return employeeVO.getName();
    }
    
   //차량 조회
    @PostMapping("getCarAsk")
    @ResponseBody
    public Map<String, Object> getCarAsk(@RequestBody CarManageVO carManageVO, Model model) throws Exception {
    	
    	Map<String, Object> map = homeService.getCarAsk(carManageVO);
    	
    	model.addAttribute("map",map);
    	return map;
    }
    
    

    
}
