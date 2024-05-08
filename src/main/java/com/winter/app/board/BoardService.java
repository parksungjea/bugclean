package com.winter.app.board;

import com.winter.app.util.commons.FileManager;
import com.winter.app.util.pagination.Pagination;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class BoardService {

    @Autowired
    BoardDAO boardDAO;

    @Value("${app.upload.basePath}")
    private String uploadPath;
    @Value("${app.upload.imgPath}")
    private String imgPath;

    @Autowired
    FileManager fileManager;

    public List<BoardCateVO> getCateList() throws Exception {
        return boardDAO.getCateList();
    }

    public Map<String, Object> getBoardList(Pagination pagination) throws Exception {

        Long totalCount = boardDAO.getTotalCount(pagination);
        pagination.makeNum(totalCount);
        pagination.makeRow();
        Map<String, Object> map = new HashMap<>();
        map.put("boardList",boardDAO.getBoardList(pagination));
        map.put("pagination",pagination);

        boolean roleCheck = false;
        Collection<? extends GrantedAuthority> arr = SecurityContextHolder.getContext().getAuthentication().getAuthorities();

        for(GrantedAuthority role : arr){
            if(role.getAuthority().equals("ROLE_PERSON")||role.getAuthority().equals("ROLE_SUPPORT")||role.getAuthority().equals("ROLE_CEO")){
                roleCheck = true;
                break;
            }
        }

        map.put("roleCheck",roleCheck);

        return map;
    }

    public Map<String, Object> getBoardDetail(BoardVO boardVO) throws Exception{
        return boardDAO.getBoardDetail(boardVO);
    }

    public int setBoard(BoardVO boardVO, MultipartFile [] files) throws Exception{
        if(boardVO.getBoard_code() == null){
            if(boardVO.getCate_code()==1){
                boardVO.setBoard_code(boardDAO.getNoticeSeq());
            }
            else{
                boardVO.setBoard_code(boardDAO.getFreeSeq());
            }
        }

        int result = boardDAO.addBoard(boardVO);
        if(files != null){

            for (MultipartFile multipartFile : files) {
                if (multipartFile.isEmpty()) {
                    continue;
                }

                String fileName = fileManager.fileSave(uploadPath, multipartFile, false);
                BoardFileVO fileVO = new BoardFileVO();
                fileVO.setBoard_code(boardVO.getBoard_code());
                fileVO.setFile_name(fileName);
                fileVO.setOrigin_name(multipartFile.getOriginalFilename());
                fileVO.setCate_code(boardVO.getCate_code());
                fileVO.setFile_code(boardDAO.getSeq());
                result = boardDAO.addFile(fileVO);

                if (result == 0) {
                    throw new Exception();
                }
            }
        }
        return result;
    }

    public String uploadImg(MultipartFile file)throws Exception{
        String imgURL = fileManager.fileSave(imgPath,file,true);
        return imgURL;
    }

    public BoardFileVO getFileDetail(BoardFileVO boardFileVO)throws Exception{
        return boardDAO.getFileDetail(boardFileVO);
    }

    public int deleteFile(BoardFileVO boardFileVO)throws Exception{
        return boardDAO.deleteFile(boardFileVO);
    }

    public int deleteBoard(BoardVO boardVO) throws Exception{
        return boardDAO.deleteBoard(boardVO);
    }

    public int updateStatus(BoardVO boardVO) throws Exception{
        return boardDAO.updateStatus(boardVO);
    }

    public int updateHit(BoardVO boardVO) throws Exception{
        return boardDAO.updateHit(boardVO);
    }
}
