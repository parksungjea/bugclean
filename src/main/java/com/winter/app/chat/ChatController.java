	package com.winter.app.chat;

import java.util.List;
import java.util.Map;

import org.apache.catalina.startup.ClassLoaderFactory.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.winter.app.customer.CustomerController;
import com.winter.app.employee.DepartmentVO;
import com.winter.app.employee.EmployeeVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat")
@Slf4j
@RequiredArgsConstructor
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	private final ChatRoomRepository repository;
	
	
	@GetMapping("rooms")
	public ModelAndView rooms() {
		log.info("# all chat rooms");
		ModelAndView mv = new ModelAndView("chat/rooms");
		
		mv.addObject("list",repository.findAllRooms());
		
		return mv;
	}
	
	@PostMapping("room")
	@ResponseBody
	public List<ChatMessage> create(@RequestBody ChatRoom chatRoom, RedirectAttributes rttr) throws Exception {
		log.info("# create chat room , name : " + chatRoom.getRoom_num());
		String name = "채팅방";
		ChatRoom chatRoom2 = new ChatRoom();
		chatRoom2.setRoom_num(chatRoom.getRoom_num());
		int check = chatService.checkExistRoom(chatRoom2);
		int create_room;
		if(check != 1) {
			create_room = chatService.createRoom(chatRoom2);
		}
		ChatMemberVO chatMemberVO = new ChatMemberVO();
		chatMemberVO.setRoom_num(chatRoom.getRoom_num());
		List<ChatMessage> list =chatService.getChatList(chatMemberVO);
		
		rttr.addFlashAttribute("roomName", repository.createChatRoom(name,chatRoom.getRoom_num()));
		return list;
	}
	
	/*
	 * @PostMapping("inRoom") public void getRoom(String roomId, Model model) {
	 * log.info("# get chat room, roomId = ", roomId);
	 * 
	 * model.addAttribute("room", repository.findRoomById(roomId)); }
	 */
	@GetMapping("room")
	public void getRoom(@RequestParam String room_num, Model model) {
		log.info("# get chat room, roomId = " + room_num);
	
		model.addAttribute("room", repository.findRoomById(room_num));
		model.addAttribute("roomId", room_num);
	}
	
	//메시지 내용 디비 저장
	@PostMapping("sendMsg")
	@ResponseBody
	public int sendMsg(@RequestBody ChatMessage chatMessage) throws Exception{
		int result = chatService.sendMsg(chatMessage);
		
		return result;
	}
	
	@PostMapping("getLastWriter")
	@ResponseBody
	public ChatMessage getLastWriter(@RequestBody ChatMessage chatMessage) throws Exception{
		return chatService.getLastWriter(chatMessage);
	}
	
	
	//사원 리스트 가져오기
	@PostMapping("list")
	@ResponseBody
	public List<Map<String, Object>> getEmployeeList( ) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setUsername(userDetails.getUsername());
		
		List<Map<String, Object>> list = chatService.getEmployeeList(employeeVO);

		return list;
	}
	//부서 리스트 가져오기
	@PostMapping("department")
	@ResponseBody
	public List<DepartmentVO> getDepartment() throws Exception{
		
		List<DepartmentVO> ar = chatService.getDepartment();
		return ar;
	}
	
	// 메신저에서 사원 이름 클릭시 사원 정보 모달창 , employee_Num으로 조회
	@PostMapping("getEmpInfo")
	@ResponseBody
	public Map<String, Object> getEmpIfo(@RequestBody EmployeeVO employeeVO) throws Exception{
		Map<String, Object> map = chatService.getEmpInfo(employeeVO);
		return map;
	}
	
	// 지메일로 사원 정보 받기 
	@PostMapping("getEmpName")
	@ResponseBody
	public Map<String, Object> getEmployeeName(@RequestBody EmployeeVO employeeVO) throws Exception{
		Map<String, Object> map = chatService.getEmpName(employeeVO);

		return map;
	}
	
	@GetMapping("getPrincipal")
	@ResponseBody
	public String getPrincipal() throws Exception{
		String name ="";
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		name = userDetails.getUsername();
		return name;
	}
	
//	채팅방 리스트 시작
	
	@PostMapping("getChattingRoom")
	@ResponseBody
	public List<Map<String,Object>> getChattingRoom(@RequestBody EmployeeVO employeeVO) throws Exception{
		return chatService.getChattingRoom(employeeVO);
	}
	
	@PostMapping("getLastMessage")
	@ResponseBody
	public ChatMessage getLastMessage(@RequestBody ChatMemberVO chatMemberVO) throws Exception{

		return chatService.getLastMessage(chatMemberVO);
	}
}
