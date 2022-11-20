/*주문서양식(마스터)------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[MKTSITE](
	[COMPCD] 				[nvarchar](20) NOT NULL,
	[ORGCD] 				[nvarchar](20) NOT NULL,
	[SITE_CD] 				[nvarchar](5) NOT NULL,
	[SITE_NM] 				[nvarchar](50) NULL,
	[ACTIVE_YN] 			[nvarchar](1) NULL,
	[PUBLIC_YN] 			[nvarchar](1) NULL DEFAULT ('N'),
	[START_LINE_NO] 		[decimal](10, 0) NULL DEFAULT (2),
	[INVALID_ENDLINE_NO] 	[decimal](10, 0) NULL DEFAULT (0),
	[HDR_LINE_NO] 			[decimal](10, 0) NULL DEFAULT (1),
	[OP_TYPE] 				[nvarchar](1) NULL DEFAULT (1),
	[OUT_BLANK_LINE_NO] 	[decimal](10, 0) NULL DEFAULT (0),
	[OUT_HDR_YN] 			[nvarchar](1) NULL DEFAULT ('Y'),
	[SITE_NM_SHORT] 		[nvarchar](30) NULL,
	[SORT_SEQ] 				[decimal](10, 0) NULL,
	[OUT_FILE_TP] 			[nvarchar](10) NULL,
	[OUT_SHEET_NM]			[nvarchar](30) NULL,
	[URL_PROD_DTL] 			[nvarchar](500) NULL,
	[DAS_ALLOT_CNT] 		[decimal](10, 0) NULL DEFAULT (0),
	[DELI_SUB_CODE] 		[nvarchar](30) NULL,
	[DELI_SND_NM] 			[nvarchar](30) NULL,
	[DELI_SND_TEL] 			[nvarchar](30) NULL,
	[DELI_SND_ADDR] 		[nvarchar](300) NULL,
	[DELI_INVC_DIRECT_YN] 	[nvarchar](1) NULL DEFAULT ('N'),
	[DELI_GTL_YN]			[nvarchar](1) NULL DEFAULT ('N'),
	[DELI_SND_ZIPCODE] 		[nvarchar](10) NULL,
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL
 CONSTRAINT [PK_MKTSITE] PRIMARY KEY CLUSTERED 
(	
	[COMPCD] ASC,
	[ORGCD] ASC,
	[SITE_CD] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식(마스터)', 'user', dbo, 'table',[MKTSITE]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [MKTSITE], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [MKTSITE], 'column', [ORGCD]											
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식코드', 'user', dbo, 'table', [MKTSITE], 'column', [SITE_CD]						
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식명', 'user', dbo, 'table', [MKTSITE], 'column', [SITE_NM]						
EXEC   sp_addextendedproperty 'MS_Description', '활성화(Y/N)', 'user', dbo, 'table', [MKTSITE], 'column', [ACTIVE_YN]						
EXEC   sp_addextendedproperty 'MS_Description', '공개여부(Y/N)', 'user', dbo, 'table', [MKTSITE], 'column', [PUBLIC_YN]					
EXEC   sp_addextendedproperty 'MS_Description', '데이터시작행', 'user', dbo, 'table', [MKTSITE], 'column', [START_LINE_NO]					
EXEC   sp_addextendedproperty 'MS_Description', '무사할마지막행수', 'user', dbo, 'table', [MKTSITE], 'column', [INVALID_ENDLINE_NO]					
EXEC   sp_addextendedproperty 'MS_Description', '머릿글행', 'user', dbo, 'table', [MKTSITE], 'column', [HDR_LINE_NO] 			
EXEC   sp_addextendedproperty 'MS_Description', '치환후병합(TRUE:1/FALSE:0)', 'user', dbo, 'table', [MKTSITE], 'column', [OP_TYPE] 				
EXEC   sp_addextendedproperty 'MS_Description', '공개행수', 'user', dbo, 'table', [MKTSITE], 'column', [OUT_BLANK_LINE_NO] 	
EXEC   sp_addextendedproperty 'MS_Description', '헤드포함체크(Y/N)', 'user', dbo, 'table', [MKTSITE], 'column', [OUT_HDR_YN] 			
EXEC   sp_addextendedproperty 'MS_Description', '약식명', 'user', dbo, 'table', [MKTSITE], 'column', [SITE_NM_SHORT] 		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [MKTSITE], 'column', [SORT_SEQ] 				
EXEC   sp_addextendedproperty 'MS_Description', '파일타입', 'user', dbo, 'table', [MKTSITE], 'column', [OUT_FILE_TP] 			
EXEC   sp_addextendedproperty 'MS_Description', '시트명', 'user', dbo, 'table', [MKTSITE], 'column', [OUT_SHEET_NM]			
EXEC   sp_addextendedproperty 'MS_Description', '사이트URL', 'user', dbo, 'table', [MKTSITE], 'column', [URL_PROD_DTL] 			
EXEC   sp_addextendedproperty 'MS_Description', '주문서열카운트', 'user', dbo, 'table', [MKTSITE], 'column', [DAS_ALLOT_CNT] 		
EXEC   sp_addextendedproperty 'MS_Description', '발송코드', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_SUB_CODE] 		
EXEC   sp_addextendedproperty 'MS_Description', '발송자명', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_SND_NM] 			
EXEC   sp_addextendedproperty 'MS_Description', '발송자번호', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_SND_TEL] 			
EXEC   sp_addextendedproperty 'MS_Description', '발송자주소', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_SND_ADDR] 		
EXEC   sp_addextendedproperty 'MS_Description', '자체출력(Y/N)', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_INVC_DIRECT_YN] 	
EXEC   sp_addextendedproperty 'MS_Description', '사은품유무(Y/N)', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_GTL_YN]			
EXEC   sp_addextendedproperty 'MS_Description', '발송자우편번호', 'user', dbo, 'table', [MKTSITE], 'column', [DELI_SND_ZIPCODE] 	
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [MKTSITE], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [MKTSITE], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [MKTSITE], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [MKTSITE], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [MKTSITE], 'column', [TERMINALCD]	
GO	

/*주문서양식정보(디테일)------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[MKTSITEFILECONFIG](       
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,                                     
	[SITE_CD]			[nvarchar](5) NOT NULL,                      
	[COL_NO]			[decimal](10, 0) NOT NULL,                   
	[COL_NM]			[nvarchar](50) NULL,                         
	[COL_WIDTH]			[decimal](10, 0) NULL,                       
	[COL_TP]			[nvarchar](3) NULL DEFAULT ('STR'),       
	[NOTNULL_YN]		[nvarchar](1) NULL,                          
	[INVC_YN]			[nvarchar](1) NULL,                          
	[SORT_KEY_YN]		[nvarchar](50) NULL,                         
	[PROD_KEY_YN]		[nvarchar](500) NULL,                        
	[INV_QTY_YN]		[nvarchar](1) NULL,                          
	[DB_COL_NM]			[nvarchar](50) NOT NULL,                     
	[ALLOW_VALUE]		[nvarchar](100) NULL,                        
	[ORD_SNO_YN]		[nvarchar](1) NULL,                          
	[ORD_QTY_YN]		[nvarchar](1) NULL DEFAULT ('N'),            
	[ORD_AMT_YN]		[nvarchar](1) NULL DEFAULT ('N'),            
	[DB_COL_NM_INVC]	[nvarchar](30) NULL,                         
	[IPGO_AMT_YN]		[nvarchar](1) NULL DEFAULT ('N'),            
	[PROD_GIFT_YN]		[nvarchar](1) NULL DEFAULT ('N'),            
	[LOT_YN]			[nvarchar](1) NULL DEFAULT ('N'),            
	[CUST_YN]			[nvarchar](1) NULL DEFAULT ('N'),            
	[PACK_1]			[nvarchar](1) NULL DEFAULT ('N'),            
	[PACK_2]			[nvarchar](1) NULL DEFAULT ('N'),            
	[ADDUSERCD]			[nvarchar](20) NULL,                         
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),         
	[UPDUSERCD]			[nvarchar](20) NULL,                         
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),         
	[TERMINALCD]		[nvarchar](50) NULL                          
 CONSTRAINT [PK_MKTSITEFILECONFIG] PRIMARY KEY CLUSTERED 
(	
	[COMPCD] ASC,
	[ORGCD] ASC,
	[SITE_CD] ASC,
	[COL_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [MKTSITEFILECONFIG_IDX1] ON [dbo].[MKTSITEFILECONFIG]
(
	[SITE_CD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식정보(디테일)', 'user', dbo, 'table',[MKTSITEFILECONFIG]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ORGCD]										
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식코드', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [SITE_CD]						
EXEC   sp_addextendedproperty 'MS_Description', '헤더순번', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [COL_NO]						
EXEC   sp_addextendedproperty 'MS_Description', '헤더명', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [COL_NM]						
EXEC   sp_addextendedproperty 'MS_Description', '컬럼길이', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [COL_WIDTH]							
EXEC   sp_addextendedproperty 'MS_Description', '데이터형 (STR, INT)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [COL_TP]	
EXEC   sp_addextendedproperty 'MS_Description', 'NULL허용여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [NOTNULL_YN]					
EXEC   sp_addextendedproperty 'MS_Description', '송장여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [INVC_YN]					
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [SORT_KEY_YN] 			
EXEC   sp_addextendedproperty 'MS_Description', '상품코드여부(상품코드, 상품명, 모델명, 제품코드 등 )(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [PROD_KEY_YN] 	
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [INV_QTY_YN]
EXEC   sp_addextendedproperty 'MS_Description', '디비순번', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [DB_COL_NM] 	
EXEC   sp_addextendedproperty 'MS_Description', '택배비형태(선불,착불)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ALLOW_VALUE] 		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ORD_SNO_YN] 				
EXEC   sp_addextendedproperty 'MS_Description', '수량여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ORD_QTY_YN] 			
EXEC   sp_addextendedproperty 'MS_Description', '주문가격여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ORD_AMT_YN]		
EXEC   sp_addextendedproperty 'MS_Description', '매칭된 컬럼명코드', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [DB_COL_NM_INVC] 			
EXEC   sp_addextendedproperty 'MS_Description', '단품가격여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [IPGO_AMT_YN] 		
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [PROD_GIFT_YN] 		
EXEC   sp_addextendedproperty 'MS_Description', '로트지정여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [LOT_YN] 			
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드여부(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [CUST_YN] 		
EXEC   sp_addextendedproperty 'MS_Description', '합포장1(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [PACK_1] 		
EXEC   sp_addextendedproperty 'MS_Description', '합포장2(Y/N)', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [PACK_2] 	
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [MKTSITEFILECONFIG], 'column', [TERMINALCD]	
GO																																				

/*주문서셀병합------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[MKTSITEFILECOLEDIT1](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,  
	[IDX]			    [decimal](10, 0) IDENTITY(1,1) NOT NULL,
	[SITE_CD]		    [nvarchar](5) NULL,
	[TGT_COL]		    [nvarchar](30) NULL,
	[SRC_COLS]		    [nvarchar](30) NULL,
	[SRC_LOCS]		    [nvarchar](30) NULL,
	[SEPS]			    [nvarchar](5) NULL,      
	[ADDUSERCD]			[nvarchar](20) NULL,                         
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),         
	[UPDUSERCD]			[nvarchar](20) NULL,                         
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),         
	[TERMINALCD]		[nvarchar](50) NULL,
	[SRC_COLS1]		    [nvarchar](30) NULL,
	[SRC_COLS2]		    [nvarchar](30) NULL,
	[SRC_COLS3]		    [nvarchar](30) NULL,
	[SEPS1]			    [nvarchar](5) NULL,      
	[SEPS2]			    [nvarchar](5) NULL 
) ON [PRIMARY]

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '주문서셀병합', 'user', dbo, 'table',[MKTSITEFILECOLEDIT1]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [IDX]		
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식코드', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SITE_CD]					
EXEC   sp_addextendedproperty 'MS_Description', '기준열', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [TGT_COL]						
EXEC   sp_addextendedproperty 'MS_Description', '합쳐질열', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SRC_COLS]							
EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SRC_LOCS]	
EXEC   sp_addextendedproperty 'MS_Description', '구분자', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SEPS]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [TERMINALCD]					
EXEC   sp_addextendedproperty 'MS_Description', '합쳐질열1', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SRC_COLS1]					
EXEC   sp_addextendedproperty 'MS_Description', '합쳐질열2', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SRC_COLS2]					
EXEC   sp_addextendedproperty 'MS_Description', '합쳐질열3', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SRC_COLS3]	
EXEC   sp_addextendedproperty 'MS_Description', '구분자1', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SEPS1]		
EXEC   sp_addextendedproperty 'MS_Description', '구분자2', 'user', dbo, 'table', [MKTSITEFILECOLEDIT1], 'column', [SEPS2]		
GO	

/*주문서문자치환------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[MKTSITEFILECOLEDIT2](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,  	
	[IDX]				[decimal](10,0) IDENTITY(1,1) NOT NULL,
	[SITE_CD]			[nvarchar](5) NULL,
	[TGT_COL]			[nvarchar](30) NULL,
	[REPLACES1]			[nvarchar](3000) NULL,
	[REPLACES2]			[nvarchar](3000) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
) ON [PRIMARY]


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '주문서문자치환', 'user', dbo, 'table',[MKTSITEFILECOLEDIT2]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [IDX]		
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식코드', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [SITE_CD]					
EXEC   sp_addextendedproperty 'MS_Description', '대상열', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [TGT_COL]						
EXEC   sp_addextendedproperty 'MS_Description', '치환대상문자열(~을)', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [REPLACES1]							
EXEC   sp_addextendedproperty 'MS_Description', '치환문자열(~으로)', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [REPLACES2]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [MKTSITEFILECOLEDIT2], 'column', [TERMINALCD]	
GO																


/*업로드용양식------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [DBO].[MKTSITEEXPORTCONFIG](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,  	
	[SITE_CD]			[nvarchar](5) NOT NULL,
	[COL_NO]			[decimal](10,0) NOT NULL,
	[DB_COL_NM]			[nvarchar](100) NULL,
	[COL_ATTR]			[nvarchar](50) NULL,
	[COL_ATTR_VAL]		[nvarchar](50) NULL,
	[COL_NM]			[nvarchar](50) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
) ON [PRIMARY]


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '업로드용양식', 'user', dbo, 'table',[MKTSITEEXPORTCONFIG]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '주문서양식코드', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [SITE_CD]					
EXEC   sp_addextendedproperty 'MS_Description', '해더순서', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [COL_NO]						
EXEC   sp_addextendedproperty 'MS_Description', '디비순번', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [DB_COL_NM]							
EXEC   sp_addextendedproperty 'MS_Description', '주문서열코드', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [COL_ATTR]								
EXEC   sp_addextendedproperty 'MS_Description', '주문서열카운트', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [COL_ATTR_VAL]							
EXEC   sp_addextendedproperty 'MS_Description', '헤더명', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [COL_NM]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [MKTSITEEXPORTCONFIG], 'column', [TERMINALCD]	
GO							


/*택배사양식(마스터)------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[COMPDELI](
	[COMPCD] 				[nvarchar](20) NOT NULL,
	[ORGCD] 				[nvarchar](20) NOT NULL,
	[PACK_YN]				[nvarchar](1) NULL,
	[PACK_1]				[nvarchar](30) NULL,
	[PACK_2]				[nvarchar](30) NULL,
	[HDR_YN]				[nvarchar](1) NULL,
	[OP_RCV]				[nvarchar](30) NULL,
	[OP_RCV_ETC]			[nvarchar](30) NULL,
	[OP_SND_ETC]			[nvarchar](30) NULL,
	[OP_DTL]				[nvarchar](30) NULL,
	[SUNBUL_NM]				[nvarchar](30) NULL,
	[CHAKBUL_NM]			[nvarchar](30) NULL,
	[HDR_YN_INVC]			[nvarchar](1) NULL DEFAULT ('Y'),
	[COL_CLGO_SEQ]			[decimal](10,0) NULL DEFAULT (1),
	[COL_INVC_SNO]			[decimal](10,0) NULL DEFAULT (2),
	[COL_FARE]				[decimal](10,0) NULL DEFAULT (3),
	[COL_FARE_AIR]			[decimal](10,0) NULL DEFAULT (4),
	[COL_FARE_SHIP]			[decimal](10,0) NULL DEFAULT (5),
	[INVC_LEN]				[decimal](10,0) NULL DEFAULT (10),
	[INVC_MULTI_LINE_YN]	[nvarchar](1) NULL DEFAULT ('Y'),
	[INVC_PROD_DELIMETER]	[nvarchar](10) NULL DEFAULT ('▲'),
	[INVC_START_LINE]		[decimal](10,0) NULL DEFAULT (2),
	[SUNBUL_FEE]			[nvarchar](30) NULL,
	[CHAKBUL_FEE]			[nvarchar](30) NULL,
	[OP_LOC_PRN]			[nvarchar](1) NULL DEFAULT ('0'),
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL
 CONSTRAINT [PK_COMPDELI] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[ORGCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/* 인덱스*/
CREATE NONCLUSTERED INDEX [IDX_DELIFILE] ON [dbo].[COMPDELI]
(
	[COMPCD] ASC,
	[ORGCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '택배사양식설정', 'user', dbo, 'table',[COMPDELI]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [COMPDELI], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [COMPDELI], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '합포장여부(Y/N)', 'user', dbo, 'table', [COMPDELI], 'column', [PACK_YN]			
EXEC   sp_addextendedproperty 'MS_Description', '합포장컬럼1', 'user', dbo, 'table', [COMPDELI], 'column', [PACK_1]			
EXEC   sp_addextendedproperty 'MS_Description', '합포장컬럼2', 'user', dbo, 'table', [COMPDELI], 'column', [PACK_2]			
EXEC   sp_addextendedproperty 'MS_Description', '헤더출력여부(Y/N)', 'user', dbo, 'table', [COMPDELI], 'column', [HDR_YN]			
EXEC   sp_addextendedproperty 'MS_Description', '수취인명(rcv_nm:수취인명/ rcv_nm+ord_nm:수취인(주문자명))', 'user', dbo, 'table', [COMPDELI], 'column', [OP_RCV]			
EXEC   sp_addextendedproperty 'MS_Description', '수취인비고(clgo_seq:출고번호/ ord_snos:주문번호)', 'user', dbo, 'table', [COMPDELI], 'column', [OP_RCV_ETC]			
EXEC   sp_addextendedproperty 'MS_Description', '발송자비고(1:주문서약식명(포장물품개수/주문건수) / 2:주문번호 / 3:  주문서약식명-주문번호-포장물품개수/주문건수)', 'user', dbo, 'table', [COMPDELI], 'column', [OP_SND_ETC]			
EXEC   sp_addextendedproperty 'MS_Description', '내품상세정보(1:주문서상품코드/ 2:주문서상품명/ 3:주문서상품코드,주문서상품명/ 4:단품코드/ 5: 단품명/ 6:단품코드, 단품명)', 'user', dbo, 'table', [COMPDELI], 'column', [OP_DTL]			
EXEC   sp_addextendedproperty 'MS_Description', '정산구분표기(선불)', 'user', dbo, 'table', [COMPDELI], 'column', [SUNBUL_NM]			
EXEC   sp_addextendedproperty 'MS_Description', '정산구분표기(착불)', 'user', dbo, 'table', [COMPDELI], 'column', [CHAKBUL_NM]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [HDR_YN_INVC]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [COL_CLGO_SEQ]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [COL_INVC_SNO]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [COL_FARE]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [COL_FARE_AIR]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [COL_FARE_SHIP]			
EXEC   sp_addextendedproperty 'MS_Description', '송장자리수', 'user', dbo, 'table', [COMPDELI], 'column', [INVC_LEN]			
EXEC   sp_addextendedproperty 'MS_Description', '송장양식(Y:행수에 따라 합포장되어 줄구분됨(합포장기준:출고번호) /N:하나의 행이 하나의 송장으로 출력됨)', 'user', dbo, 'table', [COMPDELI], 'column', [INVC_MULTI_LINE_YN]			
EXEC   sp_addextendedproperty 'MS_Description', '내품구분자', 'user', dbo, 'table', [COMPDELI], 'column', [INVC_PROD_DELIMETER]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELI], 'column', [INVC_START_LINE]			
EXEC   sp_addextendedproperty 'MS_Description', '송장표기택배비(선불)', 'user', dbo, 'table', [COMPDELI], 'column', [SUNBUL_FEE]			
EXEC   sp_addextendedproperty 'MS_Description', '송장표기택배비(착불)', 'user', dbo, 'table', [COMPDELI], 'column', [CHAKBUL_FEE]			
EXEC   sp_addextendedproperty 'MS_Description', 'Location송장표시여부(0:출력안함/ 1:맨앞에표시/ 2:맨뒤에 표시)', 'user', dbo, 'table', [COMPDELI], 'column', [OP_LOC_PRN]					
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [COMPDELI], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [COMPDELI], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [COMPDELI], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [COMPDELI], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [COMPDELI], 'column', [TERMINALCD]	

/*택배사엑셀양식양식------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[COMPDELIFILECONFIG](
	[COMPCD] 				[nvarchar](20) NOT NULL,
	[ORGCD] 				[nvarchar](20) NOT NULL,
	[COL_NO]				[decimal](10,0) NOT NULL,
	[COL_ATTR]				[nvarchar](50) NULL,
	[COL_ATTR_VAL]			[nvarchar](50) NULL,
	[COL_NM]				[nvarchar](50) NULL,
	[COL_FILE_GB]			[nvarchar](1) NULL,
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL
ON [PRIMARY]

/* 인덱스 */
CREATE NONCLUSTERED INDEX [IDX_COMPDELIFILECONFIG] ON [dbo].[COMPDELIFILECONFIG]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[COL_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '택배사엑셀양식', 'user', dbo, 'table',[COMPDELIFILECONFIG]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '엑셀순서', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [COL_NO]			
EXEC   sp_addextendedproperty 'MS_Description', '헤더코드', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [COL_ATTR]			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [COL_ATTR_VAL]			
EXEC   sp_addextendedproperty 'MS_Description', '헤더명', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [COL_NM]			
EXEC   sp_addextendedproperty 'MS_Description', '정산구분여부(Y/N)', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [COL_FILE_GB]						
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [COMPDELIFILECONFIG], 'column', [TERMINALCD]	

