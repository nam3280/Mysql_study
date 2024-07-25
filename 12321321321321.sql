-- 1. HR 부서의 어떤  사원은 급여정보를  조회하는 업무를 맡고  있다. 
-- Tucker(last_name) 사원보다  급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
select concat(e1.first_name,' ',e1.last_name) Name, e1.job_id, e1.salary
from employees e1
where salary > (
	select e2.salary
    from employees e2
    where e2.last_name like 'Tucker'
);


-- 2. 사원의 급여 정보 중 업무별 최소 급여를 받고 있는  
-- 사원의 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오.
select concat(e1.first_name,' ',e1.last_name) Name, e1.job_id, e1.salary, e1.hire_date
from employees e1
where e1.salary = (
	select min(e2.salary) 
    from employees e2
    where e1.job_id = e2.job_id
);

-- 3. 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 
-- 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
select concat(e1.first_name,' ',e1.last_name) Name, e1.salary, e1.department_id ,e1.job_id
from employees e1
where salary > (
	select avg(e2.salary)
    from employees e2
    where e1.department_id = e2.department_id
);

-- 4. 사원들의 지역별 근무 현황을 조회하고자 한다. 
-- 도시 이름이 영문 'O' 로 시작하는 지역에 살고 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오
select employee_id, concat(first_name,' ',last_name) Name, job_id, hire_date, l1.city
from employees left outer join locations l1
on l1.city = (
	select city
    from locations l2
    where l2.city like "O%"
);

-- 5. 모든 사원의 소속부서 평균연봉을 계산하여  
-- 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오
select concat(e1.first_name,' ',e1.last_name) Name, e1.job_id, e1.salary, e1.department_id, avg(e1.salary) 'Department Avg Salary'
from employees e1
where e1.employee_id = (
	select e2.employee_id
    from employees e2
    where e1.department_id = e2.department_id
);

select avg(salary * 12)
from employees
group by department_id;