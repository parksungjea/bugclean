<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BUGCLEAN</title>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
</head>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- https://github.com/szimek/signature_pad -->
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>
<c:import url="../temp/css.jsp"></c:import>
<style>
    .overlay-button {
        position: absolute;
        bottom: 5px; /* 오른쪽 하단에서의 여백 조정 */
        right: 5px; /* 오른쪽 하단에서의 여백 조정 */
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background-color: rgba(241, 241, 241, 0.822); /* 배경색 및 투명도 조정 */
        border: none;
        color: white; /* 텍스트 색상 */
        font-size: 16px; /* 텍스트 크기 */
    }

    .wrapper {
        position: relative;
        width: 400px;
        height: 200px;
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }

    .signature-pad {
        position: absolute;
        left: 0;
        top: 0;
        width: 400px;
        height: 200px;
        background-color: white;
    }


</style>

<body>
<div id="preloader">
    <div class="sk-three-bounce">
        <div class="sk-child sk-bounce1"></div>
        <div class="sk-child sk-bounce2"></div>
        <div class="sk-child sk-bounce3"></div>
    </div>
</div>
<div id="main-wrapper">


    <!--**********************************
        Content body start
    ***********************************-->
    <div class="content-body">
        <div class="container-fluid mb-5">
            <div class="row page-titles mx-0">
                <div class="col-sm-6 p-md-0">
                    <div class="welcome-text">
                        <h4>Profile</h4>

                    </div>
                </div>
                <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item active">Profile</li>
                    </ol>
                </div>
            </div>
            <!-- row -->
            <sec:authentication property="principal" var="employeeVO"/>

            <div class="row">
                <div class="col-lg-12">
                    <div class="profile">
                        <div class="profile-head">
                            <div class="photo-content">
                                <div class="cover-photo"></div>
                                <div class="profile-photo">

                                    <!-- 프로필-->
                                    <c:if test="${not empty employeeVO.profile}">

                                        <img src="/files/profile/${employeeVO.profile}"
                                             style="height: 150px; width: 150px;" class="img-fluid rounded-circle"
                                             alt=""/>

                                    </c:if>
                                    <c:if test="${empty employeeVO.profile}">
                                        <img src="/focus-bootstrap-main/theme/images/profile/사랑아보영해.jpg"
                                             style="height: 150px; width: 150px;" class="img-fluid rounded-circle"
                                             alt="">

                                    </c:if>
                                    <button class="overlay-button" data-toggle="modal"
                                            data-target="#profileUpdateModal">

                                        <i class="fa-solid fa-pen-to-square" style="color: black;"></i>
                                    </button>

                                    <!-- 변경 모달창 -->
                                    <div class="modal fade" id="profileUpdateModal" aria-hidden="true"
                                         style="display: none;">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">프로필 변경</h5>
                                                    <button type="button" class="close" data-dismiss="modal">
                                                        <span>×</span>
                                                    </button>
                                                </div>
                                                <form:form modelAttribute="employeeVO" id="updateForm"
                                                           action="./profileUpdate" method="post"
                                                           enctype="multipart/form-data">

                                                    <div class="modal-body">

                                                        <form:input path="employee_num"
                                                                    value="${employeeVO.employee_num}"
                                                                    hidden="true"></form:input>
                                                        <div class="mb-3">
                                                            <c:if test="${empty employeeVO.profile}">
                                                                <img src="/focus-bootstrap-main/theme/images/profile/사랑아보영해.jpg"
                                                                     id="preview"
                                                                     style="width: 100px; height: 100px; border-radius: 50px;"
                                                                     alt="...">
                                                            </c:if>
                                                            <c:if test="${not empty employeeVO.profile}">
                                                                <img src="/files/profile/${employeeVO.profile}"
                                                                     id="preview"
                                                                     style="width: 100px; height: 100px; border-radius: 50px;"
                                                                     alt="...">
                                                            </c:if>
                                                        </div>
                                                        <div class="input-group mb-3">
                                                            <input class="form-control" type="file"
                                                                   id="formFileMultiple" onchange="readImg(this);"
                                                                   data-file-count="0" data-file-max="1" name="file"
                                                                   accept="image/jpg, image/jpeg, image/png, image/gif">
                                                        </div>


                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" id="profileClose"
                                                                class="btn btn-secondary" data-dismiss="modal">Close
                                                        </button>
                                                        <button type="submit" class="btn btn-primary">Save</button>
                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                            </div>

                            <div class="profile-info">
                                <div class="row justify-content-center mb-3" style="float: right;">
                                    <div class="col-xl-8" style="margin-left: 2%;">
                                        <div class="row">

                                            <div class="col-xl-4 col-sm-4 border-right-1 prf-col">
                                                <div class="profile-email">
                                                    <h4 class="text-primary">${employeeVO.username}</h4>
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
            <!-- 비번 변경 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="profile-tab mx-4 my-2">
                                <div class="row mb-2">
                                    <div class="col-0 ml-3" style="display: table;">
                                        <i class="fa fa-lock" style="display: table-cell; vertical-align: middle;"></i>
                                    </div>
                                    <div class="col-10" style="display: table;">
                                        <h4 class="text-primary"
                                            style="font-weight: 700; display: table-cell; vertical-align: middle;">
                                            비밀번호</h4>
                                    </div>
                                    <div class="col-0">
                                        <a type="button" class="btn btn-light btn-lg" href="./pwUpdate">변경</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 수정불가 정보 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="profile-tab mx-4 my-4">
                                <div class="profile-personal-info">
                                    <div class="row">
                                        <div class="col-xl-6">

                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">이름 <span class="pull-right">:</span>
                                                    </h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.name}</span>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">부서 <span class="pull-right">:</span>
                                                    </h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.departmentVO.dep_name}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6">
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">사번 <span class="pull-right">:</span>
                                                    </h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.employee_num}</span>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">직급 <span class="pull-right">:</span></h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.positionVO.pos_name}</span>
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
            <!-- 수정가능 정보 -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="profile-tab mx-4 my-4">
                                <div class="profile-personal-info">
                                    <h4 class="text-primary mb-4">유저 정보</h4>
                                    <div class="row">
                                        <div class="col-xl-6">
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">닉네임 <span class="pull-right">:</span>
                                                    </h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.nickname}</span>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">휴대번호 <span class="pull-right">:</span>
                                                    </h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.phone}</span>
                                                </div>
                                            </div>
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <h5 class="f-w-500">주소 <span class="pull-right">:</span></h5>
                                                </div>
                                                <div class="col-9"><span
                                                        style="font-size: medium; font-weight: bold;">${employeeVO.address}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-6">
                                            <!-- 결재서명 -->
                                            <div class="row mb-4">
                                                <div class="col-12">
                                                    <h5 class="f-w-500">결재 서명&emsp;&emsp;&emsp;:<span
                                                            class="pull-right"></span>
                                                    </h5>
                                                </div>
                                                <div class="col-12"><span></span>
                                                    <c:if test="${not empty employeeVO.sign_file}">
                                                        <img src="${employeeVO.sign_file}" id="img01" src="" width="400"
                                                             height="200" style="border: 1px solid black"/>
                                                    </c:if>
                                                </div>
                                                <!-- 등록 -->
                                                <div class="col-0">
                                                    <button type="submit" id="exampleModalBtn"
                                                            class="btn btn-light btn-lg" data-toggle="modal"
                                                            data-target=".bd-example1-modal-lg">등록
                                                    </button>
                                                </div>
                                                <div class="modal fade bd-example1-modal-lg" id="exampleModalCenter"
                                                     style="display: none;" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">결재 서명 등록</h5>
                                                                <button type="button" class="close"
                                                                        data-dismiss="modal"><span>×</span>
                                                                </button>
                                                            </div>
                                                            <form:form action="./signSave" modelAttribute="employeeVO">
                                                                <div class="modal-body">
                                                                    <!-- <form id="addForm" action="./sign" method="post"> -->
                                                                    <!-- <form:input path="username" value="${employeeVO.username}" hidden="true"></form:input> -->
                                                                    <form:input path="employee_num"
                                                                                value="${employeeVO.employee_num}"
                                                                                hidden="true"></form:input>
                                                                    <form:input path="sign_file" id="sign_file" value=""
                                                                                hidden="true"></form:input>
                                                                    <img src="" id="img01" src="" width="400"
                                                                         height="200" style="border: 1px solid black"
                                                                         hidden/>
                                                                    <div class="wrapper">
                                                                        <canvas id="signature-pad" class="signature-pad"
                                                                                width=400 height=200
                                                                                style="border: 1px solid black"></canvas>
                                                                    </div>
                                                                    <!-- </form> -->
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn"
                                                                            data-dismiss="modal"
                                                                            style="background-color: rgb(143, 96, 188); color: white;">
                                                                        취소
                                                                    </button>
                                                                    <button type="button" id="clear"
                                                                            class="btn btn-secondary">지우기
                                                                    </button>
                                                                    <button type="submit" id="save-png"
                                                                            class="btn btn-primary">등록
                                                                    </button>
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
                            <!-- <div class="text-center mb-2"><a href="javascript:void()" class="btn btn-primary" data-toggle="modal" data-target="#infoUpdate">사원 정보 수정</a> </div> -->

                            <!-- 정보수정 -->
                            <div class="text-center mb-2 btn btn-primary" data-toggle="modal"
                                 data-target="#infoUpdateModal">사원 정보 수정
                            </div>
                            <div class="modal fade" id="infoUpdateModal" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">개인정보수정</h5>
                                            <button type="button" class="close" data-dismiss="modal"><span>×</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form:form action="./infoUpdate" modelAttribute="employeeVO" id="infoForm">
                                                <form:input path="employee_num" value="${employeeVO.employee_num}"
                                                            hidden="true"></form:input>
                                                <form:input path="phone" id="phone" value="" hidden="true"></form:input>
                                                <form:input path="address" id="address" value=""
                                                            hidden="true"></form:input>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label"
                                                           for="nickname">닉네임</label>
                                                    <div class="col-lg-6">
                                                        <form:input path="nickname"
                                                                    cssClass="form-control input-rounded" id="nickname"
                                                                    maxlength="8"
                                                                    oninput="onlyEnglish(this)"></form:input>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label><strong>휴대전화번호</strong></label>
                                                    <div class="form-row ml-3">
                                                        <div class="form-group row">
                                                            <select id="phoneStart" name="phoneStart"
                                                                    class="form-control col-3">
                                                                <option selected="" value="">
                                                                    -선택-
                                                                </option>
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
                                                                   maxlength="4" minlength="4"
                                                                   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                                                            &emsp;-&emsp;
                                                            <input type="text"
                                                                   class="form-control col-3"
                                                                   name="phoneEnd" id="phoneEnd" maxlength="4"
                                                                   minlength="4"
                                                                   onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                                                        </div>
                                                        <!-- <input type="text" id="phone" name="phone" style="display: none" value=""> -->
                                                        <!-- <form:input path="phone" id="phone" cssClass="form-control" style="display: none" value=""></form:input> -->
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label><strong>주소</strong></label>
                                                    <!-- <form:input path="address" id="address" cssClass="form-control col-6" style="display: none" value=""></form:input> -->
                                                    <div class="form-row">
                                                        <div class="col-sm-6">
                                                            <input type="text" id="sample6_postcode"
                                                                   class="form-control" placeholder="우편번호" readonly>
                                                        </div>
                                                        <div class="col-sm-6 mt-2 mt-sm-0">
                                                            <input type="button" onclick="sample6_execDaumPostcode()"
                                                                   value="우편번호 찾기">
                                                        </div>
                                                    </div>
                                                    <input type="text" id="sample6_address" class="form-control my-2"
                                                           placeholder="주소" readonly>
                                                    <div class="form-row">
                                                        <div class="col-sm-6">
                                                            <input type="text" id="sample6_detailAddress"
                                                                   class="form-control" placeholder="상세주소">
                                                        </div>
                                                        <div class="col-sm-6 mt-2 mt-sm-0">
                                                            <input type="text" id="sample6_extraAddress"
                                                                   class="form-control" placeholder="참고항목" readonly>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" id="infoClose" class="btn btn-secondary"
                                                            data-dismiss="modal">취소
                                                    </button>
                                                    <button type="submit" class="btn btn-primary" id="infoUpdateBtn">
                                                        저장
                                                    </button>
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
        </div>
        <c:import url="../temp/messenger.jsp"></c:import>
    </div>
    <!--**********************************
        Content body end
    ***********************************-->
</div>


<c:import url="../temp/header.jsp"></c:import>
<c:import url="../temp/sidebar.jsp"></c:import>


<c:import url="../temp/footer.jsp"></c:import>
<c:import url="../temp/js.jsp"></c:import>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/bugclean/js/employee/mypage.js"></script>
</body>
</html>