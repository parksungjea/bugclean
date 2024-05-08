package com.winter.app.chat;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.winter.app.employee.DepartmentVO;
import com.winter.app.employee.EmployeeVO;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ChatService {
	
	@Autowired
	ChatDAO chatDAO;
	//방 생성 및 해당 방에 인원 추가
	public int createRoom(ChatRoom chatRoom) throws Exception{
		int result = chatDAO.createRoom(chatRoom);
		String roomId = chatRoom.getRoom_num();
		String user1 = roomId.substring(0, 7);
		String user2 = roomId.substring(7);
		
		ChatMemberVO chatMemberVO1 = new ChatMemberVO();
		chatMemberVO1.setEmployee_num(user1);
		chatMemberVO1.setRoom_num(roomId);
		chatDAO.inviteChatRoom(chatMemberVO1);
		
		ChatMemberVO chatMemberVO2 = new ChatMemberVO();
		chatMemberVO2.setEmployee_num(user2);
		chatMemberVO2.setRoom_num(roomId);
		chatDAO.inviteChatRoom(chatMemberVO2);
		
		return result;
		
	}
	
	public List<ChatMessage> getChatList(ChatMemberVO chatMemberVO) throws Exception{
		List<ChatMessage> li = chatDAO.getChatList(chatMemberVO);
		if(li == null) {
			ChatMessage chatMessage = new ChatMessage();
			chatMessage.setEmployee_num("0");
			li.add(chatMessage);
		}
		
		return li;
	}
	// 대화하려는 방이 이미 db에 존재하는지 확인. 존재하지 않으면 크레이트로 넘어감 
	public int checkExistRoom(ChatRoom chatRoom) throws Exception{
		return chatDAO.checkExistRoom(chatRoom);
	}
	
	public int sendMsg(ChatMessage chatMessage) throws Exception{
		return chatDAO.sendMsg(chatMessage);
	}
	
	public ChatMessage getLastWriter(ChatMessage chatMessage) throws Exception{
		
		ChatMessage chatMessage2 = chatDAO.getLastWriter(chatMessage);
		if (chatMessage2 == null) {
			chatMessage2 = new ChatMessage();
			chatMessage2.setEmployee_num("0");
			chatMessage2.setMsg_send_time("00000000000000");
		}
		return chatMessage2;
	}
	
	
	public List<Map<String, Object>> getEmployeeList(EmployeeVO employeeVO) throws Exception{
		
		return chatDAO.getEmployeeList(employeeVO);
	}
	
	public List<DepartmentVO> getDepartment() throws Exception{
		
		return chatDAO.getDepartment();
	}
	
	public Map<String, Object> getEmpInfo(EmployeeVO employeeVO) throws Exception{
		return chatDAO.getEmpInfo(employeeVO);
	}
	
	public Map<String, Object> getEmpName(EmployeeVO employeeVO) throws Exception{
		return chatDAO.getEmpName(employeeVO);
	}
	
//	채팅방 리스트
	public List<Map<String,Object>> getChattingRoom(EmployeeVO employeeVO) throws Exception {
		return chatDAO.getChattingRoom(employeeVO);
	}
	
	public ChatMessage getLastMessage(ChatMemberVO chatMemberVO) throws Exception{
		ChatMessage chatMessage = new ChatMessage();
		chatMessage = chatDAO.getLastMessage(chatMemberVO);
		if(chatMessage ==null ) {
			chatMessage.setEmployee_num(chatMemberVO.getRoom_num());
			chatMessage.setMsg_contents("0");
			chatMessage.setRoom_num(chatMemberVO.getRoom_num());;
		}
		return chatMessage;
	}
	
}
