--출고마스터
CREATE TABLE [dbo].[P230](
	[WOKEY]				[nvarchar](20) NOT NULL,
	[EAKEY]				[nvarchar](20) NULL,
	[PREKEY]			[nvarchar](20) NULL,
	[WOTYPE]			[nvarchar](10) NULL,
	[WOSTS]				[nvarchar](10) NOT NULL,
	[WOSCHDT]			[nvarchar](8) NULL,
	[WODT]				[nvarchar](8) NULL,
	[COMPCD]			[nvarchar](20) NOT NULL,
	[WHCD]				[nvarchar](20) NOT NULL,
	[CUSTCD]			[nvarchar](20) NOT NULL,
	[SHIPTOCD]			[nvarchar](20) NOT NULL,
	[RECIPIENT]			[nvarchar](20) NULL, 
	[POSTNO]			[nvarchar](20) NULL, 
	[ADDRESS1]			[nvarchar](200) NULL,
	[ADDRESS2]			[nvarchar](200) NULL,
	[PHONENO]			[nvarchar](20) NULL, 
	[ORGCD]				[nvarchar](20) NOT NULL,
	[DEPTCD]			[nvarchar](20) NULL,
	[USERCD]			[nvarchar](20) NULL,
	[SOKEY]				[nvarchar](20) NULL,
	[PKKEY]				[nvarchar](20) NULL,
	[REFNO1]			[nvarchar](20) NULL,
	[REFNO2]			[nvarchar](20) NULL,
	[REFNO3]			[nvarchar](20) NULL,
	[REMARK]			[nvarchar](200) NULL,
	[ADDUSERCD]			[nvarchar](20) NULL,
	[ADDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			[nvarchar](20) NULL,
	[UPDDATETIME]		[datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		[nvarchar](50) NULL,
	[POSTNO_R]			[nvarchar](20) NULL, 
	[ADDRESS1_R]		[nvarchar](200) NULL,
	[ADDRESS2_R]		[nvarchar](200) NULL,   
   
   --추가컬럼   		
	[CLGO_SEQ]			[DECIMAL](10,0) NULL,
   	[INVC_SNO]			[nvarchar](30) NULL,
	[DELI_CD]			[nvarchar](5) NULL,
	[TRACE_CD]			[nvarchar](5) NULL DEFAULT ('00001'),
	[GUBUN1]			[nvarchar](300) NULL,
	[GUBUN2]			[nvarchar](300) NULL,
	[GUBUN3]			[nvarchar](300) NULL,
	[GUBUN4]			[nvarchar](300) NULL,
	[GUBUN5]			[nvarchar](300) NULL,
	[SND_NM]			[nvarchar](300) NULL,
	[SND_ADDR]			[nvarchar](255) NULL,
	[SND_TEL]			[nvarchar](30) NULL,
	[SND_ZIPCODE]		[nvarchar](30) NULL,
	[SND_MSG]			[nvarchar](1000) NULL,
	[ORD_ID]			[nvarchar](30) NULL,
	[ORD_SNOS]			[nvarchar](1000) NULL,
	[ORD_NM]			[nvarchar](300) NULL,
	[ORD_TEL1]			[nvarchar](30) NULL,
	[ORD_TEL2]			[nvarchar](30) NULL,
	[ORD_EMAIL]			[nvarchar](100) NULL,
	[ORD_ZIPCODE]		[nvarchar](30) NULL,
	[ORD_ADDR]			[nvarchar](1000) NULL,
	[ORD_YMD]			[nvarchar](30) NULL,
	[RCV_NM]			[nvarchar](300) NULL,
	[TEL1]				[nvarchar](30) NULL,
	[TEL2]				[nvarchar](30) NULL,
	[ADDR]				[nvarchar](1000) NULL,
	[ZIPCODE]			[nvarchar](30) NULL,
	[QTY]				[nvarchar](10) NULL,
	[DELI_MSG]			[nvarchar](1000) NULL,
	[RCV_MSG]			[nvarchar](1000) NULL,
	[DELI_TYPE]			[nvarchar](30) NULL,
	[DELI_TYPE_EXPORT]	[nvarchar](30) NULL,
	[PROD_CDX]			[nvarchar](1000) NULL,
	[PROD_NMX]			[nvarchar](1000) NULL,
	[PROD_NM]			[nvarchar](1000) NULL,
	[PROD_NM_SHORT]		[nvarchar](1000) NULL,
	[GIFT_MSG]			[nvarchar](1000) NULL,
	[PAY_WAY]			[nvarchar](50) NULL,
	[PAY_YMD]			[nvarchar](1) NULL,
	[REG_SEQ]			[decimal](10, 0) NULL,
	[CLGO_SCAN_YN]		[nvarchar](1) NULL DEFAULT ('N'),
	[CLGO_SCAN_YMDH]	[nvarchar](14) NULL,
	[CLGO_SCAN_ADMIN_ID][nvarchar](30) NULL,
	[CANCEL_YN]			[nvarchar](1) NULL DEFAULT ('N'),
	[CANCEL_YMDH]		[nvarchar](14) NULL,
	[CANCEL_ADMIN_ID]	[nvarchar](30) NULL,
	[STATUS_CD]			[nvarchar](5) NULL,
	[CLGO_COMP_YN]		[nvarchar](1) NULL DEFAULT ('N'),
	[CLGO_COMP_YMDH]	[nvarchar](14) NULL,
	[CLGO_COMP_ADMIN_ID][nvarchar](30) NULL,
	[ADMIN_NOTE]		[nvarchar](1000) NULL,
	[ETC1]				[nvarchar](300) NULL,
	[ETC2]				[nvarchar](300) NULL,
	[ETC3]				[nvarchar](300) NULL,
	[ETC4]				[nvarchar](300) NULL,
	[ETC5]				[nvarchar](300) NULL,
	[ETC6]				[nvarchar](300) NULL,
	[ETC7]				[nvarchar](300) NULL,
	[TOT_PROD_CNT]		[decimal](10, 0) NULL,
	[TOT_PROD_SUM]		[decimal](10, 0) NULL,
	[STM_FEE]			[decimal](10, 0) NULL,
	[TRACE_YMDH]		[nvarchar](14) NULL,
	[TRACE_STATUS_YMDH] [nvarchar](14) NULL,
	[TRACE_RCV_NM]		[nvarchar](30) NULL,
	[BIZ_COMP_NM]		[nvarchar](50) NULL,
	[BIZ_OWNER]			[nvarchar](50) NULL,
	[BIZ_REG_NUM]		[nvarchar](50) NULL,
	[BIZ_TYPE]			[nvarchar](50) NULL,
	[BIZ_ITEM]			[nvarchar](50) NULL,
	[BIZ_FAX]			[nvarchar](50) NULL,
	[BIZ_CONTACT_NM]	[nvarchar](50) NULL,
	[BIZ_CONTACT_TEL1]  [nvarchar](50) NULL,
	[BIZ_CONTACT_TEL2]  [nvarchar](50) NULL,
	[ALLOW_DIRECT_MAIL] [nvarchar](1) NULL,
	[ALLOW_CALL]		[nvarchar](1) NULL,
	[ALLOW_EMAIL]		[nvarchar](1) NULL,
	[EMAIL]				[nvarchar](50) NULL,
	[RCV_COMP_NM]		[nvarchar](50) NULL,
	[ORD_REF]			[nvarchar](105) NULL,
	[ACC_TYPE]			[nvarchar](10) NULL,
	[SUBTOTAL]			[nvarchar](30) NULL,
	[SHIPPING]			[nvarchar](30) NULL,
	[HANDLING]			[nvarchar](30) NULL,
	[TAX]				[nvarchar](30) NULL,
	[DISCOUNT]			[nvarchar](30) NULL,
	[TOTAL]				[nvarchar](30) NULL,
	[INVC_PRN_CNT]		[decimal](10, 0) NULL DEFAULT ((0)),
	[IPGO_AMT]			[decimal](10, 0) NULL DEFAULT ((0)),
	[ORD_AMT]			int NULL,	--2017.12.27 decimal → int 로 수정
	[QTY_INV]			[decimal](10, 0) NULL,
	[RCV_ETC]			[nvarchar](300) NULL,
	[SND_ETC]			[nvarchar](300) NULL,
	[SITE_PROD_CDS]		[nvarchar](500) NULL,
	[DELI_FEE_IN]		[decimal](10, 0) NULL DEFAULT ((0)),
	[DELI_FEE_OUT]		[decimal](10, 0) NULL DEFAULT ((0)),
	[CLGO_AMT]			[decimal](10, 0) NULL,
	[CLGO_WAIVE_YN]		[nvarchar](1) NULL DEFAULT ('N'),
	[DAS_SEQ]			[decimal](10, 0) NULL,
	[DAS_SEQ_SNO]		[decimal](10, 0) NULL,
	[SCAN_SEMI_YN]		[nvarchar](1) NULL,
	[INVC_CLGO_GB]		[nvarchar](5) NULL DEFAULT ('00000'),
	[PROD_GIFT]			[nvarchar](300) NULL,
	[LOT_CD]			[nvarchar](4000) NULL,
	[CUST_CD]			[nvarchar](100) NULL,
	[DELI_END_CD]		[nvarchar](10) NULL,
	[DELI_END_NM]		[nvarchar](40) NULL,
	[DELI_EMP_NM]		[nvarchar](100) NULL,
	[MAN_BRAN_NM]		[nvarchar](100) NULL,
	[INVC_SEQ]			[decimal](10, 0) NULL,
	[SHOP_ORD_SNO]		[nvarchar](500) NULL,
	[RELAY_SEQ]			[decimal](10, 0) NULL,
	[BOX_NM]			[nvarchar](30) NULL,
	[ADDRYN]			[nvarchar](2) NULL DEFAULT ('N'),
	[INTF_WAIVE_YN]     [nvarchar](1) NULL DEFAULT ('N'),
	[INVC_VOL]          DECIMAL(20,0) NULL,
	[INVC_MAX_SIDE]     INT NULL,
	[INVC_BOX_CNT]      INT NULL,
	[DELI_SCAN_BRA_NM]  NVARCHAR(50) NULL,
	[DELI_SCAN_EMP_NM]  NVARCHAR(50) NULL,
	[INTF_SCAN]         NVARCHAR(1) NULL,
	[CLGO_SNO]		 	decimal(10,0) IDENTITY(10000000,1) NOT NULL
 CONSTRAINT [PK_P230] PRIMARY KEY CLUSTERED
(
   [WOKEY] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P230_01] ON [dbo].[P230]
(
	[PREKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P230_04] ON [dbo].[P230]
(
	[PKKEY] ASC,
	[WOSTS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P230_05] ON [dbo].[P230]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WOSCHDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P230_06] ON [dbo].[P230]
(
	[REG_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [IDX_P230_07] ON [dbo].[P230]
(
	[CLGO_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


CREATE NONCLUSTERED INDEX [IDX_P230_08] ON [dbo].[P230]
(
	[CLGO_SNO] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO
CREATE NONCLUSTERED INDEX [IDX_P230_09] ON [dbo].[P230]
(
	[CLGO_SCAN_YMDH] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO
CREATE NONCLUSTERED INDEX [IDX_P230_10] ON [dbo].[P230]
(
	[INVC_SNO] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO
CREATE NONCLUSTERED INDEX [IDX_P230_11] ON [dbo].[P230]
(
	[RCV_NM] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO
CREATE NONCLUSTERED INDEX [IDX_P230_12] ON [dbo].[P230]
(
	[INVC_SEQ] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P230 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '출고마스터', 'user', dbo, 'table',[P230]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '출고번호', 'user', dbo, 'table', [P230], 'column', [WOKEY]
EXEC   sp_addextendedproperty 'MS_Description', '작업단위번호(매출작업단위)', 'user', dbo, 'table', [P230], 'column', PREKEY
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P230], 'column', EAKEY
EXEC   sp_addextendedproperty 'MS_Description', '출고유형', 'user', dbo, 'table', [P230], 'column', WOTYPE
EXEC   sp_addextendedproperty 'MS_Description', '출고상태', 'user', dbo, 'table', [P230], 'column', WOSTS
EXEC   sp_addextendedproperty 'MS_Description', '출고요청일', 'user', dbo, 'table', [P230], 'column', WOSCHDT
EXEC   sp_addextendedproperty 'MS_Description', '출고일', 'user', dbo, 'table', [P230], 'column', WODT
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P230], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P230], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '거래처코드', 'user', dbo, 'table', [P230], 'column', CUSTCD
EXEC   sp_addextendedproperty 'MS_Description', '납품처코드', 'user', dbo, 'table', [P230], 'column', SHIPTOCD
EXEC   sp_addextendedproperty 'MS_Description', '수령인', 'user', dbo, 'table', [P230], 'column', RECIPIENT
EXEC   sp_addextendedproperty 'MS_Description', '납품처우편번호', 'user', dbo, 'table', [P230], 'column', POSTNO
EXEC   sp_addextendedproperty 'MS_Description', '납품처주소1', 'user', dbo, 'table', [P230], 'column', ADDRESS1
EXEC   sp_addextendedproperty 'MS_Description', '납품처주소2', 'user', dbo, 'table', [P230], 'column', ADDRESS2
EXEC   sp_addextendedproperty 'MS_Description', '연락처', 'user', dbo, 'table', [P230], 'column', PHONENO
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P230], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P230], 'column', DEPTCD
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P230], 'column', USERCD
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P230], 'column', SOKEY
EXEC   sp_addextendedproperty 'MS_Description', '피킹지시번호', 'user', dbo, 'table', [P230], 'column', PKKEY
EXEC   sp_addextendedproperty 'MS_Description', '참조번호1 ', 'user', dbo, 'table', [P230], 'column', REFNO1
EXEC   sp_addextendedproperty 'MS_Description', '참조번호2 ', 'user', dbo, 'table', [P230], 'column', REFNO2
EXEC   sp_addextendedproperty 'MS_Description', '참조번호3', 'user', dbo, 'table', [P230], 'column', REFNO3
EXEC   sp_addextendedproperty 'MS_Description', '비고', 'user', dbo, 'table', [P230], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P230], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P230], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P230], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P230], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P230], 'column', TERMINALCD
EXEC   sp_addextendedproperty 'MS_Description', '수령인우편번호', 'user', dbo, 'table', [P230], 'column', POSTNO_R
EXEC   sp_addextendedproperty 'MS_Description', '수령인주소1', 'user', dbo, 'table', [P230], 'column', ADDRESS1_R
EXEC   sp_addextendedproperty 'MS_Description', '수령인주소2', 'user', dbo, 'table', [P230], 'column', ADDRESS2_R


--추가컬럼
EXEC   sp_addextendedproperty 'MS_Description', '고객주문번호', 'user', dbo, 'table', [P230], 'column',	[CLGO_SEQ] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '송장번호', 'user', dbo, 'table', [P230], 'column',	[INVC_SNO] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '택배사', 'user', dbo, 'table', [P230], 'column',	[DELI_CD]  		   	 
EXEC   sp_addextendedproperty 'MS_Description', '추적상태', 'user', dbo, 'table', [P230], 'column',	[TRACE_CD] 		   	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[GUBUN1] 	       	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[GUBUN2]	       	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[GUBUN3] 		   	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[GUBUN4] 		   	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[GUBUN5] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람', 'user', dbo, 'table', [P230], 'column',	[SND_NM] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람주소', 'user', dbo, 'table', [P230], 'column',	[SND_ADDR]         	 
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람전화번호', 'user', dbo, 'table', [P230], 'column',	[SND_TEL]          	 
EXEC   sp_addextendedproperty 'MS_Description', '보낸사람우편번호', 'user', dbo, 'table', [P230], 'column',	[SND_ZIPCODE]      	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[SND_MSG]          	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자id', 'user', dbo, 'table', [P230], 'column',	[ORD_ID]           	 
EXEC   sp_addextendedproperty 'MS_Description', '주문번호', 'user', dbo, 'table', [P230], 'column',	[ORD_SNOS]         	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자', 'user', dbo, 'table', [P230], 'column',	[ORD_NM] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자전화1', 'user', dbo, 'table', [P230], 'column',	[ORD_TEL1] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자전화2', 'user', dbo, 'table', [P230], 'column',	[ORD_TEL2] 		   	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자이메일', 'user', dbo, 'table', [P230], 'column',	[ORD_EMAIL] 	   	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자우편번호', 'user', dbo, 'table', [P230], 'column',	[ORD_ZIPCODE] 	   	 
EXEC   sp_addextendedproperty 'MS_Description', '주문자주소', 'user', dbo, 'table', [P230], 'column',	[ORD_ADDR]         	 
EXEC   sp_addextendedproperty 'MS_Description', '주문일', 'user', dbo, 'table', [P230], 'column',	[ORD_YMD]          	 
EXEC   sp_addextendedproperty 'MS_Description', '수취인', 'user', dbo, 'table', [P230], 'column',	[RCV_NM]           	 
EXEC   sp_addextendedproperty 'MS_Description', '전화1', 'user', dbo, 'table', [P230], 'column',	[TEL1]             	 
EXEC   sp_addextendedproperty 'MS_Description', '전화2', 'user', dbo, 'table', [P230], 'column',	[TEL2]             	 
EXEC   sp_addextendedproperty 'MS_Description', '주소', 'user', dbo, 'table', [P230], 'column',	[ADDR]             	 
EXEC   sp_addextendedproperty 'MS_Description', '우편번호', 'user', dbo, 'table', [P230], 'column',	[ZIPCODE]          	 
EXEC   sp_addextendedproperty 'MS_Description', '수량', 'user', dbo, 'table', [P230], 'column',	[QTY]              	 
EXEC   sp_addextendedproperty 'MS_Description', '배송메시지', 'user', dbo, 'table', [P230], 'column',	[DELI_MSG]         	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[RCV_MSG]          	 
EXEC   sp_addextendedproperty 'MS_Description', '배송구분', 'user', dbo, 'table', [P230], 'column',	[DELI_TYPE]        	 
EXEC   sp_addextendedproperty 'MS_Description', '정산구분', 'user', dbo, 'table', [P230], 'column',	[DELI_TYPE_EXPORT] 	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[PROD_CDX] 		   	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[PROD_NMX]         	 
EXEC   sp_addextendedproperty 'MS_Description', '품목명', 'user', dbo, 'table', [P230], 'column',	[PROD_NM]          	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[PROD_NM_SHORT]    	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[GIFT_MSG]         	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[PAY_WAY]          	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[PAY_YMD]          	 
EXEC   sp_addextendedproperty 'MS_Description', '등록번호', 'user', dbo, 'table', [P230], 'column',	[REG_SEQ]

EXEC   sp_addextendedproperty 'MS_Description', '출고스캔여부(개별차수는 하지 않음)', 'user', dbo, 'table', [P230], 'column',	[CLGO_SCAN_YN] 	   	 
EXEC   sp_addextendedproperty 'MS_Description', '스캔일자', 'user', dbo, 'table', [P230], 'column',	[CLGO_SCAN_YMDH]   	 
EXEC   sp_addextendedproperty 'MS_Description', '스캔ID', 'user', dbo, 'table', [P230], 'column',	[CLGO_SCAN_ADMIN_ID] 
/*취소관련 (AS-IS 처리화면 : 주문및송장관리) */
EXEC   sp_addextendedproperty 'MS_Description', '취소구분(주문및송장관리에서 취소처리함[Y/N])', 'user', dbo, 'table', [P230], 'column',	[CANCEL_YN] 		 
EXEC   sp_addextendedproperty 'MS_Description', '취소일시', 'user', dbo, 'table', [P230], 'column',	[CANCEL_YMDH] 		 
EXEC   sp_addextendedproperty 'MS_Description', '취소자ID', 'user', dbo, 'table', [P230], 'column',	[CANCEL_ADMIN_ID]    

EXEC   sp_addextendedproperty 'MS_Description', '상태값(0001:출고대기중 / 0002: 출고스캔완료/ 0003:출고완료/ 0004:출고대기중취소/ 0005: 출고스캔완료취소 / 0006:출고완료취소[재고ROLLBACK없음] )', 'user', dbo, 'table', [P230], 'column',	[STATUS_CD] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[CLGO_COMP_YN] 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[CLGO_COMP_YMDH] 	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[CLGO_COMP_ADMIN_ID] 
EXEC   sp_addextendedproperty 'MS_Description', '발송자비고', 'user', dbo, 'table', [P230], 'column',	[ADMIN_NOTE] 		 
EXEC   sp_addextendedproperty 'MS_Description', '고객반송메세지', 'user', dbo, 'table', [P230], 'column',	[ETC1] 				 
EXEC   sp_addextendedproperty 'MS_Description', '회수시요구사항', 'user', dbo, 'table', [P230], 'column',	[ETC2] 				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ETC3] 				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ETC4] 				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ETC5] 				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ETC6] 				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ETC7] 				 
EXEC   sp_addextendedproperty 'MS_Description', '내품건수', 'user', dbo, 'table', [P230], 'column',	[TOT_PROD_CNT] 		 
EXEC   sp_addextendedproperty 'MS_Description', '내품수량', 'user', dbo, 'table', [P230], 'column',	[TOT_PROD_SUM] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[STM_FEE] 			 
EXEC   sp_addextendedproperty 'MS_Description', '추적일시', 'user', dbo, 'table', [P230], 'column',	[TRACE_YMDH] 		 
EXEC   sp_addextendedproperty 'MS_Description', '최종상태일시', 'user', dbo, 'table', [P230], 'column',	[TRACE_STATUS_YMDH]  
EXEC   sp_addextendedproperty 'MS_Description', '받는사람', 'user', dbo, 'table', [P230], 'column',	[TRACE_RCV_NM] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_COMP_NM] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_OWNER] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_REG_NUM]        
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_TYPE] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_ITEM] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_FAX] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_CONTACT_NM] 	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_CONTACT_TEL1]   
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BIZ_CONTACT_TEL2]   
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ALLOW_DIRECT_MAIL]  
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ALLOW_CALL] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ALLOW_EMAIL] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[EMAIL] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[RCV_COMP_NM] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ORD_REF] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ACC_TYPE] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[SUBTOTAL] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[SHIPPING] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[HANDLING] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[TAX] 				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[DISCOUNT] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[TOTAL] 			 
EXEC   sp_addextendedproperty 'MS_Description', '출력건수', 'user', dbo, 'table', [P230], 'column',	[INVC_PRN_CNT] 		 
EXEC   sp_addextendedproperty 'MS_Description', '입고액', 'user', dbo, 'table', [P230], 'column',	[IPGO_AMT] 			 
EXEC   sp_addextendedproperty 'MS_Description', '주문액', 'user', dbo, 'table', [P230], 'column',	[ORD_AMT] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[QTY_INV] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[RCV_ETC] 			 
EXEC   sp_addextendedproperty 'MS_Description', '발송자비고', 'user', dbo, 'table', [P230], 'column',	[SND_ETC] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[SITE_PROD_CDS] 	 
EXEC   sp_addextendedproperty 'MS_Description', '교환비', 'user', dbo, 'table', [P230], 'column',	[DELI_FEE_IN] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[DELI_FEE_OUT] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[CLGO_AMT] 			 
EXEC   sp_addextendedproperty 'MS_Description', '출고보류(Y일때 스캔 및 확정이 안되도록)', 'user', dbo, 'table', [P230], 'column',	[CLGO_WAIVE_YN] 	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[DAS_SEQ] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[DAS_SEQ_SNO] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[SCAN_SEMI_YN] 		 
EXEC   sp_addextendedproperty 'MS_Description', '출고구분', 'user', dbo, 'table', [P230], 'column',	[INVC_CLGO_GB] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[PROD_GIFT] 		 
EXEC   sp_addextendedproperty 'MS_Description', 'LOT', 'user', dbo, 'table', [P230], 'column',	[LOT_CD] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[CUST_CD] 			 
EXEC   sp_addextendedproperty 'MS_Description', 'CJ택배인터페이스(CLSFCD + SUBCLSFCD)', 'user', dbo, 'table', [P230], 'column',	[DELI_END_CD] 		 
EXEC   sp_addextendedproperty 'MS_Description', 'CJ택배인터페이스(SHORTADDR)', 'user', dbo, 'table', [P230], 'column',	[DELI_END_NM] 		 
EXEC   sp_addextendedproperty 'MS_Description', 'CJ택배인터페이스(CLLDLVEMPNM)', 'user', dbo, 'table', [P230], 'column',	[DELI_EMP_NM] 		 
EXEC   sp_addextendedproperty 'MS_Description', 'cj택배인터페이스(CLLDLCBRANSHORTNM)', 'user', dbo, 'table', [P230], 'column',	[MAN_BRAN_NM] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[INVC_SEQ] 			 
EXEC   sp_addextendedproperty 'MS_Description', '쇼핑몰주문번호', 'user', dbo, 'table', [P230], 'column',	[SHOP_ORD_SNO] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[RELAY_SEQ] 		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[BOX_NM] 			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[ADDRYN]
EXEC   sp_addextendedproperty 'MS_Description', '인터페이스출고보류', 'user', dbo, 'table', [P230], 'column',	[INTF_WAIVE_YN]
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[INVC_VOL]        
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[INVC_MAX_SIDE]   
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[INVC_BOX_CNT]    
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[DELI_SCAN_BRA_NM]
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[DELI_SCAN_EMP_NM]
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P230], 'column',	[INTF_SCAN]       
GO

-- 출고상세
CREATE TABLE [dbo].[P231](
	[WOKEY]				 [nvarchar](20) NOT NULL,
	[SEQ]				 [decimal](10,0) NOT NULL,
	[ITEMCD]			 [nvarchar](20) NOT NULL,
	[ORIGINQTY]			 [decimal](17,6) NULL,
	[WOSCHQTY]			 [decimal](17,6) NULL,   
	[PICKQTY]			 [decimal](17,6) NULL,   
	[PICKEDQTY]			 [decimal](17,6) NULL,   
	[WOQTY]				 [decimal](17,6) NULL,
	[EXCHCD]			 [nvarchar](10) NULL,      --화폐단위
	[EXCHRATE]			 [decimal](17,6) NULL,     --환율
	[UNITPRICE]			 [decimal](17,6) NULL,     --화폐단위단가
	[EXCHAMT]			 [decimal](17,4) NULL,     --출고금액(화폐단위)
	[SUPPLYAMT]			 [decimal](17,4) NULL,     --출고금액(원화환산)
	[LOT1]				 [nvarchar](50) NULL,
	[LOT2]				 [nvarchar](50) NULL,
	[LOT3]				 [nvarchar](50) NULL,
	[LOT4]				 [nvarchar](20) NULL,
	[LOT5]				 [nvarchar](20) NULL,
	[LOTRESERVEFLG]		 [nvarchar](1) NULL,
	[COMPCD]			 [nvarchar](20) NOT NULL,
	[ORGCD]				 [nvarchar](20) NOT NULL,
	[WHCD]				 [nvarchar](20) NOT NULL,
	[LOCCD]				 [nvarchar](20) NULL,
	[LOTKEY]			 [nvarchar](20) NULL,
	[SOKEY]				 [nvarchar](20) NULL,
	[SOSEQ]				 [decimal](10,0) NULL,
	[REMARK]			 [nvarchar](200) NULL,
	[ADDUSERCD]			 [nvarchar](20) NULL,
	[ADDDATETIME]		 [datetime] NULL DEFAULT (getdate()),
	[UPDUSERCD]			 [nvarchar](20) NULL,
	[UPDDATETIME]		 [datetime] NULL DEFAULT (getdate()),
	[TERMINALCD]		 [nvarchar](50) NULL,

	
   --추가컬럼
	[CLGO_SEQ]			 [DECIMAL](10,0) NULL,
	[SNO]				 [DECIMAL](10,0) NULL,
	[PROD_NM]			 [NVARCHAR](1000) NULL,
	[QTY]				 [DECIMAL](10,0) NULL,
	[CANCEL_QTY]		 [DECIMAL](10,0) NULL DEFAULT (0),
	[CLGO_SPROD_CNT]	 [DECIMAL](10,0) NULL DEFAULT (0),
--	[PROD_CD_1]			 [NVARCHAR](300) NULL,		--
--	[PROD_CD_2]			 [NVARCHAR](300) NULL,		--
--	[LIST_PRICE]		 [NVARCHAR](30) NULL,		--
--	[SELLING_PRICE]		 [NVARCHAR](30) NULL,		--
--	[TOTAL]				 [NVARCHAR](30) NULL,		--
	[ORD_AMT]			 [DECIMAL](10,0) NULL DEFAULT (0),
	[IPGO_AMT]			 [DECIMAL](10,0) NULL DEFAULT (0),
	[ORD_DTL_SNO]		 [NVARCHAR](300) NULL,
	[ORD_DTL_PROD]		 [NVARCHAR](300) NULL,
	[DELI_FEE_IN]		 [DECIMAL](10,0) NULL DEFAULT (0),
	[CLGO_AMT]			 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_ORD_AMT]		 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_SVC_FEE]		 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_RCV_AMT]		 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_ORD_AMT_ADD]	 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_SVC_FEE_ADD]	 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_RCV_AMT_ADD]	 [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_ORD_AMT_CANCEL] [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_SVC_FEE_CANCEL] [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_RCV_AMT_CANCEL] [DECIMAL](10,0) NULL DEFAULT (0),
	[STM_STATUS_CD]		 [NVARCHAR](5) 	 NULL DEFAULT ('00000'),
	[STM_YMD]			 [NVARCHAR](8)   NULL,
	[PROD_GIFT_YN]		 [NVARCHAR](1)   NULL DEFAULT ('N'),
	[PACK_BOX_NO]		 [NVARCHAR](30)  NULL,
 CONSTRAINT [PK_P231] PRIMARY KEY CLUSTERED
(
   [WOKEY] ASC,
   [SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P231_01] ON [dbo].[P231]
(
	[CLGO_SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX  [IDX_P231_02] ON [dbo].[P231]
(
	[ORD_DTL_SNO] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90)
GO




-- LOCK_ESCALATION DISABLE 
ALTER TABLE P231 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '출고상세', 'user', dbo, 'table',[P231]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '출고번호', 'user', dbo, 'table', [P231], 'column', WOKEY
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [P231], 'column', SEQ
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P231], 'column', ITEMCD
EXEC   sp_addextendedproperty 'MS_Description', '최초출고예정수량', 'user', dbo, 'table', [P231], 'column', ORIGINQTY
EXEC   sp_addextendedproperty 'MS_Description', '출고예정수량', 'user', dbo, 'table', [P231], 'column', WOSCHQTY
EXEC   sp_addextendedproperty 'MS_Description', '지시수량', 'user', dbo, 'table', [P231], 'column', PICKQTY
EXEC   sp_addextendedproperty 'MS_Description', '피킹수량', 'user', dbo, 'table', [P231], 'column', PICKEDQTY
EXEC   sp_addextendedproperty 'MS_Description', '출고수량', 'user', dbo, 'table', [P231], 'column', WOQTY
EXEC   sp_addextendedproperty 'MS_Description', '화폐단위', 'user', dbo, 'table', [P231], 'column', EXCHCD
EXEC   sp_addextendedproperty 'MS_Description', '환율', 'user', dbo, 'table', [P231], 'column', EXCHRATE
EXEC   sp_addextendedproperty 'MS_Description', '화폐단위단가', 'user', dbo, 'table', [P231], 'column', UNITPRICE
EXEC   sp_addextendedproperty 'MS_Description', '출고금액(화폐단위)', 'user', dbo, 'table', [P231], 'column', EXCHAMT
EXEC   sp_addextendedproperty 'MS_Description', '출고금액(원화환산)', 'user', dbo, 'table', [P231], 'column', SUPPLYAMT
EXEC   sp_addextendedproperty 'MS_Description', '로트속성1', 'user', dbo, 'table', [P231], 'column', LOT1
EXEC   sp_addextendedproperty 'MS_Description', '로트속성2', 'user', dbo, 'table', [P231], 'column', LOT2
EXEC   sp_addextendedproperty 'MS_Description', '로트속성3', 'user', dbo, 'table', [P231], 'column', LOT3
EXEC   sp_addextendedproperty 'MS_Description', '로트속성4(코드)', 'user', dbo, 'table', [P231], 'column', LOT4
EXEC   sp_addextendedproperty 'MS_Description', '로트속성5(코드)', 'user', dbo, 'table', [P231], 'column', LOT5
EXEC   sp_addextendedproperty 'MS_Description', '로트지정여부', 'user', dbo, 'table', [P231], 'column', LOTRESERVEFLG
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P231], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P231], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P231], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '로케이션(단순출고)', 'user', dbo, 'table', [P231], 'column', LOCCD
EXEC   sp_addextendedproperty 'MS_Description', '로트키(단순출고)', 'user', dbo, 'table', [P231], 'column', LOTKEY
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P231], 'column', SOKEY
EXEC   sp_addextendedproperty 'MS_Description', 'X', 'user', dbo, 'table', [P231], 'column', SOSEQ
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P231], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P231], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P231], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P231], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P231], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P231], 'column', TERMINALCD

--추가컬럼		 
EXEC   sp_addextendedproperty 'MS_Description', '고객주문번호', 'user', dbo, 'table', [P231], 'column',	[CLGO_SEQ] 	
EXEC   sp_addextendedproperty 'MS_Description', '순번', 'user', dbo, 'table', [P231], 'column',	[SNO] 	
EXEC   sp_addextendedproperty 'MS_Description', '품목명', 'user', dbo, 'table', [P231], 'column', 	[PROD_NM]			 
EXEC   sp_addextendedproperty 'MS_Description', '수량', 'user', dbo, 'table', [P231], 'column', 	[QTY]				 
EXEC   sp_addextendedproperty 'MS_Description', '취소수량', 'user', dbo, 'table', [P231], 'column', 	[CANCEL_QTY]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[CLGO_SPROD_CNT]	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[PROD_CD_1]			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[PROD_CD_2]			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[LIST_PRICE]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[SELLING_PRICE]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[TOTAL]				 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[ORD_AMT]			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[IPGO_AMT]			 
EXEC   sp_addextendedproperty 'MS_Description', '판매처주문번호', 'user', dbo, 'table', [P231], 'column', 	[ORD_DTL_SNO]		 
EXEC   sp_addextendedproperty 'MS_Description', '판매처품목코드', 'user', dbo, 'table', [P231], 'column', 	[ORD_DTL_PROD]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[DELI_FEE_IN]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[CLGO_AMT]			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_ORD_AMT]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_SVC_FEE]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_RCV_AMT]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_ORD_AMT_ADD]	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_SVC_FEE_ADD]	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_RCV_AMT_ADD]	 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_ORD_AMT_CANCEL] 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_SVC_FEE_CANCEL] 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_RCV_AMT_CANCEL] 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_STATUS_CD]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[STM_YMD]			 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[PROD_GIFT_YN]		 
--EXEC   sp_addextendedproperty 'MS_Description', '', 'user', dbo, 'table', [P231], 'column', 	[PACK_BOX_NO]	

GO

--피킹마스터
CREATE TABLE [dbo].[P240](
   [PKKEY]       [nvarchar](20) NOT NULL,
   [PKDT]        [nvarchar](8) NOT NULL,
   [PKTYPE]      [nvarchar](5) NOT NULL, 
   [COMPCD]      [nvarchar](20) NOT NULL,
   [WHCD]        [nvarchar](20) NOT NULL,
   [ORGCD]       [nvarchar](20) NOT NULL,
   [WOKEY]       [nvarchar](20) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P240] PRIMARY KEY CLUSTERED
(
   [PKKEY] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P240_01] ON [dbo].[P240]
(
	[WOKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

CREATE NONCLUSTERED INDEX [IDX_P240_02] ON [dbo].[P240]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P240 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '피킹마스터', 'user', dbo, 'table',[P240]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '피킹번호', 'user', dbo, 'table', [P240], 'column', PKKEY
EXEC   sp_addextendedproperty 'MS_Description', '피킹일자', 'user', dbo, 'table', [P240], 'column', PKDT
EXEC   sp_addextendedproperty 'MS_Description', '피킹유형', 'user', dbo, 'table', [P240], 'column', PKTYPE
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P240], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P240], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P240], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '출고번호', 'user', dbo, 'table', [P240], 'column', WOKEY
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P240], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P240], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P240], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P240], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P240], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P240], 'column', TERMINALCD
GO


-- 피킹상세
CREATE TABLE [dbo].[P241](
   [PKKEY]       [nvarchar](20) NOT NULL,
   [SEQ]         [decimal](10,0) NOT NULL,
   [PKSTS]       [nvarchar](5) NOT NULL,
   [PREKEY]      [nvarchar](20) NULL,
   [WOKEY]       [nvarchar](20) NULL,
   [WOSEQ]       [decimal](10,0) NULL,
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
   [FROMLOCCD]   [nvarchar](20) NULL,
   [TOLOCCD]     [nvarchar](20) NULL,
   [PICKQTY]     [decimal](17,6) NULL,
   [PICKEDQTY]   [decimal](17,6) NULL,
   [WORKER]      [nvarchar](20) NULL,
   [REMARK]      [nvarchar](200) NULL,
   [ADDUSERCD]   [nvarchar](20) NULL,
   [ADDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [UPDUSERCD]   [nvarchar](20) NULL,
   [UPDDATETIME] [datetime] NULL DEFAULT (getdate()),
   [TERMINALCD]  [nvarchar](50) NULL,
 CONSTRAINT [PK_P241] PRIMARY KEY CLUSTERED
(
   [PKKEY] ASC,
   [SEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_P241_01] ON [dbo].[P241]
(
	[PREKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

CREATE NONCLUSTERED INDEX [IDX_P241_02] ON [dbo].[P241]
(
	[WOKEY] ASC,
	[WOSEQ] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

CREATE NONCLUSTERED INDEX [IDX_P241_03] ON [dbo].[P241]
(
	[COMPCD] ASC,
	[ORGCD] ASC,
	[WHCD] ASC,
	[ITEMCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO 

-- LOCK_ESCALATION DISABLE 
ALTER TABLE P241 SET ( LOCK_ESCALATION = DISABLE )
GO
/*
   1. 주석추가 (add)
*/
/*테이블 */
EXEC   sp_addextendedproperty 'MS_Description', '피킹상세', 'user', dbo, 'table',[P241]
/*컬럼들*/
EXEC   sp_addextendedproperty 'MS_Description', '피킹번호', 'user', dbo, 'table', [P241], 'column', PKKEY
EXEC   sp_addextendedproperty 'MS_Description', '일련번호', 'user', dbo, 'table', [P241], 'column', SEQ
EXEC   sp_addextendedproperty 'MS_Description', '피킹상세상태', 'user', dbo, 'table', [P241], 'column', PKSTS
EXEC   sp_addextendedproperty 'MS_Description', '작업단위번호', 'user', dbo, 'table', [P241], 'column', PREKEY
EXEC   sp_addextendedproperty 'MS_Description', '출고번호', 'user', dbo, 'table', [P241], 'column', WOKEY
EXEC   sp_addextendedproperty 'MS_Description', '출고일련번호', 'user', dbo, 'table', [P241], 'column', WOSEQ
EXEC   sp_addextendedproperty 'MS_Description', '품목코드', 'user', dbo, 'table', [P241], 'column', ITEMCD
EXEC   sp_addextendedproperty 'MS_Description', '로트속성1', 'user', dbo, 'table', [P241], 'column', LOT1
EXEC   sp_addextendedproperty 'MS_Description', '로트속성2', 'user', dbo, 'table', [P241], 'column', LOT2
EXEC   sp_addextendedproperty 'MS_Description', '로트속성3', 'user', dbo, 'table', [P241], 'column', LOT3
EXEC   sp_addextendedproperty 'MS_Description', '로트속성4(코드)', 'user', dbo, 'table', [P241], 'column', LOT4
EXEC   sp_addextendedproperty 'MS_Description', '로트속성5(코드)', 'user', dbo, 'table', [P241], 'column', LOT5
EXEC   sp_addextendedproperty 'MS_Description', '로트키', 'user', dbo, 'table', [P241], 'column', LOTKEY
EXEC   sp_addextendedproperty 'MS_Description', '회사코드', 'user', dbo, 'table', [P241], 'column', COMPCD
EXEC   sp_addextendedproperty 'MS_Description', '창고코드', 'user', dbo, 'table', [P241], 'column', WHCD
EXEC   sp_addextendedproperty 'MS_Description', '셀러코드', 'user', dbo, 'table', [P241], 'column', ORGCD
EXEC   sp_addextendedproperty 'MS_Description', '지시로케이션', 'user', dbo, 'table', [P241], 'column', FROMLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '실적로케이션', 'user', dbo, 'table', [P241], 'column', TOLOCCD
EXEC   sp_addextendedproperty 'MS_Description', '지시수량', 'user', dbo, 'table', [P241], 'column', PICKQTY
EXEC   sp_addextendedproperty 'MS_Description', '피킹수량', 'user', dbo, 'table', [P241], 'column', PICKEDQTY
EXEC   sp_addextendedproperty 'MS_Description', '작업자', 'user', dbo, 'table', [P241], 'column', WORKER
EXEC   sp_addextendedproperty 'MS_Description', '비고 ', 'user', dbo, 'table', [P241], 'column', REMARK
EXEC   sp_addextendedproperty 'MS_Description', '등록자ID', 'user', dbo, 'table', [P241], 'column', ADDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '등록일시', 'user', dbo, 'table', [P241], 'column', ADDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', '수정자ID', 'user', dbo, 'table', [P241], 'column', UPDUSERCD
EXEC   sp_addextendedproperty 'MS_Description', '수정일시', 'user', dbo, 'table', [P241], 'column', UPDDATETIME
EXEC   sp_addextendedproperty 'MS_Description', 'IP', 'user', dbo, 'table', [P241], 'column', TERMINALCD
GO
