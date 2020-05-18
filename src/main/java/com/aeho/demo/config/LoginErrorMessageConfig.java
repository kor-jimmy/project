package com.aeho.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;

@Configuration
public class LoginErrorMessageConfig {
	
	@Bean
	public ResourceBundleMessageSource messageSource() {
		ResourceBundleMessageSource source = new ResourceBundleMessageSource();
		
		//message properties 경로 설정
		source.setBasenames("security_message");
		//인코딩설정
		source.setDefaultEncoding("UTF-8");
		//캐싱
		source.setCacheSeconds(5);
		return source;
	}
}
