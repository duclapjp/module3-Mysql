create database quanlybanhang;
use quanlybanhang;
create table customer (
cid int auto_increment  primary key,
cname varchar (25),
cage int
);
create table oder(
oid int primary key,
cid int,
odate datetime,
ototalprice int, 
foreign key(cid) references customer (cid)
);
create table product (
pid int primary key,
pname varchar(25)
);
create table oderdetail(
oid int not null,
pid int not null,
odqty int,
foreign key (oid) references oder (oid),
foreign key (pid) references product (pid)
);

insert into customer(cname,cage) values('minh quân',10);
insert into customer(cname,cage) values('ngọc oanh',20);
insert into customer(cname,cage) values('hồng hà',50);

insert into oder(oid,cid,odate) values(1,1,'2006-3-21');
insert into oder(oid,cid,odate) values(2,2,'2006-3-23');
insert into oder(oid,cid,odate) values(3,1,'2006-3-16');

alter table product
add column pprice int;

insert into product(pid,pname,pprice) values(1,'máy giặt',3);
insert into product(pid,pname,pprice) values(2,'tủ lạnh',5);
insert into product(pid,pname,pprice) values(3,'điều hòa',7);
insert into product(pid,pname,pprice) values(4,'quạt',1);
insert into product(pid,pname,pprice) values(5,'bếp điện',2);

insert into oderdetail values(1,1,3);
insert into oderdetail values(1,3,7);
insert into oderdetail values(1,4,2);
insert into oderdetail values(2,1,1);
insert into oderdetail values(3,1,8);
insert into oderdetail values(2,3,3);

select oid, odate, ototalprice from oder; 
use quanlybanhang;
select * from customer where cid not in (select cid from oder);

select o.oid, o.odate ,odqty, pprice
from oder o join oderdetail od on o.oid = od.oid join product p on  od.pid = p.pid;

select oid, (odqty*pprice) from ( select o.oid, o.odate ,odqty, pprice
from oder o join oderdetail od on o.oid = od.oid join product p on  od.pid = p.pid) as duclap;

select oid, sum(odqty*pprice) from ( select o.oid, o.odate ,odqty, pprice
from oder o join oderdetail od on o.oid = od.oid join product p on  od.pid = p.pid) as duclap group by oid;

use quanlybanhang;