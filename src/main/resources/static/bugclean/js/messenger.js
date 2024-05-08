let affairs_team_list = document.getElementById("affairs_team_list");
let affairs_team_span = document.getElementById("affairs_team_span");
let affairs_team_div = document.getElementById("affairs_team_div"); 
let messenger_emp_list = document.getElementById("messenger_emp_list");
let messenger_msg_list = document.getElementById("messenger_msg_list");


let openChatRoom = document.getElementById("openChatRoom");

let ceo;
let affairs = document.getElementById("총무팀");
let personal = document.getElementById("인사팀_list");
let sales = document.getElementById("영업팀");
let field = document.getElementById("현장팀");


let info_name = document.getElementById("info_name");
let info_nick = document.getElementById("info_nick");
let info_def = document.getElementById("info_def");
let info_pos = document.getElementById("info_pos");
let info_phone = document.getElementById("info_phone");
let info_profile = document.getElementById("info_profile");
let info_Email = document.getElementById("info_Email");

let obj = {};

// affairs_team_div.addEventListener("click",function(){
//     if(affairs_team_span.innerText.trim() == '+'){
//         affairs_team_span.innerHTML = '-';
//         affairs_team_list.classList.remove("display_none");
//     }else{
//        affairs_team_span.innerText = '+';
//        affairs_team_list.classList.add("display_none");
        
//     }

// })

function chatRoom(e){
    let empnum = e.target.id;
    let empnum2;
    let room_num;
    let username1;
    fetch("/chat/getPrincipal",{
        method : "GET"
    }).then(res=>res.text())
    .then(res=>{
        username1 = res;
        
        fetch("/chat/getEmpName",{
            method:"POST",
            headers: {
                "Content-Type": "application/json",
            },
            body : JSON.stringify({
                username : username1
            })
        }).then(res=>res.json())
        .then(res=>{
            username1 = res.NAME;
            empnum2 = res.EMPLOYEE_NUM;
            
            if(empnum > empnum2){
                room_num = empnum2+""+empnum;
            }else{
                room_num = empnum+""+empnum2;
            }
            fetch("/chat/room",{
                method : "POST",
                headers: {
                    "Content-Type": "application/json",
                  },
                body : JSON.stringify({
                    room_num : room_num
                })
            }).then(res=>res.json())
	            .then(res=>{
	                let url = "/chat/room?room_num="+room_num;
                    localStorage.setItem("sendDateMsg", JSON.stringify(res));
	                localStorage.setItem('sendData', room_num);
	                let options = "toolbar=no,scrollbars=no,resizable=yes,status=no,menubar=no,width=400, height=600, top=50,left=50";
	                window.open(url,'_blank',options);
                //newWindow.document.write(res);
                // 다시 겟으로 바꿔서 해보쟈! 
            })
        })


    })

    
    


    
    
   

}

//사원 이름 클릭시 사원 정보 모달창 띄우기
let basicModal = document.getElementById("basicModal");
async function emp_modal(e){
    const response = await fetch("/chat/getEmpInfo",{
        method:"POST",
        headers: {
            "Content-Type": "application/json",
          },
        body : JSON.stringify({
            employee_num : e.target.id
        })
    })
    const res = await response.json();
    basicModal.classList.remove("display_none");
    info_name.value = res.NAME;
    info_def.value = res.DEP_NAME;
    info_nick.value = res.NICKNAME;
    info_phone.value = res.PHONE;
    info_pos.value = res.POS_NAME;
    info_Email.value = res.USERNAME;
    document.getElementsByClassName("emp_num")[0].setAttribute("id",res.EMPLOYEE_NUM);


}

// 외부 클릭시 모달창 닫기
window.onclick = function(event) {
    
    if (event.target == basicModal) {
      basicModal.classList.add ("display_none");
    }
  }

  let close = document.getElementsByClassName("close");

function close_modal(){
    basicModal.classList.add("display_none");
}



//페이지 로드시 메신저에 사원 조직도 그리기 1차 부서,팀
window.addEventListener("load",async function(){
	fetch("/chat/getPrincipal")
	
    const response =  await fetch("/chat/department",{
        method : "POST"
    })
        const res = await response.json();
        res.forEach(element => {
            let div = this.document.createElement("div");
            if(element.upper_dep_code == null || element.upper_dep_code== 1){
                div.innerHTML+=  
                `<div id="div${element.dep_code}">
                <div id="div${element.dep_code}_div"  class="mt-1" onclick="displayOnOff('${element.dep_code}')">
                <b>
                <span id="div${element.dep_code}_span">+</span><i class="fa-solid fa-users"></i>
                ${element.dep_name}</b>
                </div>
                <div id="div${element.dep_code}_list" class="display_none mt-1">
                </div>
                </div>
                
                `
                messenger_emp_list.append(div);
                obj[element.dep_code] = div.querySelector(`#div${element.dep_code}_list`);
            }else{
                div.innerHTML+=  
                `<div id="div${element.dep_code}">
                <div id="div${element.dep_code}_div"  class="mt-1" onclick="displayOnOff('${element.dep_code}')">
                <b>
                <span id="div${element.dep_code}_span">&emsp;+</span><i class="fa-solid fa-users"></i>
                ${element.dep_name}</b>
                </div>
                <div id="div${element.dep_code}_list" class="display_none mt-1">
                </div>
                </div>
                
                `
                document.getElementById(`div${element.upper_dep_code}_list`).append(div);
                obj[element.dep_code] = div.querySelector(`#div${element.dep_code}_list`);
            }
          });
          
		    
		    let getUserName;
		    let getName;
		    let getEmpNum;
		    fetch("/chat/getPrincipal",{
		        method : "GET"
		    }).then(res=>res.text())
		    .then(res=>{
		        getUserName = res;
		        
		        fetch("/chat/getEmpName",{
		            method:"POST",
		            headers: {
		                "Content-Type": "application/json",
		            },
		            body : JSON.stringify({
		                username : getUserName
		            })
		        }).then(res=>res.json())
		        .then(res=>{
		            getName = res.NAME;
		            getEmpNum = res.EMPLOYEE_NUM;
		          fetch("/chat/getChattingRoom",{
					  method : "POST",
					  headers: {
		                "Content-Type": "application/json",
		            },
		            body : JSON.stringify({
						employee_num : getEmpNum
						})
				  }).then(res=>res.json())
				  .then(res=>{
					  res.forEach(element => {
						  let profile = "/focus-bootstrap-main/theme/images/base_profile.png";
						  
						  if(element.PROFILE !=null){
							  profile = "/files/profile/" + element.PROFILE
						  }
						  messenger_msg_list.innerHTML += `<div style="color : black; margin-top : 3%;" id="${element.ROOM_NUM}" onclick="intoChatRoom(${element.ROOM_NUM})"> <div style="width:30%; display : inline-flex;"> <img style="border-radius : 50%; margin : auto;" width="50" height="50" id="user2_profile" src="${profile}"> </div>  <div id="msg${element.ROOM_NUM}" style="width:auto; display : inline-block;"><div> ${element.DEP_NAME} ${element.POS_NAME} ${element.NAME}<div></div> </div>`
					  fetch("/chat/getLastMessage",{
						   method : "POST",
							  headers: {
				                "Content-Type": "application/json",
				            },
				            body : JSON.stringify({
								employee_num : element.EMPLOYEE_NUM ,
								room_num : 	element.ROOM_NUM
							})
					  }).then(res=>res.json())
					  .then(res=>{
                        
						 document.getElementById(`msg${element.ROOM_NUM}`).innerHTML +=  `<div style="color : grey"> ${res.msg_contents}</div>` + `<div style="font-size : smaller">${res.msg_send_time}</div>`
					  })
					  })
					  
					  
				  })
				  
				  
				  
		         })
          
          
        })
      })
     
    function intoChatRoom(e){
        fetch("/chat/room",{
            method : "POST",
            headers: {
              "Content-Type": "application/json",
          },
          body : JSON.stringify({
            room_num : e
        })
        }).then(res=>res.json())
        .then(res=>{
            let url = "/chat/room?room_num="+e;
                    localStorage.setItem("sendDateMsg", JSON.stringify(res));
	                localStorage.setItem('sendData', e);
	                let options = "toolbar=no,scrollbars=no,resizable=yes,status=no,menubar=no,width=400, height=600, top=50,left=50";
	                window.open(url,'_blank',options);
        })
    }
      
//" class=" + "\"" + "display_none" + "\""
                            /* <div id="affairs_team_list" class="display_none">
							<div>&emsp;<i class="fa-solid fa-user"></i>박성제</div>
							<div>&emsp;<i class="fa-solid fa-user"></i>허석훈</div>
							<div>&emsp;<i class="fa-solid fa-user"></i>노지언</div>
							<div>&emsp;<i class="fa-solid fa-user"></i>윤상열</div>
						    </div> */

// 조직도 2차 각 팀,부서 소속 사원들 집어넣기
window.addEventListener("load",async function(){
    
    const response =  await fetch("/chat/list",{
        method:"POST"
    })
        const res = await response.json();
        res.forEach((element,index) => {
            obj[element.DEP_CODE].innerHTML = `<div id="${element.EMPLOYEE_NUM}" onclick="emp_modal(event)" style="color:black;" class="mt-1">&emsp;&emsp;<i class="fa-solid fa-user mr-1"></i>${element.POS_NAME} ${element.NAME} ( ${element.NICKNAME} )</div>`
            +`${obj[element.DEP_CODE].innerHTML}`
        
        
    })

}) 

// 조직도 확장 시 조직 이름 앞 - ,   조직도 축소 시 조직 이름 앞 +
function displayOnOff(name){
    
    let list = document.getElementById("div"+name+"_list")
    let span = document.getElementById("div"+name+"_span");
    
    if(name.length<3){

        if(list.classList.contains("display_none")){
            list.classList.remove("display_none");
            span.innerHTML="-";
        }else{
            list.classList.add("display_none");
            span.innerHTML="+";
        }
    }else{
        if(list.classList.contains("display_none")){
            list.classList.remove("display_none");
            span.innerHTML="&emsp;-";
        }else{
            list.classList.add("display_none");
            span.innerHTML="&emsp;+";
        }
    }
}
