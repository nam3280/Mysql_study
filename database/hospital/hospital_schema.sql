use hospital;

create table doctors(
	doctorid int unsigned not null, 
	medicalsubject varchar(10) not null,
    doctor_name varchar(10) not null,
    doctor_gender char(2) not null,
    doctor_phonenumber varchar(20) not null,
    doctor_email varchar(20),
    doctor_rank varchar(5) not null,
    primary key (doctorid)
);

create table patients(
	patientid int unsigned not null,
	nurseid int unsigned not null, 
	doctorid int unsigned not null,
	patient_name varchar(10) not null,
    patient_gender char(2) not null,
    rrn varchar(15) not null,
    address varchar(30) not null,
    patient_phonenumber varchar(20) not null,
    patient_email varchar(20),
    job varchar(10) not null,
    primary key (patientid)
);

create table nurses(
	nurseid int unsigned not null, 
    task varchar(10) not null,
	nurse_name varchar(10) not null,
    nurse_gender char(2) not null,
    nurse_phonenumber varchar(20) not null,
    nurse_email varchar(20),
    nurse_rank varchar(5) not null,
    primary key (nurseid)
);

create table consultations(
	consultationid int unsigned not null, 
	patientid int unsigned not null,
	doctorid int unsigned not null,
    consultation_detail varchar(50) not null,
    date varchar(20) not null,
    primary key (consultationid)
);

create table charts(
	chartnumber int unsigned not null, 
    consultationid int unsigned not null, 
    doctorid int unsigned not null,
	patientid int unsigned not null,
    nurseid int unsigned not null,
    chart_detail varchar(50) not null,
    primary key (chartnumber)
);

alter table patients add foreign key (nurseid) references nurses(nurseid);
alter table patients add foreign key (doctorid) references doctors(doctorid);

alter table consultations add foreign key (doctorid) references doctors(doctorid);
alter table consultations add foreign key (patientid) references patients(patientid);

alter table charts add foreign key (consultationid) references consultations(consultationid);
alter table charts add foreign key (doctorid) references consultations(doctorid);
alter table charts add foreign key (patientid) references consultations(patientid);
alter table charts add foreign key (nurseid) references nurses(nurseid);