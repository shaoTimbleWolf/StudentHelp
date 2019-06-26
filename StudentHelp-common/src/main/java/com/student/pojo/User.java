package com.student.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@AllArgsConstructor
@NoArgsConstructor
@TableName("user")
public class User extends BasePojo{
	@TableId(type=IdType.AUTO)
	private Long id;
	private String name;
	private String grede;
	private String phone;
	private String password;
	private Integer status;
	
	
}
