package com.winter.app.employee;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data					//사용자의 정보를 담는 Interface
public class EmployeeVO implements UserDetails{
	@NotBlank(message = "사번을 입력해 주세요.", groups = {EmployeeIdSearchNumGroup.class, EmployeePwSearchEmailGroup.class})
	private String employee_num;
	private DepartmentVO departmentVO;
	private PositionVO positionVO;
	private RnRVO rnrVO;
	private WorkTypeVO workTypeVO;
	@NotBlank(message = "아이디는 필수 입력 값입니다.", groups = {EmployeeCreateGroup.class, EmployeePwSearchPhoneGroup.class, EmployeePwSearchEmailGroup.class})
	private String username;
	@NotBlank(message = "인증번호를 입력해 주세요.", groups = EmployeeCreateGroup.class)
	private String userNumCheck;
	
	@NotBlank(message = "비밀번호는 필수 입력 값입니다.", groups = {EmployeeCreateGroup.class, EmployeePwupdateGroup.class})
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "비밀번호는 8~16자 영문자, 숫자, 특수문자를 사용하세요.", groups = EmployeeCreateGroup.class)
	private String password;
	@NotBlank(message = "비밀번호를 입력해 주세요.", groups = {EmployeeCreateGroup.class, EmployeePwupdateGroup.class})
	private String passwordCheck;
	@NotBlank(message = "새 비밀번호는 필수 입력 값입니다.", groups = EmployeePwupdateGroup.class)
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}", message = "비밀번호는 8~16자 영문자, 숫자, 특수문자를 사용하세요.", groups = EmployeePwupdateGroup.class)
	private String newPassword;
	
	
	@NotBlank(message = "이름을 입력해 주세요.", groups = {EmployeeCreateGroup.class, EmployeeIdSearchNumGroup.class, EmployeeIdSearchPhoneGroup.class,EmployeePwSearchPhoneGroup.class, EmployeePwSearchEmailGroup.class})
	private String name;
	@NotBlank(message = "전화번호를 입력해 주세요.", groups = {EmployeeCreateGroup.class, EmployeeIdSearchPhoneGroup.class, EmployeePwSearchPhoneGroup.class})
	@Pattern(regexp = "^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})+$", message = "", groups = EmployeeCreateGroup.class)
	private String phone;
	@NotBlank(message = "주소를 입력해 주세요.", groups = EmployeeCreateGroup.class)
	private String address;
	@Pattern(regexp = "^[ㄱ-ㅎ가-힣a-z0-9-_]{2,10}$", message = "닉네임은 특수문자를 제외한 2~10자리여야 합니다.")
	private String nickname;
	private Date join_date;
	private Date retired_date;
	private Long level_date;
	private String state;
	private String sign_file;
	private String profile;
	private String profile_name;
	private String manager_num;
	
//	private boolean accountNonExpired;
//	private boolean accountNonLocked;
//	private boolean credentialsNonExpired;
//	private boolean enabled;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		//사용자 권한을 Security에서 사용 할 수 있도록 변환
		List<GrantedAuthority> authorities = new ArrayList<>();
		
		//log.info("=== depart :  {}", departmentVO);
		
//		GrantedAuthority ga1 = new SimpleGrantedAuthority(state);
//		GrantedAuthority ga2 = new SimpleGrantedAuthority(departmentVO.getDep_name());
//		GrantedAuthority ga3 = new SimpleGrantedAuthority(positionVO.getPos_name());
//		GrantedAuthority ga4 = new SimpleGrantedAuthority(rnRVO.getRnr_name());
		
		authorities.add(new SimpleGrantedAuthority(state));
		if(departmentVO != null) {
//			authorities.add(new SimpleGrantedAuthority(departmentVO.getDep_name()));
			authorities.add(new SimpleGrantedAuthority(departmentVO.getDep_role()));
		}
		if(positionVO != null){
//			authorities.add(new SimpleGrantedAuthority(positionVO.getPos_name()));
			authorities.add(new SimpleGrantedAuthority(positionVO.getPos_role()));
		}
		if(rnrVO != null){
//			authorities.add(new SimpleGrantedAuthority(rnrVO.getRnr_name()));
			authorities.add(new SimpleGrantedAuthority(rnrVO.getRnr_role()));
		}
		
		
		System.out.println("권한!: "+departmentVO.getDep_role()+positionVO.getPos_role()+rnrVO.getRnr_role());
		log.info("=== ROLE :  {}", authorities); //[1, 총무팀, 과장, 팀장]
		return authorities;
	}
	@Override // 계정의 만료 여부 
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override	//계정잠김
	public boolean isAccountNonLocked() {
		//퇴사자는 잠금
		
		//System.out.println("트루는 맞냐?"+"0".equals(state));
		if ("0".equals(state)) {
	        return false; // 계정이 잠겨 있음
	    }
		return true; 
	}
	@Override // 비밀번호 만료 여부
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override // 계정 활성화 여부 
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
