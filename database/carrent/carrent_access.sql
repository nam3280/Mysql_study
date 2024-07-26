create user carmanager@localhost identified by 'ssg';
grant all privileges on CARRENT.* to carmanager@localhost with grant option;
create database CARRENT;
use CARRENT;