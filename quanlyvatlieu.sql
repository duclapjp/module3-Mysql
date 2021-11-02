create database quanlyvatlieu;
use quanlyvatlieu;

create table vattu(
    id int primary key ,
    name varchar(25),
    donvi varchar(20),
    price int
);
select * from vattu;

create table tonkho(
    id int primary key ,
    vattuid int,
    soluongdau int,
    tongSoLuongNhap int,
    tongSoLuongXuat int,
    foreign key (vattuid) references vattu(id)
);

create table nhacungcap(
    id int primary key ,
    code varchar(20),
    name varchar(20),
    diachi varchar(20),
    sodienthoai varchar(20)
);
create table dondathang(
    id int primary key ,
    code varchar(20),
    ngaydathang datetime,
    nhacungcapid int,
    foreign key (nhacungcapid) references nhacungcap(id)
);
create table phieunhap(
    id int primary key ,
    code varchar(20),
    ngaynhap datetime,
    donhangid int ,
    foreign key (donhangid) references dondathang(id)
);
create table phieuxuat(
    id int primary key ,
    ngayxuat datetime,
    tenkhachhang varchar(20)
);
create table chitietdonhang(
    id int primary key ,
    donhangid int,
    vattuid int ,
    soluongdat int,
    foreign key (vattuid) references vattu(id)
);
create table chitietphieunhap(
    id int primary key ,
    donhangid int,
    vattuid int,
    soluongnhap int,
    dongianhap int,
    ghichu varchar(50),
    foreign key (donhangid) references dondathang(id),
    foreign key (vattuid) references vattu(id)
);
create table chitietphieuxuat(
    id int primary key ,
    phieuxuatid int ,
    vattuid int,
    soluongxuat int,
    dongiaxuat int,
    ghichu varchar(50),
    foreign key   (phieuxuatid) references phieuxuat(id),
    foreign key (vattuid) references vattu(id)
);


create view vw_CTPNHAP as
    select c.id as `idnhap`,v.id as`idvattu`, c.soluongnhap,c.dongianhap , (dongianhap*soluongnhap) as ` thành tiền` from vattu v join chitietphieunhap c on v.id = c.vattuid;
select *from vw_CTPNHAP;

create view vw_CTPNHAP_VT as
    select ct.id as ` số phiếu nhập hàng`,ct.soluongnhap,ct.dongianhap,v.id as ` mã vật tư`,v.name, (soluongnhap*dongianhap) as ` thành tiền` from chitietphieunhap ct join vattu v on ct.vattuid = v.id;
select *from vw_CTPNHAP_VT;

create view vw_CTPNHAP_VT_PN as
    select ct.id as'số phiếu nhập hàng' , soluongnhap, dongianhap, vt.id as ` mã vật tư` , vt.name as ` tên vật tư`, pn.ngaynhap , (soluongnhap*dongianhap) as ` thành tiền`
from chitietphieunhap ct join vattu vt on ct.vattuid = vt.id join phieunhap pn on ct.donhangid = pn.donhangid;

select *from vw_CTPNHAP_VT_PN;

create view vw_CTPNHAP_VT_PN_DH as
select ct.id as'số phiếu nhập hàng' , soluongnhap as` số lượng nhập`, dongianhap`đơn giá nhập`,
       vt.id as ` mã vật tư` , vt.name as ` tên vật tư`, pn.ngaynhap , (soluongnhap*dongianhap) as ` thành tiền`,
       dd.code as` số đơn đặt hàng`, nh.code as` mã nhà cung cấp`
from chitietphieunhap ct join vattu vt on ct.vattuid = vt.id join phieunhap pn on ct.donhangid = pn.donhangid join dondathang dd on ct.donhangid = dd.id join nhacungcap nh on dd.nhacungcapid = nh.id;

select * from vw_CTPNHAP_VT_PN_DH;

create view vw_CTPNHAP_LOC as
    select pn.id as` số phiếu nhập hàng`, vt.id ` mã vật tư`, pn.soluongnhap ` số lượng nhập`, pn.dongianhap as` đơn giá nhập`, (soluongnhap*dongianhap) as ` thành tiền`
from chitietphieunhap pn join vattu vt on vt.id = pn.vattuid where pn.soluongnhap  >5;

select * from vw_CTPNHAP_LOC;

create view vw_CTPXUAT as
    select px.id as` số phiếu xuất hàng`, vt.id as` mã vật tư`, px.soluongxuat as` số lượng xuất`, px.dongiaxuat ` đơn giá xuất`, (soluongxuat*dongiaxuat) as ` thành tiền`
from chitietphieuxuat px join vattu vt on px.vattuid = vt.id;

select * from vw_CTPXUAT;

create view vw_CTPXUAT_VT as
select px.id as` số phiếu xuất hàng`, vt.id as` mã vật tư`,vt.name as ` tên vật tư`, px.soluongxuat as` số lượng xuất`, px.dongiaxuat ` đơn giá xuất`, (soluongxuat*dongiaxuat) as ` thành tiền`
from chitietphieuxuat px join vattu vt on px.vattuid = vt.id;

select * from vw_CTPXUAT_VT;

create view vw_CTPXUAT_VT_PX as
select px.id as` số phiếu xuất hàng`,p.tenkhachhang as` tên khách hàng`, vt.id as` mã vật tư`,vt.name as ` tên vật tư`, px.soluongxuat as` số lượng xuất`, px.dongiaxuat ` đơn giá xuất`, (soluongxuat*dongiaxuat) as ` thành tiền`
from chitietphieuxuat px join vattu vt on px.vattuid = vt.id join phieuxuat p on px.phieuxuatid = p.id;

select * from vw_CTPXUAT_VT_PX;

delimiter //
create procedure soluongcuoi(in ma_vat_tu int)
begin
    select v.name, sum(t.soluongdau) as ` tổng số lượng cuối` from vattu v join tonkho t on v.id = t.vattuid where v.id= ma_vat_tu group by t.vattuid;
end //
delimiter ;

drop procedure soluongcuoi;


call soluongcuoi(1);

delimiter //
create procedure tongtienxuat(in ma_vat_tu int)
begin
select v.name as` tên vật tư`, sum(soluongxuat*dongiaxuat) as ` tổng tiền xuất của vật tư`
from vattu v join chitietphieuxuat ch on v.id = ch.vattuid where v.id=ma_vat_tu group by name;
end //

call tongtienxuat(3);

alter table chitietdonhang
add foreign key (donhangid) references dondathang (id);

delimiter //
create procedure tongsoluongdat(in so_don_hang int)
begin
    select d.id ` số đơn hàng`, sum(soluongdat)  as` tổng số lượng đặt hàng`
    from dondathang d join chitietdonhang ch on d.id = ch.id where d.id = so_don_hang group by vattuid;
end //

call tongsoluongdat(2);

delimiter //
create procedure insertDonHang(
    iddonhang int,
    ma_so varchar(20),
    ngay_dat_hang datetime,
    nha_cung_cap int
)
begin
    insert into dondathang values (iddonhang,ma_so,ngay_dat_hang,nha_cung_cap);
end //
delimiter //;

call insertDonHang(5,'e1','2021-9-10',3);

delimiter //
create procedure insertChiTietDonHang(
    id_chiTietDH int,
    id_donHang int,
    id_vatTu int,
    so_Luong_Dat int
)
begin
    insert into chitietdonhang values (id_chiTietDH,id_donHang,id_vatTu,so_Luong_Dat);
end//

call insertChiTietDonHang(10,3,5,9);


