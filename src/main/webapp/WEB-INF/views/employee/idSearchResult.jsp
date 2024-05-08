<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BUGCLEAN</title>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
</head>
<c:import url="../temp/css.jsp"></c:import> <!-- //bootstrap-template-css -->

<body>

<div class="authincation mt-5">
    <div class="container-fluid h-100 mx-5">
        <div class="row justify-content-center h-100 align-items-center"></div>
        <div class="col-md-10">
            <div class="row no-gutters">
                <div class="col-xl-12">
                    <div class="auth-form">


                        <div class="row page-titles mx-0"
                             style="background-color: rgb(243, 243, 255);">
                            <div class="col-sm-6 p-md-0">
                                <div class="welcome-text">
                                    <h4 style="font-weight: bolder;"> &nbsp; 아이디 찾기</h4>
                                    <span class="ml-1"></span>
                                </div>
                            </div>
                            <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="./login">Login</a></li>
                                    <li class="breadcrumb-item active">아이디 찾기</li>
                                </ol>
                            </div>
                        </div>
                        <!-- row -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title" style="font-weight: bolder;">현재 정보와 일치하는 아이디 입니다.</h4>
                                    </div>
                                    <div class="card-body">

                                        
                                        <div class="basic-form my-3">
                                            <c:if test="${employeeVO eq null}">
                                                <h3 class="text-primary mb-3" style="text-align: center;"><i class="fa-solid fa-xmark" style="color: #fd72ca;"></i>&nbsp; 일치하는 정보가 없습니다. 사원 등록 요청을 해주세요.</h3>
                                            </c:if>
                                            <c:if test="${employeeVO ne null}">
                                                <h3 class="text-primary mb-3" style="text-align: center;"><i class="fa-solid fa-check" style="color: #74C0FC;"></i>&nbsp; ${employeeVO.username}</h3>
                                                <h5 style="color: darkgray; text-align: center;">입사일 : ${employeeVO.join_date}</h5>
                                            </c:if>
                                        </div>
                                        <div class="col-sm-12 pt-4 pb-1" style="text-align: center;">
                                            <c:if test="${employeeVO eq null}">
                                                <a href="./create" type="button" class="btn btn-primary mr-1" style="height: 35px;">사원 등록</a>
                                                <a href="./idSearch" type="button" class="btn btn-light" style="height: 35px;">뒤로가기</a>
                                            </c:if>
                                            <c:if test="${employeeVO ne null}">
                                                <a href="./login" type="button" class="btn btn-primary mr-1" style="height: 35px;">로그인하기</a>
                                                <a href="./pwSearch" type="button" class="btn btn-light" style="height: 35px;">비밀번호 찾기</a>
                                            </c:if>
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
</div>


<c:import url="../temp/js.jsp"></c:import> <!-- // bootstrap-template-js -->
<script src="/bugclean/js/employee/idSearch.js"></script>
</body>

</html>