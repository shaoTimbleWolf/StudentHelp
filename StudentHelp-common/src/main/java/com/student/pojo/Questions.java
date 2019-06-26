package com.student.pojo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain=true)
@TableName("questions")
public class Questions extends BasePojo{
	@TableId
	private Long id;
	private String title;
	private String grade;
	private String course;
	private String knowledge;
	private String question;
	private String answer;
	private Integer status;
}
