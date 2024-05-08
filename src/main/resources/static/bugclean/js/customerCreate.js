let ck_company = document.getElementById("ck_company");
    let ck_person = document.getElementById("ck_person");
    let company1 = document.getElementById("company");
    let person1 = document.getElementById("person1");

let ceo_name_in = document.getElementById("ceo_name_in");
let ceo_phone_in = document.getElementById("ceo_phone_in")
let addr_in = document.getElementById("addr_in");
let sales_name_in = document.getElementById("sales_name_in");
let selectCompany = document.getElementById("inputSelect");

let addr_person_in = document.getElementById("addr_person_in");
let person_name_in = document.getElementById("person_name_in");
let person_phone_in = document.getElementById("person_phone_in");
let person_sales_name_in = document.getElementById("person_sales_name_in");
let person_select = document.getElementById("inputSelectPerson");

let submit_check = document.getElementById("submit_check");

let emp_choice = document.getElementsByClassName("emp_choice");

let bn_kind_in = document.getElementById("bn_kind_in");
let bn_kind_select = document.getElementById("bn_kind_select");

 let postcode = document.getElementById("postcode");
    let detailAddress = document.getElementById("detailAddress");
    let roadAddress = document.getElementById("roadAddress");


	function bn_kind_fn(){
		bn_kind_in.value = bn_kind_select.value
	}

    selectCompany.addEventListener("change",function(){
        sales_name_in.value = selectCompany.value;
    })
    person_select.addEventListener("change",function(){
        person_sales_name_in.value = person_select.value;
    })
        addr_person_in.disabled=true;
        person_name_in.disabled=true;
        person_phone_in.disabled=true;
        person_sales_name_in.disabled=true;

    function company(){
        if(ck_person.checked){
            ck_person.checked=false;
        }
        if(ck_company.checked){
            company1.classList.remove("none");
            person1.classList.add("none");
        }else{
            
            ck_company.checked=true;
        }
        submit_check.value = "사업자";

        addr_person_in.disabled=true;
        person_name_in.disabled=true;
        person_phone_in.disabled=true;
        person_sales_name_in.disabled=true;

        ceo_name_in.disabled=false;
        ceo_phone_in.disabled=false;
        addr_in.disabled=false;
        sales_name_in.disabled=false;
        
        addr_person_in_in.value="";
        postcode.value ="";
        detailAddress.value="";
        roadAddress.value="";

        bn_kind_select.value ="법인";
        bn_kind_select.selectedIndex=0;
    }

    function person(){
        if(ck_company.checked){
            ck_company.checked=false;
        }
        if(ck_person.checked){
            company1.classList.add("none");
            person1.classList.remove("none");
        }else{
            ck_person.checked=true;
            
        }
        ceo_name_in.disabled=true;
        ceo_phone_in.disabled=true;
        addr_in.disabled=true;
        sales_name_in.disabled=true;

        addr_person_in.disabled=false;
        person_name_in.disabled=false;
        person_phone_in.disabled=false;
        person_sales_name_in.disabled=false;

        submit_check.value="개인";
        bn_kind_select.value="";
        addr_in.value="";
        postcode.value ="";
        detailAddress.value="";
        roadAddress.value="";
    }
    
   
    detailAddress.addEventListener("change",function(){
		if(ck_company.checked == true){
			addr_in.value = roadAddress.value + " " + detailAddress.value; 
		}else if(ck_person.checked == true){
			addr_person_in.value = roadAddress.value + " " + detailAddress.value;
		}
	})