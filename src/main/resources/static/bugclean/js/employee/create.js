//console.log('연결');

const mailCheckBtn = document.getElementById("mailCheckBtn");

let submit = document.getElementById("submit");
let phoneStart = document.getElementById("phoneStart");
let phoneMiddle = document.getElementById("phoneMiddle");
let phoneEnd = document.getElementById("phoneEnd");

let email= null;
let number;

//메일전송
mailCheckBtn.addEventListener("click",function(){
		//공백시
	    if(document.getElementById("username").value === ''){
	      alert('아이디를 입력해주세요.');
	      return false;
	    }else if(document.getElementById("username").value.includes('@')){
			alert('올바르게 입력해주세요.');
	     	return false;
		}
		
		email = document.getElementById("username").value + "@gmail.com";
		//console.log(email);
		
		//이메일 전송
		sendNumber()
		$("#number").focus();
		$("#mailCheckBtn").attr("disabled","disabled");

})
		//이메일 전송
		function sendNumber(){
			console.log(email);
			$("#mail_number").css("display","block");
			$.ajax({
				url:"/employee/mailSend",
				type:"post",
				dataType:"json",
				data:{"email" : email},
				success: function(data){
					alert("인증번호 발송");
					$("#Confirm").attr("value",data);
				}
				// ,error:function(request, status, error){
				// 	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				// }
				}
			);
		}
		
		//인증번호 일치여부
		function confirmNumber(){

			userNumCheck = document.getElementById("userNumCheck").value
			//console.log("number : "+number);
			fetch("/employee/mailCheck?userNumber="+userNumCheck,{
				method:"get"
			})
			.then(res=>res.text())
			.then(r=>{
				//console.log("r : "+r);
				if(r){
					alert("인증되었습니다.");
				}else{
					alert("다시 시도해주세요.");
				}
			})

		}
		// //인증번호 확인
		// function confirmNumber(){
		// 	var number1 = $("#number").val();
		// 	var number2 = $("#Confirm").val();
	
		// 	if(number1 == number2){
		// 		alert("인증되었습니다.");
		// 	}else{
		// 		alert("번호가 다릅니다.");
		// 	}
		// }


//


let phone = document.getElementById("phone");
let address = document.getElementById("address");
let sample6_address = document.getElementById("sample6_address");
let sample6_detailAddress = document.getElementById("sample6_detailAddress");

submit.addEventListener("click",function(){
	//폰
	if(phoneStart.value != ""&&phoneMiddle.value != ""&&phoneEnd.value != ""){

		phone.setAttribute("value",phoneStart.value+"-"+phoneMiddle.value+"-"+phoneEnd.value);
	}
	//alert(phone.value);
	//주소 sample6_address+sample6_detailAddress
	if(sample6_address.value != ""&&sample6_detailAddress.value != ""){
		address.setAttribute("value",sample6_address.value+" "+sample6_detailAddress);
	}
	//alert(address.value);


})


//주소
function sample6_execDaumPostcode() {
	//console.log('연결');
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if(data.userSelectedType === 'R'){
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if(data.buildingName !== '' && data.apartment === 'Y'){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if(extraAddr !== ''){
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("sample6_extraAddress").value = extraAddr;
			
			} else {
				document.getElementById("sample6_extraAddress").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('sample6_postcode').value = data.zonecode;
			document.getElementById("sample6_address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("sample6_detailAddress").focus();
		}
	}).open();
}