package xrt.lingoframework.utils;

import org.springframework.stereotype.Component;

/**
 * 소스에서 쓰이는 상수값 정의
 */
@Component
public class Constants {
	//빈 문자열
	public static final String EMPTY_STRING = "";
	//METHOD_ID
	public static final String METHOD_ID = "METHOD_ID";
	//AJAX
	public static final String AJAX = "AJAX";

	public static final String ENCRYPTION_PW_KEY = "LINGOENCPWKEY";

	//공지사항 첨부파일 경로
	public static String NOTICE_FILEPATH = "/upfile/noticeFiles";
	public static String NOTICE_IMAGEPATH = "/upfile/noticeImg";

	// 상품 첨부파일 경로
	public static String ITEM_IMAGEPATH = "/upfile/itemImg";

	// 셀러 사업자등록증 첨부파일(상대경로 - was webRoot )
	public static String SELLER_FILEPATH = "/upfile/sellerFiles";

	// 셀러 사업자등록증 첨부파일(절대경로 - was webRoot 외부 디렉토리)
	public static String SELLER_ABSOLUTE_FILE_PATH = "/home/ec2-user/xroute/filepath/upfile/sellerFiles";
	
	// 주문 배송 조회, 메모 첨부 파일
	public static String MEMO_FILE_PATH = "/home/ec2-user/xroute/filepath/upfile/memoFiles";
}

