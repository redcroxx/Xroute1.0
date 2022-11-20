package xrt.lingoframework.common.biz;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.PrintVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class CommonBiz extends DefaultBiz {

    // 대메뉴 가져오기
    public List<LDataMap> getMenuL1(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getMenuL1", param);
    }

    // 중메뉴 가져오기
    public List<LDataMap> getMenuL2(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getMenuL2", param);
    }

    // 소메뉴 가져오기
    public List<LDataMap> getMenuL3(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getMenuL3", param);
    }

    // 공통 버튼 권한 가져오기
    public List<LDataMap> getCommBtnInfo(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getCommBtnInfo", param);
    }

    // 공통코드 값 가져오기
    public List<CodeVO> getCommonCode(String code) throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", code);
        param.put("STATUS", "Y");
        return dao.selectList("CodeCacheMapper.getCommonCode", param);
    }

    // 공통코드 값 (코드 제외) 가져오기
    public List<CodeVO> getCommonCodeOnlyName(String code) throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", code);
        param.put("STATUS", "Y");
        return dao.selectList("CodeCacheMapper.getCommonCodeOnlyName", param);
    }

    // 공통코드 값 가져오기(SNAME 추가)
    public List<CodeVO> getCommonCodeSname(String code, String value2) throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", code);
        param.put("SNAME2", value2);
        param.put("STATUS", "Y");
        return dao.selectList("CodeCacheMapper.getCommonCode", param);
    }

    // 공통코드 값 가져오기(SNAME1 취득)
    public LDataMap getCodeSname(String code, String value) throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", code);
        param.put("CODE", value);
        param.put("STATUS", "Y");
        return (LDataMap) dao.selectOne("CodeCacheMapper.getCodeSname", param);
    }

    // 그리드용 공통코드 값 가져오기
    public String getCommonCodeGrid(String code) throws Exception {
        List<CodeVO> codeList = this.getCommonCode(code);

        String resultValue = "";
        for (int i = 0; i < codeList.size(); i++) {
            if (i == 0) {
                resultValue += codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
            } else {
                resultValue += ";" + codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
            }
        }

        return resultValue;
    }

    // 그리드용 공통코드 값 (코드 제외) 가져오기
    public String getCommonCodeOnlyNameGrid(String code) throws Exception {
        List<CodeVO> codeList = this.getCommonCodeOnlyName(code);

        String resultValue = "";
        for (int i = 0; i < codeList.size(); i++) {
            if (i == 0) {
                resultValue += codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
            } else {
                resultValue += ";" + codeList.get(i).getCode() + ":" + codeList.get(i).getValue();
            }
        }

        return resultValue;
    }

    // 창고코드 목록 가져오기
    public List<CodeVO> getWhcdList(String compcd) throws Exception {
        return dao.selectList("CommonMapper.getWhcdList", compcd);
    }

    // 공지사항 목록 가져오기
    public List<LDataMap> getNoticeList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getNoticeList", param);
    }

    // 미확정 전표 현황 가져오기
    public List<LDataMap> getNotStateList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getNotStateList", param);
    }

    // 당월 거래처 매출 분포도
    public List<LDataMap> getCompRateList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getCompRateList", param);
    }

    // 당월 셀러 매출 분포도
    public List<LDataMap> getCompOrgRateList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getCompOrgRateList", param);
    }

    // 당월 품목 매출 분포도
    public List<LDataMap> getItemRateList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getItemRateList", param);
    }

    // 당월 일자 목록 가져오기
    public List<LDataMap> getThisMonthList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getThisMonthList", param);
    }

    // 당월 입출고 현황 가져오기
    public List<LDataMap> getWiWoRetList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getWiWoRetList", param);
    }

    // 메인화면 로케이션 현재고 현황 가져오기
    public List<LDataMap> getLocInvList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getLocInvList", param);
    }

    // 상품로트속성 정보 가져오기
    public List<LDataMap> getCompItemInfo(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getCompItemInfo", param);
    }

    // 로그인 사용자 정보 조회
    public LDataMap getUserInfo() throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("USERCD", LoginInfo.getUsercd());
        return (LDataMap) dao.selectOne("CommonMapper.getUserInfo", param);
    }

    // 프린터 정보 가져오기
    public PrintVO getPrint(LDataMap param) throws Exception {
        PrintVO printVO = (PrintVO) dao.selectOne("CommonMapper.getPrint", param);
        return printVO;
    }

    // 일정 정보
    public List<LDataMap> getCalendarList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getCalendarList", param);
    }

    // 입고 요약 정보
    public List<LDataMap> getWiSummaryList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getWiSummaryList", param);
    }

    // 출고 요약 정보
    public List<LDataMap> getWoSummaryList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getWoSummaryList", param);
    }

    // 재고 요약 정보
    public List<LDataMap> getIvtSummaryList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getIvtSummaryList", param);
    }

    // 기타 요약 정보
    public List<LDataMap> getEtcSummaryList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getEtcSummaryList", param);
    }

    // 공통 버튼 권한 가져오기(대메뉴/중메뉴에 존재하지 않는 메뉴에 대한 권한 가져오기)
    public List<LDataMap> getCommBtnInfo2(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getCommBtnInfo2", param);
    }

    // 주간 주문상태 현황
    public List<LDataMap> getOrderList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getOrderList", param);
    }

    // 월간 주문등록/입고완료 현황(리스트)
    public List<LDataMap> getOrderShippedCntList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getOrderShippedCntList", param);
    }

    // 월간 주문등록/입고완료 현황
    public LDataMap getOrderShippedCnt(LDataMap param) throws Exception {
        return (LDataMap) dao.selectOne("CommonMapper.getOrderShippedCnt", param);
    }

    // 월 누적 발송량
    public List<LDataMap> getOrderCntList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getOrderCntList", param);
    }

    // 배송 국가 현황
    public List<LDataMap> getOrderNationCntList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getOrderNationCntList", param);
    }

    // TORDER 일자 가져오기
    public List<LDataMap> getTorderThisMonthList(LDataMap param) throws Exception {
        return dao.select("CommonMapper.getTorderThisMonthList", param);
    }

    // 메모 현황.
    public List<LDataMap> getMemoCnt(LDataMap paramData) throws Exception {
        return dao.select("CommonMapper.getMemoCnt", paramData);
    }

    // 주문배송상태 현황.
    public List<LDataMap> getOrderShippingCnt(LDataMap paramData) throws Exception {
        return dao.select("CommonMapper.getOrderShippingCnt", paramData);
    }

    // 프리미엄 국가 코드.
    public LDataMap getCountryList() throws Exception{
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", "USE_COUNTRY");
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("CodeCacheMapper.getCommonCode", param);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        return retMap;
    }

    // DHL 국가 코드.
    public LDataMap getCountryList2() throws Exception{
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("STATUS", "Y");
        List<CodeVO> countrylist2 = dao.selectList("DhlCountryZoneMapper.getDhlCountryCode", param);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist2", countrylist2);
        return retMap;
    }
    
    public LDataMap getCountryList3() throws Exception{
        LDataMap param = new LDataMap();
        param.put("STATUS", "Y");
        List<CodeVO> countrylist3 = dao.selectList("UpsCountryZoneMapper.getUpsCountryCode", param);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist3", countrylist3);
        return retMap;
    }

    public LDataMap view() throws Exception{
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("UpsCountryZoneMapper.getUpsCountryName", param);
        
        LDataMap param2 = new LDataMap();
        param2.put("COMPCD", LoginInfo.getCompcd());
        param2.put("CODEKEY", "DELIVERY_TYPE");
        param2.put("STATUS", "Y");
        List<CodeVO> serviceType = dao.selectList("CodeCacheMapper.getCommonCode", param2);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        retMap.put("serviceType", serviceType);
        return retMap;
    }
}