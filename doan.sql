
create database conveniencestore;
use conveniencestore; 

create table NHANVIEN (
    id int primary key,
    hoten varchar(50),
    sdt varchar(10), 
    diachi varchar(50), 
    ngayvaolam date, 
    mkdangnhap varchar(20)
);
create table CALAM (
    id int  primary key,  
    nhanvien_id int, 
    tgianketthuc time, 
    tgiandatdau time
);
alter table CALAM 
    add constraint fk_cl_nv foreign key(nhanvien_id) references NHANVIEN(id); 

create table SANPHAM (
    id int primary key, 
    ten varchar(30), 
    voucherid int, 
    giaban int
);

create table VOUCHER(
    id int primary key, 
    ngaybatdau date, 
    ngayketthuc date, 
    giatrigiam int, 
    dieukien varchar(30)
);

create table KHO(
    id int primary key, 
    sanphamid int, 
    tonkho int
);
create table CTHD (
    hoadonid int , 
    sanphamid int , 
    soluong int, 
    dongia int

); 
alter table CTHD add constraint pk_cthd primary key(hoadonid, sanphamid); 

create table HOADON (
    id int primary key, 
    khachhangid int , 
    nhanvienid int, 
    ngaylap date, 
    trangthai varchar(20), 
    tongtien int
); 

create table KHACHHANG (
    sdt int primary key, 
    ten varchar(50), 
    ngaylap date, 
    diem int
);

create table thanhtoan(
    id int primary key, 
    hoadonid int , 
    phuongthuc varchar(20), 
    ngaythanhtoan date, 
    sotien int
);

--san pham 
alter table SANPHAM 
    add constraint fk_sp_vch foreign key(voucherid) references VOUCHER(id); 
--kho 
alter table KHO 
    add constraint fk_kho_sp foreign key(sanphamid) references SANPHAM(id); 
--cthd
alter table CTHD
    add constraint fk_cthd_sp foreign key(sanphamid) references SANPHAM(id); 
alter table CTHD 
    add constraint fk_cthd_hd foreign key(hoadonid) references HOADON(id); 

--hoa don 
alter table HOADON 
    add constraint fk_hd_kh foreign key(khachhangid) references KHACHHANG(sdt); 
alter table HOADON 
    add constraint fk_hd_nv foreign key(nhanvienid) references NHANVIEN(id);

--thanhtoan 
alter table thanhtoan 
    add constraint fk_tt_hd foreign key(hoadonid) references HOADON(id); 