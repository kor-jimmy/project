package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;
import com.aeho.demo.vo.GoodsVo;

public interface GoodsReplyService {
	List<GoodsReplyVo> listGoodsReply(int g_no);
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int deleteGoodsReply(GoodsReplyVo gv);
	
	int deleteGoodsandReply(int g_no);
	
	GoodsReplyVo getGoodsReply(int gr_no);
	
	int updateCnt(int gr_ref);
	
	int updateState(int gr_no);

}