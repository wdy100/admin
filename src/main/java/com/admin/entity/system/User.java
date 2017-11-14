package com.admin.entity.system;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 用户实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class User extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2648004984368249978L;

	/**
     * 姓名
     */
    private String name;
    
    /**
     * 手机号
     */
    private String mobile;


}
