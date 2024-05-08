package com.winter.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;


@Configuration
@EnableWebSecurity //내설정
public class SecurityConfig{
	
	@Autowired
	private LoginSucessHandler sucessHandler;
	@Autowired
	private LoginFailHandler failHandler;
	
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//세션값 변경
	@Bean
	AuthenticationManager authenticationManager (AuthenticationConfiguration authenticationConfiguration) throws Exception{
		return authenticationConfiguration.getAuthenticationManager();
	}


	
	@Bean
	WebSecurityCustomizer webSecurityCustomizer() {
		return web -> web
				.ignoring()
				.requestMatchers("/css/**")
				.requestMatchers("/js/**")
				.requestMatchers("/vendor/**")
				.requestMatchers("/img/**")
				.requestMatchers("/favicon/**");
	}
	
	@Bean
	SecurityFilterChain filterChain (HttpSecurity security) throws Exception{
				//권한 설정
		security.authorizeHttpRequests(
				(authorizeHttpRequests) -> authorizeHttpRequests
											.requestMatchers("/").authenticated()
											.requestMatchers("/employee/login").permitAll()
											.requestMatchers("/employee/idSearch").permitAll()
											.requestMatchers("/employee/pwSearch").permitAll()
											.requestMatchers("/employee/create").permitAll()
											.requestMatchers("/employee/mailSend").permitAll()
											.requestMatchers("/employee/mailCheck").permitAll()
											.requestMatchers("/employee/idSearchResult").permitAll()
											.requestMatchers("/employee/idSearchPhone").permitAll()
											.requestMatchers("/chat/**").permitAll()
											.requestMatchers("/general/getUsableList","/general/getCarNumber","/general/getAllocationState","/general/carAllocation").hasAnyRole("BUSINESS","SALES","FIELD","CEO") // 현장,영업팀 스케쥴 관련
											.requestMatchers("/general/**").hasAnyRole("GENERAL","SUPPORT", "CEO") //총무팀
											.requestMatchers("/customer/list").hasAnyRole("FIELD","SALES","BUSINESS", "CEO") //영업팀
											.requestMatchers("/customer/sales_list").hasAnyRole("SALES","FIELD","BUSINESS", "CEO") //영업팀
											.requestMatchers("/schedule/list").hasAnyRole("FIELD","SALES","BUSINESS", "CEO") //스케쥴
											.requestMatchers("/schedule/sales_list").hasAnyRole("SALES","FILED","BUSINESS","CEO") //스케쥴
											.requestMatchers("/customer/**").hasAnyRole("FIELD","SALES","BUSINESS", "CEO") //영업팀
											.requestMatchers("/hr/**").hasAnyRole("PERSON","SUPPORT", "CEO") //인사팀
											
											.requestMatchers("/employee/logout", "/employee/mypage",
													"/employee/pwUpdate","/setAttendence","/setWorkOut", "/receive/inbox",
													"/customer/**","/chat/**","/schedule/**","/chart/**",
													"/draft/**", "/board/**", "/general/**", "/hr/**")
											.authenticated()
											//.requestMatchers("/hr/**").hasAnyRole("FIELD", "CEO") //현장팀
											.anyRequest().permitAll()
											//.anyRequest().authenticated()//나머지
		)
		//ajax 통신 권한
		.csrf(csrf -> csrf
	            .ignoringRequestMatchers("/employee/mailSend")
	            .ignoringRequestMatchers("/chat/**")
	            .ignoringRequestMatchers("/schedule/**")
	            .ignoringRequestMatchers("/draft/**")	    
				.ignoringRequestMatchers("/hr/**")
				.ignoringRequestMatchers("/customer/**")
				.ignoringRequestMatchers("/carManage/**")
				.ignoringRequestMatchers("/board/**")
				.ignoringRequestMatchers("/general/**")
				.ignoringRequestMatchers("/setAttendence")
				.ignoringRequestMatchers("/setWorkOut")
				.ignoringRequestMatchers("/employee/idSearchNum")
				.ignoringRequestMatchers("/employee/phoneSend")
				.ignoringRequestMatchers("/getnameAsk")
				.ignoringRequestMatchers("/getCarAsk")
				.ignoringRequestMatchers("/employee/**")
				.ignoringRequestMatchers("/chart/**")
	    )
		
		
		//내로그인폼
		.formLogin(
				(login)->login
						.loginPage("/employee/login")
						.successHandler(sucessHandler)
						.failureHandler(failHandler)
						.permitAll()
		)
		
		.logout(
				(logout)->logout
							.logoutRequestMatcher(new AntPathRequestMatcher("/employee/logout"))
							.logoutSuccessUrl("/employee/login")
							.invalidateHttpSession(true)//로그아웃시 session만료
							.permitAll()
		);
		
		return security.build();
	}
	
}
