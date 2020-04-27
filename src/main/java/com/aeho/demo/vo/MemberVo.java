package com.aeho.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberVo {

	private String m_id;
	private String m_pwd;
	private String m_nick;
	private String m_email;
	private String m_phone;
	//회원 등급
	private int m_rate;
	//회원 장터 등급
	private int m_store;
	private String role;
	
}
