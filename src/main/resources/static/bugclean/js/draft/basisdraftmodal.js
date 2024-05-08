const linebtn = document.getElementById("lineBtn");
const modal = document.getElementById("modal");
const modalBack = document.getElementById("modalBack");
const modalCloseBtn = document.getElementById("modalCloseBtn");
const filePlus = document.getElementsByClassName("filePlus");
const fileMinus = document.getElementsByClassName("fileMinus");
const files = document.getElementById("files");
const btn = document.getElementById("btn");
const temporaryBtn = document.getElementById("temporaryBtn");
const updateBtn = document.getElementById("updateBtn");
linebtn.addEventListener("click", function() {
    modalBack.classList.remove("noshow")
    modal.classList.remove("noshow")
/*    files.style.display="none";
    btn.style.display="none";
   temporaryBtn.style.display="none";
    updateBtn.style.display="none";*/
})

modalCloseBtn.addEventListener("click", function() {
    modalBack.classList.add("noshow")
    modal.classList.add("noshow")
/*    files.style.display="block";
    btn.style.display="block";
    temporaryBtn.style.display="block";
    updateBtn.style.display="block";*/
})

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
                        <input type="file" class="custom-file-input" name="attach" id="file-input-${filesCounter}">
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
