package com.admin.entity.util;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;

import com.admin.entity.system.Department;

/**
 * 用来构建用户可访问的资源树形结构
 * @author GaoJingFei
 *
 */
public class DepartmentTreeNodeFactory extends TreeNodeFactory<Department> {

	@Override
	protected String getNodeId(Department element) {
		return String.valueOf(element.getId());
	}

	@Override
	protected String getParentId(Department element) {
		Department parent = element.getParent();
		if(parent == null){
			return null;
		}
		return ObjectUtils.toString(parent.getId());
	}

	@Override
	protected TreeNode buildTreeNode(Department element) {
		TreeNode node = new TreeNode();
		node.setId(getNodeId(element));
		node.setText(element.getName());
		node.getAttributes().put("code", element.getCode());
		node.getAttributes().put("description", element.getName());
		return node;
	}
}
