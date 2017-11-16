package com.admin.entity.system;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 勘察数据表
 * Created by lx on 17-11-17.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Prospect extends BaseEntity {

    private static final long serialVersionUID = 2648004984368789978L;

    private String customerName;

    private String customerAddress;

    private String name;

    private String mobile;

    private String prospectTime;

    private String prospectContent;

    private String prospectArea;

    private String prospectRequire;

    private String prospectName;

    private String prospectStatus;

    private String prospectFileAddress;

    private String customerStatus;

    private String submitName;

    private String submitTime;

    private String createdBy;

    private String createdAt;

    private String updatedBy;

    private String updatedAt;
}
