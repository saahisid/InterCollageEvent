USE [interclgevent]
GO
/****** Object:  Table [dbo].[tbl_student]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_student](
	[studid] [int] IDENTITY(1,1) NOT NULL,
	[colgid] [int] NULL,
	[studname] [varchar](250) NULL,
	[regno] [varchar](70) NULL,
	[gender] [varchar](70) NULL,
	[admission_year] [varchar](70) NULL,
	[courseid] [int] NULL,
	[contactno] [varchar](70) NULL,
	[Email_id] [varchar](70) NULL,
	[Stud_pass] [varchar](70) NULL,
PRIMARY KEY CLUSTERED 
(
	[studid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_course]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_course](
	[courseid] [int] IDENTITY(1,1) NOT NULL,
	[course_name] [varchar](250) NULL,
 CONSTRAINT [PK_tblcourse] PRIMARY KEY CLUSTERED 
(
	[courseid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_college]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_college](
	[colgid] [int] IDENTITY(1,1) NOT NULL,
	[colgname] [varchar](30) NULL,
	[college_Code] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[colgid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_candidate]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_candidate](
	[EventID] [int] NULL,
	[EventNAME] [varchar](250) NULL,
	[CollegeId] [int] NULL,
	[CollegeName] [varchar](250) NULL,
	[StudentName] [varchar](250) NULL,
	[StudentId] [int] NULL,
	[Idproof] [varchar](250) NULL,
	[Amount] [int] NULL,
	[AccountNo] [int] NULL,
	[CVV] [int] NULL,
	[BankName] [varchar](250) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_admin]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_admin](
	[adminid] [int] NOT NULL,
	[full_name] [varchar](30) NULL,
	[uname] [varchar](30) NULL,
	[upass] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[adminid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblresult]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblresult](
	[ID] [int] NOT NULL,
	[postid] [int] NULL,
	[studentid] [int] NULL,
	[candidateid] [int] NULL,
 CONSTRAINT [PK_tblresult] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblgallery]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblgallery](
	[galleryid] [int] IDENTITY(1,1) NOT NULL,
	[photolink] [varchar](max) NULL,
	[eventid] [int] NULL,
 CONSTRAINT [PK_tblgallery] PRIMARY KEY CLUSTERED 
(
	[galleryid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblevent_result]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblevent_result](
	[Edid] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NULL,
	[event_schedule] [text] NULL,
	[event_result] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[Edid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblevent_reg]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblevent_reg](
	[pid] [int] NULL,
	[studid] [int] NULL,
	[eventid] [int] NULL,
	[colgid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblcomment]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblcomment](
	[fid] [int] IDENTITY(1,1) NOT NULL,
	[postedby] [int] NULL,
	[postedon] [date] NULL,
	[comments] [varchar](30) NULL,
	[eventid] [int] NULL,
 CONSTRAINT [PK_tblcomment] PRIMARY KEY CLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblcolg_detail]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblcolg_detail](
	[Clinfo_id] [int] IDENTITY(1,1) NOT NULL,
	[Colg_id] [int] NULL,
	[Address] [varchar](max) NULL,
	[Contact] [varchar](40) NULL,
	[Contact2] [varchar](40) NULL,
	[Email_id] [varchar](40) NULL,
	[Photopath] [varchar](500) NULL,
	[lattitude] [varchar](40) NULL,
	[longitude] [varchar](40) NULL,
	[Colg_pass] [varchar](40) NULL,
	[Status] [varchar](40) NULL,
	[Colg_code] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[Clinfo_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblevent_notice]    Script Date: 02/21/2020 03:14:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblevent_notice](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[event_name] [varchar](max) NULL,
	[event_desc] [text] NULL,
	[event_date] [date] NULL,
	[event_file] [varchar](400) NULL,
	[Colgid] [int] NULL,
	[event_type] [varchar](200) NULL,
	[Status] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK__tblcolg_d__Colg___2DE6D218]    Script Date: 02/21/2020 03:14:16 ******/
ALTER TABLE [dbo].[tblcolg_detail]  WITH CHECK ADD FOREIGN KEY([Colg_id])
REFERENCES [dbo].[tbl_college] ([colgid])
GO
/****** Object:  ForeignKey [FK__tblevent___Colgi__17036CC0]    Script Date: 02/21/2020 03:14:16 ******/
ALTER TABLE [dbo].[tblevent_notice]  WITH CHECK ADD FOREIGN KEY([Colgid])
REFERENCES [dbo].[tbl_college] ([colgid])
GO
