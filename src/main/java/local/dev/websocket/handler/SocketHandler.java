package local.dev.websocket.handler;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SocketHandler extends TextWebSocketHandler implements InitializingBean
{
	private static final Logger logger = LoggerFactory.getLogger(SocketHandler.class); 
	
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	
	@Override
	public void afterPropertiesSet() throws Exception
	{
		logger.debug("----------------------------------------------------------------");
		logger.debug("- Created SocketHandler Beans -");
		logger.debug("----------------------------------------------------------------");
		
		this.test();
	}
	
	private void test()
	{
		Thread thread = new Thread(){
			int n=0;
			
			@Override
			public void run()
			{
				while(true)
				{
					try
					{
						sendMessage("send message index " + n++);
						Thread.sleep(1000);
					}
					catch (Exception e) 
					{
						e.printStackTrace();
						break;
					}
				}
			}
		};
		
		thread.start();
	}

	/* Connection Closed */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception
	{
		super.afterConnectionClosed(session, status);
		
		sessionSet.remove(session);
		
		logger.debug("------------------------ [INFO] Removed Session ...");
	}
	
	/* Connection Establised */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception
	{
		super.afterConnectionEstablished(session);
		
		sessionSet.add(session);
		
		logger.debug("------------------------ [INFO] Added Session ...");
	}
	
	/* Received Message From Connected Client */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception
	{
		super.handleMessage(session, message);
		
		logger.debug("------------------------ [INFO] Received Message ...");
	}
	
	/* Sending Message Error */
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception
	{
		super.handleTransportError(session, exception);
		
		logger.debug("------------------------ [ERROR] Can Not Open Web Socket ...");
	}
	
	/* Sending Message Error */
	@Override
	public boolean supportsPartialMessages()
	{
		logger.debug("------------------------ [INFO] Called Method ...");
		
		return super.supportsPartialMessages();
	}
	
	private String sendMessage(String message)
	{
		for(WebSocketSession session : this.sessionSet)
		{
			if(session.isOpen())
			{
				try
				{
					session.sendMessage(new TextMessage(message));
				}
				catch (IOException e)
				{
					e.printStackTrace();
					logger.debug("--------------------------- [ERROR] Fail to Send Message !");
				}
			}
		}
		
		return message;
	}
}
