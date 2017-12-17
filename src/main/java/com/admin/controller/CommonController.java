package com.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CommonController {

    @RequestMapping(value = { "/", "/login", "/login.html" }, method = { RequestMethod.GET })
    public String login(HttpServletRequest request) {
        return "login";
    }


}  