# spring-websocket

-. 웹 소켓을 사용한 서버-클라이언트간 양방향 메시지 전송.

-. spring-websocket 라이브러리를 사용.

-. pom.xml에 기술하여, maven build 시 인터넷에서 내려 받도록 설정.

-. Class 설명

	(1) MessageController.java : 웹소켓에 연결하기 위한 EndPoint를 반환하는 Restful API 게시.
	
	(2) MessageServiceImpl.java : 연결 가능한 웹소켓 EndPoint 구성.
	
	(3) SocketHandler.java : 웹소켓 Connection, Sending, Error 등 이벤트 처리.
	
	(4) servlet-context.xml : 웹소켓 핸들러 정의 & 등록.

