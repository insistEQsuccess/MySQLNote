#MySQL启动
mysql -h localhost -P 3306 -u root -proot
mysql -u root -proot
#常用命令
#从一个库里面展示所有表明
show tables from 库名; 
#描述一个表  
desc 表名; 
#创建一个表
create table studentinfo(
	id int,
	name varchar(50),
	sex varchar(1),
	age int,
	city varchar(50),
);
#向一个表中插入数据
insert into studentinfo (id,name,sex,age,city) values(1,’jhon’,’男’,20,’北京’);
#查询所有信息
select * from studentinfo;
#删除一条数据
delete from studentinfo where id=1;
#单行注释 # 或者 --空格 内容
#多行注释 /* 内容  */

#DQL daba query language 数据查询语言

#DML 数据操作语言

#DDL 数据定义语言

#TCL 









