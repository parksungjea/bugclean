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
<link href="/focus-bootstrap-main/theme/vendor/select2/css/select2.min.css" rel="stylesheet">
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
                        <h4 style="font-weight: bolder;">&ensp;급여관리</h4>
                    </div>
                </div>
                <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item">인사팀</li>
                        <li class="breadcrumb-item active">급여관리</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">사원별 연봉 정보</div>
                            <div class="form-inline">
                                <label class="mr-2" for="yearSelect">조회할 연도 선택</label>
                                <div>
                                    <select id="yearSelect">
                                        <c:forEach items="${salYear}" var="year">
                                            <option value="${year}">${year}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <table id="salaryList" class="table-hover table" style="width: 98%">
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
            <div class="modal fade" id="salaryModal">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title"><i class="fa-solid fa-user"></i></h5>
                            <h5 id="modal-title-num" class="modal-title">2024001</h5>
                            <h5 id="modal-title-name" class="modal-title">허쿠니</h5>
                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                            </button>
                        </div>
                        <div class="modal-body d-flex justify-content-center">
                            <div class="row table-responsive">
                                <table class="table table-hover text-muted detail-table">
                                    <tbody>
                                    <tr>
                                        <th class="font-weight-bolder">급여계좌번호</th>
                                        <td class="col-7" style="padding: 0">
                                            <div style="display: inline-flex; width: 90%">
                                                <input id="account" type="text"
                                                       class="form-control input-default user_name" style="width: 50%"/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="font-weight-bolder">급여은행</th>
                                        <td class="col-7" style="padding: 0">
                                            <div style="display: inline-flex; width: 90%">
                                                <input id="bank" type="text"
                                                       class="form-control input-default user_name" style="width: 50%"/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="font-weight-bolder">연봉금액</th>
                                        <td class="col-7" style="padding: 0">
                                            <div style="display: inline-flex; width: 90%;" class="d-flex justify-content-center align-content-center align-items-center text-center">
                                                <input id="salary" type="text"
                                                       class="form-control input-default user_name" style="width: 50%"/> &nbsp 만원
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                            </div>

                        </div>
                        <div class="modal-footer justify-content-between">
                            <button id="close-btn" type="button" class="btn btn-secondary" data-dismiss="modal">닫기
                            </button>
                            <button id="save-btn" type="button" class="btn btn-primary">저장</button>
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
<script src="/focus-bootstrap-main/theme/vendor/select2/js/select2.full.min.js"></script>
<script src="/bugclean/js/hr/salaryList-dataTables-init.js"></script>

</body>
</html>