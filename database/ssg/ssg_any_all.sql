-- 1. 1970년 이후에 출생하고 키가 182 이상인 회원의 아이디와 이름을 조회하세요.
select userid, name
from usertbl
where birthYear >= 1970 and height >= 182;

-- 2. 키가 180에서 183사이의 회원의 정보를 조회하세요. 
select name, height
from usertbl
where height between 180 and 183;

-- 3. 지역이 경남, 전남, 경북에서 거주하는 회원의 이름을 조회하세요.
select name, addr
from usertbl
where addr in('경남','전남','경북'); -- 연속적인 값이 아닌 이산적인 값을 위해 in연산자를 사용한다.

-- 회원중 김씨인 회원의 정보를 조회하시오.
select *
from usertbl
where name like "김%";

-- ANY / ALL / SOME

-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 조회하세요.
select name, height from usertbl where height > 177;

select name, height from usertbl where height > (
	select height
    from usertbl
    where name = '김경호'
);

-- 지역이 경남인 회원들보다 키가 크거나 같은 회원의 이름 출력
-- (ANY = SOME) -> 키가 173 또는 170보다 크거나같은 회원의 정보 출력
select height from usertbl where addr = '경남';
select name, height from usertbl where height >= any (
	select height
    from usertbl
    where addr = '경남'
);

-- =를 사용하면 in과 같다.
select name, height from usertbl where height = any (
	select height
    from usertbl
    where addr = '경남'
);

-- (ALL) -> 키가 173보다 크거나같은 회원의 정보 출력
select name, height from usertbl where height >= all (
	select height
    from usertbl
    where addr = '경남'
);

-- 서브쿼리는 테이블을 복사할 때 많이 활용된다.(제약조건(key) 복사가 안되므로 alter 작업을 해야 한다.)
create table usertbl2 (select * from usertbl);

alter table usertbl2 add constraint pk_usertbl2 primary key (userid);