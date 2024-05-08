let email= null;


//=====================문자
const searchBtn = document.getElementById('searchBtn');

searchBtn.addEventListener('click', function() {

  if(phoneStart.value != ""&&phoneMiddle.value != ""&&phoneEnd.value != ""){

		phone.setAttribute("value",phoneStart.value+'-'+phoneMiddle.value+'-'+phoneEnd.value);
	}
  // else if(phone.value === ''){
	// 	alert('휴대전화를 입력하세요.')
	// 	e.preventDefault();
	// 	return false;
	// }

});




//=====================이메일
const emailSumitBtn = document.getElementById('emailSumitBtn');
document.addEventListener("DOMContentLoaded", function() {
    emailSumitBtn.addEventListener("click",function(e){
        //공백시
        if(document.getElementById("employee_num").value === ''){
            alert('사번을 입력해주세요.');
            e.preventDefault();
            return false;
        }else if(document.getElementById("inputname").value === ''){
        alert('이름을 입력해주세요.');
        e.preventDefault();
        return false;
        }else if(document.getElementById("inputusername").value === ''){
            alert('아이디를 입력해주세요.');
            e.preventDefault();
            return false;
        }else if(document.getElementById("inputusername").value.includes('@')){
            alert('올바르게 입력해주세요.');
            e.preventDefault();
            return false;
        }
        
        email = document.getElementById("inputusername").value + "@gmail.com";


    })
});
