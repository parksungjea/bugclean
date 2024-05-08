// 게시판 데이터를 가져와 화면에 표시하는 함수
const pageLoad = async () => {
    // 페이지 타이틀에서 카테고리 코드를 가져옴
    const cate_code = $('#page-title').data('target');

    // 서버에서 게시판 데이터를 비동기적으로 가져옴
    await $.ajax({
        url: `board/mainPage?cate_code=${cate_code}`,
        type: "GET",
        success: function (response) {
            // 서버에서 받은 HTML 코드를 카드 바디에 추가
            $(".card-body").empty().html(response);
        },
        error: function (xhr, status, error) {
            // 에러 처리
            console.error(xhr.responseText);
        }
    });

    // 초기 코드를 가져와서 해당 테이블을 표시하도록 설정
    const initialCode = $('.active').data('source');
    const showTable = $(`#list-${initialCode}`);
    if (!showTable.hasClass('show')) {
        $('#list-1').removeClass('show').removeClass('active');
        showTable.addClass('show').addClass('active');
    }

    // 게시판 데이터를 가져와서 표시하는 함수 호출
    await fetchAndDisplayBoard(initialCode, 1);

    // 검색 버튼 클릭 이벤트 핸들러 설정
    $('#search-btn').on('click', function () {
        const code = $('.active').data('source');
        const search = $('#search').val();
        const kind = $('#kind').val();
        fetchAndDisplayBoard(code, 1, search, kind);
    });

    // 검색 input 요소에 대한 keypress 이벤트 핸들러 추가
    $('#search').on('keypress', function (event) {
        if (event.keyCode === 13) {
            $('#search-btn').click();
        }
    });

    // 메뉴 클릭 이벤트 핸들러 설정
    $('.nav-link').on('click', function () {
        const pageTitle = $('#page-title');
        if (!$(this).hasClass('active')) {
            pageTitle.fadeOut(200).html("&ensp;" + $(this).text()).fadeIn(100);
            $('#title-a').html($(this).text());
            $('#search').val("");
            const code = $(this).data('source');

            pageTitle.data('target', code);
            fetchAndDisplayBoard(code, 1);
        }
    });

    // 게시글 행 클릭 이벤트 핸들러 설정
    $('.board-body').on('click', 'tr', function () {
        const board_code = ($(this).data('board-code').trim());
        const cate_code = $('#page-title').data('target');

        const formData = new FormData;
        formData.append("board_code", board_code);
        formData.append("cate_code", cate_code);
        boardDetail(formData);
    });

    // 게시글 생성 버튼 클릭 이벤트 핸들러 설정
    $('#create-board').on('click', function () {
        createBoard(null);
    });
};

// 첨부파일 삭제 함수
const deleteFile = (file_code) => {
    // Swal을 사용하여 사용자에게 확인 메시지 표시
    return Swal.fire({
        title: '첨부파일을 삭제 하시겠습니까?',
        text: '삭제하면 첨부파일 관련 정보가 초기화 됩니다.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '확인',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.value) {
            // 파일 코드를 서버로 전송하여 파일 삭제
            const fileForm = new FormData;
            fileForm.append("file_code", file_code);
            return fetch('board/deleteFile', {
                method: "POST",
                body: fileForm
            }).then(response => {
                if (response.ok) {
                    // 게시판 다시 생성
                    let board_code = ($('#board-title').data('board-code'));
                    createBoard(board_code);
                }
            });
        }
    });
};

// 게시글 상세보기 함수
const boardDetail = async (formData) => {
    // 서버에서 게시글 상세 정보 가져옴
    await fetch("board/detail", {
        method: 'POST',
        body: formData
    }).then(response => {
        return response.text();
    }).then(data => {
        // 게시글 상세 정보를 카드 바디에 추가
        $('.card-body').empty().html(data);
    });

    // 리스트 버튼 클릭 이벤트 핸들러 설정
    $('#list-btn').on('click', function () {
        pageLoad();
    });

    // 수정 버튼 클릭 이벤트 핸들러 설정
    $('#update-btn').on('click', function () {
        createBoard(formData.get("board_code"));
    });
};

// 게시판 데이터 가져와서 표시하는 함수
const fetchAndDisplayBoard = (code, page, search = '', kind = '') => {
    // URL 구성
    let url = `board/list?code=${code}&page=${page}`;
    if (search !== '' && kind !== '') {
        url += `&search=${search}&kind=${kind}`;
    }

    // 서버에서 데이터를 가져와서 화면에 표시
    return fetch(url)
        .then(response => response.json())
        .then(data => {
            // 테이블 내용 업데이트
            const tbody = $(`#list-${code} tbody`);
            tbody.empty();

            if(!data.roleCheck && code===1){
                $('#create-board').attr('hidden', true);
            }else {
                $('#create-board').attr('hidden', false);
            }

            if (data.boardList.length === 0) {
                // 검색 결과가 없을 때 처리
                const noResultRow = `<tr><td colspan="5">검색 결과가 없습니다.</td></tr>`;
                tbody.append(noResultRow);
                return;
            }



            // 테이블에 데이터 추가
            data.boardList.forEach(item => {
                const { BOARD_CODE, BOARD_TITLE, NAME, BOARD_DATE, BOARD_HIT } = item;
                const newRow = `
                    <tr data-board-code="${BOARD_CODE}">
                        <td>${BOARD_CODE}</td>
                        <td>${BOARD_TITLE}</td>
                        <td>${NAME}</td>
                        <td>${BOARD_DATE}</td>
                        <td>${BOARD_HIT}</td>
                    </tr>
                `;
                tbody.append(newRow);
            });

            // 페이지네이션 생성
            createPager(data.pagination, code, search, kind);
        })
        .catch(error => {
            console.error('Error:', error);
        });
};

// 페이지 인디케이터 생성 함수
const createPager = (pagination, code, search, kind) => {
    const paginationList = $('.pagination');
    paginationList.empty();

    paginationList.append(`<li class="page-item page-indicator ${pagination.startNum <= 1 ? 'disabled' : ''}"><a class="page-link" onclick="moveToPage(${pagination.startNum - 1}, '${code}', '${search}', '${kind}')"><i class="icon-arrow-left"></i></a></li>`);

    for (let i = pagination.startNum; i <= pagination.lastNum; i++) {
        paginationList.append(`<li class="page-item ${i === pagination.page ? 'active' : ''}"><a class="page-link" onclick="moveToPage(${i}, '${code}', '${search}', '${kind}')">${i}</a></li>`);
    }

    paginationList.append(`<li class="page-item page-indicator ${pagination.lastNum >= pagination.totalPage ? 'disabled' : ''}"><a class="page-link" onclick="moveToPage(${pagination.lastNum + 1}, '${code}', '${search}', '${kind}')"><i class="icon-arrow-right"></i></a></li>`);
};

// 페이지 이동 함수
const moveToPage = (page, code, search, kind) => {
    fetchAndDisplayBoard(code, page, search, kind);
};

// 게시글 생성 또는 수정 함수
const createBoard = async (board_code) => {
    // 카테고리 코드 가져오기
    let cate_code = $('#page-title').data("target");
    await $.ajax({
        url: `board/create?cate_code=${cate_code}${board_code == null ? '' : '&board_code=' + board_code}`,
        type: "GET",
        success: function (response) {
            // 서버에서 받은 HTML 코드를 카드 바디에 추가
            $(".card-body").empty().html(response);
        },
        error: function (xhr, status, error) {
            // 에러 처리
            console.error(xhr.responseText);
        }
    });

    // 에디터 설정
    $(".summernote").summernote({
        height: 350,       // 에디터의 높이
        minHeight: 350, // 최소 높이
        maxHeight: 500, // 최대 높이
        focus: true,     // 에디터 로드 후 포커스 여부
        toolbar: [
            // [groupName, [list of button]]
            ['fontsize', ['fontsize']],
            ['font', ['strikethrough', 'superscript', 'subscript']],
            ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
            ['color', ['forecolor']],
            ['table', ['table']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['insert', ['picture', 'link']],
        ],
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
        fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
        callbacks: {
            onImageUpload: files => {
                // 이미지를 서버에 업로드하고 URL을 반환하는 콜백함수
                uploadSummerImg(files[0]);
            }
        }

    });
    const uploadSummerImg = (file)=>{
        let imgForm = new FormData;
        imgForm.append("file",file);

        fetch('board/upload/image',{
            method: 'POST',
            body: imgForm
        }).then((response) => {
            // 서버에서 이미지 URL을 받아옴
            return response.text(); // JSON 형태의 응답을 파싱
        }).then((data) => {
            const imgUrl = data; // 서버에서 받은 이미지 URL
            console.log(imgUrl)
            const imgNode = document.createElement('img');
            imgNode.src = imgUrl;
            $('.summernote').summernote('insertNode', imgNode);
        })
    }

    // 첨부 파일 처리 및 관련 이벤트 핸들러 설정
    let attachmentCounter = $('#files .attached-index').length;
    let filesCounter = $('#files .input-group').length;
    const maxAttachments = 3;
    // 플러스 버튼 클릭 이벤트 핸들러 설정
    const attachment = $('#attachment-group');
    attachment.on('click', '.plus-file', function () {
        if (attachmentCounter + filesCounter < maxAttachments) {
            filesCounter++;
            let newAttachmentId = 'attachment-' + filesCounter;
            let newAttachmentHtml = `
                <div class="input-group mb-1" id="${newAttachmentId}">
                    <div class="input-group-prepend">
                        <span class="input-group-text">첨부파일</span>
                    </div>
                    <div class="custom-file col">
                        <input type="file" class="custom-file-input" id="file-input-${filesCounter}">
                        <label class="custom-file-label" for="file-input-${filesCounter}">파일을 선택하세요</label>
                    </div>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-sm btn-dark plus-file" >+</button>
                        <button type="button" class="btn btn-sm btn-dark minus-file" data-target="${newAttachmentId}">−</button>
                    </div>
                </div>`;
            $('#attachment-group').append(newAttachmentHtml);

            // 첨부파일 갯수에 따라 플러스/마이너스 버튼 활성화/비활성화 설정
            updateButtonStatus();
        }
    });

    // 파일 선택 시 라벨 변경 이벤트 설정
    attachment.on('change', '.custom-file-input', function () {
        let fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').html(fileName);
    });

    // 마이너스 버튼 클릭 이벤트 설정
    attachment.on('click', '.minus-file', function () {
        $(`#${$(this).data('target')}`).remove();
        filesCounter--;
        // 첨부파일 갯수에 따라 플러스/마이너스 버튼 활성화/비활성화 설정
        updateButtonStatus();
    });

    // 플러스/마이너스 버튼 활성화/비활성화 함수 설정
    const updateButtonStatus = () => {
        $('.plus-file').prop('disabled', attachmentCounter + filesCounter >= maxAttachments);
        $('.minus-file').prop('disabled', filesCounter <= 1);
    };

    // 페이지 로드시 버튼 초기화
    updateButtonStatus();

    // 파일 삭제 버튼 클릭 이벤트 설정
    $('.file-code').on('click', async function () {
        let result = await deleteFile($(this).data("file-code"));
        if (result === 1) {
            attachmentCounter--;
        }
    });

    // 닫기 버튼 클릭 이벤트 핸들러 설정
    $('#close-btn').on('click', function () {
        pageLoad();
    });

    // 삭제 버튼 클릭 이벤트 핸들러 설정
    $('#delete-btn').on('click', function () {
        // 사용자에게 삭제 여부 확인
        Swal.fire({
            title: '게시글을 삭제 하시겠습니까?',
            text: '삭제하면 복구 불가능 합니다.',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then(async (result) => {
            if (result.value) {
                // 게시글 삭제 요청
                let new_cate_code = $('#page-title').data("target");
                if (new_cate_code === undefined) {
                    new_cate_code = $('.nav-item .active').data("source");
                }
                let board_code = $('#board-title').data('board-code');
                let formDataDel = new FormData;
                formDataDel.append("board_code", board_code);
                formDataDel.append("cate_code", new_cate_code);

                await fetch("board/delete", {
                    method: 'POST',
                    body: formDataDel
                }).then((response) => {
                    if (response.ok) {
                        pageLoad();
                    }
                })
            }
        })
    });

    // 저장 버튼 클릭 이벤트 핸들러 설정
    $('#save-btn').on('click', async (e) => {
        e.preventDefault(); // 기본 동작 방지
        let new_cate_code = $('#page-title').data("target");
        if (new_cate_code === undefined) {
            new_cate_code = $('.nav-item .active').data("source");
        }

        // 제목 입력 값 가져오기
        const title = $('#board-title');
        if (title.val() === "") {
            // 제목이 비어있는 경우 경고 메시지 표시
            return Swal.fire({
                title: '제목은 필수입력 사항입니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소',
            });
        }

        // 작성자 정보 가져오기
        const employeeNum = $('#employee_num').val();

        // 에디터 내용 가져오기
        const content = $('.summernote').summernote('code');

        // 첨부 파일 처리
        const files = Array.from($('.custom-file-input')).flatMap(input => [...input.files]);

        // 폼 데이터 객체 생성
        const formData = new FormData();
        formData.append("board_code", title.data('board-code'));
        formData.append('cate_code', new_cate_code);
        formData.append('board_title', title.val());
        formData.append('employee_num', employeeNum);
        formData.append('board_contents', content);
        files.forEach(file => formData.append('files', file));

        try {
            // 서버로 데이터 전송
            const response = await fetch('board/create', {
                method: 'POST',
                body: formData
            });

            if (response.ok) {
                const responseData = await response.json();
                // 성공 메시지 표시 또는 리다이렉션 등의 후속 작업 수행
                await pageLoad();
            } else {
                console.error('Error:', response.statusText);
                // 에러 메시지 표시 또는 다른 처리 수행
            }
        } catch (error) {
            console.error('Error:', error);
            // 에러 메시지 표시 또는 다른 처리 수행
        }
    });
};
