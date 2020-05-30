package com.aeho.demo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.MemberVo;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberServiceSecurity memberServiceSecurity;
	
	@Bean
	public DaoAuthenticationProvider authenticationProvider(MemberServiceSecurity memberServiceSecurity) throws Exception {
		DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
		authenticationProvider.setUserDetailsService(memberServiceSecurity);
		authenticationProvider.setPasswordEncoder(passwordEncoder);
		return authenticationProvider;
	}

	//실제 인증을 진행하는 provider
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		System.out.println("provider 작동");
		auth.authenticationProvider(authenticationProvider(memberServiceSecurity));
	}

	//이미지, 자바스크립트, css 디렉토리 보안 설정
	@Override
	public void configure(WebSecurity web) throws Exception {
		// TODO Auto-generated method stub
		web.ignoring().antMatchers("/resource/**");
	}

	//http 관련 보안 설정.
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
				.antMatchers("/board/insert","/board/update","/board/delete",
				"/reply/insert,","/reply/delete","/goods/insert","/goods/update","/goods/delete",
				"/goodsReply/insert","/goodsReply/delete","/member/get","/member/update").hasAnyAuthority("ROLE_USER","ROLE_MASTER")
				//.antMatchers("/admin","/admin/*").hasAnyAuthority("ROLE_MASTER")
				.antMatchers("/*","/*/*").permitAll()
				/* .anyRequest().authenticated() */
			.and()
				.csrf().ignoringAntMatchers("/member/insert")
			.and()
				.formLogin()
				.loginPage("/loginCustom")
				.loginProcessingUrl("/login")
				.successForwardUrl("/main/main")
				.defaultSuccessUrl("/main/main")
			.and()
				.logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
				.deleteCookies("JSESSIONID")
				.logoutSuccessUrl("/main/main")
			.and()
				.exceptionHandling()
				.accessDeniedPage("/access-denied");
	}
}
