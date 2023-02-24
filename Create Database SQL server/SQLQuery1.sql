--Create database SQL
CREATE DATABASE QLBH;

----USE (Transact-SQL)
USE QLBH;
go

--SQL CREATE TABLE
Create Table VATTU (
   MaVTu Char(4) NOT Null Primary Key,
   TenVTu VarChar(100) NOT Null UNIQUE,
   DvTinh VarChar(10) DEFAULT '',
   PhamTram Real  ,
);

ALTER TABLE  VATTU
ADD CONSTRAINT check_PhamTram_range CHECK (PhamTram BETWEEN 0 AND 100);

Create Table NHACC (
  MaNhaCc Char(3) Not Null Primary Key,
  TenNhaCc VarChar(100) Not Null ,
  DiaChi  Varchar(200) Not Null ,
  DienThoai Varchar(20) Null Default N'Chưa có'
);

Create Table DONDH (
   SoDh Char(4) Not Null Primary Key,
   NgayDh DateTime Default Getdate(),
   MaNhaCc Char(3) Not Null Foreign Key References NHACC(MaNhaCc)
);

Create Table  CTDONDH (
  SoDh Char(4) Not Null Foreign Key References DONDH(SoDh),
  MaVTu Char(4) Not Null Foreign Key References VATTU(MaVTu),
  SIDat Int Not Null Check (SIDat >0)
);

Create Table PNHAP (
   SoPn Char(4) Primary Key,
   NgayNhap Datetime Default Getdate(),
   SoDh Char(4) Not Null Foreign Key References DONDH(SoDh)
);

Create Table CTPNHAP (
   SoPn Char(4) Not Null Foreign Key References PNHAP(SoPn),
   MaVTu Char(4)  Not Null Foreign Key References VATTU(MaVTu),
   SINhap Int Not Null Check (SINhap > 0),
   DgNhap Money Not Null Check (DgNhap > 0),
);

Create Table PXUAT (
  SoPx Char(4) Not Null Primary Key,
  NgayNhap Datetime Default Getdate(),
  TenKh Varchar(100) NOT Null,
);

Create Table CTPXUAT (
  SoPx Char(4) Not Null Foreign Key References PXUAT(SoPx),
  MaVTu Char(4)  Not Null Foreign Key References VATTU(MaVTu),
  SIXuat Int Not Null Check (SIXuat > 0),
   DgXuat Money Not Null Check (DgXuat > 0),
);

Create Table TONKHO (
   NamThang Char(6) Not Null Primary Key,
   MaVTu Char(4)  Not Null Foreign Key References VATTU(MaVTu),
   SLDau Int Not Null Check (SLDau >= 0),
   TongSLN Int Not Null Check (TongSLN >= 0),
   TongSLX Int Not Null Check (TongSLX >= 0),
   SLCuoi  as (SLDau+TongSLN-TongSLX)
);

INSERT INTO NHACC(MaNhaCc,TenNhaCc,DiaChi,DienThoai)
Values 
      ('C01',N'Lê Minh Thành',N'54, Kim Mã, Cầu Giấy, Hà Nội',8781024),
	  ('C02',N'Trần Quang Anh',N'145, Hùng Vương, Hải Dương',7698154),
	  ('C03',N'Bùi Hồng Phương ',N'154/85, Lê Chân, Hải Phòng',9600125),
	  ('C04',N'Vũ Nhật Thắng ',N'198/40 Hương Lộ 14 QTB HCM ',8757757),
	  ('C05',N'Nguyễn Thị Thúy',N'178 Nguyễn Văn Luông Đà Lạt',7964251);


INSERT INTO NHACC(MaNhaCc,TenNhaCc,DiaChi)
Values
      ('C07',N'Cao Minh Trung',N'125 Lê Quang Sung Nha Trang');

-----VATTU
INSERT INTO VATTU  
Values 
    ('DD01',N'Đầu DVD Hitachi 1 đĩa',N'Bộ',40),
	('DD02',N'Đầu DVD Hitachi 3 đĩa',N'Bộ',40),
	('TL15',N'Tủ lạnh Sanyo 150 lit',N'Cái',25),
	('TL90',N'Tủ lạnh Sanyo 90 lit',N'Cái',20),
	('TV14',N'Tivi Sony 14 inches',N'Cái',15),
	('TV21',N'Tivi Sony 21 inches',N'Cái',10),
	('TV29',N'Tivi Sony 29 inches',N'Cái',10),
	('VD01',N'Đầu VCD Sony 1 đĩa ',N'Bộ',30),
	('VD02',N'Đầu VCD Sony 3 đĩa ',N'Bộ',30);

---DONDH
INSERT INTO DONDH  --(SoDh,MaNhaCc)
Values 
    ('D001',N'01/15/2012','C03');

INSERT INTO DONDH  
Values
     ('D002',N'01/30/2012','C01'),
	 ('D003',N'02/10/2012','C02'),
	 ('D004',N'02/17/2012','C05'),
	 ('D005',N'03/01/2012','C02'),
	 ('D006',N'03/02/2012','C05');

---PNHAP
INSERT INTO PNHAP  
Values
     ('N001',N'01/17/2012','D001'),
	 ('N002',N'01/20/2012','D001'),
	 ('N003',N'01/31/2012','D002'),
	 ('N004',N'02/15/2012','D003');
    
----CTDONDH
INSERT INTO CTDONDH  
Values
     ('D001','DD01',10),
	 ('D001','DD02',15),
	 ('D002','VD02',30),
	 ('D003','TV14',10),
	 ('D003','TV29',20),
	 ('D004','TL90',10),
	 ('D005','TV14',10),
	 ('D005','TV29',20),
	 ('D006','TV14',10),
	 ('D006','TV29',20),
	 ('D006','VD01',20);

-----CTPNHAP
INSERT INTO CTPNHAP
Values
     ('N001','DD01',8,2500000),
	 ('N001','DD02',10,3500000),
	 ('N002','DD01',2,2500000),
	 ('N002','DD02',5,3500000),
	 ('N003','VD02',30,2500000),
	 ('N004','TV14',5,2500000),
	 ('N004','TV29',12,3500000);

-----PNHAP
INSERT INTO PXUAT VALUES('X001','01/17/2014',N'Lê Hoàng Anh Tuấn')
INSERT INTO PXUAT VALUES('X002','01/25/2014',N'Nguyễn Trần Lâm')
INSERT INTO PXUAT VALUES('X003','01/31/2014',N'Bùi Thị Thu Thủy')
Go

----CTPXUAT
INSERT INTO CTPXUAT VALUES('X001','DD01',2 ,35)
INSERT INTO CTPXUAT VALUES('X002','DD01',1 ,35)
INSERT INTO CTPXUAT VALUES('X002','DD02', 5,49)
INSERT INTO CTPXUAT VALUES('X003','DD01', 3,35)
INSERT INTO CTPXUAT VALUES('X003','DD02', 2,49)
INSERT INTO CTPXUAT VALUES('X003','QD02', 10,32.5)

UPDATE  CTPXUAT SET CTPXUAT.DgXuat=CTPXUAT.DgXuat*100000
Go

-----TONKHO
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201401','DD01',0,10,6 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201402','DD02',0,15,7 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201403','QD02',0,30,10 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201404','DD01',4,0,0 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201405','DD02',8,0,0 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201406','QD02',20,0,0 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201407','TV40',5,0,0 )
INSERT INTO TONKHO(NamThang,MaVTu,SLDau,TongSLN,TongSLX) VALUES('201408','TV32',12,0,0 )


----Select * from TONKHO