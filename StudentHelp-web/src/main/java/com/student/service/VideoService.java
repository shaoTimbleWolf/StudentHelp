package com.student.service;

import java.util.List;

import com.student.pojo.Video;

public interface VideoService {

	List<Video> SelectAll();

	Video queryById(Long id);

}
