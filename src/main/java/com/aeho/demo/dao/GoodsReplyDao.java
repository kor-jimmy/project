package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;

public interface GoodsReplyDao {
	
	List<GoodsReplyVo> listGoodsReply(int g_no);
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int updateGoodsReply(GoodsReplyVo gv);

	int deleteGoodsReply(GoodsReplyVo gv);
	
	int deleteGoods(int g_no);

	GoodsReplyVo getGoodsReply(int gr_no);

	int maxGrstep(GoodsReplyVo gv);
}
