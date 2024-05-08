<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BUGCLEAN</title>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
    <style>
        .detail-table th {
            text-align: center;
        }

        .detail-table * {
            padding: 6px;
        }

        .modal-header * {
            margin-right: 5px;
        }

        .user_name {
            background: #e9ecef !important;
            color: #6c757d !important;
        }
    </style>
</head>
<c:import url="../temp/css.jsp"></c:import> <!-- //bootstrap-template-css -->
<link href="/focus-bootstrap-main/theme/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/css/style.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/vendor/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet">
<link href="/bugclean/css/MemberAgree-datatables.css" rel="stylesheet">
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
                        <h4 style="font-weight: bolder;">&ensp;자산관리</h4>
                    </div>
                </div>
                <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item">총무팀</li>
                        <li class="breadcrumb-item active">자산관리</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="default-tab">
                                <ul class="nav nav-tabs" role="tablist">
                                    <c:forEach items="${pro_cate}" var="cate" varStatus="loop">
                                        <li class="nav-item">
                                            <a onclick="propertyList(${cate.pro_category})"
                                               class="nav-link ${loop.first ? 'active' : ''}" data-toggle="tab"
                                               href="#list-${cate.pro_category}">${cate.pro_name}</a>
                                        </li>
                                    </c:forEach>
                                    <sec:authorize access="hasAnyRole('TEAMHEAD','DEPARTHEAD','CEO')">
                                    <li>
                                        <button onclick="catePlus()" class="nav-link">+</button>
                                    </li>
                                    </sec:authorize>
                                </ul>
                                <div class="tab-content">
                                    <c:forEach items="${pro_cate}" var="cate" varStatus="loop">
                                        <div class="tab-pane fade ${loop.first ? 'show active' : ''}"
                                             id="list-${cate.pro_category}"
                                             role="tabpanel">
                                            <div class="pt-4">
                                                <div class="card-title d-flex justify-content-between">
                                                    <span>${cate.pro_name}</span>
                                                    <button onclick="add(${cate.pro_category})" class="btn btn-primary">
                                                        자산등록
                                                    </button>
                                                </div>
                                                <div class="table-responsive">
                                                    <table id="propertyList-${cate.pro_category}"
                                                           class="table-hover table property" style="width: 98%">
                                                        <c:if test="${cate.pro_category eq 100}">
                                                            <tr>
                                                                <th>자산번호</th>
                                                                <th>차량번호</th>
                                                                <th>차량종류</th>
                                                                <th>운용상태</th>
                                                                <th>등록날짜</th>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${cate.pro_category ne 100}">
                                                            <tr>
                                                                <th>자산번호</th>
                                                                <th>자산이름</th>
                                                                <th>등록날짜</th>
                                                            </tr>
                                                        </c:if>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="property-modal">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fa-solid fa-user"></i></h5>
                        <%--                        <h5 id="modal-title-num" class="modal-title">2024001</h5>--%>
                        <h5 id="modal-title-name" class="modal-title">차량상세 정보</h5>
                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body d-flex justify-content-center">
                        <div class="row table-responsive">
                            <table class="table table-hover text-muted detail-table">
                                <tbody>
                                <tr>
                                    <th class="font-weight-bolder">자산번호</th>
                                    <td id="car_code" class="col-7">지정불가</td>
                                </tr>
                                <tr>
                                    <th class="font-weight-bolder">차량번호</th>
                                    <td class="col-7" style="padding: 0">
                                        <div style="display: inline-flex; width: 90%">
                                            <input id="car_num" type="text" class="form-control input-default user_name"
                                                   style="width: 50%"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="font-weight-bolder">차량상태</th>
                                    <td class="col-7" style="padding: 0">
                                        <div style="display: inline-flex; width: 90%">
                                            <select id="car_status" class="custom-select" style="width: 50%">
                                                <option value="0">운용가능</option>
                                                <option value="1">수리/점검중</option>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="font-weight-bolder">차량종류</th>
                                    <td class="col-7" style="padding: 0">
                                        <div style="display: inline-flex; width: 90%">
                                            <select id="car_type" class="custom-select" style="width: 50%">
                                                <c:forEach items="${car_type}" var="type">
                                                    <option value="${type.CAR_TYPE}">${type.TYPE_NAME}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="font-weight-bolder">등록일자</th>
                                    <td id="join_date" class="col-7">2021-04-01</td>
                                </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="modal-footer justify-content-between">
                        <div>
                            <button id="delete-btn" type="button" class="btn btn-warning">삭제</button>
                        </div>
                        <div>
                            <button id="close-btn" type="button" class="btn btn-secondary" data-dismiss="modal">닫기
                            </button>
                            <button id="modi-btn" type="button" class="btn btn-primary">수정</button>
                            <button id="save-btn" type="button" class="btn btn-primary" hidden="until-found">저장</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="pro-modal">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fa-solid fa-user"></i></h5>
                        <%--                        <h5 id="modal-title-num" class="modal-title">2024001</h5>--%>
                        <h5 class="modal-title">자산 정보</h5>
                        <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body d-flex justify-content-center">
                        <div class="row table-responsive">
                            <table class="table table-hover text-muted detail-table">
                                <tbody>
                                <tr>
                                    <th class="font-weight-bolder">자산번호</th>
                                    <td id="pro_code" class="col-7">지정불가</td>
                                </tr>
                                <tr>
                                    <th class="font-weight-bolder">자산이름</th>
                                    <td class="col-7" style="padding: 0">
                                        <div style="display: inline-flex; width: 90%">
                                            <input id="pro-name" type="text"
                                                   class="form-control input-default user_name"
                                                   style="width: 50%"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="font-weight-bolder">등록일자</th>
                                    <td id="add_date" class="col-7">2021-04-01</td>
                                </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>
                    <div class="modal-footer justify-content-between">
                        <div>
                            <button id="delete-pro" type="button" class="btn btn-warning">삭제</button>
                        </div>
                        <div>
                            <button id="close-pro" type="button" class="btn btn-secondary" data-dismiss="modal">닫기
                            </button>
                            <button id="modi-pro" type="button" class="btn btn-primary">수정</button>
                            <button id="save-pro" type="button" class="btn btn-primary" hidden="until-found">저장</button>
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
<script src="/bugclean/js/general/propertyList-dataTables-init.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>