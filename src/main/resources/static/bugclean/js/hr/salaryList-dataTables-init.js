function initDataTables(data) {
    $('#salaryList').DataTable({
        "data": data,
        "columns": [
            {data: "EMPLOYEE_NUM", title: "사번"},
            {data: "NAME", title: "이름"},
            {data: "SALARY_ACCOUNT", title: "급여계좌번호", defaultContent: "미설정"},
            {data: "SALARY_BANK", title: "급여은행", defaultContent: "미설정"},
            {data: "SALARY_PAY", title: "연봉금액", defaultContent: "미설정"},
            {data: "DEP_NAME", title: "부서"},
        ],
        "language": {
            "paginate": {
                "previous": '<i class="icon-arrow-left"></i>',
                "next": '<i class="icon-arrow-right"></i>'
            }
        },
        "destroy": true
    })
}

async function getData(year) {

    // 새로운 데이터를 가져오는 비동기 함수
    let response = await $.ajax({
        url: "/hr/salary/list?year=" + $('#yearSelect').val(),
        type: "GET"
    });
    for (let item of response) {
        item.SALARY_PAY += "만원";
    }
    return response;
}

let salaryData;
$('#salaryList tbody').on('click', 'tr', function() {
    $('#salaryModal').modal('show');
    let tr = $(this);
    let table = $("#salaryList").DataTable();
    let rowData = table.row(tr).data();
    $('#modal-title-num').html(rowData.EMPLOYEE_NUM);
    $('#modal-title-name').html(rowData.NAME);
    $('#account').val(rowData.SALARY_ACCOUNT);
    $('#bank').val(rowData.SALARY_BANK);
    $('#salary').val(rowData.SALARY_PAY.substring(0,rowData.SALARY_PAY.indexOf('만')))
    salaryData = new FormData();
    salaryData.append("employee_num",rowData.EMPLOYEE_NUM);
});

$('#save-btn').on('click',async function (){
    salaryData.append("salary_year",$('#yearSelect').val());
    salaryData.append("salary_account",$('#account').val());
    salaryData.append("salary_bank",$('#bank').val());
    salaryData.append("salary_pay",$('#salary').val());
    await fetch("/hr/salary/update",{
        method: 'POST',
        body: salaryData
    }).then(res => res.json()).then(async res => {
        let data = await getData(res)
        initDataTables(data)
    })
    $('#salaryModal').modal('hide')
})



$(document).ready(async function () {
    let year = $('#yearSelect').val();
    let data = await getData(year);
    $('#yearSelect').select2({
        placeholder: 'Select Year', // 플레이스홀더 설정
        width: '20%', // 셀렉트 박스의 너비 설정
        minimumResultsForSearch: Infinity //셀렉트 박스 검색창 표기 설정
    });
    let currentYear = new Date().getFullYear();
    $('#yearSelect').val(currentYear).trigger('change');
    $('#yearSelect').on('change', async function () {
        let table = $('#salaryList').DataTable()
        year = $('#yearSelect').val();
        let newData = await getData(year); // 새로운 데이터 가져오기
        table.clear().rows.add(newData).draw(); // 데이터 업데이트
    });
    initDataTables(data); // 데이터 테이블 초기화
});

