package com.student.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.student.pojo.Video;

public interface VideoMapper extends BaseMapper<Video>{
	@Select("select * from video")
	List<Video> selectAll();

}
