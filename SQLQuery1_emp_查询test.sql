--1.������
select * from emp;
select ename as "����" from emp;
select ename as "����",emp_sal*12 as "��н" from emp;

--2.distinct
select distinct dept_id from emp;

--3.between
--���ҹ�����1500��3000֮�䣺��1500��3000��
select * from emp
    where sal between 1500 and 3000
--���ҹ���<3000����>5000��
select * from emp
    where sal not between 3000 and 5000
--�ȼ���
select * from emp
    where sal<3000 or emp_sal>5000

--4.in
select * from emp
    where sal in (2000,3000,3500)
select * from emp where sal not in (2000,3000,3500)
--�ȼ���
select * from emp where sal<>2000 and sal<>3000 and sal<>3500

--5.top
select top 5 * from emp;
select top 11 percent * from emp;--���ǰ11%������ȡ������10��0.11=1.1����ȡ��Ϊ2

--6.order by
select * from emp order by sal;--Ĭ������
select * from emp order by dept_id,sal;--�Ȱ�dept_id����dept_id��ͬ���ٰ�sal����
select * from emp order by dept_id desc, sal;--�Ȱ�dept_id��������dept_id��ͬ���ٰ�sal��������
select * from emp order by dept_id, sal desc--�Ȱ�dept_id��������dept_id��ͬ���ٰ�sal��������
--desc����ֻ����ǰ��һ����Ч

--���������3000��5000�Ĺ�����ߵ�ǰ4��
select top 4 * from emp where sal between 1000 and 5000 order by sal desc

--7.null
select * from emp where comm is null;
select * from emp where comm is not null;
select ename, sal*12+comm "ʵ������/��" from emp;
--������֤����null������κ�������������null����ȷд��Ϊ��
select ename as "����", sal*12+isnull(comm,0) "ʵ������/��" from emp;--isnull�����ú�������˼�����comm��null���ᱻ�滻Ϊ0

--8.ģ����ѯ
select * from emp where ename like '%A%' --����A��������е���excel��vlookup��
select * from emp where ename like 'A%' --����ĸ��Aʱ���
select * from emp where ename like '%e' --β��ĸ��e�����
select * from emp where ename like '_a%' --�ڶ�����ĸ��aʱ���
select * from emp where ename like '%[a-j]%' --ֻҪ����abcdefghij�е���һ��ĸ�����
select * from emp where ename like '%[a,b]%' --ֻҪ����a or b �����
select * from emp where ename like '%[^a-p]%' --ֻҪ���в���abcdefghijklmnop�е���һ��ĸ����ĸ(rstuvwxyz)�����
select * from emp where ename like '_[^a,i,o]%' --���ڶ�����ĸ����aioʱ���

--9.�ۺϺ���
select lower(ename) from emp; --��д��Сд,���ǾۺϺ������ǵ��к���
select max(sal) from emp; --���ƵľۺϺ�������min(),avg()ƽ��ֵ
select count(*) from emp; --����emp�����м�¼�ĸ���
select count(dept_id) from emp; --�ظ���¼Ҳ������
select count(distinct dept_id) from emp; --�������ظ���¼
select count(comm) from emp; --NULL�������������ж���Ա���н���

--10.group by
select dept_id,avg(sal) as "����ƽ������" from emp 
       group by dept_id;
select dept_id,count(*) from emp group by dept_id; --��Ȼ���У�������
select dept_id,position,count(*) from emp group by dept_id,position;

--11.having ���ڶԷ��������ݽ��й���
select dept_id,avg(sal) as "����ƽ������" from emp 
       group by dept_id
	   having avg(sal) > 2000;

select dept_id,avg(sal) as "����ƽ������" from emp 
       group by dept_id
	   having count(*) > 2; --�Ѳ�������С��2�Ĳ��ŵĲ�����Ϣ�޳���

--where��ÿ�����������к�A��Ա��ȥ����group by�����ű�ŷ�����㲿��ƽ�����ʣ�having�ٰѲ���ƽ�����ʵ���2000��ȥ��
select dept_id,avg(sal) as "����ƽ������" from emp where ename not like '%a%'
       group by dept_id
	   having avg(sal) > 2000;  
	   
--����һ��֪ʶ�� into   �õò��࣬���ÿ����������ǰѲ�ѯ�����ݴ��뵽һ���µı���
select dept_id,avg(sal) as "����ƽ������" 
       into emp_2
       from emp
	   group by dept_id;
	   --ִ���˻��½�����emp_2���ǵ�ɾ�����
select * from emp_2  

--12.���Ӳ�ѯ
--������

--1.select ... from A,B
select * from emp,dept 

--2.select ... from A,B where ...
select * from  emp,dept where emp_id=1003   --����������϶���dept�������
select * from emp,dept where emp.dept_id=1  --����������϶���dept��������ı���
select * from emp,dept where dept.dept_id=1 --����������϶���emp��������ı���

--3.select ... from A join B on ...
select "E".ename "Ա������","D".dname "��������" from emp"E" 
        join dept "D" --���ӣ�ԭ��emp��19�У�ÿһ�ж����dept��1-7���������
        on "E".dept_id="D".dept_id --����������������������֮��emp��ÿһ��ֻ��Ͳ��ű��һ����dept����һ������
		
select * from emp join dept on emp.dept_id=dept.dept_id
select * from emp,dept where emp.dept_id=dept.dept_id
--������һ��
--where������֮�����ʱ����й���
select "E".ename,"D".dname,"E".sal from emp "E" 
        join dept "D"
		on "E".dept_id="D".dept_id
		where "E".sal>5000

--ϰ��1�����ÿ��Ա�������� ���ű�� нˮ нˮ�ȼ�
select "E".ename "����" ,"E".dept_id "���ű��" ,"E".sal "нˮ" ,"S".grade "нˮ�ȼ�" 
        from emp "E"
        join salgrade "S"
		on "E".sal>= "S".losal and "E".sal<= "S".hisal

--ϰ��2������ÿ�����ŵı�� �ò�������Ա����ƽ������ ƽ�����ʵĹ��ʵȼ�  
select dept_id as "���ű��",avg(emp.sal) as "����ƽ������",avg(salgrade.grade) as "���ʵȼ�"
       from emp
	   join salgrade
	   on emp.sal>=losal and emp.sal<=hisal
	   group by dept_id                                                  --�Լ�д��

select dept_id as "���ű��","T"."����ƽ������",grade as "���ʵȼ�" 
from(      
       select dept_id ,avg(emp.sal) "����ƽ������"
       from emp 
	   group by dept_id
) "T"
	   join salgrade
	   on "T"."����ƽ������" between losal and hisal                     --��һ�ַ���

--ϰ��3������ÿ�����ŵı�� �������� �ò�������Ա����ƽ������ ƽ�����ʵȼ�
select "T".dept_id as "���ű��","D".dname "��������","T"."����ƽ������","S".grade as "���ʵȼ�" 
from(
       select dept_id ,avg(sal) as "����ƽ������" 
       from emp
	   group by dept_id
) "T"
       join salgrade "S"
	   on "T"."����ƽ������" between losal and hisal
	   join dept "D"
	   on "T".dept_id="D".dept_id

--ϰ��4�����ƽ��нˮ��ߵĲ��ŵı�źͲ��ŵ�ƽ��нˮ
select top 1 dept_id "���ű��",avg(sal) "ƽ������"
       from emp
	   group by dept_id
	   order by "ƽ������" desc

--ϰ��5���ѹ��ʴ�������Ա���й�����͵����й�����͵�ǰ3�˵����� ���� ���ű�� �������� ���ʵȼ� ���
select top 3 ename "����",sal "����",salgrade.grade "���ʵȼ�",emp.dept_id "���ű��",dept.dname "��������"
       from emp
	   join salgrade
	   on emp.sal between salgrade.losal and salgrade.hisal
	   join dept 
	   on emp.dept_id=dept.dept_id
	   where sal> (select min(sal) from emp)
	   order by sal 
	   
--13.Ƕ�ײ�ѯ
--14.��ͼ
