package com.winter.app.employee;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.mail.Session;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/employee/*")
@Slf4j
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	private int number;
	private String tempPw;
	
	//-----------------------------로그인
	@GetMapping("login")
	public String login(@ModelAttribute EmployeeVO employeeVO, HttpSession session) throws Exception{
		
		//로그인 성공 후 뒤로 가기 시 메인홈 처리
		Object obj = session.getAttribute("SPRING_SECURITY_CONTEXT");
		//System.out.println("======obj :"+obj);
		
		if(obj == null){
			return "employee/login";
		}
		
		SecurityContextImpl contextImpl = (SecurityContextImpl)obj;
		String user = contextImpl.getAuthentication().getPrincipal().toString();
		
		if(user.equals("anonymousUser")) {
			return "member/login";
		}
				
		return "redirect:/";
	}
	
	//----------------------------가입
	@GetMapping("create")
	public void create(@ModelAttribute EmployeeVO employeeVO) throws Exception{
		
	}
	@PostMapping("create")
	public String create(@Validated(EmployeeCreateGroup.class) EmployeeVO employeeVO, BindingResult bindingResult,Model model) throws Exception{
		
		String username= employeeVO.getUsername();
		employeeVO.setUsername(username+"@gmail.com");
		
		boolean check = employeeService.checkEmployee(employeeVO, bindingResult);
		if(check) {
			return "employee/create";
		}
		
		int result = employeeService.create(employeeVO);
		model.addAttribute("result", "employee.create.result");
		model.addAttribute("path","login");

		return "commons/result";
	}
	//이메일 인증
	@PostMapping("mailSend")
	@ResponseBody
	public String mailSend(String email) {

		
		
		number = employeeService.sendMail(email);

        String num = "" + number;


        return num;
        
    }
	// 인증번호 일치여부 확인
    @GetMapping("mailCheck")
    @ResponseBody
    public ResponseEntity<?> mailCheck(@RequestParam String userNumCheck) {
    	//System.out.println("일치확인"+userNumCheck);
        boolean isMatch = userNumCheck.equals(String.valueOf(number));
        
        return ResponseEntity.ok(isMatch);
    }
	

	//----------------------------마이페이지
	@GetMapping("mypage")
	public void mypage(@ModelAttribute EmployeeVO employeeVO, HttpSession session) throws Exception{


	}

	//비밀번호 변경
	@GetMapping("pwUpdate")
	public void pwUpdate(@ModelAttribute EmployeeVO employeeVO) throws Exception{
		
	}
	@PostMapping("pwUpdate")
	public String pwUpdate(@Validated(EmployeePwupdateGroup.class)EmployeeVO employeeVO, BindingResult bindingResult, Model model) throws Exception{
		
		//System.out.println("================:"+employeeVO.getUsername());
		
		boolean check = employeeService.checkPw(employeeVO, bindingResult);
		
		if(check) {
			
			return "employee/pwUpdate";
			
		}
		
		int result = employeeService.pwUpdate(employeeVO);
		model.addAttribute("result","employee.update.success");
		model.addAttribute("path","mypage");
		
		return "commons/result";
	}
	//서명 등록,변경
	@PostMapping("signSave")
	public String signSave(@ModelAttribute EmployeeVO employeeVO,Model model, HttpSession session) throws Exception{

		//db 변경
		int check = employeeService.signSave(employeeVO);
		
		
		//session 변경
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		UserDetails userDetails = (UserDetails)principal;
		
		EmployeeVO emVO=(EmployeeVO)userDetails;
		
		emVO.setSign_file(employeeVO.getSign_file());
		
		model.addAttribute("result", "employee.sign_file.result");
		model.addAttribute("path", "mypage");

		return "commons/result";
		
		
	}

	//개인정보수정
	@PostMapping("infoUpdate")
	public String infoUpdate(@ModelAttribute EmployeeVO employeeVO,Model model) throws Exception{
		 

		
		log.info("{}",employeeVO);
		
		
		//db 변경
		int check = employeeService.infoUpdate(employeeVO);
		
		//session 변경
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails= (UserDetails)principal;
		
		EmployeeVO emVO = (EmployeeVO)userDetails;
		
		emVO.setNickname(employeeVO.getNickname());
		emVO.setPhone(employeeVO.getPhone());
		emVO.setAddress(employeeVO.getAddress());
		
		model.addAttribute("result", "employee.sign_file.result");
		model.addAttribute("path", "mypage");

		return "commons/result";
		
		
	}
	
	//프로필 변경
	@PostMapping("profileUpdate")
	public String profileUpdate(@ModelAttribute EmployeeVO employeeVO, MultipartFile file,Model model) throws Exception{
		
		//db 변경
		int check = employeeService.profileUpdate(employeeVO, file);
		

		model.addAttribute("result", "employee.sign_file.result");
		model.addAttribute("path", "mypage");

		return "commons/result";
		
		
	}
	
	//----------------------------찾기
	@GetMapping("idSearch")
	public void idFind(@ModelAttribute EmployeeVO employeeVO) throws Exception{
		
	}
	@GetMapping("idSearchResult")
	public void idSearchResult() throws Exception{
		
	}
	//폰으로 아이디 찾기
	@PostMapping("idSearchPhone")
	public String idSearchPhone(@Validated(EmployeeIdSearchPhoneGroup.class) EmployeeVO employeeVO, BindingResult bindingResult,Model model) throws Exception{
		
		if(bindingResult.hasErrors()) {
			return "employee/idSearch";
		}
		employeeVO = employeeService.idSearchPhone(employeeVO);
		
		model.addAttribute("employeeVO", employeeVO);
		
		return "employee/idSearchResult";
	}
	//사번으로 아이디 찾기
	@PostMapping("idSearchNum")
	public String idSearchNum(@Validated(EmployeeIdSearchNumGroup.class) EmployeeVO employeeVO, BindingResult bindingResult, Model model) throws Exception{
		
		if(bindingResult.hasErrors()) {
			return "employee/idSearch";
		}
		employeeVO = employeeService.idSearchNum(employeeVO);
		
		model.addAttribute("employeeVO", employeeVO);
		
		return "employee/idSearchResult";
	}

	//===================================비번 찾기
	@GetMapping("pwSearch")
	public void pwFind(@ModelAttribute EmployeeVO employeeVO) throws Exception{
		
	}

	//문자 임시번호
	@PostMapping("pwSearchPhone")
	public String pwSearchPhone(@Validated(EmployeePwSearchPhoneGroup.class) EmployeeVO employeeVO, BindingResult bindingResult, Model model) throws Exception{
		
		if(bindingResult.hasErrors()) {
			return "employee/pwSearch";
		}
		
		employeeVO = employeeService.getUserPhoneCheck(employeeVO);
		
		//정보 없을 시
		if(employeeVO == null) {
			model.addAttribute("result", "info.search.fail");
			model.addAttribute("path", "pwSearch");

			return "commons/result";
		}
		//정보 일치 시 임시비번 문자 전송
		tempPw = employeeService.sendPhone(employeeVO.getPhone());


		//임시비번으로 비밀번호 변경
		int result = employeeService.tempPwUpdate(employeeVO);
		
		//System.out.println("비번변경 성공?> "+result);
		
		model.addAttribute("result", "tempPw.send.success");
		model.addAttribute("path", "login");

		return "commons/result";
	}

	//이메일 임시번호
	@PostMapping("pwSearchEmail")
	public String pwSearchEmail(@Validated(EmployeePwSearchEmailGroup.class) EmployeeVO employeeVO, BindingResult bindingResult, Model model) throws Exception{
			
		if(bindingResult.hasErrors()) {
			return "employee/pwSearch";
		}
		
		employeeVO.setUsername(employeeVO.getUsername()+"@gmail.com");
		//System.out.println("employeeVO 확인: "+employeeVO.getEmployee_num()+employeeVO.getName()+employeeVO.getUsername());
		employeeVO = employeeService.getUserEmailCheck(employeeVO);
		
		//정보 없을 시
		if(employeeVO == null) {
			model.addAttribute("result", "info.search.fail");
			model.addAttribute("path", "pwSearch");

			return "commons/result";
		}
		
		//정보 일치 시 임시비번 이메일 전송
		tempPw = employeeService.sendPwMail(employeeVO.getUsername());

		//System.out.println("임시비번 : "+tempPw);
		
		//임시비번으로 비밀번호 변경
		int result = employeeService.tempPwUpdate(employeeVO);
		
		//System.out.println("비번변경 성공?> "+result);
		model.addAttribute("result", "tempPw.send.success");
		model.addAttribute("path", "login");

		return "commons/result";
		
		
	}
	
	
	
	
	
	
}
