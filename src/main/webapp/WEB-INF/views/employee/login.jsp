<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>BUGCLEAN</title>
	<link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
</head>
<c:import url="../temp/css.jsp"></c:import>
<body>
	

	<div class="authincation mt-5">
		<div class="container-fluid h-100">
			<div class="row justify-content-center h-100 align-items-center">
				<div class="col-md-6">
					<div class="authincation-content">
						<div class="row no-gutters">
							<div class="col-xl-12">
								<div class="auth-form">



									<div class="text-center my-4">
										<!-- <img id="bugclean"	src="/focus-bootstrap-main/theme/images/logo.png" alt="logo" style="height: 100px; width: 300px;"> -->
										<img id="bugclean"	class="mr-2" src="/focus-bootstrap-main/theme/images/logo.png" alt="logo" style="height: 60px; width: 55px;">
										<img id="bugclean"	src="/focus-bootstrap-main/theme/images/logo-text.png" alt="logo" style="height: 50px; width: 150px;">
									</div>

									<div>
										<h4 style="color: red;">${param.message}</h4>
									</div>

									<!-- <form action="index.html"> -->
									<form:form modelAttribute="employeeVO">



									
										<div class="form-group">
											<label><strong>ID</strong></label>
											<form:input path="username" id="username" value="${cookie.rememberId.value}" cssClass="form-control" placeholder="example@gmail.com"></form:input>
											<form:errors path="username"></form:errors>
										</div>
										<div class="form-group">
											<label><strong>Password</strong></label>
											<!-- <input type="password" class="form-control"> -->
											<form:password path="password" id="password" cssClass="form-control" value="qwer1234!"></form:password>
						                    <form:errors path="password"></form:errors>
										</div>
										<div class="form-row d-flex justify-content-between mt-4 mb-2">
											<div class="form-group">
												<div class="form-check ml-2">
													<input name="rememberId" id="remember-id" class="form-check-input" type="checkbox" checked id="basic_checkbox_1">
													<label class="form-check-label" for="basic_checkbox_1">아이디 저장</label>
												</div>
											</div>
										</div>
										<div class="text-center">
											<button type="submit" class="btn btn-primary btn-block">Login</button>
										</div>
									</form:form>
									
									<div class="form-row d-flex justify-content-center mt-5">
										<div class="form-group">
											<a href="/employee/idSearch">아이디 찾기</a>
										</div>
										<p>&ensp;ㅣ&ensp;</p>
										<div class="form-group">
											<a href="./pwSearch">비밀번호 찾기</a>
										</div>
										<p>&ensp;ㅣ&ensp;</p>
										<div class="form-group">
											<a href="./create">사원 등록</a>
										</div>
									</div>

									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	


	<c:import url="../temp/js.jsp"></c:import>
</body>
</html>