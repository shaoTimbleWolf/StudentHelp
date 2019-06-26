package com.student.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.student.pojo.User;
import com.student.service.UserService;
import com.student.vo.EasyUIDataUser;
import com.student.vo.SysResult;

@RestController
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	/**
	 * http://manage.student.com/page/content?_=1560672734664
	 * @param page
	 * @param rows
	 * @return
	 */
	@RequestMapping("/query")
	public EasyUIDataUser findUserByPage(Integer page,Integer rows) {
		
		return userService.findUserByPage(page,rows);
	} 

	@RequestMapping("/delete")
	public SysResult deleteItem(Long[] ids) {
		try {
			userService.deleteUser(ids);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail();
		}
	}
	
	//
	@RequestMapping("/instock")
	public SysResult instock(Long[] ids) {
		try {
			int status = 2;
			userService.updateStatus(ids,status);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail();
		}
	}
	
	@RequestMapping("/reshelf")
	public SysResult reshelf(Long[] ids) {
		try {
			int status = 1;	
			userService.updateStatus(ids,status);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return SysResult.fail();
		}
	}
}
