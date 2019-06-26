package com.student.service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.student.mapper.UserMapper;
import com.student.pojo.User;
import com.student.vo.EasyUIDataUser;
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserMapper userMapper;
	@Override
	public EasyUIDataUser findUserByPage(Integer page, Integer rows) {
		//1.获取商品记录总数
		int total = userMapper.selectCount(null);
//		//计算起始位置
//		if (rows==null) {
//			rows = 5;
//		}
//		if (page==null) {
//			page = 1;
//		}
		int start = (page-1)*rows;
		List<User> itemList = userMapper.findItemByPage(start,rows);

		return new EasyUIDataUser(total,itemList);

	}

	@Transactional
	@Override
	public void deleteUser(Long[] ids) {
		//1.手动删除
		//itemMapper.deleteItem(ids);
		//2.利用Mybatis-plus自动删除
		List<Long> itemList = Arrays.asList(ids);
		userMapper.deleteBatchIds(itemList);
		
	}

	@Override
	@Transactional
	public void updateStatus(Long[] ids, Integer status) {
		User user = new User();
		user.setStatus(status)
		.setUpdatetime(new Date());
		List<Long> longIds = Arrays.asList(ids);
		UpdateWrapper<User> updateWrapper = new UpdateWrapper<>();
		updateWrapper.in("id", longIds);
		userMapper.update(user, updateWrapper);
	}

}
