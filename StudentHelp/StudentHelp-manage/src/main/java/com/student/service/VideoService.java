package com.student.service;

import com.student.pojo.Video;
import com.student.vo.EasyUIDataVideo;

public interface VideoService {

	EasyUIDataVideo findVideoByPage(Integer page, Integer rows);
	
	void saveItem(Video item);

	void updateItem(Video item);

	void deleteItem(Long[] ids);

	void updateStatus(Long[] ids, Integer status);

	Video findItemById(Long id);
}
