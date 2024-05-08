<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .quixnav {
        z-index: 115;
    }
</style>
<div class="quixnav">
    <div class="quixnav-scroll">
        <ul class="metismenu" id="menu">
            <li class="nav-label first">Main Menu</li>
            <li><a class="has-arrow" href="javascript:void()"
                   aria-expanded="false"><i class="icon icon-app-store"></i><span
                    class="nav-text">게시판</span></a>
                <ul aria-expanded="false">
                    <c:if test="${sessionScope.name ne null}">
                        <c:forEach var="index" begin="0" end="${fn:length(sessionScope.name)-1}" varStatus="loop">
                            <c:set var="category" value="${sessionScope.name[index]}"/>
                            <c:set var="categoryCode" value="${sessionScope.code[index]}"/>
                            <li><a href="/board?cate_code=${categoryCode}">${category}</a></li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${sessionScope.name eq null}">
                        <li><a href="/board?cate_code=1">공지사항</a></li>
                    </c:if>
                </ul>
            </li>


            <li class="nav-label">Team Menu</li>
            <li><a class="has-arrow" href="javascript:void()"
                   aria-expanded="false"><i class="icon icon-app-store"></i><span
                    class="nav-text">인사팀</span></a>
                <ul aria-expanded="false">
                    <li><a href="/hr/temp/list">가입승인</a></li>
                    <li><a href="/hr/member">사원관리</a></li>
                    <li><a href="/hr/vacation">연차관리</a></li>
                    <li><a href="/hr/salary">급여관리</a></li>
                    <li><a href="/hr/attendance">근태관리</a></li>
                </ul>
            </li>

            <li><a class="has-arrow" href="javascript:void()"
                   aria-expanded="false"><i class="icon icon-app-store"></i><span
                    class="nav-text">총무팀</span></a>
                <ul aria-expanded="false">
                    <li><a href="/general/property">자산관리</a></li>
                    <li><a href="/focus-bootstrap-main/theme/app-profile.html">구매요청서</a></li>
                    <li><a href="/general/carManage">배차관리</a></li>
                    <li><a href="/focus-bootstrap-main/theme/app-profile.html">수익관리</a></li>
                </ul>
            </li>

            <li><a class="has-arrow" href="javascript:void()"
                   aria-expanded="false"><i class="icon icon-app-store"></i><span
                    class="nav-text">영업팀</span></a>
                <ul aria-expanded="false">
                    <li><a href="/customer/sales_list">거래처관리</a></li>
                    <li><a href="/schedule/sales_list">현장일정관리</a></li>
                    <li><a href="/chart/main">매출관리</a></li>

                </ul>
            </li>

            <li><a class="has-arrow" href="javascript:void()"
                   aria-expanded="false"><i class="icon icon-app-store"></i><span
                    class="nav-text">현장팀</span></a>
                <ul aria-expanded="false">
                    <li><a href="/schedule/list">현장일정관리</a></li>
                    <li><a href="/customer/list">거래처관리</a></li>
                </ul>
            </li>
            <li class="nav-label">DRAFT MENU</li>
            <li><a class="has-arrow" href="javascript:void()"
                   aria-expanded="false"><i class="icon icon-app-store"></i><span
                    class="nav-text">전자결재</span></a>
                <ul aria-expanded="false">
                    <li><a class="has-arrow" href="javascript:void()"
                           aria-expanded="false"><i class="icon icon-app-store"></i><span
                            class="nav-text">문서함</span></a>
                        <ul aria-expanded="false">
                            <li><a href="../draft/draftlist">작성하기</a></li>
                            <li><a href="../draft/mydraftlist">내기안문서</a></li>
                            <li><a href="../draft/myapprovinglist">결재중문서</a></li>
                            <li><a href="/draft/myapprovedlist">결재완료문서</a></li>
                            <li><a href="/draft/myrejectiondraftlist">반려문서</a></li>
                            <li><a href="/draft/mytemporarylist">임시저장문서</a></li>
                        </ul>
                    <li><a class="has-arrow" href="/employee/inbox"
                           aria-expanded="false"><i class="icon icon-app-store"></i><span
                            class="nav-text">수신문서함</span></a>
                        <ul>
                            <li><a href="/receive/inbox">수신문서함</a></li>
                        </ul>
                    </li>
                </ul>
            </li>

        </ul>
    </div>


</div>