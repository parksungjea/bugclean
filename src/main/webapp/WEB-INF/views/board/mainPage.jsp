<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BUGCLEAN</title>>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
    <style>
        .table-hover thead th,
        .table-hover tbody td {
            text-align: center;
        }

        .table-hover thead th:nth-child(2),
        .table-hover tbody td:nth-child(2) {
            width: 45%;
        }

        .table-hover thead th:nth-child(1),
        .table-hover thead th:nth-child(5),
        .table-hover tbody td:nth-child(1),
        .table-hover tbody td:nth-child(5) {
            width: 7%;
        }


        .table-hover thead th:nth-child(4),
        .table-hover tbody td:nth-child(4) {
            width: 25%;
        }

        .d-flex {
            display: flex;
            align-items: start;
            padding-right: 0 !important;
        }

        #board_contents img{
            width: 99%;
        }
    </style>
</head>
<c:import url="../temp/css.jsp"></c:import> <!-- //bootstrap-template-css -->
<link href="/focus-bootstrap-main/theme/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/css/style.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/vendor/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet">
<link href="/bugclean/css/MemberAgree-datatables.css" rel="stylesheet">
<link href="/focus-bootstrap-main/theme/vendor/summernote/summernote.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

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
                        <c:forEach var="index" begin="0" end="${fn:length(sessionScope.name) - 1}"
                                   varStatus="loop">
                            <c:if test="${active == sessionScope.code[index]}">
                                <h4 id="page-title" data-target="${sessionScope.code[index]}"
                                    style="font-weight: bolder;">&ensp;${sessionScope.name[index]}</h4>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item">게시판</li>
                        <c:forEach var="index" begin="0" end="${fn:length(sessionScope.name) - 1}"
                                   varStatus="loop">
                            <c:if test="${active == sessionScope.code[index]}">
                                <li class="breadcrumb-item">
                                    <a id="title-a"
                                       href="board?cate_code=${sessionScope.code[index]}">${sessionScope.name[index]}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">

                        <c:if test="${home ne null}">
                            <div class="card-body" data-active="${active}" data-board="${home}">
                                <script>
                                    console.log("home에서 왔을때");
                                    let formDataHome = new FormData;
                                    formDataHome.append('board_code', $('.card-body').attr('data-board'));
                                    formDataHome.append('cate_code', $('.card-body').attr('data-active'));

                                    $(document).ready(async function () {
                                        await boardDetailHome(formDataHome);
                                    });

                                    async function boardDetailHome(formDataHome) {
                                        await fetch("board/detail", {
                                            method: 'POST',
                                            body: formDataHome
                                        }).then(response => {
                                            return response.text();
                                        }).then(data => {
                                            $('.card-body').empty();
                                            $('.card-body').html(data);
                                        })

                                        $('#list-btn').on('click', function () {
                                            pageLoad();
                                        })

                                        $('#update-btn').on('click', function () {
                                            createBoard(formDataHome.get("board_code"));
                                        })
                                    }
                                </script>
                            </div>
                        </c:if>
                        <c:if test="${home eq null}">
                            <div class="card-body">
                                <script>
                                    $(document).ready(async function () {
                                        await pageLoad();
                                    });
                                </script>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- <c:import url="../temp/messenger.jsp"></c:import>--%>
</div>

</div>
<c:import url="../temp/footer.jsp"></c:import> <%--footer--%>
<c:import url="../temp/js.jsp"></c:import> <%--bootstrap-template-js--%>
<script
        src="/focus-bootstrap-main/theme/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="/focus-bootstrap-main/theme/vendor/summernote/js/summernote.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/bugclean/js/board/board.js"></script>

</body>

</html>
