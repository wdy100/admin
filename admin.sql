DROP TABLE IF EXISTS `users`;  
  
CREATE TABLE `users` (  
  `id` int(11) NOT NULL AUTO_INCREMENT,  
  `name` varchar(45) NOT NULL,  
  `mobile` varchar(20) NOT NULL,  
  PRIMARY KEY (`id`)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;  
  
/*Data for the table `user` */  
  
insert  into `users`(`id`,`name`,`mobile`) values (1,'测试','18765996558'); 