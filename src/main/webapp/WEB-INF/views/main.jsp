<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<script type="text/javascript">
			var wsUri = "ws://192.168.1.180:8080/websocket/echo.do";
			
			function init() 
			{
                output = document.getElementById("output");
            }
            function send_message() 
            {
            	/* 'Web-Socket Object 생성' 및 'End-Point Binding.' */
                websocket = new WebSocket(wsUri);
            	
                /* 'Web-Socket 최초 연결' */
                websocket.onopen = function(evt) 
                {
	                writeToScreen("Connected to Endpoint!");
	                writeToScreen("Message Sent: " + "Hello Web Socket !");
	                
	                websocket.send(message);
                };
                
                /* 'Web-Socket Server 로 부터 메시지 받음' */
                websocket.onmessage = function(evt) 
                {
	                writeToScreen("Message Received: " + evt.data);
                };
                
                /* 'Web-Socket Server 와 연결 해제 또는 연결 실패' */
                websocket.onerror = function(evt) 
                {
	                writeToScreen('ERROR: ' + evt.data);
                };
            }
           
            function writeToScreen(message) 
            {
                var pre = document.createElement("p");
                
                pre.style.wordWrap = "break-word";
                pre.innerHTML = message;
                
                output.appendChild(pre);
            }
            
            window.addEventListener("load", init, false);
		</script>
		
		<h1 style="text-align: center;">Hello World WebSocket Client</h1>
        <br>
        <div style="text-align: center;">
            <form action="">
                <input onclick="send_message()" value="Send" type="button">
                <input id="textID" name="message" value="Hello WebSocket!" type="text"><br>
            </form>
        </div>
        <div id="output"></div>
	</body>
</html>