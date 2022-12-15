create table Lop(
MaLop char(5) not null primary key,
TenLop nvarchar(20),
SiSo int)
create table Sinhvien(
MaSV char(5) not null primary key,
Hoten nvarchar(20),
Ngaysinh date,
MaLop char(5) constraint fk_malop references lop(malop))
create table MonHoc(
MaMH char(5) not null primary key,
TenMH nvarchar(20))
create table KetQua(
MaSV char(5) not null,
MaMH char(5) not null,
Diemthi float,
constraint fk_Masv foreign key(MaSV) references sinhvien(MaSV),
constraint fk_Mamh foreign key(MaMH) references Monhoc(MaMH),
constraint pk_Masv_Mamh primary key(Masv, mamh))
insert lop values
('a','lop 1',0),
('b','lop 2',0),
('c','lop 3',0)
insert sinhvien values
('01','Minh Thuan','1999-1-10','a'),
('02','Le Duan','2000-7-1','a'),
('03','Le Quang','2002-12-12','a')
insert monhoc values
('PPLT','Phuong phap LT'),
('CSDL','Co so du lieu'),
('SQL','He quan tri CSDL'),
('LTW','Lap trinh Web')
insert KetQua values
('03','PPLT',8),
('01','SQL',7),
('02','PPLT',8),
('01','CSDL',5),
('02','PTW',5)

---c�u 1-----
go
create function diemtb (@msv char(5))
returns float
as
begin
 declare @tb float
 set @tb = (select avg(Diemthi)
 from KetQua
where MaSV=@msv) 
 return @tb
end
go
select dbo.diemtb ('01')

---c�u 2-----
go
create function trbinhlop1(@malop char(5))
returns @dsdiemtb table (masv char(5), tensv nvarchar(20), dtb float)
as
begin
 insert @dsdiemtb
 select s.masv, Hoten, trungbinh=dbo.diemtb(s.MaSV)
 from Sinhvien s join KetQua k on s.MaSV=k.MaSV
 where MaLop=@malop
 group by s.masv, Hoten
 return
end
go
select*from trbinhlop1('1')

---c�u 3-----
go
create proc ktra @msv char(5)
as
begin 
 declare @n int
 set @n=(select count(*) from ketqua where Masv=@msv)
 if @n=0 
 print 'sinh vien '+@msv + 'khong thi mon nao'
 else
 print 'sinh vien '+ @msv+ 'thi '+cast(@n as char(2))+ 'mon'
end 
go
exec ktra '01'---c�u 4-----go
create trigger updatesslop
on sinhvien
for insert
as
  begin
      declare @ss int
      set @ss=(select count(*) from sinhvien s 
              where malop in(select malop from inserted))
      if @ss>10
          begin
               print 'Lop day'
               rollback tran
          end
      else
          begin
               update lop
               set siso=@ss
               where malop in (select malop from inserted)
          end
	end
go