package com.aeho.demo.aop;


import java.io.FileWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.aeho.demo.dao.LogDao;
import com.aeho.demo.vo.LogVo;

@Component
@Aspect
public class LoginAspect {
	

	@Autowired
	LogDao logDao;

	@Pointcut("execution(public * com.aeho.demo.controller..*(..))")
	private void conMethod() {}
	
	@Before("conMethod()")
	public void before(JoinPoint jointPoint) {
		//실행되는 메소드의 이름
		String methodName = jointPoint.getSignature().toShortString();
		//메소드의 0번째 매개변수를 가져옴.
		HttpServletRequest request = (HttpServletRequest)jointPoint.getArgs()[0];
		//요청명
		String uri = request.getRequestURI();
		//ip
		String ip = request.getRemoteAddr();
		//요청시간
		String time = new Date().toLocaleString();
		Date today = new Date();
		int yy = today.getYear()+1900;
		int mm = today.getMonth()+1;
		int dd = today.getDate();
		String fname = yy+" "+mm+" "+dd+".txt";
		String msg = "요청 uri : "+uri+" / 요청IP : "+ip+" / 요청 시간 : "+time+"\n";
		String path = "C:\\upload\\temp\\log";
		try {
			FileWriter fw = new FileWriter(path+"/"+fname,true);
			fw.write(msg);
			fw.close();
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		LogVo logVo = new LogVo();
		logVo.setLog_ip(ip);
		logVo.setLog_uri(uri);
		logVo.setLog_time(time);
		int re = logDao.insertLog(logVo);
		System.out.println(methodName + "동작 전 입니다.");
	}
}
