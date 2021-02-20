#create database myemployees;
use myemployees;
-- create table employees (
-- 	id int primary key  comment '主键',
-- 	employee_id varchar(20)  COMMENT '员工编号',
-- 	first_name varchar(25)  COMMENT '名',
-- 	last_name varchar(25)  comment '姓',
-- 	email varchar(25)  comment '邮箱',
-- 	phone_number varchar(20)  comment '电话号码',
-- 	job_id varchar(10)  comment '工种编号',
-- 	salary double(10,2)  comment '月薪',
-- 	commission_pct double(4,2)  comment '奖金率',
-- 	manager_id int(6)  comment '上级领导的员工编号',
-- 	department_id int(4)  comment '部门编号',
-- 	hiredate datetime  comment '入职日期'
-- )comment='员工表';

#desc employees;

-- create table departments (
-- 	id int primary key comment '主键',
-- 	department_id int(4) comment '部门编号',
-- 	department_name varchar(10) comment '部门名称',
-- 	manager_id int(6) comment '部门领导的员工编号',
-- 	location_id int(4) comment '位置编号'
-- ) comment='部门表';


-- create table locations (
--  id int(11) primary key comment '主键',
--  location_id varchar(40) comment '位置编号',
--  street_address varchar(40) comment '街道',
--  postal_code varchar(12) comment '邮编',
--  city varchar(30) comment '城市名称',
--  state_province varchar(25) comment '省',
--  country_id varchar(25) comment '国家编号'
-- ) comment='位置表';


create table jobs (
	id int primary key comment '主键',
	job_id varchar(10) comment '工种编号',
	job_title varchar(35) comment '工种名称',
	min_salary int(6) comment '最低工资',
	max_salary int(6) comment '最高工资'
) comment '工种表';


















