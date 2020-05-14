package com.aeho.demo.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
	
	//HashMap<String, WebSocketSession> sessions = new HashMap<>();
	List<HashMap<String, Object>> cls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 chatListSession
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		//메세지 발송
		System.out.println(message);
		String msg = message.getPayload();
		JSONObject obj = JsonToObjectParser(msg);
			//chatRoomNum
		String crn = (String)obj.get("cr_num");
		HashMap<String, Object> temp = new HashMap<String, Object>();
		
		if(cls.size() > 0) {
			for(int i=0 ; i<cls.size() ; i++) {
				String cr_num = (String)cls.get(i).get("cr_num"); //세션리스트의 저장된 방번호를 가져와서
				if(cr_num.equals(crn)) { //같은값의 방이 존재할 경우	
					temp = cls.get(i); //해당 방번호의 세션리스트에 존재하는 모든 obj값을 가져옴
					break;
				}
			}
			//해당 방의 세션들만 찾아서 메세지를 발송
			for(String k : temp.keySet()){
				if(k.equals("cr_num")){ //방 번호일 경우 건너뛰기
					continue;
				}
				
				WebSocketSession wss = (WebSocketSession)temp.get(k);
				if(wss != null) {
					try {
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					}catch (IOException e) {
						// TODO: handle exception
						e.printStackTrace();
					}
				}
			}
		}
	}
	// 세션이 생성될때 시작되는 함수
		@SuppressWarnings("unchecked")
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			//소켓 연결
			super.afterConnectionEstablished(session);
			boolean flag = false;
			String url = session.getUri().toString();
			System.out.println(url);
			String cr_num = url.split("/chat/")[1];
			int idx = cls.size(); //방의 사이즈를 조사
			if(cls.size() > 0) {
				for(int i=0 ; i<cls.size() ; i++) {
					String crn = (String)cls.get(i).get("cr_num");
					if(crn.equals(cr_num)) {
						flag = true;
						idx = i;
						break;
					}
				}
			}
			if(flag) {	//존재하는 방은 세션만 추가
				HashMap<String, Object> map = cls.get(idx);
				map.put(session.getId(),session);
			}else {	//최초 생성하는 방이라면 방번호와 세션을 추가
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("cr_num", cr_num);
				map.put(session.getId(), session);
				cls.add(map);
			}
			//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송
			JSONObject obj = new JSONObject();
			obj.put("type", "getId");
			obj.put("sessionId", session.getId());
			session.sendMessage(new TextMessage(obj.toJSONString()));
		}

		// 세션이 끝날때 실행되는 함수
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			//소켓 종료
			if(cls.size() > 0) {
				for(int i=0 ; i<cls.size() ; i++) {
					cls.get(i).remove(session.getId());
				}
			}
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