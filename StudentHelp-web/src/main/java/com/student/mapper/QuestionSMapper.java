package com.student.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.student.pojo.Questions;

public interface QuestionSMapper extends BaseMapper<Questions>{
	@Select("select * from questions")
	List<Questions> selectAll();

}
