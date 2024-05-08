<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>BUGCLEAN</title>
	<link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
<link rel="stylesheet" href="/bugclean/css/scheduleList.css">
</head>
<c:import url="../temp/css.jsp"></c:import>
<!-- //bootstrap-template-css -->
<body>
	<div id="preloader">
		<div class="sk-three-bounce">
			<div class="sk-child sk-bounce1"></div>
			<div class="sk-child sk-bounce2"></div>
			<div class="sk-child sk-bounce3"></div>
		</div>
	</div>
	<div id="main-wrapper">

		<c:import url="../temp/header.jsp"></c:import>
		<!-- //nav-header -->
		<c:import url="../temp/sidebar.jsp"></c:import>
		<!-- //sidebar-menu -->

		<div class="content-body " style="min-height: 900px;">
			<div class="container-fluid">
				<div class="row page-titles mx-0">
					<div class="col-sm-6 p-md-0">
						<div class="welcome-text">
							<h4 style="font-weight: bolder;">현장일정 관리</h4>
						</div>
					</div>
					<div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item active">현장일정 관리</li>
						</ol>
					</div>
				</div>
			<div id="sch_Color">	
				<span style="color:black">&#x25CF; :  일반</span>
				<span style="color : blue; padding-left: 2ch;">&#x25CF; : 완료</span>
				<span style="color : red; padding-left: 2ch;">&#x25CF; : 긴급</span>
				<span style="color: grey; padding-left: 2ch;">&#x25CF; :</span> <span style="text-decoration: line-through; "> 취소</span>
				<span style="color : green; padding-left: 2ch;">&#x25CF; : 배차 신청중</span>
				<span style="color : orange; padding-left: 2ch;">&#x25CF; : 배차 신청완료</span>
				<div id = "sch_Filter" class="dataTbles_filter">
					<label id="sch_Filter_Label" for="sch_Filter_Input">Search : </label>
					<input id= "sch_Filter_Input" type="text" onkeypress="filter_name(event)">
				</div>
			</div>
			<div id='calendar'></div>


			<!-- 모달 창 -->
			<div id="myModal" class="modal">
				<div class="modal-content">
					<span class="close" onclick="closeModal()">&times;</span>
					<div id="title_div">
						<h2 id="modal-title"></h2>
					</div>
					<p id="modal-content"></p>
						<div class="input-group flex-nowrap mt-2">
							<input id="radioBase" type="radio" name="type" value="일반" class="inputRadio">
							<label for="radioBase">일반</label>
							<input id="radioEmer" type="radio" name="type" value="긴급" class="inputRadio">
							<label for="radioEmer">긴급</label>
						</div>
						<div class="input-group flex-nowrap mt-2">
							<span class="input-group-text" id="customer_Name">거래처명</span>
							<input id="inputTitle" type="hidden" class="form-control" placeholder="거래처명을 입력하세요." >
							<select id="inputSelectCustomerName" class="emp_choice">
								<option class="base_selected" id="emp_choice_base" value="" >거래처 선택</option>
							<c:forEach items="${customerList}" var="li">
								<option class="emp_choice_value" value="${li.customer_Num}">${li.business_Name} ${li.ceo_Name}</option>
							</c:forEach>	
						</select>
					  	</div>
					  	<div class="input-group flex-nowrap mt-2">
							<span class="input-group-text" id="manager_Name">영업 담당자명</span>
							<input id="inputSales" type="hidden" class="form-control" placeholder="담당자를 선택하세요." >
							<select id="inputSelect" class="emp_choice">
									<option class="base_selected" id="salse_choice_base" value="" >담당자 선택</option>
								<c:forEach items="${list}" var="li">
									<option class="sales_choice_value" value="${li.employee_num}">${li.employee_num} ${li.name}</option>
								</c:forEach>	
							</select>
					  	</div>
						<div class="input-group flex-nowrap mt-2">
							<span class="input-group-text" id="start_Time"></span>
							<input id="inputStart" type="text" class="form-control" placeholder="시작 시간을 입력하세요." > ~
							<input id="inputEnd" type="text" class="form-control" placeholder="종료 시간을 입력하세요." >
					  	</div>
						
						<div class="input-group flex-nowrap mt-2">
							<span class="input-group-text" id="employee_Num">현장 관리자</span>
						  	<input id="inputSiteManager" type="hidden" class="form-control"  >
							<c:if test="${info.DEP_NAME eq '현장팀' || info.DEP_NAME eq '사업부'}">
								<select id="inputSelect_emp" class="emp_choice">
									<option class="base_selected" id="site_choice_base" value="">담당자 선택</option>
									<c:forEach items="${list_emp}" var="li">
										<option class="site_choice_value" value="${li.employee_num}">${li.employee_num} ${li.name}</option>
									</c:forEach>	
							</c:if>
							<c:if test="${info.DEP_NAME ne '현장팀' && info.DEP_NAME ne '사업부'}">
								<select disabled id="inputSelect_emp" class="emp_choice">
									<option class="base_selected" id="site_choice_base" value="">담당자 선택</option>
									<c:forEach items="${list_emp}" var="li">
										<option class="site_choice_value" value="${li.employee_num}">${li.employee_num} ${li.name}</option>
									</c:forEach>
							</c:if>
						</select>
						</div>
						<c:if test="${info.DEP_NAME eq '현장팀' || info.DEP_NAME eq '사업부'}">
							<div class="input-group flex-nowrap mt-2" id="allocationDiv">
								<span class="input-group-text" id="manage_Code">배차 정보</span>
								<input type="text" class="form-control" value="미정" readonly id="input_carAllocation" >
								<select id="carAllocation" class="form-select">
								</select>
							</div>
						</c:if>
						<c:if test="${info.DEP_NAME ne '현장팀'}">
							<div class="input-group flex-nowrap mt-2" id="allocationDiv">
								<span class="input-group-text" id="manage_Code">배차 정보</span>
								<input type="text" class="form-control" value="미정" readonly id="input_carAllocation" >
								<select disabled id="carAllocation" class="form-select">
								</select>
							</div>
						</c:if>
						<div class="input-group flex-nowrap mt-2">
							<span class="input-group-text" id="address">주소</span>
							<input id="inputAddress"  type="text" class="form-control display_none" placeholder="주소를 입력하세요." >
							<input class="form-control postApi postApiDis" type="text" id="postcode" placeholder="우편번호">
							<input class="postApiDis form-control" type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
							
					  	</div>
						<div class="input-group flex-nowrap mt-2">
							<input class="form-control postApi postApiDis"type="text" id="roadAddress" placeholder="도로명주소">
							<input class="form-control ml-3 postApi postApiDis" type="text" id="jibunAddress" placeholder="지번주소">
							<span id="guide" style="color:#999;display:none"></span>
							<input class="form-control ml-3 postApi postApiDis" type="text" id="detailAddress" placeholder="상세주소">
						</div>
						  <div class="input-group flex-nowrap mt-2">
							<span class="input-group-text" id="price">단가</span>
							<input id="inputPrice" type="text" class="form-control" placeholder="단가를 입력하세요." >
					  	</div>
					  	
						<c:if test="${info.DEP_NAME eq '현장팀' || info.DEP_NAME eq '사업부'}">
								<button class="btn btn-light create mt-3" id="create_sch_btn">등록하기</button>
							<div> 
								<button type="button" class="btn btn-secondary updel mt-3" id="complate_sch_btn">완료하기</button>
								<button type="button" class="btn btn-primary updel mt-3" id="update_sch_btn">수정하기</button>
								<button type="button" class="btn btn-warning updel mt-3" id="delete_sch_btn">삭제하기</button>
							</div>	
						</c:if>
						<c:if test="${info.DEP_NAME ne '현장팀' && info.DEP_NAME ne '사업부'}">
								<button class="btn btn-light create mt-3 display_none" style="display: none;" id="create_sch_btn">등록하기</button>
							<div> 
								<button type="button" style="display: none;" class=" btn btn-secondary updel mt-3" id="complate_sch_btn">완료하기</button>
								<button type="button" style="display: none;" class=" btn btn-primary updel mt-3" id="update_sch_btn">수정하기</button>
								<button type="button" style="display: none;"class=" btn btn-warning updel mt-3" id="delete_sch_btn">삭제하기</button>
							</div>	
						</c:if>
					</div>	
			</div>


			<c:import url="../temp/messenger.jsp"></c:import>
		</div>

	</div>

	

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

	<c:import url="../temp/footer.jsp"></c:import>
	<!-- //footer -->
	<c:import url="../temp/js.jsp"></c:import>
	<!-- // bootstrap-template-js -->

	<!-- fullcalendar api cdn download -->
	<script
		src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
	<script src="/bugclean/js/scheduleList.js"></script>
	
</body>
</html>