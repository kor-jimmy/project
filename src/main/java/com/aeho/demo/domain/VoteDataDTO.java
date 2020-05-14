package com.aeho.demo.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class VoteDataDTO {

	private int vt_no;
	private String optionAname;
	private String optionBname;
	private MultipartFile fileA;
	private MultipartFile fileB;
	
}
