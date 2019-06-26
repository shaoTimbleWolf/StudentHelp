package com.student.service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.student.mapper.VideoMapper;
import com.student.pojo.Video;
import com.student.vo.EasyUIDataVideo;

@Service
public class VideoServiceImpl implements VideoService{
	@Autowired
	private VideoMapper videoMapper;
	@Override
	public EasyUIDataVideo findVideoByPage(Integer page, Integer rows) {
		//1.获取商品记录总数
		int total = videoMapper.selectCount(null);
		//计算起始位置
		if (rows==null) {
			rows = 10;
		}
		if (page==null) {
			page = 1;
		}
		List<Video> itemList = videoMapper.findItemByPage(page, rows);
		return new EasyUIDataVideo(total,itemList);

	}
	@Transactional//添加事务控制
	@Override
	public void saveItem(Video video) {
		long currentTimeMillis = System.currentTimeMillis();
		video.setStatus(1)
		.setCreatedtime(new Date())
		.setUpdatetime(video.getCreatedtime());
		//mybatis中如果设定主键自增,则新增时Id会自动回传
		//insert into xxx values(xxx) 
		//sql:SELECT LAST_INSERT_ID(); 之后将数据交给对象
		videoMapper.insert(video);

	}

	/**
	 * propagation 事务传播属性
	 * 			      默认值REQUIRED  必须添加事务  事务合并
	 * 			   REQUIRES_NEW   必须新建一个事务
	 * 			   SUPPORTS		   表示事务支持的	查询之前有事务时则合并事务
	 * 
	 * Spring中默认的事务控制策略:
	 * 		1.检查异常/编译异常    不负责事务控制
	 * 		2.运行时异常	/error  回滚事务
	 * 
	 * 按照指定的异常回滚事务.
	 * rollbackFor = "异常的类型"
	 * noRollbackFor =  "异常类型" 遇到异常不回滚.
	 * readOnly = true 不允许修改数据库 只读	
	 * 
	 */
	@Transactional
	@Override
	public void updateItem(Video question) {
		question.setStatus(1).setUpdatetime(new Date());
		videoMapper.updateById(question);

	}

	@Transactional
	@Override
	public void deleteItem(Long[] ids) {
		List<Long> itemList = Arrays.asList(ids);
		videoMapper.deleteBatchIds(itemList);
	}
	@Override
	@Transactional
	public void updateStatus(Long[] ids, Integer status) {
		Video item = new Video();
		item.setStatus(status)
		.setUpdatetime(new Date());
		List<Long> longIds = Arrays.asList(ids);
		UpdateWrapper<Video> updateWrapper = new UpdateWrapper<>();
		updateWrapper.in("id", longIds);
		videoMapper.update(item, updateWrapper);
	}

	@Override
	public Video findItemById(Long id) {
		return videoMapper.selectById(id);
	}
}
