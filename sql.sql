USE [NHOMWEB]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[MaGioHang] [int] IDENTITY(1,1) NOT NULL,
	[MaSP] [nvarchar](10) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaTien] [float] NOT NULL,
	[ThoiGian] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGioHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[SoHD] [nvarchar](10) NOT NULL,
	[NgayLapHoaDon] [date] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[MaKH] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[SoHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [varchar](20) NULL,
	[Email] [varchar](50) NOT NULL,
	[Matkhau] [nvarchar](50) NOT NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NOT NULL,
	[RoleUser] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSP]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSP](
	[MaLSP] [nvarchar](10) NOT NULL,
	[TenLSP] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [nvarchar](10) NOT NULL,
	[TenNCC] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Admin] [bit] NULL,
	[AnhNV] [varchar](100) NULL,
	[GioiTinh] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [nvarchar](10) NOT NULL,
	[TenSP] [nvarchar](100) NULL,
	[AnhSP] [varchar](100) NULL,
	[MaLSP] [nvarchar](10) NULL,
	[MaNCC] [nvarchar](10) NULL,
	[DonGia] [decimal](10, 2) NOT NULL,
	[MoTaSP] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NhanVien] ADD  DEFAULT ((0)) FOR [GioiTinh]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaLSP])
REFERENCES [dbo].[LoaiSP] ([MaLSP])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaLSP])
REFERENCES [dbo].[LoaiSP] ([MaLSP])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaLSP])
REFERENCES [dbo].[LoaiSP] ([MaLSP])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO

/*Dữ liệu*/

INSERT INTO GioHang (MaGioHang,MaSP, SoLuong, GiaTien, ThoiGian)
VALUES
  (1,'SP001', 2, 1000000, '2023-05-07 10:30:00'),
  (2,'SP002', 1, 5000000, '2023-05-08 14:45:00'),
  (3,'SP003', 3, 200000, '2023-05-09 08:00:00'),
  (4,'SP004', 5, 3000000, '2023-05-10 12:00:00'),
  (5,'SP005', 4, 1500000, '2023-05-11 15:30:00'),
  (6,'SP006', 2, 1200000, '2023-05-12 09:00:00'),
  (7,'SP007', 1, 800000, '2023-05-13 11:30:00'),
  (8,'SP008', 6, 4500000, '2023-05-14 16:00:00'),
  (9,'SP009', 3, 250000, '2023-05-15 08:15:00'),
  (10,'SP010', 2, 900000, '2023-05-16 13:45:00');


INSERT INTO HoaDon (SoHD, NgayLapHoaDon, TrangThai, MaKH)
VALUES ('HD001', '2023-05-01', N'Đã giao hàng', 'KH001'),
       ('HD002', '2023-05-02',  N'Đang xử lý', 'KH002'),
       ('HD003', '2023-05-03',  N'Chưa xác định', 'KH003'),
       ('HD004', '2023-05-04', N'Chưa xác định', 'KH004'),
       ('HD005', '2023-05-03', N'Chưa xác định', 'KH005'),
       ('HD006', '2023-03-04', N'Chưa xác định', 'KH006'),
	   ('HD007', '2023-05-02', N'Đang xử lý', 'KH007'),
       ('HD008', '2023-07-03', N'Chưa xác định', 'KH008'),
       ('HD009', '2023-09-04', N'Chưa xác định', 'KH009'),
       ('HD010', '2023-02-04', N'Chưa xác định', 'KH010');

INSERT INTO KhachHang (MaKH, HoTen, DiaChi, SDT, Email, GioiTinh,Ngaysinh,Matkhau)
VALUES
    ('KH001', N'Đặng Văn Hải', N'Hà Nội', '0987654321', 'dangvanhai@gmail.com',1,'1990-02-01','password123'),
    ('KH002', N'Ngô Trung Kiên', N'Hồ Chí Minh', '0234567894', 'ngotrungkien@gmail.com',1,'1999-11-01','password345'),
    ('KH003', N'Phan Minh Tiến', N'Đà Nẵng', '0975312468', 'phanminhtien@gmail.com',1,'1995-05-02','password456'),
	('KH004', N'Nguyễn Thị Diễm Kiều', N'Đà Nẵng', '0987654321', 'nguyenthidiemkieu@gmail.com',0,'2000-01-01','password678'),
	('KH005', N'Nguyen Van Huy', N'Huế', '0909090909', 'nguyenvane@gmail.com',1,'2001-03-09','password890'),
	('KH006', N'Phùng Thị Phượng', N'Ninh Hòa', '0986668321', 'ptphuong@gmail.com',0,'2002-01-08','passwordabc'),
    ('KH007', N'Trương KHánh Hòa', N'Hồ Chí Minh', '0123456449', 'truongkhanhhoa@gmail.com',1,'2002-01-01','passworddef'),
    ('KH008', N'Nguyễn Thành Đạt', N'Đà Nẵng', '0972222468', 'phanminhtien@gmail.com',1,'2005-08-09','passwordugh'),
	('KH009', N'Trần Ngọc Tiến', N'Đà Nẵng', '0987651111', 'tntien@gmail.com',1,'1990-07-03','passwordkil'),
	('KH010', N'Huỳnh Thanh Hiền', N'Huế', '0909092222', 'hthien@gmail.com',1,'2003-02-04','passwordert');



INSERT INTO NhaCungCap (MaNCC, TenNCC) 
VALUES ('NCC001', 'Asus'),
		('NCC002', 'Dell'),
		('NCC003', 'HP'),
		('NCC004', 'Lenovo'),
		('NCC005', 'Acer'),
		('NCC006', 'Apple'),
		('NCC007', 'MSI'),
		('NCC008', 'MIK'),
		('NCC009', 'Samsung'),
		('NCC010', 'Colorful');

INSERT INTO NhanVien (MaNV, HoTen, GioiTinh,NgaySinh, Email, Admin, AnhNV)
VALUES ('NV001', N'Nguyễn Văn Hải', 1,'2002-02-01', 'dangvanhai@gmail.com', 1,'nv_a.jpg'),
       ('NV002', N'Lê Thị Mỹ Kiều', 0, '2000-03-01', 'nguyenthidiemkieu@gmail.com', 0,'tt_b.jpg'),
       ('NV003', N'Lê Hoàng Thiện',1,'2000-04-02', 'phanminhtien@gmail.com', 0, 'lm_c.jpg'),
	   ('NV004', N'Nguyễn Duy Thiên', 1,'2001-12-01',  'ngotrungkien@gmail.com', 1,'pt_d.jpg'),
	   ('NV005', N'Võ Văn Quý', 1, '2002-06-01','vovane@gmail.com', 0, 'vv_e.jpg'),
       ('NV006', N'Đặng Thị Thương',0,'2005-01-02', 'dangthif@gmail.com', 0, 'dt_f.jpg'),
	   ('NV007', N'Phan Minh Tiến', 1,'2000-08-03', 'phanminhtien@gmail.com', 0, 'lm_c.jpg'),
	   ('NV008', N'Ngô Trung Kiên', 1,'2002-02-09', 'ngotrungkien@gmail.com', 1, 'pt_d.jpg'),
	   ('NV009', N'Võ Văn Quý', 1,'2001-05-07', 'vovane@gmail.com',0, 'vv_e.jpg'),
       ('NV010', N'Đặng Thị Thương',0,'2001-03-01', 'dangthif@gmail.com',0, 'dt_f.jpg');
select *from NhanVien

INSERT INTO LoaiSP (MaLSP, TenLSP)
VALUES ('LSP001', N'Laptop'),
       ('LSP002', N'PC'),
       ('LSP003', N'Màn hình'),
       ('LSP004', N'Bàn phím'),
       ('LSP005', N'Chuột'),
       ('LSP006', N'Tai nghe'),
	   ('LSP007', N'Ổ cứng'),
       ('LSP008', N'Case'),
       ('LSP009', N'Ram'),
       ('LSP010', N'PSU');
ALTER TABLE SanPham 
add MoTaSP nvarchar(1000) null;


	   update SanPham set MoTaSP =N'Laptop cao cấp của hãng Dell' where MaSP = 'SP001';

INSERT INTO SanPham (MaSP, TenSP, AnhSP, MoTaSP, MaLSP, MaNCC, DonGia)
VALUES ('SP001', N'Laptop Dell Inspiron 15', 'LaptopDell_Inspiron15.jpg', N'Laptop cao cấp của hãng Dell', 'LSP001', 'NCC001', 15000000),
		('SP002', N'Laptop HP Envy x360', 'Laptop_HP_Envy_x30.jpg', N'Laptop 2 trong 1 có khả năng xoay gập màn hình', 'LSP001', 'NCC002', 20000000),
		('SP003', N'Màn hình Dell Ultrasharp', 'Manhinh_Dell_Ultrasharp.jpg', N'Màn hình máy tính chất lượng cao của hãng Dell', 'LSP003', 'NCC001', 5000000),
		('SP004', N'Bàn phím cơ Corsair K95 RGB Platinum', 'BPC_Corsair_K95_RGB_Platinum.jpg', N'Bàn phím cơ chất lượng cao dành cho game thủ', 'LSP004', 'NCC003', 3000000),
		('SP005', N'Chuột Logitech G Pro Wireless', 'Chuot_Logitech_G_Pro_Wireless.jpg', N'Chuột không dây chuyên dụng dành cho game thủ', 'LSP005', 'NCC002', 2500000),
		('SP006', N'Ổ cứng SSD Samsung 970 EVO Plus', 'Ocung_SSD_Samsung_970_EVO_Plus.jpg', N'Ổ cứng SSD NVMe nhanh và đáng tin cậy của hãng Samsung', 'LSP007', 'NCC009', 3500000),
		('SP007', N'RAM ADATA XPG SPECTRIX D41 8GB DDR4 RGB 3000MHz – AX4U300038G16A-SR41', 'RAMa_ADATA_XPG_SPECTRIX_D41_8GB_DDR4_RGB_3000MHz_AX4U30038G16A-SR41.jpg', N'RAM ADATA XPG SPECTRIX ', 'LSP009', 'NCC009', 20000000),
		('SP008', N'VGA MSI GeForce RTX 4090 SUPRIM X 24G', 'VGA_MSI_GeForce RTX_4090_SUPRIM_X_24G.jpg', N'hỗ trợ bởi kiến ​​trúc NVIDIA Ada Lovelace và đi kèm với bộ nhớ G6X 24 GB ', 'LSP002', 'NCC001', 5000000),
		('SP009', N'Nguồn MSI MAG A550BN 550W', 'Nguon_MSI_MAG_A550BN_550W.jpg', N'Thiết kế mạch DC sang DC', 'LSP010', 'NCC007', 3000000),
		('SP010', N'Case MIK LV07 Black', 'CaseMIKLV07Black.jpg', N'2 mặt kính cường lực cao cấp show toàn bộ nội thất trong case', 'LSP008', 'NCC007', 2500000),
		('SP011', N'Màn hình HP M22F 21.5 inch FHD 2E2Y3AA', 'Man_hinh_HP.jpg', N'Màn hình Laptop hãng HP', 'LSP003', 'NCC003', 3790000),
		('SP012', N'Bàn phím giả cơ gaming YINDIAO K600', 'BPC_K600.jpg', N'Bàn phím giả cơ gaming YINDIAO K600 Nút tròn, Led đa màu, Keycaps cực đẹp', 'LSP004', 'NCC003', 2750000),
		('SP013', N'Chuột Có Dây Dell MS116', 'Chuot_dell_ms116_02.jpg', N'Chuột Có Dây Dell MS116 - Thiết kế thuận tay điều hướng nhanh chóng', 'LSP005', 'NCC002', 3500000),
		('SP014', N'Ổ cứng SSD', 'O_Cung_SSD.jpg', N'Ổ cứng SSD Thiết kế đẹp mắt', 'LSP007', 'NCC002', 4500000),
		('SP015', N'RAM DDR4', 'Ram_DDR4.jpg', N'RAM DDR4 Laptop Samsung 8GB bus 3200Mhz', 'LSP009', 'NCC009', 3500000),
		('SP016', N'VGA Asus Dual GeForce RTX 4070 OC Edition 12GB', 'VGA_Asus_Dual_GeForce_RTX_4070_OC_Edition_12GB.jpg', N'VGA Asus Dual GeForce RTX 4070 OC Edition 12GB GDDR6X DUAL-RTX4070-O12G', 'LSP002', 'NCC001', 3500000),
		('SP017', N'Dell Optiplex 7020 9020 Precision T1700 365W Power Supply HU365EM-00 7VK45
', 'Nguon.jpg', N'Dell Optiplex 7020 9020 Precision T1700 365W Power Supply HU365EM-00 7VK45
', 'LSP010', 'NCC002', 3500000),
		('SP018', N'Case Đồng Bộ HP 600G2 (i3 6100/Ram 4G/SSD 256GB)', 'Case_HP.jpg', N'Tiết kiệm năng lượng, sử dụng bộ nguồn 200W active PFC.', 'LSP008', 'NCC003', 3500000);


/****** Object:  StoredProcedure [dbo].[TimKiem]    Script Date: 5/11/2023 9:33:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TimKiem]
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Tìm kiếm trong bảng KhachHang
    SELECT * FROM KhachHang 
    WHERE HoTen LIKE '%' + @TuKhoa + '%' OR DiaChi LIKE '%' + @TuKhoa + '%' OR SDT LIKE '%' + @TuKhoa + '%' OR Email LIKE '%' + @TuKhoa + '%';
    
    -- Tìm kiếm trong bảng HoaDon
    SELECT * FROM HoaDon 
    WHERE TrangThai LIKE '%' + @TuKhoa + '%';
    
    -- Tìm kiếm trong bảng NhanVien
    SELECT * FROM NhanVien 
    WHERE HoTen LIKE '%' + @TuKhoa + '%' OR GioiTinh LIKE '%' + @TuKhoa + '%' OR Email LIKE '%' + @TuKhoa + '%';
    
    -- Tìm kiếm trong bảng SanPham
    SELECT * FROM SanPham 
    WHERE TenSP LIKE '%' + @TuKhoa + '%' OR MoTaSP LIKE '%' + @TuKhoa + '%';
    
    -- Tìm kiếm trong bảng LoaiSP
    SELECT * FROM LoaiSP 
    WHERE TenLSP LIKE '%' + @TuKhoa + '%';
    
    -- Tìm kiếm trong bảng NhaCungCap
    SELECT * FROM NhaCungCap 
    WHERE TenNCC LIKE '%' + @TuKhoa + '%';
END

SELECT * FROM NhaCungCap
GO
