use bookstore;
-- 부속질의(Subquery) - 서브쿼리 - nested query (중첩쿼리)
-- 실행순서 : where 절의 부속질의 -> 전체 질의 
-- 가장 비싼 도서명을 조회하세요
select max(price)
from book;

select bookname
from book
where price = (
select max(price)
from book
);
-- 서브쿼리는 sql문이므로 테이블로 결과를 반환, 
-- 단일행 = 단일열(1 X 1), 다중행 - 단일열(N X 1), 단일행 - 다중열(1 X N), 다중행 - 다중열(N X N)

-- 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
select name
from customer
where custid in(select custid from orders);

select custid
from orders
order by custid; -- {1,2,3,4} 고객번호를 이용해서 customer 테이블에서 고객의 이름을 찾는다. n*1

-- 대한미디어 출판사에서 출판한 도서를 구매한 고객의 이름을 구하세요.
select *
from book
where publisher = '대한미디어';

select *
from orders
where custid = 1; -- 책을 구매한 custid = {1,2,3,4}

select name from customer where custid in(
	select custid from orders where bookid in(
		select bookid from book where publisher = '대한미디어')); -- {3,4} -- 하위 부속질의

-- 서브쿼리는 하위 부속질의와 상관 부속질의어 두 가지가 있다.
-- 상위 부속질의의 튜플을 이용하여 하위 부속질의를 계산한다.

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서의 이름을 조회하세요.(서브쿼리로 작성하세요)
-- 평균가보다 도서 가격이 비싼지 비교한 쿼리이다.  b1,b2 -> 튜플 변수
select publisher, avg(price)
from book
group by publisher;

select bookname 
from book b1 
where b1.price > (
	select avg(b2.price)
    from book b2 
    where b1.publisher = b2.publisher
);

select bookname ,bookId
from book b1 
where price > ALL (select avg(price) from book group by publisher)
group by publisher;

select avg(price), bookid, publisher from book group by publisher;

-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
-- 1. 도서의 판매액 평균값을 구한다. 
-- select avg(o1.saleprice) from orders o1
-- 2. 평균값보다 초과인 구매 고객별 평균을 구하여 비교한다 
-- select avg(o2.saleprice) from orders o2 where c1.custid = o2.custid
-- 3. 해당 고객의 이름을 출력한다.
select name 
from customer c1
where (select avg(o2.saleprice) from orders o2 where c1.custid = o2.custid ) > (
    select avg(o1.saleprice) 
    from orders o1
);

-- buytbl 테이블을 참고하여 사용자가 구매한 물품의 개수를 조회하시오
select userid, sum(amount)
from buytbl
group by userID;

-- buytbl 테이블을 참고하여 사용자가 구매한 구매액의 총합을 구하세요.
select userid, sum(price * amount)
from buytbl
group by userID;

-- 휴대폰이 있는 사용자의 수를 출력하세요
select count(mobile1) from usertbl;

-- 회원중 총 구매액이 1000이상인 회원 정보 조회
select userid, sum(price * amount)
from buytbl
group by userid
having sum(price * amount) > 1000;

-- 총합 중간 합계가 필요한 경우가 있다. group by 절과 with rollup 문을 사용한다.
-- 분류 별로
select * from buytbl;

select groupname, sum(price * amount)
from buytbl
group by groupName
with rollup;