package com.student.service;

import com.student.vo.EasyUIDataUser;

public interface UserService {

	EasyUIDataUser findUserByPage(Integer page, Integer rows);

	void deleteUser(Long[] ids);

	void updateStatus(Long[] ids, Integer status);


}
