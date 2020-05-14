package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsDao;
import com.aeho.demo.dao.GoodsReplyDao;
import com.aeho.demo.vo.GoodsReplyVo;

@Service
public class GoodsReplyServiceImpl implements GoodsReplyService {
	@Autowired
	public GoodsReplyDao goodsReplyDao;
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public List<GoodsReplyVo> listGoodsReply(int g_no) {
		return goodsReplyDao.listGoodsReply(g_no);
	}

	@Override
	public int insertGoodsReply(GoodsReplyVo gv) {
		if(gv.getGr_ref() != 0) {
			System.out.println("그냥 대댓의 레벨 ! ! ! : "+gv.getGr_level());
			GoodsReplyVo grv = goodsReplyDao.getGoodsReply(gv.getGr_ref());
			gv.setGr_level(grv.getGr_level()+1);
			System.out.println("업뎃된 대댓의 레벨 ! ! ! : "+gv.getGr_level());
			goodsReplyDao.updateGstep(grv);	//부모댓글의 step을 +1시켜줌
		}
		int re = goodsReplyDao.insertGoodsReply(gv);
		String cntKeyword = "reply";
		goodsDao.updateCnt(gv.getG_no(), cntKeyword);
		return re;
	}

	@Override
	public int deleteGoodsReply(GoodsReplyVo gv) {
		int re = goodsReplyDao.deleteGoodsReply(gv);
		String cntKeyword = "reply";
		goodsDao.updateCnt(gv.getG_no(), cntKeyword);
		return re;
	}

	@Override
	public int deleteGoods(int g_no) {
		// TODO Auto-generated method stub
		return goodsReplyDao.deleteGoods(g_no);
	}

	@Override
	public GoodsReplyVo getGoodsReply(int gr_no) {
		return goodsReplyDao.getGoodsReply(gr_no);
	}

	@Override
	public int updateGstep(GoodsReplyVo gv) {
		return goodsReplyDao.updateGstep(gv);
	}

}
