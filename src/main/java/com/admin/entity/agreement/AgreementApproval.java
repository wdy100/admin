package com.admin.entity.agreement;

import java.math.BigDecimal;
import java.util.Date;

import com.admin.entity.BaseEntity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper=true)
@Getter
@Setter
public class AgreementApproval extends BaseEntity {

	private static final long serialVersionUID = -8888462661483579290L;

	private Long agreeId;

    private String approvalInfo;

    private Integer status; //处理状态。1通过 2未通过

}