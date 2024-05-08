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

<body>
<div id="preloader">
    <div class="sk-three-bounce">
        <div class="sk-child sk-bounce1"></div>
        <div class="sk-child sk-bounce2"></div>
        <div class="sk-child sk-bounce3"></div>
    </div>
</div>
<div id="main-wrapper">

    <c:import url="../temp/header.jsp"></c:import> <!-- //nav-header -->
    <c:import url="../temp/sidebar.jsp"></c:import> <!-- //sidebar-menu -->

    <div class="content-body " style="min-height:900px;">
        <div class="container-fluid">
            <div class="row page-titles mx-0">
                <div class="col-sm-6 p-md-0">
                    <div class="welcome-text">
                        <h4 style="font-weight: bolder;">&ensp; 수신문서함</h4>
                    </div>
                </div>
                <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item active">문서함</li>
                        <li class="breadcrumb-item active"><a href="./">Inbox</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->


            <div class="row">
                
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title" style="font-weight: bold;">문서 목록</h4>
                        </div>

                        <div class="card-body">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="nav-all" data-toggle="tab" href="#all8">
                                        <span>
                                            전체
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-wait" data-toggle="tab" href="#wait8">
                                        <span>
                                            대기
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-ing" data-toggle="tab" href="#ing8">
                                        <span>
                                            진행
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-com" data-toggle="tab" href="#done8">
                                        <span>
                                            완료
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="nav-ref" data-toggle="tab" href="#refer8">
                                        <span>
                                            참조
                                        </span>
                                    </a>
                                </li>


                                <div class="col-auto d-flex justify-content-end ml-auto">
                                    <form class="row g-3" action="./inbox">
                                        <div class="input-group input-group-sm" style="height: 28.4px;">
                                            <div class="input-group-prepend">
                                                <select name="kind" id="kind" style="font-size: 12px; border-color: #eaeaea">
                                                    <option value="kind1" id="all">전체</option>
                                                    <option value="kind2" id="wait">대기</option>
                                                    <option value="kind3" id="ing">진행</option>
                                                    <option value="kind4" id="done">완료</option>
                                                    <option value="kind5" id="refer">참조</option>
                                                </select>
                                            </div>
                                            <input name="search" type="text" class="form-control" style="width: 50%; border-color: #eaeaea">

                                            <div class="input-group-append">
                                                <button type="submit" id="search-btn" class="btn btn-primary">검색</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>



                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content tabcontent-border">

                                <!-- 전체 -->
                                <div class="tab-pane fade active show" id="all8" role="tabpanel">
                                    
                                    <table class="table header-border table-hover verticle-middle">
                                        <thead>
                                            <tr>
                                                <th class="col-2" style="text-align: center;">문서번호</th>
                                                <th class="col-5" style="text-align: center;">제목</th>
                                                <th class="col-2" style="text-align: center;">기안자</th>
                                                <th class="col-3" style="text-align: center;">기안날짜</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${allList.getAllList}" var="all">

                                            
                                                <tr style="text-align: center;">
                                                    <th>${all.DRAFT_NUM}</th>
                                                    <td ><a href="/draft/getdraftdetail?draft_num=${all.DRAFT_NUM}" style="font-weight: bold;">${all.TITLE}</a></td>
                                                    <td>${all.NAME}</td>
                                                    <td>${all.DRAFT_DATE}</td>
                                                </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                    
                                    <nav>
                                        <ul class="pagination pagination-xs" style="justify-content: center;">
                                            
                                            <c:if test="${!allList.pager.start}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${allList.pager.startNum-1}&search=${allList.pager.search}&kind=${allList.pager.kind}">
                                                        <i class="icon-arrow-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="${allList.pager.startNum}" end="${allList.pager.lastNum}" var="i">
                                                <li class="page-item"><a class="page-link" href="./inbox?page=${i}&search=${allList.pager.search}&kind=${allList.pager.kind}">${i}</a></li>
                                            </c:forEach>

                                            <c:if test="${!allList.pager.last}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${allList.pager.lastNum+1}&search=${allList.pager.search}&kind=${allList.pager.kind}">
                                                        <i class="icon-arrow-right"></i></a>
                                                </li>
                                            </c:if>

                                        </ul>
                                    </nav>
                                    
                                </div>

                                <!-- 대기 -->
                                <div class="tab-pane fade" id="wait8" role="tabpanel">
                                    <table class="table header-border table-hover verticle-middle">
                                        <thead>
                                            <tr>
                                                <th class="col-2" style="text-align: center;">문서번호</th>
                                                <th class="col-5" style="text-align: center;">제목</th>
                                                <th class="col-2" style="text-align: center;">기안자</th>
                                                <th class="col-3" style="text-align: center;">기안날짜</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${waitList.getWaitList}" var="wait">

                                            
                                                <tr style="text-align: center;">
                                                    <th>${wait.DRAFT_NUM}</th>
                                                    <td ><a href="/draft/getdraftdetail?draft_num=${wait.DRAFT_NUM}" style="font-weight: bold;">${wait.TITLE}</a></td>
                                                    <td>${wait.NAME}</td>
                                                    <td>${wait.DRAFT_DATE}</td>
                                                </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>

                                    <nav>
                                        <ul class="pagination pagination-xs" style="justify-content: center;">

                                            <c:if test="${!waitList.pager.start}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${waitList.pager.startNum-1}&search=${waitList.pager.search}&kind=${waitList.pager.kind}">
                                                        <i class="icon-arrow-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="${waitList.pager.startNum}" end="${waitList.pager.lastNum}" var="i">
                                                <li class="page-item"><a class="page-link" href="./inbox?page=${i}&search=${waitList.pager.search}&kind=${waitList.pager.kind}">${i}</a></li>
                                            </c:forEach>

                                            <c:if test="${!waitList.pager.last}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${waitList.pager.lastNum+1}&search=${waitList.pager.search}&kind=${waitList.pager.kind}">
                                                        <i class="icon-arrow-right"></i></a>
                                                </li>
                                            </c:if>

                                        </ul>
                                    </nav>
                                </div>

                                <!-- 진행 -->
                                <div class="tab-pane fade" id="ing8" role="tabpanel">

                                    <table class="table header-border table-hover verticle-middle">
                                        <thead>
                                            <tr>
                                                <th class="col-2" style="text-align: center;">문서번호</th>
                                                <th class="col-5" style="text-align: center;">제목</th>
                                                <th class="col-2" style="text-align: center;">기안자</th>
                                                <th class="col-3" style="text-align: center;">기안날짜</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${progressList.getProgressList}" var="progress">

                                            
                                                <tr style="text-align: center;">
                                                    <th>${progress.DRAFT_NUM}</th>
                                                    <td ><a href="/draft/getdraftdetail?draft_num=${progress.DRAFT_NUM}" style="font-weight: bold;">${progress.TITLE}</a></td>
                                                    <td>${progress.NAME}</td>
                                                    <td>${progress.DRAFT_DATE}</td>
                                                </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>

                                    
                                    <nav>
                                        <ul class="pagination pagination-xs" style="justify-content: center;">

                                            <c:if test="${!progressList.pager.start}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${progressList.pager.startNum-1}&search=${progressList.pager.search}&kind=${progressList.pager.kind}">
                                                        <i class="icon-arrow-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="${progressList.pager.startNum}" end="${progressList.pager.lastNum}" var="i">
                                                <li class="page-item"><a class="page-link" href="./inbox?page=${i}&search=${progressList.pager.search}&kind=${progressList.pager.kind}">${i}</a></li>
                                            </c:forEach>

                                            <c:if test="${!progressList.pager.last}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${progressList.pager.lastNum+1}&search=${progressList.pager.search}&kind=${progressList.pager.kind}">
                                                        <i class="icon-arrow-right"></i></a>
                                                </li>
                                            </c:if>

                                        </ul>
                                    </nav>

                                </div>
                                <!-- 완료 -->
                                <div class="tab-pane fade" id="done8" role="tabpanel">
                                    <table class="table header-border table-hover verticle-middle">
                                        <thead>
                                            <tr>
                                                <th class="col-2" style="text-align: center;">문서번호</th>
                                                <th class="col-5" style="text-align: center;">제목</th>
                                                <th class="col-2" style="text-align: center;">기안자</th>
                                                <th class="col-2" style="text-align: center;">기안날짜</th>
                                                <th class="col-1" style="text-align: center;">상태</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${doneList.getDoneList}" var="done">

                                            
                                                <tr style="text-align: center;">
                                                    <th>${done.DRAFT_NUM}</th>
                                                    <td ><a href="/draft/getdraftdetail?draft_num=${done.DRAFT_NUM}" style="font-weight: bold;">${done.TITLE}</a></td>
                                                    <td>${done.NAME}</td>
                                                    <td>${done.DRAFT_DATE}</td>

                                                    <c:if test="${done.STATE eq 3}">
                                                        <td><span class="badge badge-success" style="color: white;">완료</span></td>
                                                    </c:if>
                                                    <c:if test="${done.STATE eq 1}">
                                                        <td><span class="badge badge-danger">반려</span></td>
                                                    </c:if>
                                                    

                                                </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>


                                    <nav>
                                        <ul class="pagination pagination-xs" style="justify-content: center;">


                                            <c:if test="${!doneList.pager.start}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${doneList.pager.startNum-1}&search=${doneList.pager.search}&kind=${doneList.pager.kind}">
                                                        <i class="icon-arrow-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="${doneList.pager.startNum}" end="${doneList.pager.lastNum}" var="i">
                                                <li class="page-item"><a class="page-link" href="./inbox?page=${i}&search=${doneList.pager.search}&kind=${doneList.pager.kind}">${i}</a></li>
                                            </c:forEach>

                                            <c:if test="${!doneList.pager.last}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${doneList.pager.lastNum+1}&search=${doneList.pager.search}&kind=${doneList.pager.kind}">
                                                        <i class="icon-arrow-right"></i></a>
                                                </li>
                                            </c:if>

                                        </ul>
                                    </nav>
                                </div>


                                <!-- 참조 -->
                                <div class="tab-pane fade" id="refer8" role="tabpanel">
                                    <table class="table header-border table-hover verticle-middle">
                                        <thead>
                                            <tr>
                                                <th class="col-2" style="text-align: center;">문서번호</th>
                                                <th class="col-5" style="text-align: center;">제목</th>
                                                <th class="col-2" style="text-align: center;">기안자</th>
                                                <th class="col-3" style="text-align: center;">기안날짜</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${referList.getReferList}" var="refer">

                                            
                                                <tr style="text-align: center;">
                                                    <th>${refer.DRAFT_NUM}</th>
                                                    <td ><a href="/draft/getdraftdetail?draft_num=${refer.DRAFT_NUM}" style="font-weight: bold;">${refer.TITLE}</a></td>
                                                    <td>${refer.NAME}</td>
                                                    <td>${refer.DRAFT_DATE}</td>
                                                </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>

                                    <nav>
                                        <ul class="pagination pagination-xs" style="justify-content: center;">

                                            <c:if test="${!referList.pager.start}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${referList.pager.startNum-1}&search=${referList.pager.search}&kind=${referList.pager.kind}">
                                                        <i class="icon-arrow-left"></i></a>
                                                </li>
                                            </c:if>

                                            <c:forEach begin="${referList.pager.startNum}" end="${referList.pager.lastNum}" var="i">
                                                <li class="page-item"><a class="page-link" href="./inbox?page=${i}&search=${referList.pager.search}&kind=${referList.pager.kind}">${i}</a></li>
                                            </c:forEach>

                                            <c:if test="${!referList.pager.last}">
                                                <li class="page-item page-indicator">
                                                    <a class="page-link" href="./list?page=${referList.pager.lastNum+1}&search=${referList.pager.search}&kind=${referList.pager.kind}">
                                                        <i class="icon-arrow-right"></i></a>
                                                </li>
                                            </c:if>

                                        </ul>
                                    </nav>
                                </div>



                            </div>
                        </div>



                        
                    </div>
                </div>

            </div>



        </div>
    
    <c:import url="../temp/messenger.jsp"></c:import>
    </div>

</div>

<c:import url="../temp/footer.jsp"></c:import> <!-- //footer -->
<c:import url="../temp/js.jsp"></c:import> <!-- // bootstrap-template-js -->


</body>

<script>
    let kind =`${referList.pager.kind}`;
    
    if(kind=="kind1"){
        document.getElementById("nav-all").click()
    }else if(kind=="kind2"){
        document.getElementById("nav-wait").click()
    }else if(kind=="kind3"){
        document.getElementById("nav-ing").click()
    }else if(kind=="kind4"){
        document.getElementById("nav-com").click()
    }else if(kind=="kind5"){
        document.getElementById("nav-ref").click()
    }
    
    
    if(kind == ""){
        kind=1;
    }
    kind = parseInt(kind.substring(4,5)) ;
  
    document.getElementById("kind").selectedIndex = kind-1


</script>
</html>