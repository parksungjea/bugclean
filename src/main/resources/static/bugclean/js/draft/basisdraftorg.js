
let plusIcon = document.getElementsByClassName("plusIcon");
let minusIcon = document.getElementsByClassName("minusIcon");
let orgPepleDiv = document.getElementsByClassName("orgPepleDiv");
let orgPepleSpan = document.getElementsByClassName("orgPepleSpan");
let draftBtnMinus = document.getElementById("draftBtnMinus");
let draftBtnPlus = document.getElementById("draftBtnPlus");
let draftBoxTd = document.getElementById('draftBoxTd')
const draftBoxTdDiv = document.getElementById('draftBoxTdDiv')
let orgBoxTd = document.getElementById("orgBoxTd");
let orgAll = document.getElementsByClassName("orgAll");
let orgDep = document.getElementsByClassName("orgDep");
let refBoxTd = document.getElementById("refBoxTd");
let refMinusBtn = document.getElementById("refMinusBtn")
let refPlusBtn = document.getElementById("refPlusBtn");
let modalResetBtn = document.getElementById("modalResetBtn");
let highPlusIcon = document.getElementsByClassName("highPlusIcon");
let highMinusIcon = document.getElementsByClassName("highMinusIcon");
let orgTeamBigDiv = document.getElementsByClassName("orgTeamBigDiv");
let select = document.getElementById("select");




for (let i = 0; i < highPlusIcon.length; i++) {
	highPlusIcon[i].addEventListener("click", function() {
		if (highPlusIcon[i].style.display != "none") {
			highPlusIcon[i].style.setProperty("display", "none");
			highMinusIcon[i].style.display = "inline-block";
			orgTeamBigDiv[i].style.display = "inline-block";
		} else {
			highPlusIcon[i].style.display = "inline-block";
			highMinusIcon[i].style.display = "none";
			orgTeamBigDiv[i].style.display = "inline-block";
		}

	})
	highMinusIcon[i].addEventListener("click", function() {
		if (highPlusIcon[i].style.display != "none") {
			highPlusIcon[i].style.setProperty("display", "none");
			highMinusIcon[i].style.display = "inline-block";
			orgTeamBigDiv[i].style.display = "none";
		} else {
			highPlusIcon[i].style.display = "inline-block";
			highMinusIcon[i].style.display = "none";
			orgTeamBigDiv[i].style.display = "none";
		}

	})
}

///////////////////////////////


for (let i = 0; i < plusIcon.length; i++) {
	plusIcon[i].addEventListener("click", function() {
		if (plusIcon[i].style.display != "none") {
			plusIcon[i].style.setProperty("display", "none");
			minusIcon[i].style.display = "inline-block";
			orgPepleDiv[i].style.display = "inline-block";
		} else {
			plusIcon[i].style.display = "inline-block";
			minusIcon[i].style.display = "none";
			orgPepleDiv[i].style.display = "inline-block";
		}

	})
	minusIcon[i].addEventListener("click", function() {
		if (plusIcon[i].style.display != "none") {
			plusIcon[i].style.setProperty("display", "none");
			minusIcon[i].style.display = "inline-block";
			orgPepleDiv[i].style.display = "none";
		} else {
			plusIcon[i].style.display = "inline-block";
			minusIcon[i].style.display = "none";
			orgPepleDiv[i].style.display = "none";
		}

	})
}
for (let i = 0; i < orgPepleSpan.length; i++) {
	let drTemp = orgPepleSpan[i];
	drTemp.addEventListener(
		"click",
		function() {


			if (drTemp.style.backgroundColor != "rgb(196, 232, 230)") {
				drTemp.style.backgroundColor = "#C4E8E6";
			} else {
				drTemp.style.backgroundColor = "white";
			}

		})

}
let b = orgAll[0].textContent.split(" ");
draftBtnPlus
	.addEventListener(
		"click",
		function() {
			for (let j = 0; j < orgPepleSpan.length; j++) {
				let orTemp = orgPepleSpan[j];

				if (getComputedStyle(orTemp).backgroundColor == "rgb(196, 232, 230)") {
					draftBoxTd
						.appendChild(orTemp)
					orTemp.style.backgroundColor = "white";
				}
			}
		})

// let ddn = document.querySelector("div[data-dep-name='영업팀']")
draftBtnMinus.addEventListener("click", function() {
	for (let n = 0; n < orgDep.length; n++) {
		let orgAllArr = [...orgAll];
		let peopleSpanArr = [...orgPepleSpan];

		for (let j = 0; j < orgPepleSpan.length; j++) {

			let a = orgAllArr[j].getAttribute("data-dep-name");
			let orTemp = peopleSpanArr[j];

			if (getComputedStyle(orTemp).backgroundColor == "rgb(196, 232, 230)") {
				if (orgDep[n].textContent == a) {
					orgPepleDiv[n].appendChild(orTemp)
					orTemp.style.backgroundColor = "white";
				}
			}
		}
	}
})

////////////////////////////////참조

let c = orgAll[0].textContent.split(" ");
refPlusBtn.addEventListener(
	"click",
	function() {
		for (let j = 0; j < orgPepleSpan.length; j++) {
			let orTemp = orgPepleSpan[j];
			if (getComputedStyle(orTemp).backgroundColor == "rgb(196, 232, 230)") {
				refBoxTd
					.appendChild(orTemp)
				orTemp.style.backgroundColor = "white";
			}
		}
	})

// let ddn = document.querySelector("div[data-dep-name='영업팀']")
refMinusBtn.addEventListener("click", function() {
	for (let n = 0; n < orgDep.length; n++) {
		let orgAllArr = [...orgAll];
		let peopleSpanArr = [...orgPepleSpan];
		for (let j = 0; j < orgPepleSpan.length; j++) {

			let a = orgAllArr[j].getAttribute("data-dep-name");
			let orTemp = peopleSpanArr[j];

			if (getComputedStyle(orTemp).backgroundColor == "rgb(196, 232, 230)") {
				if (orgDep[n].textContent == a) {
					orgPepleDiv[n].appendChild(orTemp)
					orTemp.style.backgroundColor = "white";
				}
			}
		}
	}
})

//////////////////////////////초기화
modalResetBtn.addEventListener("click", function() {
	for (let n = 0; n < orgDep.length; n++) {
		let orgAllArr = [...orgAll];
		let peopleSpanArr = [...orgPepleSpan];
		for (let j = 0; j < orgPepleSpan.length; j++) {

			let a = orgAllArr[j].getAttribute("data-dep-name");
			let orTemp = peopleSpanArr[j]
			if (orgDep[n].textContent == a) {
				orgPepleDiv[n].appendChild(orTemp)
				orTemp.style.backgroundColor = "white";
			}

		}
	}
})

////등록버튼 눌렀을시
let modalCreateBtn = document.getElementById("modalCreateBtn");
let draftLine = document.getElementById("draftLine");
let refempnum = document.getElementById("refempnum");
modalCreateBtn.addEventListener("click", function() {
	modalBack.classList.add("noshow")
	modal.classList.add("noshow")
	//draftBoxTd
	let draftBoxTdAr = draftBoxTd.children
	let orgArrDep = [draftBoxTdAr.length];
	let orgArrName = [draftBoxTdAr.length];
	let empNum = [draftBoxTdAr.length];
	for (let i = 0; i < draftBoxTdAr.length; i++) {
		let splitValue = draftBoxTdAr[i].textContent.trim().split(" ");
		empNum[i] = draftBoxTdAr[i].lastElementChild.getAttribute("data-emp-num")
		orgArrDep[i] = splitValue[1];
		orgArrName[i] = splitValue[2];
	}
	let refInp = document.getElementById("refInp")

	//refBoxTd
	let refBoxTdAr = refBoxTd.children;
	let refBoxTdArCode = [refBoxTdAr.length]
	let refBoxTdName = [refBoxTdAr.length];
	for (let i = 0; i < refBoxTdAr.length; i++) {
		refBoxTdArCode[i] = refBoxTdAr[i].lastElementChild.getAttribute("data-emp-num");
		refBoxTdName[i] = refBoxTdAr[i].lastElementChild.getAttribute("data-pp-name");
	}
	if (refBoxTdName != 0) {
		refempnum.value = refBoxTdArCode.join(",");
		refInp.value = refBoxTdName.join(",");
	}
	fetch("/draft/getapprovalline", {
		method: 'POST',
		headers: {
			"Content-type": "application/x-www-form-urlencoded"
		},
		body: "dep=" + orgArrDep + "&name=" + orgArrName + "&orgCode=" + empNum + "&refCode=" + refBoxTdArCode
	})
		.then(Response => Response.text())
		.then(res => {
			const allineTable = document.getElementById("allineTable")
			allineTable.innerHTML = res;

		})

})

/////////////이벤트위임
let selectDiv = document.getElementById("selectDiv")
selectDiv.addEventListener("change", function(e) {
	//초기화
	for (let n = 0; n < orgDep.length; n++) {
		let orgAllArr = [...orgAll];
		let peopleSpanArr = [...orgPepleSpan];
		for (let j = 0; j < orgPepleSpan.length; j++) {

			let a = orgAllArr[j].getAttribute("data-dep-name");
			let orTemp = peopleSpanArr[j]
			if (orgDep[n].textContent == a) {
				orgPepleDiv[n].appendChild(orTemp)
				orTemp.style.backgroundColor = "white";
			}

		}
	}


	let selectIndex = e.target.value;

	fetch("/draft/getaldetail", {
		method: 'POST',
		headers: {
			"Content-type": "application/x-www-form-urlencoded"
		},
		body: "approval_line_code=" + selectIndex
	})
		.then(res => res.json())
		.then(res => {
			//draftbo\Td에 넣기
			for (let i = 0; i < orgPepleSpan.length; i++) {
				let empNum = orgPepleSpan[i].lastElementChild.getAttribute("data-emp-num")
				let orgPeopleSpan = orgPepleSpan[i];
				for (let n = 0; n < res.length; n++) {
					let getApRank = res[n].line_rank;
					let getEmpNum = res[n].employee_num;
					if (empNum == getEmpNum) {
						if (getApRank != 0) {
							draftBoxTd.appendChild(orgPeopleSpan)
						}
					}
				}

			}

		})

})
let approvalBtn = document.getElementById("approvalBtn");
let approvalInpName = document.getElementById("approvalInpName")
approvalBtn.addEventListener("click", function() {

	let approvalValue = draftBoxTd.children;
	let empCode = [approvalValue.length];
	for (let i = 0; i < approvalValue.length; i++) {
		empCode[i] = approvalValue[i].lastElementChild.getAttribute("data-emp-num");
	}

	fetch("/draft/getaplist", {
		method: 'POST',
		headers: {
			"Content-type": "application/x-www-form-urlencoded"
		},
		body: "empCode=" + empCode + "&lineName=" + approvalInpName.value
	})
		.then(Response => Response.text())
		.then(res => {
			selectDiv.innerHTML = res;
		})


})

let draftDeleteBtn = document.getElementById("draftDeleteBtn");

draftDeleteBtn.addEventListener("click", function() {
	let draftDeleteBtnData = draftDeleteBtn.getAttribute("data-delete-emp");


	fetch("/draft/draftdelete", {
		method: 'POST',
		headers: {
			"Content-type": "application/x-www-form-urlencoded"
		},
		body: "draft_num=" + draftDeleteBtnData
	})
		.then(Response => Response.text())
		.then(res => {
			if (res >= 1) {
				alert("삭제 실패하였습니다")
			} else {
				alert("삭제 성공하였습니다")
			}
			location.href = "/draft/mydraftlist"
		})
})