package com.admin.entity.system;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 角色实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Role  extends BaseEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = -550322401297851576L;

	private String code;

    private String name;

    private String description;

}