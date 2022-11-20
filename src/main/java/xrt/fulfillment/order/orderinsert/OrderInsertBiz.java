package xrt.fulfillment.order.orderinsert;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.thoughtworks.xstream.XStream;

import xrt.alexcloud.api.aftership.AfterShipAPI;
import xrt.alexcloud.api.aftership.vo.AfterShipTrackingVo;
import xrt.alexcloud.api.efs.EfsAPI;
import xrt.alexcloud.api.efs.vo.EfsShipmentVo;
import xrt.alexcloud.api.etomars.EtomarsAPI;
import xrt.alexcloud.api.etomars.vo.EtomarsOrderDtlVo;
import xrt.alexcloud.api.etomars.vo.EtomarsShipmentVo;
import xrt.alexcloud.api.tolos.TolosAPI;
import xrt.alexcloud.api.tolos.vo.TolosOrderVo;
import xrt.alexcloud.api.tolos.vo.TolosShipmentVo;
import xrt.alexcloud.common.CommonConst;
import xrt.interfaces.common.vo.EfsOrderDtlVo;
import xrt.interfaces.qxpress.QxpressAPI;
import xrt.interfaces.qxpress.vo.QxpressVo;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataList;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.MapEntryConverter;
import xrt.lingoframework.utils.Util;

/**
 * 오더등록biz
 *
 * @author jy.hong
 *
 */
@Service
public class OrderInsertBiz extends DefaultBiz {

    @Resource
    TolosAPI tolosAPI;

    @Resource
    EfsAPI efsAPI;

    @Resource
    EtomarsAPI etomarsAPI;

    @Resource
    AfterShipAPI afterShipAPI;

    @Resource
    QxpressAPI qxpress;

    Logger logger = LoggerFactory.getLogger(OrderInsertBiz.class);

    public List<LDataMap> getSiteHeader(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getSiteHeader", param);
    }

    /**
     * @methodname 엑셀 에러체크*
     * @param param,
     * @param paramList,
     * @param codeCOUNTRY_CD,
     * @param codeCURRENCY_CODE,
     * @param codeMAINCOUNTRY_CODE,
     * @param newStateList,
     * @param deliveryTypeList
     * @return JSON
     * @throws Exception
     */
    public List<LDataMap> setCheck(LDataMap param, List<LDataMap> paramList, List<CodeVO> codeCOUNTRY_CD, List<CodeVO> codeCURRENCY_CODE, List<CodeVO> codeMAINCOUNTRY_CODE, List<CodeVO> newStateList,
            List<CodeVO> deliveryTypeList, List<CodeVO> apiTargetCountry, Map<String, Object> paramMap) throws Exception {
        // 기등록 데이터 삭제 처리
        dao.delete("OrderInsertMapper.delete", param);

        // param.put("COMPCD", xml);

        // 주문접수양식
        List<LDataMap> checkList = dao.select("OrderInsertMapper.getCheckList", param);

        if (checkList == null || checkList.size() == 0) {
            throw new LingoException("주문서 양식이 존재하지 않습니다.");
        }

        XStream xs = new XStream();

        xs.registerConverter(new MapEntryConverter());
        xs.alias("root", LDataList.class);

        // Security설정
        XStream.setupDefaultSecurity(xs);
        xs.allowTypesByRegExp(new String[] { ".*" });

        String xml = xs.toXML(paramList);

        param.put("MSGID", "");
        param.put("MSG", "");
        param.put("XML", xml);

        if (Util.isEmpty(param.get("COMPCD"))) {
            logger.debug("compcd null");
        } else {
            logger.debug("compcd:" + param.get("COMPCD"));
        }

        ArrayList list = (ArrayList) xs.fromXML(xml);

        // 동일한 장바구니번호에 해당하는 수취인명과 수취인주소가 일치한지를 체크함
        checkCartNo(list);

        List<LDataMap> checkOrderNoList = existOrderNo(list, param);
        List<LDataMap> checkCartNoList = existCartNo(list, param);
        StringBuffer tmpOrderNoSb = new StringBuffer();
        StringBuffer tmpCartNoSb = new StringBuffer();
        boolean orderFlg = false;
        boolean cartFlg = false;    

        // 입력한 주문번호에 해당하는 오더가 DB에 있는지 존재체크
        if (checkOrderNoList != null && checkOrderNoList.size() > 0) {
            for (int i = 0; i < checkOrderNoList.size(); i++) {
                LDataMap orderListMap = new LDataMap(checkOrderNoList.get(i));

                if (!Util.isEmpty(orderListMap.get("ORD_NO"))) {
                    if (orderFlg) {
                        tmpOrderNoSb.append(", ");
                    }
                    tmpOrderNoSb.append(orderListMap.get("ORD_NO"));
                    orderFlg = true;
                }
            }
            if (!"".equals(tmpOrderNoSb.toString().trim())) {
                throw new LingoException("주문번호 : " + tmpOrderNoSb.toString() + "은 이미 등록된 주문번호입니다.");
            }
        }

        // 입력한 장바구니번호에 해당하는 오더가 DB에 있는지 존재체크
        if (checkCartNoList != null && checkCartNoList.size() > 0) {
            for (int i = 0; i < checkCartNoList.size(); i++) {
                LDataMap cartListMap = new LDataMap(checkCartNoList.get(i));

                if (!Util.isEmpty(cartListMap.get("CART_NO"))) {
                    if (cartFlg) {
                        tmpCartNoSb.append(", ");
                    }
                    tmpCartNoSb.append(cartListMap.get("CART_NO"));
                    cartFlg = true;
                }
            }
            if (!"".equals(tmpCartNoSb.toString().trim())) {
                throw new LingoException("장바구니번호 : " + tmpCartNoSb.toString() + "은 이미 등록된 장바구니번호입니다.");
            }
        }

        // 국가코드
        List<String> countryList = convertCdList(codeCOUNTRY_CD);
        // 주요국가코드
        List<String> mainCountrylist = convertCdList(codeMAINCOUNTRY_CODE);
        // 통화코드
        Map<String, String> currencyMap = convertMapList(codeCURRENCY_CODE);

        // 국가코드, 통화코드 체크, 배송타입 체크
        // 수취인 도착국가 = 미국인 경우, 주가 입력되어있는지 체크.
        checkOrderDatay(list, countryList, currencyMap, mainCountrylist, newStateList, paramMap);

        dao.select("OrderInsertMapper.uploadXml", param);

        if (!"1".equals(param.getString("MSGID"))) {
            throw new LingoException(param.getString("MSG"));
        }

        param.put("CHECKLIST", checkList);
        return dao.select("OrderInsertMapper.getOrderFileCheckList", param);
    }

    /**
     * @methodname 주문서저장
     *
     * @param param
     * @return JSON
     * @throws Exception
     */
    public LDataMap setUpload(LDataMap param) throws Exception {

        param.put("MSGID", "");
        param.put("MSG", "");
        dao.select("OrderInsertMapper.upload", param);

        if (!"1".equals(param.getString("MSGID"))) {
            throw new LingoException(param.getString("MSG"));
        }

        return param;
    }

    // 병합
    public List<LDataMap> getSiteColEdit1(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getSiteColEdit1", param);
    }

    // 치환
    public List<LDataMap> getSiteColEdit2(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getSiteColEdit2", param);
    }

    // 양식명 SEELCTBOX
    public List<LDataMap> getSiteCd(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getSiteCd", param);
    }

    /**
     * 입력한 장바구니번호에 해당하는 오더가 DB에 있는지 존재체크
     *
     * @param list
     * @param param
     * @throws Exception
     */
    public List<LDataMap> existCartNo(ArrayList list, LDataMap param) throws Exception {

        List<String> cartNoList = null;
        boolean flag = true;
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> listMap = (HashMap<String, String>) list.get(i);

            if (listMap.containsKey("C03")) {
                if (!"".equals(listMap.get("C03").trim()) && listMap.get("C03") != null) {
                    if (flag) {
                        cartNoList = new ArrayList<String>();
                        flag = false;
                    }
                    cartNoList.add(Util.getStrTrim(listMap.get("C03")));
                }
            }
        }

        if (!Util.isEmpty(cartNoList)) {
            param.put("CARTNOLIST", cartNoList);
            return dao.select("OrderInsertMapper.getSearchCartNo", param);
        } else {
            List<LDataMap> resultList = null;
            return resultList;

        }
    }

    /**
     * 입력한 주문번호에 해당하는 오더가 DB에 있는지 존재체크
     *
     * @param list
     * @param param
     * @throws Exception
     */
    public List<LDataMap> existOrderNo(ArrayList list, LDataMap param) throws Exception {

        List<String> orderNoList = null;
        boolean flag = true;
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> listMap = (HashMap<String, String>) list.get(i);

            if (listMap.containsKey("C02")) {
                if (!"".equals(listMap.get("C02").trim()) && listMap.get("C02") != null) {
                    if (flag) {
                        orderNoList = new ArrayList<String>();
                        flag = false;
                    }
                    orderNoList.add(Util.getStrTrim(listMap.get("C02")));
                }
            }
        }

        if (!Util.isEmpty(orderNoList)) {
            param.put("ORDERNOLIST", orderNoList);
            return dao.select("OrderInsertMapper.getSearchOrdNo", param);
        } else {
            List<LDataMap> resultList = null;
            return resultList;

        }
    }

    /**
     * 입력한 값을 체크 (국가코드, 통화코드)
     *
     * @param list
     * @param countryList
     * @param currencyMap
     * @param mainCountrylist
     * @param newStateList
     * @param deliveryTypeList
     * @throws Exception
     */
    public void checkOrderDatay(ArrayList list, List countryList, Map currencyMap, List mainCountrylist, List newStateList, Map<String, Object> paramMap) throws Exception {

        List<String> stateList = convertCdList(newStateList);
        List<CodeVO> codeDhlNation = (List<CodeVO>) paramMap.get("dhlNation");
        List<CodeVO> codeUpsNation = (List<CodeVO>) paramMap.get("upsNation");
        List<String> dhlNation = convertCdList(codeDhlNation);
        List<String> upsNation = convertCdList(codeUpsNation);

        // 패턴
        String pattern1 = "^[a-zA-Z0-9 ]+$";
        String pattern2 = "^[a-zA-Z0-9 ~!@#$%^&*()_+-=`]+$";
        String urlPattern = "^(http|https?):\\/\\/([^:\\/\\s]+)(:([^\\/]*))?((\\/[^\\s/\\/]+)*)?\\/?([^#\\s\\?]*)(\\?([^#\\s]*))?(#(\\w*))?$";
        
        // 2019.11.21 hjy 2019년 12월 추가개발 수정 start
        // 국가코드 (C24), 국가통화코드(C25), 주(C22), 배송타입(C06)
        // 통화코드 체크 : 대표적인 국가에 대해 체크함.
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> listMap = (HashMap<String, String>) list.get(i);

            // C01 판매자 쇼핑몰명
            if (Util.isEmpty(listMap.get("C01"))) {
                throw new LingoException("판매자 쇼핑몰명을 입력해주세요.");
            }
            // C02 판매자 주문번호
            if (Util.isEmpty(listMap.get("C02"))) {
                throw new LingoException("판매자 주문번호를 입력해주세요.");
            }
            // C06 물품배송방식
            if (Util.isEmpty(listMap.get("C06"))) {
                throw new LingoException("물품 배송방식을 입력해주세요.");
            }
            
            // 셀러 물품배송방식 체크.
            if (listMap.get("C06").equals("DHL") || listMap.get("C06").equals("dhl")) {
                throw new LingoException("물품 배송방식은 PREMIUM과 UPS로 이용 가능합니다.");
            }
            
            // C08 상품명
            if (Util.isEmpty(listMap.get("C08"))) {
                throw new LingoException("상품명을 입력해주세요.");
            }
            // C09 상품수량
            if (Util.isEmpty(listMap.get("C09"))) {
                throw new LingoException("상품수량을 입력해주세요.");
            }
            // C11 송화인명
            if (Util.isEmpty(listMap.get("C11"))) {
                throw new LingoException("송화인명을 입력해주세요.");
            }
            // C12 송화인 전화번호
            if (Util.isEmpty(listMap.get("C12"))) {
                throw new LingoException("송화인 전화번호를 입력해주세요.");
            }
            // C14 송화인 주소
            if (Util.isEmpty(listMap.get("C14"))) {
                throw new LingoException("송화인 주소를 입력해주세요.");
            } else if (listMap.get("C14").length() < 10) {
                throw new LingoException("주문번호 " + listMap.get("C02") + "의 송화인 주소가 너무 짧습니다. 10자리 이상 입력해주세요");
            }
            // C16 수취인명
            if (Util.isEmpty(listMap.get("C16"))) {
                throw new LingoException("수취인명을 입력해주세요.");
            }
            // C17 수취인 전화번호
            if (Util.isEmpty(listMap.get("C17"))) {
                throw new LingoException("수취인 전화번호을 입력해주세요.");
            }
            // C19 수취인 주소1
            if (Util.isEmpty(listMap.get("C19"))) {
                throw new LingoException("수취인 주소1을 입력해주세요.");
            }
            // C20 수취인 주소2
            if (Util.isEmpty(listMap.get("C20"))) {
                throw new LingoException("수취인 주소2를 입력해주세요.");
            }

            int recvAddr1 = listMap.get("C19").length(); // 수취인 주소1 글자수
            int recvAddr2 = listMap.get("C20").length(); // 수취인 주소2 글자수

            if ((recvAddr1 + recvAddr2) < 10) {
                throw new LingoException("주문번호 " + listMap.get("C02") + "의 수취인 주소1,2의 길이가 너무 짧습니다. \n 합쳐서 10자리 이상 입력해주세요");
            }

            // C23 수취인 우편번호
            if (Util.isEmpty(listMap.get("C23"))) {
                throw new LingoException("수취인 우편번호를 입력해주세요.");
            }
            // C26 결제금액
            if (Util.isEmpty(listMap.get("C26"))) {
                throw new LingoException("결제금액을 입력해주세요.");
            }
            
            if (!listMap.get("C26").matches("\\d+\\.?\\d*")) {
                throw new LingoException("결제금액은 정수와 소수만 입력해주세요.");
            }
            
            // 수취국가코드 입력여부 체크
            if (Util.isEmpty(listMap.get("C24"))) {
                throw new LingoException("수취인 국가를 입력해주세요.");
            }
            
            String countryCd = Util.getStrTrim(listMap.get("C24").toUpperCase());
            // 국가코드 체크
            if (!countryList.contains(countryCd)) {
                throw new LingoException("입력한 주문번호 : " + listMap.get("C02") + "의 국가코드'" + countryCd + "'가 올바르지 않습니다.");
            }
            // 입력한 통화코드로 국가코드를 취득. (주요국가)
            if (Util.isEmpty(listMap.get("C25"))) {
                throw new LingoException("수취인 통화를 입력해주세요.");
            }

            if (listMap.get("C06").equals(CommonConst.SHIP_METHOD_UPS)) {
                if (!listMap.get("C25").equals("USD")) {
                    throw new LingoException("주문배송 방식이 UPS인 주문번호 : " + listMap.get("C02") + "의 통화코드는 USD로 입력하셔야 합니다.'");
                }
            } else {
                // 국가코드가 주요국가인 경우,
                if (mainCountrylist.contains(countryCd)) {

                    String countryNm = (String) currencyMap.get(Util.getStrTrim(listMap.get("C25").toUpperCase()));
                    countryNm = Util.getStrTrim(countryNm);

                    // 입력한 국가코드가 통화코드와 일치하는 지를 체크
                    if (!countryCd.equals(countryNm)) {
                        throw new LingoException("입력한 주문번호 : " + listMap.get("C02") + "의 통화코드'" + listMap.get("C25") + "'가 올바르지 않습니다.");
                    }
                }
            }

            // 국가코드가 미국인 경우, 주(State)를 입력했는지를 체크
            switch (countryCd) {
                case "US":
                    break;
                case "TW":
                    if (Util.isEmpty(listMap.get("C28"))) {
                        throw new LingoException("개인통관고유번호를 입력하세요.");
                    }
                default:
                    if (Util.isEmpty(listMap.get("C27"))) {
                        throw new LingoException("구매URL를 입력해 주세요.");
                    }

                    if (!listMap.get("C27").matches(urlPattern)) {
                        throw new LingoException("URL 양식이 아닙니다.");
                    }
                    break;
            }

            String shipName = listMap.get("C11"); // 송화인이름
            String shipAddr = listMap.get("C14"); // 송화인주소
            String recvName = listMap.get("C16"); // 수취인이름
            String recvAddr = listMap.get("C19") + " " + listMap.get("C20"); // 수취인주소
            String goodsNm = listMap.get("C08"); // 상품명
            String goodsOption = listMap.get("C10"); // 상품옵션

            String shipMethodCd = Util.getStrTrim(listMap.get("C06").toUpperCase());
            switch (shipMethodCd) {
                case CommonConst.SHIP_METHOD_PREMIUM:
                    
                    // 프리미엄 배송 가능 국가 확인.
                    if (!countryCd.equals("US") && !countryCd.equals("JP") && !countryCd.equals("HK") && !countryCd.equals("MY") && !countryCd.equals("SG") && !countryCd.equals("TW")) {
                        throw new LingoException("프리미엄 배송 국가가 아닙니다.");
                    }

                    // 국가코드가 미국인 경우, 주(State)를 입력했는지를 체크
                    if ("US".equals(countryCd)) {
                        // 주의 입력값을 공백을 제거하고 확인, 대문자
                        if (Util.isEmpty(listMap.get("C22"))) {
                            throw new LingoException("도착국가가 미국인 경우에는 주(State)의 입력이 필수입니다.");
                        }
                        String strState = Util.getStrTrim(listMap.get("C22").toUpperCase());
                        if (!stateList.contains(strState)) {
                            throw new LingoException("주(State)의 입력된 값이 올바르지 않습니다.");
                        }
                    }

                    if ("JP1".equals(countryCd)) {
                        String postNum = listMap.get("C23");
                        if (!shipName.matches(pattern1)) {
                            throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 송화인명 (" + shipName + ")은 영문으로 입력하여야 합니다.");
                        }
                        if (!shipAddr.matches(pattern2)) {
                            throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 송화인주소 (" + shipAddr + ")는 영문으로 입력하여야 합니다.");
                        }
                        if (!recvName.matches(pattern1)) {
                            throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 수취인명 (" + recvName + ")은 영문으로 입력하여야 합니다.");
                        }
                        if (!recvAddr.matches(pattern2)) {
                            throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 수취인주소 (" + recvAddr + ")는 영문으로 입력하여야 합니다.");
                        }
                        if (!goodsNm.matches(pattern2)) {
                            throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 상품명 (" + goodsNm + ")은 영문으로 입력하여야 합니다.");
                        }
                        if (!Util.isEmpty(goodsOption)) {
                            if (!goodsOption.matches(pattern2)) {
                                throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 상품옵션 (" + goodsOption + ")은 영문으로 입력하여야 합니다.");
                            }
                        }
                        if (!Util.isEmpty(postNum)) {
                            if (postNum.length() != 7) {
                                throw new LingoException("수취국가가 일본인 경우, 수취인 우편번호의 글자수는 7글자 입니다.");
                            }
                        }
                    }

                    if ("HK1".equals(countryCd)) {
                        if (!goodsNm.matches(pattern2)) {
                            throw new LingoException("수취국가가 홍콩이고 배송타입이 PREMIUM인 경우, 상품명 (" + goodsNm + ")은 영문으로 입력하여야 합니다.");
                        }
                        if (!Util.isEmpty(goodsOption)) {
                            if (!goodsOption.matches(pattern2)) {
                                throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 상품옵션 (" + goodsOption + ")은 영문으로 입력하여야 합니다.");
                            }
                        }
                    }

                    if ("SG1".equals(countryCd)) {
                        if (!goodsNm.matches(pattern2)) {
                            throw new LingoException("수취국가가 싱가포르이고 배송타입이 PREMIUM인 경우, 상품명 (" + goodsNm + ")은 영문으로 입력하여야 합니다.");
                        }
                        if (!Util.isEmpty(goodsOption)) {
                            if (!goodsOption.matches(pattern2)) {
                                throw new LingoException("수취국가가 일본이고 배송타입이 PREMIUM인 경우, 상품옵션 (" + goodsOption + ")은 영문으로 입력하여야 합니다.");
                            }
                        }
                    }
                    break;

                  // 20210716부터 DHL 중지. UPS로 전환.
/*                case CommonConst.SHIP_METHOD_DHL:
                    // C01 판매자 쇼핑몰명
                    if (Util.isEmpty(listMap.get("C01"))) {
                        throw new LingoException("배송타입이 DHL인 경우, 판매자 쇼핑몰명을 입력해주세요.");
                    }

                    if (!listMap.get("C01").matches(pattern1)) {
                        throw new LingoException("배송타입이 DHL인 경우, 판매자 쇼핑몰명(" + listMap.get("C01") + ")은 영문 및 숫자로 입력하여야 합니다.");
                    }
                    if (!dhlNation.contains(countryCd)) {
                        throw new LingoException("입력한 주문번호 : " + listMap.get("C02") + "의 배송타입이 올바르지 않습니다. 해당 도착국가는 DHL 배송타입 대상이 아닙니다.");
                    }
                    break;*/
                
                case CommonConst.SHIP_METHOD_UPS:
                    if (Util.isEmpty(listMap.get("C01"))) {
                        throw new LingoException("배송타입이 UPS인 경우, 판매자 쇼핑몰명을 입력해주세요.");
                    }

                    if (!listMap.get("C01").matches(pattern1)) {
                        throw new LingoException("배송타입이 UPS인 경우, 판매자 쇼핑몰명(" + listMap.get("C01") + ")은 영문 및 숫자로 입력하여야 합니다.");
                    }
                    if (!upsNation.contains(countryCd)) {
                        throw new LingoException("입력한 주문번호 : " + listMap.get("C02") + "의 배송타입이 올바르지 않습니다. 해당 도착국가는 UPS 배송타입 대상 국가가 아닙니다.");
                    }
                    break;

                default:
                    throw new LingoException("입력한 주문번호 : " + listMap.get("C02") + "의 배송타입이 올바르지 않습니다.");
            }
        }
    }

    /**
     * 동일한 장바구니코드의 수취인정보가 일치한지 체크
     *
     * @param list
     * @throws Exception
     */
    public void checkCartNo(ArrayList list) throws Exception {
        logger.debug("list" + list.toString());

        Map<String, String> cMap = new HashMap<String, String>();

        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> listMap = (HashMap<String, String>) list.get(i);
            // 장바구니 코드가 ArrayList에 있는지 존재체크
            if (listMap.containsKey("C03") && !Util.isEmpty(listMap.get("C03"))) {
                StringBuffer tmpSb = new StringBuffer();

                // 2019.11.21 hjy 2019년 12월 추가개발 수정 start
                // 배송방식 C06
                if (listMap.containsKey("C06")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C06")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인명
                if (listMap.containsKey("C16")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C16")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인전화번호 C17
                if (listMap.containsKey("C17")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C17")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인 휴대폰 C18
                if (listMap.containsKey("C18")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C18")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인주소1 C19
                if (listMap.containsKey("C19")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C19")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인주소2 C20
                if (listMap.containsKey("C20")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C20")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인 도시 C21
                if (listMap.containsKey("C21")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C21")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인 주 C22
                if (listMap.containsKey("C22")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C22")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인 우편번호 C23
                if (listMap.containsKey("C23")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C23")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 수취인 국가 C24
                if (listMap.containsKey("C24")) {
                    tmpSb.append(Util.getStrTrim(listMap.get("C24")));
                } else {
                    tmpSb.append("|");
                }
                tmpSb.append("|");

                // 장바구니코드에 해당하는 수취인정보가 존재하는지 체크
                if (cMap.containsKey(listMap.get("C03"))) {
                    if (!tmpSb.toString().equals(Util.getStrTrim(cMap.get(listMap.get("C03"))))) {
                        throw new LingoException("장바구니번호 : " + listMap.get("C03") + "의 배송방식 또는 수취인정보가 일치하지 않습니다.");
                    }
                } else {
                    cMap.put(listMap.get("C03"), Util.getStrTrim(tmpSb.toString()));
                }
                // 2019.11.21 hjy 2019년 12월 추가개발 수정 end
            }
        }
    }

    /**
     * List<CodeVO>를 List<String>으로 변환
     *
     * @param list
     * @return
     * @throws Exception
     */
    public List<String> convertCdList(List<CodeVO> list) throws Exception {

        List<String> cdList = new ArrayList();
        for (CodeVO em : list) {
            cdList.add(em.getCode());
        }

        return cdList;
    }

    /**
     * List<CodeVO>를 List<String>으로 변환
     *
     * @param list
     * @return
     * @throws Exception
     */
    public List<String> convertCodeValue(List<CodeVO> list) throws Exception {

        List<String> cdList = new ArrayList();
        for (CodeVO em : list) {
            cdList.add(em.getValue());
        }

        return cdList;
    }

    /**
     * List<CodeVO>를 Map<String, String>으로 변환
     *
     * @param list
     * @return
     * @throws Exception
     */
    public Map<String, String> convertMapList(List<CodeVO> list) throws Exception {

        Map<String, String> map = new HashMap<String, String>();
        for (CodeVO em : list) {
            map.put(em.getCode(), em.getValue());
        }

        return map;
    }

    public void insertTstockHistory(LoginVO loginVo, String ipAddr, int regSeq) throws Exception {

        if (regSeq == 0) {
            throw new LingoException("REG_SEQ 정보가 없습니다.");
        }

        String sReqSeq = Integer.toString(regSeq);
        Map<String, Object> reqMap = new HashMap<>();
        reqMap.put("regSeq", sReqSeq);

        List<Map<String, Object>> xrtInvcSnos = dao.selectList("OrderInsertMapper.getXrtInvcSno", reqMap);
        List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();

        for (Map<String, Object> insertMap : xrtInvcSnos) {
            insertMap.put("addusercd", loginVo.getUsercd());
            insertMap.put("updusercd", loginVo.getUsercd());
            insertMap.put("eventCd", "UPLOAD");
            insertMap.put("terminalcd", ipAddr);
            insertMap.put("statusCd", CommonConst.ORD_STATUS_CD_ORDER_APPLY);
            insertMap.put("statusNm", CommonConst.ORD_STATUS_NM_ORDER_APPLY);
            insertMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_ORDER_APPLY);
            insertList.add(insertMap);
        }

        for (Map<String, Object> paramMap : insertList) {
            dao.insert("OrderInsertMapper.insertTstockHistory", paramMap);
            dao.insert("trackingHistoryMapper.insertTrackingHistory", paramMap);
        }
    }

    /**
     * 결제타입구분 설정
     *
     * @param loginVo
     * @param regSeq
     * @throws Exception
     */
    public void updTorderPaymentType(LoginVO loginVo, int regSeq) throws Exception {

        if (regSeq == 0) {
            throw new LingoException("REG_SEQ 정보가 없습니다.");
        }

        String sReqSeq = Integer.toString(regSeq);
        Map<String, Object> reqMap = new HashMap<>();
        reqMap.put("regSeq", sReqSeq);

        List<Map<String, Object>> xrtInvcSnos = dao.selectList("OrderInsertMapper.getXrtInvcSno", reqMap);

        for (Map<String, Object> updMap : xrtInvcSnos) {
            updMap.put("paymentType", loginVo.getPaymentType());

            dao.update("OrderInsertMapper.updTorderPaymentType", updMap);
        }
    }

    /**
     * Tolos API TS_0009 실행
     *
     * @param regSeq
     * @return
     * @throws Exception
     */
    public Map<String, Object> tolos0009(ShippingDataVo reqVo) throws Exception {

        List<Map<String, Object>> xrtInvcSnos = reqVo.getXrtInvcSnos();
        List<TolosShipmentVo> shipmentVos = reqVo.getTolosShipmentVos();

        if (shipmentVos.size() == 0) {
            Map<String, Object> retMap = new HashMap<>();
            retMap.put("code", "201");
            retMap.put("message", "");
            retMap.put("data", new ArrayList());

            return retMap;
        } else {
            Map<String, Object> resMap = tolosAPI.ts0009("dev", shipmentVos);
            List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

            if (resMap.get("list") == null) {
                String message = (String) resMap.get("message");
                Map<String, Object> retMap = new HashMap<>();
                retMap.put("message", message);
                retMap.put("data", xrtInvcSnos);
                return retMap;

            } else {
                JSONArray resList = (JSONArray) resMap.get("list");
                JSONArray toList = (JSONArray) resList.get(0);

                String message = "";
                for (int i = 0; i < toList.size(); i++) {
                    Map<String, Object> updateMap = new HashMap<>();
                    JSONObject jsonObject = (JSONObject) toList.get(i);

                    String code = jsonObject.get("code").toString();
                    if (code.equals("S001")) {

                        updateMap.put("invcSno1", jsonObject.get("shippingno").toString());
                        updateMap.put("invcSno2", jsonObject.get("refno1").toString());
                        updateMap.put("xrtInvcSno", jsonObject.get("shprrefno").toString());
                        xrtInvcSnoList.add(updateMap);
                    } else {
                        updateMap.put("xrtInvcSno", jsonObject.get("shprrefno").toString());
                        updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
                        message += "(" + jsonObject.get("shprrefno").toString() + ", " + jsonObject.get("cartno").toString() + ")" + jsonObject.get("message").toString() + "\n";
                    }

                    dao.update("OrderInsertMapper.tolosUpdate", updateMap);
                }

                Map<String, Object> retMap = new HashMap<>();
                retMap.put("code", "200");
                retMap.put("message", message);
                retMap.put("data", xrtInvcSnoList);

                return retMap;
            }
        }
    }

    /**
     * Tolos 배송데이터
     *
     * @param tOrder
     * @return
     * @throws Exception
     */
    public TolosShipmentVo tolosShippingData(Map<String, Object> tOrder) throws Exception {

        if (tOrder.size() == 0) {
            throw new LingoException("오더 정보가 없습니다.");
        }

        logger.debug("tOrder : " + tOrder.toString());
        List<Map<String, Object>> items = dao.selectList("OrderInsertMapper.getTorderDTL", tOrder);
        String eNation = tOrder.get("eNation").toString().toUpperCase();
        String shipMethod = tOrder.get("shipMethodCd").toString();

        List<TolosOrderVo> orders = new ArrayList<>();

        String[] itemno = new String[items.size()];
        String[] item = new String[items.size()];
        String[] itemoption = new String[items.size()];
        String[] itemoptionkr = new String[items.size()];
        int[] itemcount = new int[items.size()];
        float[] itemprice = new float[items.size()];

        for (int i = 0; i < items.size(); i++) {

            String itemCnt = items.get(i).get("goodsCnt").toString();
            String itemPrice = items.get(i).get("paymentPrice").toString();
            int cnt = Integer.parseInt(itemCnt);
            float price = Float.parseFloat(itemPrice);
            itemno[i] = items.get(i).get("ordSeq").toString();
            item[i] = items.get(i).get("goodsNm").toString();
            itemoption[i] = items.get(i).get("goodsOption").toString();
            itemoptionkr[i] = items.get(i).get("goodsNm").toString();
            itemcount[i] = cnt;
            itemprice[i] = price;

            TolosOrderVo orderVo = new TolosOrderVo();
            orderVo.setOrderlistKey(tOrder.get("ordCd").toString());
            orderVo.setItemno(itemno);
            orderVo.setItem(item);
            orderVo.setItemoption(itemoption);
            orderVo.setItemoptionkr(itemoptionkr);
            orderVo.setItemcnt(itemcount);
            orderVo.setItemprice(itemprice);
            orders.add(orderVo);
        }

        TolosShipmentVo shipmentVo = new TolosShipmentVo();
        shipmentVo.setShprrefno(tOrder.get("xrtInvcSno").toString());
        shipmentVo.setShipmethod(shipMethod);
        shipmentVo.setShipname(tOrder.get("shipName").toString());
        shipmentVo.setShipaddr(tOrder.get("shipAddr").toString());
        shipmentVo.setShippostal(tOrder.get("shipPost").toString());
        shipmentVo.setShiptel(tOrder.get("shipTel").toString());
        shipmentVo.setShipmobile(tOrder.get("shipMobile").toString());
        shipmentVo.setSnation("KR");
        shipmentVo.setCneename(tOrder.get("recvName").toString());
        shipmentVo.setCneeaddr(tOrder.get("recvAddr1").toString());
        shipmentVo.setCneemobile(tOrder.get("recvMobile").toString());
        shipmentVo.setCneetel(tOrder.get("recvTel").toString());
        shipmentVo.setCneepostal(tOrder.get("recvPost").toString());
        shipmentVo.setEnation(eNation);
        shipmentVo.setShopcode("LF");
        shipmentVo.setCurrency("KRW");
        shipmentVo.setPurchasecharge(1);
        shipmentVo.setCartno(tOrder.get("cartNo").toString());
        shipmentVo.setOrderList(orders);

        return shipmentVo;
    }

    /**
     * efs 배송데이터
     *
     * @param tOrder
     * @return
     * @throws Exception
     */
    public EfsShipmentVo efsShippingData(Map<String, Object> tOrder) throws Exception {

        if (tOrder.size() == 0) {
            throw new LingoException("오더 정보가 없습니다.");
        }

        logger.debug("tOrder : " + tOrder.toString());
        List<Map<String, Object>> items = dao.selectList("OrderInsertMapper.getTorderDTL", tOrder);
        String eNation = tOrder.get("eNation").toString().toUpperCase();

        List<EfsOrderDtlVo> orders = new ArrayList<>();

        for (int i = 0; i < items.size(); i++) {
            logger.debug("=================");

            EfsOrderDtlVo dtlVo = new EfsOrderDtlVo();

            dtlVo.setDtlCartNo(tOrder.get("cartNo").toString()); // 판매 쇼핑몰명
            dtlVo.setDtlMallNm(tOrder.get("mallNm").toString()); // 장바구니 번호
            dtlVo.setDtlOrdNo(items.get(i).get("ordNo").toString()); // 주문번호
            dtlVo.setGoodsCd(items.get(i).get("goodsCd").toString()); // 상품코드
            dtlVo.setGoodsNm(items.get(i).get("goodsNm").toString()); // 상품명
            dtlVo.setGoodsOption(items.get(i).get("goodsOption").toString()); // 상품명옵션
                                                                              // (영문)
            dtlVo.setGoodsOptionKor(items.get(i).get("goodsOption").toString()); // 상품명옵션
                                                                                 // (한글)
            dtlVo.setGoodsCnt(items.get(i).get("goodsCnt").toString());
            dtlVo.setDtlRecvCurrency(tOrder.get("recvCurrency").toString());
            dtlVo.setPaymentPrice(items.get(i).get("paymentPrice").toString());
            orders.add(dtlVo);
        }

        EfsShipmentVo shipmentVo = new EfsShipmentVo();
        shipmentVo.setXrtInvcNo(tOrder.get("xrtInvcSno").toString());
        shipmentVo.setShipMethodCd(tOrder.get("shipMethodCd").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setShipName(tOrder.get("shipName").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setShipAddr(tOrder.get("shipAddr").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setShipPost(tOrder.get("shipPost").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setShipTel(tOrder.get("shipTel").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setShipMobile(tOrder.get("shipMobile").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setRecvName(tOrder.get("recvName").toString().replaceAll(System.getProperty("line.separator"), " "));

        // 수화인 주소
        StringBuffer recvSb = new StringBuffer();
        recvSb.append(tOrder.get("recvAddr1").toString().replaceAll(System.getProperty("line.separator"), " "));
        if (!Util.isEmpty(tOrder.get("recvAddr2").toString())) {
            recvSb.append(" " + tOrder.get("recvAddr2").toString().replaceAll(System.getProperty("line.separator"), " "));
        }
        if (!Util.isEmpty(tOrder.get("recvCity").toString())) {
            recvSb.append(" " + tOrder.get("recvCity").toString().replaceAll(System.getProperty("line.separator"), " "));
        }
        if (!Util.isEmpty(tOrder.get("recvState").toString())) {
            recvSb.append(" " + tOrder.get("recvState").toString());
        }
        shipmentVo.setRecvAddr(recvSb.toString());

        if (!Util.isEmpty(tOrder.get("recvPost").toString())) {
            // 홍콩일경우 우편번호 9999로 세팅. 20200131최일규
            String hkNation = tOrder.get("recvNation").toString();
            if ("HK".equals(hkNation) || "MA".equals(hkNation)) {
                shipmentVo.setRecvPost("");
            } else {
                shipmentVo.setRecvPost(Util.getStrTrim(tOrder.get("recvPost").toString()).replaceAll(System.getProperty("line.separator"), " "));
            }
        } else {
            shipmentVo.setRecvPost("-");
        }

        shipmentVo.setRecvTel(tOrder.get("recvTel").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setRecvMobile(tOrder.get("recvMobile").toString().replaceAll(System.getProperty("line.separator"), " "));
        shipmentVo.setRecvNation(eNation);
        shipmentVo.setRecvCity("");
        shipmentVo.setOrderDtlList(orders);

        return shipmentVo;
    }

    /**
     * etomars 배송데이터
     *
     * @param tOrder
     * @return
     * @throws Exception
     */
    public EtomarsShipmentVo etomarsShippingData(Map<String, Object> tOrder) throws Exception {
        logger.debug("tOrder : " + tOrder.toString());
        List<Map<String, Object>> items = dao.selectList("OrderInsertMapper.getTorderDTL", tOrder);

        EtomarsShipmentVo shipmentVo = new EtomarsShipmentVo();
        List<EtomarsOrderDtlVo> orders = new ArrayList<>();

        for (int i = 0; i < items.size(); i++) {
            logger.debug("=================");

            EtomarsOrderDtlVo dtlVo = new EtomarsOrderDtlVo();

            dtlVo.setGoodsName(items.get(i).get("goodsNm").toString());
            int cnt = Integer.parseInt(items.get(i).get("goodsCnt").toString());
            float unitPrice = Float.parseFloat(items.get(i).get("paymentPrice").toString()); // .parseInt();

            dtlVo.setQty(cnt);
            dtlVo.setUnitPrice(unitPrice);
            dtlVo.setBrandName("XROUTE");
            dtlVo.setSKU(items.get(i).get("goodsCd").toString());
            dtlVo.setHSCODE("");
            dtlVo.setPurchaseUrl("");
            dtlVo.setMaterial("");
            dtlVo.setBarcode("");
            dtlVo.setGoodsNameExpEn("");
            dtlVo.setHscodeExpEn("");

            orders.add(dtlVo);
        }
        shipmentVo.setNationCode(tOrder.get("eNation").toString().toUpperCase());
        shipmentVo.setShippingType("A");
        shipmentVo.setOrderNo1(tOrder.get("xrtInvcSno").toString());
        shipmentVo.setOrderNo2("");
        shipmentVo.setSenderName(tOrder.get("shipName").toString());
        shipmentVo.setSenderTelno(tOrder.get("shipTel").toString());
        shipmentVo.setSenderAddr(tOrder.get("shipAddr").toString());
        shipmentVo.setReceiverName(tOrder.get("recvName").toString());
        shipmentVo.setReceiverNameYomigana(tOrder.get("recvName").toString());
        shipmentVo.setReceiverNameExpEng("");
        shipmentVo.setReceiverTelNo1(tOrder.get("recvTel").toString());
        shipmentVo.setReceiverTelNo2(tOrder.get("recvMobile").toString());
        shipmentVo.setReceiverZipcode(tOrder.get("recvPost").toString());
        shipmentVo.setReceiverState("");
        shipmentVo.setReceiverCity("");
        shipmentVo.setReceiverDistrict("");

        // 수취인 주소
        StringBuffer addrSb = new StringBuffer();
        addrSb.append(tOrder.get("recvAddr1").toString());
        if (!Util.isEmpty(tOrder.get("recvAddr2").toString())) {
            addrSb.append(" " + tOrder.get("recvAddr2").toString());
        }
        if (!Util.isEmpty(tOrder.get("recvCity").toString())) {
            addrSb.append(" " + tOrder.get("recvCity").toString());
        }
        shipmentVo.setReceiverDetailAddr(addrSb.toString());
        shipmentVo.setReceiverEmail("");
        shipmentVo.setReceiverSocialNo("");
        shipmentVo.setRealWeight("1");
        shipmentVo.setWeightUnit("KG");
        shipmentVo.setBoxCount("1");
        shipmentVo.setCurrencyUnit(tOrder.get("recvCurrency").toString());
        shipmentVo.setDelvMessage("");
        shipmentVo.setUserData1("");
        shipmentVo.setUserData2("");
        shipmentVo.setUserData3("");
        shipmentVo.setDimWidth("");
        shipmentVo.setDimLength("");
        shipmentVo.setDimHeight("");
        shipmentVo.setDimUnit("cm");
        shipmentVo.setDelvNo("");
        shipmentVo.setDelvCom("");
        shipmentVo.setStockMode("");
        shipmentVo.setSalesSite(tOrder.get("mallNm").toString());
        shipmentVo.setGoodsList(orders);

        return shipmentVo;
    }

    /**
     * EFS API createShipment 실행
     *
     * @param regSeq
     * @return
     * @throws Exception
     */
    public Map<String, Object> efsCreateShipment(ShippingDataVo reqVo) throws Exception {

        List<Map<String, Object>> xrtInvcSnos = reqVo.getXrtInvcSnos();
        List<EfsShipmentVo> shipmentVos = reqVo.getEfsShipmentVos();

        if (shipmentVos.size() == 0) {
            Map<String, Object> retMap = new HashMap<>();
            retMap.put("code", "201");
            retMap.put("message", "");
            retMap.put("data", new ArrayList());

            return retMap;
        } else {
            Map<String, Object> resMap = efsAPI.createShipment(shipmentVos);
            List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

            String[] changeData = resMap.get("data").toString().split("\\n");

            // 실패한 경우
            if (Util.isEmpty(changeData) || !changeData[0].toUpperCase().contains(Util.getStrTrim("SUCCESSFULLY"))) {
                resMap.put("code", "500");
                resMap.put("message", "failed");
                Map<String, Object> updateMap = new HashMap<>();
                //
                for (Map<String, Object> xrtInvcSno : xrtInvcSnos) {
                    logger.debug("xrtInvcSno : failed" + xrtInvcSno.toString());
                    updateMap.put("xrtInvcSno", xrtInvcSno.get("xrtInvcSno"));
                    updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);

                    dao.update("OrderInsertMapper.efsUpdate", updateMap);
                }
                resMap.put("data", xrtInvcSnos);
            } else {
                // 성공한 경우
                if (changeData.length > 0) {
                    resMap.put("code", "200");
                    resMap.put("message", "");

                    logger.debug("changeData.length:" + changeData.length);
                    for (int i = 1; i < changeData.length; i++) {
                        logger.debug("changeData[" + i + "] : " + changeData[i]);

                        Map<String, Object> updateMap = new HashMap<>();

                        String[] resultDtl = changeData[i].split("\\|");
                        logger.debug("resultDtl.length:" + resultDtl.length);

                        updateMap.put("invcSno2", resultDtl[0]);
                        updateMap.put("xrtInvcSno", resultDtl[1]);
                        if (resultDtl.length > 2) {
                            if ("N".equals(resultDtl[2])) {
                                // 2020-02-05 송장번호 발급 안되었을떄 에러메세지처리
                                updateMap.put("xrtInvcSno", resultDtl[1]);
                                updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
                                dao.update("OrderInsertMapper.efsUpdate", updateMap);
                                resMap.put("code", "500");
                                resMap.put("message", "Data ERROR");
                                break;
                            }
                        }
                        if (resultDtl.length > 4) {
                            updateMap.put("localShipper", resultDtl[4]);
                        }
                        if (resultDtl.length > 5) {
                            updateMap.put("invcSno1", resultDtl[5]);
                        }
                        xrtInvcSnoList.add(updateMap);
                        dao.update("OrderInsertMapper.efsUpdate", updateMap);
                    }
                    resMap.put("data", xrtInvcSnoList);
                }
            }

            return resMap;
        }
    }

    /**
     * ETOMARS API RegData 실행
     *
     * @param regSeq
     * @return
     * @throws Exception
     */
    public Map<String, Object> etomarsRegData(ShippingDataVo reqVo) throws Exception {

        List<Map<String, Object>> xrtInvcSnos = reqVo.getXrtInvcSnos();
        List<EtomarsShipmentVo> shipmentVos = reqVo.getEtomarsShipmentVos();

        if (shipmentVos.size() == 0) {
            Map<String, Object> retMap = new HashMap<>();
            retMap.put("code", "201");
            retMap.put("message", "failed");
            retMap.put("data", new ArrayList());

            return retMap;
        } else {
            Map<String, Object> resMap = etomarsAPI.RegData(shipmentVos);
            List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

            if (!"0".equals(resMap.get("code").toString())) {
                String message = (String) resMap.get("message");
                Map<String, Object> retMap = new HashMap<>();
                retMap.put("message", message);
                retMap.put("data", xrtInvcSnos);
                return retMap;
            } else {
                JSONArray resList = (JSONArray) resMap.get("list");

                String message = "";
                for (int i = 0; i < resList.size(); i++) {
                    Map<String, Object> updateMap = new HashMap<>();
                    JSONObject jsonObject = (JSONObject) resList.get(i);

                    // 성공한 경우
                    if ("0".equals(resMap.get("code").toString())) {
                        updateMap.put("xrtInvcSno", jsonObject.get("OrderNo1").toString());
                        updateMap.put("invcSno2", jsonObject.get("RegNo").toString());
                        updateMap.put("invcSno1", jsonObject.get("DelvNo").toString());
                        updateMap.put("slug1", jsonObject.get("DelvComName").toString());
                        updateMap.put("localShipper", jsonObject.get("DelvComName").toString());
                        xrtInvcSnoList.add(updateMap);
                    } else {
                        updateMap.put("xrtInvcSno", jsonObject.get("OrderNo1").toString());
                        updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
                        message += "(" + jsonObject.get("xrtInvcSno").toString() + ")" + jsonObject.get("Message").toString() + "\n";
                    }
                    dao.update("OrderInsertMapper.etomarsUpdate", updateMap);

                    if ("0".equals(resMap.get("code").toString())) {

                        Map<String, Object> parmaMap = new HashMap<String, Object>();
                        parmaMap.put("xrtInvcSno", jsonObject.get("OrderNo1").toString());
                        this.eTomarsAfterShipTrackings(parmaMap);
                    }
                }

                Map<String, Object> retMap = new HashMap<>();
                retMap.put("code", "200");
                retMap.put("message", "");
                retMap.put("data", xrtInvcSnoList);
                return retMap;
            }
        }
    }

    /**
     * 국가별 배송타입별로 API연동을 배정함.
     *
     * @param regSeq
     * @return
     * @throws Exception
     */
    public ShippingDataVo convShippingData(int regSeq) throws Exception {

        if (regSeq == 0) {
            throw new LingoException("REG_SEQ 정보가 없습니다.");
        }

        String sReqSeq = Integer.toString(regSeq);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("regSeq", sReqSeq);

        List<Map<String, Object>> xrtInvcSnos = dao.selectList("OrderInsertMapper.getXrtInvcSno", paramMap);
        List<Map<String, Object>> tOrders = new ArrayList<>();

        if (xrtInvcSnos.size() == 0) {
            throw new LingoException("INVC_SNO 정보가 없습니다.");
        }

        for (Map<String, Object> xrtInvcSno : xrtInvcSnos) {
            logger.debug("xrtInvcSno : " + xrtInvcSno.toString());

            tOrders.addAll(dao.selectList("OrderInsertMapper.getTorderData", xrtInvcSno));
        }

        ShippingDataVo shippingVo = new ShippingDataVo();
        shippingVo.setXrtInvcSnos(xrtInvcSnos);
        shippingVo.settOrders(tOrders);

        List<EfsShipmentVo> efsOrderList = new ArrayList<>();
        List<EtomarsShipmentVo> etomarsOrderList = new ArrayList<>();
        List<QxpressVo> qxpressOrderList = new ArrayList<>();

        for (Map<String, Object> tOrder : tOrders) {
            String eNation = tOrder.get("eNation").toString().toUpperCase();
            String shipMethod = tOrder.get("shipMethodCd").toString().toUpperCase();

            // TODO
            // 국가별 배송타입별, API업체별로 오더등록 리스트를 작성

            switch (shipMethod) {
                case CommonConst.SHIP_METHOD_DHL:
                    EfsShipmentVo efsOrderData = efsShippingData(tOrder);
                    efsOrderList.add(efsOrderData);
                    break;
                case CommonConst.SHIP_METHOD_PREMIUM:
                    if ("JP".equals(eNation)) {
                        // EtomarsShipmentVo etomarsOrderData =
                        // etomarsShippingData(tOrder);
                        // etomarsOrderList.add(etomarsOrderData);
                    } else if ("TW".equals(eNation) || "MY".equals(eNation) || "HK".equals(eNation) || "SG".equals(eNation)) {
                        List<QxpressVo> qxpressVos = qxpressShippingData(tOrder);
                        qxpressOrderList.addAll(qxpressVos);
                    }
                    
                    break;

                default:
                    logger.debug("API가 지원하지 않은 곳입니다.");
                    break;
            }
        }
        // 오더등록리스트의 사이즈가 0보다 큰경우, VO에 담아서 반환
        // EFS
        if (efsOrderList.size() > 0) {
            shippingVo.setEfsShipmentVos(efsOrderList);
        }
        // ETOMARS
        if (etomarsOrderList.size() > 0) {
            shippingVo.setEtomarsShipmentVos(etomarsOrderList);
        }

        // 2019.12월 추가개발 jy.hong
        if (qxpressOrderList.size() > 0) {
            shippingVo.setQxpressVos(qxpressOrderList);
        }

        return shippingVo;
    }

    /**
     * 국가코드 조회
     *
     * @param LDataMap
     * @return list<LDataMap>
     * @throws Exception
     */
    public List<LDataMap> getCountryList(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getCountryList", param);
    }

    /**
     * 통화코드 조회
     *
     * @param LDataMap
     * @return list<LDataMap>
     * @throws Exception
     */
    public List<LDataMap> getCurrencyList(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getCurrencyList", param);
    }

    /**
     * AfterShip Tracking API
     *
     * @return
     * @throws Exception
     */
    public Map<String, Object> addAfterShipTrackings(List<Map<String, Object>> xrtInvcSnos) throws Exception {

        if (xrtInvcSnos.size() == 0) {
            new LingoException("데이터가 없습니다.");
        }

        List<Map<String, Object>> xrtDatas = new ArrayList<>();

        for (Map<String, Object> xrtInvcSno : xrtInvcSnos) {
            xrtDatas.addAll(dao.selectList("AfterShipMapper.getOrderData", xrtInvcSno));
        }

        for (int i = 0; i < xrtDatas.size(); i++) {
            AfterShipTrackingVo trackingVo = new AfterShipTrackingVo();

            // TODO 현재 tolos와 efs가 연동이 안되어 현재는 usps 로 변경
            // trackingVo.setSlug(xrtDatas.get(i).get("localShipper").toString());
            trackingVo.setSlug("usps");
            trackingVo.setTrackingNumber(xrtDatas.get(i).get("invcSno1").toString());
            trackingVo.setTitle("");

            List<String> emails = new ArrayList<>();
            emails.add("xroute@logifocus.co.kr");
            trackingVo.setEmails(emails);
            trackingVo.setOrderId(xrtDatas.get(i).get("ordNo").toString());
            trackingVo.setOrderIdPath("");
            Map<String, Object> customFileds = new HashMap<>();
            customFileds.put("productName", xrtDatas.get(i).get("goodsNm").toString());
            customFileds.put("productPrice", xrtDatas.get(i).get("price").toString());

            trackingVo.setCustomFields(customFileds);
            // TODO 해당 국가 언어로 변경해야하는 로직추가
            // trackingVo.setLanguage(xrtDatas.get(i).get("sNation").toString());
            trackingVo.setLanguage("en");
            trackingVo.setOrderPromisedDeliveryDate("");
            trackingVo.setDeliveryType("pickup_at_courier");
            trackingVo.setPickupLocation(xrtDatas.get(i).get("eNation").toString());
            trackingVo.setPickupNote("");

            Map<String, Object> retMap = afterShipAPI.createTrackings(trackingVo);
        }
        Map<String, Object> retMap = new HashMap<>();
        return retMap;
    }

    public Map<String, Object> eTomarsAfterShipTrackings(Map<String, Object> paramMap) throws Exception {
        logger.info("[eTomarsAfterShipTrackings] paramMap : " + paramMap.toString());

        Map<String, Object> retMap = new HashMap<>();
        List<Map<String, Object>> orderList = dao.selectList("AfterShipMapper.getOrderData", paramMap);

        for (int i = 0; i < orderList.size(); i++) {
            AfterShipTrackingVo trackingVo = new AfterShipTrackingVo();

            logger.debug("invcSno2 : " + orderList.get(i).get("invcSno2").toString());

            if (orderList.get(i).get("invcSno2").equals("")) {
                retMap.put("code", "200");
                retMap.put("message", "정상적으로 처리되었습니다.");
                return retMap;
            }

            String slug = orderList.get(i).get("slug2").toString();

            if (slug.toLowerCase().contains("sagawa")) {
                slug = "sagawa";
            } else if (slug.toLowerCase().contains("yto")) {
                slug = "yto";
            }

            trackingVo.setSlug(slug);
            trackingVo.setTrackingNumber(orderList.get(i).get("invcSno2").toString());
            trackingVo.setTitle("");

            List<String> emails = new ArrayList<>();
            emails.add("xroute@logifocus.co.kr");
            trackingVo.setEmails(emails);
            trackingVo.setOrderId(orderList.get(i).get("ordNo").toString());
            trackingVo.setOrderIdPath("");
            Map<String, Object> customFileds = new HashMap<>();
            customFileds.put("productName", orderList.get(i).get("goodsNm").toString());
            customFileds.put("productPrice", orderList.get(i).get("price").toString());

            trackingVo.setCustomFields(customFileds);
            trackingVo.setLanguage("en");
            trackingVo.setOrderPromisedDeliveryDate("");
            trackingVo.setDeliveryType("pickup_at_courier");
            trackingVo.setPickupLocation(orderList.get(i).get("eNation").toString());
            trackingVo.setPickupNote("");

            retMap = afterShipAPI.createTrackings(trackingVo);
        }

        return retMap;
    }

    /**
     * 주(State) 조회
     *
     * @param
     * @return list<LDataMap>
     * @throws Exception
     */
    public List<LDataMap> getUSStateList(LDataMap param) throws Exception {
        return dao.select("OrderInsertMapper.getUSStateList", param);
    }

    /**
     * 영문체크 (영문 또는 숫자인경우, true)
     *
     * @param textInput
     * @return
     */
    public boolean checkAlphabet(String textInput) {
        boolean result = false;
        char chrInput;

        for (int i = 0; i < textInput.length(); i++) {
            chrInput = textInput.charAt(i); // 입력받은 텍스트에서 문자 하나하나 가져와서 체크
            if ((chrInput >= 0x61 && chrInput <= 0x7A) // 영문(소문자) OK!
                    || (chrInput >= 0x41 && chrInput <= 0x5A) || (chrInput >= 0x30 && chrInput <= 0x39)) {
                // 영문(소문자) || 영문(대문자) || 숫자
                result = true;
            }
        }
        return result;
    }

    /**
     * efs 배송데이터
     *
     * @param tOrder
     * @return
     * @throws Exception
     */
    public List<QxpressVo> qxpressShippingData(Map<String, Object> tOrder) throws Exception {

        if (tOrder.size() == 0) {
            throw new LingoException("오더 정보가 없습니다.");
        }

        logger.debug("tOrder : " + tOrder.toString());
        List<QxpressVo> qxpressVoList = new ArrayList<>();
        List<Map<String, Object>> items = dao.selectList("OrderInsertMapper.getQxpressGoodsDTL", tOrder);

        for (int i = 0; i < items.size(); i++) {

            String recvHpNo = tOrder.get("recvMobile").toString();
            String recvTel = tOrder.get("recvTel").toString();
            String zipcode = tOrder.get("recvPost").toString();
            String countryCode = tOrder.get("eNation").toString().toUpperCase();

            // 홍콩일 경우 우편번호 999로 세팅. 최일규
            if ("HK".equals(countryCode) || "MA".equals(countryCode)) {
                zipcode = "";
            }

            QxpressVo qxpressVo = new QxpressVo();
            qxpressVo.setXrtInvcSno(tOrder.get("xrtInvcSno").toString());
            qxpressVo.setRcvnm(tOrder.get("recvName").toString());
            qxpressVo.setHpNo((!recvHpNo.equals("") ? recvHpNo : recvTel));
            qxpressVo.setDelFrontaddress(tOrder.get("recvAddr1").toString().replaceAll("#", "＃"));
            qxpressVo.setDelBackaddress(tOrder.get("recvAddr2").toString().replaceAll("#", "＃"));
            qxpressVo.setDpc3refno1(tOrder.get("xrtInvcSno").toString());
            qxpressVo.setTelNo(recvTel);
            qxpressVo.setZipCode(zipcode);
            qxpressVo.setBuyCustemail("");
            qxpressVo.setDeliveryNationcd(tOrder.get("eNation").toString().toUpperCase());
            qxpressVo.setDeliveryOptionCode("");
            qxpressVo.setSellCustnm(tOrder.get("shipName").toString());
            qxpressVo.setStartNationcd(tOrder.get("sNation").toString().toUpperCase());
            qxpressVo.setRemark("");
            qxpressVo.setItemNm(items.get(i).get("goodsNm").toString());
            qxpressVo.setQty(items.get(i).get("goodsCnt").toString());
            qxpressVo.setPurchasAmt(items.get(i).get("paymentPrice").toString());
            qxpressVo.setCurrency(tOrder.get("recvCurrency").toString().toUpperCase());
            qxpressVoList.add(qxpressVo);
        }

        return qxpressVoList;
    }

    public Map<String, Object> qxpressRegData(ShippingDataVo shipmentVo) throws Exception {
        logger.debug("[qxpressRegData] shipmentVo : " + shipmentVo.toString());

        List<Map<String, Object>> xrtInvcSnos = shipmentVo.getXrtInvcSnos();
        List<QxpressVo> qxpressVos = shipmentVo.getQxpressVos();

        if (qxpressVos.size() == 0) {
            Map<String, Object> retMap = new HashMap<>();
            retMap.put("code", "404");
            retMap.put("message", "데이터가 없습니다.");
            retMap.put("data", new ArrayList());
            return retMap;
        }

        List<QxpressVo> duplicates = new ArrayList<>();
        List<QxpressVo> duplicateList = new ArrayList<>();
        List<QxpressVo> complexGoodsList = new ArrayList<>();
        List<QxpressVo> uniqueList = new ArrayList<>();
        // 1. 일반상품 및 복합상품 주문 분리
        for (int i = 0; i < qxpressVos.size(); i++) {
            if (uniqueList.size() == 0) {
                logger.debug("uniqueList.size() == 0");
                uniqueList.add(qxpressVos.get(i));
            } else {
                Boolean bUnique = true;
                for (QxpressVo qxpressVo : uniqueList) {
                    if (qxpressVo.getDpc3refno1().equals(qxpressVos.get(i).getDpc3refno1())) {
                        bUnique = false;
                    }
                }
                // 복합 상품이 이면 uniqueList에 추가
                if (bUnique) {
                    uniqueList.add(qxpressVos.get(i));
                } else {
                    duplicates.add(qxpressVos.get(i));
                }
            }
        }
        // 2. 일반상품 주문에 복합상품 주문을 제거
        for (int i = 0; i < duplicates.size(); i++) {
            for (int j = 0; j < uniqueList.size(); j++) {
                if (uniqueList.get(j).getDpc3refno1().equals(duplicates.get(i).getDpc3refno1())) {
                    uniqueList.remove(j);
                }
            }
        }
        // 3. 복합상품에 중복된 주문번호 제거
        for (int i = 0; i < duplicates.size(); i++) {
            if (duplicateList.size() == 0) {
                duplicateList.add(duplicates.get(i));
            } else {
                Boolean bUnique = true;
                for (QxpressVo qxpressVo : duplicateList) {
                    if (qxpressVo.getDpc3refno1().equals(duplicates.get(i).getDpc3refno1())) {
                        bUnique = false;
                    }
                }

                if (bUnique) {
                    duplicateList.add(duplicates.get(i));
                }
            }
        }
        // 4. 복합상품 주문 생성
        for (int i = 0; i < qxpressVos.size(); i++) {
            for (QxpressVo qxpressVo : duplicateList) {
                if (qxpressVo.getDpc3refno1().equals(qxpressVos.get(i).getDpc3refno1())) {
                    complexGoodsList.add(qxpressVos.get(i));
                }
            }
        }

        logger.debug("uniqueList : " + uniqueList.toString());
        logger.debug("duplicates : " + duplicates.toString());
        logger.debug("duplicateList : " + duplicateList.toString());
        logger.debug("complexGoodsList : " + complexGoodsList.toString());

        List<Map<String, Object>> errors = new ArrayList<>();
        List<Map<String, Object>> xrtInvcSnoList = new ArrayList();

        if (uniqueList.size() != 0) {
            for (QxpressVo qxpressVo : uniqueList) {
                Map<String, Object> retMap = qxpress.createOrder(qxpressVo);
                String code = (String) retMap.get("code");
                if (!code.equals("200")) {
                    retMap.put("code", code);
                    retMap.put("message", retMap.get("message").toString());
                    retMap.put("data", new ArrayList());
                    return retMap;
                }

                JSONArray resList = (JSONArray) retMap.get("data");
                for (int i = 0; i < resList.size(); i++) {
                    Map<String, Object> updateMap = new HashMap<>();
                    JSONObject jsonObject = (JSONObject) resList.get(i);
                    logger.debug("[qxpressRegData] jsonObject : " + jsonObject.toString());
                    JSONParser jsonParser = new JSONParser();
                    Object oOrder = jsonParser.parse(jsonObject.get("Order").toString());
                    JSONObject jOrder = (JSONObject) oOrder;

                    // 성공한 경우
                    logger.debug("[qxpressRegData] jOrder : " + jOrder.toString());
                    if ("OK".equals(jOrder.get("RESULT__MSG").toString())) {
                        updateMap.put("xrtInvcSno", jOrder.get("DPC3REFNO1").toString());
                        updateMap.put("invcSno2", jOrder.get("SHIPPING_NO").toString());
                        updateMap.put("localShipper", "");
                        updateMap.put("shippingCompany", "QXPRESS");

                        xrtInvcSnoList.add(updateMap);
                    } else {
                        updateMap.put("xrtInvcSno", qxpressVo.getDpc3refno1());
                        updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
                    }

                    dao.update("OrderInsertMapper.qxpressUpdate", updateMap);
                }
            }
        }

        if (duplicateList.size() != 0) {

            for (QxpressVo qxpressVo : duplicateList) {

                List<QxpressVo> qxpressVoList = new ArrayList<>();
                for (QxpressVo complexGoodsVo : complexGoodsList) {
                    if (complexGoodsVo.getDpc3refno1().equals(qxpressVo.getDpc3refno1())) {
                        qxpressVoList.add(complexGoodsVo);
                    }
                }

                Map<String, Object> retMap = qxpress.createOrder(qxpressVoList);
                String code = (String) retMap.get("code");
                if (!code.equals("200")) {
                    retMap.put("code", code);
                    retMap.put("message", retMap.get("message").toString());
                    retMap.put("data", new ArrayList());
                    return retMap;
                }

                JSONArray resList = (JSONArray) retMap.get("data");

                for (int i = 0; i < resList.size(); i++) {
                    Map<String, Object> updateMap = new HashMap<>();
                    JSONObject jsonObject = (JSONObject) resList.get(i);
                    logger.debug("[qxpressRegData] jsonObject : " + jsonObject.toString());
                    JSONParser jsonParser = new JSONParser();
                    Object oOrder = jsonParser.parse(jsonObject.get("Order").toString());
                    JSONObject jOrder = (JSONObject) oOrder;

                    // 성공한 경우
                    logger.debug("[qxpressRegData] jOrder : " + jOrder.toString());
                    if ("OK".equals(jOrder.get("RESULT__MSG").toString())) {
                        updateMap.put("xrtInvcSno", jOrder.get("DPC3REFNO1").toString());
                        updateMap.put("invcSno2", jOrder.get("SHIPPING_NO").toString());
                        updateMap.put("localShipper", "");
                        updateMap.put("shippingCompany", "QXPRESS");

                        xrtInvcSnoList.add(updateMap);
                    } else {
                        updateMap.put("xrtInvcSno", qxpressVo.getDpc3refno1());
                        updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_API_FAIL);
                    }

                    dao.update("OrderInsertMapper.qxpressUpdate", updateMap);
                }
            }
        }

        Map<String, Object> retuned = new HashMap<>();
        retuned.put("code", "200");
        retuned.put("message", "");
        retuned.put("data", xrtInvcSnoList);
        return retuned;
    }

    public String getPayment(Map<String, Object> param) throws Exception {
        if (param.size() == 0) {
            throw new LingoException("유저 정보가 없습니다.");
        }
        String paymentType = (String) dao.selectOne("OrderInsertMapper.getPayment", param);
        return paymentType;
    }

}
