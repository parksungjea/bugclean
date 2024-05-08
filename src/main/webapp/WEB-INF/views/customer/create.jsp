<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/bugclean/css/customerCreate.css"/>
<meta charset="UTF-8">
	<title>BUGCLEAN</title>
	<link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
</head>
<c:import url="../temp/css.jsp"></c:import>
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
		<c:import url="../temp/sidebar.jsp"></c:import>

		<div class="content-body " style="min-height: 900px;">
			<form method="post" style="background-color: white; border-style: outset;">
				<!-- 법인, 개인 체크 박스 -->
				<div id="check">
					<input type="checkbox" id="ck_company" class="ck" onclick="company()" checked="checked"> 
					<label for="ck_company">사업자</label> 
					<input type="checkbox" id="ck_person" class="ck" onclick="person()">
					<label for="ck_person">개인</label>
					<input type="hidden" name="customer_Type" id="submit_check" value="사업자">
				</div>
				<!-- 체크박스 끝 -->

				<!-- 법인 체크시 노출 시작 -->
				<div id="company">
					<div id="bn_kind">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">사업자 구분</button>
						<input class="right-div form-control " style="width:30%" id="bn_kind_in" type="hidden"
							placeholder="사업자 번호를 입력하세요." name="customer_Kind" value="법인">
						<select id="bn_kind_select" style="width:30%" class="right-div form-control" onchange="bn_kind_fn()">
							<option id="bn_select_base" value="법인">법인</option>
							<option value="개인">개인</option>
						</select>
					</div>
					<div id="bn_num">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">사업자 번호</button>
						<input class="right-div form-control" style="width:30%" id="bn_num_in" type="text"
							placeholder="사업자 번호를 입력하세요." name="business_Num">
					</div>
					<div id="bn_name">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">사업자 명</button>
						<input class="right-div form-control" style="width:30%" id="bn_name_in" type="text"
							placeholder="사업자 명을 입력하세요." name="business_Name">
					</div>
					<div id="ceo_name">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">대표자 명</button>
						<input class="right-div form-control" style="width:30%"  id="ceo_name_in" type="text"
							placeholder="대표자 이름을 입력하세요." name="ceo_Name">
					</div>
					<div id="ceo_phone">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">대표 전화번호</button>
						<input class="right-div form-control" style="width:30%" id="ceo_phone_in" type="text"
							placeholder="대표자 전화번호를 입력하세요." name="ceo_Phone">
					</div>
					<div id="manager_name">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">매니저 명</button>
						<input class="right-div form-control" style="width:30%" id="manager_name_in" type="text"
							placeholder="거래처 담당자 명을 입력하세요." name="manager_Name">
					</div>
					<div id="manager_phone">
						<button disabled="disabled"
							class=" btn-square btn-outline-dark left-div">매니저 전화번호</button>
						<input class="right-div form-control" style="width:30%" id="manager_phone_in" type="text"
							placeholder="거래처 담당자 전화번호를 입력하세요." name="manager_Phone">
					</div>
					<div id="sales_name">
						<button disabled="disabled"
							class=" btn-square btn-outline-dark left-div">영업 담당자 명</button>
						<input class="right-div form-control" style="width:30%" id="sales_name_in" type="hidden"
							placeholder="영업 담당자명을 입력하세요." name="employee_Num">
						<select id="inputSelect" class="emp_choice right-div form-control" style="width: 30%;" >
								<option value="" >담당자 선택</option>
							<c:forEach items="${list}" var="li">
								<option value="${li.employee_num}">${li.employee_num} ${li.name}</option>
							</c:forEach>	
						</select>
					</div>
					<div id="addr">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">주소</button>
						<input class="right-div form-control" style="width:30%" id="addr_in" type="text"
							placeholder="사업자 주소를 입력하세요." name="address">
					</div>
				</div>
				<!-- 법인 체크시 노출 끝 -->

				<!-- 개인 체크시 노출 시작 -->
				<div id="person1" class="none">

					<div id="person_name">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">고객명</button>
						<input class="right-div form-control" style="width:30%" id="person_name_in" type="text"
							placeholder="고객명을 입력하세요." name="ceo_Name">
					</div>
					<div id="person_phone">
						<button disabled="disabled"
							class=" btn-square btn-outline-dark left-div">고객 전화번호</button>
						<input class="right-div form-control" style="width:30%" id="person_phone_in" type="text"
							placeholder="고객 전화번호를 입력하세요." name="ceo_Phone">
					</div>
					<div id="person_sales_name">
						<button disabled="disabled"
							class=" btn-square btn-outline-dark left-div">영업 담당자 명</button>
						<input class="right-div form-control" style="width:30%" id="person_sales_name_in" type="hidden"
							placeholder="영업 담당자명을 입력하세요." name="employee_Num">
						<select id="inputSelectPerson" class="emp_choice right-div form-control" style="width: 30%;">
								<option value="" >담당자 선택</option>
							<c:forEach items="${list}" var="li">
								<option value="${li.employee_num}">${li.employee_num} ${li.name}</option>
							</c:forEach>	
						</select>	
					</div>
					<div id="addr_person">
						<button disabled="disabled"
							class="btn-square btn-outline-dark left-div">주소</button>
						<input class="right-div form-control" style="width:30%" id="addr_person_in" type="text"
							placeholder="고객 주소를 입력하세요." name="address">
					</div>
				</div>
				<!-- 개인 체크시 노출 끝 -->
				<div class="form-row mt-3" >
					<div class="col-sm-1" style="margin-left: 23%;">
						<input class="form-control postApi postApiDis right-div" style = "margin-left: 22%;" type="text" id="postcode" placeholder="우편번호">
					</div>
					<div class="col-sm-3" style="margin-left: 9%;">
						<input class="form-control postApi postApiDis right-div" style=" margin-left: 5%;" type="text" id="roadAddress" placeholder="도로명주소">
					</div>
					<div class="col-sm-1">
						<input class="postApiDis form-control" type="button" style = "margin-left: 0%;" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					</div>
				</div>
				<div class="form-row input-group flex-nowrap mt-2" style="width:65%; margin-left: 41%;">
					<span id="guide" style="color:#999;display:none"></span>
					<input class="col-sm-5 form-control ml-3 postApi postApiDis right-div" style="width: 50%;" type="text" id="detailAddress" placeholder="상세주소">
				</div>
				
				
				<!-- 작성완료 후 등록하기 버튼  -->
				<a href="/customer/list">
					<button  type = "button"  class="btn btn-secondary create mb-3">돌아가기</button>
				</a>
					<button class="btn btn-light create mb-3">등록하기</button>
			</form>
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
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                }  else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

	<c:import url="../temp/footer.jsp"></c:import>
	<c:import url="../temp/js.jsp"></c:import>
	<script src="/bugclean/js/customerCreate.js"></script>
</body>
</html>