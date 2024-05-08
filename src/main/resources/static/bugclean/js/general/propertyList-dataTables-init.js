let detail = (proCode, cateCode, event) => {
    if (cateCode === 100) {
        $('#property-modal').modal('show');

        $('#save-btn').prop('hidden', true);
        $('#modi-btn').prop('hidden', false);
        $('.custom-select').prop('disabled', true);
        $('#fire-btn').prop('hidden', false);
        $('#car_num').addClass('user_name').prop('disabled', true);
        $('#pro_name').addClass('user_name').prop('disabled', true);

        let tr = $(event.target).closest('tr');
        let table = $(`#propertyList-${cateCode}`).DataTable();
        let rowData = table.row(tr).data();
        $("#car_code").html(rowData.CAR_CODE);
        $("#car_num").val(rowData.CAR_NUM);
        $("#car_status").val(`${(rowData.CAR_STATUS === "운용가능" ? 0 : 1)}`);
        $("#car_type").val(rowData.CAR_TYPE);
        $("#join_date").html(rowData.CAR_INT_DATE);
    } else {
        $('#pro-modal').modal('show');
        $('#save-pro').prop('hidden', true);
        $('#modi-pro').prop('hidden', false);
        $('#delete-pro').prop('hidden', false);
        $('#pro-name').addClass('user_name').prop('disabled', true);
        let tr = $(event.target).closest('tr');
        let table = $(`#propertyList-${cateCode}`).DataTable();
        let rowData = table.row(tr).data();
        $('#pro_code').html(rowData.property_code);
        $('#pro-name').val(rowData.property_name);
        $('#add_date').html(rowData.pro_int_date)

        $('#pro-name').off('change');
        $('#save-pro').off('click');
        $('#delete-pro').off('click');

        let checkModi = false;

        $('#pro-name').on('change', function () {
            checkModi = true;
        })

        $('#save-pro').on('click', function () {
            $('#pro-modal').modal('hide');
            let data = {
                property_code: $('#pro_code').html(),
                property_name: $('#pro-name').val(),
                pro_int_date: $('#add_date').html(),
                pro_category: cateCode
            };
            if (checkModi) {
                fetch(`/general/proUpdate`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                }).then(response => {
                    if (response.ok) {
                        // 데이터 테이블 다시 초기화
                        checkModi = false;
                        propertyList(cateCode);
                    }
                })
            }
        });

        $('#delete-pro').on('click', function () {
            Swal.fire({
                title: '해당 자산을 삭제처리 하시겠습니까?',
                text: '삭제하면 복구할 수 없습니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.value) {
                    $('#pro-modal').modal('hide');

                    let data = {
                        property_code: $('#pro_code').html(),
                        pro_category: cateCode
                    };

                    fetch(`/general/proDelete`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(data)
                    }).then(response => {
                        if (response.ok) {
                            // 데이터 테이블 다시 초기화
                            propertyList(cateCode);
                        }
                    });
                }
            });
        });
    }


}

const add = (code) => {
    if (code === 100) {
        $('#property-modal').modal('show');
        $('#car_num').removeClass('user_name').prop('disabled', false);
        $('#pro_name').removeClass('user_name').prop('disabled', false);
        $('.custom-select').prop('disabled', false);
        $('#modi-btn').prop('hidden', true)
        $('#save-btn').prop('hidden', false);
        $('#delete-btn').prop('hidden', true);
        $("#car_code").html("");
        $("#pro_name").val("");
        $("#car_num").val("");
        $("#car_status").val(0);
        $("#car_type").val(0);
        $("#join_date").html("");
    } else {
        $('#pro-modal').modal('show');
        $('#save-pro').prop('hidden', false);
        $('#modi-pro').prop('hidden', true);
        $('#delete-pro').prop('hidden', true);
        $('#pro-name').removeClass('user_name').prop('disabled', false).val("");
        $('#pro_code').html("");
        $('#add_date').html("")

        $('#pro-name').off('change');
        $('#save-pro').off('click');
        $('#delete-pro').off('click');

        let checkModi = false;

        $('#pro-name').on('change', function () {
            checkModi = true;
        })

        $('#save-pro').on('click', function () {
            $('#pro-modal').modal('hide');
            let data = {
                property_code: $('#pro_code').html(),
                property_name: $('#pro-name').val(),
                pro_int_date: $('#add_date').html(),
                pro_category: code
            };
            if (checkModi) {
                fetch(`/general/proUpdate`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                }).then(response => {
                    if (response.ok) {
                        // 데이터 테이블 다시 초기화
                        checkModi = false;
                        propertyList(code);
                    }
                })
            }
        });

        $('#delete-pro').on('click', function () {
            Swal.fire({
                title: '해당 자산을 삭제처리 하시겠습니까?',
                text: '삭제하면 복구할 수 없습니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.value) {
                    $('#pro-modal').modal('hide');

                    let data = {
                        property_code: $('#pro_code').html(),
                        pro_category: code
                    };

                    fetch(`/general/proDelete`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(data)
                    }).then(response => {
                        if (response.ok) {
                            // 데이터 테이블 다시 초기화
                            propertyList(code);
                        }
                    });
                }
            });
        });
    }
}

function catePlus(){
    Swal.fire({
        title: '자산유형을 추가하시겠습니까?',
        input: 'text',
        icon: 'question',
        inputPlaceholder: '추가할 유형이름을 입력하세요',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showLoaderOnConfirm: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소',
        preConfirm: (text) => {
            return fetch('/general/cateAdd',{
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ pro_name: text })
            }).then(res => {
                if(res.ok){
                    window.location.href = '/general/property';
                }
            })
        }
    })
}
// 직원 목록을 불러와 DataTable에 표시하는 함수
function propertyList(code) {

    let columns;
    if (code === 100) {
        columns = [
            {data: "CAR_CODE", title: "자산번호"},
            {data: "CAR_NUM", title: "차량번호"},
            {data: "TYPE_NAME", title: "차량종류"},
            {data: "CAR_STATUS", title: "운용상태"},
            {data: "CAR_INT_DATE", title: "등록날짜"},
            {data: "CAR_TYPE", visible: false}
        ];
    } else {
        columns = [
            {data: "property_code", title: "자산번호"},
            {data: "property_name", title: "자산이름"},
            {data: "pro_int_date", title: "등록날짜"},
        ];
    }
    $.ajax({
        url: `/general/property/list?code=${code}`,
        type: "GET",
        success: function (response) {
            $(`#propertyList-${code}`).DataTable({
                "data": response.data,
                "columns": columns,
                "language": {
                    "paginate": {
                        "previous": '<i class="icon-arrow-left"></i>',
                        "next": '<i class="icon-arrow-right"></i>'
                    }
                },
                "destroy": true,
                "rowCallback": function (row, data) {
                    let proCode = data.property_code;
                    if (code === 100) {
                        proCode = data.CAR_CODE;
                    }
                    $(row).attr('onclick', `(event=>detail(${proCode},${code}, event))(event)`)
                }
            })
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $(`#propertyList-${code}`).html('<div style="color:red;">데이터를 가져오는 중 오류가 발생했습니다.</div>');
        }
    })


}


$(document).ready(async function () {
    // 페이지 로드 시 직원 목록과 퇴사 직원ㅌ 목록을 표시
    await propertyList(100);

    const saveBtn = $('#save-btn');
    const selects = $('.custom-select');
    const carNum = $('#car_num');

    // 수정 버튼 클릭 시 수정 입력 필드 활성화
    $('#modi-btn').on('click', function () {
        $('#modi-btn').prop('hidden', true);
        $('#save-btn').prop('hidden', false);
        $('.custom-select').prop('disabled', false);
        $('#car_num').removeClass('user_name').prop('disabled', false);
        $('#pro_name').removeClass('user_name').prop('disabled', false);
    });

    $('#modi-pro').on('click', function () {
        $('#modi-pro').prop('hidden', true);
        $('#save-pro').prop('hidden', false);
        $('#pro-name').removeClass('user_name').prop('disabled', false);
    });

    let checkModi = false;

    // 입력 필드 변경 시 수정 여부 체크
    selects.on('change', function () {
        checkModi = true;
    });

    carNum.on('change', function () {
        checkModi = true;
    });

    // 저장 버튼 클릭 시 수정된 정보 서버에 전송
    saveBtn.on('click', function () {
        $('#property-modal').modal('hide');
        let data = {
            car_code: $('#car_code').html(),
            car_num: $('#car_num').val(),
            car_status: $('#car_status').val(),
            car_type: $('#car_type').val(),
            pro_category: 100
        };
        if (checkModi) {
            fetch(`/general/carUpdate`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            }).then(response => {
                if (response.ok) {
                    // 데이터 테이블 다시 초기화
                    checkModi = false;
                    propertyList(100);
                }
            })
        }
    });

    // 퇴사 버튼 클릭 시 직원 퇴사 처리
    $('#delete-btn').on('click', function () {
        Swal.fire({
            title: '해당 자산을 삭제처리 하시겠습니까?',
            text: '삭제하면 복구할 수 없습니다.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.value) {
                $('#property-modal').modal('hide');

                let data = {
                    car_code: $('#car_code').html()
                };

                fetch(`/general/carDelete`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                }).then(response => {
                    if (response.ok) {
                        // 데이터 테이블 다시 초기화
                        propertyList(100);
                    }
                });
            }
        });
    });
});
