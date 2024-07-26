-- 1. 모든 사원의 이름, 부서번호, 부서이름을 조회하세요.
select first_name, last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- 2. 부서번호 80에 속하는 모든 업무의 고유 목록을 작성하고 출력 결과에 부서위치 출력
select distinct job_title, concat(country_id,' ',city,' ',street_address)
from employees e, departments d, locations l, jobs j
where d.department_id = 80 and e.department_id = d.department_id 
	and e.job_id = j.job_id and l.location_id = d.location_id;

-- 3. 커미션을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요
select concat(first_name,' ',last_name) Name, department_name, l.location_id, city
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id and 
	e.commission_pct is not null;

-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요
select first_name, last_name, department_name
from employees e, departments d
where d.department_id = e.department_id and first_name like "%a%" or last_name like "%a%";

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서번호와 부서명 조회
select first_name, last_name, job_title , d.department_id, department_name
from employees e, departments d, locations l, jobs j
where e.department_id = d.department_id and l.location_id = d.location_id and e.job_id = j.job_id and l.city = "Toronto";

-- 6. 사원의 이름과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 각각의 컬럼명을 
-- Employee, Emp#, Manager, Mgr#으로 지정하세요
select e1.first_name Employee, e1.employee_id 'Emp#', e2.first_name Manager, e2.employee_id 'Mgr#'
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
select last_name Employee, manager_id
from employees
where manager_id is null;

-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요
select concat(e1.first_name,' ',e1.last_name) Name, e1.department_id
from employees e1, employees e2
where e1.department_id = e2.department_id and e2.employee_id = 100;

-- 9. JOB_GRADRES 테이블을 생성하고 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
select concat(first_name,' ',last_name) Name, job_title, department_name, hire_date, salary, grade_level
from employees e left outer join job_grades on salary BETWEEN lowest_sal and highest_sal, 
	departments d, jobs j
where e.department_id = d.department_id and j.job_id = e.job_id
order by grade_level;