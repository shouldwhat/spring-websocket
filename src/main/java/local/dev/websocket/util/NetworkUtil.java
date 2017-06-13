package local.dev.websocket.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.stereotype.Component;

@Component
public class NetworkUtil 
{
	public String getMyIp() throws UnknownHostException
	{
		return InetAddress.getLocalHost().getHostAddress();
	}
}
