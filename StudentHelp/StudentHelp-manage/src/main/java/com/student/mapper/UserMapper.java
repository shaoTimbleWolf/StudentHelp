package com.student.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.student.pojo.User;

public interface UserMapper extends BaseMapper<User>{

	@Select("select * from user order by createdtime desc limit #{start},#{rows}")
	List<User> findItemByPage(@Param("start")Integer start,@Param("rows")Integer rows);

}
