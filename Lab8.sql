------------B�i 2-----------
-----------c�u 1-------------
SELECT * FROM SANPHAM, KHACHHANG
------------c�u 2------------
SELECT * FROM SANPHAM,KHACHHANG
-------------c�u 3------------
UPDATE SANPHAM SET GIA =GIA/(100/5)+GIA
WHERE NUOCSX = N'Thai Lan'
------------c�u 4------------
UPDATE SANPHAM SET GIA =GIA/(100/5)+GIA
WHERE NUOCSX = N'Trung Quoc'
-------------c�u 5-----------
UPDATE KHACHHANG SET LOAIKH='VIP' 
WHERE (NGDK<cast('2011/1/1' as date) AND DOANHSO>=10000000) 
OR (NGDK>cast('2011/1/1' as date) AND DOANHSO >=2000000)

-------------B�i 3------------
-----------c�u 1-------------
SELECT MASP,TENSP
FROM  SANPHAM
WHERE NUOCSX='Trung Quoc'
----------c�u 2---------
SELECT MASP,TENSP
FROM  SANPHAM
WHERE DVT='cay' OR DVT='quyen'
---------c�u 3---------
SELECT MASP,TENSP
FROM  SANPHAM
WHERE MASP LIKE 'B%01'
---------c�u 4---------
SELECT MASP,TENSP
FROM  SANPHAM
WHERE NUOCSX='Trung Quoc' AND GIA BETWEEN 30000 AND 40000
-----c�u 5------
SELECT MASP,TENSP
FROM  SANPHAM
WHERE (NUOCSX='Trung Quoc' OR NUOCSX='Thai Lan') AND GIA BETWEEN 30000 AND 40000
-----c�u 6------
SELECT SOHD,TRIGIA
FROM  HOADON
WHERE NGHD=cast('2007/01/01' as date) OR NGHD=cast('2007/01/02' as date) 
-----c�u 7------
SELECT SOHD,TRIGIA
FROM  HOADON
WHERE MONTH(NGHD)=1 AND YEAR(NGHD)=2007
ORDER BY  NGHD ASC,TRIGIA DESC
-----c�u 8------
SELECT A.MAKH,HOTEN
FROM  HOADON A, KHACHHANG B
WHERE A.MAKH=B.MAKH AND NGHD=cast('2007/01/01' as date) 
-----c�u 9------
SELECT SOHD,TRIGIA
FROM  HOADON A, NHANVIEN B
WHERE A.MANV=B.MANV AND NGHD=cast('2006/10/28' as date)  AND HOTEN='Nguyen Van B' 
-----c�u 10------
SELECT C.MASP, TENSP
FROM  HOADON A, KHACHHANG B, CTHD C, SANPHAM D
WHERE A.MAKH=B.MAKH AND A.SOHD=C.SOHD AND C.MASP=D.MASP AND
  MONTH(NGHD)=10 AND YEAR(NGHD)=2006 AND HOTEN='Nguyen Van A'