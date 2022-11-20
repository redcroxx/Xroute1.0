package xrt.alexcloud.common;

public class CommonConst {

    // 관리자 회사코드
    public static final String XROUTE_COMPCD = "1000";
    // 김포센터 창고 코드 및 이름
    public static final String XROUTE_GIMPO_WHCD = "7000";
    public static final String XROUTE_GIMPO_WHNM = "김포센터";

    // 배송구분
    public static final String SHIP_METHOD_PREMIUM = "PREMIUM";
    public static final String SHIP_METHOD_DHL = "DHL";
    public static final String SHIP_METHOD_UPS = "UPS";
    // 배송구분에 따른 부피계산
    public static final String BOX_VOLUME_PRIMEUM_NUMBER = "6000";
    public static final String BOX_VOLUME_EXPRESS_NUMBER = "5000";
    public static final String BOX_VOLUME_UPS_NUMBER = "5000";

    // 센터에 재고를 적재한 상태에서의 오더
    public static final String STOCK_TYPE_CENTER = "1";
    public static final String STOCK_TYPE_SELLER = "2";

    // 결제구분 : 건당결제
    public static final String PAYEMNT_TYPE_PERCASE = "1";
    // 결제구분 : 월말결제
    public static final String PAYEMNT_TYPE_MONTH = "2";
    // 결제구분 : 정기결제
    public static final String PAYEMNT_TYPE_REGULAR = "3";
    // 결제구분 : 신용결제
    public static final String PAYEMNT_TYPE_WARRANTY = "4";

    // 송장 취소 시간
    public static final String LABEL_CANCEL_MINUTE = "30";

    // 한도 무게
    public static final String LIMIT_WGT = "30";
    public static final String UPS_LIMIT_WGT = "20";

    // 사용자 그룹 슈퍼 관리자
    public static final String XROUTE_ADMIN = "80";
    // 사용자 그룹 센터 관리자
    public static final String CENTER_ADMIN = "70";
    // 사용자 그룹 센터 슈퍼 사용자
    public static final String CENTER_SUPER_USER = "60";
    // 사용자 그룹 센터 사용자
    public static final String CENTER_USER = "50";
    // 사용자 그룹 셀러 관리자
    public static final String SELLER_ADMIN = "40";
    // 사용자 그룹 셀러 슈퍼 사용자
    public static final String SELLER_SUPER_USER = "30";
    // 사용자 그룹 셀러 사용자
    public static final String SELLER_USER = "20";
    // 사용자 그룹 게스트
    public static final String GUEST_USER = "10";

    // 주문 상태코드 주문등록
    public static final String ORD_STATUS_CD_ORDER_APPLY = "10";
    // 주문 상태코드 발송대기
    public static final String ORD_STATUS_CD_SENDING_WAIT = "11";
    // 주문 상태코드 발송완료
    public static final String ORD_STATUS_CD_SENDING_COMP = "12";
    // 주문 상태코드 입금대기.
    public static final String ORD_STATUS_CD_CENTER_ARRIVE = "20";
    // 주문 상태코드 입금완료
    public static final String ORD_STATUS_CD_PAYMENT_COMP = "21";
    // 주문 상태코드 결제 대기
    public static final String ORD_STATUS_CD_PAYMENT_WAIT = "22";
    // 주문 상태코드 결제 실패
    public static final String ORD_STATUS_CD_PAYMENT_FAIL = "23";
    // 주문 상태코드 입고완료
    public static final String ORD_STATUS_CD_STOCK_COMP = "30";
    // 주문 상태코드 창고보관
    public static final String ORD_STATUS_CD_WAREHOUSE = "31";
    // 주문 상태코드 출고 대기
    public static final String ORD_STATUS_CD_SHIP_HOLD = "32";
    // 주문 상태코드 검수 완료
    public static final String ORD_STATUS_CD_INSPECTION_COMP = "33";
    // 주문 상태코드 검수 취소
    public static final String ORD_STATUS_CD_INSPECTION_CANCEL = "34";
    // 주문 상태코드 선적 대기
    public static final String ORD_STATUS_CD_WAITING_FOR_SHIPMENT = "35";
    // 주문 상태코드 출고 완료
    public static final String ORD_STATUS_CD_SHIP_COMP = "40";
    // 주문 상태코드 공항 출발 예정
    public static final String ORD_STATUS_CD_ETD = "50";
    // 주문 상태코드 공항 출발 완료
    public static final String ORD_STATUS_CD_ETD_COMP = "51";
    // 주문 상태코드 해외 공항 도착 예정
    public static final String ORD_STATUS_CD_ETA = "52";
    // 주문 상태코드 해외 공항 도착 완료
    public static final String ORD_STATUS_CD_ETA_COMP = "53";
    // 주문 상태코드 수입국통관대기
    public static final String ORD_STATUS_CD_CC_WAIT = "54";
    // 주문 상태코드 수입국통관완료
    public static final String ORD_STATUS_CD_CC_COMP = "55";
    // 주문 상태코드 수입국 배송시작
    public static final String ORD_STATUS_CD_DELIVERY_START = "56";
    // 주문 상태코드 수입국 배송중
    public static final String ORD_STATUS_CD_DELIVERING = "57";
    // 주문 상태코드 수입국 배송완료
    public static final String ORD_STATUS_CD_DELIVERY_COMP = "60";
    // 주문 상태코드 API Error
    public static final String ORD_STATUS_CD_API_FAIL = "80";
    // 주문 상태코드 입고 취소
    public static final String ORD_STATUS_CD_ORDER_CANCEL = "95";
    // 주문 상태코드 수입국 배송대기
    public static final String ORD_STATUS_CD_PENDING = "96";
    // 주문 상태코드 발송보류
    public static final String ORD_STATUS_CD_UNDELIVERED = "97";
    // 주문 상태코드 입금대기,입금완료 취소
    public static final String ORD_STATUS_CD_DEPOSIT_CANCEL = "98";
    // 주문 상태코드 주문캔슬
    public static final String ORD_STATUS_CD_STOCK_CANCEL = "99";
    
    // 주문 상태 이름.
    public static final String ORD_STATUS_NM_ORDER_APPLY = "주문등록";
    public static final String ORD_STATUS_NM_SENDING_WAIT = "발송대기";
    public static final String ORD_STATUS_NM_SENDING_COMP = "발송완료";
    public static final String ORD_STATUS_NM_CENTER_ARRIVE = "입금대기";
    public static final String ORD_STATUS_NM_PAYMENT_COMP = "결제완료";
    public static final String ORD_STATUS_NM_PAYMENT_WAIT = "결제대기";
    public static final String ORD_STATUS_NM_PAYMENT_FAIL = "결제실패";
    public static final String ORD_STATUS_NM_STOCK_COMP = "입고완료";
    public static final String ORD_STATUS_NM_WAREHOUSE = "창고보관";
    public static final String ORD_STATUS_NM_SHIP_HOLD = "출고대기";
    public static final String ORD_STATUS_NM_INSPECTION_COMP = "검수완료";
    public static final String ORD_STATUS_NM_INSPECTION_CANCEL = "검수취소";
    public static final String ORD_STATUS_NM_WAITING_FOR_SHIPMENT = "선적대기";
    public static final String ORD_STATUS_NM_SHIP_COMP = "출고완료";
    public static final String ORD_STATUS_NM_ETD = "인천공항출발(예정)";
    public static final String ORD_STATUS_NM_ETD_COMP = "인천공항출발(완료)";
    public static final String ORD_STATUS_NM_ETA = "해외공항도착(예정)";
    public static final String ORD_STATUS_NM_ETA_COMP = "해외공항도착(완료)";
    public static final String ORD_STATUS_NM_CC_WAIT = "수입국통관대기";
    public static final String ORD_STATUS_NM_CC_COMP = "수입국통관완료";
    public static final String ORD_STATUS_NM_DELIVERY_START = "수입국배송시작";
    public static final String ORD_STATUS_NM_DELIVERING = "수입국배송중";
    public static final String ORD_STATUS_NM_DELIVERY_COMP = "수입국배송완료";
    public static final String ORD_STATUS_NM_API_FAIL = "API오류";
    public static final String ORD_STATUS_NM_ORDER_CANCEL = "주문취소";
    public static final String ORD_STATUS_NM_PENDING = "수입국배송대기";
    public static final String ORD_STATUS_NM_UNDELIVERED = "발송보류";
    public static final String ORD_STATUS_NM_DEPOSIT_CANCEL = "입금취소";
    public static final String ORD_STATUS_NM_STOCK_CANCEL = "입고취소";

    // 주문 상태 영문 이름.
    public static final String ORD_STATUS_EN_NM_ORDER_APPLY = "register order";
    public static final String ORD_STATUS_EN_NM_SENDING_WAIT = "delivery standby";
    public static final String ORD_STATUS_EN_NM_SENDING_COMP = "delivery completed";
    public static final String ORD_STATUS_EN_NM_CENTER_ARRIVE = "deposit standby";
    public static final String ORD_STATUS_EN_NM_PAYMENT_COMP = "payment completed";
    public static final String ORD_STATUS_EN_NM_PAYMENT_WAIT = "payment standby";
    public static final String ORD_STATUS_EN_NM_PAYMENT_FAIL = "payment failed";
    public static final String ORD_STATUS_EN_NM_STOCK_COMP = "receiving completed";
    public static final String ORD_STATUS_EN_NM_WAREHOUSE = "storage";
    public static final String ORD_STATUS_EN_NM_SHIP_HOLD = "release standby";
    public static final String ORD_STATUS_EN_NM_INSPECTION_COMP = "inspection complete";
    public static final String ORD_STATUS_EN_NM_INSPECTION_CANCEL = "inspection cancel";
    public static final String ORD_STATUS_EN_NM_WAITING_FOR_SHIPMENT = "waiting for shipment";
    public static final String ORD_STATUS_EN_NM_SHIP_COMP = "release completed";
    public static final String ORD_STATUS_EN_NM_ETD = "incheon airport departure (scheduled)";
    public static final String ORD_STATUS_EN_NM_ETD_COMP = "incheon airport departure (completed)";
    public static final String ORD_STATUS_EN_NM_ETA = "overseas airport arrival (scheduled)";
    public static final String ORD_STATUS_EN_NM_ETA_COMP = "overseas airport arrival (completed)";
    public static final String ORD_STATUS_EN_NM_CC_WAIT = "import customs clearance standby";
    public static final String ORD_STATUS_EN_NM_CC_COMP = "import customs clearance completed";
    public static final String ORD_STATUS_EN_NM_DELIVERY_START = "import country delivery initiated";
    public static final String ORD_STATUS_EN_NM_DELIVERING = "import country delivery in progress";
    public static final String ORD_STATUS_EN_NM_DELIVERY_COMP = "import country delivery completed";
    public static final String ORD_STATUS_EN_NM_API_FAIL = "api error";
    public static final String ORD_STATUS_EN_NM_ORDER_CANCEL = "cancel order";
    public static final String ORD_STATUS_EN_NM_PENDING = "import country delivery standby";
    public static final String ORD_STATUS_EN_NM_UNDELIVERED = "delivery pending";
    public static final String ORD_STATUS_EN_NM_DEPOSIT_CANCEL = "cancel deposit";
    public static final String ORD_STATUS_EN_NM_STOCK_CANCEL = "cancel receiving";

    // 입고이벤트 코드 배송타입 변경
    public static final String EVENT_CONVERT = "CONVERT";
    // 입고이벤트 코드 입고 저장
    public static final String EVENT_STOCK_SAVE = "SAVE";
    // 입고이벤트 코드 입고 취소
    public static final String EVENT_STOCK_CANCEL = "CANCEL";
    // 입고이벤트 코드 건별결제 취소(입금대기 또는 입금확인상태에서의 취소)
    public static final String EVENT_PAYMENT_CANCEL = "DEPOSIT CANCEL";
    // 입고이벤트 코드 건별결제 저장(대기)
    public static final String EVENT_PAYMENT_SAVE = "DEPOSIT WAITING";
    // 입고이벤트 코드 건별결제 입금완료
    public static final String EVENT_AMOUNT_SAVE = "DEPOSIT COMPLETED";
    // 입고이벤트 코드 송장출력
    public static final String EVENT_STOCK_INVC_PRINT = "PRINT";

    // 무게측정값저장 파일
    public static final String WGT_FILE_PATH = "c:/logifocus/variable.txt";

    public static final String SETTLE_BANK_LOG_PATH = "/home/ec2-user/xroute/logs/settleBank/";
    // 승인FLG : 승인완료
    public static final String APPROVAL_FLG_COMP = "2";

    public static final String EFS_API_COUNTRY = "EFS_API_COUNTRY";

    // SettleBank PASS_BOOK 설정정보
    public static final String PASS_BOOK_HD_INFO = "IA_AUTHPAGE _1.0_1.0";
    public static final String PASS_BOOK_AP_VER = "1.0";
    public static final String PASS_BOOK_PROCESS_TYPE = "D";
    // Settle Bank 상점 아이디
    public static final String PASS_BOOK_DEV_MERCNT_ID = "M2112733";
    public static final String PASS_BOOK_REAL_MERCNT_ID = "M2112390";

    public static final String PASS_BOOK_DEV_ENCRYPT_KEY = "SETTLEBANKISGOODSETTLEBANKISGOOD";
    public static final String PASS_BOOK_REAL_ENCRYPT_KEY = "GJAGTJHTEOUBNOJDVBHAEFBNJGNDVFWO";

    public static final String PASS_BOOK_DEV_CALLBACK_URL = "https://tx.logifocus.co.kr/sys/passBook/callBack.do";
    public static final String PASS_BOOK_REAL_CALLBACK_URL = "https://xroute.logifocus.co.kr/sys/passBook/callBack.do";

    public static final String PASS_BOOK_DEV_APPROV_URL = "https://tbezauthapi.settlebank.co.kr/APIPayApprov.do";
    public static final String PASS_BOOK_REAL_APPROV_URL = "https://ezauthapi.settlebank.co.kr:8081/APIPayApprov.do";

    public static final String PASS_BOOK_DEV_REGULAR_URL = "https://tbezauthapi.settlebank.co.kr/APIRegularPayment.do";
    public static final String PASS_BOOK_REAL_REGULAR_URL = "https://ezauthapi.settlebank.co.kr:8081/APIRegularPayment.do";
    
    public static final String PASS_BOOK_DEV_CANCEL_URL = "https://tbezauthapi.settlebank.co.kr/APIPayCancel.do";
    public static final String PASS_BOOK_REAL_CANCEL_URL = "https://ezauthapi.settlebank.co.kr:8081/APIPayCancel.do";

    public static final String PASS_BOOK_DEV_REGULAR_CANCEL_URL = "https://tbezauthapi.settlebank.co.kr/APIUnRegistRegular.do";
    public static final String PASS_BOOK_REAL_REGULAR_CANCEL_URL = "https://ezauthapi.settlebank.co.kr:8081/APIUnRegistRegular.do";

    public static final String ATOMY_DEV_URL = "https://test-dev.atomy.com";
    public static final String ATOMY_REAL_URL = "https://api.atomy.com"; // http://global-scm-api.atomy.com

    public static final String ATOMY_DEV_API_TOKEN = "4bb8a5af2fe14870bfd362b60483ec80";
    public static final String ATOMY_REAL_API_TOKEN = "4bb8a5af2fe14870bfd362b60483ec80";

    public static final String ATOMY_DEV_API_USER_TOKEN = "eyJJc1ZhbGlkIjp0cnVlLCJKaXNhQ29kZSI6MSwiVXNlckNvZGUiOiIwMDAwMyIsIklzRXhwaXJlZCI6ZmFsc2UsIlVzZXJJZCI6IjciLCJVc2VyTmFtZSI6IuusvOulmCJ9";
    public static final String ATOMY_REAL_API_USER_TOKEN = "eyJJc1ZhbGlkIjp0cnVlLCJKaXNhQ29kZSI6MSwiVXNlckNvZGUiOiIwMDAwMyIsIklzRXhwaXJlZCI6ZmFsc2UsIlVzZXJJZCI6IjciLCJVc2VyTmFtZSI6IuusvOulmCJ9";
    
    public static final String ATOMY_DEV_ORGCD = "M00164";
    public static final String ATOMY_REAL_ORGCD = "M00494";
    
    public static final String ATOMY_DEV_WHCD = "WH0157";
    public static final String ATOMY_REAL_WHCD = "WH0495";
    
    public static final String ATOMY_USERCD = "ATOMY";
    
    public static final String UNIPASS_URL = "https://unipass.customs.go.kr:38010/ext/rest/expDclrNoPrExpFfmnBrkdQry/retrieveExpDclrNoPrExpFfmnBrkd";
    public static final String UNIPASS_CRKYCN = "u240g211l067e045b040b070x0";
}
