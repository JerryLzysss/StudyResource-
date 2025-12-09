# select

select 标识列,从哪个字段查询
from 从哪个表中选择
操作:
select 1,select 3*2;没有意义,相当于select from dual;从伪表查询.
select * from employee从表中所有字段,*标识所有的意思.
select emp1,emp2,emp3 from employee从表中查询emp1,emp2,emp3的字段.

## 别名
as 全称,alias相当于其他名字的意思
``select emp1 e1,emp2 as e2,emp3 e3 from employee.``此处emp1的字段名字为e1,emp2的字段名字为e2,emp3的字段名字为e3.
``select emp1*12 as "e1".``此处需要用双引号表示为将emp1*12划分为e1.

## 去重
`select DISTINCT id from employee.`此处DISTINCT表示关键字意为去除重复

## 空值参与计算
空值:null
null也就是不存在值得意思，不等同于0
`select salary*(1+IFNULL(sl,0))*12 from employee`通过IFNULL单行函数来将空值加入运算之中.

## 着重号
有的表名字属于关键字,可以通过\`来完成查询.
## 查询常数
select '123' from employee
## 显示表结构
DESCRIBE employee 显示表中字段的详细信息
## 过滤数据
select ... from ... where 条件
