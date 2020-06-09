package com.aeho.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Data
public class ChatRoomVo {
	private int roomNumber;
	private String roomName;
	
	private String m_id;
}
