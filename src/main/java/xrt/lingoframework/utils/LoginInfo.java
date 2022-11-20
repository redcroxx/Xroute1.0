package xrt.lingoframework.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import xrt.lingoframework.common.vo.LoginVO;

public class LoginInfo {

    public static LoginVO get() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
        return loginVO;
    }

    public static String getCompcd() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginUser = (LoginVO) request.getSession().getAttribute("loginVO");
        String compcd = "";

        if (loginUser != null)
            compcd = loginUser.getCompcd();

        return compcd;
    }

    public static String getUsercd() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginUser = (LoginVO) request.getSession().getAttribute("loginVO");
        String usercd = "";

        if (loginUser != null)
            usercd = loginUser.getUsercd();

        return usercd;
    }

    public static String getName() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginUser = (LoginVO) request.getSession().getAttribute("loginVO");
        String name = "";

        if (loginUser != null)
            name = loginUser.getName();

        return name;
    }

    public static String getOrgcd() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginUser = (LoginVO) request.getSession().getAttribute("loginVO");
        String name = "";

        if (loginUser != null)
            name = loginUser.getOrgcd();

        return name;
    }

    public static String getWhcd() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginUser = (LoginVO) request.getSession().getAttribute("loginVO");
        String name = "";

        if (loginUser != null)
            name = loginUser.getWhcd();

        return name;
    }

    public static String getUsergroup() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        LoginVO loginUser = (LoginVO) request.getSession().getAttribute("loginVO");
        String usergroup = "";

        if (loginUser != null)
            usergroup = loginUser.getUsergroup();

        return usergroup;
    }
}