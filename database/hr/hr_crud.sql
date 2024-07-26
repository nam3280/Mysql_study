-- 출력하는 개수를 제한하는 LIMIT
select last_name, employee_id, hire_date
from employees
order by hire_date desc limit 5;

select last_name, employee_id, hire_date
from employees
order by hire_date desc limit 1,6;

-- 테이블을 복제하는 서브쿼리 (select)
-- job_grades 테이블을 job_grades1으로 복제하고 job_grades 테이블과 동일한 제약조건을 생성하세요
create table job_grades1(select grade_level from job_grades);
desc job_grades1;
alter table job_grades1 add constraint pk_job_grades1 primary key(grade_level);

-- insert문 기본 : 테이블에 데이터를 삽입하는 명령어
-- insert [into] 테이블명[(열1,열2,...)] values(값1, 값2,...); -> [] : 생략 가능
-- 테이블 이름 다음에 나오는 열은 생략가능, 생략할 경우 values 다음에 오는 값들의 순서와 개수가 
-- 테이블이 정의된 열 순서와 개수가 동일해야한다.
create table testtbl(id int, username char(5), age int);
insert testtbl values(1,'김마리아',30);
insert testtbl(id, username) values(2,'김진영');
commit; -- commit을 안하면 다른 사람이 commit하기 전의 데이터를 볼 수 없다.
select * from testtbl;

insert testtbl(id, username) values(3,'박해란');
insert testtbl(id, username) values(4,'김해란');
insert testtbl(id, username) values(5,'고해란');
rollback;

select @@autocommit; -- @@autocommit값이 1이면 autocommit이 적용된 상태라는 뜻
set autocommit = 0;

-- 자동으로 증가하는 auto-increment (insert 할 때는 해당 열이 없다고 생각하고 입력하면 된다.)
-- 자동으로 1부터 증가하는 값을 입력해 준다.
-- PK, UNIQUE 제약조건을 지정해줘야 한다.
-- 데이터형은 숫자 형식만 사용가능하다.

create table testtbl2(id int auto_increment primary key, username char(5));
insert testtbl2(id, username) values(null,'김유진');
insert testtbl2(id, username) values(null,'박유진');
insert testtbl2(id, username) values(null,'서유진');
insert testtbl2(id, username) values(null,'고유진');
insert testtbl2(id, username) values(null,'방유진');
insert testtbl2(id, username) values(null,'유진');
select * from testtbl2;

-- auto increment를 이용하여 입력된 숫자가 어디까지 증가되었는지 궁금할 때\
select last_insert_id();

-- auto increment의 시작값 셋팅가능
alter table testtbl2 auto_increment = 1000;

-- 3씩 증가
set @@auto_increment_increment = 3;

-- 대량의 심플 데이터 생성 (입력)
-- 문법 : insert into 테이블 명(열1,열2,....) select문;
select count(employee_id) from employees;

create table testtbl3(id int, fname varchar(50), lname varchar(50));

insert into testtbl3 select employee_id, first_name, last_name from employees;

select count(id) from testtbl3;
alter table testtbl3 add constraint pk_testtbl3_id primary key(id);

create table testtbl5(select employee_id, last_name, first_name from employees);
select * from testtbl5;

alter table testtbl5 add constraint pk_testtbl5_id primary key(id);

-- 데이터 수정 (update) : 기존의 입력되어 있는 값을 변경하기 위해서 사용하는 명령어
-- [형식] : update 테이블 이름 set 열이름1 = 값1, 열이름2 = 값2... [where 조건];
-- where 절을 생략한다는 것은 테이블의 전체 행의 값의 변경이 이루어진다.
select * from testtbl5;
update testtbl5 set last_name = '손열음'; -- 안전모드 걸려있어서 실행 안됨

set sql_safe_updates = 0;

-- delete 데이터의 삭제 명령어 (적용단위 : 행) 행단위로 삭제
-- delede from 테이블명 where ...; -- where이 없으면 전체 데이터가 삭제된다.
delete from testtbl5 where employee_id = 110;
-- employees 테이블에서 employee_id, last_name, first_name 필드의 데이터를 조회하여 testtbl5dp 5번 insert
insert testtbl5 select employee_id, last_name, first_name from employees;
select count(*) from testtbl5;

delete from testtbl5 where last_name like 'Chen' limit 3;
select * from testtbl5 where last_name like 'Chen';