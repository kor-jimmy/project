package com.aeho.demo.vo;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SlideImagesVo {
	
	private int s_no;
	private String s_img;
	private String s_title;
	private String s_text;
	
	private MultipartFile file_img;
	
}
