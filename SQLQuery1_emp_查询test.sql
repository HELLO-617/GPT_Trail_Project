--1.计算列
select * from emp;
select ename as "姓名" from emp;
select ename as "姓名",emp_sal*12 as "年薪" from emp;

--2.distinct
select distinct dept_id from emp;

--3.between
--查找工资在1500到3000之间：【1500，3000】
select * from emp
    where sal between 1500 and 3000
--查找工资<3000或者>5000的
select * from emp
    where sal not between 3000 and 5000
--等价于
select * from emp
    where sal<3000 or emp_sal>5000

--4.in
select * from emp
    where sal in (2000,3000,3500)
select * from emp where sal not in (2000,3000,3500)
--等价于
select * from emp where sal<>2000 and sal<>3000 and sal<>3500

--5.top
select top 5 * from emp;
select top 11 percent * from emp;--输出前11%，向上取整，如10×0.11=1.1向上取整为2

--6.order by
select * from emp order by sal;--默认升序
select * from emp order by dept_id,sal;--先按dept_id排序，dept_id相同，再按sal排序
select * from emp order by dept_id desc, sal;--先按dept_id降序排序，dept_id相同，再按sal升序排序
select * from emp order by dept_id, sal desc--先按dept_id升序排序，dept_id相同，再按sal降序排序
--desc降序只对它前面一个有效

--输出工资在3000到5000的工资最高的前4个
select top 4 * from emp where sal between 1000 and 5000 order by sal desc

--7.null
select * from emp where comm is null;
select * from emp where comm is not null;
select ename, sal*12+comm "实发工资/年" from emp;
--本程序证明了null参与的任何运算结果都会是null，正确写法为：
select ename as "姓名", sal*12+isnull(comm,0) "实发工资/年" from emp;--isnull是内置函数，意思是如果comm是null，会被替换为0

--8.模糊查询
select * from emp where ename like '%A%' --含有A就输出，有点像excel的vlookup啊
select * from emp where ename like 'A%' --首字母是A时输出
select * from emp where ename like '%e' --尾字母是e就输出
select * from emp where ename like '_a%' --第二个字母是a时输出
select * from emp where ename like '%[a-j]%' --只要含有abcdefghij中的任一字母就输出
select * from emp where ename like '%[a,b]%' --只要含有a or b 就输出
select * from emp where ename like '%[^a-p]%' --只要含有不是abcdefghijklmnop中的任一字母的字母(rstuvwxyz)就输出
select * from emp where ename like '_[^a,i,o]%' --当第二个字母不是aio时输出

--9.聚合函数
select lower(ename) from emp; --大写变小写,不是聚合函数，是单行函数
select max(sal) from emp; --类似的聚合函数还有min(),avg()平均值
select count(*) from emp; --返回emp表所有记录的个数
select count(dept_id) from emp; --重复记录也被计数
select count(distinct dept_id) from emp; --计数不重复记录
select count(comm) from emp; --NULL不计数，返回有多少员工有奖金

--10.group by
select dept_id,avg(sal) as "部门平均工资" from emp 
       group by dept_id;
select dept_id,count(*) from emp group by dept_id; --竟然可行，好智能
select dept_id,position,count(*) from emp group by dept_id,position;

--11.having 用于对分组后的数据进行过滤
select dept_id,avg(sal) as "部门平均工资" from emp 
       group by dept_id
	   having avg(sal) > 2000;

select dept_id,avg(sal) as "部门平均工资" from emp 
       group by dept_id
	   having count(*) > 2; --把部门人数小于2的部门的部门信息剔除掉

--where把每个部门名字中含A的员工去掉，group by按部门编号分组计算部门平均工资，having再把部门平均工资低于2000的去掉
select dept_id,avg(sal) as "部门平均工资" from emp where ename not like '%a%'
       group by dept_id
	   having avg(sal) > 2000;  
	   
--插入一个知识： into   用得不多，但得看懂，作用是把查询的内容存入到一个新的表里
select dept_id,avg(sal) as "部门平均工资" 
       into emp_2
       from emp
	   group by dept_id;
	   --执行了会新建个表emp_2，记得删除表格
select * from emp_2  

--12.连接查询
--内连接

--1.select ... from A,B
select * from emp,dept 

--2.select ... from A,B where ...
select * from  emp,dept where emp_id=1003   --输出的行数肯定是dept表的行数
select * from emp,dept where emp.dept_id=1  --输出的行数肯定是dept表的行数的倍数
select * from emp,dept where dept.dept_id=1 --输出的行数肯定是emp表的行数的倍数

--3.select ... from A join B on ...
select "E".ename "员工姓名","D".dname "部门名称" from emp"E" 
        join dept "D" --连接，原本emp有19行，每一行都会和dept的1-7行组合连接
        on "E".dept_id="D".dept_id --连接条件，加了连接条件之后，emp的每一行只会和部门编号一样的dept的哪一行连接
		
select * from emp join dept on emp.dept_id=dept.dept_id
select * from emp,dept where emp.dept_id=dept.dept_id
--输出结果一致
--where对连接之后的临时表进行过滤
select "E".ename,"D".dname,"E".sal from emp "E" 
        join dept "D"
		on "E".dept_id="D".dept_id
		where "E".sal>5000

--习题1：求出每个员工的姓名 部门编号 薪水 薪水等级
select "E".ename "姓名" ,"E".dept_id "部门编号" ,"E".sal "薪水" ,"S".grade "薪水等级" 
        from emp "E"
        join salgrade "S"
		on "E".sal>= "S".losal and "E".sal<= "S".hisal

--习题2：查找每个部门的编号 该部门所有员工的平均工资 平均工资的工资等级  
select dept_id as "部门编号",avg(emp.sal) as "部门平均工资",avg(salgrade.grade) as "工资等级"
       from emp
	   join salgrade
	   on emp.sal>=losal and emp.sal<=hisal
	   group by dept_id                                                  --自己写的

select dept_id as "部门编号","T"."部门平均工资",grade as "工资等级" 
from(      
       select dept_id ,avg(emp.sal) "部门平均工资"
       from emp 
	   group by dept_id
) "T"
	   join salgrade
	   on "T"."部门平均工资" between losal and hisal                     --另一种方法

--习题3：查找每个部门的编号 部门名称 该部门所有员工的平均工资 平均工资等级
select "T".dept_id as "部门编号","D".dname "部门名称","T"."部门平均工资","S".grade as "工资等级" 
from(
       select dept_id ,avg(sal) as "部门平均工资" 
       from emp
	   group by dept_id
) "T"
       join salgrade "S"
	   on "T"."部门平均工资" between losal and hisal
	   join dept "D"
	   on "T".dept_id="D".dept_id

--习题4：求出平均薪水最高的部门的编号和部门的平均薪水
select top 1 dept_id "部门编号",avg(sal) "平均工资"
       from emp
	   group by dept_id
	   order by "平均工资" desc

--习题5：把工资大于所有员工中工资最低的人中工资最低的前3人的姓名 工资 部门编号 部门名称 工资等级 输出
select top 3 ename "姓名",sal "工资",salgrade.grade "工资等级",emp.dept_id "部门编号",dept.dname "部门名称"
       from emp
	   join salgrade
	   on emp.sal between salgrade.losal and salgrade.hisal
	   join dept 
	   on emp.dept_id=dept.dept_id
	   where sal> (select min(sal) from emp)
	   order by sal 
	   
--13.嵌套查询
--14.视图
