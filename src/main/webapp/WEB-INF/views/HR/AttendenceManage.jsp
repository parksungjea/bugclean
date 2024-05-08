<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BUGCLEAN</title>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
</head>
<c:import url="../temp/css.jsp"></c:import> <!-- //bootstrap-template-css -->
<link href="/focus-bootstrap-main/theme/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/css/style.css" rel="stylesheet">
<link href="/bugclean/css/MemberAgree-datatables.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/vendor/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
<body>
<div id="preloader">
    <div class="sk-three-bounce">
        <div class="sk-child sk-bounce1"></div>
        <div class="sk-child sk-bounce2"></div>
        <div class="sk-child sk-bounce3"></div>
    </div>
</div>
<div id="main-wrapper">

    <c:import url="../temp/header.jsp"></c:import> <!-- //nav-header-->
    <c:import url="../temp/sidebar.jsp"></c:import> <!-- //sidebar-menu-->

    <div class="content-body " style="min-height:900px;">
        <div class="container-fluid">
            <div class="row page-titles mx-0">
                <div class="col-sm-6 p-md-0">
                    <div class="welcome-text">
                        <h4 style="font-weight: bolder;">&ensp;근태관리</h4>
                    </div>
                </div>
                <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item">인사팀</li>
                        <li class="breadcrumb-item active">근태관리</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">날짜별 근태 조회</div>
                            <div class="form-inline mb-2">
                                <label class="mr-2" for="datePicker">조회 날짜 선택</label>
                                <div>
                                    <input class="form-control datePicker" id="datePicker" type="text" name="dateRange">
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <table id="attendanceList" class="table-hover table" style="width: 98%">
                                <tr>
                                    <th>사번</th>
                                    <th>이름</th>
                                    <th>급여계좌번호</th>
                                    <th>급여은행</th>
                                    <th>연봉금액</th>
                                    <th>부서</th>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:import url="../temp/messenger.jsp"></c:import>
    </div>

</div>
<c:import url="../temp/footer.jsp"></c:import> <%--footer--%>
<c:import url="../temp/js.jsp"></c:import> <%--bootstrap-template-js--%>
<script src="/focus-bootstrap-main/theme/vendor/datatables/js/jquery.dataTables.min.js"></script>
<!-- Daterangepicker -->
<!-- momment js is must -->
<script src="/focus-bootstrap-main/theme/vendor/moment/moment.min.js"></script>
<script src="/focus-bootstrap-main/theme/vendor/bootstrap-daterangepicker/daterangepicker.js"></script>

<script src="/bugclean/js/hr/attendance-dataTables-init.js"></script>

</body>
</html>