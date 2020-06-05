package com.aeho.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Member;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.GoodsService;
import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.GoodsVo;
import com.aeho.demo.vo.MemberVo;
import com.aeho.demo.vo.SlideImagesVo;
import com.google.gson.Gson;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberServiceSecurity memberServiceSecurity;
	
	@Autowired
	private MailSender javaMailSender;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private GoodsService goodsService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	public void setJavaMailSender(MailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}


	@GetMapping("/insert")
	public void insertMember(HttpServletRequest request ) {
		
	}
	
	@GetMapping("/delete")
	public void deleteMember(HttpServletRequest request ) {
		
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public String insertMember(HttpServletRequest request, MemberVo mv, RedirectAttributes rttr){
		System.out.println("컨트롤러 동작중");
		String msg = "예기치 않은 오류로 회원가입에 실패했습니다. 잠시 후 다시 시도해주시기 바랍니다. 불편을 드려 죄송합니다.";
		int re = memberServiceSecurity.insertMember(mv);
		if(re > 0) {
			msg = "회원가입이 완료되었습니다. 환영합니다!";
		}
		return msg;
	}
	
	//id 존재 여부 검사
	@GetMapping("/isExistMember")
	@ResponseBody
	public String isExistMember(HttpServletRequest request,String m_id) {
		String result = "0";
		//0: 사용 가능하고 글자수 적합 / 1: 사용중인 아이디 / 2: 사용 가능하나 글자수 미달 / 3: 사용 가능하나 글자수 초과 
		if(memberServiceSecurity.getMember(m_id) != null) {
			result = "1";
		}else {
			if(m_id.length() < 5){
				result = "2";
			}else if(m_id.length() > 20) {
				result = "3";
			}
		}
		return result;
	}
	
	//닉네임 존재여부
	@GetMapping("/isExistNick")
	@ResponseBody
	public String isExistNick(HttpServletRequest request, String m_nick) {
		String result = "0";
		if(memberServiceSecurity.getMemberByNick(m_nick) != null) {
			result = "1";
		}else {
			if(m_nick.length() < 1){
				result = "2";
			}else if(m_nick.length() > 20) {
				result = "3";
			}
		}
		return result;
	}
	
	@GetMapping("/get")
	public void get(HttpServletRequest request) {
	}
	
	@GetMapping("/mypage")
	public void myPage(HttpServletRequest request) {
		
	}
	
	@GetMapping("/getMemberInfo")
	@ResponseBody
	public String getMemberInfo(HttpServletRequest request, String m_id) {
		MemberVo memberVo = memberServiceSecurity.getMember(m_id);
		System.out.println(memberVo);
		Gson gson = new Gson();
		String str=  gson.toJson(memberVo);
		return str;
	}
	
	@GetMapping("/getMypageBoard")
	@ResponseBody
	public String getMypageBoard(HttpServletRequest request, @RequestParam("m_id") String m_id) {
		List<BoardVo> list = boardService.getMypageBoard(m_id);
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	@GetMapping("/getMypageGoods")
	@ResponseBody
	public String getMypageGoods(HttpServletRequest request, @RequestParam("m_id") String m_id) {
		List<GoodsVo> list = goodsService.getMypageGoods(m_id);
		Gson gson = new Gson();
		String str = gson.toJson(list);
		return str;
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateMember(HttpServletRequest request, MemberVo mv, RedirectAttributes rttr){
		String msg = "예기치 않은 오류로 회원 정보 수정에 실패했습니다. 잠시 후 다시 시도해주시기 바랍니다. 불편을 드려 죄송합니다.";
		int re = memberServiceSecurity.updateMember(mv);
		if(re > 0) {
			msg = "회원 정보가 수정되었습니다.";
		}
		return msg;
	}
	
	@RequestMapping("/isCorrectPwd")
	@ResponseBody
	public String isCorrectPwd(HttpServletRequest request, String m_id, String m_pwd) {
		String re = "0";
		System.out.println("m_id: "+m_id+" / m_pwd: "+m_pwd);
		String pwd = memberServiceSecurity.getMember(m_id).getM_pwd();
		
		if(passwordEncoder.matches( m_pwd, pwd )) {
			re = "1";
		}
		return re;
	}
	
	@RequestMapping("/findInfo")
	public void findInfo(HttpServletRequest request) {
	}
	
	
	
	@RequestMapping("/sendMailForPwd")
	@ResponseBody
	public String sendMailForPwd(HttpServletRequest request, String m_id, String email) {
		System.out.println(email);
		
		Random rand =new Random();

		StringBuffer buffer =new StringBuffer();

		for(int i = 0; i < 10; i++){
		    if(rand.nextBoolean()){
		        buffer.append((char)((int)(rand.nextInt(26))+97));
		    }else{
		        buffer.append((rand.nextInt(10)));
		    }
		}
		
		System.out.println(buffer);
		final String tempPwd = buffer.toString();
		
		MemberVo mv = memberServiceSecurity.getMember(m_id);
		System.out.println("원래 memberVo: "+ mv);
		mv.setM_pwd(tempPwd);
		memberServiceSecurity.updateMember(mv);
		System.out.println("수정된 memberVo: "+mv);
		
		mailSender.send(new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {

				System.out.println(tempPwd);
				
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				message.setFrom("team.demo2020@gmail.com");
				message.setTo(email);
			    message.setSubject("[Aeho] 새 비밀번호 안내입니다..");
				String str = "<h2><i>Welcome!</i></h2><p>새로운 비밀번호는 ["+tempPwd+"]입니다.</p><br>";
				str += "<i>로그인 후 반드시 새 비밀번호를 지정해주십시오.</i>";
				str += "<a href='http://localhost:8088/loginCustom'>로그인 하러가기</a>";
			    message.setText(str, true);
			    //message.addInline("aeho", new ClassPathResource("/project/src/main/webapp/img/AEHO_for_EMAIL.png"));
			}
			
		});
		
		return tempPwd;
	}
	
	//메일 발송
	@RequestMapping("/sendMail")
	@ResponseBody
	public String sendMail(HttpServletRequest request, String email) {
		System.out.println(email);
		
		int first = (int)(Math.random()*9)+1;
		int second = (int)(Math.random()*9)+1;
		int third = (int)(Math.random()*9)+1;
		int fourth = (int)(Math.random()*9)+1;
		
		final String authNum = Integer.toString(first) + Integer.toString(second) + Integer.toString(third) + Integer.toString(fourth);
		
		mailSender.send(new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {

				System.out.println(authNum);
				
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				message.setFrom("team.demo2020@gmail.com");
				message.setTo(email);
			    message.setSubject("[Aeho] 인증번호 안내 메일입니다.");
				String str = "<h2><i>Welcome!</i></h2><p>인증번호는 ["+authNum+"]입니다.</p>";
			    message.setText(str, true);
			    //message.addInline("aeho", new ClassPathResource("/project/src/main/webapp/img/AEHO_for_EMAIL.png"));
			}
			
		});
		
		return authNum;
	}
	
	@RequestMapping("/updateProfileImage")
	@ResponseBody
	public String updateProfileImage(HttpServletRequest request, MemberVo mv) {
		
		String result = "0";
		System.out.println("update: "+ mv);
		
		MemberVo oldmember = memberServiceSecurity.getMember(mv.getM_id());
		
		String path = request.getRealPath("img/profileImg");
		System.out.println("path: "+path);

		MultipartFile file = null;
		String filename = "";
		
		if(mv.getImg_file() != null) {
			file = mv.getImg_file();
			filename = mv.getM_id()+"_"+file.getOriginalFilename();
		}
		
		mv.setM_img(filename);
		System.out.println(mv);
		
		int re = memberServiceSecurity.updateProfileImage(mv);

		if(re > 0) {
			try {
				
				if(file != null) {
					if(oldmember.getM_img() != null) {
						File tempFile = new File(path + "/" + oldmember.getM_img());
						tempFile.delete();
					}
					byte [] data = file.getBytes();
					
					FileOutputStream fos = new FileOutputStream(path+"/"+filename);

					fos.write(data);
					fos.close();
				}
				
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
			result = "1";
		}
		
		return result;
	}


}
