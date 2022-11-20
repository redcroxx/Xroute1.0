-- 회사
CREATE TABLE [dbo].[P001](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[NAME]        [nvarchar](50) NOT NULL,
	[SNAME]       [nvarchar](100) NOT NULL,
	[TEL1]        [nvarchar](20) NULL,
	[TEL2]        [nvarchar](20) NULL,
	[FAX1]        [nvarchar](20) NULL,
	[FAX2]        [nvarchar](20) NULL,
	[POST]        [nvarchar](15) NULL,
	[ADDR]        [nvarchar](200) NULL,
	[ADDR2]       [nvarchar](200) NULL,
	[CEO]         [nvarchar](50) NULL,
	[BIZDATE]     [nvarchar](8) NULL,
	[BIZNO1]      [nvarchar](50) NULL,
	[BIZNO2]      [nvarchar](50) NULL,
	[BIZKIND]     [nvarchar](50) NULL,
	[BIZTYPE]     [nvarchar](50) NULL,
	[EMAIL]       [nvarchar](50) NULL,
	[WEBADDR]     [nvarchar](50) NULL,
	[NATION]      [nvarchar](20) NULL,
	[REMARKS]     [nvarchar](255) NULL,
	[ISUSING]     [nvarchar](1) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P001] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '회사', 'user', dbo, 'table',[P001]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P001], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '회사명', 'user', dbo, 'table', [P001], 'column', NAME
EXEC   sp_addextendedproperty 'MS_Description', '회사명(약칭)', 'user', dbo, 'table', [P001], 'column', SNAME
EXEC   sp_addextendedproperty 'MS_Description', '전화번호1', 'user', dbo, 'table', [P001], 'column', TEL1
EXEC   sp_addextendedproperty 'MS_Description', '전화번호2', 'user', dbo, 'table', [P001], 'column', TEL2
EXEC   sp_addextendedproperty 'MS_Description', '팩스1', 'user', dbo, 'table', [P001], 'column', FAX1
EXEC   sp_addextendedproperty 'MS_Description', '팩스2', 'user', dbo, 'table', [P001], 'column', FAX2
EXEC   sp_addextendedproperty 'MS_Description', '우편번호', 'user', dbo, 'table', [P001], 'column', POST
EXEC   sp_addextendedproperty 'MS_Description', '주소', 'user', dbo, 'table', [P001], 'column', ADDR
EXEC   sp_addextendedproperty 'MS_Description', '주소상세', 'user', dbo, 'table', [P001], 'column', ADDR2
EXEC   sp_addextendedproperty 'MS_Description', '대표자', 'user', dbo, 'table', [P001], 'column', CEO
EXEC   sp_addextendedproperty 'MS_Description', '창립입', 'user', dbo, 'table', [P001], 'column', BIZDATE
EXEC   sp_addextendedproperty 'MS_Description', '사업자번호1', 'user', dbo, 'table', [P001], 'column', BIZNO1
EXEC   sp_addextendedproperty 'MS_Description', '사업자번호2', 'user', dbo, 'table', [P001], 'column', BIZNO2
EXEC   sp_addextendedproperty 'MS_Description', '업태', 'user', dbo, 'table', [P001], 'column', BIZKIND
EXEC   sp_addextendedproperty 'MS_Description', '업종', 'user', dbo, 'table', [P001], 'column', BIZTYPE
EXEC   sp_addextendedproperty 'MS_Description', '대표이메일', 'user', dbo, 'table', [P001], 'column', EMAIL
EXEC   sp_addextendedproperty 'MS_Description', '홈페이지', 'user', dbo, 'table', [P001], 'column', WEBADDR
EXEC   sp_addextendedproperty 'MS_Description', '국가', 'user', dbo, 'table', [P001], 'column', NATION
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P001], 'column', REMARKS
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P001], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P001], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P001], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P001], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P001], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P001], 'column', TERMINALCD
GO

/*
	2. 주석수정 (update)
EXEC   sp_updateextendedproperty 'MS_Description', '테이블설명', 'user', dbo, 'table',테이블명
EXEC   sp_updateextendedproperty 'MS_Description', '컬럼설명', 'user', dbo, 'table', 테이블명, 'column', 컬럼명
*/

-- 셀러
CREATE TABLE [dbo].[P002](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[ORGCD]       [nvarchar](20) NOT NULL,
	[NAME]        [nvarchar](50) NOT NULL,
	[SNAME]       [nvarchar](100) NULL,
	[TEL1]        [nvarchar](20) NULL,
	[TEL2]        [nvarchar](20) NULL,
	[FAX1]        [nvarchar](20) NULL,
	[FAX2]        [nvarchar](20) NULL,
	[POST]        [nvarchar](15) NULL,
	[ADDR]        [nvarchar](200) NULL,
	[ADDR2]       [nvarchar](200) NULL,
	[CEO]         [nvarchar](50) NULL,
	[BIZDATE]     [nvarchar](8) NULL,
	[BIZNO1]      [nvarchar](50) NULL,
	[BIZNO2]      [nvarchar](50) NULL,
	[BIZKIND]     [nvarchar](50) NULL,
	[BIZTYPE]     [nvarchar](50) NULL,
	[EMAIL]       [nvarchar](50) NULL,
	[WEBADDR]     [nvarchar](50) NULL,
	[NATION]      [nvarchar](20) NULL,
	[REMARKS]     [nvarchar](255) NULL,
	[ISUSING]     [nvarchar](1) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P002] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '셀러', 'user', dbo, 'table',[P002]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P002], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P002], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러명', 'user', dbo, 'table', [P002], 'column', NAME
EXEC   sp_addextendedproperty 'MS_Description', '셀러명(약칭)', 'user', dbo, 'table', [P002], 'column', SNAME
EXEC   sp_addextendedproperty 'MS_Description', '전화번호1', 'user', dbo, 'table', [P002], 'column', TEL1
EXEC   sp_addextendedproperty 'MS_Description', '전화번호2', 'user', dbo, 'table', [P002], 'column', TEL2
EXEC   sp_addextendedproperty 'MS_Description', '팩스1', 'user', dbo, 'table', [P002], 'column', FAX1
EXEC   sp_addextendedproperty 'MS_Description', '팩스2', 'user', dbo, 'table', [P002], 'column', FAX2
EXEC   sp_addextendedproperty 'MS_Description', '우편번호', 'user', dbo, 'table', [P002], 'column', POST
EXEC   sp_addextendedproperty 'MS_Description', '주소', 'user', dbo, 'table', [P002], 'column', ADDR
EXEC   sp_addextendedproperty 'MS_Description', '주소상세', 'user', dbo, 'table', [P002], 'column', ADDR2
EXEC   sp_addextendedproperty 'MS_Description', '대표자', 'user', dbo, 'table', [P002], 'column', CEO
EXEC   sp_addextendedproperty 'MS_Description', '창립입', 'user', dbo, 'table', [P002], 'column', BIZDATE
EXEC   sp_addextendedproperty 'MS_Description', '사업자번호1', 'user', dbo, 'table', [P002], 'column', BIZNO1
EXEC   sp_addextendedproperty 'MS_Description', '사업자번호2', 'user', dbo, 'table', [P002], 'column', BIZNO2
EXEC   sp_addextendedproperty 'MS_Description', '업태', 'user', dbo, 'table', [P002], 'column', BIZKIND
EXEC   sp_addextendedproperty 'MS_Description', '업종', 'user', dbo, 'table', [P002], 'column', BIZTYPE
EXEC   sp_addextendedproperty 'MS_Description', '대표이메일', 'user', dbo, 'table', [P002], 'column', EMAIL
EXEC   sp_addextendedproperty 'MS_Description', '홈페이지', 'user', dbo, 'table', [P002], 'column', WEBADDR
EXEC   sp_addextendedproperty 'MS_Description', '국가', 'user', dbo, 'table', [P002], 'column', NATION
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P002], 'column', REMARKS
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P002], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P002], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P002], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P002], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P002], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P002], 'column', TERMINALCD
GO

-- 거래처
CREATE TABLE [dbo].[P003](
	[COMPCD]       [nvarchar](20) NOT NULL,
	[CUSTCD]       [nvarchar](20) NOT NULL,
	[ORGCD]        [nvarchar](20) NOT NULL,
	[CUSTGROUP]    [nvarchar](20) NULL,
	[CATEGORYCD]   [nvarchar](20) NULL,
	[NAME]         [nvarchar](100) NOT NULL,
	[SNAME]        [nvarchar](100) NULL,
	[ANAME]        [nvarchar](100) NULL,
	[CEO]          [nvarchar](50) NULL,
	[BIZKIND]      [nvarchar](50) NULL,
	[BIZTYPE]      [nvarchar](50) NULL,
	[BIZNO]        [nvarchar](20) NULL,
	[ADDR1]        [nvarchar](100) NULL,
	[ADDR2]        [nvarchar](100) NULL,
	[ADDR3]        [nvarchar](100) NULL,
	[POST]         [nvarchar](10) NULL,
	[COUNTRYCD]    [nvarchar](20) NULL,
	[PORTCD]       [nvarchar](20) NULL,
	[DISTRICTCD]   [nvarchar](20) NULL,
	[PHONE1]       [nvarchar](25) NULL,
	[PHONE2]       [nvarchar](25) NULL,
	[FAX1]         [nvarchar](25) NULL,
	[FAX2]         [nvarchar](25) NULL,
	[EMAIL]        [nvarchar](80) NULL,
	[URL]          [nvarchar](80) NULL,
	[REFUSERNM]    [nvarchar](20) NULL,
	[REFUSERPHONE] [nvarchar](25) NULL,
	[ISSALES]      [nvarchar](1) NULL DEFAULT ('N'),
	[ISSUPPLIER]   [nvarchar](1) NULL DEFAULT ('N'),
	[ISSHIPPER]    [nvarchar](1) NULL DEFAULT ('N'),
	[ISDELIVERY]   [nvarchar](1) NULL DEFAULT ('N'),
	[REMARK]       [nvarchar](255) NULL,
	[F_USER1]      [nvarchar](100) NULL,
	[F_USER2]      [nvarchar](100) NULL,
	[F_USER3]      [nvarchar](100) NULL,
	[F_USER4]      [nvarchar](100) NULL,
	[F_USER5]      [nvarchar](100) NULL,
	[F_USER6]      [nvarchar](100) NULL,
	[F_USER7]      [nvarchar](100) NULL,
	[F_USER8]      [nvarchar](100) NULL,
	[F_USER9]      [nvarchar](100) NULL,
	[F_USER10]     [nvarchar](100) NULL,
	[ISUSING]      [nvarchar](1) NULL,
	[ADDUSERCD]    [nvarchar](20) NULL,
	[ADDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]    [nvarchar](20) NULL,
	[UPDDATETIME]  [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]   [nvarchar](50) NULL,
 CONSTRAINT [PK_P003] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[CUSTCD] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '거래처', 'user', dbo, 'table',[P003]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P003], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P003], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P003], 'column', CUSTCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처그룹', 'user', dbo, 'table', [P003], 'column', CUSTGROUP
EXEC   sp_addextendedproperty 'MS_Description', '분류', 'user', dbo, 'table', [P003], 'column', CATEGORYCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처명', 'user', dbo, 'table', [P003], 'column', NAME
EXEC   sp_addextendedproperty 'MS_Description', '거래처명(약칭)', 'user', dbo, 'table', [P003], 'column', SNAME
EXEC   sp_addextendedproperty 'MS_Description', '거래처명(별칭)', 'user', dbo, 'table', [P003], 'column', ANAME
EXEC   sp_addextendedproperty 'MS_Description', 'CEO', 'user', dbo, 'table', [P003], 'column', CEO
EXEC   sp_addextendedproperty 'MS_Description', '업태', 'user', dbo, 'table', [P003], 'column', BIZKIND
EXEC   sp_addextendedproperty 'MS_Description', '업종', 'user', dbo, 'table', [P003], 'column', BIZTYPE
EXEC   sp_addextendedproperty 'MS_Description', '사업자번호', 'user', dbo, 'table', [P003], 'column', BIZNO
EXEC   sp_addextendedproperty 'MS_Description', '주소1', 'user', dbo, 'table', [P003], 'column', ADDR1
EXEC   sp_addextendedproperty 'MS_Description', '주소2', 'user', dbo, 'table', [P003], 'column', ADDR2
EXEC   sp_addextendedproperty 'MS_Description', '주소3', 'user', dbo, 'table', [P003], 'column', ADDR3
EXEC   sp_addextendedproperty 'MS_Description', '우편번호', 'user', dbo, 'table', [P003], 'column', POST
EXEC   sp_addextendedproperty 'MS_Description', '국가코드', 'user', dbo, 'table', [P003], 'column', COUNTRYCD
EXEC   sp_addextendedproperty 'MS_Description', 'PORTCD', 'user', dbo, 'table', [P003], 'column', PORTCD
EXEC   sp_addextendedproperty 'MS_Description', 'DISTRICTCD', 'user', dbo, 'table', [P003], 'column', DISTRICTCD
EXEC   sp_addextendedproperty 'MS_Description', '전화번호1', 'user', dbo, 'table', [P003], 'column', PHONE1
EXEC   sp_addextendedproperty 'MS_Description', '전화번호2', 'user', dbo, 'table', [P003], 'column', PHONE2
EXEC   sp_addextendedproperty 'MS_Description', '팩스1', 'user', dbo, 'table', [P003], 'column', FAX1
EXEC   sp_addextendedproperty 'MS_Description', '팩스2', 'user', dbo, 'table', [P003], 'column', FAX2
EXEC   sp_addextendedproperty 'MS_Description', '이메일', 'user', dbo, 'table', [P003], 'column', EMAIL
EXEC   sp_addextendedproperty 'MS_Description', 'URL', 'user', dbo, 'table', [P003], 'column', URL
EXEC   sp_addextendedproperty 'MS_Description', '담당자명', 'user', dbo, 'table', [P003], 'column', REFUSERNM
EXEC   sp_addextendedproperty 'MS_Description', '담당자연락처', 'user', dbo, 'table', [P003], 'column', REFUSERPHONE
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P003], 'column', ISSALES
EXEC   sp_addextendedproperty 'MS_Description', '공급처여부', 'user', dbo, 'table', [P003], 'column', ISSUPPLIER
EXEC   sp_addextendedproperty 'MS_Description', '납품처여부', 'user', dbo, 'table', [P003], 'column', ISSHIPPER
EXEC   sp_addextendedproperty 'MS_Description', '배송처여부', 'user', dbo, 'table', [P003], 'column', ISDELIVERY
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P003], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의1', 'user', dbo, 'table', [P003], 'column', F_USER1
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의2', 'user', dbo, 'table', [P003], 'column', F_USER2
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의3', 'user', dbo, 'table', [P003], 'column', F_USER3
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의4', 'user', dbo, 'table', [P003], 'column', F_USER4
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의5', 'user', dbo, 'table', [P003], 'column', F_USER5
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의6', 'user', dbo, 'table', [P003], 'column', F_USER6
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의7', 'user', dbo, 'table', [P003], 'column', F_USER7
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의8', 'user', dbo, 'table', [P003], 'column', F_USER8
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의9', 'user', dbo, 'table', [P003], 'column', F_USER9
EXEC   sp_addextendedproperty 'MS_Description', '사용자정의10', 'user', dbo, 'table', [P003], 'column', F_USER10
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P003], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P003], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P003], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P003], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P003], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P003], 'column', TERMINALCD
GO

-- 창고
CREATE TABLE [dbo].[P004](
	[COMPCD]      [nvarchar](20) NOT NULL,
	[WHCD]        [nvarchar](20) NOT NULL,
	[NAME]        [nvarchar](100) NOT NULL,
	[WHTYPE]      [nvarchar](10) NULL,
	[ADDR1]       [nvarchar](100) NULL,
	[ADDR2]       [nvarchar](100) NULL,
	[POST]        [nvarchar](10) NULL,
	[CUSTCD]      [nvarchar](20) NULL,
	[WHINLOCCD]   [nvarchar](20) NULL,
	[WHOUTLOCCD]  [nvarchar](20) NULL,
	[DPSLOCCD]    [nvarchar](20) NULL,
	[RETURNLOCCD] [nvarchar](20) NULL,
	[ASSYLOCCD]   [nvarchar](20) NULL,
	[CANCELLOCCD] [nvarchar](20) NULL,
	[REMARK]      [nvarchar](255) NULL,
	[ISUSING]     [nvarchar](1) NULL,
	[ADDUSERCD]   [nvarchar](20) NULL,
	[ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]   [nvarchar](20) NULL,
	[UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P004] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[WHCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '창고', 'user', dbo, 'table',[P004]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P004], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P004], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '창고명', 'user', dbo, 'table', [P004], 'column', NAME
EXEC   sp_addextendedproperty 'MS_Description', '창고구분', 'user', dbo, 'table', [P004], 'column', WHTYPE
EXEC   sp_addextendedproperty 'MS_Description', '주소1', 'user', dbo, 'table', [P004], 'column', ADDR1
EXEC   sp_addextendedproperty 'MS_Description', '주소2', 'user', dbo, 'table', [P004], 'column', ADDR2
EXEC   sp_addextendedproperty 'MS_Description', '우편번호', 'user', dbo, 'table', [P004], 'column', POST
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드(지정)', 'user', dbo, 'table', [P004], 'column', CUSTCD
EXEC   sp_addextendedproperty 'MS_Description', '입고대기로케이션', 'user', dbo, 'table', [P004], 'column', WHINLOCCD
EXEC   sp_addextendedproperty 'MS_Description', 'CART출고대기로케이션', 'user', dbo, 'table', [P004], 'column', WHOUTLOCCD
EXEC   sp_addextendedproperty 'MS_Description', 'DPS출고대기로케이션', 'user', dbo, 'table', [P004], 'column', DPSLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '반품로케이션', 'user', dbo, 'table', [P004], 'column', RETURNLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '가공로케이션', 'user', dbo, 'table', [P004], 'column', ASSYLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '취소로케이션', 'user', dbo, 'table', [P004], 'column', CANCELLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P004], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P004], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P004], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P004], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P004], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P004], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P004], 'column', TERMINALCD
GO


-- 로케이션
CREATE TABLE [dbo].[P005](
	[COMPCD]         [nvarchar](20) NOT NULL,
	[WHCD]           [nvarchar](20) NOT NULL,
	[LOCCD]          [nvarchar](20) NOT NULL,
	[LOCNAME]        [nvarchar](100) NOT NULL,
	[LOCGROUP]       [nvarchar](5) NULL,
	[ISVIRTUAL]      [nvarchar](1) NULL DEFAULT ('N'),
	[LOCTYPE]        [nvarchar](5) NULL,
	[SLOTTYPE]       [nvarchar](5) NULL,
	[PICKTYPE]       [nvarchar](5) NULL,
	[ALLOCATETYPE]   [nvarchar](5) NULL,
	[NOTALLOCFLG]    [nvarchar](1) NULL DEFAULT('N'),
	[WHINSEQ]        [decimal](10,0) NULL,
	[WHOUTSEQ]       [decimal](10,0) NULL,
	[BUIL]           [nvarchar](20) NULL,
	[FLOOR]          [nvarchar](20) NULL,
	[ZONE]           [nvarchar](20) NULL,
	[LINE]           [nvarchar](20) NULL,
	[RANGE]          [nvarchar](20) NULL,
	[STEP]           [nvarchar](20) NULL,
	[LANE]           [nvarchar](20) NULL,
	[LENGTH]         [decimal](13, 3) NULL,
	[WIDTH]          [decimal](13, 3) NULL,
	[HEIGHT]         [decimal](13, 3) NULL,
	[WEIGHTCAPACITY] [decimal](13, 3) NULL,
	[CAPACITY]       [decimal](13, 3) NULL,
	[CUSTCD]         [nvarchar](20) NULL,
	[ISUSING]        [nvarchar](1) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
 CONSTRAINT [PK_P005] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[WHCD] ASC,
	[LOCCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '로케이션', 'user', dbo, 'table',[P005]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P005], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P005], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '로케이션코드', 'user', dbo, 'table', [P005], 'column', LOCCD
EXEC   sp_addextendedproperty 'MS_Description', '로케이션명', 'user', dbo, 'table', [P005], 'column', LOCNAME
EXEC   sp_addextendedproperty 'MS_Description', '로케이션그룹', 'user', dbo, 'table', [P005], 'column', LOCGROUP
EXEC   sp_addextendedproperty 'MS_Description', '가상여부', 'user', dbo, 'table', [P005], 'column', ISVIRTUAL
EXEC   sp_addextendedproperty 'MS_Description', '로케이션타입', 'user', dbo, 'table', [P005], 'column', LOCTYPE
EXEC   sp_addextendedproperty 'MS_Description', '입고유형', 'user', dbo, 'table', [P005], 'column', SLOTTYPE
EXEC   sp_addextendedproperty 'MS_Description', '피킹유형', 'user', dbo, 'table', [P005], 'column', PICKTYPE
EXEC   sp_addextendedproperty 'MS_Description', '할당유형', 'user', dbo, 'table', [P005], 'column', ALLOCATETYPE
EXEC   sp_addextendedproperty 'MS_Description', '할당금지플래그', 'user', dbo, 'table', [P005], 'column', NOTALLOCFLG
EXEC   sp_addextendedproperty 'MS_Description', '입고순번', 'user', dbo, 'table', [P005], 'column', WHINSEQ
EXEC   sp_addextendedproperty 'MS_Description', '출고순번', 'user', dbo, 'table', [P005], 'column', WHOUTSEQ
EXEC   sp_addextendedproperty 'MS_Description', '동(건물)', 'user', dbo, 'table', [P005], 'column', BUIL
EXEC   sp_addextendedproperty 'MS_Description', '플로어', 'user', dbo, 'table', [P005], 'column', FLOOR
EXEC   sp_addextendedproperty 'MS_Description', '존', 'user', dbo, 'table', [P005], 'column', ZONE
EXEC   sp_addextendedproperty 'MS_Description', '열', 'user', dbo, 'table', [P005], 'column', LINE
EXEC   sp_addextendedproperty 'MS_Description', '연', 'user', dbo, 'table', [P005], 'column', RANGE
EXEC   sp_addextendedproperty 'MS_Description', '단', 'user', dbo, 'table', [P005], 'column', STEP
EXEC   sp_addextendedproperty 'MS_Description', '레인', 'user', dbo, 'table', [P005], 'column', LANE
EXEC   sp_addextendedproperty 'MS_Description', '깊이', 'user', dbo, 'table', [P005], 'column', LENGTH
EXEC   sp_addextendedproperty 'MS_Description', '폭', 'user', dbo, 'table', [P005], 'column', WIDTH
EXEC   sp_addextendedproperty 'MS_Description', '높이', 'user', dbo, 'table', [P005], 'column', HEIGHT
EXEC   sp_addextendedproperty 'MS_Description', '가용중량', 'user', dbo, 'table', [P005], 'column', WEIGHTCAPACITY
EXEC   sp_addextendedproperty 'MS_Description', '가용수량', 'user', dbo, 'table', [P005], 'column', CAPACITY
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드(지정)', 'user', dbo, 'table', [P005], 'column', CUSTCD
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P005], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P005], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P005], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P005], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P005], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P005], 'column', TERMINALCD
GO

-- 품목 (재고에 FK 걸려있음)
CREATE TABLE [dbo].[P006](
	[COMPCD]         [nvarchar](20) NOT NULL,
	[ORGCD]          [nvarchar](20) NOT NULL,
	[ITEMCD]         [nvarchar](20) NOT NULL,
	[NAME]           [nvarchar](100) NOT NULL,
	[SNAME]          [nvarchar](100) NULL,
	[FNAME]          [nvarchar](100) NULL,
	[ITEMTYPE]       [nvarchar](10) NULL,
	[UNITCD]         [nvarchar](10) NULL,
	[ITEMSIZE]       [nvarchar](20) NULL,
	[CATEGORYCD]     [nvarchar](20) NULL,
	[SETYN]          [nvarchar](1) NULL DEFAULT ('N'),
	[UNITTYPE]       [nvarchar](10) NULL,
	[INBOXQTY]       [decimal](10, 0) NULL,
	[INPLTQTY]       [decimal](10, 0) NULL,
	[LENGTH]         [decimal](13, 3) NULL,
	[WIDTH]          [decimal](13, 3) NULL,
	[HEIGHT]         [decimal](13, 3) NULL,
	[CAPACITY]       [decimal](13, 3) NULL,
	[MANUFACTURE]    [nvarchar](20) NULL,
	[MANUCOUNTRY]    [nvarchar](20) NULL,
	[CUSTCD]         [nvarchar](20) NULL,
	[F_USER01]       [nvarchar](20) NULL,
	[F_USER02]       [nvarchar](20) NULL,
	[F_USER03]       [nvarchar](20) NULL,
	[F_USER04]       [nvarchar](20) NULL,
	[F_USER05]       [nvarchar](20) NULL,
	[F_USER11]       [nvarchar](50) NULL,
	[F_USER12]       [nvarchar](50) NULL,
	[F_USER13]       [nvarchar](50) NULL,
	[F_USER14]       [nvarchar](50) NULL,
	[F_USER15]       [nvarchar](50) NULL,
	[IMG1_PATH]      [nvarchar](200) NULL,
	[IMG1_REAL_PATH] [nvarchar](200) NULL,
	[REMARK]         [nvarchar](200) NULL,
	[ISUSING]        [nvarchar](1) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
	-- 추가 컬럼
	[SERIAL_SCAN_YN] [nvarchar](1) null DEFAULT ('N'),
	[RACK_NO]        [nvarchar](30) null,
	[EA_MAX]         [decimal](13, 3) NULL,
	[STKTMP]         [NVARCHAR](10) NULL,
	[SUPRATE]        INT NULL DEFAULT(100),
	[SUPUNIT]        [nvarchar](10) NULL,
	[EXPMONTH]       INT NULL,
 CONSTRAINT [PK_P006] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목', 'user', dbo, 'table',[P006]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P006], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P006], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P006], 'column', ITEMCD
EXEC   sp_addextendedproperty 'MS_Description', '품목명', 'user', dbo, 'table', [P006], 'column', NAME
EXEC   sp_addextendedproperty 'MS_Description', '품목명(약칭)', 'user', dbo, 'table', [P006], 'column', SNAME
EXEC   sp_addextendedproperty 'MS_Description', '정식명칭', 'user', dbo, 'table', [P006], 'column', FNAME
EXEC   sp_addextendedproperty 'MS_Description', '품목유형', 'user', dbo, 'table', [P006], 'column', ITEMTYPE
EXEC   sp_addextendedproperty 'MS_Description', '단위', 'user', dbo, 'table', [P006], 'column', [UNITCD]
EXEC   sp_addextendedproperty 'MS_Description', '규격', 'user', dbo, 'table', [P006], 'column', [ITEMSIZE]
EXEC   sp_addextendedproperty 'MS_Description', '분류', 'user', dbo, 'table', [P006], 'column', CATEGORYCD
EXEC   sp_addextendedproperty 'MS_Description', '세트여부', 'user', dbo, 'table', [P006], 'column', SETYN
EXEC   sp_addextendedproperty 'MS_Description', '관리단위', 'user', dbo, 'table', [P006], 'column', UNITTYPE
EXEC   sp_addextendedproperty 'MS_Description', '박스입수량', 'user', dbo, 'table', [P006], 'column', INBOXQTY
EXEC   sp_addextendedproperty 'MS_Description', '팔레트입수량', 'user', dbo, 'table', [P006], 'column', INPLTQTY
EXEC   sp_addextendedproperty 'MS_Description', '깊이', 'user', dbo, 'table', [P006], 'column', LENGTH
EXEC   sp_addextendedproperty 'MS_Description', '폭', 'user', dbo, 'table', [P006], 'column', WIDTH
EXEC   sp_addextendedproperty 'MS_Description', '높이', 'user', dbo, 'table', [P006], 'column', HEIGHT
EXEC   sp_addextendedproperty 'MS_Description', '용량', 'user', dbo, 'table', [P006], 'column', CAPACITY
EXEC   sp_addextendedproperty 'MS_Description', '제조사', 'user', dbo, 'table', [P006], 'column', MANUFACTURE
EXEC   sp_addextendedproperty 'MS_Description', '제조국', 'user', dbo, 'table', [P006], 'column', MANUCOUNTRY
EXEC   sp_addextendedproperty 'MS_Description', '거래처(지정)', 'user', dbo, 'table', [P006], 'column', CUSTCD
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(코드)', 'user', dbo, 'table', [P006], 'column', F_USER01
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(코드)', 'user', dbo, 'table', [P006], 'column', F_USER02
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(코드)', 'user', dbo, 'table', [P006], 'column', F_USER03
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(코드)', 'user', dbo, 'table', [P006], 'column', F_USER04
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(코드)', 'user', dbo, 'table', [P006], 'column', F_USER05
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(TEXT)', 'user', dbo, 'table', [P006], 'column', F_USER11
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(TEXT)', 'user', dbo, 'table', [P006], 'column', F_USER12
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(TEXT)', 'user', dbo, 'table', [P006], 'column', F_USER13
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(TEXT)', 'user', dbo, 'table', [P006], 'column', F_USER14
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정(TEXT)', 'user', dbo, 'table', [P006], 'column', F_USER15
EXEC   sp_addextendedproperty 'MS_Description', '이미지경로', 'user', dbo, 'table', [P006], 'column', IMG1_PATH
EXEC   sp_addextendedproperty 'MS_Description', '실경로', 'user', dbo, 'table', [P006], 'column', IMG1_REAL_PATH
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P006], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P006], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P006], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P006], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P006], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P006], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P006], 'column', TERMINALCD
-- 추가컬럼
EXEC   sp_addextendedproperty 'MS_Description', '시리얼관리여부', 'user', dbo, 'table', [P006], 'column', SERIAL_SCAN_YN
EXEC   sp_addextendedproperty 'MS_Description', '피킹렉 번호(대기존의 위치)', 'user', dbo, 'table', [P006], 'column', RACK_NO
EXEC   sp_addextendedproperty 'MS_Description', '최대길이(가로,세로,높이중)', 'user', dbo, 'table', [P006], 'column', EA_MAX
EXEC   sp_addextendedproperty 'MS_Description', '보관온도(상온/냉장/냉동)', 'user', dbo, 'table', [P006], 'column', STKTMP
EXEC   sp_addextendedproperty 'MS_Description', '보충배율(기본값-100, 100이하로 넣을수 없음)', 'user', dbo, 'table', [P006], 'column', SUPRATE
EXEC   sp_addextendedproperty 'MS_Description', '보충단위(PLT/BOX/EA 공통코드 -SUPUNIT)', 'user', dbo, 'table', [P006], 'column', SUPUNIT
EXEC   sp_addextendedproperty 'MS_Description', '유통기한(개월수)', 'user', dbo, 'table', [P006], 'column', EXPMONTH
GO

-- 품목로트
CREATE TABLE [dbo].[P007](
	[LOTKEY]         [nvarchar](20) NOT NULL,
	[COMPCD]         [nvarchar](20) NOT NULL,
	[ORGCD]          [nvarchar](20) NOT NULL,
	[ITEMCD]         [nvarchar](20) NOT NULL,
	[LOT1]           [nvarchar](50) NULL,
	[LOT2]           [nvarchar](50) NULL,
	[LOT3]           [nvarchar](50) NULL,
	[LOT4]           [nvarchar](20) NULL,
	[LOT5]           [nvarchar](20) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
 CONSTRAINT [PK_P007] PRIMARY KEY CLUSTERED
(
	[LOTKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P007_01] ON [dbo].[P007]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목', 'user', dbo, 'table',[P007]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P007], 'column', LOTKEY
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P007], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P007], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P007], 'column', ITEMCD
EXEC   sp_addextendedproperty 'MS_Description', '로트속성(문자)1', 'user', dbo, 'table', [P007], 'column', LOT1
EXEC   sp_addextendedproperty 'MS_Description', '로트속성(문자)2', 'user', dbo, 'table', [P007], 'column', LOT2
EXEC   sp_addextendedproperty 'MS_Description', '로트속성(문자)3', 'user', dbo, 'table', [P007], 'column', LOT3
EXEC   sp_addextendedproperty 'MS_Description', '로트속성(코드)4', 'user', dbo, 'table', [P007], 'column', LOT4
EXEC   sp_addextendedproperty 'MS_Description', '로트속성(코드)5', 'user', dbo, 'table', [P007], 'column', LOT5
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P007], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P007], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P007], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P007], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P007], 'column', TERMINALCD
GO

-- 품목별 로케이션
CREATE TABLE [dbo].[P009](
	[COMPCD]         [nvarchar](20) NOT NULL,
	[ORGCD]          [nvarchar](20) NOT NULL,
	[WHCD]           [nvarchar](20) NOT NULL,
	[ITEMCD]         [nvarchar](20) NOT NULL,
	[SLOTLOCCD]      [nvarchar](20) NULL,
	[PICKLOCCD]      [nvarchar](20) NULL,
	[CUSTCD]         [nvarchar](20) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
 CONSTRAINT [PK_P009] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목별 로케이션', 'user', dbo, 'table',[P009]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P009], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P009], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P009], 'column', [WHCD]
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P009], 'column', [ITEMCD]
EXEC   sp_addextendedproperty 'MS_Description', '적재로케이션', 'user', dbo, 'table', [P009], 'column', [SLOTLOCCD]
EXEC   sp_addextendedproperty 'MS_Description', '피킹로케이션', 'user', dbo, 'table', [P009], 'column', [PICKLOCCD]
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P009], 'column', [CUSTCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P009], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P009], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P009], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P009], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P009], 'column', TERMINALCD
GO


-- BOM
CREATE TABLE [dbo].[P010](
	[COMPCD]         [nvarchar](20) NOT NULL,
	[ORGCD]          [nvarchar](20) NOT NULL,
	[PITEMCD]        [nvarchar](20) NOT NULL,
	[ITEMCD]         [nvarchar](20) NOT NULL,
	[QTY]            [decimal](17,6) NULL,
    [REMARK]         [nvarchar](200) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
 CONSTRAINT [PK_P010] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[PITEMCD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', 'BOM', 'user', dbo, 'table',[P010]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P010], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P010], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '품목코드(완성)', 'user', dbo, 'table', [P010], 'column', [PITEMCD]
EXEC   sp_addextendedproperty 'MS_Description', '품목코드(부품)', 'user', dbo, 'table', [P010], 'column', [ITEMCD]
EXEC   sp_addextendedproperty 'MS_Description', '수량', 'user', dbo, 'table', [P010], 'column', [QTY]
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P010], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P010], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P010], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P010], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P010], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P010], 'column', TERMINALCD
GO

-- 품목판매가
CREATE TABLE [dbo].[P011](
	[COMPCD]         [nvarchar](20) NOT NULL,
	[ORGCD]			 [nvarchar](20) NOT NULL,
	[CUSTCD]         [nvarchar](20) NOT NULL,
	[ITEMCD]         [nvarchar](20) NOT NULL,
	[STARTDT]        [nvarchar](8) NOT NULL,
	[ENDDT]          [nvarchar](8) NOT NULL,
	[UNITPRICE]      [decimal](17,4) NULL,
    [REMARK]         [nvarchar](200) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
 CONSTRAINT [PK_P011] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD]  ASC,
	[CUSTCD] ASC,
	[ITEMCD] ASC,
	[STARTDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목판매가', 'user', dbo, 'table',[P011]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P011], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P011], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P011], 'column', [CUSTCD]
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P011], 'column', [ITEMCD]
EXEC   sp_addextendedproperty 'MS_Description', '시작일자', 'user', dbo, 'table', [P011], 'column', [STARTDT]
EXEC   sp_addextendedproperty 'MS_Description', '종료일자', 'user', dbo, 'table', [P011], 'column', [ENDDT]
EXEC   sp_addextendedproperty 'MS_Description', '판매단가', 'user', dbo, 'table', [P011], 'column', [UNITPRICE]
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P011], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P011], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P011], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P011], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P011], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P011], 'column', TERMINALCD
GO


-- 품목매입가(공급가)
CREATE TABLE [dbo].[P012](
	[COMPCD]         [nvarchar](20) NOT NULL,
	[ORGCD]			 [nvarchar](20) NOT NULL,
	[CUSTCD]         [nvarchar](20) NOT NULL,
	[ITEMCD]         [nvarchar](20) NOT NULL,
	[STARTDT]        [nvarchar](8) NOT NULL,
	[ENDDT]          [nvarchar](8) NOT NULL,
	[UNITCOST]       [decimal](17,4) NULL,
    [REMARK]         [nvarchar](200) NULL,
	[ADDUSERCD]      [nvarchar](20) NULL,
	[ADDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]      [nvarchar](20) NULL,
	[UPDDATETIME]    [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]     [nvarchar](50) NULL,
 CONSTRAINT [PK_P012] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD]  ASC,
	[CUSTCD] ASC,
	[ITEMCD] ASC,
	[STARTDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목매입가', 'user', dbo, 'table',[P012]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P012], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P012], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P012], 'column', [CUSTCD]
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P012], 'column', [ITEMCD]
EXEC   sp_addextendedproperty 'MS_Description', '시작일자', 'user', dbo, 'table', [P012], 'column', [STARTDT]
EXEC   sp_addextendedproperty 'MS_Description', '종료일자', 'user', dbo, 'table', [P012], 'column', [ENDDT]
EXEC   sp_addextendedproperty 'MS_Description', '단가', 'user', dbo, 'table', [P012], 'column', [UNITCOST]
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P012], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P012], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P012], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P012], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P012], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P012], 'column', TERMINALCD
GO


-- 부서
CREATE TABLE [dbo].[P016](
	[COMPCD]                [nvarchar](20) NOT NULL,
	[ORGCD]                 [nvarchar](20) NOT NULL,
	[DEPTCD]                [nvarchar](20) NOT NULL,
	[PDEPTCD]               [nvarchar](20) NOT NULL,
	[NAME]                  [nvarchar](100) NOT NULL,
	[LVL]                   [decimal](10,0) NULL,
	[SORTNO]                [decimal](10,0) NULL,
	[ISUSING]               [nvarchar](1) NULL DEFAULT ('Y'),
	[REMARK] 				[nvarchar](200) NULL,
	[ADDUSERCD]             [nvarchar](20) NULL,
	[ADDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]             [nvarchar](20) NULL,
	[UPDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]            [nvarchar](50) NULL,
 CONSTRAINT [PK_P016] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[ORGCD]  ASC,
	[DEPTCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '부서', 'user', dbo, 'table',[P016]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P016], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P016], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '부서코드', 'user', dbo, 'table', [P016], 'column', DEPTCD
EXEC   sp_addextendedproperty 'MS_Description', '상위부서코드', 'user', dbo, 'table', [P016], 'column', PDEPTCD
EXEC   sp_addextendedproperty 'MS_Description', '부서명', 'user', dbo, 'table', [P016], 'column', NAME
EXEC   sp_addextendedproperty 'MS_Description', '레벨(0,1,2,3...)', 'user', dbo, 'table', [P016], 'column', LVL
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [P016], 'column', SORTNO
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P016], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P016], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P016], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P016], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P016], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P016], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P016], 'column', TERMINALCD
GO

-- 품목분류(대중소)
CREATE TABLE [dbo].[P017](
	[COMPCD]                [nvarchar](20) NOT NULL,
	[CATEGORYCD]            [nvarchar](20) NOT NULL,
	[NAME]                  [nvarchar](20) NOT NULL,
	[PCATEGORYCD]           [nvarchar](20) NOT NULL,
	[LVL]                   [decimal](10,0) NULL,
	[SORTNO]                   [decimal](10,0) NULL,
	[ISUSING]               [nvarchar](1) NULL DEFAULT ('Y'),
	[REMARK] 				[nvarchar](200) NULL,
	[ADDUSERCD]             [nvarchar](20) NULL,
	[ADDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]             [nvarchar](20) NULL,
	[UPDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]            [nvarchar](50) NULL,
 CONSTRAINT [PK_P017] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[CATEGORYCD]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '품목분류(대중소)', 'user', dbo, 'table',[P017]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P017], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '분류코드', 'user', dbo, 'table', [P017], 'column', [CATEGORYCD]
EXEC   sp_addextendedproperty 'MS_Description', '분류명', 'user', dbo, 'table', [P017], 'column', [NAME]
EXEC   sp_addextendedproperty 'MS_Description', '상위분류코드', 'user', dbo, 'table', [P017], 'column', [PCATEGORYCD]
EXEC   sp_addextendedproperty 'MS_Description', '레벨(1:대,2:중,3:소)', 'user', dbo, 'table', [P017], 'column', LVL
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [P017], 'column', SORTNO
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P017], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P017], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P017], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P017], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P017], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P017], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P017], 'column', TERMINALCD
GO


-- 거래처분류(대중소)
CREATE TABLE [dbo].[P018](
	[COMPCD]                [nvarchar](20) NOT NULL,
	[CATEGORYCD]            [nvarchar](20) NOT NULL,
	[NAME]                  [nvarchar](20) NOT NULL,
	[PCATEGORYCD]           [nvarchar](20) NOT NULL,
	[LVL]                   [decimal](10,0) NULL,
	[SORTNO]                [decimal](10,0) NULL,
	[ISUSING]               [nvarchar](1) NULL DEFAULT ('Y'),
	[REMARK] 				[nvarchar](200) NULL,
	[ADDUSERCD]             [nvarchar](20) NULL,
	[ADDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]             [nvarchar](20) NULL,
	[UPDDATETIME]           [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]            [nvarchar](50) NULL,
 CONSTRAINT [PK_P018] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC,
	[CATEGORYCD]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '거래처분류(대중소)', 'user', dbo, 'table',[P018]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P018], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '분류코드', 'user', dbo, 'table', [P018], 'column', [CATEGORYCD]
EXEC   sp_addextendedproperty 'MS_Description', '분류명', 'user', dbo, 'table', [P018], 'column', [NAME]
EXEC   sp_addextendedproperty 'MS_Description', '상위분류코드', 'user', dbo, 'table', [P018], 'column', [PCATEGORYCD]
EXEC   sp_addextendedproperty 'MS_Description', '레벨(1:대,2:중,3:소)', 'user', dbo, 'table', [P018], 'column', LVL
EXEC   sp_addextendedproperty 'MS_Description', '정렬순서', 'user', dbo, 'table', [P018], 'column', SORTNO
EXEC   sp_addextendedproperty 'MS_Description', '사용여부', 'user', dbo, 'table', [P018], 'column', ISUSING
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P018], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P018], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P018], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P018], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P018], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P018], 'column', TERMINALCD
GO

-- 회사별 품목지정 설정
CREATE TABLE [DBO].[P020](
	[COMPCD]           [NVARCHAR](20) NOT NULL,
	[LOT1_YN]          [NVARCHAR](1) NULL DEFAULT ('N'),
	[LOT1_LABEL]       [NVARCHAR](50) NULL,
	[LOT1_TYPE]        [NVARCHAR](20) NULL,
	[LOT2_YN]          [NVARCHAR](1) NULL DEFAULT ('N'),
	[LOT2_LABEL]       [NVARCHAR](50) NULL,
	[LOT2_TYPE]        [NVARCHAR](20) NULL,
	[LOT3_YN]          [NVARCHAR](1) NULL DEFAULT ('N'),
	[LOT3_LABEL]       [NVARCHAR](50) NULL,
	[LOT3_TYPE]        [NVARCHAR](20) NULL,
	[LOT4_YN]          [NVARCHAR](1) NULL DEFAULT ('N'),
	[LOT4_LABEL]       [NVARCHAR](50) NULL,
	[LOT5_YN]          [NVARCHAR](1) NULL DEFAULT ('N'),
	[LOT5_LABEL]       [NVARCHAR](50) NULL,
	[F_USER01_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER01_LABEL]   [NVARCHAR](50) NULL,
	[F_USER02_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER02_LABEL]   [NVARCHAR](50) NULL,
	[F_USER03_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER03_LABEL]   [NVARCHAR](50) NULL,
	[F_USER04_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER04_LABEL]   [NVARCHAR](50) NULL,
	[F_USER05_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER05_LABEL]   [NVARCHAR](50) NULL,
	[F_USER11_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER11_LABEL]   [NVARCHAR](50) NULL,
	[F_USER12_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER12_LABEL]   [NVARCHAR](50) NULL,
	[F_USER13_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER13_LABEL]   [NVARCHAR](50) NULL,
	[F_USER14_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER14_LABEL]   [NVARCHAR](50) NULL,
	[F_USER15_YN]      [NVARCHAR](1) NULL DEFAULT ('N'),
	[F_USER15_LABEL]   [NVARCHAR](50) NULL,
	[ADDUSERCD]        [NVARCHAR](20) NULL,
	[ADDDATETIME]      [DATETIME] NULL DEFAULT (GETDATE()),
	[UPDUSERCD]        [NVARCHAR](20) NULL,
	[UPDDATETIME]      [DATETIME] NULL DEFAULT (GETDATE()),
	[TERMINALCD]       [NVARCHAR](50) NULL,
 CONSTRAINT [PK_P020] PRIMARY KEY CLUSTERED
(
	[COMPCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '회사별 품목지정 설정', 'user', dbo, 'table',[P020]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P020], 'column', [COMPCD]
EXEC   sp_addextendedproperty 'MS_Description', '로트1 사용여부', 'user', dbo, 'table', [P020], 'column', [LOT1_YN]
EXEC   sp_addextendedproperty 'MS_Description', '로트1 라벨', 'user', dbo, 'table', [P020], 'column', [LOT1_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '로트1 타입(TXT,DATE,NUMBER)', 'user', dbo, 'table', [P020], 'column', [LOT1_TYPE]
EXEC   sp_addextendedproperty 'MS_Description', '로트2 사용여부', 'user', dbo, 'table', [P020], 'column', [LOT2_YN]
EXEC   sp_addextendedproperty 'MS_Description', '로트2 라벨', 'user', dbo, 'table', [P020], 'column', [LOT2_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '로트2 타입(TXT,DATE,NUMBER)', 'user', dbo, 'table', [P020], 'column', [LOT2_TYPE]
EXEC   sp_addextendedproperty 'MS_Description', '로트3 사용여부', 'user', dbo, 'table', [P020], 'column', [LOT3_YN]
EXEC   sp_addextendedproperty 'MS_Description', '로트3 라벨', 'user', dbo, 'table', [P020], 'column', [LOT3_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '로트3 타입(TXT,DATE,NUMBER)', 'user', dbo, 'table', [P020], 'column', [LOT3_TYPE]
EXEC   sp_addextendedproperty 'MS_Description', '로트4 사용여부', 'user', dbo, 'table', [P020], 'column', [LOT4_YN]
EXEC   sp_addextendedproperty 'MS_Description', '로트4 라벨', 'user', dbo, 'table', [P020], 'column', [LOT4_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '로트5 사용여부', 'user', dbo, 'table', [P020], 'column', [LOT5_YN]
EXEC   sp_addextendedproperty 'MS_Description', '로트5 라벨', 'user', dbo, 'table', [P020], 'column', [LOT5_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정1 사용여부',   'user', dbo, 'table', [P020], 'column', [F_USER01_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정1 라벨',       'user', dbo, 'table', [P020], 'column', [F_USER01_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정2 사용여부',   'user', dbo, 'table', [P020], 'column', [F_USER02_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정2 라벨',       'user', dbo, 'table', [P020], 'column', [F_USER02_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정3 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER03_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정3 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER03_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정4 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER04_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정4 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER04_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정5 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER05_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정5 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER05_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정11 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER11_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정11 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER11_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정12 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER12_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정12 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER12_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정13 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER13_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정13 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER13_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정14 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER14_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정14 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER14_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정15 사용여부', 'user', dbo, 'table', [P020], 'column', [F_USER15_YN]
EXEC   sp_addextendedproperty 'MS_Description', '사용자지정15 라벨', 'user', dbo, 'table', [P020], 'column', [F_USER15_LABEL]
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P020], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P020], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P020], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P020], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P020], 'column', TERMINALCD
GO