package com.aeho.demo.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.aeho.demo.vo.MemberVo;

public class MemberPrincipal implements UserDetails {
	
	
	private MemberVo memberVo;

	public MemberPrincipal(MemberVo memberVo) {
		this.memberVo = memberVo;
	}

	//유저가 가지고 있는 권한(목록으로 뽑아 올 수도 있다.)
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		System.out.println("권한 체크");
		List<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority(memberVo.getRole()));
		System.out.println(auth);
		return auth;
	}

	//유저 비밀번호
	@Override
	public String getPassword() {
		System.out.println("비밀번호 확인");
		// TODO Auto-generated method stub
		System.out.println(memberVo.getM_pwd());
		return memberVo.getM_pwd();
	}

	//유저 아이디
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		System.out.println("아이디 확인");
		return memberVo.getM_id();
	}

	//아이디 만료여부
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	//아이디 lock 여부
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	//비밀번호 만료 여부
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	//계정 활성 비활성 여부
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		boolean result = true;
		System.out.println("계정 활성화 여부 체크==>" + memberVo.getM_id());
		/*
		 * if(memberVo.getM_id().equals("test")) { result = false; }
		 */
		return result;
	}

}
