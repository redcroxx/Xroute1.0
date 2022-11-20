-- 보조송장관리 
CREATE TABLE [dbo].[INVCSPLIT](
	[COMPCD] 				[nvarchar](20) NOT NULL,
	[ORGCD] 				[nvarchar](20) NOT NULL,
	[SEQ]					[decimal](10, 0) IDENTITY(10000,1) NOT NULL,
	[YYYYMMDD]				[nvarchar](8) NULL,
	[CLGO_SEQ]				[decimal](10, 0) NULL,
	[REG_SEQ]				[decimal](10, 0) NULL,
	[STATUS_CD]				[nvarchar](5) NULL,
	[INVC_SNO_ORI]			[nvarchar](30) NULL,
	[SITE_CD]				[nvarchar](5) NULL,
	[INVC_SNO]				[nvarchar](30) NULL,
	[SNO]					[decimal](10, 0) NULL,
	[PROD_NM]				[nvarchar](300) NULL,
	[QTY]					[decimal](10, 0) NULL,
	[RCV_NM]				[nvarchar](300) NULL,
	[TEL1]					[nvarchar](30) NULL,
	[TEL2]					[nvarchar](30) NULL,
	[ADDR]					[nvarchar](1000) NULL,
	[ZIPCODE]				[nvarchar](30) NULL,
	[DELI_TYPE]				[nvarchar](30) NULL,
	[DELI_MSG]				[nvarchar](1000) NULL,
	[DELI_CD]				[nvarchar](5) NULL,
	[SND_NM]				[nvarchar](300) NULL,
	[SND_ADDR]				[nvarchar](1000) NULL,
	[SND_TEL]				[nvarchar](30) NULL,
	[SND_ZIPCODE]			[nvarchar](30) NULL, 
	[CLGO_SCAN_YN]			[nvarchar](1) NULL DEFAULT ('N'),
	[CLGO_SCAN_YMDH]		[nvarchar](14) NULL,
	[CLGO_SCAN_ADMIN_ID]	[nvarchar](30) NULL,
	[CANCEL_YN]				[nvarchar](1) NULL DEFAULT ('N'),
	[CANCEL_YMDH]			[nvarchar](14) NULL,
	[CANCEL_ADMIN_ID]		[nvarchar](30) NULL,
	[CLGO_COMP_YN]			[nvarchar](1) NULL DEFAULT ('N'),
	[CLGO_COMP_YMDH]		[nvarchar](14) NULL,
	[CLGO_COMP_ADMIN_ID]	[nvarchar](30) NULL,
	[TRACE_CD]				[nvarchar](5) NULL,
	[TRACE_YMDH]			[nvarchar](14) NULL,
	[GUBUN1]				[nvarchar](300) NULL,
	[GUBUN2]				[nvarchar](300) NULL,
	[SEQ_MST]				[decimal](10, 0) NULL,
	[PROD_CD]				[nvarchar](300) NULL,
	[INVC_SEQ]				[decimal](10, 0) NULL,
	[C80]					[nvarchar](300) NULL,
	[INVC_PRN_CNT]			[decimal](10, 0) NULL DEFAULT ((0)),
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [INVCSPLIT_IDX1] ON [dbo].[INVCSPLIT]
(	
	[COMPCD] ASC,
	[ORGCD] ASC,
	[CLGO_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [INVCSPLIT_IDX2] ON [dbo].[INVCSPLIT]
(
	[INVC_SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [INVCSPLIT_IDX3] ON [DBO].[INVCSPLIT]
(
	[YYYYMMDD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [INVCSPLIT_IDX4] ON [dbo].[INVCSPLIT]
(
	[INVC_SNO_ORI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '보조송장관리', 'user', dbo, 'table',[INVCSPLIT]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [INVCSPLIT], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [INVCSPLIT], 'column', [ORGCD]  			
EXEC   sp_addextendedproperty 'MS_Description', '테이블순번', 'user', dbo, 'table', [INVCSPLIT], 'column', [SEQ]					
EXEC   sp_addextendedproperty 'MS_Description', '송장발행일자', 'user', dbo, 'table', [INVCSPLIT], 'column', [YYYYMMDD]				
EXEC   sp_addextendedproperty 'MS_Description', '고객주문번호', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_SEQ]				
EXEC   sp_addextendedproperty 'MS_Description', '주문파일키', 'user', dbo, 'table', [INVCSPLIT], 'column', [REG_SEQ]				
EXEC   sp_addextendedproperty 'MS_Description', '출고상태', 'user', dbo, 'table', [INVCSPLIT], 'column', [STATUS_CD]				
EXEC   sp_addextendedproperty 'MS_Description', '원송장번호', 'user', dbo, 'table', [INVCSPLIT], 'column', [INVC_SNO_ORI]			
EXEC   sp_addextendedproperty 'MS_Description', '양식코드', 'user', dbo, 'table', [INVCSPLIT], 'column', [SITE_CD]				
EXEC   sp_addextendedproperty 'MS_Description', '보조송장번호', 'user', dbo, 'table', [INVCSPLIT], 'column', [INVC_SNO]				
EXEC   sp_addextendedproperty 'MS_Description', '주문파일키별순번', 'user', dbo, 'table', [INVCSPLIT], 'column', [SNO]					
EXEC   sp_addextendedproperty 'MS_Description', '보조송장상품정보(ex. 보조송장(1/5) 헤모힘)', 'user', dbo, 'table', [INVCSPLIT], 'column', [PROD_NM]				
EXEC   sp_addextendedproperty 'MS_Description', '수량', 'user', dbo, 'table', [INVCSPLIT], 'column', [QTY]					
EXEC   sp_addextendedproperty 'MS_Description', '수취인', 'user', dbo, 'table', [INVCSPLIT], 'column', [RCV_NM]				
EXEC   sp_addextendedproperty 'MS_Description', '전화1', 'user', dbo, 'table', [INVCSPLIT], 'column', [TEL1]					
EXEC   sp_addextendedproperty 'MS_Description', '전화2', 'user', dbo, 'table', [INVCSPLIT], 'column', [TEL2]					
EXEC   sp_addextendedproperty 'MS_Description', '주소', 'user', dbo, 'table', [INVCSPLIT], 'column', [ADDR]					
EXEC   sp_addextendedproperty 'MS_Description', '우편번호', 'user', dbo, 'table', [INVCSPLIT], 'column', [ZIPCODE]				
EXEC   sp_addextendedproperty 'MS_Description', '배송구분', 'user', dbo, 'table', [INVCSPLIT], 'column', [DELI_TYPE]				
EXEC   sp_addextendedproperty 'MS_Description', '배송메시지', 'user', dbo, 'table', [INVCSPLIT], 'column', [DELI_MSG]				
EXEC   sp_addextendedproperty 'MS_Description', '택배사', 'user', dbo, 'table', [INVCSPLIT], 'column', [DELI_CD]				
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람', 'user', dbo, 'table', [INVCSPLIT], 'column', [SND_NM]				
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람주소', 'user', dbo, 'table', [INVCSPLIT], 'column', [SND_ADDR]				
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람전화번호', 'user', dbo, 'table', [INVCSPLIT], 'column', [SND_TEL]				
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람우편번호', 'user', dbo, 'table', [INVCSPLIT], 'column', [SND_ZIPCODE]			
EXEC   sp_addextendedproperty 'MS_Description', '스캔구분(Y:스캔, N:미스캔)', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_SCAN_YN]			
EXEC   sp_addextendedproperty 'MS_Description', '스캔일자', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_SCAN_YMDH]		
EXEC   sp_addextendedproperty 'MS_Description', '스캔ID', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_SCAN_ADMIN_ID]	
EXEC   sp_addextendedproperty 'MS_Description', '취소구분(Y:취소, N:취소안함)', 'user', dbo, 'table', [INVCSPLIT], 'column', [CANCEL_YN]				
EXEC   sp_addextendedproperty 'MS_Description', '취소일자', 'user', dbo, 'table', [INVCSPLIT], 'column', [CANCEL_YMDH]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [CANCEL_ADMIN_ID]		
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_COMP_YN]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_COMP_YMDH]		
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [CLGO_COMP_ADMIN_ID]	
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [TRACE_CD]				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [TRACE_YMDH]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [GUBUN1]				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [GUBUN2]				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [SEQ_MST]				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [PROD_CD]				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [INVC_SEQ]				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [C80]					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INVCSPLIT], 'column', [INVC_PRN_CNT]				
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [INVCSPLIT], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [INVCSPLIT], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [INVCSPLIT], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [INVCSPLIT], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [INVCSPLIT], 'column', [TERMINALCD]	
GO

-- 시리얼관리
CREATE TABLE [dbo].[SPRODSERIAL](
	[COMPCD] 				[nvarchar](20) NOT NULL,
	[ORGCD] 				[nvarchar](20) NOT NULL,
	[SERIAL_NO]				[nvarchar](30) NOT NULL,
	[INVC_SNO]				[nvarchar](30) NULL,
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL
 CONSTRAINT [PK_SPRODSERIAL] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[SERIAL_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '시리얼관리', 'user', dbo, 'table',[SPRODSERIAL]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [SPRODSERIAL], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [SPRODSERIAL], 'column', [ORGCD]  			
EXEC   sp_addextendedproperty 'MS_Description', '트래킹번호', 'user', dbo, 'table', [SPRODSERIAL], 'column', [SERIAL_NO]					
EXEC   sp_addextendedproperty 'MS_Description', '송장번호', 'user', dbo, 'table', [SPRODSERIAL], 'column', [INVC_SNO]				
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [SPRODSERIAL], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [SPRODSERIAL], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [SPRODSERIAL], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [SPRODSERIAL], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [SPRODSERIAL], 'column', [TERMINALCD]	
GO


-- 시리얼삭제관리
CREATE TABLE [dbo].[SPRODSERIALDEL](
	[COMPCD]				[nvarchar](20) NOT NULL,
	[ORGCD]					[nvarchar](20) NOT NULL,
	[SERIAL_NO]				[nvarchar](30) NOT NULL,
	[INVC_SNO]				[nvarchar](30) NULL,
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL,
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '시리얼삭제관리', 'user', dbo, 'table',[SPRODSERIALDEL]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', [COMPCD]           
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', [ORGCD]            
EXEC   sp_addextendedproperty 'MS_Description', '트래킹번호', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', [SERIAL_NO]      
EXEC   sp_addextendedproperty 'MS_Description', '송장번호', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', [INVC_SNO]      
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID(트래킹등록자)', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시(트래킹등록일시)', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID(트래킹삭제자)', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시(트래킹삭제일시)', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [SPRODSERIALDEL], 'column', TERMINALCD
GO



/*임시테이블------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[SEQDTL](
	[COMPCD] 		[nvarchar](20) NOT NULL,
	[ORGCD] 		[nvarchar](20) NOT NULL,     
	[SEQ]			[decimal](10, 0)  NULL,
	[SNO]			[decimal](10, 0)  NULL,
	[TOT_CNT]		[decimal](10, 0)  NULL DEFAULT (0),
	[TOT_SUM]		[decimal](10, 0)  NULL DEFAULT (0),
	[STR0]			[nvarchar](300) NULL,
	[STR1]			[nvarchar](300) NULL,
	[STR2]			[nvarchar](300) NULL,
	[STR3]			[nvarchar](300) NULL,
	[STR4]			[nvarchar](300) NULL,
	[STR5]			[nvarchar](300) NULL,
	[STR6]			[nvarchar](300) NULL,
	[STR7]			[nvarchar](300) NULL,
	[STR8]			[nvarchar](300) NULL,
	[STR9]			[nvarchar](300) NULL,
	[STR10]			[nvarchar](300) NULL,
	[STR11]			[nvarchar](300) NULL,
	[STR12]			[nvarchar](300) NULL,
	[STR13]			[nvarchar](300) NULL,
	[STR14]			[nvarchar](300) NULL,
	[STR15]			[nvarchar](300) NULL,
	[STR16]			[nvarchar](300) NULL,
	[STR17]			[nvarchar](300) NULL,
	[STR18]			[nvarchar](300) NULL,
	[STR19]			[nvarchar](300) NULL,
	[STR20]			[nvarchar](300) NULL,
	[STR1000]		[nvarchar](1000) NULL,
	[STR2000]		[nvarchar](1000) NULL,
	[STR4000]		[nvarchar](1000) NULL
) ON [PRIMARY]

GO


/*스캔테이블------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[ORDERFILEINVCDTLSCAN](
	[CLGO_SEQ]		[int] NULL,
	[INVC_SNO]		[nvarchar](30) NULL,
	[SPROD_CD]		[nvarchar](300) NULL,
	[ORD_QTY]		[int] NULL,
	[SCAN_QTY]		[int] NULL,
	[SCAN_SERIALS]  [nvarchar](4000) NULL
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_ORDERFILEINVCDTLSCAN] ON [DBO].[ORDERFILEINVCDTLSCAN]
(
	[CLGO_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

