
const searchBtn = document.getElementById("searchBtn");
let name = document.getElementById("name");
let phoneStart = document.getElementById("phoneStart");
let phoneMiddle = document.getElementById("phoneMiddle");
let phoneEnd = document.getElementById("phoneEnd");

let phone = document.getElementById("phone");

//submit버튼
searchBtn.addEventListener("click",function(e){
	
	//폰
	if(name.value === ''){
		alert('이름을 입력하세요.')
		e.preventDefault();
		return false;
	}
	if(phoneStart.value != ""&&phoneMiddle.value != ""&&phoneEnd.value != ""){

		phone.setAttribute("value",phoneStart.value+'-'+phoneMiddle.value+'-'+phoneEnd.value);
	}else if(phone.value === ''){
		alert('휴대전화를 입력하세요.')
		e.preventDefault();
		return false;
	}
	

})


