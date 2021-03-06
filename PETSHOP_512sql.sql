USE [PETSHOP]
GO
/****** Object:  Table [dbo].[CHITIET_HOADON]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIET_HOADON](
	[MACT] [int] IDENTITY(1,1) NOT NULL,
	[MAHD] [int] NOT NULL,
	[MASP] [int] NOT NULL,
	[SOLUONG] [int] NOT NULL,
	[GHICHU] [text] NULL,
 CONSTRAINT [PK_CHITIET_HOADON] PRIMARY KEY CLUSTERED 
(
	[MACT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GIOHANG]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIOHANG](
	[MAGH] [int] IDENTITY(1,1) NOT NULL,
	[MAKH] [int] NOT NULL,
	[MASP] [int] NOT NULL,
	[SOLUONG] [int] NOT NULL,
 CONSTRAINT [PK_GIOHANG] PRIMARY KEY CLUSTERED 
(
	[MAGH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADON](
	[MAHD] [int] IDENTITY(1,1) NOT NULL,
	[NGAYLAP] [datetime] NOT NULL,
	[MAKH] [int] NOT NULL,
	[MANV] [int] NULL,
	[TONGTIEN] [money] NOT NULL,
	[XACNHAN] [bit] NOT NULL,
 CONSTRAINT [PK_HOADON] PRIMARY KEY CLUSTERED 
(
	[MAHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MAKH] [int] IDENTITY(1,1) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[SDT] [varchar](10) NOT NULL,
	[DIACHI] [nvarchar](100) NOT NULL,
	[EMAIL] [varchar](50) NULL,
	[TENDANGNHAP] [varchar](40) NULL,
 CONSTRAINT [PK_KHACHHANG] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[MANV] [int] IDENTITY(1,1) NOT NULL,
	[HOTEN] [nvarchar](50) NOT NULL,
	[CMND] [varchar](12) NOT NULL,
	[GIOITINH] [nchar](3) NULL CONSTRAINT [DF_NHANVIEN_GIOITINH]  DEFAULT ('Nam'),
	[DIACHI] [nvarchar](100) NOT NULL,
	[NGAYSINH] [date] NOT NULL,
	[SDT] [varchar](10) NOT NULL,
	[EMAIL] [varchar](50) NULL,
	[TENDANGNHAP] [varchar](40) NULL,
 CONSTRAINT [PK_NHANVIEN] PRIMARY KEY CLUSTERED 
(
	[MANV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHOMSANPHAM]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHOMSANPHAM](
	[MANHOMSP] [int] IDENTITY(1,1) NOT NULL,
	[TENNHOMSP] [nvarchar](50) NOT NULL,
	[VATNUOI] [nchar](3) NOT NULL,
 CONSTRAINT [PK_NHOMSANPHAM] PRIMARY KEY CLUSTERED 
(
	[MANHOMSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SANPHAM]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SANPHAM](
	[MASP] [int] IDENTITY(1,1) NOT NULL,
	[TENSP] [nvarchar](100) NOT NULL,
	[GIA] [money] NOT NULL,
	[MOTA] [nvarchar](max) NULL,
	[THUONGHIEU] [nvarchar](50) NULL DEFAULT ('Ðang c?p nh?t...'),
	[TINHTRANG] [bit] NULL CONSTRAINT [DF_SANPHAM_TINHTRANG]  DEFAULT ('TRUE'),
	[MANHOMSP] [int] NOT NULL,
	[HINHANH] [varchar](max) NULL,
 CONSTRAINT [PK_SANPHAM] PRIMARY KEY CLUSTERED 
(
	[MASP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TAIKHOAN]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAIKHOAN](
	[TENDANGNHAP] [varchar](40) NOT NULL,
	[MATKHAU] [varchar](50) NOT NULL,
	[TRANGTHAI] [bit] NOT NULL CONSTRAINT [DF_TAIKHOAN_TRANGTHAI]  DEFAULT ('TRUE'),
	[VAITRO] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TAIKHOAN] PRIMARY KEY CLUSTERED 
(
	[TENDANGNHAP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TINTUC]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TINTUC](
	[MATT] [int] IDENTITY(1,1) NOT NULL,
	[TUADE] [nvarchar](500) NOT NULL,
	[HINHANH] [varchar](max) NULL,
	[NOIDUNG] [nvarchar](max) NOT NULL,
	[VATNUOI] [nchar](3) NOT NULL,
	[NGAYDANG] [datetime] NOT NULL,
	[MANV] [int] NOT NULL,
 CONSTRAINT [PK_TINTUC] PRIMARY KEY CLUSTERED 
(
	[MATT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[YEUTHICH]    Script Date: 05-Dec-21 13:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YEUTHICH](
	[MASP] [int] NOT NULL,
	[MAKH] [int] NOT NULL,
 CONSTRAINT [PK_YEUTHICH] PRIMARY KEY CLUSTERED 
(
	[MASP] ASC,
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[CHITIET_HOADON] ON 

INSERT [dbo].[CHITIET_HOADON] ([MACT], [MAHD], [MASP], [SOLUONG], [GHICHU]) VALUES (15, 1, 3, 1, N'')
INSERT [dbo].[CHITIET_HOADON] ([MACT], [MAHD], [MASP], [SOLUONG], [GHICHU]) VALUES (16, 1, 1, 2, N'')
INSERT [dbo].[CHITIET_HOADON] ([MACT], [MAHD], [MASP], [SOLUONG], [GHICHU]) VALUES (17, 1, 4, 1, N'')
INSERT [dbo].[CHITIET_HOADON] ([MACT], [MAHD], [MASP], [SOLUONG], [GHICHU]) VALUES (18, 2, 4, 1, N'')
INSERT [dbo].[CHITIET_HOADON] ([MACT], [MAHD], [MASP], [SOLUONG], [GHICHU]) VALUES (19, 2, 3, 1, N'')
INSERT [dbo].[CHITIET_HOADON] ([MACT], [MAHD], [MASP], [SOLUONG], [GHICHU]) VALUES (20, 2, 19, 2, N'')
SET IDENTITY_INSERT [dbo].[CHITIET_HOADON] OFF
SET IDENTITY_INSERT [dbo].[GIOHANG] ON 

INSERT [dbo].[GIOHANG] ([MAGH], [MAKH], [MASP], [SOLUONG]) VALUES (14, 2, 3, 1)
SET IDENTITY_INSERT [dbo].[GIOHANG] OFF
SET IDENTITY_INSERT [dbo].[HOADON] ON 

INSERT [dbo].[HOADON] ([MAHD], [NGAYLAP], [MAKH], [MANV], [TONGTIEN], [XACNHAN]) VALUES (1, CAST(N'2021-12-01 21:38:33.740' AS DateTime), 2, 3, 1560000.0000, 1)
INSERT [dbo].[HOADON] ([MAHD], [NGAYLAP], [MAKH], [MANV], [TONGTIEN], [XACNHAN]) VALUES (2, CAST(N'2021-12-05 10:31:53.340' AS DateTime), 2, 1, 1930000.0000, 1)
SET IDENTITY_INSERT [dbo].[HOADON] OFF
SET IDENTITY_INSERT [dbo].[KHACHHANG] ON 

INSERT [dbo].[KHACHHANG] ([MAKH], [TENKH], [SDT], [DIACHI], [EMAIL], [TENDANGNHAP]) VALUES (2, N'Vũ Ngân Yên', N'0123456789', N'90 Nguyễn Duy Trinh', N'yenkhum@gmail.com', N'yennnnn')
INSERT [dbo].[KHACHHANG] ([MAKH], [TENKH], [SDT], [DIACHI], [EMAIL], [TENDANGNHAP]) VALUES (9, N'Lưu', N'0979582514', N'97 Man Thiện', N'dungluu568847@gmail.com', N'dung2000')
SET IDENTITY_INSERT [dbo].[KHACHHANG] OFF
SET IDENTITY_INSERT [dbo].[NHANVIEN] ON 

INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [CMND], [GIOITINH], [DIACHI], [NGAYSINH], [SDT], [EMAIL], [TENDANGNHAP]) VALUES (1, N'Châu Văn Hậu', N'072200006235', N'Nam', N'Thủ Đức', CAST(N'2004-12-28' AS Date), N'0389882924', N'vanhau293@gmail.com', N'cvanhau')
INSERT [dbo].[NHANVIEN] ([MANV], [HOTEN], [CMND], [GIOITINH], [DIACHI], [NGAYSINH], [SDT], [EMAIL], [TENDANGNHAP]) VALUES (3, N'Yên', N'123456789', N'Nam', N'Thủ đức', CAST(N'2000-01-01' AS Date), N'012345678', NULL, N'yenkhum')
SET IDENTITY_INSERT [dbo].[NHANVIEN] OFF
SET IDENTITY_INSERT [dbo].[NHOMSANPHAM] ON 

INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (1, N'Thức ăn cho chó', N'Chó')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (2, N'Sữa tắm cho chó', N'Chó')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (3, N'Phụ kiện cho chó', N'Chó')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (4, N'Đồ dùng cho chó', N'Chó')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (5, N'Quần áo cho chó', N'Chó')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (6, N'Y tế & Thuốc cho chó', N'Chó')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (7, N'Thức ăn cho mèo', N'Mèo')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (8, N'Sữa tắm cho mèo', N'Mèo')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (9, N'Cát vệ sinh cho mèo', N'Mèo')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (10, N'Đồ dùng cho mèo', N'Mèo')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (11, N'Phụ kiện cho mèo', N'Mèo')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (12, N'Quần áo cho mèo', N'Mèo')
INSERT [dbo].[NHOMSANPHAM] ([MANHOMSP], [TENNHOMSP], [VATNUOI]) VALUES (13, N'Y tế & Thuốc cho mèo', N'Mèo')
SET IDENTITY_INSERT [dbo].[NHOMSANPHAM] OFF
SET IDENTITY_INSERT [dbo].[SANPHAM] ON 

INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (1, N'Thức ăn khô cho chó vị bò nướng', 94000.0000, N'Ngon tuyệt', N'SmartHeart', 1, 1, N'resources/images/sanpham/211025123035-thucanuotcho2.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (2, N'Thức ăn khô vị gà, trứng, sữa', 122000.0000, N'Ngon ghê', N'Pedigree', 1, 1, N'resources/images/sanpham/211025123055-thucanchokhoden.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (3, N'Thức Ăn Khô Cho Chó Con SmartHeart Power Pack', 1250000.0000, N'Yummy', N'SmartHeart', 1, 1, N'resources/images/sanpham/211025123120-snackcho2.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (4, N'Dầu Gội Trị Ve Cho Thú Cưng Budle Budle', 180000.0000, N'Sạch', N'Budle''Budle ', 1, 2, N'resources/images/sanpham/211025122902-thuoc-tri-ghe-nam-ngoai-da-cho.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (5, N'Sữa Tắm Hantox Trị Ve Rận Cho Thú Cưng', 45000.0000, N'Sạch hơn', N'Hantox', 1, 2, N'resources/images/sanpham/211025122919-suatamcho1.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (6, N'Vòng Cổ Policedog 2cm', 45000.0000, N'Đẹp', N'Policedog', 1, 3, N'resources/images/sanpham/211031191022-phukien.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (7, N'Áo Vest bò Cowboy kèm dây dắt cho chó mèo', 130000.0000, N'Đẹp lắm', N'Đang cập nhật', 1, 3, N'resources/images/sanpham/211025122746-quanao.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (8, N'Viên Bổ Sung Canxi - Phốt Pho PetAg Cho Chó Mèo', 250000.0000, N'Tốt', N'PetAg', 1, 6, N'resources/images/sanpham/211025123307-thuocmeo.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (9, N'Thuốc Bổ Sung Dinh Dưỡng Vitamin - Bio Vit Plus', 10000.0000, N'', N'Bio', 1, 6, N'resources/images/sanpham/211025123331-thuocmeo4.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (10, N'Canxi Nano - Chống Hạ Bàn, Cụp Tai Chó Con', 240000.0000, N'', N'Công ty TNHH DVTM Quốc tế Việt Đức', 1, 6, N'resources/images/sanpham/211025123356-thuocmeo3.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (11, N'Bát Ăn Cho Chó Mèo - Bát Đôi Hình Ếch Hai Ngăn', 65000.0000, N'', N'Đang cập nhật...', 1, 4, N'resources/images/sanpham/211025122716-dodung.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (12, N'Ba Lô Trong Suốt Vận Chuyển Chó Mèo Loại Đẹp', 370000.0000, N'', N'Đang cập nhật', 1, 4, N'resources/images/sanpham/211025122633-balomeo1.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (13, N'Áo Mùa Hè Teddy Mỏ Vịt Cho Chó Mèo', 75000.0000, N'', N'Đang cập nhật', 1, 5, N'resources/images/sanpham/211025122808-quanao2.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (14, N'Áo Phao Azibebe Happy Smile Xanh Navy Size Nhỏ', 240000.0000, N'', N'Đang cập nhật', 1, 5, N'resources/images/sanpham/211025122833-quanao.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (15, N'Gà sấy khô cho mèo Tellme 40gr', 50000.0000, N'', N'Tellme', 1, 7, N'resources/images/sanpham/211025123209-thucan3.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (16, N'Thức ăn hạt dành cho mèo mẹ và mèo con', 99000.0000, N'', N'Royal Canin', 1, 7, N'resources/images/sanpham/211025123235-thucan1.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (17, N'Gel Kem Ăn Dinh Dưỡng Virbac Nutri Plus', 185000.0000, N'', N'Virbac', 1, 13, N'resources/images/sanpham/211205132154-thuocmeo1.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (18, N'Cát Vệ Sinh Catlike Hương Chanh', 110000.0000, N'', N'Catlike', 1, 9, N'resources/images/sanpham/211025122156-catmeo1.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (19, N'Sữa tắm khô yú cho chó mèo 145ml', 250000.0000, N'', N'Yus', 1, 8, N'resources/images/sanpham/211025122941-suatamcho2.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (20, N'Cát Vệ Sinh Catlike Hương Chanh', 80000.0000, N'Thơm, không vón cục', N'Catlike', 1, 9, N'resources/images/sanpham/211205105808-catmeo2.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (21, N'Bát Nhựa Đôi Cấp Nước Cho Chó Mèo', 50000.0000, N'Đẹp, giúp ăn ngon miệng', N'hihi', 1, 4, N'resources/images/sanpham/211205110419-dodung.jpg')
INSERT [dbo].[SANPHAM] ([MASP], [TENSP], [GIA], [MOTA], [THUONGHIEU], [TINHTRANG], [MANHOMSP], [HINHANH]) VALUES (23, N'Thau vệ sinh cho mèo', 60000.0000, N'Sạch sẽ', N'', 1, 10, N'resources/images/sanpham/211205112107-khay-di-ve-sinh-cho-cho-3.jpg')
SET IDENTITY_INSERT [dbo].[SANPHAM] OFF
INSERT [dbo].[TAIKHOAN] ([TENDANGNHAP], [MATKHAU], [TRANGTHAI], [VAITRO]) VALUES (N'cvanhau', N'12345678', 1, N'ADMIN     ')
INSERT [dbo].[TAIKHOAN] ([TENDANGNHAP], [MATKHAU], [TRANGTHAI], [VAITRO]) VALUES (N'dung2000', N'12345678', 1, N'Khách hàng')
INSERT [dbo].[TAIKHOAN] ([TENDANGNHAP], [MATKHAU], [TRANGTHAI], [VAITRO]) VALUES (N'yenkhum', N'23456789', 1, N'ADMIN     ')
INSERT [dbo].[TAIKHOAN] ([TENDANGNHAP], [MATKHAU], [TRANGTHAI], [VAITRO]) VALUES (N'yennnnn', N'12345678', 1, N'Khách hàng')
SET IDENTITY_INSERT [dbo].[TINTUC] ON 

INSERT [dbo].[TINTUC] ([MATT], [TUADE], [HINHANH], [NOIDUNG], [VATNUOI], [NGAYDANG], [MANV]) VALUES (1, N' Biến thức ăn khô của chó mèo trở nên hấp dẫn và ngon miệng hơn', N'resources/images/sanpham/211204164650-Capture.PNG', N'<p>Ng&agrave;y nay, do bận bịu với c&ocirc;ng việc n&ecirc;n c&aacute;c Sen thường cho ch&oacute; v&agrave; m&egrave;o của m&igrave;nh ăn thức ăn kh&ocirc; cho nhanh v&agrave; tiện. Kh&ocirc;ng phủ nhận những đặc t&iacute;nh tốt của thức ăn kh&ocirc; như: Nhanh, bảo quản dễ, đảm bảo chất dinh dưỡng... ngo&agrave;i ra thức ăn kh&ocirc; c&ograve;n gi&uacute;p răng miệng của những ch&uacute; ch&oacute; v&agrave; m&egrave;o sạch sẽ hơn. Tuy nhi&ecirc;n, do c&aacute;c bạn kh&ocirc;ng để &yacute; thay đổi thức ăn, hoặc biến tấu thức ăn kh&ocirc; cho hấp dẫn n&ecirc;n l&agrave;m cho th&uacute; cưng của m&igrave;nh ch&aacute;n hoặc kh&ocirc;ng h&agrave;o hứng với thức ăn kh&ocirc; đơn điệu.<br />
Sau đ&acirc;y l&agrave; một số c&aacute;ch để khiến thức ăn kh&ocirc; của ch&oacute; m&egrave;o trở n&ecirc;n hấp dẫn v&agrave; gi&agrave;u dinh dưỡng:<br />
+ Bạn n&ecirc;n tưới th&ecirc;m một ch&uacute;t nước ấm v&agrave;o thức ăn kh&ocirc; cho ch&oacute; m&egrave;o (Tốt hơn bạn c&oacute; thể nấu nước d&ugrave;ng như nước g&agrave;, rồi cho v&agrave;o lọ thủy tinh để v&agrave;o tủ lạnh sau ta d&ugrave;ng dần, nhớ h&acirc;m n&oacute;ng trước khi d&ugrave;ng).<br />
+ Kết hợp c&ugrave;ng với thức ăn ướt.<br />
+ Th&ecirc;m c&aacute;c loại rau củ quả, trứng l&ecirc;n thức ăn kh&ocirc;.<br />
+ Để hỗ trợ cho đường ruột của th&uacute; cưng, bạn c&oacute; thể chộn th&ecirc;m cả sữa chua trắng v&agrave;o thức ăn cho ch&uacute;ng (Lưu &yacute; nếu ch&ugrave;ng kh&ocirc;ng dung nạp sữa chua, dẫn đến bị ti&ecirc;u chảy ch&uacute;ng ta hay tạm dừng cho ch&uacute;ng ăn).</p>

<p>Lưu &yacute;: Nhiều khi ch&oacute; m&egrave;o của bạn bỏ ăn kh&ocirc;ng phải do thức ăn của bạn kh&ocirc;ng hấp dẫn, c&oacute; thể ch&uacute;ng cần được đi kh&aacute;m nếu c&oacute; c&aacute;c biểu hiện kh&aacute;c thường kh&aacute;c k&egrave;m theo.</p>
', N'Chó', CAST(N'2021-12-04 16:46:53.143' AS DateTime), 1)
INSERT [dbo].[TINTUC] ([MATT], [TUADE], [HINHANH], [NOIDUNG], [VATNUOI], [NGAYDANG], [MANV]) VALUES (2, N'Cách dùng gel dinh dưỡng đơn giản nhất quả đất !!', N'resources/images/sanpham/211204165642-Capture2.PNG', N'<p>Gần đ&acirc;y, gel dinh dưỡng cho th&uacute; cưng đang được nhiều &quot;sen&quot; chọn cho &quot;boss&quot; sử dụng. T&aacute;c dụng của gel dinh dưỡng chắc hẳn mọi người đều biết. Tuy nhi&ecirc;n, nhiều người lại đang cho ch&oacute; m&egrave;o sử dụng v&ocirc; tội vạ. &Iacute;t ai biết rằng gel dinh dưỡng kh&ocirc;ng phải l&agrave; thức ăn d&agrave;nh cho th&uacute; cưng. Đ&acirc;y chỉ l&agrave; 1 loại thực phẩm bổ sung. V&igrave; thế, c&aacute;ch d&ugrave;ng gel dinh dưỡng kiểu &quot;bừa b&atilde;i&quot; n&agrave;y đang khiến t&aacute;c dụng của n&oacute; kh&ocirc;ng được ph&aacute;t huy. Vậy&nbsp;<strong>c&aacute;ch d&ugrave;ng gel dinh dưỡng</strong>&nbsp;thế n&agrave;o mới đ&uacute;ng? C&ugrave;ng&nbsp;<strong>FamiPet&nbsp;</strong>t&igrave;m hiểu ngay sau đ&acirc;y!</p>

<h2><strong>Đối tượng sử dụng gel dinh dưỡng</strong></h2>

<p>Để nắm được c&aacute;ch d&ugrave;ng gel dinh dưỡng th&igrave; c&aacute;c &quot;sen&quot; cần hiểu r&otilde; th&uacute; cưng thế n&agrave;o mới d&ugrave;ng sản phẩm n&agrave;y. Sở dĩ đ&acirc;y chỉ l&agrave; sản phẩm bổ sung năng lượng. V&igrave; thế, nếu th&uacute; cưng kh&ocirc;ng bị sao th&igrave; cho ăn gel dinh dưỡng sẽ kh&ocirc;ng c&oacute; kết quả g&igrave; nhiều. T&aacute;c dụng của sản phẩm cũng kh&ocirc;ng được ph&aacute;t huy.</p>

<p>Đối tượng sử dụng&nbsp;<strong><a href="https://famipet.vn/calxi-vitamins-cho-cho">gel dinh dưỡng&nbsp;</a></strong>l&agrave; những ch&uacute; th&uacute; cưng mất năng lượng v&agrave; ốm yếu. Từ đ&acirc;y, bạn c&oacute; thể liệt k&ecirc; ra 1 loạt đối tượng sử dụng của gel dinh dưỡng:</p>

<ul>
	<li>Ch&oacute; m&egrave;o ốm yếu, vừa ốm dậy, vừa phẫu thuật</li>
	<li>Th&uacute; cưng lười ăn, biếng ăn, chậm lớn</li>
	<li>Ch&oacute; m&egrave;o mẹ đang mang thai v&agrave; m&egrave;o con cũng c&oacute; thể sử dụng gel dinh dưỡng</li>
	<li>Những &quot;boss&quot; hay vận động nhiều</li>
</ul>

<p><img alt="cách dùng gel dinh dưỡng" src="https://bizweb.dktcdn.net/100/346/633/files/cach-dung-gel-dinh-duong-don-gian1.jpg?v=1566968483217" /></p>

<p><em>M&egrave;o mang thai l&agrave; đối tượng c&oacute; thể sử dụng gel dinh dưỡng</em></p>

<p>Ngo&agrave;i ra, nếu th&uacute; cưng c&oacute; bộ l&ocirc;ng xấu, hay rụng l&ocirc;ng th&igrave; sử dụng gel dinh dưỡng cũng rất c&oacute; lợi. B&ecirc;n cạnh đ&oacute;, hệ ti&ecirc;u ho&aacute; cũng được cải thiện hơn khi sử dụng gel dinh dưỡng. Chung quy lại, với những ch&uacute; c&uacute;n khoẻ mạnh th&igrave; tốt nhất n&ecirc;n tham khảo &yacute; kiến b&aacute;c sỹ th&uacute; y để xem c&oacute; n&ecirc;n sử dụng hay kh&ocirc;ng.</p>

<h2><strong>C&aacute;ch d&ugrave;ng gel dinh dưỡng</strong></h2>

<p>Sau khi đ&atilde; biết khi n&agrave;o n&ecirc;n cho ch&oacute; m&egrave;o ăn gel dinh dưỡng th&igrave; bạn mới ch&uacute; &yacute; tới c&aacute;ch d&ugrave;ng sản phẩm n&agrave;y. Thực ra, c&aacute;ch d&ugrave;ng gel dinh dưỡng kh&ocirc;ng kh&oacute; ch&uacute;t n&agrave;o. Thậm ch&iacute; c&ograve;n l&agrave; đơn giản. C&oacute; 2 c&aacute;ch d&ugrave;ng gel dinh dưỡng m&agrave; c&aacute;c &quot;sen&quot; hay l&agrave;m. Đ&oacute; l&agrave; cho ăn trực tiếp hoặc trộn với cơm</p>

<h3><em><strong>Cho ăn trực tiếp</strong></em></h3>

<p>Đ&acirc;y l&agrave; c&aacute;ch d&ugrave;ng gel dinh dưỡng&nbsp; đơn giản v&agrave; dễ thực hiện nhất. Sau khi đ&atilde; đọc hướng dẫn sử dụng v&agrave; liều d&ugrave;ng th&igrave; bạn chỉ cần lấy đ&uacute;ng lượng gel khuyến nghị rồi b&ocirc;i v&agrave;o miệng cho c&aacute;c b&eacute; ăn. Mỗi lần chỉ n&ecirc;n lấy 1 lượng nhỏ để cho th&uacute; cưng ăn. Kh&ocirc;ng n&ecirc;n cho ăn liền 1 l&uacute;c sẽ khiến hệ ti&ecirc;u ho&aacute; l&agrave;m việc vất vả hơn.</p>

<p>Ngo&agrave;i ra, bạn cũng n&ecirc;n lưu &yacute; khi mới sử dụng gel dinh dưỡng cho th&uacute; cưng. L&uacute;c đầu c&oacute; thể c&aacute;c b&eacute; chưa quen v&agrave; sẽ kh&ocirc;ng chịu ăn. Để xem xem c&aacute;c &quot;boss&quot; c&oacute; ăn gel dinh dưỡng kh&ocirc;ng th&igrave; h&atilde;y cho th&uacute; cưng l&agrave;m quen. Mới đầu, b&ocirc;i 1 &iacute;t gel dinh dưỡng v&agrave;o miệng c&aacute;c b&eacute; xem c&oacute; phản ứng g&igrave; hay kh&ocirc;ng. Sau đ&oacute; mới cho ăn theo liều lượng.</p>

<p><img alt="cách dùng gel dinh dưỡng" src="https://bizweb.dktcdn.net/100/346/633/files/cach-dung-gel-dinh-duong-don-gian2-9b4308bb-cecf-4d9d-b16b-9df329808b41.jpg?v=1566968395686" /></p>

<p><em>Cho ăn trực tiếp l&agrave; c&aacute;ch d&ugrave;ng gel dinh dưỡng đơn giản nhất</em></p>

<p>Một điểm đ&aacute;ng lưu &yacute; về c&aacute;ch d&ugrave;ng gel dinh dưỡng trực tiếp l&agrave; khi th&uacute; cưng c&ograve;n b&eacute; th&igrave; chỉ cần 1 lượng nhỏ. Sau đ&oacute; dần dần mới tăng l&ecirc;n. N&oacute;i chung, vấn đề n&agrave;y đều được đề cập ở hướng dẫn sử dụng. Nếu c&ograve;n thắc mắc g&igrave;, bạn h&atilde;y hỏi người b&aacute;n hoặc b&aacute;c sỹ th&uacute; y.</p>

<h3><em><strong>Trộn với thức ăn</strong></em></h3>

<p>C&aacute;ch tr&ecirc;n nếu kh&ocirc;ng c&oacute; hiệu quả với c&aacute;c &quot;boss&quot; th&igrave; trộn với thức ăn l&agrave; c&aacute;ch d&ugrave;ng gel dinh dưỡng hiệu quả hơn! C&aacute;ch n&agrave;y khiến c&aacute;c ch&uacute; th&uacute; cưng kh&oacute; nhận ra vị của gel dinh dưỡng trong thức ăn. Dẫu vậy, c&oacute; nhiều &quot;boss&quot; rất kh&ocirc;n v&agrave; c&oacute; thể đ&aacute;nh hơi thấy m&ugrave;i gel. Trường hợp n&agrave;y kh&aacute; hiếm nhưng khi ch&uacute;ng thấy m&ugrave;i lạ, c&oacute; thể c&aacute;c b&eacute; sẽ kh&ocirc;ng ăn m&oacute;n n&agrave;y lần sau v&agrave; sẽ kh&aacute; &quot;cảnh gi&aacute;c&quot; khi được cho ăn.</p>

<p>C&aacute;ch d&ugrave;ng gel dinh dưỡng n&agrave;y hiệu quả cũng bởi sự nhanh ch&oacute;ng. Bạn kh&ocirc;ng cần mất thời gian b&ocirc;i 1 &iacute;t một cho ch&oacute; m&egrave;o m&agrave; chỉ cần trộn v&agrave;o thức ăn l&agrave; xong. Điều n&agrave;y cũng lại đặt ra vấn đề kh&aacute;c l&agrave; c&oacute; thể c&aacute;c ch&uacute; th&uacute; cưng kh&ocirc;ng ăn hết thức ăn v&agrave; bỏ thừa th&igrave; lượng gel n&agrave;y lại kh&ocirc;ng cung cấp đủ.</p>

<p><img alt="cách dùng gel dinh dưỡng" src="https://bizweb.dktcdn.net/100/346/633/files/cach-dung-gel-dinh-duong-don-gian3.jpg?v=1566968440518" /></p>

<p><em>Trộn chung với cơm cũng l&agrave; c&aacute;ch d&ugrave;ng gel dinh dưỡng rất hiệu quả</em></p>

<p>V&igrave; thế, để biết c&aacute;ch d&ugrave;ng gel dinh dưỡng n&agrave;o l&agrave; ph&ugrave; hợp với th&uacute; cưng nh&agrave; m&igrave;nh nhất th&igrave; bạn n&ecirc;n theo d&otilde;i th&oacute;i quen ăn uống cũng như thể trạng của c&aacute;c b&eacute;. Nếu cần thiết c&oacute; thể kết hợp cả 2 c&aacute;ch d&ugrave;ng gel dinh dưỡng tr&ecirc;n.</p>
', N'Chó', CAST(N'2021-12-04 16:56:45.090' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TINTUC] OFF
INSERT [dbo].[YEUTHICH] ([MASP], [MAKH]) VALUES (1, 2)
INSERT [dbo].[YEUTHICH] ([MASP], [MAKH]) VALUES (2, 2)
INSERT [dbo].[YEUTHICH] ([MASP], [MAKH]) VALUES (4, 2)
/****** Object:  Index [UK_CHITIETHOADON]    Script Date: 05-Dec-21 13:53:11 ******/
ALTER TABLE [dbo].[CHITIET_HOADON] ADD  CONSTRAINT [UK_CHITIETHOADON] UNIQUE NONCLUSTERED 
(
	[MAHD] ASC,
	[MASP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK_GIOHANG]    Script Date: 05-Dec-21 13:53:11 ******/
ALTER TABLE [dbo].[GIOHANG] ADD  CONSTRAINT [UK_GIOHANG] UNIQUE NONCLUSTERED 
(
	[MAKH] ASC,
	[MASP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NHANVIEN_CMND]    Script Date: 05-Dec-21 13:53:11 ******/
ALTER TABLE [dbo].[NHANVIEN] ADD  CONSTRAINT [IX_NHANVIEN_CMND] UNIQUE NONCLUSTERED 
(
	[CMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHITIET_HOADON]  WITH CHECK ADD  CONSTRAINT [FK_CHITIET_HOADON_HOADON] FOREIGN KEY([MAHD])
REFERENCES [dbo].[HOADON] ([MAHD])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CHITIET_HOADON] CHECK CONSTRAINT [FK_CHITIET_HOADON_HOADON]
GO
ALTER TABLE [dbo].[CHITIET_HOADON]  WITH CHECK ADD  CONSTRAINT [FK_CHITIET_HOADON_SANPHAM] FOREIGN KEY([MASP])
REFERENCES [dbo].[SANPHAM] ([MASP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CHITIET_HOADON] CHECK CONSTRAINT [FK_CHITIET_HOADON_SANPHAM]
GO
ALTER TABLE [dbo].[GIOHANG]  WITH CHECK ADD  CONSTRAINT [FK_GIOHANG_KHACHHANG] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHACHHANG] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIOHANG] CHECK CONSTRAINT [FK_GIOHANG_KHACHHANG]
GO
ALTER TABLE [dbo].[GIOHANG]  WITH CHECK ADD  CONSTRAINT [FK_GIOHANG_SANPHAM] FOREIGN KEY([MASP])
REFERENCES [dbo].[SANPHAM] ([MASP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIOHANG] CHECK CONSTRAINT [FK_GIOHANG_SANPHAM]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HOADON_KHACHHANG] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHACHHANG] ([MAKH])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HOADON_KHACHHANG]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HOADON_NHANVIEN] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MANV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HOADON_NHANVIEN]
GO
ALTER TABLE [dbo].[KHACHHANG]  WITH CHECK ADD  CONSTRAINT [FK_KHACHHANG_TAIKHOAN] FOREIGN KEY([TENDANGNHAP])
REFERENCES [dbo].[TAIKHOAN] ([TENDANGNHAP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[KHACHHANG] CHECK CONSTRAINT [FK_KHACHHANG_TAIKHOAN]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NHANVIEN_TAIKHOAN] FOREIGN KEY([TENDANGNHAP])
REFERENCES [dbo].[TAIKHOAN] ([TENDANGNHAP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NHANVIEN_TAIKHOAN]
GO
ALTER TABLE [dbo].[TINTUC]  WITH CHECK ADD  CONSTRAINT [FK_TINTUC_NHANVIEN] FOREIGN KEY([MANV])
REFERENCES [dbo].[NHANVIEN] ([MANV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TINTUC] CHECK CONSTRAINT [FK_TINTUC_NHANVIEN]
GO
ALTER TABLE [dbo].[YEUTHICH]  WITH CHECK ADD  CONSTRAINT [FK_YEUTHICH_KHACHHANG] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHACHHANG] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[YEUTHICH] CHECK CONSTRAINT [FK_YEUTHICH_KHACHHANG]
GO
ALTER TABLE [dbo].[YEUTHICH]  WITH CHECK ADD  CONSTRAINT [FK_YEUTHICH_SANPHAM] FOREIGN KEY([MASP])
REFERENCES [dbo].[SANPHAM] ([MASP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[YEUTHICH] CHECK CONSTRAINT [FK_YEUTHICH_SANPHAM]
GO
ALTER TABLE [dbo].[NHOMSANPHAM]  WITH CHECK ADD  CONSTRAINT [CK_NHOMSANPHAM_VATNUOI] CHECK  (([VATNUOI]=N'CHÓ' OR [VATNUOI]=N'MÈO'))
GO
ALTER TABLE [dbo].[NHOMSANPHAM] CHECK CONSTRAINT [CK_NHOMSANPHAM_VATNUOI]
GO
ALTER TABLE [dbo].[TAIKHOAN]  WITH CHECK ADD  CONSTRAINT [CK_TAIKHOAN_VAITRO] CHECK  (([VAITRO]=N'ADMIN' OR [VAITRO]=N'Khách hàng' OR [VAITRO]=N'Nhân viên'))
GO
ALTER TABLE [dbo].[TAIKHOAN] CHECK CONSTRAINT [CK_TAIKHOAN_VAITRO]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TRẠNG THÁI HOẠT ĐỘNG' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TAIKHOAN', @level2type=N'COLUMN',@level2name=N'TRANGTHAI'
GO
