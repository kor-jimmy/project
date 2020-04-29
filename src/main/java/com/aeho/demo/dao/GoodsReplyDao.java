package com.aeho.demo.dao;

import java.util.List;

import com.aeho.demo.vo.GoodsReplyVo;
import com.aeho.demo.vo.GoodsVo;

public interface GoodsReplyDao {
	
	List<GoodsReplyVo> listGoodsReply(GoodsReplyVo gv);
	
	int insertGoodsReply(GoodsReplyVo gv);
	
	int updateGoodsReply(GoodsReplyVo gv);

	int deleteGoodsReply(GoodsReplyVo gv);
	
	int deleteReply(int g_no);
}
