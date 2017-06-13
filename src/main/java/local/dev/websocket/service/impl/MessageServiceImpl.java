package local.dev.websocket.service.impl;

import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import local.dev.websocket.service.MessageService;
import local.dev.websocket.util.NetworkUtil;

@Service
public class MessageServiceImpl implements MessageService
{
	private static String template = "${protocol}${address}${uri}";
	
	private static final String address = "192.168.1.180:8080";
	
	private static final String protocol = "ws://";
	
	private static final String uri = "/websocket/echo.do";
	
	@Autowired
	private NetworkUtil networkUtil;

	@Override
	public String getServiceEndpoint() throws UnknownHostException 
	{
		return template.replace("${protocol}", protocol).replace("${address}", address).replace("${uri}", uri);
//		return template.replace("${protocol}", protocol).replace("${address}", networkUtil.getMyIp()).replace("${uri}", uri);
	}
}
