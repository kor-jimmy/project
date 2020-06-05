package com.aeho.demo.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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
	
	private int m_reportcnt;
	private int m_lovecnt;
	private int m_hatecnt;
	
	private String m_state;
	private Date m_bandate; 
	
	//수정할 비밀번호
	private String newPwd;
	
	private String m_img;
	private MultipartFile img_file;
	
}
