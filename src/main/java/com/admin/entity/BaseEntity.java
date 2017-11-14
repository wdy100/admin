package com.admin.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

import com.google.common.base.Strings;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 所有实体类的基类
 * @author gaojingfei
 *
 */
@ToString
@Getter
@Setter
public class BaseEntity implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4055603087217089041L;
	/**
	 * 主键自增长ID
	 */
	private Long id;
	/**
	 * 记录创建人
	 */
	private String createdBy;
	/**
	 * 记录创建时间
	 */
	private Date createdAt;
	/**
	 * 记录最后修改人
	 */
	private String updatedBy;
	/**
	 * 最后修改时间
	 */
	private Date updatedAt;
	/**
	 * 系统 保留字段，用来记录诸如 数据 迁移的备注等
	 */
	private String remark;
	/**
	 * json字符串，根据实际的实体来判断是否添加 ， 映射
	 */
	private String properties;
	
	/**
	 * 将properties字符串转换成jsonobect对象，方便操作
	 * @return
	 * @see JsonObject
	 */
	public Map<String, Object> getPropertiesMap(){
		Gson gson = new GsonBuilder().create();
		@SuppressWarnings("unchecked")
		Map<String,Object> rs = gson.fromJson(Strings.nullToEmpty(properties), Map.class);
		return rs;
	}
}
