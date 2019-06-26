package com.student.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.student.fastdfs.FastDFSClient;
import com.student.mapper.VideoMapper;
import com.student.pojo.Video;
import com.student.service.VideoService;
import com.student.vo.EasyUIDataVideo;
import com.student.vo.SysResult;

@Controller
@RequestMapping("/video/")
public class VideoController {
	@Autowired
	private VideoMapper videoMapper;
	@Autowired
	private VideoService videoService;
	//http://manage.student.com/video/save
	@RequestMapping("save")
	@ResponseBody
	@Transactional
	public SysResult fileUpload(@RequestParam(value="file",required=false) MultipartFile file,
			Video video) {
		try {
			//	获取文件的后缀
			String originalFilename = file.getOriginalFilename();
			System.out.println("originalFilename:   "+originalFilename);
			String extName = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
			//	创建FastDFSClient对象
			FastDFSClient fastDFSClient = new FastDFSClient();
			String fileName = fastDFSClient.uploadFile(file.getBytes(),extName);
			System.out.println("fileName:   "+fileName);

			//存入数据库
			System.out.println("kemu:"+video.getVideocourse());
			System.out.println("nianji"+video.getVideograde());
			System.out.println("zhsihidian"+video.getVideoknowledge());
			video.setVideoname(originalFilename).setUrl(fileName)
			.setCreatedtime(new Date()).setUpdatetime(video.getCreatedtime());
			int rows = videoMapper.insert(video);

			if (fileName!=null&&rows!=0) {
				//	
				System.out.println("上传成功");
				System.out.println(video);
			}
			return SysResult.ok(video);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("上传失败");
			return SysResult.fail();
		}
	}
	/**
	 * http://manage.student.com/Video/query?page=1&rows=20
	 * manage.student.com/Video/query?page=1&rows=20
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("query")
	@ResponseBody
	public EasyUIDataVideo findVideoByPage(Integer page,Integer rows) {

		return videoService.findVideoByPage(page,rows);
	}



	//修改商品
	@RequestMapping("update")
	@ResponseBody
	public SysResult updateItem(Video video) {
		try {
			videoService.updateItem(video);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail("商品试题失败");
		}
	}

	/**
	 * 1.删除商品信息
	 * url地址:/item/delete
	 * 参数: {ids:ids}
	 */
	@RequestMapping("delete")
	@ResponseBody
	public SysResult deleteItem(Long[] ids) {
		try {

			videoService.deleteItem(ids);

			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail();
		}
	}

	//实现商品下架
	@RequestMapping("instock")
	@ResponseBody
	public SysResult instock(Long[] ids) {
		try {
			int status = 2;	//下架
			videoService.updateStatus(ids,status);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail();
		}
	}

	@RequestMapping("reshelf")
	@ResponseBody
	public SysResult reshelf(Long[] ids) {
		try {
			int status = 1;	//上架
			videoService.updateStatus(ids,status);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail();
		}
	}


}




