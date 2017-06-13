<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Message Community</title>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script type="text/javascript" src="resources/common.js"></script>
	</head>
	<body>
		<script type="text/javascript">
			
			var webSocket = null;
		
			$(document).ready(function(e)
			{
				getWebSocketEndPoint();
				registEventHandler();
			});

			/* 엔터 이벤트 등록. */
			function registEventHandler()
			{
				$("#message").keypress(function(event)
				{
					if(event.keyCode == 13)
					{
						sendMessage();
					}
				});
			}
			
			/* 서버의 웹소켓 엔드포인트 요청 */
			function getWebSocketEndPoint()
			{
				var uri = "/messages/endpoint";
				var methodType = "get";
				var param = null;
				var callback = connectWebSocket;
				
				cfn_ajaxRequest(uri, methodType, param, callback);
			}
			
			/* 서버의 웹소켓 연결 요청 */
			function connectWebSocket(httpResponse)
			{
				var endPoint = httpResponse.responseText;
				
				makeupWebSocket(endPoint);
			}
			
			function makeupWebSocket(endPoint)
			{
				webSocket = new WebSocket(endPoint);
				
				/* 'Web-Socket 최초 연결시' */
                webSocket.onopen = function(evt) 
                {
	                writeToScreen("Connection Established ...");
                };
                
                /* 'Web-Socket Server 로 부터 메시지 받음' */
                webSocket.onmessage = function(evt) 
                {
	                writeToScreen(evt.data);
                };
                
                /* 'Web-Socket Server 와 연결 해제 또는 연결 실패' */
                webSocket.onerror = function(evt) 
                {
	                writeToScreen('ERROR: ' + evt.data);
                };
			}
			
			/* 클라이언트 화면에 메시지 랜더링 */
			function writeToScreen(message) 
            {
                var p = document.createElement("p");
                
                p.style.wordWrap = "break-word";
                p.innerHTML = message;
                
                $("#output").prepend(p);
            }
			
			/* 웹소켓을 사용하여 클라이언트 메시지를 서버로 전달 */
			function sendMessage()
			{
				var userId = $("#userId").val();
				var message = $("#message").val();
				
				var formatedMessage = userId + ": " + message;
				
				if(message == "")
				{
					return;
				}
				
				webSocket.send(formatedMessage);
				
				clearMessage();
			}
			
			function clearMessage()
			{
				$("#message").val('');
			}
		</script>
		
		<!-- <h1 style="text-align: center;">WebSocket Client</h1> -->
        <br>
        <div style="text-align: center;">
            <form action="">
            	<input id="userId" type="text" placeholder="input your ID" value="unknown">
                <input id="message" type="text" placeholder="input your messages">
                <input id="send" type="button" onclick="sendMessage()" value="Send">
            </form>
        </div>
        <div id="output"></div>
	</body>
</html>