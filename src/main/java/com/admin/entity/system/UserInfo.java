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
public class UserInfo  extends BaseEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = -1649691620709858307L;

	private String userName;

    private String password;

    private Integer status;

    private Boolean sex;

    private String mobile;

    private String email;

    private String nickName;

}