-- ssg 계정 생성 (비번 : ssg)
create user ssg@localhost identified by "ssg";
-- 외부에서 접근 가능한 ssg 계정 생성  (비번 : ssg)
create user ssg@'%' identified by "ssg";

-- 권한 부여
grant all privileges on ssg.* to ssg@localhost with grant option;
commit;