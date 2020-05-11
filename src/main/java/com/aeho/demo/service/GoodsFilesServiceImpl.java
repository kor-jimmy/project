package com.aeho.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aeho.demo.dao.GoodsFilesDao;
import com.aeho.demo.vo.GoodsFilesVo;
@Service
public class GoodsFilesServiceImpl implements GoodsFilesSevice {
	@Autowired
	private GoodsFilesDao goodsFilesDao;
	
	@Override
	public int insert(GoodsFilesVo bfv) {
		int re = goodsFilesDao.insert(bfv);
		return re;
	}

	@Override
	public int delete(String uuid) {
		// TODO Auto-generated method stub
		int re = goodsFilesDao.delete(uuid);
		return re;
	}

	@Override
	public List<GoodsFilesVo> findByGno(int gno) {
		List<GoodsFilesVo> list = goodsFilesDao.findByGno(gno);
		return list;
	}

	@Override
	public int deleteByGno(int g_no) {
		int re = goodsFilesDao.deleteByGno(g_no);
		return re;
	}

	@Override
	public List<GoodsFilesVo> checkFiles() {
		List<GoodsFilesVo> list = goodsFilesDao.checkFiles();
		return list;
	}

}
