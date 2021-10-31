create database quanlydulich;
use quanlydulich;
create table  destinations(
id int primary key,
desname varchar(25),
description varchar(25),
avgcost double,
townid int,
foreign key (townid) references town (id)
);
insert into destinations values(1,'osaka','phía nam nhật bản',20.5,1);
insert into destinations values(2,'tokyo','thủ đô nhật bản',40,2);
insert into destinations values(3,'okinawa','biển đẹp nhất',30.5,3);
insert into destinations values(4,'hokaido','phía bắc, vùng lạnh nhất',50,4);
insert into destinations values(5,'odaiba','khu du lịch nổi tiếng',20,5);


create table customer(
id int primary key,
odername varchar(25),
cmnd varchar(20),
dateofbirth datetime,
townid int,
foreign key (townid) references town(id)
);

insert into customer values(1,'lập','0123abc','1994-10-9',2);
insert into customer values(2,'thái','01234abc','2000-8-9',3);
insert into customer values(3,'an','01235abc','1992-11-9',4);
insert into customer values(4,'xa','01236abc','1995-1-9',1);
insert into customer values(5,'vũ','01237abc','1992-12-9',2);
insert into customer values(6,'hà','01222abc','2000-3-23',3);
insert into customer values(7,'hải','012433abc','1996-12-9',1);
insert into customer values(8,'hoảng','012123abc','1997-2-9',2);
insert into customer values(9,'hoằng','0123314abc','1998-9-9',4);
insert into customer values(10,'bách','01234a4bc','1999-10-5',2);

create table town(
id int primary key,
townname varchar(20)
);

insert into town values(1,'osaka');
insert into town values(2,'tokyo');
insert into town values(3,'okinawa');
insert into town values(4,'hokaido');
insert into town values(5,'odaiba');

create table tour(
id int primary key,
codetour varchar(20),
costtour double,
typetourid int,
startdate date,
closedate date
);


insert into tour values (1,'a1',32,1,'2021-3-12','2021-3-19');
insert into tour values (2,'b1',22,2,'2020-3-1','2020-3-15');
insert into tour values (3,'c1',30,3,'2021-3-16','2021-3-21');
insert into tour values (4,'a11',15,1,'2020-2-12','2020-3-1');
insert into tour values (5,'a12',10,2,'2020-3-2','2020-3-7');
insert into tour values (6,'a13',21,3,'2021-3-12','2020-4-1');
insert into tour values (7,'b1',22,2,'2020-3-5','2020-3-19');
insert into tour values (8,'bc1',20,2,'2021-3-11','2021-3-19');
insert into tour values (9,'a111',30,3,'2021-3-21','2021-3-27');
insert into tour values (10,'ac1',32,3,'2021-3-2','2021-3-9');
insert into tour values (11,'avc1',15,1,'2021-3-3','2021-3-9');
insert into tour values (12,'a113',24,2,'2021-3-4','2021-3-12');
insert into tour values (13,'a34',28,1,'2021-3-5','2021-3-15');
insert into tour values (14,'a2341',22,2,'2021-3-6','2021-3-19');
insert into tour values (15,'a12314x',19,3,'2021-3-7','2021-3-19');

create table typetour(
id int primary key,
codetype varchar(20),
typetourname varchar(20)
);

insert into typetour values(1,'abc1','du lịch abc');
insert into typetour values(2,'abc2','du lịch zyz');
insert into typetour values(3,'abc3','du lịch a-z');


create table bill(
id int primary key,
tourid int,
customerid int,
status bit,
foreign key (tourid) references tour (id),
foreign key (customerid) references customer(id)
);

insert into bill values(1,1,1,1);
insert into bill values(2,2,2,0);
insert into bill values(3,3,3,1);
insert into bill values(4,4,4,0);
insert into bill values(5,5,5,1);
insert into bill values(6,6,6,1);
insert into bill values(7,7,7,0);
insert into bill values(8,8,8,1);
insert into bill values(9,9,9,0);
insert into bill values(10,10,10,1);

select t.townname,b.tourid from town t join customer c on t.id = c.townid join bill b on c.id = b.customerid;
select townname, count(tourid) from (select t.townname,b.tourid from town t join customer c on t.id = c.townid join bill b on c.id = b.customerid) as duclap group by townname;

select startdate from tour where startdate >='2020-3-1' and startdate<='2020-3-30'; 
select startdate, count(startdate) from tour where (startdate>='2020-3-1' and startdate<='2020-3-30');

select closedate, count(closedate) `số tour` from tour where closedate<='2020-4-30' and closedate>='2020-4-1' ;

alter table tour add index costindex(costtour);

 explain select *from tour where costtour =20;