package com.admin.service.system;
import java.util.List;

import com.admin.entity.system.RoleResource;
import com.haier.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface RoleResourceService {


	public ServiceResult<List<RoleResource>> selectAllByRoleId(Integer roleId);
	
	public ServiceResult<Integer> insert(RoleResource roleResource);
	
	public ServiceResult<Integer> deleteByRoleId(Integer roleId);
}
