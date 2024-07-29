-- [문제 1] HR 부서의 어떤  사원은 급여정보를  조회하는 업무를 맡고  있다. 
-- Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
select concat(first_name,' ',last_name) Name, job_id, salary
from employees
where salary > (
	select e2.salary
    from employees e2
    where e2.last_name like 'Tucker'
);

-- [문제 2]  사원의 급여  정보  중 업무별  최소  급여를 받고  있는  사원의 성과  이름(Name으로 별칭), 업무, 
-- 급여, 입사일을 출력하시오
select concat(first_name,' ',last_name) Name, e1.job_id, salary, hire_date
from employees e1 right outer join(
	select job_id, min(e2.salary) min_salary
    from employees e2
    group by job_id
) e 
on e1.salary = e.min_salary and e.job_id = e1.job_id
order by e1.job_id;
    
-- [문제 3] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 
-- 급여, 부서번호, 업무를 출력하시오
select concat(e1.first_name,' ',e1.last_name) Name, e1.salary, e1.department_id, e1.job_id, e.avg_salary
from employees e1 inner join (
	select e2.department_id, avg(salary) avg_salary
	from employees e2
    group by e2.department_id
) e
on e.avg_salary < e1.salary and e1.department_id = e.department_id
ORDER BY e1.department_id;
    
-- [문제 4] 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 'O' 로 시작하는 지역에 살고 
-- 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오
select e.employee_id, concat(e.first_name,' ',e.last_name) Name, e.job_id, e.hire_date
from employees e 
inner join departments d
on e.department_id = d.department_id and (
select l.location_id
from locations l
where d.location_id = l.location_id and l.city like 'O%'
);

-- [문제 5] 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부
-- 서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오
select concat(e.first_name, ' ', e.last_name) Name, e.job_id, e.salary, e.department_id, ee.avg_salary 'Department Avg Salary'
from employees e left outer join (
    select e2.department_id, avg(e2.salary) avg_salary
    from employees e2
    group by e2.department_id
) ee
on ee.department_id = e.department_id;

-- [문제 6] ‘Kochhar’의 급여보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오.
select e.employee_id, concat(e.first_name, ' ', e.last_name) Name, e.job_id, j.job_title, e.salary
from employees e Inner join (
select salary
from employees
where last_name like 'Kochhar') ee
on ee.salary < e.salary, jobs j
where e.job_id = j.job_id;

-- [문제 7] 급여의 평균보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오
 select e.employee_id, concat(e.first_name, ' ', e.last_name) Name, e.job_id, e.salary, e.department_id
 from employees e inner join (
	select avg(salary) avg_salary
	from employees
 ) ee on e.salary < ee.avg_salary
 order by e.salary;

-- [문제 8] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오
 select d.department_name
 from employees e, departments d
 where e.department_id = d.department_id
 group by d.department_id
 having min(salary) > (
	select min(e.salary)
    from employees e
    where e.department_id = 100
 );
 
-- [문제 9] 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오, 출력시 업무별로 정렬하시오
select e.employee_id, concat(e.first_name, ' ', e.last_name) Name, e.job_id, e.department_id, e.salary
from employees e inner join (
	select job_id, min(salary) min_salary
    from employees
    group by job_id
) ee on ee.min_salary = e.salary and e.job_id = ee.job_id;

-- [문제 10]
-- 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오
select department_name
from employees e, departments d
where e.department_id = d.department_id
group by e.department_id
having min(e.salary) > (
	select min(e1.salary)
    from employees e1
    where e1.department_id = 100
);

-- [문제 11]
-- 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.
select concat(e.first_name, ' ', e.last_name) Name, e.job_id, d.department_name, l.street_address
from employees e 
inner join (
	select job_id
    from jobs
    where job_id like 'SA_MAN'
) j on e.job_id = j.job_id
inner join departments d on d.department_id = e.department_id
inner join locations l on d.location_id = l.location_id;

-- [문제 12]
-- 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오
select distinct e.manager_id, concat(m.first_name, ' ', m.last_name) Name
from employees e 
inner join (
	select manager_id, count(manager_id) count
    from employees 
    group by manager_id
    ORDER BY count DESC
	LIMIT 1
)em on e.manager_id = em.manager_id
inner join employees m on e.manager_id = m.employee_id;

-- [문제 13] 사원번호가 123인 사원과 업무가 같고 사원번호가 192인 사원의 급여(SAL))보다 많은 
-- 사원의 사원번호,이름,직업,급여를 출력하시오
select e.employee_id, concat(e.first_name, ' ', e.last_name) Name, e.job_id, e.salary
from employees e 
inner join (
	select employee_id, job_id
	from employees	
) a on a.employee_id = 123 and e.job_id = a.job_id
inner join (
	select salary
    from employees	
    where employee_id = 192 
) aa on aa.salary < e.salary;

-- [문제 14] 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는 사원의 
-- 사원번호,이름,업무,입사일자,급여,부서번호를 출력하시오. 
-- 단 50번 부서의 사원은 제외합니다.
select e.employee_id, concat(e.first_name, ' ', e.last_name) Name, e.job_id, e.hire_date, e.salary, e.department_id
from employees e inner join (
	select min(e1.salary) min_salary
    from employees e1
    where e1.department_id = 50
)a on a.min_salary < e.salary and not e.department_id = 50
order by e.salary;


-- [문제 15] 50번 부서의 최고 급여를 받는 사원 보다 많은 급여를 받는 사원의 
-- 사원번호,이름,업무,입사일자,급여,부서번호를 출력하시오. 
-- 단 50번 부서의 사원은 제외합니다.
select e.employee_id, concat(e.first_name, ' ', e.last_name) Name, e.job_id, e.hire_date, e.salary, e.department_id
from employees e inner join (
	select max(e1.salary) max_salary
    from employees e1
    where e1.department_id = 50
)a on a.max_salary < e.salary and not e.department_id = 50
order by e.salary;
