package com.student.controller;

import java.util.List;

import org.jboss.logging.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.student.mapper.VideoMapper;
import com.student.pojo.Questions;
import com.student.pojo.Video;
import com.student.service.QuestionsService;
import com.student.service.VideoService;

@Controller
public class PageController {
	@Autowired
	private VideoMapper videoMapper;
	@Autowired
	private VideoService videoService;
	@Autowired
	private QuestionsService questionsService;
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	@RequestMapping("/{moduleName}")
	public String moduleName(@PathVariable String moduleName) {
		return moduleName;
	}
	@RequestMapping("studyList")
	public String studyList1(Model model) {
		List<Questions> questionsList = questionsService.selectAll();
		model.addAttribute("questionsList", questionsList);
		return "studyList";
	}	
//	@RequestMapping("/query/studyList")
//	public String studyList(Model model) {
//		List<Questions> questionsList = questionsService.selectAll();
//		model.addAttribute("questionsList", questionsList);
//		return "studyList";
//	}
	@RequestMapping("studyVideo")
	public String studyVideo(Model model) {
		List<Video> videoList = videoService.SelectAll();
		model.addAttribute("videoList", videoList);
		return "studyVideo";
	}
	//URL:/video/play?id=1
	@RequestMapping("/video/play")
	public String videoPlay(Long id,Model model) {
		Video videoPlay = videoService.queryById(id);
		model.addAttribute("videoPlay", videoPlay);
		return "videoPlay";
	}
	@RequestMapping("/video/play/getUrl")
	@ResponseBody
	public String getUrl(long id) {
		Video video = videoMapper.selectById(id);
		return "http://192.168.77.129:8888/"+video.getUrl() ;
	}
}





