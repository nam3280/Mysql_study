-- 1. 데이터 검색(select) : 테이블에 저장된 데이터를 추출하는 명령어
-- 표시하고자 하는 열(column)만 선택하여 출력할 수 있다.(선택 범위 지정 가능)

-- 사원정보에서 사원번호, 이름, 급여, 입사일, 상사의 사원번호를 출력하세요
-- (이름은 성과 이름을 연결하여 Name 이라는 별칭으로 출력)
select employee_id, 
	concat(first_name,'',last_name) as "Name", 
    salary,
    hire_date,
    manager_id
from employees;
    
-- 사원정보에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary, 
-- 연봉에 100 보너스를 추가하여 계산한 값을 Increased_Saraly로 출력
select concat(first_name,'',last_name) as "Name", 
	job_id as "Job",
    salary as "Salary",
    (salary + 100) * 12 as "Increased_Salary"
from employees;

-- 부서별로 담당하는 업무를 출력하시오.
select department_id, job_id from employees;

-- 부서별로 담당하는 업무를 한번씩만 출력하시오.
select distinct department_id, job_id from employees;

-- 사원정보테이블에서 모든 사원의 이름(last_Name)과 연봉을 "이름 : 1 Year Salary = $연봉"형식으로 출력하고,
--  1 Year Salary라는 별칭으로 출력
select concat(last_name,': 1 Year Salary = $',salary ) as "1 Year Salary" from employees;

-- hr 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다.
-- 사원 정보에서 급여가 $7000 ~ $10000 범위 이외의 사람의 성과 이름(Name 별칭), 급여가 작은 순으로 출력
select concat(first_name,' ',last_name) as "Name", salary
from employees
where salary not between 7000 and 10000
order by salary asc; -- asc 생략 가능

select e1.last_name, e2.last_name
from employees e1, employees e2
where e1.employee_id = e2.manager_id and e2.last_name = 'Higgins';

-- 하나의 스키마에서 여러 테이블이 존재하고 정보를 저장하고 있다.
-- 테이블간의 관계를 기반으로 수행되는 연산
-- join sql:1999 문법 이전과 이후 구분
-- join 종류는 등가조인(equi join) -> 오라클 : natural / inner join
-- outer join(외부 조인, 포괄 조인) -> left outer join, right outer join
-- self join(자체 조인)
-- 비등가 조인
-- 카티시안 곱 -> cross join

-- 조인 조건에서 '='을 사용하는 조인을 등가조인, equi, inner, natural join 이라고 한다.
select emp.employee_id 사원번호, 
	emp.first_name 이름, 
    emp.department_id 부서번호, 
	dept.department_id 부서번호, 
    dept.department_name 부서이름
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- 지역코드(location_id)가 1700인 사원의 이름과 지역번호, 부서번호, 부서이름을 조회하세요
select e.last_name, d.location_id, l.city
from departments d, locations l, employees e
where d.location_id = l.location_id and 
	e.department_id = d.department_id and
    l.location_id = 1700;
    
-- self join
select * from employees;

-- 각 사원을 관리하는 상사의 이름을 조회하세요. (위계성 데이터 셀프 조인)
select e1.employee_id 사원번호, 
	concat(e1.first_name,' ', e1.last_name) 사원이름,
    e1.manager_id 상사번호,
    e2.employee_id "상사의 사원번호",
    e2.first_name 상사이름
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

select e1.employee_id 사원번호, 
	concat(e1.first_name,' ', e1.last_name) 사원이름,
    e1.manager_id 상사번호,
    e2.employee_id "상사의 사원번호",
    e2.first_name 상사이름
from employees e1 inner join employees as e2 on e1.manager_id = e2.employee_id;

-- left outer join
select dept.department_id 부서번호, dept.department_name 부서명, emp.first_name 사원명
from departments dept, employees emp
where dept.department_id = emp.department_id;

-- a join b : a에 b의 데이터를 모두 넣는다.
-- a left join b on(조건) : a와 b의 조건에 맞는 값만 a에 들어가고 나머지 값들은 모두 null값으로 들어간다.