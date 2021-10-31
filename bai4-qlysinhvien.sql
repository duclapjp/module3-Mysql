use quanlysinhvien;

select address , count(studentid) as 'số lượng học viên' from student group by address;


select st.studentname, m.mark,sub.subname from student st join mark m on st.studentid = m.studentid join subject sub on m.subid = sub.subid; 
select avg(mark) as 'điểm trung bình' ,studentname,subname from (select st.studentname, m.mark,sub.subname from student st join mark m on st.studentid = m.studentid join subject sub on m.subid = sub.subid) as duclap group by studentname;

select avg(mark) as diemtrungbinh ,studentname,subname from (select st.studentname, m.mark,sub.subname from student st join mark m on st.studentid = m.studentid join subject sub on m.subid = sub.subid) as duclap group by studentname having diemtrungbinh>7;

select max(diemtrungbinh) as diemtrungbinh ,studentname,subname from (select avg(mark) as diemtrungbinh ,studentname,subname from (select st.studentname, m.mark,sub.subname from student st join mark m on st.studentid = m.studentid join subject sub on m.subid = sub.subid) as duclap group by studentname) as duclap;

select max(credit), s.subname, s.status from subject s; 

select s.studentname, sub.subname,m.mark from student s join mark m on s.studentid = m.studentid join subject sub on sub.subid = m.subid; 
select max(mark),subname,studentname,examtimes from(select m.examtimes, s.studentname, sub.subname,m.mark from student s join mark m on s.studentid = m.studentid join subject sub on sub.subid = m.subid) as duclap;

select s.studentname,s.phone,c.classname,m.mark from student s join mark m on s.studentid = m.studentid join class c on s.classid = c.classid;
select avg(mark), studentname,phone,classname from(select s.studentname,s.phone,c.classname,m.mark from student s join mark m on s.studentid = m.studentid join class c on s.classid = c.classid) as duclap group by  studentname order by mark desc ;