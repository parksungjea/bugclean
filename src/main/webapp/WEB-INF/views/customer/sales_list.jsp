<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/bugclean/css/customerList.css" type="text/css" />
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

			<div class="container-fluid">
				<div class="row page-titles mx-0">
					<div class="col-sm-6 p-md-0">
						<div class="welcome-text">
							<h4 style="font-weight: bolder;">거래처 목록</h4>
						</div>
					</div>
					<div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">Home</a></li>
							<li class="breadcrumb-item active">거래처 목록</li>
						</ol>
					</div>
				</div>

				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
							
							</div>
							<div class="card-body">
								<ul class="nav nav-tabs" role = "tablist">
									<li class="nav-item">
										<a class="nav-link active" data-toggle="tab" href="#company">
											<span>사업자</span>
										</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" id="nav-person" data-toggle="tab" href="#person">
											<span>개인</span>
										</a>
									</li>
									<form action="list" method="get" style="margin-left: 69%;">
										<div class="col-auto d-flex justify-content-end ml-auto">
											<div class="input-group input-group-sm">
												<div class="input-group-prepend">
													<select name="kind" id="kind" style="font-size: 12px; border-color: #eaeaea">
														<option value="1">법인 사업자</option>
														<option value="2">개인 사업자</option>
														<option value="3">개인 고객명</option>
													</select>
												</div>
												<input id="search" name="search" type="text" class="form-control" style="width: 50%; border-color: #eaeaea">
												<div class="input-group-append">
													<button id="search-btn" class="btn btn-primary">검색</button>
												</div>
											</div>
										</div>
									</form>
								</ul>
								
								<div class="table-responsive">
									<div id="example_wrapper" class="dataTables_wrapper">
										<!-- 리스트 시작 -->
										
										<div class="tab-content tabcontent-border">
											<!-- 법인 거래처 -->
											<div class="tab-pane fade active show" id="company" role="tabpanel">
												<table id="example" role="grid" class="table customer_list display dataTable" >
													<thead>
														<tr class="col-12" role="row">
															<th class="col-1">구분</th>
															<th class="col-2">사업자명</th>
															<th class="display_none">대표자명</th>
															<th class="display_none">대표자 번호</th>
															<th class="col-2">거래처 담당자</th>
															<th class="col-2">담당자 번호</th>
															<th class="col-3">주소</th>
															<th class="col-2">영업 담당자</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${companyList.ar}" var="li" >
																<tr class="list_tr modi_tr odd">
																	<td class="display_none td_customer_num" data-customernum="${li.customer_Num}"></td>
																	<td class="display_none td_customer_type" data-customertype="${li.customer_Type}"></td>
																	<td class="display_none modi_checkbox" ><input type="checkbox" class="td_checkbox"></td>
																	<td class="td_customer_kind">${li.customer_Kind}</td>
																	<c:if test="${info.DEP_NAME eq '영업팀' || info.DEP_NAME eq '사업부'}">
																		<td>
																			<a href="./detail?customer_Num=${li.customer_Num}" class="td_business_name">
																				${li.business_Name}
																			</a>
																		</td>
																	</c:if>
																	<c:if test="${info.DEP_NAME ne '영업팀' && info.DEP_NAME ne '사업부'}">
																		<td class="td_business_name">${li.business_Name}</td>
																	</c:if>
																	<td class="td_ceo_name display_none">${li.ceo_Name}</td>
																	<td class="td_ceo_phone display_none">${li.ceo_Phone}</td>
																	<td class="td_mng_name">${li.manager_Name}</td>
																	<td class="td_mng_phone">${li.manager_Phone}</td>
																	<td class="td_address">${li.address}</td>
																	<td class="td_sales_mng">${li.employee_Name}</td>
																	<td class="real_sales_mng display_none">${li.employee_Num}</td>
																</tr>
														
														</c:forEach>
													</tbody>
												</table>
												<div class="mb-3 pagerlabel">
													<nav aria-label="Page navigation example">
														<ul style="justify-content: center;" class="pagination pagination-xs">
															<c:if test="${!companyList.company_pager.start}">
																<li class="page-item">
																	<a class="page-link"
																	href="./list?page=${companyList.company_pager.startNum-1}&search=${companyList.company_pager.search}&kind=${companyList.company_pager.kind}"
																	aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
																	</a>
																</li>
															</c:if>
															<c:forEach begin="${companyList.company_pager.startNum}" end="${companyList.company_pager.lastNum}"
																var="i">
																<li class="page-item"><a class="page-link pager_btn ${companyList.company_pager.page==i?'select':''	}"
																	href="./list?page=${i}&search=${companyList.company_pager.search}&kind=${companyList.company_pager.kind}">${i}</a></li>
															</c:forEach>
								
															<c:if test="${!companyList.company_pager.last}">
																<li class="page-item">
																	<a class="page-link"
																	href="./list?page=${companyList.company_pager.lastNum+1}&search=${companyList.company_pager.search}&kind=${companyList.company_pager.kind}"
																	aria-label="Next"> <span aria-hidden="true">&raquo;</span>
																	</a>
																</li>
															</c:if>
														</ul>
													</nav>
												</div>
											</div>		
											<!-- 법인 거래처 끝 -->
											<!-- 개인 거래처 시작 -->
											<div class="tab-pane fade" id="person" role="tabpanel">
												<div class="tab-pane fade active show" id="person" role="tabpanel">
													<table id="example2" role="grid" class="table customer_list display dataTable" >
														<thead>
															<tr role="row">
																<th>고객 명</th>
																<th>고객 전화번호</th>
																<th>주소</th>
																<th>영업 담당자명</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${personMap.ar}" var="li">
																<tr class="list_tr modi_tr odd">
																	<td class="display_none td_customer_num" data-customernum="${li.customer_Num}"></td>
																	<td class="display_none td_customer_type" data-customertype="${li.customer_Type}"></td>
																	<td class="display_none modi_checkbox" ><input type="checkbox" class="td_checkbox"></td>
																	<td class="td_ceo_name">
																		<a href="./detail?customer_Num=${li.customer_Num}" class="td_business_name">
																			${li.ceo_Name}	
																		</a>
																	</td>
																	<td class="td_ceo_phone">${li.ceo_Phone}</td>
																	<td class="td_address">${li.address}</td>
																	<td class="td_sales_mng">${li.employee_Name}</td>
																	<td class="real_sales_mng display_none">${li.employee_Num}</td>
																</tr>
															</c:forEach>
														</tbody>
		
													</table>
													<div class="mb-3 pagerlabel">
												<nav aria-label="Page navigation example">
													<ul style="justify-content: center;" class="pagination pagination-xs">
														<c:if test="${!personMap.person_pager.start}">
															<li class="page-item">
																<a class="page-link"
																href="./list?page=${personMap.person_pager.startNum-1}&search=${personMap.person_pager.search}&kind=${personMap.person_pager.kind}"
																aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
																</a>
															</li>
														</c:if>
														<c:forEach begin="${personMap.person_pager.startNum}" end="${personMap.person_pager.lastNum}"
															var="i">
															<li class="page-item"><a class="page-link pager_btn ${persopersonMapnList.person_pager.page==i?'select':''	}"
																href="./list?page=${i}&search=${personMap.person_pager.search}&kind=${personMap.person_pager.kind}">${i}</a></li>
														</c:forEach>
							
														<c:if test="${!personMap.person_pager.last}">
															<li class="page-item">
																<a class="page-link"
																href="./list?page=${personMap.person_pager.lastNum+1}&search=${personMap.person_pager.search}&kind=${personMap.person_pager.kind}"
																aria-label="Next"> <span aria-hidden="true">&raquo;</span>
																</a>
															</li>
														</c:if>
													</ul>
												</nav>
											</div>
												</div>		
											</div>
											

											
											<!-- 개인 리스트 끝 -->
											<c:if test="${info.DEP_NAME eq '영업팀' || info.DEP_NAME eq '사업부'}">
												<a href="./create">
													<button class="btn btn-light create mt-4 mb-3">등록하기</button>
												</a>
											</c:if>
										</div>
										
										<!-- 리스트 끝 -->

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			
			

			<!-- 수정 모달 -->
			<form method="post">
				<div id="modal_myModal" class="modal">
						
					  <div class="modal-content" style="width : 30%;">
						<span class="close">&times;</span>
						<div class="modal-head-tool">
							<h4><b>거래처 정보 수정</b></h4>
						</div>
						<div id="modal_company">
						<input type="hidden" id="type" value="">
						
						<div class="input-group flex-nowrap mt-2" id="modal_bn_name">
							<span class="input-group-text left-div" id="customer_Name">사업자 명</span>
							<input id="modal_bn_name_in" type="text" class="form-control right-div" placeholder="사업자명을 입력하세요." >
						  </div>
						<div class="input-group flex-nowrap mt-2" id="modal_ceo_name">
							<span id="modal_ce_name_span" class="input-group-text left-div" >대표자 명</span>
							<input id="modal_ceo_name_in" type="text" class="form-control right-div" placeholder="대표자명을 입력하세요." >
						  </div>
						<div class="input-group flex-nowrap mt-2" id="modal_ceo_phone">
							<span id="modal_ce_phone_span" class="input-group-text left-div" >대표 전화번호</span>
							<input id="modal_ceo_phone_in" type="text" class="form-control right-div" placeholder="대표자 전화번호를 입력하세요." >
						  </div>						
						<div class="input-group flex-nowrap mt-2" id="modal_addr">
							<span class="input-group-text left-div" >주소</span>
							<input id="modal_addr_in" type="text" class="form-control right-div" placeholder="사업자 주소를 입력하세요." >
						  </div>						
						<div class="input-group flex-nowrap mt-2" id="modal_manager_name">
							<span class="input-group-text left-div" >담당자 명</span>
							<input id="modal_manager_name_in" type="text" class="form-control right-div" placeholder="거래처 담당자명을 입력하세요." >
						  </div>						
						<div class="input-group flex-nowrap mt-2" id="modal_manager_phone">
							<span class="input-group-text left-div" >담당자 전화번호</span>
							<input id="modal_manager_phone_in" type="text" class="form-control right-div" placeholder="거래처 담당자 전화번호를 입력하세요." >
						  </div>	 
						<div class="input-group flex-nowrap mt-2" id="modal_sales_name">
							<span class="input-group-text left-div" >영업 담당자 명</span>
							<input id="modal_sales_name_in" type="hidden" class="form-control right-div" placeholder="영업 담당자명을 입력하세요." >
							<select id="inputSelect" class="emp_choice right-div" style="width: 37%;">
								<option class="base_selected" id="salse_choice_base" value="" >담당자 선택</option>
							<c:forEach items="${sales_List}" var="li">
								<option class="sales_choice_value" value="${li.employee_num}">${li.employee_num} ${li.name}</option>
							</c:forEach>	
						</select>
						</div>	 
						 
						</div>
						<c:if test="${info.DEP_NAME eq '영업팀'}">
							<button id="modi_com" type="button" class="btn btn-primary create" onclick="modiComplate()">수정</button>
						</c:if>					
					  </div>
					</div>
				</form>	
			<!-- 수정 모달 끝 -->
			
			

			<c:import url="../temp/messenger.jsp"></c:import>
		</div>
	</div>

	

	<c:import url="../temp/footer.jsp"></c:import>
	<c:import url="../temp/js.jsp"></c:import>
	<script src="/bugclean/js/customerList.js"></script>
	<script>
		let kind = `${companyList.company_pager.kind}`;
		document.getElementById("kind").selectedIndex=kind-1;
		if(kind==""){
			document.getElementById("kind").selectedIndex=0
		}
	if(kind==3){
		document.getElementById("nav-person").click()
	}
	</script>
</body>
</html>