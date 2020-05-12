package com.aeho.demo.handler;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@Component
public class SocketTextHandler extends TextWebSocketHandler {
	
	HashMap<String, WebSocketSession> sessions = new HashMap<>();
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		String payload = message.getPayload();
		JSONObject obj = JsonToObjectParser(payload);
		
		try {
			for(String key : sessions.keySet()) {
				WebSocketSession ss = sessions.get(key);
				ss.sendMessage(new TextMessage(payload));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	// 세션이 생성될때 시작되는 함수
		@SuppressWarnings("unchecked")
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			super.afterConnectionEstablished(session);
			sessions.put(session.getId(), session);
			JSONObject obj = new JSONObject();
			obj.put("type", "getId");
			obj.put("sessionId",session.getId());
			session.sendMessage(new TextMessage(obj.toJSONString()));
		}

		// 세션이 끝날때 실행되는 함수
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			sessions.remove(session.getId());
			super.afterConnectionClosed(session, status);
		}
		private static JSONObject JsonToObjectParser(String jsonStr) {
			JSONParser parser = new JSONParser();
			JSONObject obj = null;
			try {
				obj = (JSONObject) parser.parse(jsonStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			return obj;
		}
}
