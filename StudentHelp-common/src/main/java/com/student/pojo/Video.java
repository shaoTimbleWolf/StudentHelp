package com.student.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
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
@TableName("video")
public class Video extends BasePojo{
	@TableId(type=IdType.AUTO)
	private int id;
	private String videoname;
	private String url;
	private Integer status;
	private String videograde;
	private String videocourse;
	private String videoknowledge;
}
