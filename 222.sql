#MySQL启动
mysql -h localhost -P 3306 -u root -proot
mysql -u root -proot
#常用命令
#从一个库里面展示所有表明
SHOW TABLES FROM 库名; 
#描述一个表  
DESC 表名; 
#创建一个表
CREATE TABLE studentinfo(
	id INT,
	NAME VARCHAR(50),
	sex VARCHAR(1),
	age INT,
	city VARCHAR(50),
);
#向一个表中插入数据
INSERT INTO studentinfo (id,NAME,sex,age,city) VALUES(1,’jhon’,’男’,20,’北京’);
#查询所有信息
SELECT * FROM studentinfo;
#删除一条数据
DELETE FROM studentinfo WHERE id=1;
#单行注释 # 或者 --空格 内容
#多行注释 /* 内容  */

#DQL daba query language 数据查询语言
SELECT 字段、常量、表达式、函数 FROM 表
SELECT last_name FROM employees;
SELECT 100;
SELECT 100*8;
SELECT VERSION();
SELECT DATABASE();
SELECT USER();

SELECT  字段/ 常量/ 函数/ 表达式 FROM 表名
查询的结果是一个虚拟的表格
执行顺序：先看看是否存在 表，在查字段
即：第一步：FROM employees; 第二步 SELECT last_name

SELECT 100;
SELECT 10*98;
SELECT last_name FROM employees;
#查询当前数据库的版本
SELECT VERSION();
#查询当前数据库
SELECT DATABASE();
#查询用户
SELECT USER();
#起别名
SELECT last_name AS '姓' FROM employees;
#使用拼接函数，拼接字符串 注意 null 拼接任何值都是null
SELECT CONCAT(first_name, last_name) FROM employees;
#去重 关键字
SELECT DISTINCT department_id FROM employees;
#描述一个表
SHOW FULL COLUMNS FROM employees;
SHOW FULL FIELDS FROM employees;
DESC employees;

#函数 ifnull
#语法 ifnull(表达式1,表达式2)
/*
表达式1：可能为null 的字段
表达式2： 如果表达式1为null，则最终显示的值

功能：如果表达式1为null，则显示表达式2的值，否则默认显示表达式1的值

select commission_pct, ifnull(commission, '空') from employees;
*/

#条件查询
SELECT * FROM employees WHERE 条件;
/*
执行顺序
1。from 子句
2. where 子句
3. select 子句
特点：
1.  按关系表达式筛选
关系预算符： >  <  =  >=  <=  <>(!=)
2. 按逻辑表达式筛选
逻辑运算符： and  or  not 
3. 模糊查询
like 
in
between and
is null

示例：
案例1：查询部门编号不是 100 的员工的信息
select * 
from employees
where department_id <> 100;
案例2： 查询部门编号不在50-100的，员工姓名，邮箱，部门编号
方案1：
select last_name,email,department_id
from employees
where department_id<50 or department_id>100;
方案2：
select last_name,email,department_id
from employees
where not(department_id>=50 and department_id<=100);
案例3：查询奖金率大于0.03或者员工编号在60-110之间的
select *
from employees
where commission_pct > 0.03 or (employee_id>=60 and employee_id<=110);
*/

#模糊查询  like  或者 not like
一般和通配符配合使用，查询字符型数据  _ 匹配任意一个字符，%匹配任意多个字符（0到多个）
案例1：查询员工姓名中包含 a 的员工的信息
SELECT * FROM employees WHERE last_name LIKE '%a%';
案例2：查询员工姓名中第二个字符为 _  的员工的信息
方案1：SELECT * FROM employees WHERE last_name LIKE '_\_%'; # 默认使用 \ 为转义字符
方案2：sleect * FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$';
		# escape '$' 设置 $ 为转义字符
#模糊查询  in 或者  not in
用于查询某字段的值是否在列表之内
案例1：查询员工部门编号在30  50  90 的员工编号和邮箱
SELECT employee_id,department_id,email FROM employees
WHERE department_id IN (30,50,90);


一、起别名
1、用AS起别名
SELECT last_name AS 姓 FROM employees;
2、用空格起别名
SELECT last_name 姓  FROM employees;
3、别名有空格时需要用引号引起来
SELECT last_name AS '姓 名' FROM employees;

#between and / not between and 
# 判断某个字段的值是否介于 xx 之间 包括边界 即 >=
案例1：查询部门编号是 30--90之间的员工的部门编号和员工姓名
SELECT departmeng_id, last_name FROM employees WHERE department_id BETWEEN 30 AND 90;

案例2：查询年薪不是 100000-200000 之间的员工的姓名，工资，年薪。
SELECT first_name, salary, salary*12*(1+IFNULL(commission_pct, 0))
FROM employees
WHERE salary*12*(1+IFNULL(commission_pct, 0)) NOT BETWEEN 100000 AND 200000;

# is null  /  is not null
= 只能判断普通数值
IS 只能判断 NULL
<=> 安全等于，普通数值和NULL都能判断
案例1： 查询奖金率没有的员工信息；
SELECT * FROM employees WHERE commission_pct IS NULL;

练习
1.查询部门号是176的员工姓名和部门号和年薪
SELECT last_name,department_id, salary*12*(1+IFNULL(commission_pct, 0))
FROM employees WHERE employee_id = 176;
2.查询在20或50号部门工作的员工姓名和部门编号；
SELECT last_name,department_id FROM employees WHERE department_id IN (20,50);
3.查询没有管理者的员工姓名和 job_id；
SELECT last_name , job_id FROM employees WHERE manager_id IS NULL;
4.查询员工姓名既有a又有e的员工信息
SELECT * FROM employees WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';
方式2：SELECT * FROM employees WHERE last_name LIKE '%a%e%' OR last_name LIKE '%e%a%';

进阶：排序查询
语法：
SELECT *
FROM 表名
WHERE 查询条件
ORDER BY 排序列表（可以按多个字段排序）
执行顺序：
1.from子句
2.where子句
3.select子句
4.order BY
特点：
1.排序列表可以是： 单个字段，多个字段，表达式，函数，常量（列数），以及以上的组合
2。升序  ASC ，默认升序
	 降序  DESC，
案例
1.按单个字段排序，查询员工编号大于120的，按工资升序排序
SELECT * FROM employees WHERE employee_id > 120 ORDER BY salary ASC;
2.按表达式排序对有奖金的员工，按年薪降序排序
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 
FROM employees 
WHERE commission_pct IS NOT NULL 
ORDER BY salary*12*(1+IFNULL(commission_pct, 0)) DESC;
3.按别名排序
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 
FROM employees 
WHERE commission_pct IS NOT NULL 
ORDER BY 年薪 DESC;
4.按函数结果排序，按姓名的字数长度排序
SELECT LENGTH(last_name), last_name
FROM employees
ORDER BY LENGTH(last_name);
5.按多个字段排序，查询员工的姓名，工资，部门编号，先按工资升序，在按部门编号降序排序
SELECT last_name, salary, department_id
FROM employees
ORDER BY salary ASC, department_id DESC;
6.按常量（列数）排序，
SELECT * FROM employees ORDER BY 2; #按第二列的字符顺序排序
等同于 
SELECT * FROM employees ORDER BY first_name;

#进阶：常见函数(单行函数)
1.字符型函数
	1. CONCAT 拼接字符串
	SELECT CONCAT('hello', ' ', first_name, ' ', last_name) AS '备注' FROM employees;
	2. LENGTH() 获取字节长度
	SELECT LENGTH('hello,郭靖'); ==》 12
	3. CHAR_LENGTH() 获取字符长度 
	SELECT CHAR_LENGTH('hello,郭靖'); ==》 8
	4. SUBSTRING 截取子串
	注意：起始索引从1开始
	SUBSTRING(str, 起始索引，截取的长度);
	SUBSTRING(str, 起始索引);
	
	SELECT SUBSTRING('张三丰爱上了郭襄',1,3);
	SELECT SUBSTRING('张三丰爱上了郭襄',7);
	5. INSTR 获取字符第一次出现的索引
	SELECT INSTR('孙悟空三打aaa白骨精bbb白骨精', '白骨精');
	6. TRIM 去掉前后指定的字符，默认是空格
	SELECT TRIM('  成 昆   ');
	SELECT TRIM('x' FROM 'xxx成xx昆xxxxx');
	7. LPAD / RPAD 左填充 、 右填充
	SELECT LPAD('木婉清', 9, 'x');
	8. UPPER 小写字母转大写  LOWER 大写字母转小写
	SELECT UPPER('aaa');
	SELECT LOWER('BBB');
	9. STRCMP 比较两个字符的大小，按照UNICODE码的排序比较，前面比后面打返回 1，反之返回 -1，相等则返回 0；
	SELECT STRCMP('abc', 'aaa');
	SELECT STRCMP('abc', 'aec');
	SELECT STRCMP('abc', 'abc');
	10. LEFT / RIGHT  从 左边 或者 右边 截取子串
	SELECT LEFT('鸠摩智', 2);
	SELECT RIGHT('鸠摩智', 1);
	
	案例：查询员工表的姓名，要求，姓的首字母大写其它字母小写，名的全部字母大写，且姓和名之间用 _ 连接，最后起别名 'output';
	USE myemployees;
	SELECT CONCAT(UPPER(first_name),'_',UPPER(SUBSTRING(last_name,1,1)) , LOWER(SUBSTRING(last_name,2))) AS output FROM employees;
	
	
	
	
	
2.数学型函数
	1. ABS 求绝对值
	SELECT ABS(-999);
	2. CEIL 向上取整
	SELECT CEIL(99.2);
	3. FLOOR 向下取整
	SELECT FLOOR(99.9);
	4. ROUND(数字， 需要保留几位) 四舍五入
	SELECT ROUND(0.6);
	SELECT ROUND(1.857462, 3);
	5. TRUNCATE(数字， 需要保留的小数)  截断小数, 保留几位小数
	SELECT TRUNCATE(1.85746, 2);
	SELECT TRUNCATE(56874, 3);
	6. MOD 取余
	SELECT MOD(-10,-3);



3.日期型函数
	 1. NOW 获取当前日期时间
	 SELECT NOW();
	 2. CURDATE 获取当前日期
	 SELECT CURDATE();
	 3. CURTIME 获取当前时间
	 SELECT CURTIME();
	 4. DATEDIFF 获取两个日期之差
	 SELECT DATEDIFF('1999-1-11', NOW());
	 5. DATE_FORMAT 转换日期格式
	 SELECT DATE_FORMAT('1999-1-2', '%Y年%m月%d日 %H小时%i分钟%s秒') AS 出生年月;
	 6. STR_TO_DATE 按指定格式，把字符串解析成日期
	 SELECT STR_TO_DATE('3/15 1996','%m/%d %Y');
	 USE myemployees;
	 SELECT * FROM employees
	 WHERE hiredate < STR_TO_DATE('3/15 1998', '%m/%d %Y');
	 7. 提取年月日时分秒
	 YEAR(str)  
	 MONTH(str)
	 DAY(str)
	 HOUR(str)
	 MINUTE(str)
	 SECOND(str)

4.流程控制函数
	 1. IF(条件语句，成功的提示，失败的提示) 函数 
	 SELECT IF(100>9, '成功了', '失败了') 100大于9吗;
	 案例：如果有奖金，则显示年薪，否则显示0；
	 USE myemployees;
	 SELECT IF(commission_pct IS NULL, salary*12*(1+IFNULL(commission_pct, 0)), 0) FROM employees;
	 2. 
	 情况1 CASE 表达式
			WHEN 值1 THEN 结果1
			WHEN 值2 THEN 结果2
			WHEN 值3 THEN 结果3
			...
			ELSE 结果n
			END
	 案例：
	 部门编号是30，工资显示为2倍
	 部门编号是50，工资显示为3倍
	 部门编号是60，工资显示为4倍
	 否则不变
	 查询并显示 部门编号，新工资，就工资
	 USE myemployees;
	 SELECT department_id, salary,
	 CASE department_id
	 WHEN 30 THEN salary*2
	 WHEN 50 THEN salary*3
	 WHEN 60 THEN salary*4
	 ELSE salary
	 END AS newSalary
	 FROM employees;
	 
	 情况2
	 类似于多重 IF 语句，实现区间判断
	 CASE 
	 WHEN 值1 THEN 结果1
	 WHEN 值2 THEN 结果2
	 ...
	 ELSE 结果n
	 END
	 案例：
	 如果工资 > 20000，显示级别为A
	 如果工资 > 15000，显示级别为B
	 如果工资 > 10000，显示级别为C
	 否则显示级别为 D
	 USE myemployees;
	 SELECT 
	 CASE 
	 WHEN salary>20000 THEN 'A'
	 WHEN salary>15000 THEN 'B'
	 WHEN salary>10000 THEN 'C'
	 ELSE 'D'
	 END AS 级别
	 FROM employees;
	 
	 
	 练习：
	 1. 将员工的姓名按首字母排序，并显示姓名的长度
	 USE myemployees;
	 SELECT LENGTH(last_name), last_name FROM employees ORDER BY SUBSTRING(last_name,1,1);
	 2. 做一个查询产生下面的结果
	 King earns <salary> monthly but wants <salary*3>
	 USE myemployees;
	 SELECT CONCAT(last_name, ' ', 'earns', ' ', salary, ' ', 'monthly', ' ', 'but wants', ' ', salary*3) 期望 FROM employees;
   3. 使用 CASE-WHEN 按照下面的条件
	 job        grade 
	 AD_PRES    A
	 ST_MAN     B
	 IT_PROG    C
	 SA_REP     D
	 ST_CLERK   E
   产生下面的结果
	 Last_name   job_id    Grade 
	 king        AD_PRES   A 
	 USE myemployees;
	 SELECT CONCAT( UPPER(SUBSTRING(last_name,1,1)), LOWER(SUBSTRING(last_name,2)) ) AS Last_name, job_id, 
	 CASE job_id
	 WHEN 'AD_PRES'  THEN 'A'
	 WHEN 'ST_MAN'   THEN 'B'
	 WHEN 'IT_PROG'  THEN 'C'
	 WHEN 'SA_REP'   THEN 'D'
	 WHEN 'ST_CLERK' THEN 'E'
	 ELSE 'F'
	 END AS Grade 
	 FROM employees
	 ORDER BY Grade;
	 
	 
 进阶：分组函数：	 
   说明：分组函数往往用于实现将一组数据进行统计计算，最终得到一个值，又称为聚合函数或统计函数
	 
	 分组函数清单：
	 SUM(字段名) 求和
	 AVG(字段名) 求平均值
	 MAX(字段名) 求最大值
         MIN(字段名) 求最小值
	 COUNT(字段名) 计算非空字段值的个数
	 
	 COUNT 补充：
	 案例：查询有
	 USE myemployees;
	 #select count(distinct manager_id) from employees;
	 
	 案例：查询每个部门的工资之和
	 SELECT SUM(salary), department_id
	 FROM employees
	 GROUP BY department_id;

分组查询：
	 语法：
	 SELECT 查询列表（分组函数 和 被分组的字段）
	 FROM 表
	 WHERE 查询条件
	 GROUP BY 分组列表
	 HAVING 分组后筛选
	 ORDER BY 排序
	 执行顺序
	 FROM --> WHERE --> GROUP BY --> SELECT --> HAVING --> ORDER BY
	 
	 特点：
	 1. 查询列表往往是分组函数和被分组列表
	 2. 分组查询中的筛选分为两类
		       筛选的基表              使用的关键词         位置
	 分组前筛选    原始表			WHERE               GROUP BY 后面
	 分组后筛选    分组后的虚拟表           HAVING		    GROUP BY 前面
	 
	 顺序：
	 FROM --- WHERE --- GROUP BY ---- HAVING 
	 分组函数做条件只能放在 GROUP BY  后面
	 

  案例：
	1. 查询每个工种的平均工资
	USE myemployees;
	SELECT AVG(salary), job_id
	FROM employees GROUP BY job_id;

	2. 查询每个部门中邮箱包含 a 的最高工资
	USE myemployees;
	SELECT MAX(salary), department_id FROM employees WHERE email LIKE '%a%' GROUP BY department_id;

	3. 查询每个领导手下有奖金的员工的平均工资
	USE myemployees;
	SELECT AVG(salary), manager_id FROM employees
	WHERE commission_pct IS NOT NULL
	GROUP BY manager_id;

	4. 查询哪个部门的员工个数大于5
	应该先查每个部门的员工个数
	再筛选哪个部门的员工数大于5
	USE myemployees;
	SELECT COUNT(*) AS number, department_id FROM employees  GROUP BY department_id HAVING number > 5;
	
	5. 领导编号大于102的每个领导手下的最低工资大于5000的最低工资
	USE myemployees;
	SELECT MIN(salary), manager_id
	FROM employees
	WHERE manager_id > 102
	GROUP BY manager_id
	HAVING MIN(salary) > 5000;
  
  1. 内连接
	1. 等值连接
	  92语法---------------------------------------------------------------------------------------------------------------------
		语法：
		SELECT 查询列表
		FROM 表名1，表名2，。。。
		WHERE 等值连接的连接条件和筛选条件
		特点：
		1.为了解决多个表的字段重名的问题，往往给表起别名，提高语义性
		2.表的顺序无需求
		
		案例：
		简单的两表连接：
		1. 查询员工名和部门名
		SELECT last_name, department_name FROM employees em, departments de WHERE em.department_id = de.department_id;
		添加筛选条件
		2. 查询部门编号大于102的部门名和所在城市名
		SELECT city, department_name FROM departments de, locations lo WHERE de.location_id = lo.location_id;
		3. 查询有奖金的员工姓名和部门名
		SELECT last_name, department_name FROM employees em, departments de WHERE em.department_id = de.department_id AND commission_pct IS NOT NULL;
		添加分组和筛选
		4.查询每个城市的部门名
		SELECT city , department_name FROM departments de, locations lo WHERE de.location_id=lo.location_id GROUP BY lo.city;
	        5.查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
		SELECT MIN(salary),department_name, de.manager_id
		FROM employees em , departments de 
		WHERE em.department_id = de.department_id AND em.commission_pct IS NOT NULL
		GROUP BY de.department_id;
		6.查询部门中员工个数大于10的部门名
		SELECT COUNT(*), department_name 
		FROM employees em, departments de 
		WHERE em.department_id = de.department_id 
		GROUP BY de.department_id HAVING COUNT(*) >10;
		添加分组筛选排序
	 	7.查询部门中员工个数大于10的部门名，并按部门名降序
		SELECT department_name, COUNT(*)
		FROM employees em, departments de 
		WHERE em.department_id = de.department_id
		GROUP BY de.department_name
		HAVING COUNT(*)>10
		ORDER BY de.department_name;
		8.查询每个工种的员工个数和工种名，并按个数降序
		SELECT COUNT(*),em.job_id,job_title
		FROM employees em, jobs jo
		WHERE em.job_id = jo.job_id
		GROUP BY em.job_id
		ORDER BY COUNT(*) DESC;
		三表连接
		10. 查询员工名，部门名，城市名
		SELECT last_name, department_name, city
		FROM employees em, departments de, locations lo
		WHERE em.department_id=de.department_id AND de.location_id = lo.location_id;
		
	   99语法-------------------------------------------------------------------------------------------------------------------------------------------------
	        语法：
	        SELECT 查询列表
	        FROM 表名1 别名
	        INNER JOIN 表名2 别名
	        ON 连接条件
	        WHERE 筛选条件
	        GROUP BY 分组列表
	        HAVING 分组后筛选
	        ORDER BY 排序列表
	        sql92和sql99语法的区别：使用JOIN关键字代替之前的逗号，并将连接条件和筛选条件分开，提高了阅读性；
	        
	        案例：
	        1. 查询员工名和部门名
	        SELECT last_name, department_name FROM employees em INNER JOIN departments de ON em.department_id = de.department_id;
	        2. 查询部门编号大于100的部门名和所在城市名
	        SELECT department_name, city 
	        FROM departments de 
	        INNER JOIN locations lo 
	        ON de.location_id = lo.location_id 
	        WHERE department_id > 100;
	        3. 查询每个城市的部门个数
	        SELECT COUNT(*), city FROM departments de INNER JOIN locations lo 
	        ON de.location_id = lo.location_id
	        GROUP BY city;
	        4. 查询部门中员工个数大于10的部门名，并按部门名降序
		SELECT COUNT(*), department_name 
		FROM employees em INNER JOIN departments de
		ON em.department_id = de.department_id
		GROUP BY em.department_id
		HAVING COUNT(*)>10
		ORDER BY department_name DESC;
		
	   
	   
	   
	   
	   
	   
	   
	2. 非等值连接
		案例：
		查询部门编号在10-90之间的员工的工资级别，并按级别进行分组。
		SELECT COUNT(*), grade
		FROM employees em INNER JOIN sal_grade sa
		ON em.salary BETWEEN sa.min_salary AND sa.max_salary
		WHERE em.department_id BETWEEN 10 AND 90
		GROUP BY sa.grade;
		
	
	3.自连接
		案例： 查询员工名和对应的领导名
		SELECT em1.last_name, em2.last_name 
		FROM employees em1 INNER JOIN employees em2
		ON em1.manager_id = em2.employee_id;
		

	练习：
	1. 把当前日期显示为年月日
	SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日');
	2. 已知有三个表
	   表1：学员信息表stuinfo
	        stuId,  stuName,  gender,  majorId
	   表2： 已知专业表 major
	        id,  majorName
	   表3：已知成绩表 result
	        id 成绩编号,  majorId,  stuid,  score
	   问题：
	        1. 查询所有男生的姓名，专业名和成绩，使用sql92和sql99实现
	        sql92：SELECT stuName, majorName, score FROM stuinfo stu, major ma, result re 
		       WHERE stu.majorId=ma.id AND re.stuid=stu.stuId stu.gender='男';
	        
	        sql99：SELECT stuName,majorName,score 
		       FROM stuinfo stu 
		       INNER JOIN major ma ON stu.majorId=ma.id 
		       INNER JOIN result re ON re.stuid=stu.stuId 
		       WHERE stu.gender='男';
	        
	        2. 查询每个性别的每个专业的平均成绩，并按平均成绩降序
		       SELECT AVG(score), gender, s.majorId
		       FROM stuinfo s
		       INNER JOIN result r ON s.stuId=r.stuid
		       GROUP BY gender, s.majorId;
	        
	 
	 外连接： sql99
	   说明：查询结果为主表中所有的记录，如果从表有匹配项，则显示匹配项；没有则显示NULL
	   应用场景：一般用于查询主表中有，从表中没有的记录
	   特点：1. 外连接分主从两表，所以两表的顺序不能随意调换
		 2. 左连接的话，左边为主表
		    右连接的话，右边为主表
		 3. 外连接的查询结果 = 内连接的查询结果 + 主表有但从表没有的记录   
		 4. 一般用于查询 主表有但从表没有的记录
	   语法： 
		SELECT 查询列表
		FROM 表名1 别名1
		LEFT|RIGHT 【OUTER JOIN】 表名2 别名2
		ON 连接条件
		WHERE 筛选条件；
		
	   USE girls;
	   使用 girls 数据库；
	   案例
	       1.查询所有的女神记录，以及对应的男神名，如果没有对应的男神，则显示为NULL
	       左外连接
	       SELECT * FROM beauty be
	       LEFT JOIN boys bo
	       ON be.boyfriend_id = bo.id;
	       右外连接
	       SELECT * FROM boys bo
	       RIGHT JOIN beauty be
	       ON bo.id = be.boyfriend_id;
	       2.查询哪个女神没有男朋友与
	       左外连接
	       SELECT * FROM beauty be
	       LEFT JOIN boys bo
	       ON be.boyfriend_id = bo.id
	       WHERE bo.id IS NULL;
	       右外连接
	       SELECT * FROM boys bo
	       RIGHT JOIN beauty be
	       ON bo.id = be.boyfriend_id
	       WHERE bo.id IS NULL;
	       3. 查询哪个部门没有员工，并查询其部门编号和部门名
	       USE myemployees;
	       SELECT * FROM employees em
	       RIGHT JOIN departments de
	       ON em.department_id = de.department_id
	       WHERE em.employee_id IS NULL;
	   
	 练习：
	      1.查询编号大于3的女神的男朋友的信息，如果有则列出详细，如果没有则用NULL填充
	      USE girls;
	      SELECT * FROM beauty be 
	      LEFT JOIN boys bo
	      ON be.boyfriend_id = bo.id
	      WHERE be.id > 3;
	      
	      2.查询哪个城市没有部门
	      USE myemployees;
	      SELECT * FROM locations lo
	      LEFT JOIN departments de
	      ON lo.location_id = de.location_id
	      WHERE de.location_id IS NULL;
	      
	      3.查询部门名为 SAL 或 IT 的员工信息
	      SELECT last_name, de.department_name 
	      FROM employees em
	      LEFT JOIN departments de
	      ON em.department_id = de.department_id
	      WHERE de.department_name IN ('SAL', 'IT');
	      
	      
	      
  子查询
        说明：当一个查询语句中又嵌套了另一个完整的SELECT语句，则被嵌套的SELECT语句称为子查询或内查询，
	      外面的SELECT语句称为主查询或外查询。
	分类：按子查询出现的位置进行分类。
	特点：
	  1.子查询放在条件中，要求必须放在条件的右侧
	  2.子查询一般放在小括号中
	  3.子查的执行一般优先于主查询
	  4.单行子查询对应单行操作符： > < >= <= <>
	    多行子查询对应多行操作符： ANY SOME  ALL  IN
	1.select 后面
	  要求：子查询的结果为单行单列（标量子查询）
	  案例
	  1. 查询部门编号是50的员工的个数
	  SELECT COUNT(*) FROM employees WHERE department_id=50;
	  或者
	  SELECT (SELECT COUNT(*) FROM employees WHERE department_id=50) 个数;
	  
	2.from 后面
	  要求：子查询的结果可以为多行多列
	  案例：
	  1. 查询每个部门的平均工资的工资级别
	  SELECT department_id, dep_ag.ag, grade_level
	  FROM job_grades jo INNER JOIN (
		SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id
	  ) dep_ag
	  ON dep_ag.ag BETWEEN jo.lowest_sal AND jo.highest_sal;
	  
	  
	  
	3. WHERE或HAVING后面  
	  要求：子查询的结果必须为单列（多行子查询，单行子查询）
	  1.标量子查询（单行子查询）
	    案例：
	    1.谁的工资比 Abel 的工资高
	      SELECT last_name FROM employees WHERE salary > (SELECT salary FROM employees WHERE last_name='Abel');
	    2.返回 job_id 与 141号员工相同，salary比143号员工多的员工的 姓名 job_id 工资
	      SELECT last_name, job_id, salary FROM employees WHERE 
	      job_id=(SELECT job_id FROM employees WHERE employee_id=141) AND 
	      salary>(SELECT salary FROM employees WHERE employee_id = 143);
	    3.返回公司工资最少的员工的 last_name, job_id , salary
	      SELECT last_name, job_id, salary FROM employees WHERE salary = (SELECT MIN(salary) FROM employees);
	    4.查询最低工资大于50号部门最低工资的部门id和其最低工资
	      SELECT department_id, MIN(salary) 
	      FROM employees
	      GROUP BY department_id
	      HAVING MIN(salary) > (SELECT MIN(salary) FROM employees WHERE department_id=50);
	  
	  2.列子查询（多行子查询）
	    ANY / SOME 判断某字段的值是否满足其中任意一个
			X > ANY(10,20,30) 相当与 X > MIN()
			X < ANY() 相当于 X < MAX()
			
	    ALL  判断某字段的值是否满足列表的所有的值
			X > ALL(10,20,30);  相当于  X > MAX();
			X < ALL() 相当于 X < MIN()
			
	    IN   判断某字段是否在指定列表内
			X IN (10,20,30)
	    案例：
	      1. 返回 location_id 是 1400 或 1700 的部门中的所有员工姓名
	      SELECT last_name FROM employees em
	      INNER JOIN departments de ON em.department_id = de.department_id
	      WHERE de.department_id IN(SELECT department_id FROM departments WHERE location_id IN (1400,1700));
	      2. 返回其它部门中比 job_id 为 IT_PROG 的部门任一工资低的员工的 员工号 姓名 job_id 以及 salary
	      SELECT employee_id, last_name, job_id, salary 
	      FROM employees
	      WHERE salary < ANY(
	            SELECT DISTINCT salary FROM employees WHERE job_id = 'IT_PROG'
	      );
	      或者
	      SELECT employee_id, last_name, job_id, salary 
	      FROM employees
	      WHERE salary < (
	            SELECT MAX(salary) FROM employees WHERE job_id = 'IT_PROG'
	      );
	      3. 返回其它部门中比job_id为 IT_PROG 部门所有工资都低的员工的 员工号 姓名 job_id 以及salary
	      SELECT employee_id, last_name, job_id, salary FROM employees
	      WHERE salary < ALL(
		    SELECT DISTINCT salary FROM employees WHERE job_id = 'IT_PROG'
	      );
	      或者
	      SELECT employee_id, last_name, job_id, salary FROM employees
	      WHERE salary < (
		    SELECT MIN(salary) FROM employees WHERE job_id = 'IT_PROG'
	      );
	      
	      
	  3.行子查询（多行多列）
	  
	4. EXISTS 后面 ，结果 0 表示没有， 1 表示有
	  要求：子查询结果必须为单列（相关子查询）
	  案例：
	  1. 查询有没有叫做张三丰的员工
	  SELECT * FROM employees WHERE last_name='张三丰';
	  或者
	  SELECT EXISTS(
		SELECT * FROM employees WHERE last_name='张三丰'
	  ) 有无张三丰;
	  2. 查询没有女朋友的男神信息
	  
	  SELECT * FROM boys bo LEFT JOIN beauty be 
	  ON bo.id = be.boyfriend_id
	  
	
	      
	案例
	  1.查询和Zlotkey相同部门的员工姓名和工资
	  SELECT last_name, salary FROM employees WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Zlotkey');
	  
	  2.查询工资比公司平均工资高的员工的员工号，姓名和工资
	  SELECT employee_id, last_name, salary FROM employees WHERE salary>(SELECT AVG(salary) FROM employees);
		
        
        子查询练习
            1. 查询工资最低的员工信息：last_name, salary
               SELECT last_name, salary FROM employees WHERE salary=(SELECT MIN(salary) FROM employees);
            
            2. 查询平均工资最低的部门信息
               1.查询部门的平均工资
               SELECT AVG(salary),department_id FROM employees GROUP BY department_id;
               2.从 1 里面查询最低的平均工资
               SELECT MIN(ag) FROM (SELECT AVG(salary) ag,department_id FROM employees GROUP BY department_id) dep_ag;
               3.从 2 中查询平均工资最低的是哪个部门
               SELECT AVG(salary), department_id FROM employees GROUP BY department_id HAVING AVG(salary) = (
		  SELECT MIN(ag) FROM (SELECT AVG(salary) ag,department_id FROM employees GROUP BY department_id) dep_ag
               );
               4.从 3 中查询出部门信息
               SELECT * FROM departments WHERE department_id = (
			SELECT  department_id FROM employees GROUP BY department_id HAVING AVG(salary) = (
				SELECT MIN(ag) FROM (SELECT AVG(salary) ag,department_id FROM employees GROUP BY department_id) dep_ag
			)
               );
               或者
               SELECT d.*
		FROM departments d
		WHERE d.`department_id`=(
			SELECT department_id
			FROM employees
			GROUP BY department_id
			HAVING AVG(salary)=(
				SELECT MIN(ag)
				FROM (
					SELECT AVG(salary) ag,department_id
					FROM employees
					GROUP BY department_id
				) ag_dep

			)

		);
		或者
		SELECT * FROM departments WHERE department_id = (
			SELECT department_id FROM (
							SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id ORDER BY ag DESC LIMIT 1
						  ) ag1
		);
               
               
            3. 查询平均工资最低的部门信息和该部门的平均工资
               1.查询各个部门的平均工资
	       SELECT AVG(salary), department_id FROM employees GROUP BY department_id;
	       2. 从 1 中查询最低的部门工资
	       SELECT MIN(ag) FROM (SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id) ag1;
	       3. 从 2 中查询出部门id
	       SELECT department_id FROM employees GROUP BY department_id HAVING AVG(salary)=(
			 SELECT MIN(ag) FROM (SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id) ag1
	       );
	       4.查询部门信息和平均工资
	       SELECT de.department_id,de.department_name,de.manager_id,de.location_id,AVG(salary) FROM employees em LEFT JOIN departments de ON em.department_id=de.department_id
	       WHERE de.department_id = (
			SELECT department_id FROM employees GROUP BY department_id HAVING AVG(salary)=(
				 SELECT MIN(ag) FROM (SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id) ag1
		        )
	       ) GROUP BY de.department_id;
	       
            
            4. 查询平均工资最高的 job 信息
               1.按job_id分组
               SELECT AVG(salary), job_id FROM employees GROUP BY job_id;
               2.查询出最高的平均工资
               SELECT MAX(ag) FROM (SELECT AVG(salary) ag,job_id FROM employees GROUP BY job_id) job_avg; 
               3.查询出最高平均工资的 job_id
               SELECT job_id 
               FROM (SELECT MAX(salary) ma,job_id FROM employees GROUP BY job_id) job1 
               WHERE ma = (SELECT MAX(ag) FROM (SELECT AVG(salary) ag,job_id FROM employees GROUP BY job_id) job_avg);
               4.完成
               SELECT * FROM jobs WHERE job_id = (
		 SELECT job_id 
                 FROM (SELECT MAX(salary) ma,job_id FROM employees GROUP BY job_id) job1 
                 WHERE ma = (SELECT MAX(ag) FROM (SELECT AVG(salary) ag,job_id FROM employees GROUP BY job_id) job_avg)
               );
               
               或者：
               SELECT * 
		FROM jobs
		WHERE job_id=(
			SELECT job_id
			FROM employees
			GROUP BY job_id
			ORDER BY AVG(salary) DESC
			LIMIT 1

		);
            
            5. 查询平均工资高于公司平均工资的部门有哪些
               1.查询公司的平均工资
               SELECT AVG(salary) FROM employees;
               2.查询各个部门的平均工资
               SELECT AVG(salary) , department_id FROM employees GROUP BY department_id;
               3.查询最后结果
               SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id HAVING ag>(
			SELECT AVG(salary) FROM employees
               );
               或者
               SELECT AVG(salary),department_id
		FROM employees
		GROUP BY department_id
		HAVING AVG(salary)>(
			SELECT AVG(salary)
			FROM employees

		);
            
            6. 查询出公司中所有 manager 的详细信息
               SELECT * FROM employees WHERE manager_id = ANY(
			SELECT DISTINCT manager_id FROM departments
               );
            7. 各个部门中 最高工资中最低的那个部门的 最低工资是多少
               1.查询各个部门的最高工资
               SELECT MAX(salary) , department_id FROM employees GROUP BY department_id ORDER BY MAX(salary);
               2.在 1 中查询最低的
               SELECT MIN(ag) FROM (SELECT MAX(salary) ag, department_id FROM employees GROUP BY department_id) ag1;
               3.查询最高工资是 2 的部门 id
               SELECT department_id FROM employees GROUP BY department_id HAVING MAX(salary)=(
			SELECT MIN(ag) FROM (SELECT MAX(salary) ag, department_id FROM employees GROUP BY department_id) ag1
               );
               4.查询 department_id 是 4的结果的部门的所有工资
               SELECT salary FROM employees WHERE department_id = (
				SELECT department_id FROM employees GROUP BY department_id HAVING MAX(salary)=(
					SELECT MIN(ag) FROM (SELECT MAX(salary) ag, department_id FROM employees GROUP BY department_id) ag1
			       )
               );
               5.查询4的结果中最小的工资
               SELECT MIN(salary) FROM (
			SELECT salary FROM employees WHERE department_id = (
				SELECT department_id FROM employees GROUP BY department_id HAVING MAX(salary)=(
					SELECT MIN(ag) FROM (SELECT MAX(salary) ag, department_id FROM employees GROUP BY department_id) ag1
			       )
			)
               ) sal2;
            8. 查询平均工资最高的部门的 manager 的详细信息：last_name, department_id, email, salary 
               1.查询各个部门的平均工资
               SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1;
	       2.查询 1的结果的 manager_id
	       SELECT manager_id FROM departments WHERE department_id = (SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1);
               3.查询 employee_id 是2的结果的员工信息
               SELECT last_name, department_id, salary FROM employees WHERE employee_id=(
			SELECT manager_id FROM departments WHERE department_id = (SELECT department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC LIMIT 1)
               );
         子查询练习2
            1.查询和Zlotkey相同部门的员工姓名和工资
	        1.查询  Zlotkey  的部门
	        SELECT department_id FROM employees WHERE last_name='Zlotkey';
	        2.查询和 1的结果的相同的员工信息
	        SELECT last_name, salary FROM employees WHERE department_id=(
			SELECT department_id FROM employees WHERE last_name='Zlotkey'
	        );
            
            2.查询工资比公司平均工资高的员工的员工号 姓名 工资
                SELECT employee_id, last_name, salary FROM employees WHERE salary > ( SELECT AVG(salary) FROM employees);
            3.查询各部门中工资比本部门平均工资高的员工的员工号和姓名和工资
                
                SELECT * FROM employees em
                INNER JOIN (
			SELECT AVG(salary) ag, department_id FROM employees GROUP BY department_id
                ) dep_ag
                ON em.department_id = dep_ag.department_id
                WHERE em.salary > dep_ag.ag;
                或者
                SELECT employee_id,last_name,salary,e.department_id
		FROM employees e
		INNER JOIN (
			SELECT AVG(salary) ag,department_id
			FROM employees
			GROUP BY department_id


		) ag_dep
		ON e.department_id = ag_dep.department_id
		WHERE salary>ag_dep.ag ;
                
            4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
	       1.查询姓名中包含 u 的员工的部门
	       SELECT DISTINCT department_id FROM employees WHERE last_name LIKE '%u%';
	       2.结果
	       SELECT employee_id, last_name FROM employees WHERE department_id IN (
			SELECT DISTINCT department_id FROM employees WHERE last_name LIKE '%u%'
	       );
            
            5.查询在部门的  location_id  为1700的部门工作的员工的员工号
               SELECT employee_id FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id=1700);
            
            6.查询管理者是King的员工姓名和工资
	       SELECT last_name, salary FROM employees WHERE manager_id IN (SELECT manager_id FROM employees WHERE last_name='K_ing');
               
            7.查询工资最高的员工姓名，要求：first_name 和last_name 显示为一列列明为 姓.名
               
               SELECT CONCAT(first_name, '.', last_name) AS '姓.名' FROM employees WHERE salary=(SELECT MAX(salary) FROM employees);
  
  
      分页查询：
          语法：
          SELECT 查询列表
          FROM 表1 别名2
          JOIN 表2 别名2
          ON 连接条件
          WHERE 筛选条件
          GROUP BY 分组列表
          HAVING 分组后筛选
          ORDER BY 排序列表
          LIMIT 起始的索引，显示的数据数量
          
          执行顺序
          FROM --> JOIN --> ON --> WHERE --> GROUP BY --> HAVING --> SELECT --> ORDER BY --> LIMIT
          
          特点：
               如果起始索引不写默认从 0 开始
               
          
          案例：
             1. 查询员工表前5条
             SELECT * FROM employees LIMIT 5 等价于  SELECT * FROM employees LIMIT 0,5
             2，有奖金的且工资较高的第 11-20 名 
             SELECT * FROM employees WHERE commission_pct IS NOT NULL ORDER BY salary DESC LIMIT 10,10;
             
    联合查询：
	  说明：当查询结果来自于多张表，但多张表之间没有关联，这个时候往往使用联合查询，也UNION查询
	  语法：
	  SELECT  查询列表 FROM 表1 WHERE 筛选列表
	  UNION
	  SELECT  查询列表 FROM 表2 WHERE 筛选列表
	  特点：
	    1.每个表的查询列数必须一样，查询列表的各个项的意义类型最好一致
	    2. UNION 自动去重， UNION ALL 支持显示重复项
          SELECT department_name FROM departments UNION SELECT city FROM locations;
          SELECT 1,3  UNION SELECT 1,3 UNION SELECT 1,3
          SELECT 1,3  UNION ALL SELECT 1,3 UNION ALL SELECT 1,3


#DDL 数据定义语言 data define language
    专门用于操作数据库和数据表的
    #---库的管理---------------------------
    #1.创建数据库
       CREATE DATABASE stutest;
       CREATE DATABASE IF NOT EXISTS stutest;
    #2.删除数据库
       DROP DATABASE stutest;
       DROP DATABASE IF EXISTS stutest;   
    #---表的管理---------------------------
    #1.创建表
       CREATE TABLE IF NOT EXISTS 表名 (
		字段名 字段类型 【约束】,
		字段名 字段类型 【约束】,
		字段名 字段类型 【约束】,
		字段名 字段类型 【约束】
		......
       );
       #示例
       USE test;
       CREATE TABLE IF NOT EXISTS stuinfo (
		id INT,
		cname VARCHAR(20),
		age INT
       );
       DESC stuinfo;
       #常见的数据类型
       1. INT 整形
       2. DOUBLE / FLOAT 浮点型，例如 DOUBLE(5,2)表示最多5位，其中必须有2位小数，即最大值位 999.99
       3. DECIMAL 浮点型，表示在钱方面使用该类型，因为不会出现精度确实问题
       4. CHAR 固定长度的字符串，如 CHAR(4) 是 0-255 
       5. VARCHAR 可变长度字符串类型 
       6. TEXT 字符串类型，表示存储较长文本，如 日记小说
       
       # 表格
       #           意思           格式        n的解释                      特点                              效率
       # char      固定长度字符   char        最大的字符个数，可选默认1    不管实际存储，开辟的空间都是n个   高
       # varchar   可变长度字符   varchar(n)  最大的字符个数，必选         根据实际存储决定开辟的空间        低
       
       7. BLOB 字节类型，
       8. DATE 日期类型，格式为 yyyy-MM-dd
       9. TIME 时间类型，格式为 hh:mm:ss
       10. TIMESTAMP / DATETIME 时间戳类型 日期+时间  yyyyMMdd hhmmss
       
       # 表格
       # 	     保存范围              所占字节
       # datetime    1900-1-1~xxxx年       8
       # timestamp   1970-1-1~2038-12-31   4
       
       #常见约束
       说明：用于限制表中字段的数据的，从而进一步保证数据表的数据的一致性，准确性，可靠性！！！
       NOT NULL 非空      用于限制该字段为必填项
       DEFAULT 默认       用于限制该字段没有显式插入值，则直接显示默认值
       PRIMARY KEY 主键   用于限制该字段值不能重复，设置为主键列的字段默认不能为空
                          一个表只能有一个主键，当然可以是组合主键
       UNIQUE 唯一        用于限制该字段不能重复
       
			  # 表格
			  #	      字段是否可以为空         一个表可以有几个
                          #主键约束   否                       一个
                          #唯一约束   是                       n个
                          
       CHECK 检查         用于限制该字段必选满足指定条件 
                          CHECK(age BETWEEN 10 AND 30) 【说明：WHERE 后面可以写啥，这里就可以写啥】
       FOREIGN KEY 外键   用于限制两个表的关系，要求外键列的值必须来自主表的关联列
	                  要求：
			       1.主表的关联列和从表的关联列的类型必须一致，意思一样，名称无要求
			       2.主表的关联列要求必须是主键
       
       添加外键的语法
       CREATE TABLE IF NOT EXISTS stuinfo (
	 id PRIMARY KEY ,
	 majorid INT,
	 CONSTRAINT fk_stuinfo_major FOREIGN KEY majorid REFERENCES major(id)
       );
       
    #2.修改表
       语法： 
       ALTER TABLE 表名 ADD(增加列) | MODIFY(修改列的类型) | CHANGE(改列名) | DROP(删除列)  COLUMN  字段名  字段类型 【字段约束】;
       
       
       CREATE DATABASE IF NOT EXISTS test DEFAULT CHARACTER SET utf8;
       
       
       USE test;
       CREATE TABLE major(
	  majorid INT PRIMARY KEY,
	  majorname VARCHAR(50)
       );
        
       INSERT INTO major (majorid,majorname) VALUES (4, '化学');
       INSERT INTO major (majorid,majorname) VALUES (5,'生物');
       INSERT INTO major (majorid,majorname) VALUES (6,'历史');
       CREATE TABLE stuinfo (
	  stuid INT PRIMARY KEY,
	  sname VARCHAR(10) NOT NULL,
	  sage INT NOT NULL,
	  majorid INT NOT NULL,
	  FOREIGN KEY(majorid) REFERENCES major(majorid)
       );
       1. 修改表名
          ALTER TABLE stuinfo RENAME TO students;
       2. 添加字段
          ALTER TABLE students ADD COLUMN sborndate TIMESTAMP NOT NULL;  
       3. 修改字段名
          ALTER TABLE students CHANGE COLUMN sborndate birthday DATETIME NULL;
       4. 修改字段类型
          ALTER TABLE students MODIFY COLUMN birthday TIMESTAMP NOT NULL;
       5. 删除字段
          ALTER TABLE students DROP COLUMN birthday;    
                                   
    
    #3.删除表
	DROP TABLE IF EXISTS students;
	
    #4.复制表
       #仅仅复制表的结构
       CREATE TABLE newTable LIKE girls.beauty;
       #复制表的结构 和 数据
       CREATE TABLE newTable2 SELECT * FROM girls.beauty;
       
       案例：
       1. 复制 employees 的last_name, department_id, salary 到新表 emp 表，但不复制字段
       CREATE TABLE emp SELECT last_name, department_id, salary FROM myemployees.employees WHERE 1=2;
      
       练习
       1. 使用分页查询实现，查询员工信息表中部门为50号的工资最低的5名员工信息
       SELECT * FROM employees WHERE department_id = 50 ORDER BY salary ASC LIMIT 5;
       2. 使用子查询实现城市为 Toronto 的，且工资 > 10000 的员工的姓名
           1. 查询城市为 Toroto 的 location_id
           SELECT location_id FROM locations WHERE city='Toronto';
           2. 查询 location_id 的结果为 1 的department_id
           SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM locations WHERE city='Toronto');
           3. 查结果
           SELECT last_name FROM employees WHERE salary>10000 AND department_id=(
		SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM locations WHERE city='Toronto')
           );
           或者
           USE myemployees;
           SELECT last_name FROM departments de
           INNER JOIN employees em ON de.department_id = em.department_id
           INNER JOIN locations lo ON de.location_id = lo.location_id
           WHERE em.salary>10000 AND lo.city='Toronto';
           或者
           SELECT last_name FROM employees
           WHERE salary>10000 AND department_id IN (
		SELECT department_id FROM departments de
		INNER JOIN locations lo 
		ON lo.location_id = de.location_id
		WHERE city = 'Toronto'
           );
       
       3. 创建表 qqinfo 里面包含 qqid 添加主键约束 昵称 nickname , 添加唯一约束邮箱 email 添加非空约束 性别gender
       USE test;
       CREATE TABLE IF NOT EXISTS qqinfo (
	  qqid INT PRIMARY KEY,
	  nickname VARCHAR(50) UNIQUE,
	  email VARCHAR(50) NOT NULL,
	  gender INT
       );
       4. 删除表 qqinfo
       USE test;
       DROP TABLE IF EXISTS qqinfo;
       5. 试着写出 SQL 查询语句的定义顺序和执行顺序
       SELECT 查询列表
       FROM 表名 别名
       INNER|LEFT|RIGHT JOIN 表名 别名
       ON 连接条件
       WHERE 筛选条件
       GROUP BY 分组列表
       HAVING 分组后筛选
       ORDER BY 排序列表
       LIMIT n,m
       
       FROM --> INNER ON --> WHERE --> GROUP BY --> HAVING --> SELECT --> SELECT --> ORDER BY --> LIMIT
        

#DML 数据操作语言 data manipulation language 数据操作语言  insert update delete 
     1. 数据插入
     语法：插入单行
     INSERT INTO 表名 (字段1, 字段2, ...) VALUES (值1,值2,...);
           插入多行
     INSERT INTO 表名 (字段1, 字段2, ...) VALUES (值1,值2,...),(值1,值2,...),(值1,值2,...);      
     特点
         1. 字段和值列表一一对应，包含的类型 约束等必须匹配
         2. 数值型的值不用单引号，非数值型的值必须使用单引号
         3. 字段顺序无要求
         
     案例：
     插入可以为空的字段，字段和值都不写或者字段写上值用NULL
     插入有默认值的字段，值用 DEFAULT 代替
     简写方式： INSERT INTO 表名 VALUES(值列表);
     
     2. 自增长列
     CREATE TABLE IF NOT EXISTS gradeinfo(
	gradeid INT PRIMARY KEY AUTO_INCREMENT,
	gradename CHAR(10) DEFAULT NULL
     );
     说明：设置了自增长列的数据，插入的时候，字段值用 NULL 代替
           自增列一个表只能有一个自增列，且必须是数值型
     INSERT INTO gradeinfo VALUES (NULL, '数学'),(NULL, '英语'),(NULL, '语文');
     
     3. 删除数据
     语法
         1. DELETE FROM 表名 # 删除全部数据
            DELETE FROM 表名 WHERE 筛选条件 # 删除复核条件的数据
         2. TRUNCATE FROM 表名; # 删除全部数据，执行原理：删除 drop 整个表，在新建一个一样的空表
     面试题：DELETE 和 TRUNCATE 的区别
         1. DELETE 可以添加 WHERE 条件， TRUNCATE 不能添加WHERE条件，一次删除所有数据
         2. TRUNCATE 的效率高
         3. 如果删除带有自增的列，重新插入数据的时候，
            DELETE 删除的，会从断点处开始自增
            TRUNCATE 删除的，会从 1 开始自增
         4. DELETE 删除数据可以返回影响的条数， TRUNCATE 则不会
         5. DELETE 删除数据支持事务回滚， TRUNCATE 则不支持

#TCL 


#事务
     #含义：一个事务是由一条或者多条 sql 语句构成，这一条或者多条 sql 语句要么全部执行成功，要么全部执行失败。
     分类：
	  隐式事务：没有明显的开启结束标记
	      比如：INSERT 语句
	  显示事务：具有明显的开启结束标记
	      一般由多条 SQL 语句组成，必须有明显的开启结束标记
	      步骤：
	      1. 取消事务自动开启的功能
	      2. 开启事务
	      3. 编写事务需要的 SQL 语句（1条或多条）
	         INSERT 。。。
	         INSERT 。。。
	      4. 关闭事务
           
     SHOW VARIABLES LIKE '%auto%'; # 结果中有个 autocommit 是 on
     
     # 演示事务的使用步骤
     1. 取消事务自动开启
        SET autocommit = 0;
     2. 开启事务
        START TRANSACTION; 
     3.               
	  
     





























