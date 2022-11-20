package xrt.lingoframework.common.vo;

import java.io.Serializable;

public class LoginVO extends SearchVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String compcd;
    private String compnm;
    private String usercd;
    private String name;
    private String orgcd;
    private String orgnm;
    private String custcd;
    private String custnm;
    private String deptcd;
    private String deptnm;
    private String whcd;
    private String whnm;
    private String usergroup;
    private String usergroupnm;
    private String isusing;
    private String lastlogin;
    private String logincnt;
    private String pwdchgdate;
    private String pwdchgscdate;
    private String islock;
    private String pwdchgyn;
    private String pass;
    private String inituseryn;
    private String last3month;
    private String returnCode;
    private String email;
    private String print1;
    private String print2;
    private String print3;
    private String scale1;
    private String sellerWhcd; // 20191128 jy.hong 2019년12까지 추가개발
    private String paymentType; // 20200210 jy.hong 결제타입구분 추가
    private String passBookAuthYn;
    private int failCnt;

    public String getCompcd() {
        return compcd;
    }

    public void setCompcd(String compcd) {
        this.compcd = compcd;
    }

    public String getCompnm() {
        return compnm;
    }

    public void setCompnm(String compnm) {
        this.compnm = compnm;
    }

    public String getUsercd() {
        return usercd;
    }

    public void setUsercd(String usercd) {
        this.usercd = usercd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrgcd() {
        return orgcd;
    }

    public void setOrgcd(String orgcd) {
        this.orgcd = orgcd;
    }

    public String getOrgnm() {
        return orgnm;
    }

    public void setOrgnm(String orgnm) {
        this.orgnm = orgnm;
    }

    public String getCustcd() {
        return custcd;
    }

    public void setCustcd(String custcd) {
        this.custcd = custcd;
    }

    public String getCustnm() {
        return custnm;
    }

    public void setCustnm(String custnm) {
        this.custnm = custnm;
    }

    public String getDeptcd() {
        return deptcd;
    }

    public void setDeptcd(String deptcd) {
        this.deptcd = deptcd;
    }

    public String getDeptnm() {
        return deptnm;
    }

    public void setDeptnm(String deptnm) {
        this.deptnm = deptnm;
    }

    public String getWhcd() {
        return whcd;
    }

    public void setWhcd(String whcd) {
        this.whcd = whcd;
    }

    public String getWhnm() {
        return whnm;
    }

    public void setWhnm(String whnm) {
        this.whnm = whnm;
    }

    public String getUsergroup() {
        return usergroup;
    }

    public void setUsergroup(String usergroup) {
        this.usergroup = usergroup;
    }

    public String getUsergroupnm() {
        return usergroupnm;
    }

    public void setUsergroupnm(String usergroupnm) {
        this.usergroupnm = usergroupnm;
    }

    public String getIsusing() {
        return isusing;
    }

    public void setIsusing(String isusing) {
        this.isusing = isusing;
    }

    public String getLastlogin() {
        return lastlogin;
    }

    public void setLastlogin(String lastlogin) {
        this.lastlogin = lastlogin;
    }

    public String getLogincnt() {
        return logincnt;
    }

    public void setLogincnt(String logincnt) {
        this.logincnt = logincnt;
    }

    public String getPwdchgdate() {
        return pwdchgdate;
    }

    public void setPwdchgdate(String pwdchgdate) {
        this.pwdchgdate = pwdchgdate;
    }

    public String getPwdchgscdate() {
        return pwdchgscdate;
    }

    public void setPwdchgscdate(String pwdchgscdate) {
        this.pwdchgscdate = pwdchgscdate;
    }

    public String getIslock() {
        return islock;
    }

    public void setIslock(String islock) {
        this.islock = islock;
    }

    public String getPwdchgyn() {
        return pwdchgyn;
    }

    public void setPwdchgyn(String pwdchgyn) {
        this.pwdchgyn = pwdchgyn;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getInituseryn() {
        return inituseryn;
    }

    public void setInituseryn(String inituseryn) {
        this.inituseryn = inituseryn;
    }

    public String getLast3month() {
        return last3month;
    }

    public void setLast3month(String last3month) {
        this.last3month = last3month;
    }

    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPrint1() {
        return print1;
    }

    public void setPrint1(String print1) {
        this.print1 = print1;
    }

    public String getPrint2() {
        return print2;
    }

    public void setPrint2(String print2) {
        this.print2 = print2;
    }

    public String getPrint3() {
        return print3;
    }

    public void setPrint3(String print3) {
        this.print3 = print3;
    }

    public String getScale1() {
        return scale1;
    }

    public void setScale1(String scale1) {
        this.scale1 = scale1;
    }

    public String getSellerWhcd() {
        return sellerWhcd;
    }

    public void setSellerWhcd(String sellerWhcd) {
        this.sellerWhcd = sellerWhcd;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getPassBookAuthYn() {
        return passBookAuthYn;
    }

    public void setPassBookAuthYn(String passBookAuthYn) {
        this.passBookAuthYn = passBookAuthYn;
    }

    public int getFailCnt() {
        return failCnt;
    }

    public void setFailCnt(int failCnt) {
        this.failCnt = failCnt;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tcompcd: ");
        builder.append(compcd);
        builder.append("\n\tcompnm: ");
        builder.append(compnm);
        builder.append("\n\tusercd: ");
        builder.append(usercd);
        builder.append("\n\tname: ");
        builder.append(name);
        builder.append("\n\torgcd: ");
        builder.append(orgcd);
        builder.append("\n\torgnm: ");
        builder.append(orgnm);
        builder.append("\n\tcustcd: ");
        builder.append(custcd);
        builder.append("\n\tcustnm: ");
        builder.append(custnm);
        builder.append("\n\tdeptcd: ");
        builder.append(deptcd);
        builder.append("\n\tdeptnm: ");
        builder.append(deptnm);
        builder.append("\n\twhcd: ");
        builder.append(whcd);
        builder.append("\n\twhnm: ");
        builder.append(whnm);
        builder.append("\n\tusergroup: ");
        builder.append(usergroup);
        builder.append("\n\tusergroupnm: ");
        builder.append(usergroupnm);
        builder.append("\n\tisusing: ");
        builder.append(isusing);
        builder.append("\n\tlastlogin: ");
        builder.append(lastlogin);
        builder.append("\n\tlogincnt: ");
        builder.append(logincnt);
        builder.append("\n\tpwdchgdate: ");
        builder.append(pwdchgdate);
        builder.append("\n\tpwdchgscdate: ");
        builder.append(pwdchgscdate);
        builder.append("\n\tislock: ");
        builder.append(islock);
        builder.append("\n\tpwdchgyn: ");
        builder.append(pwdchgyn);
        builder.append("\n\tpass: ");
        builder.append(pass);
        builder.append("\n\tinituseryn: ");
        builder.append(inituseryn);
        builder.append("\n\tlast3month: ");
        builder.append(last3month);
        builder.append("\n\treturnCode: ");
        builder.append(returnCode);
        builder.append("\n\temail: ");
        builder.append(email);
        builder.append("\n\tprint1: ");
        builder.append(print1);
        builder.append("\n\tprint2: ");
        builder.append(print2);
        builder.append("\n\tprint3: ");
        builder.append(print3);
        builder.append("\n\tscale1: ");
        builder.append(scale1);
        builder.append("\n\tsellerWhcd: ");
        builder.append(sellerWhcd);
        builder.append("\n\tpaymentType: ");
        builder.append(paymentType);
        builder.append("\n\tpassBookAuthYn: ");
        builder.append(passBookAuthYn);
        builder.append("\n\tfailCnt: ");
        builder.append(failCnt);
        builder.append("\n}");
        return builder.toString();
    }
}
