package com.student.vo;

import java.io.Serializable;
import java.util.List;

import com.student.pojo.Video;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
@Data
@Accessors(chain=true)
@NoArgsConstructor
@AllArgsConstructor
public class EasyUIDataVideo implements Serializable{
	private Integer total;	//记录总数
	private List<Video> rows;//展现数据集合
}
