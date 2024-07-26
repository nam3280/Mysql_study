create user account@localhost identified by 'ssgdoctor';

create database hospital;

grant all privileges on hospital.* to account@localhost with grant option;

