package xrt.fulfillment.seller.sellertally;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;

/**
 * 입고스캔
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/seller/sellerTally")
public class SellerTallyController {

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private SellerTallyBiz biz;

	Logger logger = LoggerFactory.getLogger(SellerTallyController.class);

	// 화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		String SELLER_ADMIN = CommonConst.SELLER_ADMIN;
		
		// 권한
		model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
		return "fulfillment/seller/sellertally/SellerTally";
	}

	/**
	 * XROUTE송장 검색
	 * 
	 * @param request
	 * @param reqData
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getSearch(HttpServletRequest request, @RequestBody LReqData reqData)
			throws Exception {

		LDataMap paramData = reqData.getParamDataMap("paramData");

		// HttpSession session = request.getSession();
		// LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");

		List<LDataMap> resultList = new ArrayList<LDataMap>();
		List<LDataMap> resultListDtl = new ArrayList<LDataMap>();

		// 주문마스터 검색
		LDataMap resultData = biz.getSearch(paramData);
		LRespData respData = new LRespData();

		// 주문상품정보검색
		// DEL_YN = 'N'인경우, 검색가능
		if (!Util.isEmpty(resultData)) {

			if ("Y".equals(resultData.get("DEL_FLG"))) {
				throw new LingoException("이미 삭제된 송장번호 입니다.");
			} else {
				if (resultData.get("TALLY_DATETIME") == null || Util.isEmpty(resultData.get("TALLY_DATETIME"))) {
					paramData.put("COMPCD", resultData.get("COMPCD"));
					paramData.put("ORGCD", resultData.get("ORGCD"));
					paramData.put("WHCD", resultData.get("WHCD"));
					paramData.put("ORD_CD", resultData.get("ORD_CD"));
					paramData.put("LOGIN_USERCD", LoginInfo.getUsercd());
					paramData.put("LOGIN_IP", ClientInfo.getClntIP());

					// tmporderdtl에 ORGCD, ORD_CD가 동일한 것이 있으면 삭제한다.
					biz.setTmpDelete(paramData);
					// 임시테이블에 데이터 등록.
					biz.setTmpOrderDtl(paramData);

					// 검색
					
					resultList = biz.getOrder(paramData);
					resultListDtl = biz.getTmpOrderDtl(paramData);
					respData.put("compFlg", "N");
				} else {
					paramData.put("ORD_CD", resultData.get("ORD_CD"));
					resultList = biz.getOrder(paramData);
					resultListDtl = biz.getTallyGoodsDtl(paramData);
					System.out.println(resultList.toString());
					System.out.println(resultListDtl.toString());
					/*if (resultList.size() == 0) {
						// torderdtl검색
						resultList = biz.getOrderDtl(resultData);
						
					}*/
					logger.debug("이미 검수 처리된 송장입니다.");
					respData.put("compFlg", "Y");
				}
			}
		} else {
			throw new LingoException("존재하지 않는 송장번호 입니다.");
		}

		respData.put("resultList", resultList);
		respData.put("resultListDtl", resultListDtl);
		respData.put("resultData", resultData);

		return respData;
	}

	/**
	 * 상품 바코드 검색
	 * 
	 * @param request
	 * @param reqData
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getGoodsSearch.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getGoodsSearch(HttpServletRequest request, @RequestBody LReqData reqData)
			throws Exception {

		LDataMap paramData = reqData.getParamDataMap("paramData");

		// HttpSession session = request.getSession();
		// LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");

		String goodsBarcode = paramData.get("GOODS_BARCODE").toString();

		if (Util.isEmpty(goodsBarcode)) {
			throw new LingoException("바코드 값이 정확하지 않습니다.");
		}

		List<LDataMap> resultListDtl = new ArrayList<LDataMap>();
		LDataMap goodsResult = new LDataMap();

		paramData.put("ORGCD", paramData.get("ORGCD"));

		// 1. 상품존재체크 (바코드를 가지고 P006검색), TORDERDTL해당하는 상품코드가 맞는지 체크해서 있으면, 2번 실행. 없으면
		// throw
		goodsResult = biz.getGoodsSearch(paramData);

		if (!Util.isEmpty(goodsResult) && goodsResult.size() > 0) {
			int goods_cnt = Integer.parseInt(goodsResult.getString("GOODS_CNT"));
			int scan_cnt = Integer.parseInt(goodsResult.getString("SCAN_CNT"));

			// 2. 스캔수량 1 증가 (TMP_TORDEREDTL)
			if (goods_cnt == scan_cnt) {
				throw new LingoException("해당품목의 스캔수량이 주문수량을 넘었습니다.");
			} else {
				int scanCnt = biz.setScanCnt(paramData);
				if (scanCnt <= 0) {
					throw new LingoException("해당 주문에 존재하지 않는 상품입니다.");
				}
				/*resultList = biz.getTmpOrderDtl(paramData);*/
				resultListDtl = biz.getTmpOrderDtl(paramData);
			}

		} else {
			throw new LingoException("해당 주문에 존재하지 않는 상품입니다.");
		}

		LRespData respData = new LRespData();
		respData.put("resultListDtl", resultListDtl);

		return respData;
	}

	/**
	 * 미스캔품목 수량 맞음
	 * 
	 * @param request
	 * @param reqData
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setMatchCnt.do", method = RequestMethod.POST)
	public @ResponseBody LRespData setMatchCnt(HttpServletRequest request, @RequestBody LReqData reqData)
			throws Exception {

		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> paramList = biz.getTmpOrderDtl(paramData);

		biz.setMatchCnt(paramList);

		List<LDataMap> resultList = new ArrayList<LDataMap>();
		resultList = biz.getTmpOrderDtl(paramData);
		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}

	/**
	 * 검수(출고)완료
	 * 
	 * @param request
	 * @param reqData
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/setTallyComp.do", method = RequestMethod.POST)
	public @ResponseBody LRespData setTallyComp(HttpServletRequest request, @RequestBody LReqData reqData)
			throws Exception {

		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getTmpOrderDtl(paramData);

		boolean checkFlg = false;
		// 1. 부족수량이 있는 경우, 주문수량과 스캔수량이 일치하지 않습니다. 에러
		// 2. 주문수량과 스캔수량이 일치하고, 부족수량이 없는 경우,
		// 재고테이블의 재고수량을 확인. 주문수량을 차감할 재고가 있는 경우, 3을 진행. 없으면 재고 부족 에러.

		// 3. 재고테이블의 재고수량을 수정
		// 재고 수량 = 재고수량 - 주문수량, ORD_CD등록
		// 4. TORDER테이블의 출고일자, 검수user ID를 갱신한다.
		// 검수완료처리를 한후, 화면을 초기화한다.

		LDataMap paramMap = new LDataMap();

		// 오늘날짜
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Calendar date = Calendar.getInstance();
		String toDate = format.format(date.getTime());
		// 출고번호 채번
		biz.getSeq(paramMap);
		String WIKEY = paramMap.getString("MSG");

		for (int i = 0; i < resultList.size(); i++) {
			LDataMap imap = resultList.get(i);
			System.out.println(imap.toString());
			// 2. 주문수량과 스캔수량이 일치하고, 부족수량이 없는 경우,
			if (imap.getString("SCAN_CNT").equals(imap.getString("GOODS_CNT"))
					&& "0".equals(imap.getString("LACK_CNT"))) {
				// 3. 재고테이블의 재고수량을 수정
				// 재고 수량 = 재고수량 - 주문수량
				paramMap = new LDataMap();
				paramMap.put("DATE", toDate);
				paramMap.put("WIKEY", WIKEY);
				paramMap.put("COMPCD", LoginInfo.getCompcd());
				paramMap.put("ORGCD", imap.getString("ORGCD"));
				paramMap.put("ORD_CD", imap.getString("ORD_CD"));
				paramMap.put("WHCD", imap.getString("WHCD"));
				paramMap.put("GOODS_CD", imap.getString("GOODS_CD"));
				paramMap.put("LOGIN_USERCD", LoginInfo.getUsercd());
				paramMap.put("LOGIN_IP", ClientInfo.getClntIP());
				paramMap.put("OUT_VALUE", "");
				paramMap.put("MSGID", "");
				paramMap.put("MSG", "");

				// 상품코드가 있는 경우
				if (!Util.isEmpty(imap.getString("GOODS_CD"))) {

					// 재고 수량
					String qty = biz.getInventoryQty(paramMap);
					// 주문 수량
					String orderCnt = imap.getString("GOODS_CNT");

					if (!Util.isEmpty(qty)) {
						paramMap.put("BEFOREQTY", qty);
						paramMap.put("AFTERQTY", Integer.parseInt(qty) - Integer.parseInt(orderCnt));

						if (0 < Integer.parseInt(qty) && Integer.parseInt(orderCnt) <= Integer.parseInt(qty)) {
							// 재고 차감
							paramMap.put("UPD_QTY", orderCnt);

							int updCnt = biz.updInventoryQty(paramMap);
							if (updCnt <= 0) {
								checkFlg = false;
								throw new LingoException("재고갱신 처리중 이상이 발생해서, 검수완료처리를 중지합니다.");
							} else {
								// torder의 검수날짜, 검수ID갱신
								checkFlg = true;

								// 재고차감 이력
								biz.insertInventoryHistory(paramMap);
							}
						} else {
							// 현재 재고가 부족한 경우
							checkFlg = false;
							throw new LingoException(imap.getString("GOODS_CD") + "의 재고가 부족합니다.");
						}
					} else {
						// 입고등록 수량이 없는 경우
						checkFlg = false;
						throw new LingoException(imap.getString("GOODS_CD") + "의 입고등록을 한후, 상품 검수처리를 해주세요.");
					}
				} else {
					checkFlg = true;
				}

			} else {
				checkFlg = false;
				throw new LingoException("미스캔 품목이 존재함으로, 검수완료처리를 중지합니다.");
			}
		}

		if (checkFlg) {
			// 4. TORDER테이블의 출고일자, 검수user ID를 갱신한다.
			// 검수완료처리를 한후, 화면을 초기화한다.
			int tallyInsert = biz.setTallyComp(paramData);
			if(tallyInsert > 0 ) {
				biz.setTallyGoodsInsert(paramData);
			}
		}

		LRespData respData = new LRespData();
		LDataMap resultData = biz.getTallySearch(paramData);
		respData.put("resultData", resultData);

		return respData;

	}

}
