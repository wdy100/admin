package com.admin.entity.system;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 资源实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class ResourceInfo  extends BaseEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = -2409219216758363466L;

	private String code;

    private String name;

    private String description;

    private String url;

    private Boolean type;//类别 0:模块 1:页面  2:按钮

    private Integer order;

    private Long parentId;

}