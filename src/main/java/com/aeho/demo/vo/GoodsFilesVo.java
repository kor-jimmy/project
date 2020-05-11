package com.aeho.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
 
public class GoodsFilesVo {
	private String uuid;
	private String uploadpath;
	private String filename;
	private int g_no;
}
