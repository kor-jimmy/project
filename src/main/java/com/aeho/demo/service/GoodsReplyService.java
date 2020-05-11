package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;

public interface GoodsReplyService {
	List<GoodsReplyVo> listGoodsReply(int g_no);
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int deleteGoodsReply(GoodsReplyVo gv);
	
	int deleteGoods(int g_no);
}
