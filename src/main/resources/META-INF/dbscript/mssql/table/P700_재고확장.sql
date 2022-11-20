-- 재고이동 마스터
CREATE TABLE [dbo].[P710](
	[IMKEY]       [nvarchar](20) NOT NULL,			/* 재고이동번호 */
	[IMSTS]       [nvarchar](10) NOT NULL,			/* 재고이동상태(99:취소, 100:예정, 200:확정) */
	[IMTYPE]      [nvarchar](10) NOT NULL,			/* 재고이동타입(WH:창고간, LOC:로케이션) */
	[MVTYPE]      [nvarchar](10) NULL,			    /* 이동구분(STD:일반,INS:적치,SUP:보충) */
	[IMDT]        [nvarchar](8) NOT NULL,			/* 재고이동요청날짜 */
	[BEFOREWHCD]  [nvarchar](20) NOT NULL,	        /* 이동전 창고코드 */
	[AFTERWHCD]   [nvarchar](20) NOT NULL,	        /* 이동후 창고코드 (로케이션 이동일 때는 두개가 같은 창고) */
	[IMWHCD]      [nvarchar](20) NULL,				/* 이동중 창고코드 */
	[COMPCD]      [nvarchar](20) NOT NULL,			/* 회사코드 */
	[ORGCD]       [nvarchar](20) NOT NULL,			/* 셀러코드 */
	[USERCD]      [nvarchar](20) NULL,				/* 담당자 */
	[IMCFMDT]     [nvarchar](8) NULL,				/* 재고이동확정날짜 */
	[CFMUSERCD]   [nvarchar](20) NULL,				/* 확정자 */
	[REMARK]      [nvarchar](200) NULL,				/* 전표비고 */
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,

 CONSTRAINT [PK_P710] PRIMARY KEY CLUSTERED 
(
	[IMKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P710_01] ON [dbo].[P710]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[IMDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- 재고이동 마스터 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고이동', 'user', dbo, 'table',[P710]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '재고이동번호', 'user', dbo, 'table', [P710], 'column', [IMKEY]
EXEC   sp_addextendedproperty 'MS_Description', '재고이동상태(99:취소, 100:예정, 200:확정)', 'user', dbo, 'table', [P710], 'column', [IMSTS]     
EXEC   sp_addextendedproperty 'MS_Description', '재고이동타입(WH:창고간, LOC:로케이션)', 'user', dbo, 'table', [P710], 'column', [IMTYPE]
EXEC   sp_addextendedproperty 'MS_Description', '이동구분(STD:일반,INS:적치,SUP:보충)', 'user', dbo, 'table', [P710], 'column', [MVTYPE]
EXEC   sp_addextendedproperty 'MS_Description', '재고이동요청날짜', 'user', dbo, 'table', [P710], 'column', [IMDT] 
EXEC   sp_addextendedproperty 'MS_Description', '재고이동확정날짜', 'user', dbo, 'table', [P710], 'column', [IMCFMDT]      
EXEC   sp_addextendedproperty 'MS_Description', '이동전 창고코드', 'user', dbo, 'table', [P710], 'column', [BEFOREWHCD]      
EXEC   sp_addextendedproperty 'MS_Description', '이동후 창고코드', 'user', dbo, 'table', [P710], 'column', [AFTERWHCD]  
EXEC   sp_addextendedproperty 'MS_Description', '이동중 창고코드', 'user', dbo, 'table', [P710], 'column', [IMWHCD]   
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P710], 'column', [COMPCD]    
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P710], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '담당자', 'user', dbo, 'table', [P710], 'column', [USERCD]		
EXEC   sp_addextendedproperty 'MS_Description', '확정자', 'user', dbo, 'table', [P710], 'column', [CFMUSERCD]		
EXEC   sp_addextendedproperty 'MS_Description', '전표비고', 'user', dbo, 'table', [P710], 'column', [REMARK]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P710], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P710], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P710], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P710], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P710], 'column', [TERMINALCD]
GO

-- 재고이동 디테일
CREATE TABLE [dbo].[P711](
	[IMKEY]         [nvarchar](20) NOT NULL,	/* 재고이동번호 */
	[SEQ]           [decimal](10,0) NOT NULL,	/* SEQ */
	[ITEMCD]        [nvarchar](20) NOT NULL,	/* 이동할 품목코드 */
	[LOTKEY]        [nvarchar](20) NULL,		/* 이동할 품목의 로트키 */
	[IMSCHQTY]      [decimal](17, 6) NULL,		/* 이동예정 수량 */
	[IMQTY]         [decimal](17, 6) NULL,		/* 이동확정 수량 */
	[BEFOREWHCD]    [nvarchar](20) NOT NULL,	/* 이동전 창고코드 (마스터와 동일) */
	[AFTERWHCD]     [nvarchar](20) NOT NULL,	/* 이동후 창고코드 (마스터와 동일, 로케이션 이동일 때는 두개가 같은 창고) */
	[BEFORELOCCD]   [nvarchar](20) NOT NULL,	/* 이동전 로케이션코드 */
	[AFTERLOCCD]    [nvarchar](20) NOT NULL,	/* 이동후 로케이션코드 */
	[IMWHCD]        [nvarchar](20) NULL,		/* 이동중 창고코드 */
	[IMLOCCD]       [nvarchar](20) NULL,		/* 이동중 로케이션 */
	[COMPCD]        [nvarchar](20) NOT NULL,	/* 회사코드 */
	[ORGCD]         [nvarchar](20) NOT NULL,	/* 셀러 코드 */
	[REMARK]        [nvarchar](200) NULL,		/* 품목 비고 */
	[ADDUSERCD]     [nvarchar](20) NULL,
	[ADDDATETIME]   [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]     [nvarchar](20) NULL,
	[UPDDATETIME]   [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]    [nvarchar](50) NULL,
    [PDA_CK]        [NVARCHAR](1) DEFAULT('N'),
    [IMDSTS] 		[nvarchar](10) NULL
 CONSTRAINT [PK_P711] PRIMARY KEY CLUSTERED 
(
	[IMKEY] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 재고이동 디테일 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고이동상세', 'user', dbo, 'table',[P711]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '재고이동번호', 'user', dbo, 'table', [P711], 'column', [IMKEY]
EXEC   sp_addextendedproperty 'MS_Description', 'SEQ', 'user', dbo, 'table', [P711], 'column', [SEQ]     
EXEC   sp_addextendedproperty 'MS_Description', '이동할 품목코드', 'user', dbo, 'table', [P711], 'column', [ITEMCD]
EXEC   sp_addextendedproperty 'MS_Description', '이동할 품목의 로트키', 'user', dbo, 'table', [P711], 'column', [LOTKEY] 
EXEC   sp_addextendedproperty 'MS_Description', '이동예정 수량', 'user', dbo, 'table', [P711], 'column', [IMSCHQTY]      
EXEC   sp_addextendedproperty 'MS_Description', '이동확정 수량', 'user', dbo, 'table', [P711], 'column', [IMQTY]      
EXEC   sp_addextendedproperty 'MS_Description', '이동전 창고코드 (마스터와 동일)', 'user', dbo, 'table', [P711], 'column', [BEFOREWHCD]  
EXEC   sp_addextendedproperty 'MS_Description', '이동후 창고코드 (마스터와 동일)', 'user', dbo, 'table', [P711], 'column', [AFTERWHCD]   
EXEC   sp_addextendedproperty 'MS_Description', '이동전 로케이션코드', 'user', dbo, 'table', [P711], 'column', [BEFORELOCCD]    
EXEC   sp_addextendedproperty 'MS_Description', '이동후 로케이션코드', 'user', dbo, 'table', [P711], 'column', [AFTERLOCCD]		
EXEC   sp_addextendedproperty 'MS_Description', '이동중 창고코드', 'user', dbo, 'table', [P711], 'column', [IMWHCD]		
EXEC   sp_addextendedproperty 'MS_Description', '이동중 로케이션', 'user', dbo, 'table', [P711], 'column', [IMLOCCD]		
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P711], 'column', [COMPCD]		
EXEC   sp_addextendedproperty 'MS_Description', '셀러 코드', 'user', dbo, 'table', [P711], 'column', [ORGCD]		
EXEC   sp_addextendedproperty 'MS_Description', '품목 비고', 'user', dbo, 'table', [P711], 'column', [REMARK]		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P711], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P711], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P711], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P711], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P711], 'column', [TERMINALCD]
EXEC   sp_addextendedproperty 'MS_Description', 'PDA확인여부(보충확인용도)', 'user', dbo, 'table', [P711], 'column', [PDA_CK]
EXEC   sp_addextendedproperty 'MS_Description', '디테일상태', 'user', dbo, 'table', [P711], 'column', [IMDSTS]
GO

-- 로트속성변경 마스터
CREATE TABLE [dbo].[P720](
	[CLKEY]        [nvarchar](20) NOT NULL,		/* 변경번호 */
	[CLDT]         [nvarchar](8) NOT NULL,		/* 변경날짜 */
	[COMPCD]       [nvarchar](20) NOT NULL,		/* 회사코드 */
	[ORGCD]        [nvarchar](20) NOT NULL,		/* 셀러코드 */	
	[WHCD]         [nvarchar](20) NULL,			/* 창고코드 */
	[USERCD]       [nvarchar](20) NULL,			/* 담당자 */
	[REMARK]       [nvarchar](200) NULL,		/* 전표비고 */
	[ADDUSERCD]    [nvarchar](20) NULL,
	[ADDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]    [nvarchar](20) NULL,
	[UPDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]   [nvarchar](50) NULL,

 CONSTRAINT [PK_P720] PRIMARY KEY CLUSTERED 
(
	[CLKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P720_01] ON [dbo].[P720]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[CLDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- 로트속성변경 마스터 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '로트속성변경', 'user', dbo, 'table',[P720]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '변경번호', 'user', dbo, 'table', [P720], 'column', [CLKEY]
EXEC   sp_addextendedproperty 'MS_Description', '변경날짜', 'user', dbo, 'table', [P720], 'column', [CLDT]     
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P720], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P720], 'column', [ORGCD] 
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P720], 'column', [WHCD]      
EXEC   sp_addextendedproperty 'MS_Description', '담당자', 'user', dbo, 'table', [P720], 'column', [USERCD]      
EXEC   sp_addextendedproperty 'MS_Description', '전표비고', 'user', dbo, 'table', [P720], 'column', [REMARK]  
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P720], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P720], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P720], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P720], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P720], 'column', [TERMINALCD]
GO

-- 로트속성변경 디테일
CREATE TABLE [dbo].[P721](
	[CLKEY]        [nvarchar](20) NOT NULL,			 	/* 변경번호 */
	[SEQ]          [decimal](10,0) NOT NULL,			/* SEQ */
	[WHCD]         [nvarchar](20) NOT NULL,				/* 창고코드 */
	[BEFLOCCD]     [nvarchar](20) NOT NULL,     	    /* 변경전 로케이션 */
	[AFTLOCCD]     [nvarchar](20) NOT NULL,		        /* 변경후 로케이션 */
	[ITEMCD]       [nvarchar](20) NOT NULL,				/* 변경할 품목코드 */	
	[BEFLOTKEY]    [nvarchar](20) NULL,				    /* 변경전 로트키 */ 
	[AFTLOTKEY]    [nvarchar](20) NULL,				    /* 변경후 로트키 */ 
	[CLQTY]        [decimal](17, 6) NULL,				/* 변경할 수량 */
	[BEFLOT1]      [nvarchar](20) NULL,					/* 변경전 로트1 */ 
	[BEFLOT2]      [nvarchar](20) NULL,					/* 변경전 로트2 */ 
	[BEFLOT3]      [nvarchar](20) NULL,					/* 변경전 로트3 */ 
	[BEFLOT4]      [nvarchar](20) NULL,					/* 변경전 로트4 */ 
	[BEFLOT5]      [nvarchar](20) NULL,					/* 변경전 로트5 */ 
	[AFTLOT1]      [nvarchar](20) NULL,					/* 변경후 로트1 */ 
	[AFTLOT2]      [nvarchar](20) NULL,					/* 변경후 로트2 */ 
	[AFTLOT3]      [nvarchar](20) NULL,					/* 변경후 로트3 */ 
	[AFTLOT4]      [nvarchar](20) NULL,					/* 변경후 로트4 */ 
	[AFTLOT5]      [nvarchar](20) NULL,					/* 변경후 로트5 */ 
	[COMPCD]       [nvarchar](20) NOT NULL,				/* 회사코드 */
	[ORGCD]        [nvarchar](20) NOT NULL,				/* 셀러코드 */
	[REMARK]       [nvarchar](200) NULL,				/* 품목비고 */
	[ADDUSERCD]    [nvarchar](20) NULL,
	[ADDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]    [nvarchar](20) NULL,
	[UPDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]   [nvarchar](50) NULL,
 CONSTRAINT [PK_P721] PRIMARY KEY CLUSTERED 
(
	[CLKEY] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 로트속성변경 디테일 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '로트속성변경상세', 'user', dbo, 'table',[P721]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '변경번호', 'user', dbo, 'table', [P721], 'column', [CLKEY]
EXEC   sp_addextendedproperty 'MS_Description', 'SEQ', 'user', dbo, 'table', [P721], 'column', [SEQ]     
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P721], 'column', [WHCD]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로케이션', 'user', dbo, 'table', [P721], 'column', [BEFLOCCD] 
EXEC   sp_addextendedproperty 'MS_Description', '변경후 로케이션', 'user', dbo, 'table', [P721], 'column', [AFTLOCCD]      
EXEC   sp_addextendedproperty 'MS_Description', '변경할 품목코드', 'user', dbo, 'table', [P721], 'column', [ITEMCD]      
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트키', 'user', dbo, 'table', [P721], 'column', [BEFLOTKEY]  
EXEC   sp_addextendedproperty 'MS_Description', '변경후 로트키', 'user', dbo, 'table', [P721], 'column', [AFTLOTKEY]
EXEC   sp_addextendedproperty 'MS_Description', '변경할 수량', 'user', dbo, 'table', [P721], 'column', [CLQTY]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트1', 'user', dbo, 'table', [P721], 'column', [BEFLOT1]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트2', 'user', dbo, 'table', [P721], 'column', [BEFLOT2]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트3', 'user', dbo, 'table', [P721], 'column', [BEFLOT3]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트4', 'user', dbo, 'table', [P721], 'column', [BEFLOT4]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트5', 'user', dbo, 'table', [P721], 'column', [BEFLOT5]
EXEC   sp_addextendedproperty 'MS_Description', '변경전 로트1', 'user', dbo, 'table', [P721], 'column', [AFTLOT1]
EXEC   sp_addextendedproperty 'MS_Description', '변경후 로트2', 'user', dbo, 'table', [P721], 'column', [AFTLOT2]
EXEC   sp_addextendedproperty 'MS_Description', '변경후 로트3', 'user', dbo, 'table', [P721], 'column', [AFTLOT3]
EXEC   sp_addextendedproperty 'MS_Description', '변경후 로트4', 'user', dbo, 'table', [P721], 'column', [AFTLOT4]
EXEC   sp_addextendedproperty 'MS_Description', '변경후 로트5', 'user', dbo, 'table', [P721], 'column', [AFTLOT5]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P721], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P721], 'column', [ORGCD]
EXEC   sp_addextendedproperty 'MS_Description', '품목비고', 'user', dbo, 'table', [P721], 'column', [REMARK]
EXEC   sp_addextendedproperty 'MS_Description', '등록자자ID', 'user', dbo, 'table', [P721], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P721], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P721], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P721], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P721], 'column', [TERMINALCD]
GO

-- 재고실사 마스터
CREATE TABLE [dbo].[P730](
	[ICKEY]           [nvarchar](20) NOT NULL,			/* 실사번호 */
	[ICDT]			  [nvarchar](8) NULL,				/* 실사 생성일 */
	[ICFROMDT]        [nvarchar](8) NULL,				/* 실사 시작 날짜 */
	[ICTODT]          [nvarchar](8) NULL,				/* 실사 종료 날짜 */
	[ICTYPE]          [nvarchar](10) NULL,				/* 지정형태(지정하지않는, 피킹지시로케이션만 등)*/
	[ICSTS]           [nvarchar](10) NOT NULL,			/* 상태(100:예정, 200:확정, 99:취소) */
	[COMPCD]          [nvarchar](20) NOT NULL,			/* 회사코드 */
	[ORGCD]           [nvarchar](20) NOT NULL,			/* 셀러코드 */
	[WHCD]            [nvarchar](20) NOT NULL,			/* 창고코드 */
	[FROMLOCCD]       [nvarchar](20) NULL,	            /* from로케이션 */
	[TOLOCCD]         [nvarchar](20) NULL,		        /* to로케이션 */				 																																							
	[ITEMCD]          [nvarchar](20) NULL,			    /* 품목코드 */				 																																							
	[USERCD]          [nvarchar](20) NULL,				/* 담당자 */
	[CFMDT]           [nvarchar](8) NULL,				/* 확정일 */
	[CFMUSERCD]       [nvarchar](20) NULL,				/* 확정자 */
	[IAKEY]           [nvarchar](20) NULL,				/* 재고조정번호 */
	[REMARK]          [nvarchar](200) NULL,				/* 전표비고 */
	[ADDUSERCD]       [nvarchar](20) NULL,
	[ADDDATETIME]     [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]       [nvarchar](20) NULL,
	[UPDDATETIME]     [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]      [nvarchar](50) NULL,
 CONSTRAINT [PK_P730] PRIMARY KEY CLUSTERED 
(
	[ICKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P730_01] ON [dbo].[P730]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[CFMDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- 재고실사 마스터 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고실사', 'user', dbo, 'table',[P730]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '실사번호', 'user', dbo, 'table', [P730], 'column', [ICKEY]
EXEC   sp_addextendedproperty 'MS_Description', '실사 생성일', 'user', dbo, 'table', [P730], 'column', [ICDT]     
EXEC   sp_addextendedproperty 'MS_Description', '실사 시작 날짜', 'user', dbo, 'table', [P730], 'column', [ICFROMDT]     
EXEC   sp_addextendedproperty 'MS_Description', '실사 종료 날짜', 'user', dbo, 'table', [P730], 'column', [ICTODT]     
EXEC   sp_addextendedproperty 'MS_Description', '상태(100:예정, 200:확정, 99:취소)', 'user', dbo, 'table', [P730], 'column', [ICSTS]     
EXEC   sp_addextendedproperty 'MS_Description', '지정형태', 'user', dbo, 'table', [P730], 'column', [ICTYPE]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P730], 'column', [COMPCD] 
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P730], 'column', [ORGCD]      
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P730], 'column', [WHCD]      
EXEC   sp_addextendedproperty 'MS_Description', 'from로케이션', 'user', dbo, 'table', [P730], 'column', [FROMLOCCD]  
EXEC   sp_addextendedproperty 'MS_Description', 'to로케이션', 'user', dbo, 'table', [P730], 'column', [TOLOCCD]  
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P730], 'column', [ITEMCD]  
EXEC   sp_addextendedproperty 'MS_Description', '담당자', 'user', dbo, 'table', [P730], 'column', [USERCD]  
EXEC   sp_addextendedproperty 'MS_Description', '확정일', 'user', dbo, 'table', [P730], 'column', [CFMDT]
EXEC   sp_addextendedproperty 'MS_Description', '확정자', 'user', dbo, 'table', [P730], 'column', [CFMUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '재고조정번호', 'user', dbo, 'table', [P730], 'column', [IAKEY]
EXEC   sp_addextendedproperty 'MS_Description', '전표비고', 'user', dbo, 'table', [P730], 'column', [REMARK]  
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P730], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P730], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P730], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P730], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P730], 'column', [TERMINALCD]
GO

-- 재고실사 디테일
CREATE TABLE [dbo].[P731](
	[ICKEY]       [nvarchar](20) NOT NULL,		/* 실사번호 */
	[SEQ]         [decimal](10,0) NOT NULL,		/* SEQ */
	[WHCD]        [nvarchar](20) NOT NULL,		/* 창고코드 */
	[LOCCD]       [nvarchar](20) NOT NULL,	    /* 로케이션 */																					
	[ITEMCD]      [nvarchar](20) NOT NULL, 	    /* 품목코드 */
	[LOTKEY]      [nvarchar](20) NULL,	        /* 로트키 */ 
	[QTY]         [decimal](17, 6) NULL,		/* 현재고 수량 */
	[ALLOCQTY]    [decimal](17, 6) NULL,		/* 할당 수량 */
	[CHKQTY]      [decimal](17, 6) NULL,		/* 실사 수량 */
	[COMPCD]      [nvarchar](20) NOT NULL,		/* 회사코드 */
	[ORGCD]       [nvarchar](20) NOT NULL,		/* 셀러코드 */
	[CHKUSERCD]   [nvarchar](20) NULL,		    /* 실사 등록자 */
	[CHKDATETIME] [datetime] NULL,			    /* 실사 시간 */
	[REMARK]      [nvarchar](200) NULL,			/* 품목비고 */
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P731] PRIMARY KEY CLUSTERED 
(
	[ICKEY] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 재고실사 디테일 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고실사상세', 'user', dbo, 'table',[P731]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '실사번호', 'user', dbo, 'table', [P731], 'column', [ICKEY]
EXEC   sp_addextendedproperty 'MS_Description', 'SEQ', 'user', dbo, 'table', [P731], 'column', [SEQ]     
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P731], 'column', [WHCD]
EXEC   sp_addextendedproperty 'MS_Description', '로케이션', 'user', dbo, 'table', [P731], 'column', [LOCCD]  
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P731], 'column', [ITEMCD]      
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P731], 'column', [LOTKEY]  
EXEC   sp_addextendedproperty 'MS_Description', '현재고 수량', 'user', dbo, 'table', [P731], 'column', [QTY]
EXEC   sp_addextendedproperty 'MS_Description', '할당 수량', 'user', dbo, 'table', [P731], 'column', [ALLOCQTY]
EXEC   sp_addextendedproperty 'MS_Description', '실사 수량', 'user', dbo, 'table', [P731], 'column', [CHKQTY]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P731], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P731], 'column', [ORGCD]
EXEC   sp_addextendedproperty 'MS_Description', '실사 등록자', 'user', dbo, 'table', [P731], 'column', [CHKUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '실사 시간', 'user', dbo, 'table', [P731], 'column', [CHKDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '품목비고', 'user', dbo, 'table', [P731], 'column', [REMARK]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P731], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P731], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P731], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P731], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P731], 'column', [TERMINALCD]
GO

-- 재고조정 마스터
CREATE TABLE [dbo].[P740](
	[IAKEY]       [nvarchar](20) NOT NULL,			/* 조정번호 */
	[EAKEY]       [nvarchar](20) NULL,			    /* 전자결재번호 */
	[IADT]        [nvarchar](8) NOT NULL,			/* 조정요청일 */
	[IATYPE]      [nvarchar](10) NULL,				/* 조정형태(재고조정, 불량, 파기, 손실, 잉여 등)*/
	[IASTS]       [nvarchar](10) NOT NULL,			/* 상태(100:예정, 200:확정, 99:취소) */
	[COMPCD]      [nvarchar](20) NOT NULL,			/* 회사코드 */
	[ORGCD]       [nvarchar](20) NOT NULL,			/* 셀러코드 */
	[WHCD]        [nvarchar](20) NOT NULL,			/* 창고코드 */
	[USERCD]      [nvarchar](20) NULL,				/* 담당자 */
	[CFMDT]       [nvarchar](8) NULL,				/* 확정일 */
	[CFMUSERCD]   [nvarchar](20) NULL,				/* 확정자 */
	[DEPTCD]      [nvarchar](20) NULL,				/* 담당부서 */
	[REMARK]      [nvarchar](200) NULL,				/* 전표비고 */
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P740] PRIMARY KEY CLUSTERED 
(
	[IAKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P740_01] ON [dbo].[P740]
(
	[EAKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

CREATE NONCLUSTERED INDEX [IDX_P740_02] ON [dbo].[P740]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[CFMDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- 재고조정 마스터 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고조정', 'user', dbo, 'table',[P740]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '조정번호', 'user', dbo, 'table', [P740], 'column', [IAKEY]
EXEC   sp_addextendedproperty 'MS_Description', '전자결재번호', 'user', dbo, 'table', [P740], 'column', [EAKEY]     
EXEC   sp_addextendedproperty 'MS_Description', '조정요청일', 'user', dbo, 'table', [P740], 'column', [IADT]     
EXEC   sp_addextendedproperty 'MS_Description', '조정형태(재고조정, 불량, 파기, 손실, 잉여 등)', 'user', dbo, 'table', [P740], 'column', [IATYPE]     
EXEC   sp_addextendedproperty 'MS_Description', '상태(100:예정, 200:확정, 99:취소)', 'user', dbo, 'table', [P740], 'column', [IASTS]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P740], 'column', [COMPCD] 
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P740], 'column', [ORGCD]      
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P740], 'column', [WHCD]      
EXEC   sp_addextendedproperty 'MS_Description', '담당자', 'user', dbo, 'table', [P740], 'column', [USERCD]  
EXEC   sp_addextendedproperty 'MS_Description', '확정일', 'user', dbo, 'table', [P740], 'column', [CFMDT]
EXEC   sp_addextendedproperty 'MS_Description', '확정자', 'user', dbo, 'table', [P740], 'column', [CFMUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '전표비고', 'user', dbo, 'table', [P740], 'column', [REMARK]  
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P740], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P740], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P740], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P740], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P740], 'column', [TERMINALCD]
GO

-- 재고조정 디테일
CREATE TABLE [dbo].[P741](
	[IAKEY]       [nvarchar](20) NOT NULL,	/* 조정번호 */
	[SEQ]         [decimal](10,0) NOT NULL,	/* SEQ */
	[WHCD]        [nvarchar](20) NOT NULL,	/* 창고코드 */
	[LOCCD]       [nvarchar](20) NOT NULL,	/* 로케이션 */																					
	[ITEMCD]      [nvarchar](20) NOT NULL, 	/* 품목코드 */
	[LOT1]        [nvarchar](20) NULL,		/* 로트1 */ 
	[LOT2]        [nvarchar](20) NULL,		/* 로트2 */ 
	[LOT3]        [nvarchar](20) NULL,		/* 로트3 */ 
	[LOT4]        [nvarchar](20) NULL,		/* 로트4 */ 
	[LOT5]        [nvarchar](20) NULL,		/* 로트5 */ 
	[LOTKEY]      [nvarchar](20) NULL,	    /* 로트키 */ 
	[IASCHQTY]    [decimal](17, 6) NULL,	/* 예정 수량 +, - 수량 둘다 입력 가능 */
	[IAQTY]       [decimal](17, 6) NULL,	/* 확정 수량 */
	[UNITPRICE]   [decimal](17,4) NULL,     /* 조정단가 */
	[AMT]         [decimal](17,4) NULL,     /* 조정금액 */
	[COMPCD]      [nvarchar](20) NOT NULL,	/* 회사코드 */
	[ORGCD]       [nvarchar](20) NOT NULL,	/* 셀러코드 */
	[REMARK]      [nvarchar](200) NULL,		/* 품목비고 */
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P741] PRIMARY KEY CLUSTERED 
(
	[IAKEY] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 재고조정 디테일 주석추가 (add)
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '재고조정상세', 'user', dbo, 'table',[P741]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '조정번호', 'user', dbo, 'table', [P741], 'column', [IAKEY]
EXEC   sp_addextendedproperty 'MS_Description', 'SEQ', 'user', dbo, 'table', [P741], 'column', [SEQ]     
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P741], 'column', [WHCD]
EXEC   sp_addextendedproperty 'MS_Description', '로케이션', 'user', dbo, 'table', [P741], 'column', [LOCCD]  
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P741], 'column', [ITEMCD]    
EXEC   sp_addextendedproperty 'MS_Description', '로트1', 'user', dbo, 'table', [P741], 'column', [LOT1]  
EXEC   sp_addextendedproperty 'MS_Description', '로트2', 'user', dbo, 'table', [P741], 'column', [LOT2]  
EXEC   sp_addextendedproperty 'MS_Description', '로트3', 'user', dbo, 'table', [P741], 'column', [LOT3]  
EXEC   sp_addextendedproperty 'MS_Description', '로트4', 'user', dbo, 'table', [P741], 'column', [LOT4]  
EXEC   sp_addextendedproperty 'MS_Description', '로트5', 'user', dbo, 'table', [P741], 'column', [LOT5]  
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P741], 'column', [LOTKEY]  
EXEC   sp_addextendedproperty 'MS_Description', '예정 수량 +, - 수량 둘다 입력 가능', 'user', dbo, 'table', [P741], 'column', [IASCHQTY]
EXEC   sp_addextendedproperty 'MS_Description', '확정 수량', 'user', dbo, 'table', [P741], 'column', [IAQTY]
EXEC   sp_addextendedproperty 'MS_Description', '조정단가', 'user', dbo, 'table', [P741], 'column', [UNITPRICE]
EXEC   sp_addextendedproperty 'MS_Description', '조정금액', 'user', dbo, 'table', [P741], 'column', [AMT]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P741], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P741], 'column', [ORGCD]
EXEC   sp_addextendedproperty 'MS_Description', '품목비고', 'user', dbo, 'table', [P741], 'column', [REMARK]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P741], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P741], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P741], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P741], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P741], 'column', [TERMINALCD]
GO
