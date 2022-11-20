
-- 현재고
CREATE TABLE [dbo].[P810](																									
	[COMPCD]      [nvarchar](20) NOT NULL,																								
	[ORGCD]       [nvarchar](20) NOT NULL,																								
	[WHCD]        [nvarchar](20) NOT NULL,																								
	[LOCCD]       [nvarchar](20) NOT NULL,																						
	[ITEMCD]      [nvarchar](20) NOT NULL,
	[LOTKEY]      [nvarchar](20) NOT NULL,
	[QTY]         [decimal](17,6) NULL,																								
	[ALLOCQTY]    [decimal](17,6) NULL,																							
    [ADDUSERCD]   [nvarchar](20) NULL,
    [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
    [UPDUSERCD]   [nvarchar](20) NULL,
    [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
    [TERMINALCD]  [nvarchar](50) NULL,																							
 CONSTRAINT [PK_P810] PRIMARY KEY CLUSTERED 																									
(																									
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[LOCCD] ASC,
	[ITEMCD] ASC,
	[LOTKEY] ASC																				
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]																									
) ON [PRIMARY]																																																	
GO				

ALTER TABLE [dbo].[P810]  WITH CHECK ADD  CONSTRAINT [FK_P810_01] FOREIGN KEY([COMPCD], [ORGCD], [ITEMCD])
REFERENCES [dbo].[P006] ([COMPCD], [ORGCD], [ITEMCD])
GO

ALTER TABLE [dbo].[P810] CHECK CONSTRAINT [FK_P810_01]
GO

ALTER TABLE [dbo].[P810]  WITH CHECK ADD  CONSTRAINT [FK_P810_02] FOREIGN KEY([LOTKEY])
REFERENCES [dbo].[P007] ([LOTKEY])
GO

ALTER TABLE [dbo].[P810] CHECK CONSTRAINT [FK_P810_02]
GO

ALTER TABLE [dbo].[P810]  WITH CHECK ADD  CONSTRAINT [FK_P810_03] FOREIGN KEY([COMPCD], [WHCD], [LOCCD])
REFERENCES [dbo].[P005] ([COMPCD], [WHCD], [LOCCD])
GO

ALTER TABLE [dbo].[P810] CHECK CONSTRAINT [FK_P810_03]
GO																
				
-- LOCK_ESCALATION DISABLE 
ALTER TABLE P810 SET ( LOCK_ESCALATION = DISABLE )
GO
/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '재고', 'user', dbo, 'table',[P810]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P810], 'column', COMPCD																						
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P810], 'column', ORGCD																							
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P810], 'column', WHCD																							
EXEC   sp_addextendedproperty 'MS_Description', '로케이션코드', 'user', dbo, 'table', [P810], 'column', LOCCD																							
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P810], 'column', ITEMCD																							
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P810], 'column', LOTKEY																							
EXEC   sp_addextendedproperty 'MS_Description', '재고수량', 'user', dbo, 'table', [P810], 'column', QTY																							
EXEC   sp_addextendedproperty 'MS_Description', '할당수량', 'user', dbo, 'table', [P810], 'column', ALLOCQTY																							
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P810], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P810], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P810], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P810], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P810], 'column', TERMINALCD																									
GO
																						
/*																									
	2. 주석수정 (update)																								
EXEC   sp_updateextendedproperty 'MS_Description', '재고', 'user', dbo, 'table',[P810]																									
EXEC   sp_updateextendedproperty 'MS_Description', '컬럼설명', 'user', dbo, 'table', 테이블명, 'column', 컬럼명																									
*/																									


-- 재고이력                       
CREATE TABLE [dbo].[P811](
   [SHKEY]       [nvarchar](20) NOT NULL,
   [TYPE]        [nvarchar](20) NOT NULL,
   [IOTYPE]      [nvarchar](5) NOT NULL,
   [IOFLG]       [nvarchar](1) NOT NULL,
   [IOKEY]       [nvarchar](20) NULL,
   [IOSEQ]       [decimal](10,0) NULL,
   [WORKKEY]     [nvarchar](20) NULL,
   [COMPCD]      [nvarchar](20) NULL,
   [ORGCD]       [nvarchar](20) NULL,
   [CUSTCD]		 [nvarchar](20) NULL,
   [WHCD]		 [nvarchar](20) NULL,
   [LOCCD]		 [nvarchar](20) NULL,
   [ITEMCD]      [nvarchar](20) NOT NULL,
   [LOTKEY]      [nvarchar](20) NULL,
   [QTY]         [decimal](17,6) NULL,
   [BEFOREQTY]   [decimal](17,6) NULL,
   [AFTERQTY]    [decimal](17,6) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P811] PRIMARY KEY CLUSTERED
(
   [SHKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P811_01] ON [dbo].[P811]
(
	[IOKEY] ASC,
	[IOSEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO	

CREATE NONCLUSTERED INDEX [IDX_P811_02] ON [dbo].[P811]
(
	[WORKKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO	

CREATE NONCLUSTERED INDEX [IDX_P811_03] ON [dbo].[P811]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[ITEMCD] ASC,
	[ADDDATETIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO	

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P811 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고이력', 'user', dbo, 'table',[P811]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '재고이력번호', 'user', dbo, 'table', [P811], 'column', [SHKEY]
EXEC   sp_addextendedproperty 'MS_Description', '유형(WI, WO)', 'user', dbo, 'table', [P811], 'column', [TYPE]     
EXEC   sp_addextendedproperty 'MS_Description', '입출고유형', 'user', dbo, 'table', [P811], 'column', [IOTYPE]
EXEC   sp_addextendedproperty 'MS_Description', '재고증감(1:증가, 0:감소)', 'user', dbo, 'table', [P811], 'column', [IOFLG] 
EXEC   sp_addextendedproperty 'MS_Description', '전표번호', 'user', dbo, 'table', [P811], 'column', [IOKEY]      
EXEC   sp_addextendedproperty 'MS_Description', '전표일련번호', 'user', dbo, 'table', [P811], 'column', [IOSEQ]      
EXEC   sp_addextendedproperty 'MS_Description', '작업번호(지시,피킹)', 'user', dbo, 'table', [P811], 'column', [WORKKEY]  
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P811], 'column', [COMPCD]   
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P811], 'column', [ORGCD]    
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P811], 'column', [CUSTCD]		
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P811], 'column', [WHCD]		
EXEC   sp_addextendedproperty 'MS_Description', '로케이션', 'user', dbo, 'table', [P811], 'column', [LOCCD]		
EXEC   sp_addextendedproperty 'MS_Description', '품목', 'user', dbo, 'table', [P811], 'column', [ITEMCD]   
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P811], 'column', [LOTKEY]   
EXEC   sp_addextendedproperty 'MS_Description', '수량', 'user', dbo, 'table', [P811], 'column', [QTY]      
EXEC   sp_addextendedproperty 'MS_Description', '이전재고수량', 'user', dbo, 'table', [P811], 'column', [BEFOREQTY]
EXEC   sp_addextendedproperty 'MS_Description', '이후재고수량', 'user', dbo, 'table', [P811], 'column', [AFTERQTY] 
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P811], 'column', REMARK 
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P811], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P811], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P811], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P811], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P811], 'column', TERMINALCD
GO