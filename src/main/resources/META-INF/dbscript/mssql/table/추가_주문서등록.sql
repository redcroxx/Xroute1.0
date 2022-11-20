
/*주문파일마스터*/
CREATE TABLE [dbo].[ORDERFILE](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,
	[REG_SEQ] 			[decimal](10,0) IDENTITY(100000,1) NOT NULL,
	[FILE_YMD] 			[nvarchar](8) NULL,
	[FILE_SEQ] 			[decimal](10,0) NULL,
	[FILE_NM] 			[nvarchar](300) NULL,
	[FILE_NM_REAL] 		[nvarchar](300) NULL,
	[SITE_CD] 			[nvarchar](30) NULL,
	[DELI_CD] 			[nvarchar](30) NULL,
	[STATUS_CD] 		[nvarchar](5) NOT NULL DEFAULT (0),
	[PICKUP_STATUS] 	[nvarchar](5) NULL DEFAULT ('00000'),
	[PICKUP_CNT] 		[decimal](10,0) NULL DEFAULT (0),
	[PICKUP_ADMIN_ID] 	[nvarchar](30) NULL,
	[PICKUP_YMDH]		[nvarchar](14) NULL,
	[TMP_REG_SEQ] 		[decimal](10,0) NULL,
	[WH_CD] 			[nvarchar](30) NULL,
	[EACH_YN] 			[nvarchar](1) NULL,
	[SEQ_TP] 			[nvarchar](5) NULL,
	[SEQ_FILE_GB] 		[nvarchar](5) NULL,
	[GTL_END_NO] 		[nvarchar](5) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL,
	[BOOK_YN]           [NVARCHAR](1) NULL,
	[CARD_YN]           [NVARCHAR](1) NULL DEFAULT('N'),
	[RELEASE_LINE]      [NVARCHAR](4) NULL,
	[INTF_PLANT_YN]     [NVARCHAR](1) NULL
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [ORDERFILE_IDX1] ON [dbo].[ORDERFILE]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[FILE_YMD] ASC,
	[FILE_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [ORDERFILE_IDX2] ON [dbo].[ORDERFILE]
(
	[FILE_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [ORDERFILE_IDX3] ON [dbo].[ORDERFILE]
(	
	[COMPCD] ASC,
	[ORGCD] ASC,
	[FILE_YMD] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [ORDERFILE_IDX4] ON [DBO].[ORDERFILE]
(
	[REG_SEQ] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '주문파일마스터', 'user', dbo, 'table',[ORDERFILE]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [ORDERFILE], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [ORDERFILE], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '주문파일키', 'user', dbo, 'table', [ORDERFILE], 'column', [REG_SEQ]		
EXEC   sp_addextendedproperty 'MS_Description', '날짜', 'user', dbo, 'table', [ORDERFILE], 'column', [FILE_YMD]					
EXEC   sp_addextendedproperty 'MS_Description', '차수', 'user', dbo, 'table', [ORDERFILE], 'column', [FILE_SEQ]						
EXEC   sp_addextendedproperty 'MS_Description', '차수명', 'user', dbo, 'table', [ORDERFILE], 'column', [FILE_NM]							
EXEC   sp_addextendedproperty 'MS_Description', '파일명', 'user', dbo, 'table', [ORDERFILE], 'column', [FILE_NM_REAL]		
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식코드', 'user', dbo, 'table', [ORDERFILE], 'column', [SITE_CD]		
EXEC   sp_addextendedproperty 'MS_Description', '택배사코드', 'user', dbo, 'table', [ORDERFILE], 'column', [DELI_CD]		
EXEC   sp_addextendedproperty 'MS_Description', '주문파일처리상태코드(LF_ORDFILESTATUS/00000:전체, 00001:원주문저장완료, 00002:발주서생성완료, 00003:송장발번완료, 00004:주소정제완료, 00005:상품포장중, 00006:픽업및포장중, 00007:출고스캔중,  00008:출고스캔완료, 00009:출고완료)', 'user', dbo, 'table', [ORDERFILE], 'column', [STATUS_CD]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [PICKUP_STATUS]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [PICKUP_CNT]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [PICKUP_ADMIN_ID]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [PICKUP_YMDH]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [TMP_REG_SEQ]		
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [ORDERFILE], 'column', [WH_CD]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [EACH_YN]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [SEQ_TP]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [SEQ_FILE_GB]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILE], 'column', [GTL_END_NO]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [ORDERFILE], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [ORDERFILE], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [ORDERFILE], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [ORDERFILE], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [ORDERFILE], 'column', [TERMINALCD]	
GO	


/*주문파일디테일*/
CREATE TABLE [DBO].[ORDERFILEDTL](
    [COMPCD]            [NVARCHAR](20) NOT NULL,
	[ORGCD]      	    [NVARCHAR](20) NOT NULL,
    [REG_SEQ]			[DECIMAL](10,0) NULL,
	[C00]				[DECIMAL](10,0) IDENTITY(1,1) NOT NULL,
	[C01]				[NVARCHAR](1000) NULL,
	[C02]				[NVARCHAR](1000) NULL,
	[C03]				[NVARCHAR](1000) NULL,
	[C04]				[NVARCHAR](1000) NULL,
	[C05]				[NVARCHAR](1000) NULL,
	[C06]				[NVARCHAR](1000) NULL,
	[C07]				[NVARCHAR](1000) NULL,
	[C08]				[NVARCHAR](1000) NULL,
	[C09]				[NVARCHAR](1000) NULL,
	[C10]				[NVARCHAR](1000) NULL,
	[C11]				[NVARCHAR](1000) NULL,
	[C12]				[NVARCHAR](1000) NULL,
	[C13]				[NVARCHAR](1000) NULL,
	[C14]				[NVARCHAR](1000) NULL,
	[C15]				[NVARCHAR](1000) NULL,
	[C16]				[NVARCHAR](1000) NULL,
	[C17]				[NVARCHAR](1000) NULL,
	[C18]				[NVARCHAR](1000) NULL,
	[C19]				[NVARCHAR](1000) NULL,
	[C20]				[NVARCHAR](1000) NULL,
	[C21]				[NVARCHAR](1000) NULL,
	[C22]				[NVARCHAR](1000) NULL,
	[C23]				[NVARCHAR](1000) NULL,
	[C24]				[NVARCHAR](1000) NULL,
	[C25]				[NVARCHAR](1000) NULL,
	[C26]				[NVARCHAR](1000) NULL,
	[C27]				[NVARCHAR](1000) NULL,
	[C28]				[NVARCHAR](1000) NULL,
	[C29]				[NVARCHAR](1000) NULL,
	[C30]				[NVARCHAR](1000) NULL,
	[C31]				[NVARCHAR](1000) NULL,
	[C32]				[NVARCHAR](1000) NULL,
	[C33]				[NVARCHAR](1000) NULL,
	[C34]				[NVARCHAR](1000) NULL,
	[C35]				[NVARCHAR](1000) NULL,
	[C36]				[NVARCHAR](1000) NULL,
	[C37]				[NVARCHAR](1000) NULL,
	[C38]				[NVARCHAR](1000) NULL,
	[C39]				[NVARCHAR](1000) NULL,
	[C40]				[NVARCHAR](1000) NULL,
	[C41]				[NVARCHAR](1000) NULL,
	[C42]				[NVARCHAR](1000) NULL,
	[C43]				[NVARCHAR](1000) NULL,
	[C44]				[NVARCHAR](1000) NULL,
	[C45]				[NVARCHAR](1000) NULL,
	[C46]				[NVARCHAR](1000) NULL,
	[C47]				[NVARCHAR](1000) NULL,
	[C48]				[NVARCHAR](1000) NULL,
	[C49]				[NVARCHAR](1000) NULL,
	[C50]				[NVARCHAR](1000) NULL,
	[C51]				[NVARCHAR](1000) NULL,
	[C52]				[NVARCHAR](1000) NULL,
	[C53]				[NVARCHAR](1000) NULL,
	[C54]				[NVARCHAR](1000) NULL,
	[C55]				[NVARCHAR](1000) NULL,
	[C56]				[NVARCHAR](1000) NULL,
	[C57]				[NVARCHAR](1000) NULL,
	[C58]				[NVARCHAR](1000) NULL,
	[C59]				[NVARCHAR](1000) NULL,
	[C60]				[NVARCHAR](1000) NULL,
	[C61]				[NVARCHAR](1000) NULL,
	[C62]				[NVARCHAR](1000) NULL,
	[C63]				[NVARCHAR](1000) NULL,
	[C64]				[NVARCHAR](1000) NULL,
	[C65]				[NVARCHAR](1000) NULL,
	[C66]				[NVARCHAR](1000) NULL,
	[C67]				[NVARCHAR](1000) NULL,
	[C68]				[NVARCHAR](1000) NULL,
	[C69]				[NVARCHAR](1000) NULL,
	[C70]				[NVARCHAR](1000) NULL,
	[C71]				[NVARCHAR](1000) NULL,
	[C72]				[NVARCHAR](1000) NULL,
	[C73]				[NVARCHAR](1000) NULL,
	[C74]				[NVARCHAR](1000) NULL,
	[C75]				[NVARCHAR](1000) NULL,
	[C76]				[NVARCHAR](1000) NULL,
	[C77]				[NVARCHAR](1000) NULL,
	[C78]				[NVARCHAR](1000) NULL,
	[C79]				[NVARCHAR](1000) NULL,
	[C80]				[NVARCHAR](1000) NULL,
	[PACK_STR]			[NVARCHAR](1000) NULL,
	[PACK_CNT]			[DECIMAL](10,0) NULL,
	[CLGO_SEQ]			[DECIMAL](10,0) NULL,
	[QTY_INV]			[DECIMAL](10,0) NULL,
	[DELI_TYPE]			[NVARCHAR](10) NULL,
	[SNO]				[DECIMAL](10,0) NULL,
	[ORD_SNO]			[NVARCHAR](30) NULL,
	[SPROD_CNT]			[DECIMAL](10,0) NULL,
	[REF_KEY]			[DECIMAL](10,0) NULL,
	[QTY_JEGO]			[DECIMAL](10,0) NULL,
	[QTY_CLGO]			[DECIMAL](10,0) NULL,
	[DUP_TYPE]			[DECIMAL](10,0) NULL DEFAULT (0),
	[CANCEL_YN_DTL]		[NVARCHAR](1) NULL DEFAULT ('N'),
	[SPROD_CNT_GIFT]	[DECIMAL](10,0) NULL,
	[FLG_INT]			[DECIMAL](10,0) NULL DEFAULT (0),
	[QTY_ORDER]			[DECIMAL](10,0) NULL,
	[ADDUSERCD]    		[NVARCHAR](20) NULL,
	[ADDDATETIME] 		[DATETIME] NULL DEFAULT (GETDATE()),
	[UPDUSERCD]   		[NVARCHAR](20) NULL,
	[UPDDATETIME] 		[DATETIME] NULL DEFAULT (GETDATE()),
	[TERMINALCD]  		[NVARCHAR](50) NULL,
	[RELAY_SEQ]         [INT],
	[BOX_NM]            [NVARCHAR](30) NULL,
	[INTF_YN]           [NVARCHAR](1) NULL,
	[PROD_CD]           [NVARCHAR](20) NULL,
	[PROD_NM]           [NVARCHAR](300) NULL,
	[QTY]               [INT] NULL,
) ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [OrderFileDtl_idx1] ON [dbo].[OrderFileDtl]
(
	[reg_seq] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [OrderFileDtl_idx2] ON [dbo].[OrderFileDtl]
(
	[ord_sno] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [OrderFileDtl_idx3] ON [dbo].[OrderFileDtl]
(
	[clgo_seq] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO 

/*
1. 주석추가 (add)
 인덱스

*
**/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '주문파일디테일', 'user', dbo, 'table',[ORDERFILEDTL]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [ORDERFILEDTL], 'column', [COMPCD]            
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [ORDERFILEDTL], 'column', [ORGCD]      	    
EXEC   sp_addextendedproperty 'MS_Description', '주문파일키', 'user', dbo, 'table', [ORDERFILEDTL], 'column', [REG_SEQ]			
EXEC   sp_addextendedproperty 'MS_Description', 'C00', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C00]				
EXEC   sp_addextendedproperty 'MS_Description', 'C01', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C01]				
EXEC   sp_addextendedproperty 'MS_Description', 'C02', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C02]				
EXEC   sp_addextendedproperty 'MS_Description', 'C03', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C03]				
EXEC   sp_addextendedproperty 'MS_Description', 'C04', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C04]				
EXEC   sp_addextendedproperty 'MS_Description', 'C05', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C05]				
EXEC   sp_addextendedproperty 'MS_Description', 'C06', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C06]				
EXEC   sp_addextendedproperty 'MS_Description', 'C07', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C07]				
EXEC   sp_addextendedproperty 'MS_Description', 'C08', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C08]				
EXEC   sp_addextendedproperty 'MS_Description', 'C09', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C09]				
EXEC   sp_addextendedproperty 'MS_Description', 'C10', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C10]				
EXEC   sp_addextendedproperty 'MS_Description', 'C11', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C11]				
EXEC   sp_addextendedproperty 'MS_Description', 'C12', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C12]				
EXEC   sp_addextendedproperty 'MS_Description', 'C13', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C13]				
EXEC   sp_addextendedproperty 'MS_Description', 'C14', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C14]				
EXEC   sp_addextendedproperty 'MS_Description', 'C15', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C15]				
EXEC   sp_addextendedproperty 'MS_Description', 'C16', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C16]				
EXEC   sp_addextendedproperty 'MS_Description', 'C17', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C17]				
EXEC   sp_addextendedproperty 'MS_Description', 'C18', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C18]				
EXEC   sp_addextendedproperty 'MS_Description', 'C19', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C19]				
EXEC   sp_addextendedproperty 'MS_Description', 'C20', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C20]				
EXEC   sp_addextendedproperty 'MS_Description', 'C21', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C21]				
EXEC   sp_addextendedproperty 'MS_Description', 'C22', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C22]				
EXEC   sp_addextendedproperty 'MS_Description', 'C23', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C23]				
EXEC   sp_addextendedproperty 'MS_Description', 'C24', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C24]				
EXEC   sp_addextendedproperty 'MS_Description', 'C25', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C25]				
EXEC   sp_addextendedproperty 'MS_Description', 'C26', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C26]				
EXEC   sp_addextendedproperty 'MS_Description', 'C27', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C27]				
EXEC   sp_addextendedproperty 'MS_Description', 'C28', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C28]				
EXEC   sp_addextendedproperty 'MS_Description', 'C29', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C29]				
EXEC   sp_addextendedproperty 'MS_Description', 'C30', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C30]				
EXEC   sp_addextendedproperty 'MS_Description', 'C31', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C31]				
EXEC   sp_addextendedproperty 'MS_Description', 'C32', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C32]				
EXEC   sp_addextendedproperty 'MS_Description', 'C33', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C33]				
EXEC   sp_addextendedproperty 'MS_Description', 'C34', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C34]				
EXEC   sp_addextendedproperty 'MS_Description', 'C35', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C35]				
EXEC   sp_addextendedproperty 'MS_Description', 'C36', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C36]				
EXEC   sp_addextendedproperty 'MS_Description', 'C37', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C37]				
EXEC   sp_addextendedproperty 'MS_Description', 'C38', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C38]				
EXEC   sp_addextendedproperty 'MS_Description', 'C39', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C39]				
EXEC   sp_addextendedproperty 'MS_Description', 'C40', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C40]				
EXEC   sp_addextendedproperty 'MS_Description', 'C41', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C41]				
EXEC   sp_addextendedproperty 'MS_Description', 'C42', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C42]				
EXEC   sp_addextendedproperty 'MS_Description', 'C43', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C43]				
EXEC   sp_addextendedproperty 'MS_Description', 'C44', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C44]				
EXEC   sp_addextendedproperty 'MS_Description', 'C45', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C45]				
EXEC   sp_addextendedproperty 'MS_Description', 'C46', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C46]				
EXEC   sp_addextendedproperty 'MS_Description', 'C47', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C47]				
EXEC   sp_addextendedproperty 'MS_Description', 'C48', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C48]				
EXEC   sp_addextendedproperty 'MS_Description', 'C49', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C49]				
EXEC   sp_addextendedproperty 'MS_Description', 'C50', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C50]				
EXEC   sp_addextendedproperty 'MS_Description', 'C51', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C51]				
EXEC   sp_addextendedproperty 'MS_Description', 'C52', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C52]				
EXEC   sp_addextendedproperty 'MS_Description', 'C53', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C53]				
EXEC   sp_addextendedproperty 'MS_Description', 'C54', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C54]				
EXEC   sp_addextendedproperty 'MS_Description', 'C55', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C55]				
EXEC   sp_addextendedproperty 'MS_Description', 'C56', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C56]				
EXEC   sp_addextendedproperty 'MS_Description', 'C57', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C57]				
EXEC   sp_addextendedproperty 'MS_Description', 'C58', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C58]				
EXEC   sp_addextendedproperty 'MS_Description', 'C59', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C59]				
EXEC   sp_addextendedproperty 'MS_Description', 'C60', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C60]				
EXEC   sp_addextendedproperty 'MS_Description', 'C61', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C61]				
EXEC   sp_addextendedproperty 'MS_Description', 'C62', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C62]				
EXEC   sp_addextendedproperty 'MS_Description', 'C63', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C63]				
EXEC   sp_addextendedproperty 'MS_Description', 'C64', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C64]				
EXEC   sp_addextendedproperty 'MS_Description', 'C65', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C65]				
EXEC   sp_addextendedproperty 'MS_Description', 'C66', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C66]				
EXEC   sp_addextendedproperty 'MS_Description', 'C67', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C67]				
EXEC   sp_addextendedproperty 'MS_Description', 'C68', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C68]				
EXEC   sp_addextendedproperty 'MS_Description', 'C69', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C69]				
EXEC   sp_addextendedproperty 'MS_Description', 'C70', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C70]				
EXEC   sp_addextendedproperty 'MS_Description', 'C71', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C71]				
EXEC   sp_addextendedproperty 'MS_Description', 'C72', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C72]				
EXEC   sp_addextendedproperty 'MS_Description', 'C73', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C73]				
EXEC   sp_addextendedproperty 'MS_Description', 'C74', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C74]				
EXEC   sp_addextendedproperty 'MS_Description', 'C75', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C75]				
EXEC   sp_addextendedproperty 'MS_Description', 'C76', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C76]				
EXEC   sp_addextendedproperty 'MS_Description', 'C77', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C77]				
EXEC   sp_addextendedproperty 'MS_Description', 'C78', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C78]				
EXEC   sp_addextendedproperty 'MS_Description', 'C79', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C79]				
EXEC   sp_addextendedproperty 'MS_Description', 'C80', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[C80]				
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[PACK_STR]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[PACK_CNT]			
EXEC   sp_addextendedproperty 'MS_Description', '고객주문번호', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[CLGO_SEQ]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[QTY_INV]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[DELI_TYPE]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[SNO]				
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[ORD_SNO]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[SPROD_CNT]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[REF_KEY]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[QTY_JEGO]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[QTY_CLGO]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[DUP_TYPE]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[CANCEL_YN_DTL]		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[SPROD_CNT_GIFT]	
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[FLG_INT]			
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[QTY_ORDER]			
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[ADDUSERCD]    		
EXEC   sp_addextendedproperty 'MS_Description', '등록일시',  'user', dbo, 'table', [ORDERFILEDTL], 'column',	[ADDDATETIME] 		
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [ORDERFILEDTL], 'column',	[UPDUSERCD]   		
EXEC   sp_addextendedproperty 'MS_Description', '수정일시',  'user', dbo, 'table', [ORDERFILEDTL], 'column',	[UPDDATETIME] 		
EXEC   sp_addextendedproperty 'MS_Description', 'IP',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[TERMINALCD] 

--EXEC   sp_addextendedproperty 'MS_Description', '',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[RELAY_SEQ]
EXEC   sp_addextendedproperty 'MS_Description', '박스명',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[BOX_NM]
EXEC   sp_addextendedproperty 'MS_Description', '인터페이스여부',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[INTF_YN]
EXEC   sp_addextendedproperty 'MS_Description', '품목코드(단품,복합)',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[PROD_CD]
EXEC   sp_addextendedproperty 'MS_Description', '품목명(단품,복함)',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[PROD_NM]
EXEC   sp_addextendedproperty 'MS_Description', '주문수량',     'user', dbo, 'table', [ORDERFILEDTL], 'column',	[QTY]

GO


/* 애터미 임시주문 마스터 */
CREATE TABLE [dbo].[OrderFileAtomy](
	[reg_seq_tmp] [int] IDENTITY(100000,1) NOT NULL,
	[comp_cd] [varchar](30) NULL,
	[file_ymd] [varchar](8) NULL,
	[file_seq] [int] NULL,
	[file_nm] [varchar](300) NULL,
	[file_nm_real] [varchar](300) NULL,
	[site_cd] [varchar](30) NULL,
	[deli_cd] [varchar](30) NULL,
	[in_ymdh] [varchar](14) NULL,
	[in_admin_id] [varchar](30) NULL,
	[status_cd] [varchar](5) NULL DEFAULT ('00000'),
	[pickup_status] [varchar](5) NULL,
	[pickup_cnt] [int] NULL,
	[pickup_admin_id] [varchar](30) NULL,
	[pickup_ymdh] [varchar](14) NULL DEFAULT (replace(replace(replace(convert(char(19),getdate(),20),':',''),'-',''),' ',''))
) ON [PRIMARY]

GO
CREATE CLUSTERED INDEX [idx_OrderFileAtomy] ON [dbo].[OrderFileAtomy]
(
	[reg_seq_tmp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO



EXEC   sp_addextendedproperty 'MS_Description', '애터미 임시주문 마스터', 'user', dbo, 'table', [OrderFileAtomy]


/* 애터미 임시주문 상세 */
CREATE TABLE [dbo].[OrderFileDtlAtomy](
	[reg_seq_tmp] [int] NULL,
	[c00] [int] IDENTITY(1,1) NOT NULL,
	[c01] [varchar](1000) NULL,
	[c02] [varchar](1000) NULL,
	[c03] [varchar](1000) NULL,
	[c04] [varchar](1000) NULL,
	[c05] [varchar](1000) NULL,
	[c06] [varchar](1000) NULL,
	[c07] [varchar](1000) NULL,
	[c08] [varchar](1000) NULL,
	[c09] [varchar](1000) NULL,
	[c10] [varchar](1000) NULL,
	[c11] [varchar](1000) NULL,
	[c12] [varchar](1000) NULL,
	[c13] [varchar](1000) NULL,
	[c14] [varchar](1000) NULL,
	[c15] [varchar](1000) NULL,
	[c16] [varchar](1000) NULL,
	[c17] [varchar](1000) NULL,
	[c18] [varchar](1000) NULL,
	[c19] [varchar](1000) NULL,
	[c20] [varchar](1000) NULL,
	[c21] [varchar](1000) NULL,
	[c22] [varchar](1000) NULL,
	[c23] [varchar](1000) NULL,
	[c24] [varchar](1000) NULL,
	[c25] [varchar](1000) NULL,
	[c26] [varchar](1000) NULL,
	[c27] [varchar](1000) NULL,
	[c28] [varchar](1000) NULL,
	[c29] [varchar](1000) NULL,
	[c30] [varchar](1000) NULL,
	[c31] [varchar](1000) NULL,
	[c32] [varchar](1000) NULL,
	[c33] [varchar](1000) NULL,
	[c34] [varchar](1000) NULL,
	[c35] [varchar](1000) NULL,
	[c36] [varchar](1000) NULL,
	[c37] [varchar](1000) NULL,
	[c38] [varchar](1000) NULL,
	[c39] [varchar](1000) NULL,
	[c40] [varchar](1000) NULL,
	[c41] [varchar](1000) NULL,
	[c42] [varchar](1000) NULL,
	[c43] [varchar](1000) NULL,
	[c44] [varchar](1000) NULL,
	[c45] [varchar](1000) NULL,
	[c46] [varchar](1000) NULL,
	[c47] [varchar](1000) NULL,
	[c48] [varchar](1000) NULL,
	[c49] [varchar](1000) NULL,
	[c50] [varchar](1000) NULL,
	[c51] [varchar](1000) NULL,
	[c52] [varchar](1000) NULL,
	[c53] [varchar](1000) NULL,
	[c54] [varchar](1000) NULL,
	[c55] [varchar](1000) NULL,
	[c56] [varchar](1000) NULL,
	[c57] [varchar](1000) NULL,
	[c58] [varchar](1000) NULL,
	[c59] [varchar](1000) NULL,
	[c60] [varchar](1000) NULL,
	[c61] [varchar](1000) NULL,
	[c62] [varchar](1000) NULL,
	[c63] [varchar](1000) NULL,
	[c64] [varchar](1000) NULL,
	[c65] [varchar](1000) NULL,
	[c66] [varchar](1000) NULL,
	[c67] [varchar](1000) NULL,
	[c68] [varchar](1000) NULL,
	[c69] [varchar](1000) NULL,
	[c70] [varchar](1000) NULL,
	[c71] [varchar](1000) NULL,
	[c72] [varchar](1000) NULL,
	[c73] [varchar](1000) NULL,
	[c74] [varchar](1000) NULL,
	[c75] [varchar](1000) NULL,
	[c76] [varchar](1000) NULL,
	[c77] [varchar](1000) NULL,
	[c78] [varchar](1000) NULL,
	[c79] [varchar](1000) NULL,
	[c80] [varchar](1000) NULL,
	[pack_str] [varchar](1000) NULL,
	[pack_cnt] [int] NULL,
	[clgo_seq] [int] NULL,
	[qty_inv] [int] NULL,
	[deli_type] [varchar](10) NULL,
	[sno] [int] NULL,
	[ord_sno] [varchar](30) NULL,
	[sprod_cnt] [int] NULL,
	[ref_key] [int] NULL,
	[qty_jego] [int] NULL,
	[qty_clgo] [int] NULL,
	[dup_type] [int] NULL CONSTRAINT [DF__orderfileatomy__dup_t__61F08603]  DEFAULT (0),
	[cancel_yn_dtl] [varchar](1) NULL CONSTRAINT [DF__orderfileatomy__cance__4F12BBB9]  DEFAULT ('N'),
	[sprod_cnt_gift] [int] NULL,
	[wh_cd] [varchar](30) NULL,
	[wh_gb] [varchar](30) NULL,
	[centor_hap] [varchar](1000) NULL,
	[seq_type] [int] NULL DEFAULT (0),
	[iljuk_yn] [varchar](1) NULL DEFAULT ('N'),
	[invc_yn] [varchar](1) NULL DEFAULT ('N'),
	[each_clgo_yn] [varchar](1) NULL DEFAULT ('N'),
	[jego_yn] [varchar](1) NULL CONSTRAINT [DF_OrderFileDtlAtomy_jego_yn]  DEFAULT ('Y'),
	[gtl_yn] [varchar](1) NULL CONSTRAINT [DF_OrderFileDtlAtomy_gtl_yn]  DEFAULT ('N'),
	[vol_each] [decimal](20, 0) NULL DEFAULT (0),
	[vol_invc] [decimal](20, 0) NULL DEFAULT (0),
	[box_cnt] [int] NULL DEFAULT (0),
	[center_yn] [varchar](1) NULL DEFAULT ('N'),
	[each_hap_yn] [varchar](1) NULL DEFAULT ('N'),
	[each_hap_cnt] [int] NULL DEFAULT (0),
	[sprod_cd] [varchar](50) NULL,
	[GTL_END_NO] [varchar](5) NULL,
	[max_side] [int] NULL DEFAULT (0),
	[box_nm] [varchar](30) NULL,
	[book_yn] [varchar](1) NULL DEFAULT ('N'),
	[card_yn] [varchar](1) NULL DEFAULT ('N'),
	[BOX_YN] [varchar](1) NULL CONSTRAINT [DF_OrderFileDtlAtomy_BOX_YN]  DEFAULT ('N')
) ON [PRIMARY]

GO

CREATE CLUSTERED INDEX [OrderFileDtlAtomy_idx1] ON [dbo].[OrderFileDtlAtomy]
(
	[reg_seq_tmp] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO


CREATE NONCLUSTERED INDEX [OrderFileDtlatomy_idx2] ON [dbo].[OrderFileDtlAtomy]
(
	[ord_sno] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO


CREATE NONCLUSTERED INDEX [OrderFileDtlatomy_idx3] ON [dbo].[OrderFileDtlAtomy]
(
	[clgo_seq] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO


EXEC   sp_addextendedproperty 'MS_Description', '애터미 임시주문 상세', 'user', dbo, 'table', [OrderFileDtlAtomy]




/*택배사정보*/
CREATE TABLE [dbo].[DELIDEF](
	[DELI_CD] [nvarchar](5) NULL,
	[DELI_NM] [nvarchar](50) NULL,
	[ACTIVE_YN] [nvarchar](1) NULL,
	[TRACKING_URL] [nvarchar](300) NULL,
	[IN_YMDH] [nvarchar](14) NULL
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'택배사마스터' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DELIDEF'
/*컬럼들*/
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'택배사코드' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DELIDEF', @level2type=N'COLUMN',@level2name=N'DELI_CD'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'택배사명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DELIDEF', @level2type=N'COLUMN',@level2name=N'DELI_NM'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용유무' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DELIDEF', @level2type=N'COLUMN',@level2name=N'ACTIVE_YN'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'택배조회사이트' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DELIDEF', @level2type=N'COLUMN',@level2name=N'TRACKING_URL'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'날짜' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DELIDEF', @level2type=N'COLUMN',@level2name=N'IN_YMDH'
GO

/*택배사송장파일매핑마스터*/
CREATE TABLE [dbo].[DELIFILE](
	[FILE_SNO] [int] IDENTITY(1,1) NOT NULL,
	[FILE_NM] [varchar](300) NULL,
	[REG_SEQ] [int] NULL,
	[IN_YMDH] [varchar](14) NULL,
	[IN_ADMIN_ID] [varchar](30) NULL,
	[REG_SEQS] [varchar](1000) NULL,
	[ORD_NAME] [nvarchar](100) NULL,
 CONSTRAINT [PK_DELIFILE] PRIMARY KEY CLUSTERED 
(
	[FILE_SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DELIFILE] ADD  CONSTRAINT [DF_DELIFILE_IN_YMDH]  DEFAULT (replace(replace(replace(CONVERT([char](19),getdate(),(20)),':',''),'-',''),' ','')) FOR [IN_YMDH]
GO

CREATE NONCLUSTERED INDEX [DeliFile_idx1] ON [dbo].[DeliFile]
(
	[reg_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC sp_addextendedproperty 'MS_Description', '송장파일매핑마스터' , 'user','dbo', 'TABLE',[DELIFILE]
/*컬럼들*/
EXEC sp_addextendedproperty 'MS_Description', '차수' , 'user','dbo', 'TABLE',[DELIFILE], 'COLUMN',[FILE_SNO]
EXEC sp_addextendedproperty 'MS_Description', '파일명' , 'user','dbo', 'TABLE',[DELIFILE], 'COLUMN',[FILE_NM]
EXEC sp_addextendedproperty 'MS_Description', '주문키' , 'user','dbo', 'TABLE',[DELIFILE], 'COLUMN',[REG_SEQ]
EXEC sp_addextendedproperty 'MS_Description', '날짜' , 'user','dbo', 'TABLE',[DELIFILE], 'COLUMN',[IN_YMDH]
EXEC sp_addextendedproperty 'MS_Description', '등록자' , 'user','dbo', 'TABLE',[DELIFILE], 'COLUMN',[IN_ADMIN_ID]
GO

/*택배사송장파일매핑디테일*/
CREATE TABLE [dbo].[DELIFILEDTL](
	[FILE_SNO] [int] NULL,
	[CLGO_SEQ] [int] NULL,
	[INVC_SNO] [varchar](30) NULL,
	[FARE] [int] NULL,
	[FARE_AIR] [int] NULL,
	[FARE_SHIP] [int] NULL,
	[IN_ADMIN_ID] [varchar](30) NULL,
	[ORD_NAME] [nvarchar](100) NULL
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [idx_delifiledtl_clgoseq] ON [dbo].[DeliFileDtl]
(
	[clgo_seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC sp_addextendedproperty 'MS_Description', '송장파일매핑디테일' ,'user', 'dbo', 'TABLE',[DELIFILEDT]
/*컬럼들*/
EXEC sp_addextendedproperty 'MS_Description', '차수' ,'user', 'dbo', 'TABLE',[DELIFILEDTL], 'COLUMN', [FILE_SNO]
EXEC sp_addextendedproperty 'MS_Description', '출고번호' ,'user', 'dbo', 'TABLE',[DELIFILEDTL], 'COLUMN',[CLGO_SEQ]
EXEC sp_addextendedproperty 'MS_Description', '송장번호' ,'user', 'dbo', 'TABLE',[DELIFILEDTL], 'COLUMN',[INVC_SNO]
EXEC sp_addextendedproperty 'MS_Description', '운임단가' ,'user', 'dbo', 'TABLE',[DELIFILEDTL], 'COLUMN',[FARE]
EXEC sp_addextendedproperty 'MS_Description', '항공운임' ,'user', 'dbo', 'TABLE',[DELIFILEDTL], 'COLUMN',[FARE_AIR]
EXEC sp_addextendedproperty 'MS_Description', '등록자' , 'user','dbo', 'TABLE',[DELIFILEDTL], 'COLUMN',[IN_ADMIN_ID]
GO


/*택배사송장파일매핑임시저장테이블*/
CREATE TABLE [dbo].[POPTMPORD](
	[A] [nvarchar](100) NULL,
	[B] [nvarchar](100) NULL,
	[C] [nvarchar](100) NULL,
	[D] [nvarchar](100) NULL,
	[E] [nvarchar](100) NULL,
	[F] [nvarchar](100) NULL,
	[G] [nvarchar](100) NULL,
	[H] [nvarchar](100) NULL,
	[I] [nvarchar](100) NULL,
	[J] [nvarchar](100) NULL,
	[K] [nvarchar](100) NULL,
	[L] [nvarchar](100) NULL,
	[M] [nvarchar](100) NULL,
	[N] [nvarchar](100) NULL,
	[O] [nvarchar](100) NULL,
	[P] [nvarchar](100) NULL,
	[Q] [nvarchar](100) NULL,
	[R] [nvarchar](100) NULL,
	[S] [nvarchar](100) NULL,
	[T] [nvarchar](100) NULL,
	[U] [nvarchar](100) NULL,
	[V] [nvarchar](100) NULL,
	[W] [nvarchar](100) NULL,
	[X] [nvarchar](100) NULL,
	[Y] [nvarchar](100) NULL,
	[Z] [nvarchar](100) NULL,
	[AA] [nvarchar](100) NULL,
	[AB] [nvarchar](100) NULL,
	[AC] [nvarchar](100) NULL,
	[AD] [nvarchar](100) NULL,
	[AE] [nvarchar](100) NULL,
	[AF] [nvarchar](100) NULL,
	[AG] [nvarchar](100) NULL,
	[AH] [nvarchar](100) NULL,
	[AI] [nvarchar](100) NULL,
	[AJ] [nvarchar](100) NULL,
	[AK] [nvarchar](100) NULL,
	[AL] [nvarchar](100) NULL,
	[AM] [nvarchar](100) NULL,
	[AN] [nvarchar](100) NULL,
	[AO] [nvarchar](100) NULL,
	[AP] [nvarchar](100) NULL,
	[AQ] [nvarchar](100) NULL,
	[AR] [nvarchar](100) NULL,
	[AS] [nvarchar](100) NULL,
	[AT] [nvarchar](100) NULL,
	[AU] [nvarchar](100) NULL,
	[AV] [nvarchar](100) NULL,
	[AW] [nvarchar](100) NULL,
	[AX] [nvarchar](100) NULL,
	[AY] [nvarchar](100) NULL,
	[AZ] [nvarchar](100) NULL,
	[REG_SEQ] [int] NULL,
	[ADDUSERCD] [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL,
	[UPDUSERCD] [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL,
	[TERMINALCD] [nvarchar](50) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[POPTMPORD] ADD  DEFAULT (getdate()) FOR [ADDDATETIME]
GO

ALTER TABLE [dbo].[POPTMPORD] ADD  DEFAULT (getdate()) FOR [UPDDATETIME]
GO

/*테이블*/
EXEC sp_addextendedproperty 'MS_Description', '택배사송장파일임시테이블' , 'user','dbo', 'TABLE',[POPTMPORD]
/*컬럼*/
EXEC sp_addextendedproperty 'MS_Description', 'A' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[A]
EXEC sp_addextendedproperty 'MS_Description', 'B' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[B]
EXEC sp_addextendedproperty 'MS_Description', 'C' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[C]
EXEC sp_addextendedproperty 'MS_Description', 'D' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[D]
EXEC sp_addextendedproperty 'MS_Description', 'E' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[E]
EXEC sp_addextendedproperty 'MS_Description', 'F' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[F]
EXEC sp_addextendedproperty 'MS_Description', 'G' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[G]
EXEC sp_addextendedproperty 'MS_Description', 'H' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[H]
EXEC sp_addextendedproperty 'MS_Description', 'I' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[I]
EXEC sp_addextendedproperty 'MS_Description', 'J' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[J]
EXEC sp_addextendedproperty 'MS_Description', 'K' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[K]
EXEC sp_addextendedproperty 'MS_Description', 'L' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[L]
EXEC sp_addextendedproperty 'MS_Description', 'M' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[M]
EXEC sp_addextendedproperty 'MS_Description', 'N' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[N]
EXEC sp_addextendedproperty 'MS_Description', 'O' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[O]
EXEC sp_addextendedproperty 'MS_Description', 'P' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[P]
EXEC sp_addextendedproperty 'MS_Description', 'Q' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[Q]
EXEC sp_addextendedproperty 'MS_Description', 'R' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[R]
EXEC sp_addextendedproperty 'MS_Description', 'S' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[S]
EXEC sp_addextendedproperty 'MS_Description', 'T' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[T]
EXEC sp_addextendedproperty 'MS_Description', 'U' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[U]
EXEC sp_addextendedproperty 'MS_Description', 'V' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[V]
EXEC sp_addextendedproperty 'MS_Description', 'W' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[W]
EXEC sp_addextendedproperty 'MS_Description', 'X' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[X]
EXEC sp_addextendedproperty 'MS_Description', 'Y' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[Y]
EXEC sp_addextendedproperty 'MS_Description', 'Z' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[Z]
EXEC sp_addextendedproperty 'MS_Description', 'AA' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AA]
EXEC sp_addextendedproperty 'MS_Description', 'AB' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AB]
EXEC sp_addextendedproperty 'MS_Description', 'AC' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AC]
EXEC sp_addextendedproperty 'MS_Description', 'AD' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AD]
EXEC sp_addextendedproperty 'MS_Description', 'AE' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AE]
EXEC sp_addextendedproperty 'MS_Description', 'AF' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AF]
EXEC sp_addextendedproperty 'MS_Description', 'AG' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AG]
EXEC sp_addextendedproperty 'MS_Description', 'AH' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AH]
EXEC sp_addextendedproperty 'MS_Description', 'AI' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AI]
EXEC sp_addextendedproperty 'MS_Description', 'AJ' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AJ]
EXEC sp_addextendedproperty 'MS_Description', 'AK' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AK]
EXEC sp_addextendedproperty 'MS_Description', 'AL' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AL]
EXEC sp_addextendedproperty 'MS_Description', 'AM' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AM]
EXEC sp_addextendedproperty 'MS_Description', 'AN' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AN]
EXEC sp_addextendedproperty 'MS_Description', 'AO' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AO]
EXEC sp_addextendedproperty 'MS_Description', 'AP' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AP]
EXEC sp_addextendedproperty 'MS_Description', 'AQ' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AQ]
EXEC sp_addextendedproperty 'MS_Description', 'AR' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AR]
EXEC sp_addextendedproperty 'MS_Description', 'AS' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AS]
EXEC sp_addextendedproperty 'MS_Description', 'AT' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AT]
EXEC sp_addextendedproperty 'MS_Description', 'AU' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AU]
EXEC sp_addextendedproperty 'MS_Description', 'AV' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AV]
EXEC sp_addextendedproperty 'MS_Description', 'AW' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AW]
EXEC sp_addextendedproperty 'MS_Description', 'AX' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AX]
EXEC sp_addextendedproperty 'MS_Description', 'AY' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AY]
EXEC sp_addextendedproperty 'MS_Description', 'AZ' , 'user','dbo', 'TABLE', [POPTMPORD], 'COLUMN',[AZ]
EXEC sp_addextendedproperty 'MS_Description', '주문키' , 'user', 'dbo', 'TABLE',[POPTMPORD], 'COLUMN', [REG_SEQ]
EXEC sp_addextendedproperty 'MS_Description', '등록자ID' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[ADDUSERCD]
EXEC sp_addextendedproperty 'MS_Description', '등록일시' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[ADDDATETIME]
EXEC sp_addextendedproperty 'MS_Description', '수정자ID' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[UPDUSERCD]
EXEC sp_addextendedproperty 'MS_Description', '수정일시' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[UPDDATETIME]
EXEC sp_addextendedproperty 'MS_Description', 'IP' , 'user','dbo', 'TABLE',[POPTMPORD], 'COLUMN',[TERMINALCD]
GO

/*차수분리임시테이블*/
CREATE TABLE [dbo].[TMPORDDIV](
	[COMPCD] [nvarchar](20) NULL,
	[ORGCD] [nvarchar](20) NULL,
	[REG_SEQ] [decimal](10, 0) NULL,
	[ITEMCD] [nvarchar](20) NULL,
	[SNO] [decimal](10, 0) NULL
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC sp_addextendedproperty 'MS_Description', '차수분리임시테이블' ,'user' , 'dbo', 'TABLE',[TMPORDDIV]
/*컬럼들*/
EXEC sp_addextendedproperty 'MS_Description', '회사코드', 'user','dbo', 'TABLE', [TMPORDDIV], 'COLUMN',[COMPCD]
EXEC sp_addextendedproperty 'MS_Description', '셀러코드', 'user','dbo', 'TABLE', [TMPORDDIV], 'COLUMN',[ORGCD]
EXEC sp_addextendedproperty 'MS_Description', '주문마스터키', 'user','dbo', 'TABLE', [TMPORDDIV], 'COLUMN',[REG_SEQ]
EXEC sp_addextendedproperty 'MS_Description', '품목코드', 'user','dbo', 'TABLE', [TMPORDDIV], 'COLUMN',[ITEMCD]
EXEC sp_addextendedproperty 'MS_Description', '주문순번', 'user','dbo', 'TABLE', [TMPORDDIV], 'COLUMN',[SNO]
GO

