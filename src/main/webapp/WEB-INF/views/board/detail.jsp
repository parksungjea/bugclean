<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header row">
                <!-- 제목 입력 -->
                <div class="col-6 media-body">
                    <h4 class="text-primary" data-board="${board.BOARD_NUM}">${board.BOARD_TITLE}</h4>
                    <p class="mb-0">${board.BOARD_DATE}</p>
                </div>
                <!-- 작성자 표기 -->
                <div class="col-6 d-flex justify-content-end">
                    <span class="mt-2">작성자 :</span>
                    <h5 class="text-dark mt-2 mr-2">&nbsp${board.NAME}</h5>
                </div>
            </div>
            <hr>
            <div class="card-body text-dark">
                <div id="board_contents">
                    ${board.BOARD_CONTENTS}
                </div>
                <hr>
                <span class="text-primary">첨부파일</span>
                <div class="text-secondary d-flex justify-content-between">
                    <c:forEach items="${board.fileVOs}" var="file">
                        <a href="/board/download?file_code=${file.file_code}">${file.origin_name}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="card-footer d-flex justify-content-end">
    <div>
        <button id="list-btn" type="button" class="btn btn-primary">목록보기</button>
        <sec:authentication property="principal" var="employee"/>
        <c:if test="${employee.employee_num eq board.EMPLOYEE_NUM}">
            <button id="update-btn" type="button" class="btn btn-primary">수정하기</button>
        </c:if>
    </div>
</div>
