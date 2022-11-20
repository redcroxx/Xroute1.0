/*애터미 입고 인터페이스 테이블------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[INTF_ORDERSTOCK](
	[COMPCD] 			[nvarchar](20) NOT NULL,
	[ORGCD] 			[nvarchar](20) NOT NULL,
	[IDX] 				[decimal](18,0) IDENTITY(1,1) NOT NULL,
	[ORDERNO] 			[nvarchar](20) NOT NULL,
	[ORDERSUBNO] 		[nvarchar](20) NOT NULL,
	[ORDERSEQ] 			[decimal](18,0) NOT NULL,
	[ORDERDATE] 		[nvarchar](10) NULL,
	[TYPE] 				[nvarchar](3) NULL,
	[MATERIALCODE] 		[nvarchar](50) NULL,
	[MATERIALNAME] 		[nvarchar](50) NULL,
	[PLANTCODE] 		[nvarchar](50) NULL,
	[PLANTNAME] 		[nvarchar](50) NULL,
	[STORAGECODE] 		[nvarchar](50) NULL,
	[STORAGENAME] 		[nvarchar](50) NULL,
	[STOCKCOUNT] 		[decimal](18,0) NULL,
	[STOCKDATE] 		[nvarchar](10) NULL,
	[COMPANYCODE] 		[nvarchar](50) NULL,
	[COMPANYNAME] 		[nvarchar](50) NULL,
	[MEINS] 			[nvarchar](50) NULL, 
	[ORDERPRICE] 		[decimal](18,0) NULL,
	[TOTALPRICE] 		[decimal](18,0) NULL,
	[STATUS] 			[nvarchar](3) NULL,
	[OPERATEDATE] 		[nvarchar](10) NULL,
	[OPERATETIME] 		[nvarchar](10) NULL,
	[OPERATEID] 		[nvarchar](50) NULL,
	[LOGINO] 			[nvarchar](20) NULL,
	[LOGISUBNO] 		[nvarchar](20) NULL,
	[TYPETEXT] 			[nvarchar](50) NULL,
	[RETURNNO] 			[nvarchar](20) NULL,
	[RETURNSUBNO] 		[nvarchar](20) NULL,
	[RETURNMONTH] 		[nvarchar](7) NULL,
	[BUYNUM] 			[nvarchar](50) NULL,
	[BUYSEQ] 			[nvarchar](50) NULL,
	[QTY] 				[decimal](18,0) NULL,
	[RMK] 				[nvarchar](50) NULL,
	[VALID_DATE] 		[nvarchar](50) NULL,
	[LOT] 				[nvarchar](50) NULL,
	[INTF_YN] 			[nvarchar](1) NULL,
	[INTF_DATE] 		[datetime] NULL,
	[TRS_DATE] 			[datetime] NULL DEFAULT (getdate()),
	[INTF_RETURN_YN] 	[nvarchar](1) NULL,
	[INTF_RETURN_DATE] 	[datetime] NULL,
	[IN_SNO] 			[decimal](18,0) NULL,
	[LOGIFLAG] 			[nvarchar](1) NULL,
	[LOGISEQ] 			[decimal](10,0) NULL,
	[LOGICOUNT] 		[decimal](18,0) NULL,
	[OUT_SNO] 			[decimal](18,0) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL
 CONSTRAINT [PK_INTF_ORDERSTOCK] PRIMARY KEY CLUSTERED 
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[ORDERNO] ASC,
	[ORDERSUBNO] ASC,
	[ORDERSEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/*
	1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '애터미구매인터페이스', 'user', dbo, 'table',[INTF_ORDERSTOCK]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [COMPCD]							
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ORGCD]											
EXEC   sp_addextendedproperty 'MS_Description', '인터페이스순번', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [IDX] 						
EXEC   sp_addextendedproperty 'MS_Description', '구매번호', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ORDERNO] 					
EXEC   sp_addextendedproperty 'MS_Description', '상세번호', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ORDERSUBNO] 				
EXEC   sp_addextendedproperty 'MS_Description', 'SEQ', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ORDERSEQ] 					
EXEC   sp_addextendedproperty 'MS_Description', '구매일자', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ORDERDATE] 				
EXEC   sp_addextendedproperty 'MS_Description', '타입명(CODE_SLT:ATOMY_INTERFACE)', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [TYPE] 						
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [MATERIALCODE] 				
EXEC   sp_addextendedproperty 'MS_Description', '품목명', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [MATERIALNAME] 				
EXEC   sp_addextendedproperty 'MS_Description', '플랜트코드', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [PLANTCODE] 				
EXEC   sp_addextendedproperty 'MS_Description', '플랜트명', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [PLANTNAME] 				
EXEC   sp_addextendedproperty 'MS_Description', '스토리지코드', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [STORAGECODE] 				
EXEC   sp_addextendedproperty 'MS_Description', '스토리지명', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [STORAGENAME] 				
EXEC   sp_addextendedproperty 'MS_Description', '예정수량', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [STOCKCOUNT] 				
EXEC   sp_addextendedproperty 'MS_Description', '입고예정일자', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [STOCKDATE] 				
EXEC   sp_addextendedproperty 'MS_Description', '공급처코드', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [COMPANYCODE] 				
EXEC   sp_addextendedproperty 'MS_Description', '공급처명', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [COMPANYNAME] 				
EXEC   sp_addextendedproperty 'MS_Description', '품목단위(EA..)', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [MEINS] 					
EXEC   sp_addextendedproperty 'MS_Description', '단가', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ORDERPRICE] 				
EXEC   sp_addextendedproperty 'MS_Description', '총금액', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [TOTALPRICE] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [STATUS] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [OPERATEDATE] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [OPERATETIME] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [OPERATEID] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [LOGINO] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [LOGISUBNO] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [TYPETEXT] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [RETURNNO] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [RETURNSUBNO] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [RETURNMONTH] 				
--EXEC   sp_addextendedproperty 'MS_Description', '주문서번호', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [BUYNUM] 					
EXEC   sp_addextendedproperty 'MS_Description', '주문서번호 순번', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [BUYSEQ] 					
EXEC   sp_addextendedproperty 'MS_Description', '수량', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [QTY] 						
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [RMK] 						
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [VALID_DATE] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [LOT] 						
EXEC   sp_addextendedproperty 'MS_Description', '반품Y/N', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [INTF_YN] 					
EXEC   sp_addextendedproperty 'MS_Description', '반품일자', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [INTF_DATE] 				
EXEC   sp_addextendedproperty 'MS_Description', '매칭번호(입고)', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [TRS_DATE] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [INTF_RETURN_YN] 			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [INTF_RETURN_DATE] 			
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [IN_SNO] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [LOGIFLAG] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [LOGISEQ] 					
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [LOGICOUNT] 				
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [OUT_SNO] 		
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ADDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [ADDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [UPDUSERCD]
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [UPDDATETIME]
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [INTF_ORDERSTOCK], 'column', [TERMINALCD]	
GO	