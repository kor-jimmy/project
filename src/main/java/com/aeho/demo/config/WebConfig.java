package com.aeho.demo.config;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	//web root가 아닌 외부 경로에 있는 리소스를 url로 불러올 수 있도록 설정
    //현재 localhost:8090/summernoteImage/1234.jpg
    //로 접속하면 C:/summernote_image/1234.jpg 파일을 불러온다.
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	Date date = new Date();
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH", Locale.KOREA);
    	String today = dateFormat.format(date);

    	String year = today.split("/")[0];
    	String month = today.split("/")[1];

        registry.addResourceHandler("/boardImage/**")
                .addResourceLocations("file:///C:/aehoUpload/board/"+year+"/"+month+"/");
        registry.addResourceHandler("/goodsImage/**")
        		.addResourceLocations("file:///C:/aehoUpload/goods/"+year+"/"+month+"/");
    }
}
