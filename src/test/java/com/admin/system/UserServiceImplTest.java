package com.admin.system;
import javax.annotation.Resource;  

import org.apache.log4j.Logger;  
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;  
import com.admin.entity.system.User;
import com.admin.service.system.UserService;
import com.haier.common.ServiceResult;

 /**
 * 
 * @Filename 
 * @Version: 1.0
 * @author gaojingfei
 * @date 2017年11月13日
 */
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) 
@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
public class UserServiceImplTest{
	private static Logger logger = Logger.getLogger(UserServiceImplTest.class);  
	@Resource
	private UserService userService;
	
	@Test
	public void testGetByMobile(){
		ServiceResult<User> result = userService.getByMobile("18765996558");
		System.out.println(result.getSuccess());
		System.out.println(result.getResult().getName());
		logger.info("用户姓名：" + result.getResult().getName()); 
	}

	@Test
	public void test1() {
        //TODO
	}
}
