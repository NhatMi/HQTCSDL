-----Câu 1-----
create table SinhVien(
MaSV varchar(5) not null primary key,
Hoten nvarchar(20),
Ngaysinh date)
create table MonHoc(
MaMH varchar(5) not null primary key,
TenMH nvarchar(20),
SoTC int)
create table Diem(
MaSV varchar(5) not null constraint fk_MaSV references Sinhvien(MaSV),
MaMH varchar(5) not null constraint fk_MaMH references MonHoc(MaMH),
DiemThi decimal
)

-----Nhập dữ liệu cho bảng-----

insert SinhVien values
('001', 'Minh Thuan', '2002-10-5'),
('002', 'Truong Vi', '2002-12-1'),
('003', 'Minh Tuan', '2002-7-5')

insert MonHoc values
('MH1', 'LTW', '3'),
('MH2', 'HQTCSDL', '3'),
('MH3', 'LSDCSVN', '2')

insert Diem values
('001', 'MH3', '8'),
('002', 'MH1', '7.5'),
('001', 'MH2', '6'),
('003', 'MH2', '8.5'),
('003', 'MH1', '9'),
('002', 'MH3', '5')

-----Viết câu lệnh select xem dữ liệu bảng---
SELECT *  
FROM Diem;

SELECT   MaSV, MaMH, DiemThi 
FROM     Diem
ORDER BY DiemThi DESC ;

SELECT MaSV, MaMH, DiemThi
FROM   Diem
WHERE  DiemThi BETWEEN 8 AND 9 ;
go


-----Câu 2-----
go
create function tkssv (@tmh nvarchar(20))
returns int
as
begin
 declare @dem int
 set @dem = (select count(*)
 from Diem join MonHoc on MonHoc.MaMH = Diem.MaMH
where @dem<5)
 return @dem
end
go
select dbo.tkssv ('LSDCSVN')


-----Câu 3-----
CREATE PROCEDURE nhapDiem(@masv VARCHAR(10), @mamon VARCHAR(10), @diemthi decimal)
AS
BEGIN
	INSERT INTO DIEM (MaSV, MaMH, DiemThi)
	VALUES (@masv, @mamon, @diemthi)
END
go
nhapDiem'004', 'LSDCSVN', 4

-----Câu 4-----
create trigger them_sua
on Diem
FOR  INSERT, UPDATE
AS
if(select DiemThi From inserted)>10 and (select DiemThi From inserted)<0
begin
print
'khong cho phep'
rollback transaction
end
insert into Diem
values ('003','MH2','10')

