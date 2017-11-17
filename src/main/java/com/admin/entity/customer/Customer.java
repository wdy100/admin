package com.admin.entity.customer;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 客户实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Customer extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = -1228505501747126397L;

	private String customerCode;

    private String customerName;

    private String typeCode;

    private String typeName;

    private String phone;

    private String fax;

    private String address;

    private String url;

    private String corporate;

    private String manager;

    private String contact;

    private String dockDepartment;

    private String dockPerson;

    private String dockContact;

    private String relateDepartment;

    private String relatePerson;

    private String relateContact;

}