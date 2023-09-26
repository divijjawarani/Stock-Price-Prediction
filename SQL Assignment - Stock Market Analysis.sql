-- Changing format and type of 'Date' column of each table before starting the tasks

update bajaj
set Date = str_to_date(Date, "%d-%M-%Y"); #Converting the date to a YYYY-MM-DD format

alter table bajaj
modify `Date` Date; #Changing the Data Type of the Date Column to 'Date'. The same functions are repeated for all tables

desc bajaj;
select Date from bajaj 
limit 5;


update eicher
set Date = str_to_date(Date, "%d-%M-%Y");

alter table eicher
modify `Date` Date;

desc eicher;
select Date from eicher
limit 5;


update hero
set Date = str_to_date(Date, "%d-%M-%Y");

alter table hero
modify `Date` Date;

desc hero;
select Date from hero
limit 5;


update infosys
set Date = str_to_date(Date, "%d-%M-%Y");

alter table infosys
modify `Date` Date;

desc infosys;
select Date from infosys
limit 5;


update tcs
set Date = str_to_date(Date, "%d-%M-%Y");

alter table tcs
modify `Date` Date;

desc tcs;
select Date from tcs
limit 5;


update tvs
set Date = str_to_date(Date, "%d-%M-%Y");

alter table tvs
modify `Date` Date;

desc tvs;
select Date from tvs
limit 5;


-- TASK 1: Create a new table containing Date, Close Price, 20 Day moving average and 50 day moving average

-- Bajaj moving average table

create table bajaj1 as
select Date, `Close Price`,
IF(row_number() over w > 19, avg(`Close Price`) over (order by Date asc rows 19 preceding), Null) as '20DayMA', 
IF(row_number() over w > 49, avg(`Close Price`) over (order by Date asc rows 49 preceding), Null) as '50DayMA'
From bajaj
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from bajaj1
limit 55;

-- Eicher moving average table

create table eicher1 as
select Date, `Close Price`,
IF(row_number() over w > 19, avg(`Close Price`) over (order by Date asc rows 19 preceding), Null) as '20DayMA',
IF(row_number() over w > 49, avg(`Close Price`) over (order by Date asc rows 49 preceding), Null) as '50DayMA'
From eicher
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from eicher1
limit 55;

-- Hero moving average table

create table hero1 as
select Date, `Close Price`,
IF(row_number() over w > 19, avg(`Close Price`) over (order by Date asc rows 19 preceding), Null) as '20DayMA',
IF(row_number() over w > 49, avg(`Close Price`) over (order by Date asc rows 49 preceding), Null) as '50DayMA'
From hero
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from hero1
limit 55;

-- Infosys moving average table

create table infosys1 as
select Date, `Close Price`,
IF(row_number() over w > 19, avg(`Close Price`) over (order by Date asc rows 19 preceding), Null) as '20DayMA',
IF(row_number() over w > 49, avg(`Close Price`) over (order by Date asc rows 49 preceding), Null) as '50DayMA'
From infosys
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from infosys1
limit 55;

-- TCS moving average table

create table tcs1 as
select Date, `Close Price`,
IF(row_number() over w > 19, avg(`Close Price`) over (order by Date asc rows 19 preceding), Null) as '20DayMA',
IF(row_number() over w > 49, avg(`Close Price`) over (order by Date asc rows 49 preceding), Null) as '50DayMA'
From tcs
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from tcs1
limit 55;

-- TVS moving average table

create table tvs1 as
select Date, `Close Price`,
IF(row_number() over w > 19, avg(`Close Price`) over (order by Date asc rows 19 preceding), Null) as '20DayMA',
IF(row_number() over w > 49, avg(`Close Price`) over (order by Date asc rows 49 preceding), Null) as '50DayMA'
From tvs
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from tvs1
limit 55;


-- TASK 2: Create a master table containing the Date and the Close Price of all 6 stocks

create table master1 as
select 	b.Date,
		b.`Close Price`as Bajaj,
        e.`Close Price` as Eicher,
        h.`Close Price` as Hero, 
        i.`Close Price` as Infosys,
        t.`Close Price` as TCS, 
        v.`Close Price` as TVS
from 	bajaj b inner join eicher e on b.Date = e.Date 
				inner join hero h on e.Date = h.Date 
                inner join infosys i on h.Date = i.Date 
                inner join tcs t on i.Date = t.Date 
                inner join tvs v on t.Date = v.Date
order by Date asc;

select* from master1 
limit 5;


-- TASK 3: Create a new table containing the Buy/Sell/Hold Signal for each stock

-- Bajaj table with Signal

create table bajaj2 as
select Date, `Close Price`,
CASE
	WHEN (row_number() over w) > 19 AND 20DayMA > 50DayMA AND lag(20DayMA,1) over w < lag(50DayMA,1) over w THEN 'Buy'
	WHEN (row_number() over w) > 49 AND 50DayMA > 20DayMA AND lag(50DayMA,1) over w < lag(20DayMA,1) over w THEN 'Sell'
	ELSE 'Hold'
END as `Signal`
From bajaj1
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from bajaj2
limit 100;

-- Eicher table with Signal

create table eicher2 as
select Date, `Close Price`,
CASE
	WHEN (row_number() over w) > 19 AND 20DayMA > 50DayMA AND lag(20DayMA,1) over w < lag(50DayMA,1) over w THEN 'Buy'
	WHEN (row_number() over w) > 49 AND 50DayMA > 20DayMA AND lag(50DayMA,1) over w < lag(20DayMA,1) over w THEN 'Sell'
	ELSE 'Hold'
END as `Signal`
From eicher1
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from eicher2
limit 100;

-- Hero table with Signal

create table hero2 as
select Date, `Close Price`,
CASE
	WHEN (row_number() over w) > 19 AND 20DayMA > 50DayMA AND lag(20DayMA,1) over w < lag(50DayMA,1) over w THEN 'Buy'
	WHEN (row_number() over w) > 49 AND 50DayMA > 20DayMA AND lag(50DayMA,1) over w < lag(20DayMA,1) over w THEN 'Sell'
	ELSE 'Hold'
END as `Signal`
From hero1
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from hero2
limit 150;

-- Infosys table with Signal

create table infosys2 as
select Date, `Close Price`,
CASE
	WHEN (row_number() over w) > 19 AND 20DayMA > 50DayMA AND lag(20DayMA,1) over w < lag(50DayMA,1) over w THEN 'Buy'
	WHEN (row_number() over w) > 49 AND 50DayMA > 20DayMA AND lag(50DayMA,1) over w < lag(20DayMA,1) over w THEN 'Sell'
	ELSE 'Hold'
END as `Signal`
From infosys1
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from infosys2
limit 100;

-- TCS table with Signal

create table tcs2 as
select Date, `Close Price`,
CASE
	WHEN (row_number() over w) > 19 AND 20DayMA > 50DayMA AND lag(20DayMA,1) over w < lag(50DayMA,1) over w THEN 'Buy'
	WHEN (row_number() over w) > 49 AND 50DayMA > 20DayMA AND lag(50DayMA,1) over w < lag(20DayMA,1) over w THEN 'Sell'
	ELSE 'Hold'
END as `Signal`
From tcs1
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from tcs2
limit 100;

-- TVS table with Signal

create table tvs2 as
select Date, `Close Price`,
CASE
	WHEN (row_number() over w) > 19 AND 20DayMA > 50DayMA AND lag(20DayMA,1) over w < lag(50DayMA,1) over w THEN 'Buy'
	WHEN (row_number() over w) > 49 AND 50DayMA > 20DayMA AND lag(50DayMA,1) over w < lag(20DayMA,1) over w THEN 'Sell'
	ELSE 'Hold'
END as `Signal`
From tvs1
window w as (order by Date asc) # Window name 'w' given to the function since it is used more than once
order by Date asc;

select* from tvs2
limit 150;


-- TASK 4: Create a User Defined Function that takes input as Date and returns the signal for that particular day for the Bajaj Stock

create function assignment.Bajaj_Stock_Signal (bajaj_date date) # Input variable selected as 'bajaj_date'
returns varchar(5)
deterministic
return
(
	select `Signal`
	from bajaj2
	where Date = bajaj_date
);


select Bajaj_Stock_Signal('2015-10-19') as `Bajaj Stock Signal`;