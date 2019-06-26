package com.student.service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.student.mapper.QuestionsMapper;
import com.student.pojo.Questions;
import com.student.vo.EasyUIDataQuestions;


@Service
public class QuestionsServiceImpl implements QuestionsService{
	@Autowired
	private QuestionsMapper questionsMapper;
	@Override
	public EasyUIDataQuestions findQuestionsByPage(Integer page, Integer rows) {
		//1.获取商品记录总数
		int total = questionsMapper.selectCount(null);
		//计算起始位置
//		if (rows==null) {
//			rows = 10;
//		}
//		if (page==null) {
//			page = 1;
//		}
		List<Questions> itemList = questionsMapper.findItemByPage(page, rows);
		return new EasyUIDataQuestions(total,itemList);

	}
	@Transactional//添加事务控制
	@Override
	public void saveItem(Questions question) {
		long currentTimeMillis = System.currentTimeMillis();
		Long idLong=currentTimeMillis%100000000;
		question.setId(idLong);
		question.setStatus(1)
		.setCreatedtime(new Date())
		.setUpdatetime(question.getCreatedtime());
		//mybatis中如果设定主键自增,则新增时Id会自动回传
		//insert into xxx values(xxx) 
		//sql:SELECT LAST_INSERT_ID(); 之后将数据交给对象
		questionsMapper.insert(question);
		
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
	public void updateItem(Questions question) {
		question.setUpdatetime(new Date());
		questionsMapper.updateById(question);

	}

	@Transactional
	@Override
	public void deleteItem(Long[] ids) {
		List<Long> itemList = Arrays.asList(ids);
		questionsMapper.deleteBatchIds(itemList);
	}


	@Override
	@Transactional
	public void updateStatus(Long[] ids, Integer status) {
		Questions item = new Questions();
		item.setStatus(status)
		.setUpdatetime(new Date());
		List<Long> longIds = Arrays.asList(ids);
		UpdateWrapper<Questions> updateWrapper = new UpdateWrapper<>();
		updateWrapper.in("id", longIds);
		questionsMapper.update(item, updateWrapper);
	}

	@Override
	public Questions findItemById(Long id) {
		return questionsMapper.selectById(id);
	}
}
