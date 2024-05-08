<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<html lang="en" xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.thymeleaf.org/extras/spring-security">
<link rel="stylesheet" href="/bugclean/css/chat.css">
<div>
    <th:block th:replace="~{/layout/basic :: setContent(~{this :: content})}">
        <th:block th:fragment="content">

            <div id="chat_container" class="container">
                <div class="col-12" id="chat_person">
                    
                </div>
                <div>
                    <div id="msgArea" class="col"></div>
                    
                </div>
                <div class="col-6"></div>
            </div>
            

            
        </th:block>
    </th:block>
    <div class="col-12 inputbox" style="position: relative; bottom: 0;">
        <div class="input-group mb-3" >
            <input type="text" id="msg" onkeyup="enterKey()" class="form-control">
        </div>
        <div class="input-group-append">
            <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>

const chat_container = document.getElementById("chat_container");
chat_container.scrollTop = chat_container.scrollHeight;
let lastWriter;
let username1 = '${pageContext.request.userPrincipal.name}';
let username2;
const sendData = localStorage.getItem('sendData');
const sendDataMsg = JSON.parse(localStorage.getItem('sendDateMsg'));
    
                    // 로그인 한 사람 사원번호 예정
                    let id1 = sendData.substring(0,7);
                    // 상대방 번호 될 예정
                    let id2 = sendData.substring(7);
                    let t;
window.onload = function(){
    fetch("/chat/getEmpName",{
                    method:"POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body : JSON.stringify({
                        username : username1
                    })
                }).then(res=>res.json())
                .then(res=>{
                    username1 = res.NAME;
                    

                    if(res.EMPLOYEE_NUM != id1){
                        t = id2;
                        id2 = id1;
                        id1 = t;
                    }
                    fetch("/chat/getEmpInfo",{
                        method:"POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body : JSON.stringify({
                        employee_num : id2
                    })
                    }).then(res=>res.json())
                    .then(res=>{
                        let profile= "/focus-bootstrap-main/theme/images/base_profile.png";
                        if(res.PROFILE != null){
                            profile = "/files/profile/" +res.PROFILE 
                        }
                        document.getElementById("chat_person").innerHTML = '<div style="display : inline-block"><img class="user2_profile" id="user2_profile" src="' +profile +'"></div>' + 
                        '<b>'+ res.DEP_NAME+" " + res.POS_NAME+ " " + res.NAME + '</b><hr> ';
                        username2 = res.NAME;

                                        // 채팅내역 불러오기 성공! 집가서 채팅창에 뿌려주면됩니다!!!
                                        for(let i=0;i<sendDataMsg.length;i++){
                                            let send_Time = sendDataMsg[i].msg_send_time.substring(5,16);
                                            let send_hour = parseInt(send_Time.substring(6,8));
                                            let send_apm = '오전'
                                           
                                            if(send_hour>=12 && send_hour != 24){
                                                send_apm = '오후'
                                            }
                                            if(send_hour%12 != 0){
                                                send_hour %= 12;
                                            }else if(send_hour %12 ==0 && send_hour/12 == 2){
                                                send_hour = '00';
                                            }
                                            else{
                                                send_hour=12;
                                            }

                                            let send_date =  send_Time.substring(0,5)+ " "+ send_apm + " " + +send_hour + " : " + send_Time.substring(send_Time.length-2,send_Time.length);

                                            if(i>0){
                                                if(sendDataMsg[i].employee_num == sendDataMsg[i-1].employee_num && sendDataMsg[i].msg_send_time.substring(8,16) == sendDataMsg[i-1].msg_send_time.substring(8,16)){
                                                    if(sendDataMsg[i].employee_num === id1){
                                                                str = "<div class='col-6 username1'>";
                                                                str += "<div class='alert alert-secondary' style='padding : 2%; font-size:small;'>";
                                                                str += sendDataMsg[i].msg_contents ;
                                                                str += "</div></div>";
                                                                $("#msgArea").append(str);
                                                            }
                                                            else{
                                                                str = "<div class='col-6 username2'>";
                                                                str += "<div class='alert alert-warning' style='padding : 2%; font-size:small;'>";
                                                                str +=   sendDataMsg[i].msg_contents ;
                                                                str += "</div>"
                                                                $("#msgArea").append(str);
                                                            }
                                                    
                                                }else if(sendDataMsg[i].employee_num === id1){
                                                                str = "<div class='col-6 username1'>";
                                                                str += "<p style='font-size : x-small; margin-top : auto;'>"+send_date + "</p>";
                                                                str += "<div class='alert alert-secondary' style='padding : 2%; font-size:small;'>";
                                                                str += sendDataMsg[i].msg_contents ;
                                                                str += "</div></div>";
                                                                $("#msgArea").append(str);
                                                            }
                                                            else{
                                                                str="<div class='user2_name'>" + '<img class="user2_profile" src="'+profile+'">'+ username2 +"</div>";
                                                                str += "<div class='col-6 username2'>";
                                                                
                                                                str += "<div class='alert alert-warning' style='padding : 2%; font-size:small;'>";
                                                                str +=   sendDataMsg[i].msg_contents ;
                                                                str += "</div>"
                                                                str +=  "<p style='font-size : x-small; margin-top : auto;'>"+send_date+"</p>"+"</div>";
                                                                $("#msgArea").append(str);
                                                            }
                                            }else if(i==0){
                                                if(sendDataMsg[i].employee_num === id1){
                                                str = "<div class='col-6 username1'>";
                                                str += "<p style='font-size : x-small; margin-top : auto;'>"+send_date + "</p>";
                                                str += "<div class='alert alert-secondary' style='padding : 2%; font-size:small;'>";
                                                str += sendDataMsg[i].msg_contents ;
                                                str += "</div></div>";
                                                $("#msgArea").append(str);
                                            }
                                            else{
                                                str="<div class='user2_name'>" + '<img class="user2_profile" src="'+profile+'">'+ username2 +"</div>";
                                                str += "<div class='col-6 username2'>";
                                                
                                                str += "<div class='alert alert-warning' style='padding : 2%; font-size:small;'>";
                                                str +=   sendDataMsg[i].msg_contents ;
                                                str += "</div>"
                                                str +=  "<p style='font-size : x-small; margin-top : auto;'>"+send_date+"</p>"+"</div>";
                                                $("#msgArea").append(str);
                                            }
                                        }          
                                        }

                                        scroll();
                    })
                })
}
                
    
                    var roomName = "${room.name}";
                    var roomId = sendData;
                    
    
                    
                    let message;

                    var today = new Date();   

                    var hours = ('0' + today.getHours()).slice(-2); 
                    var minutes = ('0' + today.getMinutes()).slice(-2);
                    var timeString = hours + ':' + minutes
    
                    var sockJs = new SockJS("/stomp/chat");
                    //1. SockJS를 내부에 들고있는 stomp를 내어줌
                    var stomp = Stomp.over(sockJs);
    
                    //2. connection이 맺어지면 실행
                    stomp.connect({}, function (){
    
                       //4. subscribe(path, callback)으로 메세지를 받을 수 있음
                       stomp.subscribe("/sub/chat/room/" + roomId, function (chat) {
                           var content = JSON.parse(chat.body);
    
                           var writer = content.writer;
                           var str = '';
                           fetch("/chat/getLastWriter",{
                            method : 'POST',
                            headers: {
                                "Content-Type": "application/json",
                            },
                            body : JSON.stringify({
                                room_num : roomId
                            })
                           }).then(res=>res.json())
                           .then(res=>{
                            var today = new Date(); 
                            var hours = ('0' + today.getHours()).slice(-2); 
                            var minutes = ('0' + today.getMinutes()).slice(-2);
                            var timeString = hours + ':' + minutes
                           
                            if(id1 == res.employee_num && res.msg_send_time.substring(11,16) == timeString ){
                                if(writer === username1){
                                    str = "<div class='col-6 username1'>";
                                    str += "<div class='alert alert-secondary' style='padding : 2%; font-size:small';>";
                                    str +=  content.message;
                                    str += "</div></div>";
                                    $("#msgArea").append(str);
                           }
                                else{
                                    str = "<div class='col-6 username2'>";
                                    str += "<div class='alert alert-warning' style='padding : 2%; font-size:small';>";
                                    str +=  content.message ;
                                    str += "</div>";
                                    $("#msgArea").append(str);
                                }
                            }else{
                                if(writer === username1){
                                    str = "<div class='col-6 username1'>";
                                    str += "<p style='font-size : x-small; margin-top : auto;'>"+ timeString +"</p>";
                                    str += "<div class='alert alert-secondary' style='padding : 2%; font-size:small';>";
                                    str +=  content.message;
                                    str += "</div></div>";
                                    $("#msgArea").append(str);
                           }
                                else{
                                    str="<div class='user2_name'>" + '<img id="user2_profile" src="/focus-bootstrap-main/theme/images/base_profile.png">'+ username2 +"</div>";
                                    str += "<div class='col-6 username2'>";
                                    str += "<div class='alert alert-warning' style='padding : 2%; font-size:small';>";
                                    str +=  content.message ;
                                    str += "</div>";
                                    str += "<p style='font-size : x-small; margin-top : auto;'>"+ timeString + "</p>" + "</div>";
                                    $("#msgArea").append(str);
                                }
                            }
                            scroll();
                           })

                           
                           
                           
                       });
    
                       //3. send(path, header, message)로 메세지를 보낼 수 있음
                       stomp.send('/pub/chat/enter', {}, JSON.stringify({ room_num: roomId, writer: username1}))
                    });
    
                    $("#button-send").on("click", function(e){
                        var msg = document.getElementById("msg");
                        message = $("#msg").val();
                        stomp.send('/pub/chat/message', {}, JSON.stringify({room_num: roomId, message: msg.value, writer: username1}));
                        sendMessage(roomId,msg.value,id1);
                        msg.value = '';
                    });
                    function enterKey(){
                        if(window.event.keyCode == 13){
                        var msg = document.getElementById("msg");
                        message = $("#msg").val();
                        stomp.send('/pub/chat/message', {}, JSON.stringify({room_num: roomId, message: msg.value, writer: username1}));
                        sendMessage(roomId,msg.value,id1);
                        msg.value = '';
                        }
                    }        
                    
                    function sendMessage(roomId,msg,username){
                        fetch("/chat/sendMsg",{
                            method : "POST",
                            headers: {
                                "Content-Type": "application/json",
                            },
                            body : JSON.stringify({
                                employee_num : username,
                                msg_contents : msg,
                                room_num : roomId
                            })
                        }).then(res=>res.json())
                        .then(res=>{
                            
                           
                        })
                    }

                    window.onresize = function(){
                        window.resizeTo(400,665)
                    }

                    function scroll(){
                        // 문서의 높이
                        var chatContainerHeight = document.getElementById("chat_container").scrollHeight;

                                        // chat_container의 스크롤 가능한 높이
                        var chatContainerScrollHeight = document.getElementById("chat_container").clientHeight;

                        // chat_container의 스크롤바를 최 하단으로 이동
                        document.getElementById("chat_container").scrollTop = chatContainerHeight - chatContainerScrollHeight;

                    }

        </script>



</html>