select * from class
where startdate >= '2021-12-01';
select * from class
where startdate >='2021-12-01';
select * from student
where studentname like 'h%';
select * from subject
where credit >=3 and credit <=5;
select s.studentname, sub.subname , m.mark 
from student s join mark m on s.studentid = m.studentid join subject sub on sub.subid = m.subid
order by mark desc
 ;
