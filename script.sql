CREATE DATABASE [NHOMWEB]
USE [NHOMWEB]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 5/7/2023 8:38:55 AM ******/
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
/****** Object:  Table [dbo].[HoaDon]    Script Date: 5/7/2023 8:38:55 AM ******/
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
/****** Object:  Table [dbo].[KhachHang]    Script Date: 5/7/2023 8:38:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SDT] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[Matkhau] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSP]    Script Date: 5/7/2023 8:38:55 AM ******/
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
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 5/7/2023 8:38:55 AM ******/
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
/****** Object:  Table [dbo].[NhanVien]    Script Date: 5/7/2023 8:38:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](10) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[Email] [varchar](50) NULL,
	[Admin] [bit] NULL,
	[AnhNV] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 5/7/2023 8:38:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [nvarchar](10) NOT NULL,
	[TenSP] [nvarchar](50) NULL,
	[AnhSP] [varchar](100) NULL,
	[MoTaSP] [text] NULL,
	[MaLSP] [nvarchar](10) NULL,
	[MaNCC] [nvarchar](10) NULL,
	[DonGia] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaLSP])
REFERENCES [dbo].[LoaiSP] ([MaLSP])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
/****** Object:  StoredProcedure [dbo].[TimKiem]    Script Date: 5/7/2023 8:38:55 AM ******/
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
