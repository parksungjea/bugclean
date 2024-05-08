// 직원 목록을 불러와 DataTable에 표시하는 함수
function memberList() {
    $.ajax({
        url: "/hr/member/list",
        type: "GET",
        success: function (response) {
            $('#memberList').DataTable({
                "data": response,
                "columns": [
                    {data: "EMPLOYEE_NUM", title: "사번"},
                    {data: "NAME", title: "이름"},
                    {data: "NICKNAME", title: "닉네임"},
                    {data: "PHONE", title: "연락처"},
                    {data: "ADDRESS", title: "주소", defaultContent: "미입력"},
                    {data: "DEP_NAME", title: "부서"},
                    {data: "POS_NAME", title: "직급"},
                    {data: "JOIN_DATE", title: "입사일"}
                ],
                "language": {
                    "paginate": {
                        "previous": '<i class="icon-arrow-left"></i>',
                        "next": '<i class="icon-arrow-right"></i>'
                    }
                }
            })
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#memberList').html('<div style="color:red;">데이터를 가져오는 중 오류가 발생했습니다.</div>');
        }
    })
}

// 퇴사 직원 목록을 불러와 DataTable에 표시하는 함수
function resignationList() {
    $.ajax({
        url: "/hr/resignation/list",
        type: "GET",
        success: function (response) {
            //복구 가능한 퇴사자 목록
            $('#possibleList').DataTable({
                "data": response.possible,
                "columns": [
                    {data: "EMPLOYEE_NUM", title: "사번"},
                    {data: "NAME", title: "이름"},
                    {data: "PHONE", title: "연락처"},
                    {data: "ADDRESS", title: "주소", defaultContent: "미입력"},
                    {data: "DEP_NAME", title: "부서"},
                    {data: "POS_NAME", title: "직급"},
                    {data: "JOIN_DATE", title: "입사일"},
                    {data: "RETIRED_DATE", title: "퇴사일"},
                    {
                        orderable: false,
                        render: function (data, type, row) {
                            return '<button id="restore-btn" class="btn btn-rounded btn-light btn-xs mr-2">' +
                                "복구" +
                                '</button>';
                        }
                    }
                ],
                "language": {
                    "paginate": {
                        "previous": '<i class="icon-arrow-left"></i>',
                        "next": '<i class="icon-arrow-right"></i>'
                    }
                },
                "columnDefs": [
                    {target: "_all", width: "auto"}
                ]
            })

            //복구 불가능한 퇴사자 목록
            $('#impossibleList').DataTable({
                "data": response.impossible,
                "columns": [
                    {data: "EMPLOYEE_NUM", title: "사번"},
                    {data: "NAME", title: "이름"},
                    {data: "PHONE", title: "연락처"},
                    {data: "ADDRESS", title: "주소", defaultContent: "미입력"},
                    {data: "DEP_NAME", title: "부서"},
                    {data: "POS_NAME", title: "직급"},
                    {data: "JOIN_DATE", title: "입사일"},
                    {data: "RETIRED_DATE", title: "퇴사일"}
                ],
                "language": {
                    "paginate": {
                        "previous": '<i class="icon-arrow-left"></i>',
                        "next": '<i class="icon-arrow-right"></i>'
                    }
                }
            })
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $('#possibleList').html('<div style="color:red;">데이터를 가져오는 중 오류가 발생했습니다.</div>');
            $('#impossibleList').html('<div style="color:red;">데이터를 가져오는 중 오류가 발생했습니다.</div>');
        }
    })
}

$(document).ready(async function () {
    // 페이지 로드 시 직원 목록과 퇴사 직원 목록을 표시
    await memberList();
    await resignationList();

    const modiBtn = $('#modi-btn');
    const saveBtn = $('#save-btn');
    const selects = $('.custom-select');
    const userName = $('#user_name');
    const fireBtn = $('#fire-btn');

    // 수정 버튼 클릭 시 수정 입력 필드 활성화
    modiBtn.on('click', function (){
        modiBtn.prop('hidden', true);
        saveBtn.prop('hidden', false);
        selects.prop('disabled', false);
        userName.removeClass('user_name').prop('disabled', false);
    });

    let checkModi = false;

    // 입력 필드 변경 시 수정 여부 체크
    selects.on('change',function (){
        checkModi = true;
    });

    userName.on('change', function (){
        checkModi = true;
    });

    // 저장 버튼 클릭 시 수정된 정보 서버에 전송
    saveBtn.on('click', function (){
        $('#EmployeeModalCenter').modal('hide');
        let data = {
            EMPLOYEE_NUM: $('#modal-title-num').html(),
            NICKNAME: $('#user_name').val(),
            DEP_CODE: $('#user_team').val(),
            RNR_CODE: $('#user_rnr').val(),
            POS_CODE: $('#user_pos').val()
        };
        if(checkModi) {
            fetch(`/hr/member/update`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            }).then(response => {
                if (response.ok) {
                    if ($('#memberList').DataTable()) {
                        $('#memberList').DataTable().destroy();
                    }
                    // 데이터 테이블 다시 초기화
                    memberList();
                }
            })
        }
    });

    // 퇴사 버튼 클릭 시 직원 퇴사 처리
    fireBtn.on('click', function () {
        Swal.fire({
            title: '해당 직원을 퇴사처리 하시겠습니까?',
            text: '퇴사처리 후 30일이 지나면 복구할 수 없습니다.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.value) {
                $('#EmployeeModalCenter').modal('hide');

                let data = {
                    EMPLOYEE_NUM: $('#modal-title-num').html()
                };

                fetch(`/hr/member/fired`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                }).then(response => {
                    if (response.ok) {
                        if ($('#memberList').DataTable() || $('#possibleList').DataTable()) {
                            $('#memberList').DataTable().destroy();
                            $('#possibleList').DataTable().destroy();
                            $('#impossibleList').DataTable().destroy();
                        }
                        // 데이터 테이블 다시 초기화
                        memberList();
                        resignationList();
                    }
                });
            }
        });
    });

    // 직원 목록 테이블에서 행 클릭 시 모달에 직원 상세 정보 표시
    $('#memberList tbody').on('click', 'tr', function() {
        $('#EmployeeModalCenter').modal('show');

        if (!$("#EmployeeModalCenter").hasClass("show")) {
            saveBtn.prop('hidden', true);
            modiBtn.prop('hidden', false);
            selects.prop('disabled', true);
            userName.addClass('user_name').prop('disabled', true);
        }

        let tr = $(this);
        let table = $("#memberList").DataTable();
        let rowData = table.row(tr).data();
        fetch(`/hr/member/detail?employee_num=${rowData.EMPLOYEE_NUM}`).then(response => response.json()).then(response => {
            $("#modal-title-num").html(`${response.data.EMPLOYEE_NUM || '오류'}`);
            $("#modal-title-name").html(`${response.data.NAME || '오류'}`);
            $("#user_id").html(`${response.data.USERNAME || '오류'}`);
            $("#user_name").val(`${response.data.NICKNAME || '오류'}`);
            $("#user_phone").html(`${response.data.PHONE || '오류'}`);
            $("#user_address").html(`${response.data.ADDRESS || '미입력'}`);
            $("#user_join").html(`${response.data.JOIN_DATE || '오류'}`);

            // 셀렉트 박스 렌더링 함수
            function renderSelectBox(dataArray, selectElementId, selectedCode) {
                const selectElement = $(`#${selectElementId}`);
                // 셀렉트 박스 초기화
                selectElement.empty();
                // 옵션 추가
                if(rowData.DEP_NAME == "사장"){
                    return selectElement.append(`<option value="">사장</option>`);
                }
                dataArray.forEach(item => {
                    selectElement.append(`<option value="${item.code}">${item.name}</option>`);
                });
                if (selectedCode !== undefined && selectedCode !== null) {
                    selectElement.find(`option[value="${selectedCode}"]`).attr('selected', 'selected');
                }
            }

            // 상위 부서 선택 시 하위 부서 옵션 로드
            $('#user_dep').change(function() {
                let upperDepCode = $(this).val(); // 사용자가 선택한 상위 부서 코드
                renderSelectBox(
                    response.commons.dep
                        .filter(item => item.upper_dep_code == upperDepCode)
                        .map(item => ({ code: item.dep_code, name: item.dep_name })),
                    'user_team',
                    response.data.DEP_CODE // 선택된 사용자의 부서 코드를 기본값으로 설정
                );
            });

            renderSelectBox(response.commons.pos.map(item => ({ code: item.pos_code, name: item.pos_name })), 'user_pos', response.data.POS_CODE);
            renderSelectBox(response.commons.rnr.map(item => ({ code: item.rnr_code, name: item.rnr_name })), 'user_rnr', response.data.RNR_CODE);
            renderSelectBox(
                response.commons.dep
                    .filter(item => item.upper_dep_code == 1)
                    .map(item => ({ code: item.dep_code, name: item.dep_name })),
                'user_dep',
                response.data.UPPER_DEP_CODE == 1 ? response.data.DEP_CODE : response.data.UPPER_DEP_CODE
            );
            let upperDepCode = $('#user_dep').val(); // 사용자가 선택한 상위 부서 코드
            renderSelectBox(
                response.commons.dep
                    .filter(item => item.upper_dep_code == upperDepCode || item.dep_code == upperDepCode)
                    .map(item => ({ code: item.dep_code, name: item.dep_name })),
                'user_team',
                response.data.DEP_CODE // 선택된 사용자의 부서 코드를 기본값으로 설정
            );


        });
    });

    // 퇴사 직원 목록에서 복구 버튼 클릭 시 해당 직원을 복구 처리
    $("#possibleList tbody").on('click', 'button', function (event) {
        let tr = $(this).closest('tr');
        let table = $("#possibleList").DataTable();
        let rowData = table.row(tr).data();
        let data = {
            employee_num: rowData.EMPLOYEE_NUM
        };
        if ($(this).attr('id') === "restore-btn") {
            Swal.fire({
                title: '해당 직원을 복구하시겠습니까?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: `/hr/resignation/update`,
                        type: "POST",
                        data: data,
                        success: function () {
                            if ($('#memberList').DataTable() || $('#possibleList').DataTable()) {
                                $('#memberList').DataTable().destroy();
                                $('#possibleList').DataTable().destroy();
                                $('#impossibleList').DataTable().destroy();
                            }
                            // 데이터 테이블 다시 초기화
                            memberList();
                            resignationList();
                        }
                    });
                }
            });
        }
    });

});
