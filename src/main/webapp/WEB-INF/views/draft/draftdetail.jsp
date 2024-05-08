<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>BUGCLEAN</title>
    <link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
    <!-- Favicon icon -->
    <c:import url="../temp/css.jsp"></c:import>
    <link rel="stylesheet" href="/bugclean/css/draft/basisdraftmodal.css">
    <link rel="stylesheet" href="/bugclean/css/draft/basisdraftorg.css">
    <link rel="stylesheet" href="/bugclean/css/draft/basisdraft.css">
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
    <!--*******************
    Preloader start
********************-->

    <!--*******************
    Preloader end
********************-->


    <!--**********************************
    Main wrapper start
***********************************-->


    <!--**********************************
        Nav header start
    ***********************************-->

    <!--**********************************
        Nav header end
    ***********************************-->

    <!--**********************************
        Header start
    ***********************************-->
    <c:import url="../temp/header.jsp"></c:import>
    <!--**********************************
        Header end ti-comment-alt
    ***********************************-->

    <!--**********************************
        Sidebar start
    ***********************************-->
    <c:import url="../temp/sidebar.jsp"></c:import>
    <!--**********************************
        Sidebar end
    ***********************************-->

    <!--**********************************
        Content body start
    ***********************************-->
    <div class="content-body" style="min-height: 877px;">
        <!-- 기안서 제목 시작 -->
        <div id="standardDraftDiv">
            <!-- 임시저장일때 -->
            <c:if test="${draftmap.STATE eq 2}">
                <form action="/draft/setdetaildraft" method="post"
                      enctype="multipart/form-data">
                    <div>
                        <h1 id="title">기안서</h1>
                    </div>
                    <!-- 기안서 제목 끝 -->

                    <!--  결재선 편집버튼 시작 -->

                    <!-- 결재선 편집버튼 끝 -->

                    <!-- 결재선 시작 -->
                    <div id="draftLine">
                        <div id="lineBtnDiv"
                             style="position: absolute; top: 15px; left: -50px; display: inline-block;">
                            <button type="button" id="lineBtn"
                                    class="lineBtnDiv btn btn-google">
                                편<br>집<br>하<br>기
                            </button>

                        </div>

                        <table border="1" id="allineTable">

                            <tr id="input_grade">
                                <td rowspan="4">결재선</td>
                                <c:forEach items="${approvalar}" var="approvalar">
                                    <c:if test="${approvalar.SIGN_RANK eq 0 }">
                                        <td>기안자</td>
                                    </c:if>
                                    <c:if test="${approvalar.SIGN_RANK ne 0}">
                                        <td>${approvalar.POS_NAME}</td>

                                    </c:if>
                                </c:forEach>
                            </tr>

                            <tr id="input_blank">
                                <c:forEach items="${approvalar}" var="approvalar">
                                    <c:if
                                            test="${approvalar.SIGN_RANK < approvalar.NOW_APPROVAL }">
                                        <c:if test="${not empty approvalar.SIGN_FILE }">
                                            <td><img src="${approvalar.SIGN_FILE}" width="50px"
                                                     height="30px"></td>
                                        </c:if>
                                        <c:if test="${empty approvalar.SIGN_FILE }">
                                            <td>${approvalar.NAME }</td>
                                        </c:if>
                                    </c:if>
                                    <c:if
                                            test="${approvalar.SIGN_RANK >= approvalar.NOW_APPROVAL }">
                                        <td></td>
                                    </c:if>

                                </c:forEach>
                            </tr>

                            <tr id="input_name">
                                <c:forEach items="${approvalar }" var="approvalar">
                                    <td>${approvalar.NAME}<input type="hidden"
                                                                 value="${approvalar.EMPLOYEE_NUM}" name="SignEmp">
                                    </td>
                                </c:forEach>
                            </tr>

                            <tr>
                                <c:forEach items="${approvalar}" var="approvalar">
                                    <c:if
                                            test="${approvalar.SIGN_RANK < approvalar.NOW_APPROVAL }">
                                        <td class="date">${approvalar.SIGN_DATE}</td>
                                    </c:if>
                                    <c:if
                                            test="${approvalar.SIGN_RANK >= approvalar.NOW_APPROVAL }">
                                        <td class="date"></td>
                                    </c:if>
                                </c:forEach>
                            </tr>
                        </table>

                    </div>

                    <!-- 결재선 끝 -->

                    <!-- 기안서양식 시작 -->
                    <div id="basisDraft">
                        <table border="1">
                            <tr>
                                <td class="basisTitleTd">기안자</td>
                                <td class="basisTd"><input class="inp" type="text"
                                                           value="${draftmap.NAME}" readonly="readonly"> <input
                                        type="hidden" value="${draftmap.EMPLOYEE_NUM}"
                                        name="employee_num"></td>
                                <td class="basisTitleTd">소속부서</td>
                                <td class="basisTd"><input class="inp" type="text"
                                                           value="${draftmap.DEP_NAME}" readonly="readonly"></td>
                            </tr>

                            <tr>
                                <td class="basisTitleTd">기안일자</td>
                                <td class="basisTd"><input name="draft_date" class="inp"
                                                           type="hidden" value="${draftmap.DRAFT_DATE}"
                                                           readonly="readonly"></td>
                                <td class="basisTitleTd">문서번호</td>
                                <td class="basisTd"><input name="draft_num" class="inp"
                                                           type="text" value="${draftmap.DRAFT_NUM}"
                                                           readonly="readonly"></td>
                            </tr>

                            <tr>
                                <td class="basisTitleTd">제목</td>
                                <td class="basisTd"><input name="title"
                                                           value="${draftmap.TITLE}" class="inp" type="text"></td>
                                <td class="basisTitleTd">참조</td>
                                <td class="basisTd"><input readonly="readonly" id="refInp"
                                                           class="inp" type="text" readonly="readonly"
                                                           value="${refname}">
                                    <input id="refempnum" type="hidden" class="inp"
                                           name="refempnum"></td>
                            </tr>

                            <tr style="height: 300px;">
                                <td class="basisTitleTd">내용</td>
                                <td class="basisTitleTd" colspan="4" style="text-align: left;">
										<textarea name="contents" class="inp" name="contents"
                                                  style="text-align: left;" rows="" cols="">
												<c:if test="${draftmap.CONTENTS ne null}">
                                                    ${draftmap.CONTENTS }
                                                </c:if>
										</textarea>
                                </td>
                            </tr>
                        </table>
                        <div id="files">
                            <div id="attachment-group">
                                <div class="input-group mb-1" id="attachment-1">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">첨부파일</span>
                                    </div>
                                    <div class="custom-file col" style="background-color: green;">
                                        <input type="file" class="custom-file-input" name="attach">
                                        <label class="custom-file-label">파일을 선택하세요</label>
                                    </div>
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-sm btn-dark plus-file">+</button>
                                        <button type="button" class="btn btn-sm btn-dark minus-file"
                                                data-target="attachment-1" disabled="">−
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 파일 시작 -->
                            <%-- <input type="hidden" value="${draftmap.STATE}" name="state"> --%>
                        <input type="hidden" value="${draftmap.NOW_APPROVAL}"
                               name="now_approval">
                        <div>
                            <c:if test="${draftmap.STATE eq 3}">
                                <h4 style="color: blue;">결재완료된 기안서 입니다</h4>
                            </c:if>

                            <c:if test="${draftmap.STATE ne 3}">
                                <div id="btn"
                                     style="position: absolute; left: 350px; bottom: -40px;">
                                    <button id="draftDeleteBtn" type="button" style="width: 90px"
                                            data-delete-emp="${draftmap.DRAFT_NUM}"
                                            class="btn btn-warning">삭제하기
                                    </button>
                                </div>

                                <div id="temporaryBtn"
                                     style="position: absolute; left: 450px; bottom: -40px;">
                                    <button type="submit" name="state" value="2"
                                            style="width: 90px" data-delete-emp="${draftmap.DRAFT_NUM}"
                                            class="btn btn-secondary">임시저장
                                    </button>
                                </div>

                                <div id="updateBtn"
                                     style="position: absolute; left: 550px; bottom: -40px;">
                                    <button type="submit" name="state" value="0"
                                            style="width: 90px" data-delete-emp="${draftmap.DRAFT_NUM}"
                                            class="btn btn-primary">상신하기
                                    </button>
                                </div>
                            </c:if>
                        </div>
                        <!-- 파일 끝 -->
                    </div>
                    <!-- 기안서양식 끝 -->
                    <input type="hidden" value="0" name="draft_category">
                    <!-- 버튼모음 시작 -->
                </form>
                <!-- 버튼모음 끝 -->

                <!-- 모달창 시작 -->
                <div id="modalBack" class="noshow">
                    <div id="modal" class="noshow">
                        <!-- 셀렉트 시작 -->
                        <div id="selectDiv">
                            <select id="select">
                                <option>자주쓰는결재선</option>
                                <c:forEach items="${allist}" var="allist">
                                    <option value="${allist.approval_line_code}">${allist.line_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!-- 셀렉트 끝 -->

                        <!-- 제목 시작 -->
                        <div id="draftLineTitle">
                            <h3>결재선 설정</h3>
                        </div>
                        <!-- 제목 끝 -->

                        <!-- 결재선 제목 시작 -->
                        <div id="draftTitle">
                            <h4>결재선</h4>
                        </div>
                        <!-- 결재선 제목 끝 -->

                        <!-- 결재선 버튼 시작 -->
                        <div id="draftBtnDiv">
                            <i id="draftBtnMinus"
                               class="fa-solid fa-square-caret-left fa-2x"
                               style="display: inline-block;"></i>
                            <h3 style="display: inline-block;">결재</h3>
                            <i id="draftBtnPlus"
                               class="fa-solid fa-square-caret-right fa-2x"
                               style="display: inline-block;"></i>
                        </div>
                        <!-- 결재선 버튼 끝 -->

                        <!-- 참조 버튼 시작 -->
                        <div id="refBtn">
                            <i id="refMinusBtn" class="fa-solid fa-square-caret-left fa-2x"></i>
                            <h3 style="display: inline-block;">참조</h3>
                            <i id="refPlusBtn" class="fa-solid fa-square-caret-right fa-2x"
                               style="display: inline-block;"></i>
                        </div>
                        <!-- 참조 버튼 끝 -->

                        <!-- 결재선 박스 시작 -->
                        <div id="draftBox" style="overflow-y: scroll; height:141px;">
                            <table border="1">
                                <tr style="height: 140px;" id="draftBoxTr">
                                    <td style="width: 200px; vertical-align: top;" id="draftBoxTd">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <!-- 결재선 박스 끝 -->
                        <!-- 참조 제목 시작 -->
                        <div id="refTitle">
                            <h4>참조</h4>
                        </div>
                        <!-- 참조 제목 시작 -->

                        <!-- 참조 박스 시작 -->

                        <div id="refBox" style="overflow-y: scroll; height:141px;">
                            <table border="1">
                                <tr style="height: 140px">
                                    <td style="width: 200px; vertical-align: top;" id="refBoxTd"></td>
                                </tr>
                            </table>
                        </div>
                        <!-- 닫기 버튼 시작 -->
                        <div id="modalCloseBtn">
                            <span class="close">&times;</span>
                        </div>
                        <!-- 닫기 버튼 끝 -->

                        <!-- 등록 버튼 시작 -->
                        <div id="modalCreateBtnDiv">
                            <button id="modalCreateBtn">등록</button>
                        </div>
                        <!-- 등록 버튼 끝 -->

                        <!-- 초기화 버튼 시작 -->
                        <div id="modalResetBtn">
                            <button>초기화</button>
                        </div>
                        <!-- 초기화 버튼 끝 -->

                        <!-- 결재선 저장 타이틀 -->
                        <div id="approvalDiv">
                            <input type="text" placeholder="결재선 이름 입력" style="width: 120px;"
                                   id="approvalInpName">
                            <button id="approvalBtn" type="button"
                                    style="display: inline-block;">저장
                            </button>
                        </div>
                        <!-- 결재선 저장 타이틀 -->

                        <!-- 조직도 제목 시작 -->
                        <div id="orgTitle">
                            <h4>조직도</h4>
                        </div>
                        <!-- 조직도 제목 끝-->

                        <!-- 조직도 시작 -->
                        <div id="orgDiv" style="overflow-y: scroll; height:381px;">

                            <table border="1">
                                <tr style="height: 380px;">
                                    <td style="width: 200px; vertical-align: top;" id="orgBoxTd">
                                        <!-- 부서 리스트 시작--> <c:forEach items="${dep}" var="dep">
                                        <div class="orgTeamDiv">
                                            <c:if test="${dep.dep_name ne '사장'}">
                                                <i class="fa-solid fa-minus minusIcon"
                                                   style="display: none;"></i>
                                                <i class="fa-solid fa-plus plusIcon"
                                                   style="display: inline-block;"></i>
                                                <i class="fa-solid fa-users"></i>
                                                <h5 style="display: inline-block;" class="orgDep">${dep.dep_name}</h5>
                                            </c:if>
                                            <br>
                                            <!-- 사원리스트 시작 -->
                                            <div data-dep-name="${dep.dep_name}" class="orgPepleDiv">
                                                <c:forEach items="${list}" var="list">
                                                    <c:if test="${list.DEP_NAME eq dep.dep_name}">
                                                        <div class="orgPepleSpan"
                                                             style="display: inline-block; padding-left: 20px">
                                                            <i class="fa-solid fa-user"
                                                               style="display: inline-block;"></i>
                                                            <h6 style="display: inline-block;" class="orgAll"
                                                                data-emp-num="${list.EMPLOYEE_NUM}"
                                                                data-dep-name="${list.DEP_NAME}"
                                                                data-pp-name="${list.NAME }">${list.DEP_NAME}
                                                                    ${list.POS_NAME} ${list.NAME}</h6>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <!-- 사원 리스트 끝 -->
                                        </div>
                                    </c:forEach> <!-- 부서리스트 끝 -->
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- 조직도 끝 -->

                    </div>
                </div>
            </c:if>

            <!-- 임시저장이 아닐때 -->
            <c:if test="${draftmap.STATE ne 2}">
            <form action="/draft/setdetaildraft" method="post"
                  enctype="multipart/form-data">
                <div>
                    <h1 id="title">기안서</h1>
                </div>
                <!-- 기안서 제목 끝 -->

                <!--  결재선 편집버튼 시작 -->

                <!-- 결재선 편집버튼 끝 -->

                <!-- 결재선 시작 -->
                <div id="draftLine">
                    <div id="lineBtnDiv"
                         style="position: absolute; top: 15px; left: -50px; display: inline-block;">
                        <!-- 							<button type="button" id="lineBtn"
                        class="lineBtnDiv btn btn-google">
                        편<br>집<br>하<br>기
                    </button>
-->
                    </div>

                    <table border="1" id="allineTable">
                        <!-- 직급 tr 시작 -->
                        <tr id="input_grade">
                            <td rowspan="4">결재선</td>
                            <c:forEach items="${approvalar}" var="approvalar">
                                <c:if test="${approvalar.SIGN_RANK eq 0 }">
                                    <td>기안자</td>
                                </c:if>
                                <c:if test="${approvalar.SIGN_RANK ne 0}">
                                    <td>${approvalar.POS_NAME}</td>

                                </c:if>
                            </c:forEach>
                        </tr>
                        <!-- 직급 tr 끝 -->

                        <!-- 사인 tr 시작 -->
                        <tr id="input_blank">
                            <c:forEach items="${approvalar}" var="approvalar">
                                <!-- 반려가 아닐때 -->
                                <c:if test="${approvalar.SIGN_REF ne 1 }">
                                    <c:if
                                            test="${approvalar.SIGN_RANK < approvalar.NOW_APPROVAL }">
                                        <c:if test="${not empty approvalar.SIGN_FILE }">
                                            <td><img src="${approvalar.SIGN_FILE}" width="50px"
                                                     height="30px"></td>
                                        </c:if>
                                        <c:if test="${empty approvalar.SIGN_FILE }">
                                            <td>${approvalar.NAME }</td>
                                        </c:if>
                                    </c:if>
                                </c:if>
                                <!-- 반려일때 -->
                                <c:if test="${approvalar.SIGN_REF eq 1 }">
                                    <td style="color: red;">반려</td>
                                </c:if>


                                <c:if test="${approvalar.SIGN_REF ne 1 }">
                                    <c:if
                                            test="${approvalar.SIGN_RANK >= approvalar.NOW_APPROVAL }">
                                        <td></td>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                        </tr>
                        <!-- 사인 tr 끝 -->

                        <!-- 이름 tr 시작 -->
                        <tr id="input_name">
                            <c:forEach items="${approvalar }" var="approvalar">
                                <td>${approvalar.NAME}<input type="hidden"
                                                             value="${approvalar.EMPLOYEE_NUM}" name="SignEmp">
                                </td>
                            </c:forEach>
                        </tr>
                        <!-- 이름 tr 끝 -->

                        <!-- 날짜 tr 시작 -->
                        <tr>
                            <c:forEach items="${approvalar}" var="approvalar">
                                <!-- 반려아닐때 -->
                                <c:if test="${approvalar.SIGN_REF ne 1}">
                                    <c:if
                                            test="${approvalar.SIGN_RANK < approvalar.NOW_APPROVAL }">
                                        <td class="date">${approvalar.SIGN_DATE}</td>
                                    </c:if>
                                </c:if>
                                <!-- 반려일때 -->
                                <c:if test="${approvalar.SIGN_REF eq 1}">
                                    <td class="date" style="color: red;">${approvalar.SIGN_DATE}</td>
                                </c:if>

                                <c:if test="${approvalar.SIGN_REF ne 1 }">
                                    <c:if
                                            test="${approvalar.SIGN_RANK >= approvalar.NOW_APPROVAL }">
                                        <td class="date"></td>
                                    </c:if>
                                </c:if>

                            </c:forEach>
                        </tr>
                        <!-- 날짜 tr 끝 -->
                    </table>

                </div>

                <!-- 결재선 끝 -->

                <!-- 기안서양식 시작 -->
                <div id="basisDraft">
                    <table border="1">
                        <tr>
                            <td class="basisTitleTd">기안자</td>
                            <td class="basisTd"><input class="inp" type="text"
                                                       value="${draftmap.NAME}" readonly="readonly"> <input
                                    type="hidden" value="${draftmap.EMPLOYEE_NUM}"
                                    name="employee_num"></td>
                            <td class="basisTitleTd">소속부서</td>
                            <td class="basisTd"><input class="inp" type="text"
                                                       value="${draftmap.DEP_NAME}" readonly="readonly"></td>
                        </tr>

                        <tr>
                            <td class="basisTitleTd">기안일자</td>
                            <td class="basisTd"><input name="draft_date" class="inp"
                                                       type="text" value="${draftmap.DRAFT_DATE}" readonly="readonly">
                            </td>
                            <td class="basisTitleTd">문서번호</td>
                            <td class="basisTd"><input name="draft_num" class="inp"
                                                       type="text" value="${draftmap.DRAFT_NUM}" readonly="readonly">
                            </td>
                        </tr>

                        <tr>
                            <td class="basisTitleTd">제목</td>
                            <td class="basisTd"><input readonly="readonly"
                                                       name="title" value="${draftmap.TITLE}" class="inp" type="text">
                            </td>
                            <td class="basisTitleTd">참조</td>
                            <td class="basisTd"><input readonly="readonly" id="refInp"
                                                       class="inp" type="text" readonly="readonly" value="${refname}">
                                <input id="refempnum" type="hidden" class="inp"
                                       name="refempnum"></td>
                        </tr>

                        <tr style="height: 300px;">
                            <td class="basisTitleTd">내용</td>
                            <td class="basisTitleTd" colspan="4" style="text-align: left;">
										<textarea readonly="readonly" name="contents" class="inp"
                                                  name="contents" style="text-align: left;" rows=""
                                                  cols="">${draftmap.CONTENTS }</textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="basisTitleTd">첨부파일</td>
                            <c:forEach items="${filear}" var="filear">
                                <td class="basisTd" colspan="4">${filear.ori_name}<br></td>
                            </c:forEach>
                        </tr>

                    </table>
                    <!-- 파일 시작 -->
                    <input type="hidden" value="${draftmap.NOW_APPROVAL}"
                           name="now_approval">
                    <div>
                        <c:if test="${draftmap.STATE eq 3}">
                            <h4 style="color: blue;">결재완료된 기안서 입니다.</h4>
                        </c:if>

                        <c:if test="${draftmap.STATE ne 3 or draftmap.STATE ne 1}">
                            <!-- 반려아닐때 -->
                            <c:if test="${draftmap.STATE ne 1}">
                                <div id="btn"
                                     style="position: absolute; left: 900px; bottom: -40px;">
                                    <c:if
                                            test="${draftmap.NOW_APPROVAL eq 1 and draftmap.EMPLOYEE_NUM == employeeNum}">
                                        <button id="draftDeleteBtn" type="button"
                                                style="width: 90px" data-delete-emp="${draftmap.DRAFT_NUM}"
                                                class="btn btn-warning">삭제하기
                                        </button>
                                    </c:if>
                                </div>
                            </c:if>
                            <!-- 반려일때 -->
                            <c:if test="${draftmap.STATE eq 1}">
                                <div style="position: absolute; left: 400px; bottom: -40px;">
                                    <h4 style="color: red;">결재반려된 기안서 입니다.</h4>
                                </div>
                                <div id="btn"
                                     style="position: absolute; left: 900px; bottom: -40px;">
                                        <%-- 							<c:if
                                                                        test="${draftmap.NOW_APPROVAL eq 1 and draftmap.EMPLOYEE_NUM == employeeNum}">
                                                                        <button id="draftDeleteBtn" type="button"
                                                                            style="width: 90px" data-delete-emp="${draftmap.DRAFT_NUM}"
                                                                            class="btn btn-warning">삭제하기</button>
                                                                    </c:if> --%>
                                </div>
                            </c:if>
                            <c:if test="${draftmap.STATE ne 1}">
                                <c:if test="${employeeNum == nowemp }">
                                    <div id="updateBtn"
                                         style="position: absolute; left: -1px; bottom: -40px;">
                                        <button type="submit" name="state" value="0"
                                                style="width: 90px" data-delete-emp="${draftmap.DRAFT_NUM}"
                                                class="btn btn-primary">결재하기
                                        </button>
                                    </div>

                                    <input type="hidden" name="nowemp" value="${nowemp}">

                                    <div style="position: absolute; left: 900px; bottom: -40px;">
                                        <button type="submit" name="state" value="1"
                                                style="width: 90px" data-delete-emp="${draftmap.DRAFT_NUM}"
                                                class="btn btn-pinterest">반려하기
                                        </button>
                                    </div>
                                </c:if>
                            </c:if>
                        </c:if>
                        <!-- 반려일때 -->
                    </div>
                    <!-- 파일 끝 -->
                </div>
                <!-- 기안서양식 끝 -->
                <input type="hidden" value="0" name="draft_category">
                <!-- 버튼모음 시작 -->
            </form>
            <!-- 버튼모음 끝 -->

            <!-- 모달창 시작 -->
            <div id="modalBack" class="noshow">
                <div id="modal" class="noshow">
                    <!-- 셀렉트 시작 -->
                    <div id="selectDiv">
                        <select id="select">
                            <option>자주쓰는결재선</option>
                            <c:forEach items="${allist}" var="allist">
                                <option value="${allist.approval_line_code}">${allist.line_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- 셀렉트 끝 -->

                    <!-- 제목 시작 -->
                    <div id="draftLineTitle">
                        <h3>결재선 설정</h3>
                    </div>
                    <!-- 제목 끝 -->

                    <!-- 결재선 제목 시작 -->
                    <div id="draftTitle">
                        <h4>결재선</h4>
                    </div>
                    <!-- 결재선 제목 끝 -->

                    <!-- 결재선 버튼 시작 -->
                    <div id="draftBtnDiv">
                        <i id="draftBtnMinus"
                           class="fa-solid fa-square-caret-left fa-2x"
                           style="display: inline-block;"></i>
                        <h3 style="display: inline-block;">결재</h3>
                        <i id="draftBtnPlus"
                           class="fa-solid fa-square-caret-right fa-2x"
                           style="display: inline-block;"></i>
                    </div>
                    <!-- 결재선 버튼 끝 -->

                    <!-- 참조 버튼 시작 -->
                    <div id="refBtn">
                        <i id="refMinusBtn" class="fa-solid fa-square-caret-left fa-2x"></i>
                        <h3 style="display: inline-block;">참조</h3>
                        <i id="refPlusBtn" class="fa-solid fa-square-caret-right fa-2x"
                           style="display: inline-block;"></i>
                    </div>
                    <!-- 참조 버튼 끝 -->

                    <!-- 결재선 박스 시작 -->
                    <div id="draftBox">
                        <table border="1">
                            <tr style="height: 140px;" id="draftBoxTr">
                                <td style="width: 200px; vertical-align: top;" id="draftBoxTd">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!-- 결재선 박스 끝 -->
                    <!-- 참조 제목 시작 -->
                    <div id="refTitle">
                        <h4>참조</h4>
                    </div>
                    <!-- 참조 제목 시작 -->

                    <!-- 참조 박스 시작 -->

                    <div id="refBox">
                        <table border="1">
                            <tr style="height: 140px">
                                <td style="width: 200px; vertical-align: top;" id="refBoxTd"></td>
                            </tr>
                        </table>
                    </div>
                    <!-- 닫기 버튼 시작 -->
                    <div id="modalCloseBtn">
                        <span class="close">&times;</span>
                    </div>
                    <!-- 닫기 버튼 끝 -->

                    <!-- 등록 버튼 시작 -->
                    <div id="modalCreateBtnDiv">
                        <button id="modalCreateBtn">등록</button>
                    </div>
                    <!-- 등록 버튼 끝 -->

                    <!-- 초기화 버튼 시작 -->
                    <div id="modalResetBtn">
                        <button>초기화</button>
                    </div>
                    <!-- 초기화 버튼 끝 -->

                    <!-- 결재선 저장 타이틀 -->
                    <div id="approvalDiv">
                        <input type="text" placeholder="결재선 이름 입력" style="width: 120px;"
                               id="approvalInpName">
                        <button id="approvalBtn" type="button"
                                style="display: inline-block;">저장
                        </button>
                    </div>
                    <!-- 결재선 저장 타이틀 -->

                    <!-- 조직도 제목 시작 -->
                    <div id="orgTitle">
                        <h4>조직도</h4>
                    </div>
                    <!-- 조직도 제목 끝-->

                    <!-- 조직도 시작 -->
                    <div id="orgDiv">
                        <table border="1">
                            <tr style="height: 380px;">
                                <td style="width: 200px; vertical-align: top;" id="orgBoxTd">
                                    <!-- 부서 리스트 시작-->
                                    <c:forEach items="${dep}" var="dep">
                                        <div class="orgTeamDiv">
                                            <c:if test="${dep.dep_name ne '사장'}">
                                                <i class="fa-solid fa-minus minusIcon"
                                                   style="display: none;"></i>
                                                <i class="fa-solid fa-plus plusIcon"
                                                   style="display: inline-block;"></i>
                                                <i class="fa-solid fa-users"></i>
                                                <h5 style="display: inline-block;" class="orgDep">${dep.dep_name}</h5>
                                            </c:if>
                                            <br>
                                            <!-- 사원리스트 시작 -->
                                            <div data-dep-name="${dep.dep_name}" class="orgPepleDiv">
                                                <c:forEach items="${list}" var="list">
                                                    <c:if test="${list.DEP_NAME eq dep.dep_name}">
                                                        <div class="orgPepleSpan"
                                                             style="display: inline-block; padding-left: 20px">
                                                            <i class="fa-solid fa-user"
                                                               style="display: inline-block;"></i>
                                                            <h6 style="display: inline-block;" class="orgAll"
                                                                data-emp-num="${list.EMPLOYEE_NUM}"
                                                                data-dep-name="${list.DEP_NAME}"
                                                                data-pp-name="${list.NAME }">${list.DEP_NAME}
                                                                    ${list.POS_NAME} ${list.NAME}</h6>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <!-- 사원 리스트 끝 -->
                                        </div>
                                    </c:forEach>
                                    <!-- 부서리스트 끝 -->
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- 조직도 끝 -->

                </div>
                </c:if>
            </div>
            <!-- 모달창 끝 -->
        </div>
        <!--**********************************
            Content body end
        ***********************************-->


        <!--**********************************
            Footer start
        ***********************************-->
    </div>
    <c:import url="../temp/footer.jsp"></c:import>
    <!--**********************************
            Footer end
        ***********************************-->

    <!--**********************************
           Support ticket button start
        ***********************************-->

    <!--**********************************
           Support ticket button end
        ***********************************-->


    <%-- 			<!-- 부서 리스트 시작-->
                                        <c:forEach items="${dep}"
                                            var="dep">
                                            <div class="orgTeamDiv">
                                                    <c:if test="${dep.dep_name ne '사장'}">
                                                <i class="fa-solid fa-minus minusIcon" style="display: none;"></i> <i
                                                    class="fa-solid fa-plus plusIcon"
                                                    style="display: inline-block;"></i> <i
                                                    class="fa-solid fa-users"></i>
                                                <h5 style="display: inline-block;" class="orgDep">${dep.dep_name}</h5>
                                                </c:if>
                                                <br>
                                                <!-- 사원리스트 시작 -->
                                             <div data-dep-name="${dep.dep_name}" class="orgPepleDiv">
                                                <c:forEach items="${list}" var="list">
                                                <c:if test="${list.DEP_NAME eq dep.dep_name}">
                                                <div class="orgPepleSpan"
                                                    style="display: inline-block; padding-left: 20px">
                                                    <i class="fa-solid fa-user" style="display: inline-block;"></i>
                                                    <h6 style="display: inline-block;" class="orgAll" data-dep-name="${list.DEP_NAME}">${list.DEP_NAME} ${list.POS_NAME} ${list.NAME}</h6>
                                                </div>
                                            </c:if>
                                            </c:forEach>
                                            </div>
                                            <!-- 사원 리스트 끝 -->
                                        </div>
                                        </c:forEach>
                                        <!-- 부서리스트 끝 -->  --%>


    <!-- ////////////////////////////////////////////// -->


    <%-- 									<c:forEach items="${depHighAr}" var="dephighar">
                                    <div class="orgHighTeamDiv">
                                        <i class="fa-solid fa-minus highMinusIcon" style="display: none;"></i> <i
                                                class="fa-solid fa-plus highPlusIcon"
                                                style="display: inline-block;"></i> <i
                                                class="fa-solid fa-users"></i>
                                            <h5 style="display: inline-block;" class="orgDep">${dephighar.dep_name}</h5>
                                            <br>
                                    <!-- 부서 리스트 시작-->
                                        <div class="orgTeamBigDiv">
                                        <c:forEach items="${dep}"
                                            var="dep">
                                            <c:if test="${dep.upper_dep_code eq dephighar.dep_code }">
                                            <div class="orgTeamDiv">
                                                <i class="fa-solid fa-minus minusIcon" style="display: none;"></i> <i
                                                    class="fa-solid fa-plus plusIcon"
                                                    style="display: inline-block;"></i> <i
                                                    class="fa-solid fa-users"></i>
                                                <h5 style="display: inline-block;" class="orgDep">${dep.dep_name}</h5>
                                                <br>
                                                </c:if>
                                                <!-- 사원리스트 시작 -->
                                             <div data-dep-name="${dep.dep_name}" class="orgPepleDiv">
                                                <c:forEach items="${list}" var="list">
                                                <c:if test="${list.DEP_NAME eq dep.dep_name}">
                                                <div class="orgPepleSpan"
                                                    style="display: inline-block; padding-left: 20px">
                                                    <i class="fa-solid fa-user" style="display: inline-block;"></i>
                                                    <h6 style="display: inline-block;" class="orgAll" data-dep-name="${list.DEP_NAME}">${list.DEP_NAME} ${list.POS_NAME} ${list.NAME}</h6>
                                                </div>
                                            </c:if>
                                            </c:forEach>
                                            </div>
                                            <!-- 사원 리스트 끝 -->
                                        </div>
                                        </c:forEach>
                                        </div>
                                        <!-- 부서리스트 끝 -->

                                        </div>
                                        </c:forEach> --%>

    <!--**********************************
        Main wrapper end
    ***********************************-->


    <!--**********************************
        Scripts
    ***********************************-->
    <!-- Required vendors -->
    <script src="https://kit.fontawesome.com/17a98cc585.js"
            crossorigin="anonymous"></script>
    <c:import url="../temp/js.jsp"></c:import>

    <script src="/bugclean/js/draft/basisdraftorg.js"></script>
    <script src="/bugclean/js/draft/basisdraftmodal.js"></script>
</body>