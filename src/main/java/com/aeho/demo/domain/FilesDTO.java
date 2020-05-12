package com.aeho.demo.domain;

import java.util.Date;
import java.util.List;

import com.aeho.demo.vo.BoardFilesVo;
import com.aeho.demo.vo.BoardVo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class FilesDTO {
	private String filedName;
	private String uploadPath;
	private String uuid;
}
