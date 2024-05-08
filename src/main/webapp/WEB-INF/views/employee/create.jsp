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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<body>
	
	

	<div class="authincation mt-5">
		<div class="container-fluid h-100">
			<div class="row justify-content-center h-100 align-items-center">
				<div class="col-md-7">
					<div class="authincation-content">
						<div class="row no-gutters">
							<div class="col-xl-12">
								<div class="auth-form">
									<h3 class="text-primary text-center mb-5" style="font-weight: bolder;">BugClean 가입 신청</h3>
									
									
									<form:form modelAttribute="employeeVO">

										<div class="form-group">
											<label><strong>아이디</strong></label>
											<div style="display: flex;">
												<div class="input-group mb-3">
													<form:input path="username"  cssClass="form-control" id="username"></form:input>
													<div class="input-group-append">
														<span class="input-group-text">@gmail.com</span>
													</div>
												</div>
												<div class="card-action mx-1 mt-1" style="height: 35px; display: table;">
													<div id="mailCheckBtn" type="button" class="dropdown custom-dropdown" style="width: 80px; display: table-cell; vertical-align: middle;">
														인증 요청
													</div>
												</div>
											</div>
											<form:errors path="username" style="color: red;"></form:errors></br>
											<form:errors path="userNumCheck" style="color: red;"></form:errors>
										</div>

										<div id="mail_number" class="form-group mb-4" style="display: none;">
											<label><strong>인증번호</strong></label>
											<div style="display: flex;">
												<!-- <input type="text" name="number" id="number" class="form-control col-6 mailCheckInput" maxlength="6" placeholder="인증번호 6자리를 입력해주세요."> -->
												
												<form:input path="userNumCheck"  cssClass="form-control col-6 mailCheckInput" id="userNumCheck" maxlength="6" placeholder="인증번호 6자리를 입력해주세요."></form:input>
												
												<input type="text" id="Confirm" name="Confirm" style="display: none" value="">
												<button type="button" name="confirmBtn" id="confirmBtn" onclick="confirmNumber()" class="btn btn-light mx-1" style="height: 35px;">확인</button>
											</div>
											<span id="mailCheckWarn"></span>
										</div>






										<div class="form-group">
											<label><strong>비밀번호</strong></label>
											<p class="my-0">10~16자 영문자, 숫자, 특수문자</p>
											<form:password path="password" cssClass="form-control" id="password"></form:password>
											<form:errors path="password" style="color: red;"></form:errors>
										</div>

										<div class="form-group">
											<label><strong>비밀번호 확인</strong></label>
											<form:password path="passwordCheck" cssClass="form-control" id="passwordCheck"></form:password>
											<form:errors path="passwordCheck" style="color: red;"></form:errors>
										</div>

										<div class="form-group">
											<label><strong>이름</strong></label>
											<form:input path="name" id="name" cssClass="form-control col-6"></form:input>
											<form:errors path="name"  style="color: red;"></form:errors>
										</div>
										<div class="form-group">
											<label><strong>휴대전화번호</strong></label>

											


												<div class="form-row ml-3">
													<div class="form-group row">
														<select id="phoneStart" name="phoneStart"
															class="form-control col-3">
															<option selected="" value="">
																-선택-</option>
															<option value="010">010</option>
															<option value="011">011</option>
															<option value="016">016</option>
															<option value="017">017</option>
															<option value="018">018</option>
															<option value="019">019</option>
														</select>&emsp;-&emsp;
														<input type="text"
															class="form-control col-3"
															name="phoneMiddle" id="phoneMiddle"
															maxlength="4" minlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
														&emsp;-&emsp;
														<input type="text"
															class="form-control col-3"
															name="phoneEnd" id="phoneEnd" maxlength="4" minlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
													</div>
													<!-- <input type="text" id="phone" name="phone" style="display: none" value=""> -->
													<form:input path="phone" id="phone" cssClass="form-control" style="display: none" value=""></form:input>
												</div>
												<form:errors path="phone" style="color: red;"></form:errors>
										</div>

										<div class="form-group">
											<label><strong>주소</strong></label>
											<form:input path="address" id="address" cssClass="form-control col-6" style="display: none" value=""></form:input>
											
											
											<div class="form-row">
												<div class="col-sm-6">
													<input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호" readonly>
												</div>
												<div class="col-sm-6 mt-2 mt-sm-0">
													<input type="button" class="btn-sm btn-light" onclick="sample6_execDaumPostcode()" style="height: 35px;" value="우편번호 찾기">
												</div>
											</div>
											<input type="text" id="sample6_address" class="form-control my-2" placeholder="주소">
											<div class="form-row">
												<div class="col-sm-6">
													<input type="text" id="sample6_detailAddress" class="form-control" placeholder="상세주소">
												</div>
												<div class="col-sm-6 mt-2 mt-sm-0">
													<input type="text" id="sample6_extraAddress" class="form-control" placeholder="참고항목" readonly>
												</div>
											</div>
											
											<form:errors path="address" style="color: red;"></form:errors>
										</div>


										<div class="text-center mt-5">
											<button type="submit" id="submit" class="btn btn-primary btn-block">가입 신청</button>
										</div>
									</form:form>
									

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:import url="../temp/js.jsp"></c:import>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/bugclean/js/employee/create.js"></script>


</body>
</html>