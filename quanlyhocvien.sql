create database quanlyhocvien;
use quanlyhocvien;
create table class (
cid int primary key,
cname varchar(20),
clanguage varchar(20),
description varchar(49)
);

create table address(
adid int primary key,
address varchar (49)
);

create table students(
stid int primary key,
stname varchar(49),
staddressid int ,
phone varchar (20) unique,
stclassid int ,
foreign key (staddressid) references address (adid),
foreign key (stclassid) references class (cid)
);

create table course (
courseid int primary key,
courseidname varchar(20),
description varchar (49)
);

insert into address values (1,'hà nội');
insert into address values (2,'hà giang');
insert into address values (3,'thái bình');
insert into address values (4,'nam định');
insert into address values (5,'huế');

insert into class values (1,'c02','tiếng nhật','lớp nâng cao');
insert into class values (2,'b03','tiếng anh','lớp cá biệt');
insert into class values (3,'abc01','tiếng việt','học tốt');
insert into class values (4,'cde3','tiếng trung','lớp ngáo đá');
insert into class values (5,'abc9','tiếng pháp','lớp mất dạy');

insert into students values(1,'lập',1,'0987654499',1);
insert into students values(2,'an',2,'0987654498',2);
insert into students values(3,'thái',3,'0987654497',3);
insert into students values(4,'quang',4,'0987654496',4);
insert into students values(5,'bằng',5,'09876244995',5);
insert into students values(6,'quốc',1,'098116544995',1);
insert into students values(7,'vũclone',4,'032876544995',2);
insert into students values(8,'ý',2,'044995',3);
insert into students values(9,'thảo',5,'0644995',5);
insert into students values(10,'trường',1,'09236544995',2);

insert into course values (1,'khóa a','mèo');
insert into course values (2,'khóa b','gà');
insert into course values (3,'khóa c','bò');
insert into course values (4,'khóa d','chó');
insert into course values (5,'khóa e','lợn');

create table point (
pid int primary key,
courseid int ,
studentid int,
point int,
foreign key (courseid) references course (courseid)
);

insert into point values(1,2,1,10);
insert into point values(2,1,2,8);
insert into point values(3,3,3,7);
insert into point values(4,4,4,6);
insert into point values(5,1,5,5);
insert into point values(6,2,6,4);
insert into point values(7,3,7,2);
insert into point values(8,1,8,8);
insert into point values(9,2,9,9);
insert into point values(10,1,2,7);
insert into point values(11,3,3,10);
insert into point values(12,4,4,10);
insert into point values(13,2,5,2);
insert into point values(14,2,6,4);
insert into point values(15,4,1,3);

select count(stid) from students;

select c.cname from class c join students s on c.cid = s.stclassid;
select count(cname) ,cname from (select c.cname from class c join students s on c.cid = s.stclassid) as duclap group by cname;
 
select ad.address from address ad join students s on ad.adid = s.staddressid ; 
select  count(address),address from ( select ad.address from address ad join students s on ad.adid = s.staddressid ) as duclap group by address;
  
select p.point,co.courseidname from point p join course co on p.courseid = co.courseid ; 
select avg(point) as abc, courseidname from (select p.point,co.courseidname from point p join course co on p.courseid = co.courseid) as duclap group by courseidname;

select max(abc) from ( select avg(point) as abc, courseidname from (select p.point,co.courseidname from point p join course co on p.courseid = co.courseid) as duclap group by courseidname) as duclap;
