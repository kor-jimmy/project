package com.aeho.demo.controller;

import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aeho.demo.service.BoardService;
import com.aeho.demo.service.GoodsService;
import com.aeho.demo.service.MemberServiceSecurity;
import com.aeho.demo.vo.BoardVo;
import com.aeho.demo.vo.GoodsVo;
import com.aeho.demo.vo.MemberVo;
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
	public void get(HttpServletRequest request, @RequestParam("m_id") String m_id,Model model) {
		System.out.println("member get");
		MemberVo mv = memberServiceSecurity.getMember(m_id);
		model.addAttribute("member", mv);
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


}
