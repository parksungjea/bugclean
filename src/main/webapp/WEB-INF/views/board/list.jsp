<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<div class="default-tab">
    <ul id="board-tabs" class="nav nav-tabs" role="tablist">
        <c:forEach var="index" begin="0" end="${fn:length(name) - 1}" varStatus="loop">
            <li class="nav-item">
                <a class="nav-link${active == code[index] ? ' active' : ''}"
                   data-toggle="tab" data-source="${code[index]}"
                   href="#list-${code[index]}">${name[index]}</a>
            </li>
        </c:forEach>
        <div class="col-auto d-flex justify-content-end ml-auto">
            <div class="input-group input-group-sm">
                <div class="input-group-prepend">
                    <select id="kind" style="font-size: 12px; border-color: #eaeaea">
                        <option value="1">제목</option>
                        <option value="2">작성자</option>
                    </select>
                </div>
                <input id="search" type="text" class="form-control"
                       style="width: 50%; border-color: #eaeaea"/>
                <div class="input-group-append">
                    <button id="search-btn" class="btn btn-primary">검색</button>
                </div>
            </div>
        </div>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade show active" id="list-1" role="tabpanel">
            <div class="pt-4">
                <div class="table-responsive">
                    <table class="table-responsive-sm table table-hover align-text-center">
                        <thead>
                        <tr>
                            <th>
                                글번호
                            </th>
                            <th>
                                글제목
                            </th>
                            <th>
                                작성자
                            </th>
                            <th>
                                작성일시
                            </th>
                            <th>
                                조회수
                            </th>
                        </tr>
                        </thead>
                        <tbody class="board-body">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="list-2">
            <div class="pt-4">
                <div class="table-responsive">
                    <table class="table-responsive-sm table table-hover align-text-center">
                        <thead>
                        <tr>
                            <th>
                                글번호
                            </th>
                            <th>
                                글제목
                            </th>
                            <th>
                                작성자
                            </th>
                            <th>
                                작성일시
                            </th>
                            <th>
                                조회수
                            </th>
                        </tr>
                        </thead>
                        <tbody class="board-body">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="d-flex justify-content-between">
    <div class="col-4">
    </div>
    <nav>
        <ul class="pagination pagination-xs">
            <li class="page-item page-indicator">
                <a class="page-link">
                    <i class="icon-arrow-left"></i>
                </a>
            </li>
            <li class="page-item active">
                <a class="page-link">1</a>
            </li>
            <li class="page-item">
                <a class="page-link">2</a>
            </li>
            <li class="page-item">
                <a class="page-link">3</a>
            </li>
            <li class="page-item">
                <a class="page-link">4</a>
            </li>
            <li class="page-item">
                <a class="page-link">5</a>
            </li>
            <li class="page-item page-indicator">
                <a class="page-link">
                    <i class="icon-arrow-right"></i>
                </a>
            </li>
        </ul>
    </nav>
    <div class="col-4 d-flex justify-content-end">
        <button id="create-board" class="btn btn-xs btn-primary">글작성</button>
    </div>
</div>
