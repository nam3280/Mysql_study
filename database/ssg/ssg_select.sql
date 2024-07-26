use bookstore;

select phone from customer where name = "김연아";

-- 도서 테이블에 있는 모든 출판사를 출력하세요.
select distinct publisher from book order by publisher;

-- 가격이 2만원 미만인 도서를 검색하세요.
select * from book where price < 20000;

-- 가격이 만원 이상 2만원 이하인 도서를 검색하세요.
select * from book where price >= 10000 and price <=20000;
select * from book where price between 10000 and 20000;

-- 책 정보에서 가격이 10000원 이상인 도서의 이름과 출판사를 출력하세요.
select bookname, publisher, price from book
where price >= 10000
order by price;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하세요.
select * from book where publisher in('굿스포츠','대한미디어');

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하세요.
select * from book where publisher not in('굿스포츠','대한미디어');

-- '축구의 역사'를 출간한 출판사를 검색하세요.
select bookname, publisher from book where bookname like '축구의 역사';

-- 와일드 문자 : %, [], [^], _
-- 1. %
select bookname, publisher from book where bookname like '%축구%'; -- '축구'가 들어가는 모든 데이터 출력
select bookname, publisher from book where bookname like '%축구'; -- '축구'로 끝나는 모든 데이터 출력
select bookname, publisher from book where bookname like '축구%'; -- '축구'로 시작하는 모든 데이터 출력
-- 2. [] 
-- (1) [0-5] : 0 ~ 5 사이의 숫자로 시작하는 문자열
-- (2) [^0-5] : 0 ~ 5 사이의 숫자로 시작하지 않는 문자열

-- 3. _ : 특정 위치에 있는 1개의 문자와 일치
select bookname, publisher from book where bookname like '_구%'; -- '축구'로 시작하는 모든 데이터 출력

-- 도서 이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서를 검색하세요.
select * from book where bookname like '_구%';

-- 도서를 이름순으로 검색
select * from book order by bookname asc;

-- 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하세요.
select * from book order by price, bookname;

-- 도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차순으로 검색하세요.
select * from book order by price desc, publisher asc;

-- 고객이 주문한 도서의 총 판매액을 구하세요
select sum(saleprice) as 총매출 from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오
select sum(saleprice) as '김연아 고객님의 구매 금액' from orders where custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최소값, 최댓값 구하세요.
select sum(saleprice) as '총매출', 
	avg(saleprice) as '평균값', 
    min(saleprice) as '최소값',
    max(saleprice) as '최대값'
from orders;

-- 서점의 도서 판매 건수를 구하시오
select count(*) from orders; -- count(*)함수는 null을 포함한 해당 속성의 튜플 개수를 출력
select count(publisher) from book; -- 컬럼명을 직접 제시하면 null을 제외한 출판사 개수 출력
select count(distinct publisher) from book; -- 중복을 제외한 출판사 개수 출력

select count(ifnull(saleprice,0)) from orders; -- saleprice 값이 null이면 0 아니면 ++된다

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
select custid, 
	count(*) as '총 수량', 
	sum(saleprice) as '총 판매액'
from orders
group by custid;

-- 가격이 8천원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량 출력(두 권 이상 구매한 고객만)
select custid, 
	count(*) as '총 수량', 
	sum(saleprice) as '총 판매액'
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2; -- group의 조건 (count가 2 이상 = custid가 같은 튜플의 수가 2 이상)

-- select 질의 실행 순서
-- from -> where -> group by -> having -> select -> order by
-- sql문은 실행 순서가 없는 비절차적인 언어지만 내부적 실행 순서는 존재한다.

-- (1)
select bookname from book where bookid = 1;
-- (2)
select bookname from book where price >= 20000; 
-- (3)
select sum(saleprice) from orders where custid = 1;
-- (4)
select count(*) from orders where custid = 1;

-- (1)
select count(*) from book;
-- (2)
select count(distinct publisher) from book;
-- (3)
select name, address from customer;
-- (4)
select orderid from orders where orderdate between '2024-07-04' and '2024-07-07';
-- (5)
select orderid from orders where orderdate not between '2024-07-04' and '2024-07-07';
-- (6)
select name, address from customer where name like "김%";
-- (7)
select name, address from customer where name like "김%아";

-- 두 테이블을 아무 조건 없이 연결한 결과 관계대수 : 카디션 프로덕트 연산 5 X 10
select * from customer, orders;
select count(custid) from customer;
select count(orderid) from orders;

-- 만약 박지성 고객이 주문한 도서의 총 구매액을 알고 싶다.
-- join : 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산.(공통 속성)
-- equi join(동등 조인) : 동등조건에 의하여 테이블을 조인하는 것

-- 고객과 고객의 주문에 대한 데이터를 모두 출력하시오
select *
from customer, orders
where customer.custid = orders.custid  -- 두 테이블의 연결 조건을 추가
order by customer.name;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하세요.
select name, saleprice
from customer, orders
where customer.custid = orders.custid
order by customer.custid, saleprice desc;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬하세요.
select name, sum(saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- 고객의 이름(customer.name)과 고객이 주문한 도서의 이름(book.bookname), 고객의 주문 정보(orders)
select customer.name, book.bookname, book.price
from customer, book, orders
where customer.custid = orders.custid and orders.bookid = book.bookid;

-- 가격이 2만원인 도서를 주문한 고객의 이름 출력
select customer.name, book.bookname
from customer, book, orders
where customer.custid = orders.custid and 
	orders.bookid = book.bookid and 
    book.price = 20000;

-- outer join(외부 조인) : on 조건과 겹치지 않는 left || right 테이블의 데이터도 출력시킨다. 
select customer.name, orders.saleprice
from customer left outer join orders on customer.custid = orders.custid;

select name, bookname
from book, orders, customer 
where customer.custid = orders.custid and book.bookid = orders.orderid and customer.custid = 1;

-- (5)
select name, count(distinct publisher)
from book, orders, customer 
where customer.custid = orders.custid and 
	book.bookid = orders.orderid and 
	customer.name = '박지성';
-- (6)
select bookname, price, saleprice, price - saleprice
from book, orders, customer
where customer.custid = orders.custid and 
	book.bookid = orders.bookid and 
    customer.name = '박지성';
-- (7)
select distinct bookname, name
from book, orders, customer
where customer.custid = orders.custid and 
	book.bookid = orders.bookid 
	and not customer.name = '추신수';