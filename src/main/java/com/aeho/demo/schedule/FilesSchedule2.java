package com.aeho.demo.schedule;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

import com.aeho.demo.service.GoodsFilesServiceImpl;
import com.aeho.demo.service.GoodsFilesSevice;
import com.aeho.demo.vo.GoodsFilesVo;

@Controller
public class FilesSchedule2 {
	
	@Autowired
	private GoodsFilesSevice goodsFilesService;

	@Scheduled(cron="0 59 * * * *")
	public void removeFiles() {
		
		System.out.println("스케줄링 작동중");
		
		List<GoodsFilesVo> filesDBList = goodsFilesService.checkFiles();
		
		Calendar cal = Calendar.getInstance();
		//현재 시간 milliseconds
		long justNow = cal.getTimeInMillis();
		//만 하루의 milliseconds
		long oneday = 24*60*60*1000;
		
		Calendar filesUploadTime = Calendar.getInstance();
		Date filesUpdateDate = null;
		
		Date date = new Date();
		date = new Date(date.getTime()+(1000*60*60*24*-1));
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM", Locale.KOREA);
		String yesterday = dateFormat.format(date);
		
		String [] splitYester = yesterday.split("/");
		String year = splitYester[0];
		String month = splitYester[1];
		
		//지울 파일의 위치
		File path = new File("C:\\aehoUpload\\goods\\"+year+"\\"+month);
		//위 path의 파일을 모두 가져와 filesList에 담는다.
		File [] filesList = path.listFiles();
		HashMap<Integer, String> map = new HashMap<Integer, String>();
		ArrayList<String> fileNameList = new ArrayList<String>();
		
		//디렉토리의 파일 수만큼 반복문 실행
		for(int i=0; i<filesList.length;i++) {
			//맵에 key로 인덱스, value에 디렉토리의 파일 이름을 각각 넣는다.
			map.put(i, filesList[i].getName());
			fileNameList.add(filesList[i].getName());
		}
		System.out.println(map);
		
		//파일 이름을 모아둔 list 크기만큼 반복문 실행
		for(int i = 0; i < fileNameList.size(); i++) {
			String dirFileName = fileNameList.get(i);
			for(GoodsFilesVo dbFile : filesDBList) {
				//db에 존재하는 파일을 가져와 아래처럼 문자열로 만든다.
				//7597966b-8cad-4051-8589-52555a501993_EUIrjQoWoAAmdJ9.jfif 와 같은 모양
				String dbFileName = dbFile.getUuid()+"_"+dbFile.getFilename();
				//System.out.println(dirFile.equals(dbFileName));
				//디렉토리의 file 이름과 db의 파일 이름이 같다면 맵의 해당 인덱스의 value를 지워준다.
				if( dirFileName.equals(dbFileName) ) {
					map.remove(i);
				}
			}
		}
		
		System.out.println(map.keySet());
		
		//map의 key를 하나씩 돌면 인덱스.
		for(int i : map.keySet()) {
			//디렉토리 파일 리스트 중 인덱스에 해당하는 파일의 마지막 수정날짜를 담는다.
			filesUpdateDate = new Date(filesList[i].lastModified());
			//Calendar 객체 filesUploadTime에 디렉토리 파일의 수정날짜를 set
			filesUploadTime.setTime(filesUpdateDate);
			//바로 지금 시간에서 파일의 수정날짜 milliseconds를 뺀다.
			long diffMil = justNow - filesUploadTime.getTimeInMillis();
			//거기서 하루를 나눠 diffDay에 담는다.
			//(즉, 지금을 기준으로 디렉토리 파일이 만 하루가 지났다면 diffDay는 1이다.)
			int diffDay = (int)( diffMil / oneday ); 
			
			//디렉토리의 파일이 수정된지 1일이 지났고 해당 파일이 존재한다면 파일을 지운다.
			if( diffDay > 1 && filesList[i].exists()) {
				filesList[i].delete();
			}
		}
	
	}
	
}
