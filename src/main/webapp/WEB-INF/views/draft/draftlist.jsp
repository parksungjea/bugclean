<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="/focus-bootstrap-main/theme/vendor/nestable2/css/jquery.nestable.min.css" rel="stylesheet">
	<title>BUGCLEAN</title>
	<link rel="icon" type="image/x-icon" href="/bugclean/favicon.ico">
<!-- Favicon icon -->
<c:import url="../temp/css.jsp"></c:import>



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
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">문서양식</h4>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table mb-0">
								<tbody>
									<tr>
										<td><a href="./basisdraft">기본양식</a></td>
									</tr>
									<tr>
										<td>현장보고서</td>
									</tr>
									<tr>
										<td>매출보고서</td>
									</tr>
									<tr>
										<td>연차신청서</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
			<!--**********************************
            Content body end
        ***********************************-->


			<!--**********************************
            Footer start
        ***********************************-->
		</div>
		<c:import url="../temp/messenger.jsp"></c:import>
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



		<!--**********************************
        Main wrapper end
    ***********************************-->

		<!--**********************************
        Scripts
    ***********************************-->
		<!-- Required vendors -->
		<script src="/focus-bootstrap-main/theme/vendor/nestable2/js/jquery.nestable.min.js"></script>
		<script src="/focus-bootstrap-main/theme./js/plugins-init/nestable-init.js"></script>
		<c:import url="../temp/js.jsp"></c:import>
</body>