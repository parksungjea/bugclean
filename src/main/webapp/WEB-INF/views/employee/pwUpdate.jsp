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
                        <h4>비밀번호 변경</h4>
                        <p class="mb-1">8~16자 영문자, 숫자, 특수문자</p>
                    </div>
                </div>
               
            </div>
            <!-- row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"></h4>
                        </div>
                        <div class="card-body">


                            <div class="form-validation">
                                <form class="form-valide" action="#" method="post" novalidate="novalidate">
                                    <div class="row">
                                        <div class="col-xl-12">
                                            <form:form modelAttribute="employeeVO">
                                            
                                                <sec:authentication property="principal" var="employeeVO"/>
                                                <form:input path="username" value="${employeeVO.username}" hidden="true"></form:input>
                                                

                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="val-username">현재 비밀번호 <span class="text-danger">*</span></label>
                                                    <div class="col-lg-6">
                                                        <form:password path="password" cssClass="form-control" id="password"></form:password>
                                                    </div>
                                                    
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="val-email">새 비밀번호<span class="text-danger">*</span></label>
                                                    <div class="col-lg-6">
                                                        <form:password path="newPassword" cssClass="form-control input-rounded" id="newPassword"></form:password>
                                                    </div>
                                                    
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="val-password">새 비밀번호 확인<span class="text-danger">*</span></label>
                                                    <div class="col-lg-6">
                                                        <form:password path="passwordCheck" cssClass="form-control input-rounded" id="passwordCheck"></form:password>
                                                    </div>
                                                    
                                                </div>

                                                <form:errors path="password" style="color: red;"></form:errors></br>
                                                <form:errors path="newPassword" style="color: red;"></form:errors></br>
                                                <form:errors path="passwordCheck" style="color: red;"></form:errors>
                                                

                                                <button type="submit" class="btn btn-primary" id="pwBtn">변경</button>
                                                

                                            </form:form>
                                        </div>
                                    </div>
                                </form>
                            </div>


                            
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <script>
            const pwBtn = document.getElementById("pwBtn");

            pwBtn.addEventListener("click",function(e){
                    //공백시
                    if(document.getElementById("password").value === ''){

                        alert('비밀번호를 입력하세요.');
                        e.preventDefault();
                        return false;
                    }else if(document.getElementById("newPassword").value === ''){
                        alert('새 비밀번호를 입력하세요.');
                        e.preventDefault();
                        return false;
                    }else if(document.getElementById("passwordCheck").value === ''){
                        alert('새 비밀번호 확인을 입력하세요.');
                        e.preventDefault();
                        return false;
                    }

                    return false;

            })




        </script>
    <c:import url="../temp/messenger.jsp"></c:import>
    </div>

</div>
    <c:import url="../temp/footer.jsp"></c:import> <!-- //footer -->
<c:import url="../temp/js.jsp"></c:import> <!-- // bootstrap-template-js -->
</body>
</html>
