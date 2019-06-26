package com.student.vo;
//该类是展现表格数据的

import java.io.Serializable;
import java.util.List;

import com.student.pojo.Questions;
import com.student.pojo.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
@Data
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
public class EasyUIDataQuestions implements Serializable{
	private Integer total;	//记录总数
	private List<Questions> rows;//展现数据集合	
}






