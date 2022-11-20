-- 박스관리
CREATE TABLE [dbo].[BOXSIZE](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[ORGCD]       [nvarchar](20) NOT NULL,
	[BOX_ID]      [nvarchar](30) NOT NULL,
	[BOX_NM]      [nvarchar](50) NULL,
	[BOX_SIZE_W]  [INT] NULL,
	[BOX_SIZE_B]  [INT] NULL,
	[BOX_SIZE_H]  [INT] NULL,
	[BOX_VOL]     [NUMERIC](15,0) NULL,
	[VOL_SEQ]     [INT] NULL,
	[END_DATE]    [nvarchar](8) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_BOXSIZE] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[BOX_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '회사', 'user', dbo, 'table',[BOXSIZE]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [BOXSIZE], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [BOXSIZE], 'column', [ORGCD]     
EXEC   sp_addextendedproperty 'MS_Description', '박스ID', 'user', dbo, 'table', [BOXSIZE], 'column', [BOX_ID]    
EXEC   sp_addextendedproperty 'MS_Description', '박스명', 'user', dbo, 'table', [BOXSIZE], 'column', [BOX_NM]    
EXEC   sp_addextendedproperty 'MS_Description', '가로', 'user', dbo, 'table', [BOXSIZE], 'column', [BOX_SIZE_W]
EXEC   sp_addextendedproperty 'MS_Description', '세로', 'user', dbo, 'table', [BOXSIZE], 'column', [BOX_SIZE_B]
EXEC   sp_addextendedproperty 'MS_Description', '높이', 'user', dbo, 'table', [BOXSIZE], 'column', [BOX_SIZE_H]
EXEC   sp_addextendedproperty 'MS_Description', '체적', 'user', dbo, 'table', [BOXSIZE], 'column', [BOX_VOL]   
EXEC   sp_addextendedproperty 'MS_Description', 'SEQ', 'user', dbo, 'table', [BOXSIZE], 'column', [VOL_SEQ]   
EXEC   sp_addextendedproperty 'MS_Description', '종료일', 'user', dbo, 'table', [BOXSIZE], 'column', [END_DATE]   
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [BOXSIZE], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [BOXSIZE], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [BOXSIZE], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [BOXSIZE], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [BOXSIZE], 'column', TERMINALCD
GO




-- 품목코드 MAP
--(단품,복합,대입 품목의 모든 코드 마스터 관리)
-- 신규 등록시 코드 체크를 PRODUCTMAP을 통해서 함
CREATE TABLE [dbo].[PRODUCTMAP](
	[COMPCD]       [nvarchar](20) NOT NULL,
	[ORGCD]        [nvarchar](20) NOT NULL,
	[MAP_PROD_CD]  [nvarchar](20) NOT NULL,
	[PROD_CD]      [nvarchar](20) NOT NULL,
	[PROD_TYPE_CD] [nvarchar](20) NULL,
	[ADDUSERCD]    [nvarchar](20) NULL,
	[ADDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]    [nvarchar](20) NULL,
	[UPDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]   [nvarchar](50) NULL,
 CONSTRAINT [PK_PRODUCTMAP] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[MAP_PROD_CD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목코드 MAP', 'user', dbo, 'table',[PRODUCTMAP]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [PRODUCTMAP], 'column', [COMPCD]           
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [PRODUCTMAP], 'column', [ORGCD]            
EXEC   sp_addextendedproperty 'MS_Description', '마스터코드(단품,복합,대입)', 'user', dbo, 'table', [PRODUCTMAP], 'column', [MAP_PROD_CD]      
EXEC   sp_addextendedproperty 'MS_Description', '품목코드(단품코드,복합코드)', 'user', dbo, 'table', [PRODUCTMAP], 'column', [PROD_CD]           
EXEC   sp_addextendedproperty 'MS_Description', '품목유형(00001:단품,00002:복합,00003:대입)', 'user', dbo, 'table', [PRODUCTMAP], 'column', [PROD_TYPE_CD]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [PRODUCTMAP], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [PRODUCTMAP], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [PRODUCTMAP], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [PRODUCTMAP], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [PRODUCTMAP], 'column', TERMINALCD
GO

-- 품목코드 마스터 
-- 단품,복합코드만 관리함
CREATE TABLE [dbo].[PRODUCT](
	[COMPCD]       [nvarchar](20) NOT NULL,
	[ORGCD]        [nvarchar](20) NOT NULL,
	[PROD_CD]      [nvarchar](20) NOT NULL,
	[PROD_NM]      [nvarchar](300) NULL,
	[PROD_TYPE_CD] [nvarchar](20) NULL,
	[MAX_CLGO_QTY] [INT] NULL DEFAULT (0),
	[ADDUSERCD]    [nvarchar](20) NULL,
	[ADDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]    [nvarchar](20) NULL,
	[UPDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]   [nvarchar](50) NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[PROD_CD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목코드마스터', 'user', dbo, 'table', [PRODUCT]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [PRODUCT], 'column', [COMPCD]           
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [PRODUCT], 'column', [ORGCD]            
EXEC   sp_addextendedproperty 'MS_Description', '품목코드(단품코드,복합코드)', 'user', dbo, 'table', [PRODUCT], 'column', [PROD_CD]           
EXEC   sp_addextendedproperty 'MS_Description', '품목명', 'user', dbo, 'table', [PRODUCT], 'column', [PROD_NM]           
EXEC   sp_addextendedproperty 'MS_Description', '품목유형(00001:단품,00002:복합,[00003:대입])', 'user', dbo, 'table', [PRODUCT], 'column', [PROD_TYPE_CD]
EXEC   sp_addextendedproperty 'MS_Description', '개별품목여부(0:아니오,1:예)', 'user', dbo, 'table', [PRODUCT], 'column', [MAX_CLGO_QTY]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [PRODUCT], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [PRODUCT], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [PRODUCT], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [PRODUCT], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [PRODUCT], 'column', TERMINALCD
GO

-- 복합품목 상세
CREATE TABLE [dbo].[PRODSPROD](
	[COMPCD]       [nvarchar](20) NOT NULL,
	[ORGCD]        [nvarchar](20) NOT NULL,
	[PROD_CD]      [nvarchar](20) NOT NULL,
	[ITEMCD]       [nvarchar](20) NOT NULL,
	[SPROD_QTY]    [INT] NULL DEFAULT (1),
	[REMARKS]      [nvarchar](250) NULL,
	[ADDUSERCD]    [nvarchar](20) NULL,
	[ADDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]    [nvarchar](20) NULL,
	[UPDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]   [nvarchar](50) NULL,
 CONSTRAINT [PK_PRODSPROD] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[PROD_CD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '복합품목상세', 'user', dbo, 'table',[PRODSPROD]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [PRODSPROD], 'column', [COMPCD]           
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [PRODSPROD], 'column', [ORGCD]            
EXEC   sp_addextendedproperty 'MS_Description', '복합코드', 'user', dbo, 'table', [PRODSPROD], 'column', [PROD_CD]            
EXEC   sp_addextendedproperty 'MS_Description', '단품코드', 'user', dbo, 'table', [PRODSPROD], 'column', [ITEMCD]            
EXEC   sp_addextendedproperty 'MS_Description', '입수량', 'user', dbo, 'table', [PRODSPROD], 'column', [SPROD_QTY]            
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [PRODSPROD], 'column', [REMARKS]            
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [PRODSPROD], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [PRODSPROD], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [PRODSPROD], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [PRODSPROD], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [PRODSPROD], 'column', TERMINALCD
GO


-- 품목바코드(단품기준으로만 등록됨)
CREATE TABLE [dbo].[SPRODBARCODE](
	[BARCODE]     [nvarchar](30) NOT NULL,
	[BARCODE_NM]  [nvarchar](100) NULL,
	[COMPCD]      [nvarchar](20) NOT NULL,
	[ORGCD]       [nvarchar](20) NOT NULL,
	[ITEMCD]      [nvarchar](20) NOT NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_SPRODBARCODE] PRIMARY KEY CLUSTERED
(
	[BARCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '회사', 'user', dbo, 'table',[SPRODBARCODE]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '바코드', 'user', dbo, 'table', [SPRODBARCODE], 'column', [BARCODE]     
EXEC   sp_addextendedproperty 'MS_Description', '바코드명', 'user', dbo, 'table', [SPRODBARCODE], 'column', [BARCODE_NM]     
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [SPRODBARCODE], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [SPRODBARCODE], 'column', [ORGCD]     
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [SPRODBARCODE], 'column', [ITEMCD]     
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [SPRODBARCODE], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [SPRODBARCODE], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [SPRODBARCODE], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [SPRODBARCODE], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [SPRODBARCODE], 'column', TERMINALCD
GO
/*
	2. 주석수정 (update)
EXEC   sp_updateextendedproperty 'MS_Description', '테이블설명', 'user', dbo, 'table',테이블명
EXEC   sp_updateextendedproperty 'MS_Description', '컬럼설명', 'user', dbo, 'table', 테이블명, 'column', 컬럼명
*/

/*변수설정*/
CREATE TABLE [dbo].[ENVDFLT](
	[IDX] 				[decimal](10,0) IDENTITY(1,1) NOT NULL,
	[ENV_CD] 			[nvarchar](30) NULL,
	[ENV_NM] 			[nvarchar](30) NULL,
	[DFLT_VAL] 			[nvarchar](30) NULL,
	[ALLOW_VALS] 		[nvarchar](500) NULL,
	[ENV_DESC] 			[nvarchar](500) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '변수설정', 'user', dbo, 'table',[ENVDFLT]
/*컬럼들*/	
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [ENVDFLT], 'column', [IDX]		
EXEC   sp_addextendedproperty 'MS_Description', '변수코드', 'user', dbo, 'table', [ENVDFLT], 'column', [ENV_CD]		
EXEC   sp_addextendedproperty 'MS_Description', '변수명', 'user', dbo, 'table', [ENVDFLT], 'column', [ENV_NM]		
EXEC   sp_addextendedproperty 'MS_Description', '기본값', 'user', dbo, 'table', [ENVDFLT], 'column', [DFLT_VAL]		
EXEC   sp_addextendedproperty 'MS_Description', 'selectbox값', 'user', dbo, 'table', [ENVDFLT], 'column', [ALLOW_VALS]		
EXEC   sp_addextendedproperty 'MS_Description', '변수코멘트', 'user', dbo, 'table', [ENVDFLT], 'column', [ENV_DESC]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [ENVDFLT], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [ENVDFLT], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [ENVDFLT], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [ENVDFLT], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [ENVDFLT], 'column', [TERMINALCD]	
GO	


/*변수설정데이터(셀러별)*/
CREATE TABLE [dbo].[ENVMY](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,
	[ENV_CD] 			[nvarchar](30) NULL,
	[ENV_VAL] 			[nvarchar](30) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
) ON [PRIMARY]
GO


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '변수설정데이터(셀러별)', 'user', dbo, 'table',[ENVMY]
/*컬럼들*/	
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [ENVMY], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [ENVMY], 'column', [ORGCD]	
EXEC   sp_addextendedproperty 'MS_Description', '변수코드', 'user', dbo, 'table', [ENVMY], 'column', [ENV_CD]		
EXEC   sp_addextendedproperty 'MS_Description', '변수값', 'user', dbo, 'table', [ENVMY], 'column', [ENV_VAL]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [ENVMY], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [ENVMY], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [ENVMY], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [ENVMY], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [ENVMY], 'column', [TERMINALCD]	
GO	



/*프린트설정*/
CREATE TABLE [dbo].[MACADDRE_PRINT](
	[IDX] 				[decimal](10,0) IDENTITY(1,1) NOT NULL,
	[MACADDRES]			[nvarchar](50) NULL,
	[LABELPRINT] 		[nvarchar](50) NULL,
	[DOCUMENTPRINT] 	[nvarchar](50) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
	
 CONSTRAINT [PK_MACADDRE_PRINT] PRIMARY KEY CLUSTERED 
(
	[MACADDRES] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '프린트설정', 'user', dbo, 'table',[MACADDRE_PRINT]
/*컬럼들*/	
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [IDX]							
EXEC   sp_addextendedproperty 'MS_Description', 'MAC ADDRESS', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [MACADDRES]	
EXEC   sp_addextendedproperty 'MS_Description', '라벨프린트', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [LABELPRINT]		
EXEC   sp_addextendedproperty 'MS_Description', '거래명세서 프린트', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [DOCUMENTPRINT]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [MACADDRE_PRINT], 'column', [TERMINALCD]	
GO	


/* 창고별 피킹렉 정보 */
CREATE TABLE [dbo].[WHITEMRACK](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[WHCD] 			    [nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,
	[ITEMCD] 			[nvarchar](20) NOT NULL,
	[CART_GROUP]		[nvarchar](30) NULL,
	[CART_RACK_NO]		[nvarchar](30) NULL,
	[DPS_GROUP]		    [nvarchar](30) NULL,
	[DPS_RACK_NO]		[nvarchar](30) NULL,
	[REMARK]            [nvarchar](200) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
	
 CONSTRAINT [PK_WHITEMRACK] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[WHCD] ASC,
	[ORGCD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '창고별 피킹렉 정보', 'user', dbo, 'table',[WHITEMRACK]
/*컬럼들*/	
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [WHITEMRACK], 'column', [COMPCD] 							
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [WHITEMRACK], 'column', [WHCD] 									
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [WHITEMRACK], 'column', [ORGCD] 								
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [WHITEMRACK], 'column', [ITEMCD] 							
EXEC   sp_addextendedproperty 'MS_Description', '카트작업그룹', 'user', dbo, 'table', [WHITEMRACK], 'column', [CART_GROUP]							
EXEC   sp_addextendedproperty 'MS_Description', '카트렉번호', 'user', dbo, 'table', [WHITEMRACK], 'column', [CART_RACK_NO]
EXEC   sp_addextendedproperty 'MS_Description', 'DPS작업그룹', 'user', dbo, 'table', [WHITEMRACK], 'column', [DPS_GROUP]
EXEC   sp_addextendedproperty 'MS_Description', 'DPS렉번호', 'user', dbo, 'table', [WHITEMRACK], 'column', [DPS_RACK_NO]							
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [WHITEMRACK], 'column', [REMARK] 							
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [WHITEMRACK], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [WHITEMRACK], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [WHITEMRACK], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [WHITEMRACK], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [WHITEMRACK], 'column', [TERMINALCD]	
GO	


CREATE TABLE [dbo].[WMS_POST_DELI_CJ](
	[ZIP_NO] [varchar](6) NOT NULL,
	[MAN_BRAN_NM] [varchar](200) NULL,
	[SIDO_ADDR] [varchar](200) NULL,
	[SKK_ADDR] [varchar](200) NULL,
	[DONG_ADDR] [varchar](200) NULL,
	[END_NO] [varchar](5) NULL,
	[SUB_END_NO] [varchar](5) NULL,
	[END_NM] [varchar](40) NULL,
	[CLDV_EMP_NM] [varchar](200) NULL,
	[MODI_YMD] [varchar](8) NOT NULL,
	[MODI_DTIME] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ZIP_NO] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[OrdWaiveAtomy](
	[idx] [int] IDENTITY(1000,1) NOT NULL,
	[order_sno] [varchar](30) NULL,
	[waive_msg] [varchar](300) NULL,
	[waive_ymd] [varchar](8) NULL,
	[proc_yn] [varchar](1) NULL DEFAULT ('N'),
	[waive_ymdh] [varchar](14) NULL DEFAULT (replace(replace(replace(convert(char(19),getdate(),20),':',''),'-',''),' ','')),
PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[CSMeMo](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[clgo_sno] [int] NULL,
	[in_ymdh] [varchar](14) NULL,
	[in_admin_id] [varchar](30) NULL,
	[memo_msg] [varchar](1000) NULL,
	[memo_gb] [varchar](5) NULL
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [idx_csmemo] ON [dbo].[CSMeMo]
(
	[clgo_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO