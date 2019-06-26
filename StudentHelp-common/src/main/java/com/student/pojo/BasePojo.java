package com.student.pojo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
@Data
@Accessors(chain=true)
@AllArgsConstructor
@NoArgsConstructor
public class BasePojo implements Serializable{
	private Date createdtime;
	private Date updatetime;
	
}
