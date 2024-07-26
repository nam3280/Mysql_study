-- [문제 1] HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. Tucker(last_name) 사원보다
-- 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
-- 1. Tucker의 급여
select last_name, salary
from employees
where last_name = 'Tucker' or last_name = 'tucker';
-- 2.
select e.last_name, e.salary
from employees e
where e.salary > (
	select e2.salary
	from employees e2
	where e2.last_name = 'Tucker'
);

-- [문제 2] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무,
-- 급여, 입사일을 출력하시오
-- 1. 업무별 최소 급여
select distinct job_id, min(salary)
from employees
group by job_id
order by job_id;
-- 2.
select e1.last_name, e1.job_id, e1.hire_date, e1.salary
from employees e1
join (
	select job_id, MIN(salary) 
    as min_salary 
    from employees 
    group by job_id) e2 on e1.job_id = e2.job_id and e1.salary = e2.min_salary
order by e1.job_id;

-- [문제 3] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭),
-- 급여, 부서번호, 업무를 출력하시오
select concat(e.first_name, ' ', e.last_name) Name, e.salary 급여, e.department_id 부서번호, e.job_id 업무
from employees e
where e.salary > any(
	select avg(e2.salary)
	from employees e2
    group by department_id
)
order by department_id;

-- [문제 4] 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 'O' 로 시작하는 지역에 살고
-- 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오
-- O지역 search
select *
from locations
where city like 'O%';
select distinct concat(e.first_name, ' ', e.last_name) 이름, e.job_id 업무, e.hire_date 입사일
from employees e, departments dept, locations loc
where e.department_id = (
	select d2.department_id
    from departments d2
	where d2.location_id = (
		select l2.location_id
		from locations l2
		where l2.city like 'O%'
    )
) 
order by e.job_id;

-- [문제 5] 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭), 업무, 급여, 부
-- 서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오 /keep
select
	concat(emp.first_name, ' ', emp.last_name) as 이름,
    jobs.job_title as 업무,
    emp.salary as 급여,
    emp.department_id as 부서번호,
    avg_sal.평균연봉 as '부서 평균연봉'
from -- 조회 해야 할 세 테이블과 서브쿼리로 조회한 테이블까지 같이 조인
	employees emp,
    departments dept,
    jobs,
	(
		select
			dept.department_id 사번,
            avg(salary) 평균연봉
		from
			employees emp,
			departments dept
		where
			emp.department_id = dept.department_id
		group by
			emp.department_id
	) avg_sal -- 모든 사원의 소속부서 평균연봉을 계산
where
	emp.department_id = dept.department_id
    and emp.job_id = jobs.job_id
    and dept.department_id = avg_sal.사번;

-- [문제 6] 'Kochhar'의 급여/보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오.
select
	e.employee_id 사번,
    concat(first_name, ' ', last_name) 이름,
    jobs.job_title 담당업무,
    e.salary 급여
from
	employees e,
    jobs
where
	e.job_id = jobs.job_id
    and e.salary > (
		select
			salary
		from
			employees
		where
			concat(first_name, ' ', last_name)
            like '%Kochhar%'
);
    
-- [문제 7] 급여의 평균/보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오
select
	emp.employee_id 사번,
    concat(emp.first_name, ' ', emp.last_name) 이름,
    jobs.job_title 담당업무,
    emp.salary 급여,
    emp.department_id
from
	employees emp,
    departments dept,
    jobs
where
	emp.department_id = dept.department_id
	and emp.job_id = jobs.job_id
	and emp.salary < (
		select
			avg(salary)
		from
			employees
	);
-- [문제 8] 100번 부서의 최소 급여/보다 최소 급여가 많은 다른 모든 부서를 출력하시오
select distinct d.department_name
from employees e, departments d
where e.department_id = d.department_id
group by e.department_id
having min(e.salary) > (
	select min(emp.salary)
    from employees emp, departments dept
	where emp.department_id = dept.department_id and emp.department_id = 100
);

-- 9. 업무별로 최소 급여를 받는 사원의 사원번호, 이름, 업무, 부서번호 조회 (정렬: 업무별)
-- 사원번호, 이름, 부서번호: employees / 업무: jobs
SELECT employee_id, CONCAT(first_name, ' ', last_name) Name, j.job_id, department_id
FROM employees e
	JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_id
HAVING MIN(salary)
ORDER BY j.job_id;

-- 10. 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서 조회
-- 1) 100번 부서의 최소 급여 확인
SELECT MIN(salary)
FROM employees
WHERE department_id = 100;

-- 2) 1)번의 결과를 바탕으로 최소 급여가 많은 다른 모든 부서 조회
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 100);

-- 11. 업무가 SA_MAN 사원의 이름, 업무, 부서명, 근무지 조회
SELECT CONCAT(first_name, ' ', last_name) Name, job_id, department_name, street_address
FROM employees e
	JOIN departments d ON e.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
WHERE job_id = ANY(
	SELECT 'SA_MAN'
    FROM jobs);
    
-- [문제 9]
-- 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오.
-- 출력시 업무별로 정렬하시오
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.department_id
FROM employees e
         JOIN (SELECT MIN(salary) salary
                    , job_id
               FROM employees
               GROUP BY job_id) AS ms ON e.salary = ms.salary AND e.job_id = ms.job_id;


-- [문제 10]
-- 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오
SELECT DISTINCT d.department_name, d.department_id
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
HAVING MIN(e.salary) > ANY (SELECT MIN(salary) salary
                            FROM employees
                            WHERE department_id = 100);


-- [문제 11]
-- 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , d.department_name
     , l.city
FROM (SELECT first_name, last_name, job_id, department_id
      FROM employees
      WHERE job_id = 'SA_MAN') e,
     (SELECT department_id, department_name, location_id
      FROM departments) d,
     (SELECT location_id, city
      FROM locations) l
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id;

-- [문제 12]
-- 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
FROM employees e
WHERE e.employee_id = (SELECT manager_id
                       FROM employees e
                       GROUP BY manager_id
                       ORDER BY COUNT(manager_id) DESC
                       LIMIT 1);

-- [문제 13] 사원번호가 123인 사원과 업무가 같고 사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 사원번호,이름,직업,급여를 출력하시오
-- 1) 사원번호가 123인 사원의 업무(job_id)
SELECT job_id
FROM employees
WHERE employee_id = 123; -- ST_MAN
-- 2) 사원번호가 192인 사원의 급여(salary)
SELECT salary
FROM employees
WHERE employee_id = 192; -- 4000.00
-- 3) 사원의 사원번호,이름,직업,급여를 출력하시오
-- where 조건: 1)과 업무가 같고 AND 2)보다 많은 급여를 받는
SELECT e.employee_id 사원번호, concat(e.first_name, ' ', e.last_name) 이름, j.job_title 직업, e.salary 급여
FROM employees e JOIN jobs j
ON e.job_id = j.job_id
WHERE e.job_id = (
     SELECT job_id
     FROM employees
     WHERE employee_id = 123
 ) AND e.salary > (
     SELECT salary
     FROM employees
     WHERE employee_id = 192
);

-- [문제 14] 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.
-- 1) 50번 부서에서 최소 급여 (MIN())
SELECT MIN(salary)
FROM employees
WHERE department_id = 50; -- 2100.00
-- 2) 사원의 사원번호,이름,업무,입사일자,급여,부서번호를 출력
-- where 조건: 1)보다 많은 급여를 받는 AND 50번 부서의 사원은 제외
SELECT e.employee_id 사원번호, concat(e.first_name, ' ', e.last_name) 이름, j.job_title 업무, e.hire_date 입사일자, e.salary 급여, e.department_id 부서번호
FROM employees e JOIN jobs j
ON e.job_id = j.job_id
WHERE e.salary > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 50
) AND e.department_id <> 50
ORDER BY e.salary;

-- [문제 15] 50번 부서의 최고 급여를 받는 사원 보다 많은 급여를 받는 사원의 사원번호,이름,업무,입사일자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.
-- 1) 50번 부서의 최고 급여 (MAX())
SELECT MAX(salary)
FROM employees
WHERE department_id = 50; -- 8200.00
-- 2) 사원의 사원번호,이름,업무,입사일자,급여,부서번호를 출력
-- where 조건: 1)보다 많은 급여를 받는 AND 50번 부서의 사원은 제외
SELECT e.employee_id 사원번호, concat(e.first_name, ' ', e.last_name) 이름, j.job_title 업무, e.hire_date 입사일자, e.salary 급여, e.department_id 부서번호
FROM employees e JOIN jobs j
ON e.job_id = j.job_id
WHERE e.salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = 50
) AND e.department_id <> 50
ORDER BY e.salary;