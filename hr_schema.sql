-- create를 적어 놓고 외래키는 나중에 설정한다.
-- employees : 사원 테이블
create table employees(
	employee_id int unsigned not null,	-- 사원번호, unsigned(양수)
    first_name varchar(20),				-- 성
    last_name varchar(30) not null,		-- 이름
    email varchar(25) not null,			-- 이메일
    phone_number varchar(20),			-- 전화번호
    hire_date date not null,			-- 입사일
    job_id varchar(10) not null,		-- 직무번호
    salary decimal(8,2) not null,		-- 월급, decimal(8,2) 소수 두번째 까지 받는다.
    commission_pct decimal(2,2),		-- 수당
    manager_id int unsigned,
    department_id integer unsigned,		-- 부서아이디
    primary key (employee_id)
);

-- Regions : 지역 테이블 (1순위)
create table regions(
	region_id int unsigned not null,
    region_name varchar(25),
    primary key (region_id)
);

-- countries : 나라 테이블 (2순위)
create table countries(
	country_id char(2) not null,
    country_name varchar(40),
    region_id int unsigned not null,
    primary key (country_id)
);

-- locations: 위치 테이블 (3순위)
create table locations(
	location_id int unsigned not null auto_increment,
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(30),
    country_id char(2) not null,
    primary key (location_id)
);

-- departments: 부서 테이블 (4순위)
create table departments(
	department_id int unsigned not null,
    department_name varchar(30)not null,
    manager_id int unsigned,
    location_id int unsigned,
    primary key (department_id)
);

-- jobs: 직업 테이블 (5순위)
create table jobs(
	job_id varchar(20) not null,
    job_title varchar(40) not null,
    min_salary decimal(8,0) unsigned,
    max_salary decimal(8,0) unsigned,
    primary key (job_id)
);

-- job_history: 직업_이력 테이블 (6순위)
create table job_history(
	employee_id int unsigned not null,
	start_date date not null,
    end_date date not null,
    job_id varchar(20) not null,
    department_id int unsigned not null
);

alter table job_history add unique index(
	employee_id, start_date
);

-- 외래키(fk) 추가 작업 alter 명령어
alter table countries add foreign key (region_id) references regions(region_id);
alter table locations add foreign key (country_id) references countries(country_id);
alter table departments add foreign key (location_id) references locations(location_id);

alter table employees add foreign key (department_id) references departments(department_id);
alter table departments add foreign key (manager_id) references employees(employee_id);
alter table employees add foreign key (job_id) references jobs(job_id);
alter table employees add foreign key (manager_id) references employees(employee_id);

alter table job_history add foreign key (employee_id) references employees(employee_id);
alter table job_history add foreign key (job_id) references jobs(job_id);
alter table job_history add foreign key (department_id) references departments(department_id);