$(document).ready(async function () {
    let dataTable; // 데이터 테이블 변수 선언

    const datePicker = $('#datePicker');
    datePicker.daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        applyClass: 'btn-danger',
        cancelClass: 'btn-inverse',
        locale: {
            format: 'YYYY-MM-DD', // 날짜 형식을 설정합니다.
        }
    });

    // 데이터 테이블 초기화 함수
    function initDataTables(startDate, endDate) {
        dataTable = $('#attendanceList').DataTable({
            "serverSide": true, // 서버 측 처리 활성화
            "ajax": {
                "url": "/hr/attendance/list", // 서버 측 API 엔드포인트
                "type": "POST", // 데이터 전송 방식 (GET 또는 POST)
                "dataSrc": "data",
                "data": function (d) {
                    // 서버에 전달할 추가 데이터 (예: 페이지 번호, 페이지당 항목 수)
                    return  {
                        startDate : startDate,
                        endDate : endDate,
                        page : (d.start / d.length) + 1, // DataTables가 서버에 요청하는 페이지 번호
                        pageSize : d.length, // DataTables가 서버에 요청하는 페이지당 항목 수
                        search: d.search.value,
                        column: d.order[0].column,
                        dir: d.order[0].dir
                    }
                }

            },
            "order": [[0, 'asc']], // 기본 정렬 열 설정
            "searching": true, // 검색 기능 활성화
            "lengthChange": true, // 페이지 당 항목 수 변경 활성화
            "columns": [
                {data: "EMPLOYEE_NUM", title: "사번"},
                {data: "NAME", title: "이름"},
                {data: "ATTEND_DATE", title: "출근날짜"},
                {data: "LATE", title: "상태", defaultContent: "결근"},
                {data: "START_TIME", title: "출근시간", defaultContent: ""},
                {data: "DONE_TIME", title: "퇴근시간", defaultContent: ""},
                {data: "DEP_NAME", title: "부서"},
            ],
            "language": {
                "paginate": {
                    "previous": '<i class="icon-arrow-left"></i>',
                    "next": '<i class="icon-arrow-right"></i>'
                }
            }
        });
    }

    let startDate = datePicker.val().substring(0, datePicker.val().indexOf(" "));
    let endDate = datePicker.val().substring(datePicker.val().lastIndexOf(" ") + 1);

    // applyBtn 클릭 이벤트 핸들러
    $("#datePicker").on("change", function () {
        startDate = datePicker.val().substring(0, datePicker.val().indexOf(" "));
        endDate = datePicker.val().substring(datePicker.val().lastIndexOf(" ") + 1);
        // 데이터 테이블 제거
        if (dataTable) {
            dataTable.destroy();
        }

        // 데이터 테이블 다시 초기화
        initDataTables(startDate, endDate);
    });


    // 초기화
    initDataTables(startDate, endDate);
});
