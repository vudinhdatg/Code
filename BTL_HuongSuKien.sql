create database dbBookStore
go
use dbBookStore
go

-- create table

create table tblNhanVien
(	sMaNV  varchar(5) primary key,
	sTenNV nvarchar(25) ,
	dNgaysinh date  check (datediff(day,dNgaysinh , getdate())/365 >=18),
	sGioitinh nvarchar(4)  check (sGioiTinh = N'Nam' or sGioiTinh = N'Nữ'),
	sQuequan nvarchar(25) ,
	sSDT varchar(11) 
)

alter table tblNhanVien
add sChucvu nvarchar(25)
create table tblKhachHang 
(	sMaKH varchar(5) primary key,
	sTenKH nvarchar(60) not null,
	sDiachi nvarchar(25) not null,
	sSDT varchar(11) not null
)
alter table tblKhachHang
add sGioiTinh nvarchar(10)
alter table tblKhachHang
add dNgaySinh date
go
create table tblNXB 
(	sMaNXB varchar(5) primary key,
	sTenNXB nvarchar(60) not null,
	sDiachi nvarchar(25),
	sSDT varchar(11)
)
go
create table tblSach 
(	sMasach varchar(5) primary key,
	sTensach nvarchar(25) not null,
	sMaNXB varchar(5) not null references tblNXB(sMaNXB),
	sTacgia nvarchar(25) not null,
	sTheloai nvarchar(30),
	fGia float check (fGia > 0),
	iNXB int
)
go


create table tblHoaDon
(	sMaHD varchar(5) primary key,
	sMaNV varchar(5) not null references tblNhanVien(sMaNV),
	sMaKH varchar(5) not null references tblKhachHang(sMaKH),
	dNgaylap date check(dNgayLap <= getDate()),
	fTongtien float,

)
go
alter table tblHoaDon
add bTrangthai bit default 0
create table tblChiTietHD 
(	sMaHD varchar(5) references tblHoaDon(sMaHD),
	sMasach varchar(5) references tblSach(sMaSach),
	iSl int not null check (iSL >0),
	constraint pk primary key (sMaHD, sMaSach)
)


select * from tblNXB

---------------------------------------------------------------
insert into tblNXB
values('NXB1', N'Nhà xuất bản Kim Đồng',N'Hà Nội','0395478923'),
	  ('NXB2', N'Nhà xuất bản Trẻ', N'Thành phố Hồ Chí Minh', '0346985345'),
	  ('NXB3', N'Nhà xuất bản Giáo dục Việt Nam', N'Hà Nội', '0346985314'),
	  ('NXB4', N'Nhà xuất bản Thanh Niên', N'Thành phố Hồ Chí Minh', '0398742563'),
	  ('NXB5', N'Nhà xuất bản Văn Học', N'Thành phố Hồ Chí Minh', '0316789521')
go

select * from tblNhanVien

insert into tblNhanVien
values('NV01',N'Đỗ Trọng Ninh','2003/09/28',N'Nam',N'Thái Bình','0382127429'),
	('NV02',N'Nguyễn Đức Cường','2003/12/18',N'Nam',N'Bắc Ninh','0982127429'),
	('NV03',N'Vũ Việt Anh','2003/12/18',N'Nam',N'Thái Bình','0782127429'),
	('NV04',N'Lê Thu Hiền','2001/06/02',N'Nữ',N'Bình Dương','0482127429'),
	('NV05',N'Bùi Thị Trang','2003/11/05',N'Nữ',N'Hà Nội','0582127429')
go
select * from tblSach
insert into tblSach
values('S01', N'Thám tử lừng danh Conan', 'NXB1', 'Gosho Aoyama', N'Truyện trinh thám', 18000,1998),
	  ('S02', N'Doraemon', 'NXB1', 'Fujiko F Fujio', N'Truyện tranh', 18000,1998),
	  ('S03', N'Shin - Cậu bé bút chì', 'NXB1', 'Yoshito Usui', N'Truyện tranh', 18000,2000),
	  ('S04', N'Còn chút gì để nhớ', 'NXB2', N'Nguyễn Nhật Ánh', N'Truyện dài', 550000,2000),
	  ('S05', N'Bàn có năm chỗ ngồi', 'NXB2', N'Nguyễn Nhật Ánh', N'Truyện dài', 38000,1999),
	  ('S06', 'Digiscience 3', 'NXB3', N'Trương Hạ Dương', N'Sách tham khảo', 65000,2001),
	  ('S07', N'Mãi mãi tuổi hai mươi', 'NXB4', N'Nguyễn Văn Thạc', N'Hồi ký', 123000,2003),
	  ('S08', N'Nghìn lẻ một đêm', 'NXB5', 'Antoine Galland', N'Truyện cổ tích', 70000,1997)
go

insert into tblKhachHang
values('KH01',N'Nguyen Duc Cuong',N'Hai Phong','0999123698'),
('KH02',N'Tran Van Duc',N'Thai Binh','0678345619'),
('KH03',N'Pham Thi Thu Trang',N'Nam Dinh','0989435432'),
('KH04',N'Nguyen Duc Tu',N'Ha Noi','0978090567'),
('KH05',N'Le Thu Hoai',N'Hai Duong','0385121768')



select * from tblHoaDon
alter table tblSach
add iNamXB int

go

select * from tblChiTietHD

--TẠO PROC 

	--hien chi tiet 1 hoa don  
create or alter proc prChitietHD (@mahd varchar(5) )
	as
		begin
		if exists (select * from tblHoaDon where sMaHD = @mahd)
		select  sMaHD , sTensach, iSl , iSl*fGia as N'Thanh tien'
		from tblChiTietHD, tblSach
		where tblChiTietHD.sMasach = tblSach.sMasach and sMaHD = @mahd
		else
		print'Ma hoa don khong ton tai'
	end
	
exec prChitietHD 'HD1'

	-- thêm mới hóa đơn cơ bản 
go
create or alter proc prthemhdcoban (@mahd varchar(5) , @manv varchar(5) , @makh varchar(5) , @ngaylap date,@trangthai bit)
	as
		begin 
			if not exists (select * from tblHoaDon where sMaHD = @mahd) 
				insert into tblHoaDon(sMaHD,sMaNV,sMaKH,dNgaylap,bTrangthai)
					values(@mahd, @manv, @makh, @ngaylap,@trangthai)
		
			else 
				print(N'Mã hóa đơn tồn tại')
				
		end
go
exec prthemhdcoban'HD4', 'NV03','KH05', '5/19/2023',0

	-- thêm mới thông tin chi tiết hóa đơn 
go
create or alter proc prThemCTHD (@mahd varchar(5) , @masach varchar(5) , @sl int  )
	as

		begin
			if  exists (select * from tblHoaDon where sMaHD = @mahd) 
				
					insert into tblChiTietHD(sMaHD,sMasach,iSl)
						values (@mahd, @masach, @sl)
				
			else 
				print(N'khong the thuc thi')
		end

exec prThemCTHD 'HD2', 'S03' , 7
select * from tblChiTietHD
go
	-- hien danh sach hoa don
create or alter proc prHiendsHD 
	as
		select tblHoaDon.sMaHD as 'Ma hoa don',dNgaylap as N'Ngày lập',sMaNV as N'Mã NV',tblHoaDon.sMaKH as N'Mã KH' ,sTenKH as 'Ten khach hang', 
		isnull(fTongtien,0) as Tongtien, 
		case bTrangthai when 1 then 'Da thanh toan'
		                else  'Chua thanh toan'
						end as Trangthai
		from tblHoaDon, tblKhachHang
		where  tblHoaDon.sMaKH = tblKhachHang.sMaKH 

exec prHiendsHD
go


create or alter view vv_HD
as
select tblHoaDon.sMaHD as 'Ma hoa don', sTenKH as 'Ten khach hang',isnull(fTongtien,0) as Tongtien, 
		case bTrangthai when 1 then 'Da thanh toan'
		                else  'Chua thanh toan'
						end as Trangthai
		from tblHoaDon, tblKhachHang
		where  tblHoaDon.sMaKH = tblKhachHang.sMaKH

select * from vv_HD

go
	-- xóa hóa đơn (xóa cả CTHĐ) 
create or alter proc prXoaHD (@mahd varchar(5))
as
	begin	
      if exists (select * from tblHoaDon where sMaHD = @mahd and bTrangthai = 1)   
	  begin
			 delete from tblChiTietHD
				    where sMaHD = @mahd
			delete from tblHoaDon
				    where sMaHD = @mahd
	 end
         else
		 print'Hoa don khong ton tai hoac chua thanh toan'
					
	end
go

exec prXoaHD 'HD6'

--tim kiem danh sach hoadon theo ngay thang nam,...
create or alter proc prtimkiemhoadon(@ngay int   , @thang int , @nam int , @tenkh nvarchar(60), @tensach nvarchar(60))
as
	begin
		select tblChiTietHD.sMaHD,dNgaylap, sTenKH ,sTensach,iSl, fGia, iSl*fGia as 'thanhtien'
		from tblHoaDon, tblChiTietHD, tblKhachHang, tblSach
		where tblHoaDon.sMaHD = tblChiTietHD.sMaHD 
		and tblHoaDon.sMaKH = tblKhachHang.sMaKH 
		and tblChiTietHD.sMasach = tblSach.sMasach
		and 
			DAY(dNgaylap) = 

				case 
				when @ngay = 0 then day(dNgaylap)
				else @ngay 
				end
			and
			
			month(dNgaylap) = 
				case when @thang = 0 then month(dNgaylap)
				else @thang 
				end
			and
			year(dNgaylap) = 
				case when @nam = 0 then year(dNgaylap)
				else @nam
				end
		and
			sTenKH like '%' +@tenkh + '%'
		and
			sTensach like '%' +@tensach+'%'
			
	end

	insert into tblChiTietHD values('HD1', 'S03',5)
exec prtimkiemhoadon 0,0,0, N'', 'Doraemon'

go
-- proc cập nhật thông tin của bảng hóa đơn cơ bản 
create or alter proc prCapnhatHDcb (@mahd varchar(5) , @manv varchar(5) , @makh varchar(5), @ngaylap date, @trangthai bit)
	as
	begin
	if exists (select * from tblHoaDon where sMaHD = @mahd )
		update tblHoaDon
		set sMaNV = @manv , sMaKH = @makh, dNgaylap = @ngaylap, bTrangthai = @trangthai where sMaHD = @mahd
		
	else
		print(N'Mã hóa đơn không tồn tại')

	end

	select * from tblHoaDon


	
	
go

-- tao proc cập nhật chi tiet hoa don  
create or alter proc prCapnhatchitiethd (@mahd varchar(5) , @masach varchar(5), @sl int )
as
begin
      if exists (select * from tblChiTietHD where sMaHD = @mahd )
	   update tblChiTietHD
	   set iSl = @sl, sMasach = @masach
	   where sMaHD = @mahd
	else
	print('Hoa don khong ton tai')
end

select * from tblChiTietHD
go



---trigger tính tổng tiền hóa đơn khi cập nhật, thêm,xóa chi tiết hóa đơn
create or alter trigger tongTienHD
on tblChiTietHD
after insert,update,delete
as
      update tblHoaDon
	  set fTongtien = (select sum(fGia*iSl)
	  from tblChiTietHD,tblSach
	  where tblHoaDon.sMaHD = tblChiTietHD.sMaHD and tblSach.sMasach = tblChiTietHD.sMasach)
	  

select sMaHD from tblHoaDon


----THÊM ĐÂY NÀY

----- hiện ds cthd
create or alter proc prHiendsCTHD 
	as
		select tblChiTietHD.sMaHD as 'Ma hoa don', tblChiTietHD.sMasach as 'Mã sách', iSl as 'Số lượng'
		from tblChiTietHD
	
exec prHiendsCTHD
go

create or alter proc prtimkiemHD(  @thang int , @nam int,@ma varchar(10) )
as
	begin
		select tblChiTietHD.sMaHD,tblNhanVien.sMaNV,sTenNV,tblNhanVien.sSDT,dNgaylap, sTenKH ,sTensach, fTongtien as 'thanhtien'
		from tblHoaDon, tblChiTietHD, tblKhachHang, tblSach,tblNhanVien
		where tblHoaDon.sMaHD = tblChiTietHD.sMaHD 
		and tblHoaDon.sMaKH = tblKhachHang.sMaKH 
		and tblChiTietHD.sMasach = tblSach.sMasach
		
		and tblNhanVien.sMaNV = @ma
		
		and 
			
			month(dNgaylap) = 
				case when @thang = 0 then month(dNgaylap)
				else @thang 
				end
			and
			year(dNgaylap) = 
				case when @nam = 0 then year(dNgaylap)
				else @nam
				end
		
	end

	exec prtimkiemHD 11, 2023, NV02



select* from tblHoaDon
select * from tblChiTietHD

----------------------------SÁCH----------------
create proc sp_themSach(
@tensach nvarchar(25),
@manxb varchar(5),@tacgia nvarchar(25),
@theloai nvarchar(30), @giatien float, @namxb int)
as
begin
		declare @masach varchar(5)				
		select @masach = CONCAT('S', CONVERT(varchar(5),COUNT(sMasach)+1)) from tblSach
		insert into tblSach 
		values(@masach,@tensach,@manxb,@tacgia,@theloai,@giatien,@namxb)		
end
exec sp_themSach  N'Nghìn lẻ một đêm', 'NXB5', 'Antoine Galland', N'Truyện cổ tích', 70000, 2003
go
create proc sp_SuaSach
(@masach varchar(5), @tensach nvarchar(25), 
@manxb varchar(5), @tacgia nvarchar(25), 
@theloai nvarchar(30),@gia float)
as
	begin
	if not exists (select sMasach from tblSach where sMasach=@masach)
		print N'Ma sach khong ton tai'
	else
		begin
			update tblSach
			set sTensach = @tensach,
			sMasach = @masach,
			sTacgia = @tacgia,
			sTheloai = @theloai,
			fGia = @gia			
			where sMasach = @masach
		end
	end
go
create proc sp_XoaSach(@masach varchar(5))
as
begin
	if not exists (select sMasach from tblSach where sMasach=@masach)
		print N'Khong co ma sach ban vua nhap'
	else
		delete tblSach where sMasach = @masach
end
go
create proc sp_timSach(@tensach nvarchar(25))
as
begin
	if not exists (select sTensach from tblSach where sTensach not like '%'+@tensach+'%')
		print N'Khong co sach nao!'
	else                   
		select sMasach as [Mã sách], sTensach as[Tên sách],sMaNXB as[Mã nhà xuất bản],
		sTacgia as[Tác giả], sTheloai as[Thể loại], fGia as[Giá tiền], 
		iNamXB as[Năm xuất bản] from tblSach where sTensach like '%'+ @tensach +'%'
end

create view vvSach
as

select sMasach as [Mã sách], sTensach as[Tên sách],sMaNXB as[Mã nhà xuất bản],sTacgia as[Tác giả], 
sTheloai as[Thể loại], fGia as[Giá tiền], iNamXB as[Năm xuất bản] from tblSach

select CONCAT('S', CONVERT(varchar(10),COUNT(sMasach)+1)) from tblSach

select * from tblSach


----------------KHÁCH HÀNG-------------
create or alter proc prCheck_dangnhap(@taikhoan varchar(20),@matkhau varchar(40))
	as
		begin
			if exists (select * from tblDangNhap where sTenTK=@taikhoan and sMatKhau = @matkhau)
				select 'Login Successful' as Status;
			else
				select 'Login Failed' as Status;
		end
go

create or alter proc DSKH
as
	begin
		select * from tblKhachHang
	end
go

--Them khach hang
create or alter proc prThemKH(@makh varchar(10), @tenkh nvarchar(60),@ngaysinh date,@gioitinh nvarchar(10), @diachi nvarchar(25), @sdt varchar(11))
	as
		begin 
			if not exists (select * from tblKhachHang where sMaKH = @makh)
				insert into tblKhachHang
					values(@makh, @tenkh,@ngaysinh,@gioitinh, @diachi, @sdt)
			else
				print(N'Mã khách hàng đã tồn tại')
				
		end
go

--Them dl proc
exec prThemKH 'KH06',N'Nguyễn Phương Anh','4-1-2001',N'Nữ',N'Hà Nội','0385980423'

create or alter proc prCapnhatKH (@makh varchar(10), @tenkh nvarchar(60),@ngaysinh date,@gioitinh nvarchar(10), @diachi nvarchar(25), @sdt varchar(11))
	as
	begin
	if exists (select * from tblKhachHang where sMaKH = @makh)
		update tblKhachHang
			set  sTenKH = @tenkh,dNgaySinh =@ngaysinh,sGioiTinh = @gioitinh, sDiachi=@diachi, sSDT = @sdt
				where sMaKH = @makh
	else
		print(N'Mã khách hàng không tồn tại')
		
	end
go
execute prCapnhatKH 'KH01',N'Phan Tấn Trung','4-1-2001',N'Nam',N'Đồng Tháp','0135498763'

--Xoa khach hang
create or alter proc prXoaKH(@makh varchar(10))
as
	begin
		if exists (select * from tblKhachHang where sMaKH = @makh)
			delete tblKhachHang
			where sMaKH=@makh
		else
			print(N'Mã khách hàng không tồn tại')
	end
go

--thu tuc tim kiem theo ma khach hang
create or alter proc prTimkiemtheoMaKH @makh nvarchar(10)
as
	begin
		select * from tblKhachHang
		where sMaKH=@makh
	end
go

execute prTimkiemtheoMaKH 'KH01'

--hien
CREATE OR ALTER PROC prHienKH
 AS
SELECT dbo.tblKhachHang.sMaKH AS 'Mã khách hàng', sTenKH AS 'Tên khách hàng',dNgaySinh AS 'Ngày sinh',sGioiTinh AS 'Giới tính', sDiachi AS 'Địa chỉ', sSDT AS 'Số điện thoại'
FROM dbo.tblKhachHang

EXEC prHienKH


--view
CREATE VIEW view_dskh
AS SELECT * FROM dbo.tblKhachHang

drop proc prTimkiemtheoMaKH

create or alter proc thongke_diachi
(@diachi nvarchar(50))
as
begin
	select * from tblKhachHang
	where sDiachi = @diachi
end

select * from dbo.tblKhachHang

create or alter proc thongke_ten
(@ten nvarchar(60))
as
begin
	select * from tblKhachHang
	where sTenKH like '%' + @ten ;
end

exec thongke_ten @ten =N'Tu';

-------------NXB-------------

create proc prThemNXB(@manxb varchar(5), @tennxb nvarchar(60), @diachi nvarchar(25), @sdt varchar(11))
as
	begin
		insert into tblNXB
		values(@manxb, @tennxb, @diachi, @sdt)
	end

select*from tblNXB 
go
create proc prSuaNXB(@manxb varchar(5), @tennxb nvarchar(60), @diachi nvarchar(25), @sdt varchar(11))
as
	begin
	if not exists (select sMaNXB from tblNXB where sMaNXB=@manxb)
		print N'Khong co nha xuat ban nay'
	else 
		update tblNXB
		set sTenNXB = @tennxb,
			sSDT = @sdt,
			sDiachi = @diachi
		where sMaNXB = @manxb
	end
go

create proc prXoaNXB(@manxb varchar(5))
as
	begin
		delete tblNXB
		where sMaNXB = @manxb
	end

go
create proc timkiem_theoma
@manxb varchar(5)
as
	begin
	if not exists (select sMaNXB from tblNXB where sMaNXB=@manxb)
		print N'Khong co nha xuat ban nay'
	else 
		select * from tblNXB where sMaNXB = @manxb
	end

create or alter proc timkiem_theoloaisach
@theloai nvarchar(30)
as
	begin
		select tblNXB.sMaNXB, sTenNXB, sTheloai 
		from tblNXB,tblSach
		where  tblNXB.sMaNXB =tblSach.sMaNXB
		and sTheloai  like  @theloai 
		
	end
exec timkiem_theoloaisach N'Truyện tranh'
create or alter proc hienloaisach
as 
begin
select  sTheloai 
from tblSach
end

create proc sapxep_theoMaNXB
as
	select*from tblNXB 
	order by sMaNXB
	desc
exec sapxep_theoMaNXB

create proc danhsachNXB
as
begin
	select*from tblNXB
end
select smanxb from tblNXB


-----------------------------------NHÂN VIÊN-------------
create proc prHienNV
as
	begin
		select * from tblNhanVien
	end
go


exec prHienNV
go

create proc prThemNV(@manv varchar(5), @tennv nvarchar(60), @ngaysinh date, @gioitinh nvarchar(4), @diachi nvarchar(25), @sdt varchar(11), @chucvu nvarchar(25))
as
	begin
		insert into tblNhanVien
		values(@manv,@tennv,@ngaysinh,@gioitinh,@diachi,@sdt,@chucvu)
	end
go

exec prThemNV 'NV06',N'Nguyen huu duc','2003/09/28',N'Nam',N'Ha Noi','0382127429','Giam Doc'
go

create proc prSuaNhanVien(@manv varchar(5), @tennv nvarchar(60), @ngaysinh date, @gioitinh nvarchar(4), @diachi nvarchar(25), @sdt varchar(11), @chucvu nvarchar(25))
as
	begin
		update tblNhanVien
		set sTenNV = @tennv,
			dNgaysinh = @ngaysinh,
			sGioitinh = @gioitinh,
			sQuequan = @diachi,
			sSDT = @sdt,
			sChucvu = @chucvu
		where sMaNV = @manv
	end
go


select * from tblNhanVien
go

create proc prXoaNhanVien(@manv varchar(5))
as
	begin
		delete tblNhanVien
		where sMaNV = @manv
	end
go

-- Thong ke nhan vien nghi huu
create or alter proc prThongKeNhanVienNghiHuu
as
begin
    select sMaNV as [Mã NV] ,sTenNV as[Tên Nhân Viên] ,sGioitinh as[Giới Tính], dNgaysinh as[Ngày Sinh],sQuequan as[Quê Quán] ,sSDT as [SDT] ,sChucvu as[Chức Vụ] 
	from tblNhanVien
	where (sGioitinh = 'Nam' and datediff(year,dNgaysinh , getdate()) > 60) or (sGioitinh = N'Nữ' and datediff(year,dNgaysinh , getdate()) > 55)

end
go
exec prThongKeNhanVienNghiHuu
go

--Tim kiem nhan vien
create or alter proc prTimkiemNV (@tukhoa nvarchar(30))
as
	begin
		select* from tblNhanVien
		where 
			lower(sTenNV) like '%' +lower(trim(@tukhoa)) + '%'
			or lower (sQuequan) like '%' +lower(trim(@tukhoa)) + '%'
			or lower (sSDT) like '%' + lower(trim(@tukhoa)) + '%'
		order by sTenNV asc 
	end


go

exec prTimkiemNV 'C'
UPDATE tblNhanVien
SET sChucvu = N'Nhân viên'
WHERE sMaNV = 'NV05';

select * from tblNhanVien

('NV01',N'Đỗ Trọng Ninh','2003/09/28',N'Nam',N'Thái Bình','0382127429','Admin'),
	('NV02',N'Nguyễn Đức Cường','2003/12/18',N'Nam',N'Bắc Ninh','0982127429',N'Nhân viên'),
	('NV03',N'Vũ Việt Anh','2003/12/18',N'Nam',N'Thái Bình','0782127429','Nhân viên'),
	('NV04',N'Lê Thu Hiền','2001/06/02',N'Nữ',N'Bình Dương','0482127429','Nhân viên'),
	('NV05',N'Bùi Thị Trang','2003/11/05',N'Nữ',N'Hà Nội','0582127429','Nhân viên')