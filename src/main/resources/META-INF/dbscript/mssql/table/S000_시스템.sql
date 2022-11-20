
-- 공통코드마스터 
CREATE TABLE [dbo].[S001](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[CODEKEY]     [nvarchar](20) NOT NULL,
	[NAME]        [nvarchar](100) NOT NULL,
	[SNAME]       [nvarchar](100) NOT NULL,
	[TABLENAME]   [nvarchar](20) NULL,
	[EDITABLE]    [nvarchar](1) NULL DEFAULT('Y'),
	[REMARK]      [nvarchar](200) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S001] PRIMARY KEY CLUSTERED 
(
    [COMPCD]    ASC,
	[CODEKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO																									
																									
																									
/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '공통코드마스터', 'user', dbo, 'table',[S001]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S001], 'column', [COMPCD]       																						
EXEC   sp_addextendedproperty 'MS_Description', '공통코드마스터키', 'user', dbo, 'table', [S001], 'column', [CODEKEY]    																							
EXEC   sp_addextendedproperty 'MS_Description', '명칭', 'user', dbo, 'table', [S001], 'column', [NAME]       																						
EXEC   sp_addextendedproperty 'MS_Description', '약칭', 'user', dbo, 'table', [S001], 'column', [SNAME]      																						
EXEC   sp_addextendedproperty 'MS_Description', '테이블명', 'user', dbo, 'table', [S001], 'column', [TABLENAME]  																						
EXEC   sp_addextendedproperty 'MS_Description', '수정가능여부', 'user', dbo, 'table', [S001], 'column', [EDITABLE]  																						
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S001], 'column', [REMARK]     																						
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S001], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S001], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S001], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S001], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S001], 'column', TERMINALCD																									
GO
																						
/*																									
	2. 주석수정 (update)																								
EXEC   sp_updateextendedproperty 'MS_Description', '테이블설명', 'user', dbo, 'table',테이블명																									
EXEC   sp_updateextendedproperty 'MS_Description', '컬럼설명', 'user', dbo, 'table', 테이블명, 'column', 컬럼명																									
*/																									


-- 공통코드상세
CREATE TABLE [dbo].[S002](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[CODEKEY]     [nvarchar](20) NOT NULL,
	[CODE]        [nvarchar](20) NOT NULL,
	[SNAME1]      [nvarchar](100) NOT NULL,
	[SNAME2]      [nvarchar](100) NULL,
	[SNAME3]      [nvarchar](100) NULL,
	[SNAME4]      [nvarchar](100) NULL,
	[SNAME5]      [nvarchar](100) NULL,
	[REMARK]      [nvarchar](200) NULL,
	[SORTNO]      [int] NULL DEFAULT ((0)),
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S002] PRIMARY KEY CLUSTERED 
(
    [COMPCD]  ASC,
	[CODEKEY] ASC,
	[CODE]    ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO																									
																							
																									
/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '공통코드상세', 'user', dbo, 'table',[S002]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S002], 'column', [COMPCD]          																						
EXEC   sp_addextendedproperty 'MS_Description', '공통코드마스터키', 'user', dbo, 'table', [S002], 'column', [CODEKEY]       																						
EXEC   sp_addextendedproperty 'MS_Description', '코드', 'user', dbo, 'table', [S002], 'column', [CODE]          																						
EXEC   sp_addextendedproperty 'MS_Description', '명칭1', 'user', dbo, 'table', [S002], 'column', [SNAME1]        																						
EXEC   sp_addextendedproperty 'MS_Description', '명칭2', 'user', dbo, 'table', [S002], 'column', [SNAME2]        																						
EXEC   sp_addextendedproperty 'MS_Description', '명칭3', 'user', dbo, 'table', [S002], 'column', [SNAME3]        																						
EXEC   sp_addextendedproperty 'MS_Description', '명칭4', 'user', dbo, 'table', [S002], 'column', [SNAME4]        																						
EXEC   sp_addextendedproperty 'MS_Description', '명칭5', 'user', dbo, 'table', [S002], 'column', [SNAME5]        																						
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S002], 'column', [REMARK]        																						
EXEC   sp_addextendedproperty 'MS_Description', '정렬', 'user', dbo, 'table', [S002], 'column', [SORTNO]        																						
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S002], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S002], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S002], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S002], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S002], 'column', TERMINALCD																									
GO


-- 채번마스터
CREATE TABLE [dbo].[S003](
	[SEQ_NAME] [nvarchar](30) NOT NULL,
	[FORMAT_INFO] [nvarchar](100) NOT NULL,
	[SEQ_LENGTH] [decimal](10, 0) NOT NULL,
	[REMARK] [nvarchar](100) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[ADDUSERCD] [varchar](30) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD] [varchar](30) NULL,
	[TERMINALCD] [nvarchar](20) NULL,
 CONSTRAINT [PK_S003] PRIMARY KEY CLUSTERED 
(
	[SEQ_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시퀀스명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'SEQ_NAME'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'포맷정보([SEQ]필수)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'FORMAT_INFO'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'일련번호 길이' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'SEQ_LENGTH'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'비고' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'REMARK'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'ADDDATETIME'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'ADDUSERCD'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'UPDDATETIME'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'UPDUSERCD'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단말기' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S003', @level2type=N'COLUMN',@level2name=N'TERMINALCD'
GO

-- 채번상세
CREATE TABLE [dbo].[S004](
	[SEQ_NAME] [nvarchar](30) NOT NULL,
	[DATA1] [nvarchar](15) NOT NULL DEFAULT ('*'),
	[DATA2] [nvarchar](15) NOT NULL DEFAULT ('*'),
	[DATA3] [nvarchar](15) NOT NULL DEFAULT ('*'),
	[DATA4] [nvarchar](15) NOT NULL DEFAULT ('*'),
	[DATA5] [nvarchar](15) NOT NULL DEFAULT ('*'),
	[CNT] [decimal](10, 0) NOT NULL DEFAULT ((1)),
	[SEQ_VALUE] [nvarchar](100) NOT NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[ADDUSERCD] [varchar](30) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD] [varchar](30) NULL,
	[TERMINALCD] [nvarchar](20) NULL,
 CONSTRAINT [PK_S004] PRIMARY KEY CLUSTERED 
(
	[SEQ_NAME] ASC,
	[DATA1] ASC,
	[DATA2] ASC,
	[DATA3] ASC,
	[DATA4] ASC,
	[DATA5] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'시퀀스명' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'SEQ_NAME'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'값1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'DATA1'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'값2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'DATA2'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'값3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'DATA3'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'값4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'DATA4'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'값5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'DATA5'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재순번' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'CNT'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재일련번호값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'SEQ_VALUE'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'ADDDATETIME'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'등록자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'ADDUSERCD'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경일시' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'UPDDATETIME'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'변경자' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'UPDUSERCD'
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'단말기' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'S004', @level2type=N'COLUMN',@level2name=N'TERMINALCD'
GO

--프로그램
CREATE TABLE [dbo].[S005](
	[APPKEY]        [nvarchar](20) NOT NULL,
	[APPNM]         [nvarchar](100) NULL,
	[APPURL]        [nvarchar](100) NULL,
	[BTNSEARCH]     [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNNEW]        [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNSAVE]       [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNDELETE]     [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNEXECUTE]    [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNPRINT]      [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNEXCELDOWN]  [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNEXCELUP]    [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNCANCEL]     [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNCOPY]       [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNLIST]       [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNINIT]       [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNUSER1]      [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNUSER2]      [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNUSER3]      [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNUSER4]      [decimal](1, 0) NULL DEFAULT ((0)),
	[BTNUSER5]      [decimal](1, 0) NULL DEFAULT ((0)),
	[REMARK]        [nvarchar](200) NULL,
	[ADDUSERCD]     [nvarchar](20) NULL,
	[ADDDATETIME]   [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]     [nvarchar](20) NULL,
	[UPDDATETIME]   [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]    [nvarchar](50) NULL,
 CONSTRAINT [PK_S005] PRIMARY KEY CLUSTERED 
(
	[APPKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '프로그램', 'user', dbo, 'table',[S005]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '프로그램코드', 'user', dbo, 'table', [S005], 'column', [APPKEY]                
EXEC   sp_addextendedproperty 'MS_Description', '프로그램명', 'user', dbo, 'table', [S005], 'column', [APPNM]                 
EXEC   sp_addextendedproperty 'MS_Description', 'URL', 'user', dbo, 'table', [S005], 'column', [APPURL]                
EXEC   sp_addextendedproperty 'MS_Description', '검색', 'user', dbo, 'table', [S005], 'column', [BTNSEARCH]             
EXEC   sp_addextendedproperty 'MS_Description', '신규', 'user', dbo, 'table', [S005], 'column', [BTNNEW]                
EXEC   sp_addextendedproperty 'MS_Description', '저장', 'user', dbo, 'table', [S005], 'column', [BTNSAVE]               
EXEC   sp_addextendedproperty 'MS_Description', '삭제', 'user', dbo, 'table', [S005], 'column', [BTNDELETE]             
EXEC   sp_addextendedproperty 'MS_Description', '실행', 'user', dbo, 'table', [S005], 'column', [BTNEXECUTE]            
EXEC   sp_addextendedproperty 'MS_Description', '출력', 'user', dbo, 'table', [S005], 'column', [BTNPRINT]              
EXEC   sp_addextendedproperty 'MS_Description', '엑셀저장', 'user', dbo, 'table', [S005], 'column', [BTNEXCELDOWN]              
EXEC   sp_addextendedproperty 'MS_Description', '엑셀업로드', 'user', dbo, 'table', [S005], 'column', [BTNEXCELUP]            
EXEC   sp_addextendedproperty 'MS_Description', '취소', 'user', dbo, 'table', [S005], 'column', [BTNCANCEL]             
EXEC   sp_addextendedproperty 'MS_Description', '복사', 'user', dbo, 'table', [S005], 'column', [BTNCOPY]               
EXEC   sp_addextendedproperty 'MS_Description', '목록', 'user', dbo, 'table', [S005], 'column', [BTNLIST]               
EXEC   sp_addextendedproperty 'MS_Description', '초기화', 'user', dbo, 'table', [S005], 'column', [BTNINIT]               
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의1', 'user', dbo, 'table', [S005], 'column', [BTNUSER1]              
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의2', 'user', dbo, 'table', [S005], 'column', [BTNUSER2]              
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의3', 'user', dbo, 'table', [S005], 'column', [BTNUSER3]              
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의4', 'user', dbo, 'table', [S005], 'column', [BTNUSER4]              
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의5', 'user', dbo, 'table', [S005], 'column', [BTNUSER5]              
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S005], 'column', [REMARK]                
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S005], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S005], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S005], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S005], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S005], 'column', TERMINALCD																									
GO

--프로그램별 권한 
CREATE TABLE [dbo].[S006](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[USERCD]      [nvarchar](20) NOT NULL,
	[MENUL1KEY]   [decimal](10, 0) NOT NULL,
	[MENUL2KEY]   [decimal](10, 0) NOT NULL,
	[APPKEY]      [nvarchar](20) NOT NULL,
	[AUTHSEARCH]  [nvarchar](10) NOT NULL DEFAULT ('N'),
	[AUTHUPD]     [nvarchar](1) NOT NULL DEFAULT ('N'),
	[AUTHDEL]     [nvarchar](1) NOT NULL DEFAULT ('N'),
	[AUTHEXEC]    [nvarchar](1) NOT NULL DEFAULT ('N'),
	[AUTHPRINT]   [nvarchar](1) NOT NULL DEFAULT ('N'),
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S006] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[USERCD] ASC,
	[MENUL1KEY] ASC,
	[MENUL2KEY] ASC,
	[APPKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '프로그램 사용자 권한', 'user', dbo, 'table',[S006]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S006], 'column', [COMPCD]                    
EXEC   sp_addextendedproperty 'MS_Description', '사용자코드', 'user', dbo, 'table', [S006], 'column', [USERCD]                  
EXEC   sp_addextendedproperty 'MS_Description', '대메뉴코드', 'user', dbo, 'table', [S006], 'column', [MENUL1KEY]               
EXEC   sp_addextendedproperty 'MS_Description', '중메뉴코드', 'user', dbo, 'table', [S006], 'column', [MENUL2KEY]               
EXEC   sp_addextendedproperty 'MS_Description', '프로그램코드', 'user', dbo, 'table', [S006], 'column', [APPKEY]                  
EXEC   sp_addextendedproperty 'MS_Description', '조회', 'user', dbo, 'table', [S006], 'column', [AUTHSEARCH]              
EXEC   sp_addextendedproperty 'MS_Description', '수정', 'user', dbo, 'table', [S006], 'column', [AUTHUPD]                 
EXEC   sp_addextendedproperty 'MS_Description', '삭제', 'user', dbo, 'table', [S006], 'column', [AUTHDEL]                 
EXEC   sp_addextendedproperty 'MS_Description', '실행', 'user', dbo, 'table', [S006], 'column', [AUTHEXEC]                
EXEC   sp_addextendedproperty 'MS_Description', '출력', 'user', dbo, 'table', [S006], 'column', [AUTHPRINT]               
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S006], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S006], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S006], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S006], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S006], 'column', TERMINALCD																									
GO


-- 대메뉴
CREATE TABLE [dbo].[S007](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[MENUL1KEY]   [decimal](10, 0) NOT NULL,
	[L1TITLE]     [nvarchar](50) NOT NULL,
	[SORTNO]      [decimal](10, 0) NOT NULL DEFAULT ((0)),
	[REMARKS]     [nvarchar](200) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S007] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[MENUL1KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '대메뉴', 'user', dbo, 'table',[S007]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S007], 'column', [COMPCD]                        
EXEC   sp_addextendedproperty 'MS_Description', '대메뉴코드', 'user', dbo, 'table', [S007], 'column', [MENUL1KEY]                   
EXEC   sp_addextendedproperty 'MS_Description', '명칭', 'user', dbo, 'table', [S007], 'column', [L1TITLE]                     
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [S007], 'column', [SORTNO]                      
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S007], 'column', [REMARKS]                     
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S007], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S007], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S007], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S007], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S007], 'column', TERMINALCD																									
GO

--중메뉴
CREATE TABLE [dbo].[S008](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[MENUL1KEY]   [decimal](10, 0) NOT NULL,
	[MENUL2KEY]   [decimal](10, 0) NOT NULL,
	[L2TITLE]     [nvarchar](50) NOT NULL,
	[SORTNO]      [decimal](10, 0) NOT NULL DEFAULT ((0)),
	[REMARKS]     [nvarchar](200) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S008] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[MENUL1KEY] ASC,
	[MENUL2KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '중메뉴', 'user', dbo, 'table',[S008]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S008], 'column', [COMPCD]                           
EXEC   sp_addextendedproperty 'MS_Description', '대메뉴코드', 'user', dbo, 'table', [S008], 'column', [MENUL1KEY]                      
EXEC   sp_addextendedproperty 'MS_Description', '중메뉴코드', 'user', dbo, 'table', [S008], 'column', [MENUL2KEY]                      
EXEC   sp_addextendedproperty 'MS_Description', '중메뉴명', 'user', dbo, 'table', [S008], 'column', [L2TITLE]                        
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [S008], 'column', [SORTNO]                         
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S008], 'column', [REMARKS]                        
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S008], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S008], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S008], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S008], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S008], 'column', TERMINALCD																									
GO


--소메뉴
CREATE TABLE [dbo].[S009](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[MENUL1KEY]   [decimal](10, 0) NOT NULL,
	[MENUL2KEY]   [decimal](10, 0) NOT NULL,
	[APPKEY]      [nvarchar](20) NOT NULL,
	[L3TITLE]     [nvarchar](50) NOT NULL,
	[SORTNO]      [decimal](10, 0) NOT NULL DEFAULT ((0)),
	[REMARKS]     [nvarchar](200) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S009] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[MENUL1KEY] ASC,
	[MENUL2KEY] ASC,
	[APPKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '소메뉴', 'user', dbo, 'table',[S009]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S009], 'column', [COMPCD]                                
EXEC   sp_addextendedproperty 'MS_Description', '대메뉴코드', 'user', dbo, 'table', [S009], 'column', [MENUL1KEY]                           
EXEC   sp_addextendedproperty 'MS_Description', '중메뉴코드', 'user', dbo, 'table', [S009], 'column', [MENUL2KEY]                           
EXEC   sp_addextendedproperty 'MS_Description', '프로그램코드', 'user', dbo, 'table', [S009], 'column', [APPKEY]                              
EXEC   sp_addextendedproperty 'MS_Description', '소메뉴명', 'user', dbo, 'table', [S009], 'column', [L3TITLE]                             
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [S009], 'column', [SORTNO]                              
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S009], 'column', [REMARKS]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S009], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S009], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S009], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S009], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S009], 'column', TERMINALCD																									
GO

-- 사용자
CREATE TABLE [dbo].[S010](
	[COMPCD]                [nvarchar](20) NOT NULL,
	[USERCD]                [nvarchar](20) NOT NULL,
	[NAME]                  [nvarchar](100) NOT NULL,
	[PASS]                  [nvarchar](500) NOT NULL,
	[ORGCD]                 [nvarchar](20) NULL,
	[CUSTCD]                [nvarchar](20) NULL,
	[DEPTCD]                [nvarchar](20) NULL,
	[POSITION]              [nvarchar](50) NULL,
	[WHCD]                  [nvarchar](20) NULL,
	[USERGROUP]             [nvarchar](20) NULL,
	[PHONENO]               [nvarchar](25) NULL,
	[FAX]                   [nvarchar](25) NULL,
	[EMAIL]                 [nvarchar](80) NULL,
	[SEX]                   [nvarchar](5) NULL,
	[BIRTHDATE]             [nvarchar](8) NULL,
	[WORKTYPE]              [nvarchar](5) NULL,
	[EMPLOYTYPE]            [nvarchar](5) NULL,
	[EMPLOYDATE]            [nvarchar](8) NULL,
	[ISDRT]                 [nvarchar](1) NULL DEFAULT ('N'),
	[ATTACH_FILE_PATH]      [nvarchar](100) NULL,
	[ATTACH_FILE_REAL_NAME] [nvarchar](100) NULL,
	[PWDCHGDATE]            [datetime] NULL,
	[ISLOCK]                [nvarchar](1) NULL DEFAULT ('N'),
	[ISUSING]               [nvarchar](1) NULL DEFAULT ('Y'),
	[ADDUSERCD]             [nvarchar](20) NULL,
	[ADDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]             [nvarchar](20) NULL,
	[UPDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]            [nvarchar](50) NULL,
 CONSTRAINT [PK_S010] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[USERCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '사용자', 'user', dbo, 'table',[S010]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S010], 'column', [COMPCD]                  
EXEC   sp_addextendedproperty 'MS_Description', '사용자코드', 'user', dbo, 'table', [S010], 'column', [USERCD]                
EXEC   sp_addextendedproperty 'MS_Description', '사용자명', 'user', dbo, 'table', [S010], 'column', [NAME]                  
EXEC   sp_addextendedproperty 'MS_Description', '비밀번호', 'user', dbo, 'table', [S010], 'column', [PASS]                  
EXEC   sp_addextendedproperty 'MS_Description', '셀러', 'user', dbo, 'table', [S010], 'column', [ORGCD]
EXEC   sp_addextendedproperty 'MS_Description', '부서코드', 'user', dbo, 'table', [S010], 'column', [DEPTCD]                
EXEC   sp_addextendedproperty 'MS_Description', '직급', 'user', dbo, 'table', [S010], 'column', [POSITION]
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [S010], 'column', [WHCD]           
EXEC   sp_addextendedproperty 'MS_Description', '사용자그룹', 'user', dbo, 'table', [S010], 'column', [USERGROUP]             
EXEC   sp_addextendedproperty 'MS_Description', '전화번호', 'user', dbo, 'table', [S010], 'column', [PHONENO]               
EXEC   sp_addextendedproperty 'MS_Description', '팩스', 'user', dbo, 'table', [S010], 'column', [FAX]                   
EXEC   sp_addextendedproperty 'MS_Description', '이메일', 'user', dbo, 'table', [S010], 'column', [EMAIL]                 
EXEC   sp_addextendedproperty 'MS_Description', '성별', 'user', dbo, 'table', [S010], 'column', [SEX]                   
EXEC   sp_addextendedproperty 'MS_Description', '생년월일', 'user', dbo, 'table', [S010], 'column', [BIRTHDATE]             
EXEC   sp_addextendedproperty 'MS_Description', 'WORKTYPE', 'user', dbo, 'table', [S010], 'column', [WORKTYPE]              
EXEC   sp_addextendedproperty 'MS_Description', 'EMPLOYTYPE', 'user', dbo, 'table', [S010], 'column', [EMPLOYTYPE]            
EXEC   sp_addextendedproperty 'MS_Description', '고용일', 'user', dbo, 'table', [S010], 'column', [EMPLOYDATE]  
EXEC   sp_addextendedproperty 'MS_Description', '전결여부', 'user', dbo, 'table', [S010], 'column', [ISDRT]            
EXEC   sp_addextendedproperty 'MS_Description', '사진파일명', 'user', dbo, 'table', [S010], 'column', [ATTACH_FILE_PATH]      
EXEC   sp_addextendedproperty 'MS_Description', '사진파일경로', 'user', dbo, 'table', [S010], 'column', [ATTACH_FILE_REAL_NAME] 
EXEC   sp_addextendedproperty 'MS_Description', '비밀번호변경일', 'user', dbo, 'table', [S010], 'column', [PWDCHGDATE]            
EXEC   sp_addextendedproperty 'MS_Description', '잠김여부', 'user', dbo, 'table', [S010], 'column', [ISLOCK]                
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [S010], 'column', [ISUSING]               
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S010], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S010], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S010], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S010], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S010], 'column', TERMINALCD																									
GO

-- 사용자별 그리드 정보
CREATE TABLE [dbo].[S011](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[USERCD]      [nvarchar](20) NOT NULL,
	[APPKEY]      [nvarchar](20) NOT NULL,
	[GRIDID]      [nvarchar](50) NOT NULL,
	[COLKEY]      [nvarchar](50) NULL,
	[COLNAME]     [nvarchar](50) NULL,
	[COLHIDDEN]   [nvarchar](10) NULL,
	[COLWIDTH]    [decimal](10, 0) NULL,
	[COLINX]      [decimal](10, 0) NULL,
	[COLJSON]     [varchar](MAX) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S011] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[USERCD] ASC,
	[APPKEY] ASC,
	[GRIDID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '사용자별 그리드 정보', 'user', dbo, 'table',[S011]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S011], 'column', [COMPCD]        
EXEC   sp_addextendedproperty 'MS_Description', '사용자코드', 'user', dbo, 'table', [S011], 'column', [USERCD]      
EXEC   sp_addextendedproperty 'MS_Description', '프로그램ID', 'user', dbo, 'table', [S011], 'column', [APPKEY]  
EXEC   sp_addextendedproperty 'MS_Description', '그리드ID', 'user', dbo, 'table', [S011], 'column', [GRIDID]      
EXEC   sp_addextendedproperty 'MS_Description', '컬럼KEY', 'user', dbo, 'table', [S011], 'column', [COLKEY]      
EXEC   sp_addextendedproperty 'MS_Description', '컬럼명', 'user', dbo, 'table', [S011], 'column', [COLNAME]     
EXEC   sp_addextendedproperty 'MS_Description', '숨김여부', 'user', dbo, 'table', [S011], 'column', [COLHIDDEN]   
EXEC   sp_addextendedproperty 'MS_Description', '길이', 'user', dbo, 'table', [S011], 'column', [COLWIDTH]    
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [S011], 'column', [COLINX]
EXEC   sp_addextendedproperty 'MS_Description', 'JSON', 'user', dbo, 'table', [S011], 'column', [COLJSON]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S011], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S011], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S011], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S011], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S011], 'column', TERMINALCD																									
GO

--마이메뉴
CREATE TABLE [dbo].[S012](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[USERCD]      [nvarchar](20) NOT NULL,
	[APPKEY]      [nvarchar](20) NOT NULL,
	[L2TITLE]     [nvarchar](50) NOT NULL,
	[SORTNO]      [decimal](10, 0) NOT NULL DEFAULT ((0)),
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_S012] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[USERCD] ASC,
	[APPKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '마이메뉴', 'user', dbo, 'table',[S012]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S012], 'column', [COMPCD]            
EXEC   sp_addextendedproperty 'MS_Description', '사용자코드', 'user', dbo, 'table', [S012], 'column', [USERCD]          
EXEC   sp_addextendedproperty 'MS_Description', '프로그램코드', 'user', dbo, 'table', [S012], 'column', [APPKEY]          
EXEC   sp_addextendedproperty 'MS_Description', '중메뉴명', 'user', dbo, 'table', [S012], 'column', [L2TITLE]         
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [S012], 'column', [SORTNO]   
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S012], 'column', ADDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S012], 'column', ADDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S012], 'column', UPDUSERCD																									
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S012], 'column', UPDDATETIME																									
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S012], 'column', TERMINALCD																									
GO


--사용자 로그인 이력
CREATE TABLE [dbo].[S013](
	[COMPCD]          [nvarchar](20) NOT NULL,
	[USERCD]          [nvarchar](20) NOT NULL,
	[HISTORYKEY]      [decimal](10, 0) NOT NULL,
	[HISTORYTYPE]     [nvarchar](20) NULL,
	[HISTORYDATETIME] [datetime] NULL DEFAULT (getdate()),
	[USERIP]          [nvarchar](50) NULL,
	[USERLOCALIP]     [nvarchar](50) NULL,
	[USEROS]          [nvarchar](50) NULL,
	[USERBROWSER]     [nvarchar](50) NULL,
	[STATUS]          [nvarchar](50) NULL,
	[REMARK]          [nvarchar](100) NULL,
 CONSTRAINT [PK_S013] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[USERCD] ASC,
	[HISTORYKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/*																									
	1. 주석추가 (add)																								
*/																									
/*테이블 */																									
EXEC   sp_addextendedproperty 'MS_Description', '사용자 로그인 이력', 'user', dbo, 'table',[S013]																									
/*컬럼들*/																									
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S013], 'column', [COMPCD]                  
EXEC   sp_addextendedproperty 'MS_Description', '사용자코드', 'user', dbo, 'table', [S013], 'column', [USERCD]                
EXEC   sp_addextendedproperty 'MS_Description', '이력KEY', 'user', dbo, 'table', [S013], 'column', [HISTORYKEY]            
EXEC   sp_addextendedproperty 'MS_Description', '이력TYPE', 'user', dbo, 'table', [S013], 'column', [HISTORYTYPE]           
EXEC   sp_addextendedproperty 'MS_Description', '일시', 'user', dbo, 'table', [S013], 'column', [HISTORYDATETIME]       
EXEC   sp_addextendedproperty 'MS_Description', '사용자IP', 'user', dbo, 'table', [S013], 'column', [USERIP]                
EXEC   sp_addextendedproperty 'MS_Description', '사용자로컬IP', 'user', dbo, 'table', [S013], 'column', [USERLOCALIP]           
EXEC   sp_addextendedproperty 'MS_Description', '사용자OS', 'user', dbo, 'table', [S013], 'column', [USEROS]                
EXEC   sp_addextendedproperty 'MS_Description', '사용자BROWSER', 'user', dbo, 'table', [S013], 'column', [USERBROWSER]           
EXEC   sp_addextendedproperty 'MS_Description', '로그인상태', 'user', dbo, 'table', [S013], 'column', [STATUS]                
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [S013], 'column', [REMARK]              																								
GO

--공지사항
CREATE TABLE [dbo].[S014](
	[NTKEY]				    [nvarchar](20) NOT NULL,
	[COMPCD]				[nvarchar](20) NOT NULL,
	[STARTDT]			    [nvarchar](8) NOT NULL,
	[ENDDT]			        [nvarchar](8) NOT NULL,
	[NTTYPE]			    [nvarchar](10) NOT NULL,
	[TITLE]					[nvarchar](200) NOT NULL,
	[CONTENTS]				[nvarchar](MAX) NOT NULL,
	[HITS]					[decimal](10, 0) NULL DEFAULT (0),
	[TARGET]				[nvarchar](20) NULL,
	[POPFLG]				[nvarchar](1) NULL DEFAULT ('N'),
	[ISUSING]				[nvarchar](1) NULL DEFAULT ('Y'),
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL,
 CONSTRAINT [PK_S014] PRIMARY KEY CLUSTERED
(
	[NTKEY] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '공지사항', 'user', dbo, 'table',[S014]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '공지번호', 'user', dbo, 'table', [S014], 'column', [NTKEY]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S014], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '시작일', 'user', dbo, 'table', [S014], 'column', [STARTDT]
EXEC   sp_addextendedproperty 'MS_Description', '종료일', 'user', dbo, 'table', [S014], 'column', [ENDDT]
EXEC   sp_addextendedproperty 'MS_Description', '공지유형', 'user', dbo, 'table', [S014], 'column', [NTTYPE]
EXEC   sp_addextendedproperty 'MS_Description', '공지제목', 'user', dbo, 'table', [S014], 'column', [TITLE]
EXEC   sp_addextendedproperty 'MS_Description', '내용', 'user', dbo, 'table', [S014], 'column', [CONTENTS]
EXEC   sp_addextendedproperty 'MS_Description', '조회수', 'user', dbo, 'table', [S014], 'column', [HITS]
EXEC   sp_addextendedproperty 'MS_Description', '공지대상유형', 'user', dbo, 'table', [S014], 'column', [TARGET]
EXEC   sp_addextendedproperty 'MS_Description', '팝업공지여부', 'user', dbo, 'table', [S014], 'column', [POPFLG]
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [S014], 'column', [ISUSING]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S014], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S014], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S014], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S014], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S014], 'column', [TERMINALCD]
GO

--공지사항대상
CREATE TABLE [dbo].[S015](
	[NTKEY]				    [nvarchar](20) NOT NULL,
	[SEQ]				    [decimal](10, 0) NOT NULL,
	[COMPCD]				[nvarchar](20) NULL,
	[ORGCD]			        [nvarchar](20) NULL,
	[DEPTCD]			    [nvarchar](20) NULL,
	[CUSTCD]			    [nvarchar](20) NULL,
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL,
 CONSTRAINT [PK_S015] PRIMARY KEY CLUSTERED
(
	[NTKEY] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '공지사항대상', 'user', dbo, 'table',[S015]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '공지번호', 'user', dbo, 'table', [S015], 'column', [NTKEY]
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [S015], 'column', [SEQ]
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [S015], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [S015], 'column', [ORGCD]
EXEC   sp_addextendedproperty 'MS_Description', '부서코드', 'user', dbo, 'table', [S015], 'column', [DEPTCD]
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [S015], 'column', [CUSTCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S015], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S015], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S015], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S015], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S015], 'column', [TERMINALCD]
GO


--공지사항대상
CREATE TABLE [dbo].[S016](
	[NTKEY]				    [nvarchar](20) NOT NULL,
	[SEQ]				    [decimal](10, 0) NOT NULL,
	[FILENM]				[nvarchar](255) NULL,
	[ORIGINFILENM]			[nvarchar](255) NULL,
	[FILESZ]				[decimal](17,0) NULL,
	[ADDUSERCD]				[nvarchar](20) NULL,
	[ADDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]				[nvarchar](20) NULL,
	[UPDDATETIME]			[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]			[nvarchar](50) NULL,
 CONSTRAINT [PK_S016] PRIMARY KEY CLUSTERED
(
	[NTKEY] ASC,
	[SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '공지사항 첨부파일', 'user', dbo, 'table',[S016]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '공지번호', 'user', dbo, 'table', [S016], 'column', [NTKEY]
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [S016], 'column', [SEQ]
EXEC   sp_addextendedproperty 'MS_Description', '첨부파일명', 'user', dbo, 'table', [S016], 'column', [FILENM]
EXEC   sp_addextendedproperty 'MS_Description', '첨부파일 실경로', 'user', dbo, 'table', [S016], 'column', [ORIGINFILENM]
EXEC   sp_addextendedproperty 'MS_Description', '파일크기', 'user', dbo, 'table', [S016], 'column', [FILESZ]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [S016], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [S016], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [S016], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [S016], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [S016], 'column', [TERMINALCD]
GO


CREATE TABLE [dbo].[DUAL](
	[DUMMY] [int] NULL
) ON [PRIMARY]
GO

EXEC   sp_addextendedproperty 'MS_Description', 'DUAL', 'user', dbo, 'table',[DUAL]
EXEC   sp_addextendedproperty 'MS_Description', '값,1,항상 1개 행만 유지', 'user', dbo, 'table', [DUAL], 'column', [DUMMY]
GO

--COMMIT