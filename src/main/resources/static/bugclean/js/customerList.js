let modi = document.getElementById("modi");
let th_check = document.getElementById("th_check");
let modal = document.getElementById("modal_myModal");
let modi_tr = document.getElementsByClassName("modi_tr");
let span = document.getElementsByClassName("close")[0];
let list_tr = document.getElementsByClassName("list_tr");
let td_checkbox = document.getElementsByClassName("td_checkbox");



// 모달 창 각 항목 아이디
let modal_bn_name_in = document.getElementById("modal_bn_name_in");
let modal_ceo_name_in = document.getElementById("modal_ceo_name_in");
let modal_ceo_phone_in  = document.getElementById("modal_ceo_phone_in");
let modal_addr_in = document.getElementById("modal_addr_in");
let modal_manager_name_in = document.getElementById("modal_manager_name_in");
let modal_manager_phone_in = document.getElementById("modal_manager_phone_in");
let modal_sales_name_in = document.getElementById("modal_sales_name_in");
let real_sales_mng = document.getElementsByClassName("real_sales_mng");

let modal_ce_name_span = document.getElementById("modal_ce_name_span");
let modal_ce_phone_span = document.getElementById("modal_ce_phone_span")
// 리스트의 값들 클래스명으로 저장

let td_business_name = document.getElementsByClassName("td_business_name");
let td_ceo_name = document.getElementsByClassName("td_ceo_name");
let td_ceo_phone = document.getElementsByClassName("td_ceo_phone");
let td_mng_name = document.getElementsByClassName("td_mng_name");
let td_mng_phone = document.getElementsByClassName("td_mng_phone");
let td_address = document.getElementsByClassName("td_address");
let td_sales_mng = document.getElementsByClassName("td_sales_mng");
let td_customer_num = document.getElementsByClassName("td_customer_num");
let td_customer_type = document.getElementsByClassName("td_customer_type");
let type = document.getElementById("type");

//modal창 div 아이디 저장
let modal_bn_name = document.getElementById("modal_bn_name");
let modal_manager_name = document.getElementById("modal_manager_name");
let modal_manager_phone = document.getElementById("modal_manager_phone")

let inputSelect = document.getElementById("inputSelect");

let customer;
let business;

/*모달창 접근*/
for(let i=0; i<modi_tr.length;i++){

    
    modi_tr[i].addEventListener("click",function(event){
            //A링크를 클릭했을때는 모달창이 나오지않는다.
            if(event.target.tagName =='A' ){
              event.stopPropagation();
              return;
            }
            customer = td_customer_num[i].getAttribute("data-customernum");
            customerType = td_customer_type[i].getAttribute("data-customertype");
            type.value = customerType;
            if(type.value=="개인"){
              modal_bn_name.style.display="none";
              modal_manager_name.style.display="none";
              modal_manager_phone.style.display="none";
              modal_ce_name_span.innerHTML = "고객명"
              modal_ce_phone_span.innerHTML = "고객 전화번호"
            }else{
              modal_bn_name.style.display="";
              modal_manager_name.style.display="";
              modal_manager_phone.style.display="";
              modal_ce_name_span.innerHTML = "대표자 명"
              modal_ce_phone_span.innerHTML = "대표자 전화번호"
            }


            modal.style.display="block";

            modal_bn_name_in.value = td_business_name[i].innerText;
            modal_ceo_name_in.value = td_ceo_name[i].innerText;
            modal_ceo_phone_in.value = td_ceo_phone[i].innerText;
            modal_addr_in.value = td_address[i].innerText;
            modal_manager_name_in.value = td_mng_name[i].innerText;
            modal_manager_phone_in.value = td_mng_phone[i].innerText;
            modal_sales_name_in.value = td_sales_mng[i].innerText;

            for(let j=0;j<inputSelect.length;j++){
              if(inputSelect[j].value ==  real_sales_mng[i].innerHTML ){
                inputSelect[j].selected = true;
              }
            }
           
            


    })
}

inputSelect.addEventListener("change",function(){
  modal_sales_name_in.value = inputSelect.value
})

// 수정 완료 
function modiComplate(){
    fetch("/customer/update",{
        method : "post",
        headers: {
            "Content-Type": "application/json",
          },
        body : JSON.stringify({
            business_Num : business,
            customer_Num : customer,
            business_Name : modal_bn_name_in.value,
            ceo_Name : modal_ceo_name_in.value,
            ceo_Phone : modal_ceo_phone_in.value,
            address : modal_addr_in.value,
            manager_Name : modal_manager_name_in.value,
            manager_Phone : modal_manager_phone_in.value,
            employee_Num : inputSelect.value
        })
    }).then(response=>response.json())
    .then(response=>{
      if(response>0){
        alert("변경에 성공하였습니다.");
        location.href="/customer/list";
      }else{
        alert("변경에 실패하였습니다.");
        location.href="/customer/list"; 
      }
    })
}


/*모달창 종료 */
span.onclick = function() {
  modal.style.display = "none";
}

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}

/*수정 버튼 클릭시 체크박스 노출 */
function checkOn() {
    th_check.classList.remove("display_none");
    for(let i=0;i<modi_checkbox.length;i++){
		modi_checkbox[i].classList.remove("display_none");
	}
    

}


