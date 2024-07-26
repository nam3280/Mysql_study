use carrent;

create table campingcar_repairshop(
	shop_id int unsigned not null,
	shop_name varchar(10) not null,
    shop_address varchar(20) not null,
    shop_number varchar(15) not null,
    shop_manager_name varchar(10) not null,
    shop_manager_email varchar(15) not null,
    primary key(ger_id)
);

create table customers(
	license varchar(15) not null,
    cus_name varchar(10) not null,
    cus_address varchar(20) not null,
    cus_phonenumber varchar(15) not null,
    cus_email varchar(15),
    before_car_date varchar(15),
    before_car_type varchar(10),
    primary key(license)
);

create table campingcar_rental_companies(
    company_id int unsigned not null,
    company_name varchar(10) not null,
	company_address varchar(20) not null,
    company_number varchar(15) not null,
    company_manager_name varchar(10) not null,
    company_manager_email varchar(15) not null,
    primary key(company_id)
);

create table campingcars(
    car_reg_id int unsigned not null,
    company_name varchar(10) not null,
	company_address varchar(20) not null,
    company_number varchar(15) not null,
    company_manager_name varchar(10) not null,
    company_manager_email varchar(15) not null,
    primary key(company_id)
);

create table campingcar_repairinfo(
    repair_number varchar(15) not null,
	car_id int unsigned not null,
	shop_id int unsigned not null,
    company_id int unsigned not null,
	license varchar(15) not null,
    repair_history varchar(50),
    repair_date varchar(15) not null,
    duedate varchar(15) not null,
    repair_etc varchar(50),
    primary key(repair_number)
);