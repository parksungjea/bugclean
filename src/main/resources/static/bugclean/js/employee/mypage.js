

//닉 영어
function onlyEnglish(e)  {
  var englishOnly = e.value.replace(/[^a-zA-Z]/g, "");
  e.value = englishOnly;
}
//서명
$(document).ready(function() {  
        $( '#exampleModalBtn').on('click', function() {
          var canvas = document.getElementById('signature-pad');
        
           // 픽셀 비율을 고려하여 캔버스 좌표 공간을 조정합니다.
           // 모바일 장치에서 선명하게 보이도록 합니다.
           // 이것은 또한 캔버스가 지워지게 합니다.
          function resizeCanvas() {
              // 아주 이상한 이유로 100% 미만으로 축소하면,
              // 일부 브라우저는 devicePixelRatio를 1 미만으로 보고합니다.
              // 그러면 캔버스의 일부만 지워집니다.
            var ratio =  Math.max(window.devicePixelRatio || 1, 1);
            canvas.width = canvas.offsetWidth * ratio;
            canvas.height = canvas.offsetHeight * ratio;
            canvas.getContext("2d").scale(ratio, ratio);
          }
        
          //window.onresize = resizeCanvas;
          //resizeCanvas();
        
          var signaturePad = new SignaturePad(canvas, {
            backgroundColor: 'rgb(255, 255, 255, 0)',
            //penColor: "rgb(1, 2, 3)"
            penColor: 'black'
          });
        
          document.getElementById('save-png').addEventListener('click', function () {
            if (signaturePad.isEmpty()) {
              return alert("먼저 서명을 해주세요.");
            }
        
            var data = signaturePad.toDataURL('image/png');
            $("#img01").attr('src', data);
            $("#sign_file").attr('value', data);

          });
        
          document.getElementById('clear').addEventListener('click', function () {
            signaturePad.clear();
          });
        
        });
    });



const infoUpdateBtn = document.getElementById("infoUpdateBtn");

let nickname = document.getElementById("nickname");

let phoneStart = document.getElementById("phoneStart");
let phoneMiddle = document.getElementById("phoneMiddle");
let phoneEnd = document.getElementById("phoneEnd");



let phone = document.getElementById("phone");
let address = document.getElementById("address");
let sample6_address = document.getElementById("sample6_address");
let sample6_detailAddress = document.getElementById("sample6_detailAddress");

infoUpdateBtn.addEventListener("click",function(e){
	
	if(nickname.value === ''){
		alert('닉네임을 입력하세요.')
		e.preventDefault();
		return false;
	}
	
	//폰
	if(phoneStart.value != ""&&phoneMiddle.value != ""&&phoneEnd.value != ""){

		phone.setAttribute("value",phoneStart.value+"-"+phoneMiddle.value+"-"+phoneEnd.value);
	}else if(phone.value === ''){
		alert('휴대전화를 입력하세요.')
		e.preventDefault();
		return false;
	}
	//alert(phone.value);
	//주소 sample6_address+sample6_detailAddress
	if(sample6_address.value != ""&&sample6_detailAddress.value != ""){
		address.setAttribute("value",sample6_address.value+" "+sample6_detailAddress.value);
	}else if(address.value === ''){
		alert('주소을 입력하세요.')
		e.preventDefault();
		return false;
	}
	//alert(address.value);


})


//주소
function sample6_execDaumPostcode() {
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

//이미지
function readImg(input) {
    if (input.files && input.files[0]) {
        ////파일읽기
      let reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById('preview').src = e.target.result;
      };
        //////file 인풋에서 change이벤트가 실행됐을때의 이벤트 헨들러
      reader.readAsDataURL(input.files[0]);
    } else {
      document.getElementById('preview').src = "";
    }
  }

// File uload 검사
let ctncheck = $("#formFileMultiple");
ctncheck.on("change", () => {
    let files = ctncheck[0].files; // 선택된 파일들
    if (files.length > 1) {
        alert("1개의 파일만 업로드 가능합니다.");
        ctncheck.val(""); // 파일 선택 취소
        return false;
    }
    for (let i = 0; i < files.length; i++) {
        let ext = files[i].name.split(".").pop().toLowerCase(); // 확장자 분리
        // 아래 확장자가 있는지 체크 배열에 담아서 비교
        if ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) == -1) {
            alert(
                "jpg,gif,jpeg,png 파일만 업로드 할수 있습니다. 다시 업로드 해주십시오."
            );
            ctncheck.val(""); // 파일 선택 취소
            return false;
        }
    }
});


//폼내용 초기화
document.getElementById('profileClose').addEventListener("click",()=>{
	document.getElementById('preview').src = "/focus-bootstrap-main/theme/images/profile/사랑아보영해.jpg";
  	document.getElementById('updateForm').reset();
})
document.getElementById('infoClose').addEventListener("click",()=>{
 	document.getElementById('infoForm').reset();
})
