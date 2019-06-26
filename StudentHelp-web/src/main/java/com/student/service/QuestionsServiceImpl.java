package com.student.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.student.mapper.QuestionSMapper;
import com.student.pojo.Questions;

@Service
public class QuestionsServiceImpl implements QuestionsService{
	@Autowired
	private QuestionSMapper questionSMapper;
	@Override
	public List<Questions> selectAll() {
		List<Questions> questionsList = questionSMapper.selectAll();
		return questionsList;
	}

}
