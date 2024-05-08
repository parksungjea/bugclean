<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>BUGCLEAN</title>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
    <!-- Favicon icon -->

	<c:import url="./temp/css.jsp"></c:import>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

</head>

<body>
    <div id="preloader">
		<div class="sk-three-bounce">
			<div class="sk-child sk-bounce1"></div>
			<div class="sk-child sk-bounce2"></div>
			<div class="sk-child sk-bounce3"></div>
		</div>
	</div>
	<div id="main-wrapper">
        <c:import url="./temp/header.jsp"></c:import>
        <c:import url="./temp/sidebar.jsp"></c:import>
        
        <div class="content-body">
            <div class="container-fluid mb-5">

                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal" var="employeeVO"/>
                    <h3 style="font-weight: bold;" class="mb-2">
                        <spring:message code="welcome" arguments="${employeeVO.name}" text="안녕하세요!"></spring:message>  
                    </h3>
                </sec:authorize>



               
                <div class="row">
                    <!-- 출퇴 -->
                    <div class="col-lg-5">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">T&A</h4>
                            </div>
                            <div class="card-body">
                                <div class="bootstrap-media">
                                    <div class="media">
                                        
                                        <div class="media-body">


                                            <div class="card-body" style="text-align: center;">
                                                <h2 id="clock">00:00:00</h2>
                                            </div>
                                            
                                                
                                                <div class="text-center mt-4 mx-3">
                                                    <form action="/setAttendence" method="post" onsubmit="return confirm('출근하시겠습니까?');">
                                                        <input type="hidden" name="employee_num" value="${employeeVO.employee_num}">
                                                        <button type="submit" id="attendence" class="btn btn-light btn-block" style="font-weight: bold;">출근</button>
                                                    </form>
                                                    <form action="/setWorkOut" method="post" onsubmit="return confirm('퇴근하시겠습니까?');">
                                                        <input type="hidden" name="employee_num" value="${employeeVO.employee_num}">
                                                        <button type="submit" id="workout"  class="btn btn-dark btn-block" style="font-weight: bold;">퇴근</button>
                                                    </form>
                                                </div>

                                                <div class="text-center mt-4 mx-3">
                                                    <table class="col-12">
                                                        <tbody>
                                                            <tr>
                                                                <td class="col-6">출근 시간</th>
                                                                <c:if test="${null eq attendanceVO.attend_start_time}">
                                                                    <td id="leaveTime" style="font-size: large; color: darkgray;">-</td>
                                                                </c:if>
                                                                <c:if test="${null ne attendanceVO.attend_start_time}">

                                                                    <td id="leaveTime" style="font-size: large; color: darkgray;">${attendanceVO.attend_start_time}</td>
                                                                </c:if>
                                                            </tr>
                                                            <tr>
                                                                <td>퇴근 시간</td>
                                                                
                                                                <c:if test="${null eq attendanceVO.attend_done}">
                                                                    <td id="leaveTime" style="font-size: large; color: darkgray;">-</td>
                                                                </c:if>
                                                                <c:if test="${null ne attendanceVO.attend_done}">

                                                                    <td id="leaveTime" style="font-size: large; color: darkgray;">${attendanceVO.attend_done}</td>
                                                                </c:if>

                                                                
                                                            </tr>
                                                    </table>

                                                </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 공지사항 -->
                    <div class="col-lg-7">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Notice</h4>
                            </div>
                            <div class="card-body py-2">
                                <div class="bootstrap-media">

                                    <table class="table header-border table-responsive-sm">
                                        <thead>
                                            <tr>
                                                <th class="col-2">No.</th>
                                                <th class="col-6">Title</th>
                                                <th class="col-4">Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${boardVO.size()==0}">
                                                <tr>
                                                    <td colspan="4">결과 없습니다</td>
                                                <tr>
                                            </c:if>
                                            
                                            <c:forEach items="${boardVO}" var="list">
                                                <tr>
                                                    <td>${list.board_code}</td>
                                                    <td><a href="/board?cate_code=${list.cate_code}&home=${list.board_code}" style="font-weight: bold;">${list.board_title}</a></td>
                                                    <td>${list.board_date}</td>
                                                    
                                                </tr>
                                            </c:forEach>
                                            <!-- <tr>
                                                <td>217</td>
                                                <td><a href="javascript:void(0)" style="font-weight: bold;">공지입니당!</a></td>
                                                <td>2024-04-05</td>
                                            </tr> -->
                                            
                                            
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 일정확인 -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Schedule</h4>
                            </div>

                            <div class="card-body" id="card-body">
                                
                                <div id='calendar' style="color: black"></div>
                                <!-- <i class="fa-regular fa-circle-check" style="color: #B197FC;"></i> -->
                                <!-- style="color: red"  text-warning-->
                                <div id="content" style="display: none;">
                                    <div class="row justify-content-between">
                                        
                                        <div class="col-12">
                                            <br>
                                            <hr>
                                             <div class="close-button" id="closeButton" style="display: inline-block; margin: 0 5px; float: right; font-size: 16px; color: black;"><a href="#"><i class="fa-solid fa-xmark"></i></a></div>
                                            <br>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-4">
                                                <h4 class="card-title card-intro-title">Details</h4>
                                            </div>
                            
                                            <div class="card-content" >
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">현장 번호 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="site_Num"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">거래처 번호 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="customer_Num"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">작업 시작일시 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="start_Time"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">작업 종료일시 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="end_Time"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">주소 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="address"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500" id="buisnessman">사업자 이름 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="business_Name"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 id="printCeoName" class="f-w-500">대표자 이름<span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="ceo_Name"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">현장관리자 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="employee_Num"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">배차 상태 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="manage_Code"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">단가 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="price"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">영업 담당자 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="sales_Manager"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-4">
                                                        <h5 class="f-w-500">현장구분 <span class="pull-right">:</span></h5>
                                                    </div>
                                                    <div class="col-8" id="site_Type"><span class="text-primary" style="font-weight: bolder;"></span>
                                                    </div>
                                                </div>
                                                
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-4">
                                                    <h4 class="card-title card-intro-title">Map</h4>
                                            </div>
                                
                                            <div id="map" style="width:100%;height:500px;"></div>
                                        </div>
                                    
                                    </div>
                                </div>
                                    
                            </div>
                        </div>
                    </div>
                </div>






                <c:import url="./temp/messenger.jsp"></c:import>
                
            </div>
        </div>
    </div>
    
        
        
        <c:import url="./temp/footer.jsp"></c:import>
        <c:import url="./temp/js.jsp"></c:import>
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fff43990ae8a3d5c0de034a2023420d6&libraries=services"></script>
        <script src="/bugclean/js/index.js"></script>
</body>
    
    