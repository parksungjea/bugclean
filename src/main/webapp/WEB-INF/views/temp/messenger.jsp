<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<link rel="stylesheet" href="/bugclean/css/messenger.css">

	<div class="modal fade show display_none" id="basicModal" aria-modal="true" style="padding-right: 17px; display: block;">
		<div class="modal-dialog" style="max-width: 600px;" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="modal_title" class="modal-title">사원 정보 </h5>
					<button type="button" onclick="close_modal()"  class="close" data-dismiss="modal"><span>×</span>
					</button>
				</div>
				<div class="modal-body">
					<div id="emp_info">
						<div id="left_info">
							<div id="info_profile">
								<img id="profile" src="/focus-bootstrap-main/theme/images/base_profile.png">
							</div>
						</div>
						<div id="right_info">
							<div>
								<div class="mb-2 row">
									<label for="info_name" class="col-sm-2 col-form-label">이름</label>
									<div class="col-sm-10">
									  <input style="color: black; text-align: center;" type="text" readonly class="form-control-plaintext" id="info_name" value="">
									</div>
								  </div>
							</div>
							<div>
								<div class="mb-2 row">
									<label for="info_def" class="col-sm-2 col-form-label">부서</label>
									<div class="col-sm-10">
									  <input style="color: black; text-align: center;" type="text" readonly class="form-control-plaintext" id="info_def" value="">
									</div>
								  </div>
							</div>
							<div>
								<div class="mb-2 row">
									<label for="info_pos" class="col-sm-2 col-form-label">직급</label>
									<div class="col-sm-10">
									  <input style="color: black; text-align: center;" type="text" readonly class="form-control-plaintext" id="info_pos" value="">
									</div>
								  </div>
							</div>
							<div>
								<div class="mb-2 row">
									<label for="info_ick" class="col-sm-2 col-form-label">닉네임</label>
									<div class="col-sm-10">
									  <input style="color: black; text-align: center;" type="text" readonly class="form-control-plaintext" id="info_nick" value="">
									</div>
								  </div>
							</div>
							<div>
								<div class="mb-2 row">
									<label for="info_phone" class="col-sm-2 col-form-label">번호</label>
									<div class="col-sm-10">
									  <input style="color: black; text-align: center;" type="text" readonly class="form-control-plaintext" id="info_phone" value="">
									</div>
								  </div>
							</div>
							<div>
								<div class="mb-2 row">
									<label for="info_Email" class="col-sm-2 col-form-label">E-mail</label>
									<div class="col-sm-10">
									  <input style="color: black; text-align: center;"  type="text" readonly class="form-control-plaintext" id="info_Email" value="">
									</div>
								  </div>
							</div>
						</div>
					</div>
					<div id="footer_info">
						<div class="open_chat" >
							<div class="messenger_modal_footer mt-1">
								<i onclick="chatRoom(event)" class="emp_num fa-regular fa-comment fa-3x"></i>
							</div>
							
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button"  class="btn btn-secondary" onclick="close_modal()" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>



<div id="messenger_div" class="display_none">
	        <div class="left_messenger" >
	        	<div id="messenger_Kind"> 
	        		<div >
	        			<i class="fa-regular fa-user fa-2x" onclick="change_emp_list()" id="messenger_list_icon" class="msg_icon"></i>
	        		</div>
	        		<div >
	        			<i class="fa-regular fa-comment fa-2x"  id="messenger_msg_icon" onclick="change_msg_list()"></i>
	        		</div>
	        	</div>
	        </div>
	        <div class="right_messenger" id="messenger_list">
	       		<div id="messenger_emp_list">
					
	       		</div>
	       		<div id="messenger_msg_list" class="display_none">
	       		
	       		</div>
	       	</div>
        </div> 
		<i id="messenger_img" class="fa-regular fa-comment-dots fa-4x" onclick="messenger_toggle()"></i>
        <script src="/bugclean/js/messenger.js"></script>   

