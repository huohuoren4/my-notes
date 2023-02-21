#!/bin/bash
# -*- coding:utf-8 -*-

drop procedure if exists idata;
delimiter ;;
create procedure idata()
begin
  declare i int;
  declare price decimal(10,2);
  declare username varchar(50);
  set i=1, price=10.20, username="小明123";
START TRANSACTION;
  while(i<=1000000)do
    INSERT INTO `blog_user`(`id`, `username`, `age`, `price`, `description`, `group_id`) VALUES ( NULL, username, i , price,'weweweewew','1');
    set i=i+1;
  end while;
commit;
end;;
delimiter ;
call idata();