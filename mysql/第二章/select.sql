# select

# SQL分类
/*
    DDL:数据定义语言 CREATE/ALTER/DROP/RENAME/TRUNCATE
    DML:数据操作语言 INSERT/DELETE/UPDATE/SELECT
    DCL:数据控制语言 COMMIT/ROLLBACK/SAVEPOINT/GRANT/REVOKE
*/
use test;

create table if not exists emp(
    id int  primary key,
    names varchar(50) not null,
    email varchar(100) not null
);
select * from emp;
DESCRIBE emp;
select * from emp where names='Tom';
/*show create table emp;*/

/*insert into emp values(1,'Tom','1@qq.com');
 insert into emp values(2,'Jerry','2@qq.com');*/
