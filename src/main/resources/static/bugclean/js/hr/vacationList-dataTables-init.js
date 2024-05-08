function initDataTables(data) {
    $('#vacationList').DataTable({
        "data": data,
        "columns": [
            {data: "사번", title: "사번"},
            {data: "이름", title: "이름"},
            {data: "입사일", title: "입사일"},
            {data: "총연차일수", title: "총연차일수(시간)"},
            {data: "사용연차일수", title: "사용연차일수(시간)"},
            {data: "잔여연차일수", title: "잔여연차일수(시간)"},
            // {data: "근속연수", title: "근속연수"},
            {data: "부서", title: "부서"}
        ],
        "language": {
            "paginate": {
                "previous": '<i class="icon-arrow-left"></i>',
                "next": '<i class="icon-arrow-right"></i>'
            }
        }
    })
}

const saveData = {}; //비동기 통신으로 가져온 데이터를 저장하는 객체
async function getData(year) {
    if(saveData[year]){
        return saveData[year]; //해당하는 연도를 통신으로 데이터를 가져온적 있으면 해당 데이터를 리턴
    }

    // 새로운 데이터를 가져오는 비동기 함수
    let response = await $.ajax({
        url: "/hr/vacation/list?year=" + $('#yearSelect').val(),
        type: "GET"
    });
    for (let item of response) {
        item.근속연수 += "년";
        item.총연차일수 = (item.총연차일수 / 8) + `일 (${item.총연차일수})`;
        item.사용연차일수 = (item.사용연차일수 / 8) + `일 (${item.사용연차일수})`;
        item.잔여연차일수 = (item.잔여연차일수 / 8) + `일 (${item.잔여연차일수})`;
    }

    const saveDataKeys = Object.keys(saveData);
    if (saveDataKeys.length >= 3) {
        const oldestYear = saveDataKeys[2]; // 가장 오래된 연도 가져오기
        delete saveData[oldestYear]; // 가장 오래된 데이터 삭제
    }

    saveData[year] = response; //비동기 통신으로 가져온 데이터를 해당연도 데이터로 저장
    return response;
}

$(document).ready(async function () {
    let year = $('#yearSelect').val()+"";
    let data = await getData(year);
    $('#yearSelect').select2({
        placeholder: 'Select Year', // 플레이스홀더 설정
        width: '20%', // 셀렉트 박스의 너비 설정
        minimumResultsForSearch: Infinity //셀렉트 박스 검색창 표기 설정
    });
    let currentYear = new Date().getFullYear();
    $('#yearSelect').val(currentYear).trigger('change');
    $('#yearSelect').on('change', async function () {
        let table = $('#vacationList').DataTable()
        year = $('#yearSelect').val()+"";
        let newData = await getData(year); // 새로운 데이터 가져오기
        table.clear().rows.add(newData).draw(); // 데이터 업데이트
    });
    initDataTables(data); // 데이터 테이블 초기화
});

