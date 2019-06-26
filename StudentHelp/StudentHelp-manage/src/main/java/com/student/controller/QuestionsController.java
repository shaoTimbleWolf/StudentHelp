package com.student.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.student.pojo.Questions;
import com.student.service.QuestionsService;
import com.student.vo.EasyUIDataQuestions;
import com.student.vo.SysResult;

@RestController
@RequestMapping("/questions")
public class QuestionsController {
	@Autowired
	private QuestionsService questionsService;
	/**
	 * http://manage.student.com/questions/query?page=1&rows=20
	 * manage.student.com/questions/query?page=1&rows=20
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/query")
	public EasyUIDataQuestions findQuestionsByPage(Integer page,Integer rows) {
	
		return questionsService.findQuestionsByPage(page,rows);
	}
	
	//name=id  value=<div>页面信息</div>
		@RequestMapping("/save")
		public SysResult saveItem(Questions item) {
			try {
				//实现数据新增
				questionsService.saveItem(item);
				return SysResult.ok();
			} catch (Exception e) {
				e.printStackTrace();
				return SysResult.fail();
			}
		}
		
		//修改商品
		@RequestMapping("/update")
		public SysResult updateItem(Questions item) {
			try {
				questionsService.updateItem(item);
				return SysResult.ok();
			} catch (Exception e) {
				e.printStackTrace();
				return SysResult.fail("商品试题失败");
			}
		}
		
		/**
		 * 1.删除商品信息
		 * url地址:/item/delete
		 * 参数: {ids:ids}
		 */
		@RequestMapping("/delete")
		public SysResult deleteItem(Long[] ids) {
			try {
				
				questionsService.deleteItem(ids);
				
				return SysResult.ok();
			} catch (Exception e) {
				e.printStackTrace();
				return SysResult.fail();
			}
		}
		
		//实现商品下架
		@RequestMapping("/instock")
		public SysResult instock(Long[] ids) {
			try {
				int status = 2;	//下架
				questionsService.updateStatus(ids,status);
				return SysResult.ok();
			} catch (Exception e) {
				e.printStackTrace();
				return SysResult.fail();
			}
		}
		
		@RequestMapping("/reshelf")
		public SysResult reshelf(Long[] ids) {
			try {
				int status = 1;	//上架
				questionsService.updateStatus(ids,status);
				return SysResult.ok();
			} catch (Exception e) {
				e.printStackTrace();
				return SysResult.fail();
			}
		}
		
	
		
}
