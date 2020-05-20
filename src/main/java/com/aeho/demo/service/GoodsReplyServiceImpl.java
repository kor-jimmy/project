package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional(rollbackFor=Exception.class)
	public int insertGoodsReply(GoodsReplyVo gv) {
		GoodsReplyVo grv = new GoodsReplyVo();
		if(gv.getGr_ref() != 0) {
			grv = goodsReplyDao.getGoodsReply(gv.getGr_ref());
			gv.setGr_level(1);
/*			if(grv.getGr_step() != 0) {
				gv.setGr_step(grv.getGr_step());
			}
			else {
				gv.setGr_step(goodsReplyDao.maxGrstep(gv)+1);
			}*/
			gv.setGr_ref(grv.getGr_ref());
		}
		gv.setGr_refid(grv.getM_id());
		int re = 0;
		try {
			int result_insert = goodsReplyDao.insertGoodsReply(gv);
			String cntKeyword = "reply";
			int result_update = goodsDao.updateCnt(gv.getG_no(), cntKeyword);
			if( result_insert > 0 && result_update > 0)
				re = 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());// TODO: handle exception
		}
		
		return re;
	}

	@Override
	public int deleteGoodsReply(GoodsReplyVo gv) {
		int re=0;
		try {
			int result_delete = goodsReplyDao.deleteGoodsReply(gv);
			String cntKeyword="reply";
			System.out.println("gno:"+gv.getG_no());
			int result_update = goodsDao.updateCnt(gv.getG_no(), cntKeyword);
			
			if(result_delete > 0 && result_update > 0)
				re=1;
			
			System.out.println("업데이트결과:"+result_update);
		} catch (Exception e) {
			System.out.println(e.getMessage());// TODO: handle exception
		}
		return re;
	}

	@Override
	public int deleteGoodsandReply(int g_no) {
		// TODO Auto-generated method stub
		return goodsReplyDao.deleteGoodsandReply(g_no);
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
