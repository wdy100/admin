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

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getProspectTime() {
        return prospectTime;
    }

    public void setProspectTime(String prospectTime) {
        this.prospectTime = prospectTime;
    }

    public String getProspectContent() {
        return prospectContent;
    }

    public void setProspectContent(String prospectContent) {
        this.prospectContent = prospectContent;
    }

    public String getProspectArea() {
        return prospectArea;
    }

    public void setProspectArea(String prospectArea) {
        this.prospectArea = prospectArea;
    }

    public String getProspectRequire() {
        return prospectRequire;
    }

    public void setProspectRequire(String prospectRequire) {
        this.prospectRequire = prospectRequire;
    }

    public String getProspectName() {
        return prospectName;
    }

    public void setProspectName(String prospectName) {
        this.prospectName = prospectName;
    }

    public String getProspectStatus() {
        return prospectStatus;
    }

    public void setProspectStatus(String prospectStatus) {
        this.prospectStatus = prospectStatus;
    }

    public String getProspectFileAddress() {
        return prospectFileAddress;
    }

    public void setProspectFileAddress(String prospectFileAddress) {
        this.prospectFileAddress = prospectFileAddress;
    }

    public String getCustomerStatus() {
        return customerStatus;
    }

    public void setCustomerStatus(String customerStatus) {
        this.customerStatus = customerStatus;
    }

    public String getSubmitName() {
        return submitName;
    }

    public void setSubmitName(String submitName) {
        this.submitName = submitName;
    }

    public String getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(String submitTime) {
        this.submitTime = submitTime;
    }
}
