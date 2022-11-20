--입고마스터
CREATE TABLE [dbo].[P130](
   [WIKEY]       [nvarchar](20) NOT NULL,
   [EAKEY]       [nvarchar](20) NULL,
   [PREKEY]      [nvarchar](20) NULL,
   [WITYPE]      [nvarchar](10) NULL,
   [WISTS]       [nvarchar](10) NOT NULL,
   [WISCHDT]     [nvarchar](8) NULL,
   [WIDT]        [nvarchar](8) NULL,
   [COMPCD]      [nvarchar](20) NOT NULL,
   [WHCD]        [nvarchar](20) NOT NULL,
   [CUSTCD]      [nvarchar](20) NOT NULL,
   [ORGCD]       [nvarchar](20) NOT NULL,
   [DEPTCD]      [nvarchar](20) NULL,
   [USERCD]      [nvarchar](20) NULL,
   [VATFLG]       [nvarchar](20) NULL,
   [CARNO]       [nvarchar](20) NULL,
   [DRIVER]      [nvarchar](20) NULL,
   [DRIVERTEL]   [nvarchar](20) NULL,
   [POKEY]       [nvarchar](20) NULL,
   [WDKEY]       [nvarchar](20) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
   
   --추가
   [IFWIPRICE]	 [decimal](18,0) NULL --입고비
   
 CONSTRAINT [PK_P130] PRIMARY KEY CLUSTERED
(
   [WIKEY] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P130_01] ON [dbo].[P130]
(
	[EAKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P130_02] ON [dbo].[P130]
(
	[PREKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P130_03] ON [dbo].[P130]
(
	[POKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P130_04] ON [dbo].[P130]
(
	[WDKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P130_05] ON [dbo].[P130]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WISCHDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P130 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '입고마스터', 'user', dbo, 'table',[P130]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '입고번호', 'user', dbo, 'table', [P130], 'column', WIKEY
EXEC   sp_addextendedproperty 'MS_Description', '전자결재번호', 'user', dbo, 'table', [P130], 'column', EAKEY
EXEC   sp_addextendedproperty 'MS_Description', '작업단위번호(매입작업단위)', 'user', dbo, 'table', [P130], 'column', PREKEY
EXEC   sp_addextendedproperty 'MS_Description', '입고유형', 'user', dbo, 'table', [P130], 'column', WITYPE
EXEC   sp_addextendedproperty 'MS_Description', '입고상태', 'user', dbo, 'table', [P130], 'column', WISTS
EXEC   sp_addextendedproperty 'MS_Description', '입고요청일', 'user', dbo, 'table', [P130], 'column', WISCHDT
EXEC   sp_addextendedproperty 'MS_Description', '입고일', 'user', dbo, 'table', [P130], 'column', WIDT
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P130], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P130], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P130], 'column', CUSTCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P130], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '부서코드', 'user', dbo, 'table', [P130], 'column', DEPTCD
EXEC   sp_addextendedproperty 'MS_Description', '사용자코드', 'user', dbo, 'table', [P130], 'column', USERCD
EXEC   sp_addextendedproperty 'MS_Description', '과세구분(0:매입과세, 1:수입영세, 2:매입면세, 3:매입기타)', 'user', dbo, 'table', [P130], 'column', VATFLG
EXEC   sp_addextendedproperty 'MS_Description', '입고차량번호', 'user', dbo, 'table', [P130], 'column', CARNO
EXEC   sp_addextendedproperty 'MS_Description', '입고차량운전자', 'user', dbo, 'table', [P130], 'column', DRIVER
EXEC   sp_addextendedproperty 'MS_Description', '입고차량운전자 연락처', 'user', dbo, 'table', [P130], 'column', DRIVERTEL
EXEC   sp_addextendedproperty 'MS_Description', '발주번호', 'user', dbo, 'table', [P130], 'column', POKEY
EXEC   sp_addextendedproperty 'MS_Description', '입고지시번호', 'user', dbo, 'table', [P130], 'column', WDKEY
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P130], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P130], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P130], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P130], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P130], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P130], 'column', TERMINALCD

--추가
EXEC   sp_addextendedproperty 'MS_Description', '입고비(I/F)', 'user', dbo, 'table', [P130], 'column', IFWIPRICE
GO


-- 입고상세
CREATE TABLE [dbo].[P131](
   [WIKEY]       [nvarchar](20) NOT NULL,
   [SEQ]         [decimal](10,0) NOT NULL,
   [ITEMCD]      [nvarchar](20) NOT NULL,
   [ORIGINQTY]   [decimal](17,6) NULL,
   [WISCHQTY]    [decimal](17,6) NULL,   
   [WIQTY]       [decimal](17,6) NULL,
   [EXCHCD]      [nvarchar](10) NULL,      --화폐단위
   [EXCHRATE]    [decimal](17,6) NULL,     --환율
   [UNITPRICE]   [decimal](17,6) NULL,     --화폐단위단가
   [EXCHAMT]     [decimal](17,4) NULL,     --입고금액(화폐단위)
   [SUPPLYAMT]   [decimal](17,4) NULL,     --입고금액(원화환산)
   [LOT1]        [nvarchar](50) NULL,
   [LOT2]        [nvarchar](50) NULL,
   [LOT3]        [nvarchar](50) NULL,
   [LOT4]        [nvarchar](20) NULL,
   [LOT5]        [nvarchar](20) NULL,
   [COMPCD]      [nvarchar](20) NOT NULL,
   [ORGCD]       [nvarchar](20) NOT NULL,
   [WHCD]        [nvarchar](20) NOT NULL,
   [POKEY]       [nvarchar](20) NULL,
   [POSEQ]       [decimal](10,0) NULL,
   [PREDISTAMT]  [decimal](17,4) NULL,     --배부전금액
   [DISTAMT]     [decimal](17,4) NULL,     --배부비용금액
   [LOCCD]       [nvarchar](20) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
   
   --추가
   [IFORDERNO]     [nvarchar](20) NULL, --구매번호
   [IFORDERSUBNO]  [nvarchar](20) NULL, --상세번호
   [IFORDERSEQ]    [decimal](18,0) NULL, --순번
   [IFPOQTY]       [decimal](17,6) NULL, --구매서 입고요청량
 CONSTRAINT [PK_P131] PRIMARY KEY CLUSTERED
(
   [WIKEY] ASC,
   [SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P131_01] ON [dbo].[P131]
(
	[POKEY] ASC,
	[POSEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P131 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '입고상세', 'user', dbo, 'table',[P131]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '입고번호', 'user', dbo, 'table', [P131], 'column', WIKEY
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [P131], 'column', SEQ
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P131], 'column', ITEMCD
EXEC   sp_addextendedproperty 'MS_Description', '최초입고예정수량', 'user', dbo, 'table', [P131], 'column', ORIGINQTY
EXEC   sp_addextendedproperty 'MS_Description', '입고예정수량', 'user', dbo, 'table', [P131], 'column', WISCHQTY
EXEC   sp_addextendedproperty 'MS_Description', '입고수량', 'user', dbo, 'table', [P131], 'column', WIQTY
EXEC   sp_addextendedproperty 'MS_Description', '화폐단위', 'user', dbo, 'table', [P131], 'column', EXCHCD
EXEC   sp_addextendedproperty 'MS_Description', '환율', 'user', dbo, 'table', [P131], 'column', EXCHRATE
EXEC   sp_addextendedproperty 'MS_Description', '화폐단위단가', 'user', dbo, 'table', [P131], 'column', UNITPRICE
EXEC   sp_addextendedproperty 'MS_Description', '입고금액(화폐단위)', 'user', dbo, 'table', [P131], 'column', EXCHAMT
EXEC   sp_addextendedproperty 'MS_Description', '입고금액(원화환산)', 'user', dbo, 'table', [P131], 'column', SUPPLYAMT
EXEC   sp_addextendedproperty 'MS_Description', '로트속성1', 'user', dbo, 'table', [P131], 'column', LOT1
EXEC   sp_addextendedproperty 'MS_Description', '로트속성2', 'user', dbo, 'table', [P131], 'column', LOT2
EXEC   sp_addextendedproperty 'MS_Description', '로트속성3', 'user', dbo, 'table', [P131], 'column', LOT3
EXEC   sp_addextendedproperty 'MS_Description', '로트속성4', 'user', dbo, 'table', [P131], 'column', LOT4
EXEC   sp_addextendedproperty 'MS_Description', '로트속성5', 'user', dbo, 'table', [P131], 'column', LOT5
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P131], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P131], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P131], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '발주번호', 'user', dbo, 'table', [P131], 'column', POKEY
EXEC   sp_addextendedproperty 'MS_Description', '발주순번', 'user', dbo, 'table', [P131], 'column', POSEQ
EXEC   sp_addextendedproperty 'MS_Description', '배부전금액', 'user', dbo, 'table', [P131], 'column', PREDISTAMT
EXEC   sp_addextendedproperty 'MS_Description', '배부비용금액', 'user', dbo, 'table', [P131], 'column', DISTAMT
EXEC   sp_addextendedproperty 'MS_Description', '실적로케이션(단순입고용)', 'user', dbo, 'table', [P131], 'column', LOCCD
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P131], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P131], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P131], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P131], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P131], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P131], 'column', TERMINALCD

--추가
EXEC   sp_addextendedproperty 'MS_Description', '구매번호(I/F)', 'user', dbo, 'table', [P131], 'column', IFORDERNO
EXEC   sp_addextendedproperty 'MS_Description', '싱세번호(I/F)', 'user', dbo, 'table', [P131], 'column', IFORDERSUBNO
EXEC   sp_addextendedproperty 'MS_Description', '순번(I/F)', 'user', dbo, 'table', [P131], 'column', IFORDERSEQ
EXEC   sp_addextendedproperty 'MS_Description', '구매서 입고요청량(I/F)', 'user', dbo, 'table', [P131], 'column', IFPOQTY
GO


--입고지시마스터
CREATE TABLE [dbo].[P140](
   [WDKEY]       [nvarchar](20) NOT NULL,
   [WDDT]        [nvarchar](8) NULL,
   [WDTYPE]      [nvarchar](20) NULL,
   [COMPCD]      [nvarchar](20) NOT NULL,
   [WHCD]        [nvarchar](20) NOT NULL,
   [ORGCD]       [nvarchar](20) NOT NULL,
   [WORKER]      [nvarchar](20) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P140] PRIMARY KEY CLUSTERED
(
   [WDKEY] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IDX_P140_01] ON [dbo].[P140]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[WDDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P140 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '입고지시마스터', 'user', dbo, 'table',[P140]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '입고지시번호', 'user', dbo, 'table', [P140], 'column', WDKEY
EXEC   sp_addextendedproperty 'MS_Description', '입고지시일자', 'user', dbo, 'table', [P140], 'column', WDDT
EXEC   sp_addextendedproperty 'MS_Description', '입고지시유형', 'user', dbo, 'table', [P140], 'column', WDTYPE
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P140], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P140], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P140], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '작업자', 'user', dbo, 'table', [P140], 'column', WORKER
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P140], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P140], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P140], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P140], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P140], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P140], 'column', TERMINALCD
GO


-- 입고지시상세
CREATE TABLE [dbo].[P141](
   [WDKEY]       [nvarchar](20) NOT NULL,
   [SEQ]         [decimal](10,0) NOT NULL,
   [WDSTS]       [nvarchar](5) NOT NULL,
   [PREKEY]      [nvarchar](20) NULL,
   [WIKEY]       [nvarchar](20) NULL,
   [WISEQ]       [decimal](10,0) NULL,
   [ITEMCD]      [nvarchar](20) NOT NULL,
   [LOT1]        [nvarchar](50) NULL,
   [LOT2]        [nvarchar](50) NULL,
   [LOT3]        [nvarchar](50) NULL,
   [LOT4]        [nvarchar](20) NULL,
   [LOT5]        [nvarchar](20) NULL,
   [LOTKEY]      [nvarchar](20) NULL,
   [COMPCD]      [nvarchar](20) NULL,
   [WHCD]        [nvarchar](20) NULL,
   [ORGCD]       [nvarchar](20) NULL,
   [SCHLOCCD]    [nvarchar](20) NULL,
   [WDSCHQTY]    [decimal](17,6) NULL,
   [LOCCD]       [nvarchar](20) NULL,
   [WDQTY]       [decimal](17,6) NULL,
   [WORKER]      [nvarchar](20) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P141] PRIMARY KEY CLUSTERED
(
   [WDKEY] ASC,
   [SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P141_01] ON [dbo].[P141]
(
	[PREKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

CREATE NONCLUSTERED INDEX [IDX_P141_02] ON [dbo].[P141]
(
	[WIKEY] ASC,
	[WISEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P141 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '입고지시상세', 'user', dbo, 'table',[P141]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '입고지시번호', 'user', dbo, 'table', [P141], 'column', WDKEY
EXEC   sp_addextendedproperty 'MS_Description', '일련번호', 'user', dbo, 'table', [P141], 'column', SEQ
EXEC   sp_addextendedproperty 'MS_Description', '입고지시상세상태', 'user', dbo, 'table', [P141], 'column', WDSTS
EXEC   sp_addextendedproperty 'MS_Description', '작업단위번호', 'user', dbo, 'table', [P141], 'column', PREKEY
EXEC   sp_addextendedproperty 'MS_Description', '입고번호', 'user', dbo, 'table', [P141], 'column', WIKEY
EXEC   sp_addextendedproperty 'MS_Description', '입고일련번호', 'user', dbo, 'table', [P141], 'column', WISEQ
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P141], 'column', ITEMCD
EXEC   sp_addextendedproperty 'MS_Description', '로트속성1', 'user', dbo, 'table', [P141], 'column', LOT1
EXEC   sp_addextendedproperty 'MS_Description', '로트속성2', 'user', dbo, 'table', [P141], 'column', LOT2
EXEC   sp_addextendedproperty 'MS_Description', '로트속성3', 'user', dbo, 'table', [P141], 'column', LOT3
EXEC   sp_addextendedproperty 'MS_Description', '로트속성4(코드)', 'user', dbo, 'table', [P141], 'column', LOT4
EXEC   sp_addextendedproperty 'MS_Description', '로트속성5(코드)', 'user', dbo, 'table', [P141], 'column', LOT5
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P141], 'column', LOTKEY
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P141], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P141], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P141], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '지시로케이션', 'user', dbo, 'table', [P141], 'column', SCHLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '지시수량', 'user', dbo, 'table', [P141], 'column', WDSCHQTY
EXEC   sp_addextendedproperty 'MS_Description', '실적로케이션', 'user', dbo, 'table', [P141], 'column', LOCCD
EXEC   sp_addextendedproperty 'MS_Description', '실적수량', 'user', dbo, 'table', [P141], 'column', WDQTY
EXEC   sp_addextendedproperty 'MS_Description', '작업자', 'user', dbo, 'table', [P141], 'column', WORKER
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P141], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P141], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P141], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P141], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P141], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P141], 'column', TERMINALCD
GO
