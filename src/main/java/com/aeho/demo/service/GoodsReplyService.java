package com.aeho.demo.service;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;

public interface GoodsReplyService {
	List<GoodsReplyVo> listGoodsReply();
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int deleteGoodsReply(GoodsReplyVo gv);
}
