drop database if exists hospital_billing;

create database hospital_billing;
use hospital_billing;


-- create patient table

create table patients (
    patient_id int primary key,
    patient_name varchar(50),
    age int,
    gender varchar(10),
    city varchar(50),
    phone varchar(15)
);


-- insert patient data

insert into patients values
(101, 'ramesh', 35, 'male', 'chennai', '9876543210'),
(102, 'priya', 28, 'female', 'salem', '9876543211'),
(103, 'arun', 45, 'male', 'madurai', '9876543212'),
(104, 'divya', 32, 'female', 'chennai', '9876543213'),
(105, 'kumar', 50, 'male', 'coimbatore', '9876543214'),
(106, 'sneha', 24, 'female', 'salem', '9876543215'),
(107, 'vijay', 40, 'male', 'trichy', '9876543216'),
(108, 'meena', 30, 'female', 'madurai', '9876543217');


-- create billing table

create table billing (
    bill_id int primary key,
    patient_id int,
    treatment varchar(50),
    bill_amount int,
    payment_status varchar(20),
    foreign key (patient_id) references patients(patient_id)
);


-- insert billing data

insert into billing values
(201, 101, 'general checkup', 1500, 'paid'),
(202, 102, 'blood test', 2500, 'pending'),
(203, 103, 'x-ray', 3000, 'paid'),
(204, 104, 'dental treatment', 5000, 'pending'),
(205, 105, 'heart checkup', 8000, 'paid'),
(206, 106, 'eye checkup', 2000, 'paid'),
(207, 107, 'full body checkup', 6000, 'pending'),
(208, 108, 'scan test', 4000, 'paid');


-- display data

show tables;

desc patients;

desc billing;

select * from patients;

select * from billing;


-- where condition

select * from patients
where age > 30;

select * from patients
where city = 'chennai';

select * from patients
where gender = 'female';

select * from billing
where bill_amount > 3000;


-- order by

select * from billing
order by bill_amount asc;

select * from billing
order by bill_amount desc;


-- distinct

select distinct city
from patients;

select distinct payment_status
from billing;


-- aggregate functions

select count(*) as total_patients
from patients;

select count(*) as total_bills
from billing;

select sum(bill_amount) as total_revenue
from billing;

select avg(bill_amount) as average_bill
from billing;

select max(bill_amount) as highest_bill
from billing;

select min(bill_amount) as lowest_bill
from billing;


-- group by

select payment_status, count(*) as total_bills
from billing
group by payment_status;

select treatment, avg(bill_amount) as average_amount
from billing
group by treatment;

select city, count(*) as total_patients
from patients
group by city;


-- having

select payment_status, count(*) as total_bills
from billing
group by payment_status
having count(*) > 2;


-- like operator

select * from patients
where patient_name like 'a%';

select * from patients
where patient_name like '%a';

select * from billing
where treatment like '%checkup%';


-- between and in

select * from billing
where bill_amount between 2000 and 6000;

select * from patients
where city in ('chennai', 'salem');


-- update data

update billing
set bill_amount = 2000
where bill_id = 201;


-- alter table

alter table patients
add email varchar(50);


-- delete data

delete from billing
where bill_id = 208;


-- string functions

select upper(patient_name)
from patients;

select lower(patient_name)
from patients;

select length(patient_name)
from patients;

select concat(patient_name, ' - ', city) as patient_details
from patients;


-- case when statement

select bill_id, treatment, bill_amount,
case
    when bill_amount >= 6000 then 'high bill'
    when bill_amount >= 3000 then 'medium bill'
    else 'low bill'
end as bill_category
from billing;


-- simple case statement

select bill_id, payment_status,
case payment_status
    when 'paid' then 'payment completed'
    when 'pending' then 'payment not completed'
    else 'unknown status'
end as payment_message
from billing;


-- inner join

select patients.patient_name,
billing.bill_id,
billing.treatment,
billing.bill_amount
from patients
inner join billing
on patients.patient_id = billing.patient_id;


-- left join

select patients.patient_name,
billing.bill_id,
billing.payment_status
from patients
left join billing
on patients.patient_id = billing.patient_id;

-- window function - rank

select bill_id,
patient_id,
bill_amount,
rank() over(order by bill_amount desc) as bill_rank
from billing;


-- window function - dense_rank

select bill_id,
patient_id,
bill_amount,
dense_rank() over(order by bill_amount desc) as bill_rank
from billing;


-- final hospital billing report

select
count(*) as total_bills,
sum(bill_amount) as total_revenue,
avg(bill_amount) as average_bill,
max(bill_amount) as highest_bill,
min(bill_amount) as lowest_bill
from billing;

select * from patients;

select * from billing;