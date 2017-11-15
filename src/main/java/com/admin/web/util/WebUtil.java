package com.admin.web.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.haier.common.util.StringUtil;

public class WebUtil {
    protected static org.apache.log4j.Logger log = org.apache.log4j.LogManager
                                                     .getLogger(WebUtil.class);

    /**
	 * 将json或jsonp的返回数据写入到response中。
	 * 
	 * @param result
	 *            要转换为json或jsonp的对象
	 * @param request
	 *            http request
	 * @param response
	 *            json response
	 */
	public static void writeAjaxResponse(Object result,
			HttpServletRequest request, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setContentType("text/plain;charset=utf-8");
			out = response.getWriter();
			String jsonStr = null;
			String callback = request.getParameter("callback");
			String json = JSON.toJSONString(result,
					SerializerFeature.BrowserCompatible);
			if (StringUtil.isEmpty(callback, true)) {
				jsonStr = json;
			} else {
				jsonStr = callback + "(" + json + ")";
			}
			out.write(jsonStr);
		} catch (IOException e) {
			log.error(
					"[shoppingmall-member-web][WebUtil][writeAjaxResponse]开启输出流错误",
					e);
		} finally {
			if (out != null) {
				try {
					out.flush();
					out.close();
				} catch (Exception e) {
					log.error(
							"[shoppingmall-member-web][WebUtil][writeAjaxResponse]关闭输出流错误",
							e);
				}
			}
		}
	}
}
