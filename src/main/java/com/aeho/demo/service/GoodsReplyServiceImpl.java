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
			GoodsReplyVo grv = goodsReplyDao.getGoodsReply(gv.getGr_ref());
			gv.setGr_level(grv.getGr_level()+1);
			if(grv.getGr_step() != 0) {
				gv.setGr_step(grv.getGr_step());
			}
			else {
				gv.setGr_step(goodsReplyDao.maxGrstep(gv)+1);
			}

			gv.setGr_ref(grv.getGr_ref());
		}
		else {
//			gv.setGr_ref(gv.getGr_no());//여기 gr_no 먼저 얻을거 생각하기 (부모댓글이 없는 경우)
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
	public int maxGrstep(GoodsReplyVo gv) {
		return goodsReplyDao.maxGrstep(gv);
	}

}
