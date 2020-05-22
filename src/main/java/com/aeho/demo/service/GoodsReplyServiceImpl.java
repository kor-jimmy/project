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
		if(gv.getGr_ref() != 0) {	//답댓글일 경우
			GoodsReplyVo grv = goodsReplyDao.getGoodsReply(gv.getGr_ref());	//부모댓글 get	
			gv.setGr_level(1);	//답댓글은 level이 1임
			gv.setGr_ref(grv.getGr_ref());//답댓글에는 ref를 부모번호 넣어줌
		}
		int re = 0;
		try {
			int result_insert = goodsReplyDao.insertGoodsReply(gv);
			String cntKeyword = "reply";
			int result_update = goodsDao.updateCnt(gv.getG_no(), cntKeyword);
			if( result_insert > 0 && result_update > 0)	{
				re = 1;
				goodsReplyDao.updateCnt(gv.getGr_ref());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());// TODO: handle exception
		}
		
		return re;
	}

	@Override
	public int deleteGoodsReply(GoodsReplyVo gv) {
		int re=0;
		
		//delete수행시, 답댓글이 아닌 경우는 삭제가 아닌 상태를 1로 변경하고
		//답댓글인 경우는 삭제를 진행하고, 원래 댓글의 cnt를 변경한다.
		if(gv.getGr_no() == gv.getGr_ref()) {//답댓글이 아닐때
			goodsReplyDao.updateState(gv.getGr_no());
			goodsDao.updateCnt(gv.getG_no(), "reply");
			re=1;
		}
		else {
//			GoodsReplyVo grv = goodsReplyDao.getGoodsReply(gv.getGr_ref());	//부모댓글 get	
			int gr_ref = gv.getGr_ref();	//지우고 나서도 이용할 수 있도록 미리 저장
			try {
				int result_delete = goodsReplyDao.deleteGoodsReply(gv);
				String cntKeyword="reply";
//				System.out.println("gno:"+gv.getG_no());
				int result_update = goodsDao.updateCnt(gv.getG_no(), cntKeyword);
				if(result_delete > 0 && result_update > 0) {
					re = 1;
					goodsReplyDao.updateCnt(gr_ref);
				}			
				System.out.println("re:"+re);
			} catch (Exception e) {
				System.out.println(e.getMessage());// TODO: handle exception
			}
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
	public int updateCnt(int gr_ref) {
		return goodsReplyDao.updateCnt(gr_ref);
	}

	@Override
	public int updateState(int gr_no) {
		return goodsReplyDao.updateState(gr_no);
	}


}
