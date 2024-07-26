USE shopdb;

CREATE TABLE shopdb.memberTBL(
	memberID CHAR(8) NOT NULL PRIMARY KEY,
    memberName CHAR(5) NOT NULL,
    memberAddress CHAR(20) NULL
);

DESC membertbl;

SELECT * FROM shopdb.membertbl;

INSERT INTO membertbl values('ssg001','신세계','서울시 영등포구 여의도동');
INSERT INTO membertbl values('ssg002','이동우','서울시 강남구 청담동');
INSERT INTO membertbl values('ssg003','진선미','서울시 금천구 신일동');
commit;

select * from membertbl;

INSERT INTO producttbl values("냉장고",5,"2024-06-01","삼성",30);
INSERT INTO producttbl values("세탁기",20,"2024-09-01","LG",3);
INSERT INTO producttbl values("컴퓨터",10,"2024-11-01","한성",17);
commit;

select * from producttbl;

-- 1. 회원 테이블에서 진선미 회원의 정보만 조회하세요.
select * from membertbl where memberName = "진선미";

