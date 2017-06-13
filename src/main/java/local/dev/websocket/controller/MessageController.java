package local.dev.websocket.controller;

import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import local.dev.websocket.service.MessageService;

@Controller
@ResponseBody
public class MessageController 
{
	@Autowired
	private MessageService messageService;
	
	@RequestMapping(value = "/messages/endpoint", method = RequestMethod.GET)
	public String getServiceEndPoint(HttpServletRequest request) throws UnknownHostException
	{
		return messageService.getServiceEndpoint();
	}
}
