package com.winter.app.employee;

import java.security.SecureRandom;
import java.util.HashMap;

import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

import com.winter.app.util.commons.FileManager;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)//유저의 정보를 가져오는 인터페이스
@RequiredArgsConstructor
public class EmployeeService implements UserDetailsService{

	@Autowired
	private EmployeeDAO employeeDAO;
	@Autowired
	private FileManager fileManager;
	@Value("${app.upload.profile}")
	private String uploadPath;
	@Value("${coolsms.api.key}")
    private String apiKey;
    @Value("${coolsms.api.secret}")
    private String apiSecretKey;
	@Value("${coolsms.dev.fromnumber}")
	private String fromNumber;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender javaMailSender;
	private static final String senderEmail= "arark057@gmail.com";
    private static int number;
    private static String tempPw;

    //--------------------가입
	//아이디 중복, 비번 일치 여부
	public boolean checkEmployee(EmployeeVO employeeVO, BindingResult bindingResult) throws Exception{
		//check true -> 에러
		boolean check = false;
		
		check = bindingResult.hasErrors();
		
		//아이디 검증
		EmployeeVO result = employeeDAO.getDetail(employeeVO);
		
		if(result != null) {
			
			check=true;
			bindingResult.rejectValue("username", "employeeVO.username.equals");
		}
		//이미신청된 아이디 일 시
		EmployeeVO result2 = employeeDAO.getAlreadyCheck(employeeVO);
		if(result2 != null) {
			
			check=true;
			bindingResult.rejectValue("username", "employeeVO.username.already");
		}
		
		//비밀번호 검증
		if(!employeeVO.getPassword().equals(employeeVO.getPasswordCheck())) {
			check=true;
			bindingResult.rejectValue("passwordCheck", "employeeVO.password.equals");
			
		}
		
		//인증번호 검증
		if(employeeVO.getUserNumCheck().equals("")) {
			check=true;
			return check;
		}else if(!employeeVO.getUserNumCheck().equals(""+number)) {
			
			check=true;
			bindingResult.rejectValue("userNumCheck", "employeeVO.userNumCheck.equals");
		}
		
		
		return check;
	}
	//======================메일
	//인증메일
    public static void createNumber() {
        number = (int)(Math.random() * (90000)) + 100000;
    }

    public MimeMessage CreateMail(String mail) {
        createNumber();
        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO, mail);
            message.setSubject("이메일 인증");
            String body = "";
            body += "<h3>" + "[BugClean] 요청하신 인증 번호입니다." + "</h3>";
            body += "<h1 style='color:green'>" + number + "</h1>";
            body += "<h3>" + "위의 인증코드를 입력하여 주세요. 감사합니다." + "</h3>";
            message.setText(body,"UTF-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return message;
    }
    public int sendMail(String mail) {
        MimeMessage message = CreateMail(mail);
        javaMailSender.send(message);

        return number;
    }
    //임시비번 이메일 전송
    private static final char[] rndAllCharacters = new char[]{
            //number
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            //uppercase
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
            'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
            //lowercase
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
            'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
            //special symbols
            '@', '$', '!', '%', '*', '?', '&'
    };
    public void getRandomPassword(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder stringBuilder = new StringBuilder();

        int rndAllCharactersLength = rndAllCharacters.length;
        for (int i = 0; i < length; i++) {
            stringBuilder.append(rndAllCharacters[random.nextInt(rndAllCharactersLength)]);
        }

        tempPw = stringBuilder.toString();
    }
    public MimeMessage CreatPwMail(String mail) {
    	getRandomPassword(10);
		MimeMessage message = javaMailSender.createMimeMessage();

        try {
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO, mail);
            message.setSubject("이메일 인증");
            String body = "";
            body += "<h3>" + "[BugClean] 요청하신 임시비밀번호 입니다." + "</h3>";
            body += "<h1 style='color:green'>" + tempPw + "</h1>";
            body += "<h3>" + "로그인 후 비밀번호 변경을 해주세요. 감사합니다." + "</h3>";
            message.setText(body,"UTF-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return message;
    }
  	public String sendPwMail(String mail) {
  		MimeMessage message = CreatPwMail(mail);
  		javaMailSender.send(message);
  		
  		return tempPw;
  	}
  	
  	
  	
  	
    //사원등록
    public int create(EmployeeVO employeeVO) throws Exception{
    	
    	//비번 암호화
    	employeeVO.setPassword(passwordEncoder.encode(employeeVO.getPassword()));
    	int result = employeeDAO.create(employeeVO);
    	
    	return result;
    }
    
    //--------------------개인정보수정
    //비번 일치 여부
    public boolean checkPw(EmployeeVO employeeVO, BindingResult bindingResult) throws Exception{
    	boolean check= false;
    	
    	check = bindingResult.hasErrors();
    	
    	//현재비번 일치
    	EmployeeVO current = employeeDAO.getDetail(employeeVO);
    	
    	//passwordEncoder.matches(employeeVO.getPassword(),current.getPassword())
    	if(!passwordEncoder.matches(employeeVO.getPassword(),current.getPassword())) {
    		check=true;
    		bindingResult.rejectValue("password", "employeeVO.password.update");
    	}
    	//새비번 일치
    	if(!employeeVO.getPasswordCheck().equals(employeeVO.getNewPassword())) {
    		check=true;
    		bindingResult.rejectValue("newPassword", "employeeVO.newPassword.update");
    	}
    	
    	return check;
    }
    
    //비번변경
    public int pwUpdate(EmployeeVO employeeVO) {
    	
    	employeeVO.setPassword(passwordEncoder.encode(employeeVO.getNewPassword()));
    	int result = employeeDAO.pwUpdate(employeeVO);
    	
    	return result;
    }
    
    //서명변경
    public int signSave(EmployeeVO employeeVO) {
    	int result = employeeDAO.signSave(employeeVO);
    	
		return result;
	}
    //개인정보변경
    public int infoUpdate(EmployeeVO employeeVO) {
    	int result = employeeDAO.infoUpdate(employeeVO);
    	
		return result;
	}
    
    //프로필변경
    public int profileUpdate(EmployeeVO employeeVO, MultipartFile file) throws Exception {
    	
    	
    	int result=0;
    	//session 변경
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails= (UserDetails)principal;
		EmployeeVO emVO = (EmployeeVO)userDetails;
    
		if(file.isEmpty()) {
			employeeVO.setProfile(null);
			employeeVO.setProfile_name(null);
			
			emVO.setProfile(null);
			emVO.setProfile_name(null);
			
			result = employeeDAO.profileUpdate(employeeVO);
			
			return result;
		}
		
		String fileName = fileManager.fileSave(uploadPath, file,false);

		employeeVO.setProfile(fileName);
		employeeVO.setProfile_name(file.getOriginalFilename());
		
		
		emVO.setProfile(employeeVO.getProfile());
		emVO.setProfile_name(employeeVO.getProfile_name());
		
		result = employeeDAO.profileUpdate(employeeVO);

		return result;
	}
    
    
    //--------------------찾기
    //폰으로 아이디 찾기
    public EmployeeVO idSearchPhone(EmployeeVO employeeVO) throws Exception{
    	employeeVO = employeeDAO.idSearchPhone(employeeVO);
    	
		return employeeVO;
	}
    
    
    //사번으로 아이디 찾기
    public EmployeeVO idSearchNum(EmployeeVO employeeVO) throws Exception{
		
    	employeeVO = employeeDAO.idSearchNum(employeeVO);
    	
		return employeeVO;
	}
    
    //받은 정보로 회원있는지 체크(email)
    public EmployeeVO getUserEmailCheck(EmployeeVO employeeVO) {
    	employeeVO = employeeDAO.getUserEmailCheck(employeeVO);
    	
    	return employeeVO;
	}
    
    //임시비번으로 변경
    public int tempPwUpdate(EmployeeVO employeeVO) {
    	
    	employeeVO.setPassword(passwordEncoder.encode(tempPw));
    	int result = employeeDAO.pwUpdate(employeeVO);
    	
    	return result;
    }
    //받은 정보로 회원있는지 체크(phone)
    public EmployeeVO getUserPhoneCheck(EmployeeVO employeeVO) {
		employeeVO = employeeDAO.getUserPhoneCheck(employeeVO);
    	
    	return employeeVO;
	}
    //문자보내기
    public String sendPhone(String phone) throws Exception{
    	
    	getRandomPassword(10);
    	
    	phone = phone.replaceAll("-", "");

		Message coolsms = new Message(apiKey, apiSecretKey);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phone); //수신 번호
		params.put("from", fromNumber); //발신번호
		params.put("type", "SMS");  // 문자 타입
		params.put("text", "[BugClean] 임시비밀번호 : "+tempPw+" 입니다.");
		params.put("app_version", "test app 1.2"); // application name and version
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params); //보내기&전송결과받기
		} catch (CoolsmsException e) {
			System.out.println("getMessage : "+e.getMessage());
			System.out.println("getCode : "+e.getCode());
		}
    	
    	
		return tempPw;
	}
    //UserDetailService
    @Override			//유저의 정보를 불러와서 UserDetails로 리턴
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	EmployeeVO employeeVO = new EmployeeVO();
    	employeeVO.setUsername(username);

    	try {
			employeeVO= employeeDAO.getDetail(employeeVO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return employeeVO;
    }

}
