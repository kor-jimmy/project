package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;

public interface GoodsReplyService {
	List<GoodsReplyVo> listGoodsReply(GoodsReplyVo gv);
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int deleteGoodsReply(GoodsReplyVo gv);
	
	int deleteReply(int g_no);
}
