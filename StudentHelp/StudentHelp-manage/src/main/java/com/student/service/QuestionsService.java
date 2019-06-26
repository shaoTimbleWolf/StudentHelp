package com.student.service;

import com.student.pojo.Questions;
import com.student.vo.EasyUIDataQuestions;

public interface QuestionsService {

	EasyUIDataQuestions findQuestionsByPage(Integer page, Integer rows);
	
	void saveItem(Questions item);

	void updateItem(Questions item);

	void deleteItem(Long[] ids);

	void updateStatus(Long[] ids, Integer status);

	Questions findItemById(Long id);

}
