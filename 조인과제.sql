-- [문제  0]  hr  스키마에  존재하는  Employees,  Departments,  Locations  테이블의    구조를  파악한  후 
-- Oxford에  근무하는  사원의  성과  이름(Name으로  별칭),  업무,  부서명,  도시명을  출력하시오.  
-- 이때  첫  번째 열은  회사명인  ‘Han-Bit’이라는  상수값이  출력되도록  하시오.
select 'Han-Bit' 회사명, concat(first_name, ' ', last_name) Name, job_id, department_name ,city
from employees e, departments d, locations l
where e.department_id = d.department_id and
	d.location_id = l.location_id and
    l.city like 'Oxford';
    

-- [문제 1]
-- HR 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후
-- 사원수가 5명 이상인 부서의 부서명과 사원수를 출력하시오.
-- 이때 사원수가 많은 순으로 정렬하시오.
select e.department_id, d.department_name, count(*)
from employees e join departments d on e.department_id = d.department_id
group by department_id
having count(*) >= 5
order by count(*) desc;

-- [문제 2]
-- 각 사원의 급여에 따른 급여 등급을 보고하려고 한다.
-- 급여 등급은 JOB_GRADES 테이블에 표시 된다.
-- 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무,
-- 부서명, 입사일, 급여, 급여등급을 출력하시오.
select concat(first_name, ' ', last_name) Name, job_id, department_name, hire_date, salary, grade_level
from employees e 
left outer join departments d on e.department_id = d.department_id
left outer join job_grades on salary between lowest_sal and highest_sal
order by salary;

  
-- [문제 3]
-- 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.
-- ex> 홍길동은 허균에게 보고한다 → Eleni Zlotkey report to Steven King
-- 어떤 사원이 어떤 사원에서 보고하는지를 위 예를 참고하여 출력하시오.
-- 단, 보고할 상사가 없는 사원이 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오.
select ifnull(concat(e1.first_name,' ', e1.last_name, '은 ', e2.first_name,' ', e2.last_name,'에게 보고한다.'), 
				concat(e1.first_name,' ', e1.last_name, '은 보고할 사람이 없다.')) report
from employees e1 left outer join employees e2 on e1.manager_id = e2.employee_id;
