package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;

public interface GoodsReplyDao {
	
	List<GoodsReplyVo> listGoodsReply(GoodsReplyVo gv);
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int updateGoodsReply(GoodsReplyVo gv);

	int deleteGoodsReply(GoodsReplyVo gv);
	
	int deleteGoods(int g_no);
}
