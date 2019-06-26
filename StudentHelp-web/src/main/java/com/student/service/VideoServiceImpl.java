package com.student.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.student.mapper.VideoMapper;
import com.student.pojo.Video;

@Service
public class VideoServiceImpl implements VideoService{
	@Autowired
	private VideoMapper videoMapper;
	@Override
	public List<Video> SelectAll() {
		List<Video> videoList = videoMapper.selectAll();
		return videoList;
	}
	@Override
	public Video queryById(Long id) {
		Video video = videoMapper.selectById(id);
		return video;
	}

}
