package com.admin.entity.system;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 角色资源实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class RoleResource  extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = 7338000316774087035L;

	private Integer roleId;

    private Integer resourceId;

}