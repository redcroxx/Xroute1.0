package xrt.lingoframework.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import net.sf.ehcache.CacheManager;
import xrt.alexcloud.common.CommonConst;
import xrt.fulfillment.system.WeightCalculationBiz;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.common.vo.PrintVO;
import xrt.lingoframework.utils.CookieUtils;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;
import xrt.lingoframework.utils.Util;

@Controller
public class CommonController {

    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    private CommonBiz commonBiz;
    private WeightCalculationBiz weightCalculationBiz;

    @Autowired
    public CommonController(CommonBiz commonBiz, WeightCalculationBiz weightCalculationBiz) {
        super();
        this.commonBiz = commonBiz;
        this.weightCalculationBiz = weightCalculationBiz;
    }

    @Value("#{config['c.version']}")
    private String version;
    @Value("#{config['c.debugtype']}")
    private String debugtype;

    // 공통 CSS,JS Import
    @RequestMapping(value = "/comm/commJsCsImpt.do")
    public String commJsCsImpt(ModelMap model) throws Exception {
        model.addAttribute("LANGCD", CookieUtils.getCookie("Language"));
        model.addAttribute("VERSION", version);

        if ("REAL".equals(debugtype)) {
            model.addAttribute("RG_LIC", "/js/realgrid/limit/realgridjs-lic.js");
            model.addAttribute("RG_JS", "/js/realgrid/limit/realgridjs.1.1.34.min.js");
            model.addAttribute("RG_API", "/js/realgrid/limit/realgridjs-api.1.1.34.js");
            model.addAttribute("RG_JZIP", "/js/realgrid/limit/jszip.min.js");
            model.addAttribute("RG_SKIN", "/js/realgrid/RealGridSkins.js");
        } else {
            model.addAttribute("RG_LIC", "/js/realgrid/realgridjs-lic.js");
            model.addAttribute("RG_JS", "/js/realgrid/realgridjs_eval.1.1.34.min.js");
            model.addAttribute("RG_API", "/js/realgrid/realgridjs-api.1.1.34.js");
            model.addAttribute("RG_JZIP", "/js/realgrid/jszip.min.js");
            model.addAttribute("RG_SKIN", "/js/realgrid/RealGridSkins.js");
        }

        return "common/commJsCsImpt";
    }

    // 화면공통 CSS,JS Import
    @RequestMapping(value = "/comm/contJsCsImpt.do")
    public String contJsCsImpt(ModelMap model) throws Exception {
        model.addAttribute("LANGCD", CookieUtils.getCookie("Language"));
        model.addAttribute("VERSION", version);
        if ("REAL".equals(debugtype)) {
            model.addAttribute("RG_LIC", "/js/realgrid/limit/realgridjs-lic.js");
            model.addAttribute("RG_JS", "/js/realgrid/limit/realgridjs.1.1.34.min.js");
            model.addAttribute("RG_API", "/js/realgrid/limit/realgridjs-api.1.1.34.js");
            model.addAttribute("RG_JZIP", "/js/realgrid/limit/jszip.min.js");
            model.addAttribute("RG_SKIN", "/js/realgrid/RealGridSkins.js");
            model.addAttribute("PASS_BOOK_URL", "https://ezauth.settlebank.co.kr/js/SettlePay.js");
        } else {
            model.addAttribute("RG_LIC", "/js/realgrid/realgridjs-lic.js");
            model.addAttribute("RG_JS", "/js/realgrid/realgridjs_eval.1.1.34.min.js");
            model.addAttribute("RG_API", "/js/realgrid/realgridjs-api.1.1.34.js");
            model.addAttribute("RG_JZIP", "/js/realgrid/jszip.min.js");
            model.addAttribute("RG_SKIN", "/js/realgrid/RealGridSkins.js");
            model.addAttribute("PASS_BOOK_URL", "https://tbezauth.settlebank.co.kr/js/SettlePay.js");
        }

        return "common/contJsCsImpt";
    }

    // 메인
    @RequestMapping(value = "/comm/main.do")
    public String main(ModelMap model) throws Exception {

        LDataMap param = new LDataMap();
        param.put("LANGCD", CookieUtils.getCookie("Language"));
        param.put("USERCD", LoginInfo.getUsercd());

        Map<String, Object> constMap = new HashMap<String, Object>();
        constMap.put("XROUTE_ADMIN", CommonConst.XROUTE_ADMIN);
        constMap.put("CENTER_ADMIN", CommonConst.CENTER_ADMIN);
        constMap.put("CENTER_SUPER", CommonConst.CENTER_SUPER_USER);
        constMap.put("CENTER_USER", CommonConst.CENTER_USER);
        constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        constMap.put("SELLER_SUPER", CommonConst.SELLER_SUPER_USER);
        constMap.put("SELLER_USER", CommonConst.SELLER_USER);
        // 권한
        model.addAttribute("constMap", constMap);
        // 대메뉴
        List<LDataMap> resultMenuL1List = commonBiz.getMenuL1(param);
        model.addAttribute("resultMenuL1List", resultMenuL1List);
        return "common/main";
    }

    // 좌측메뉴
    @RequestMapping(value = "/comm/leftmenu.do")
    public String leftmenu() throws Exception {
        return "common/leftmenu";
    }

    // 좌측메뉴 처리
    @RequestMapping(value = "/comm/leftmenuLoad.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData leftmenuLoad(@RequestBody LReqData reqData) throws Exception {
        String menu = reqData.getParamDataVal("menu");

        LDataMap param = new LDataMap();
        param.put("LANGCD", CookieUtils.getCookie("Language"));
        param.put("USERCD", LoginInfo.getUsercd());
        param.put("MENUL1KEY", menu);
        // 중메뉴
        List<LDataMap> resultMenuL2List = commonBiz.getMenuL2(param);
        // 소메뉴
        List<LDataMap> resultMenuL3List = commonBiz.getMenuL3(param);

        LRespData respData = new LRespData();
        respData.put("resultMenuL2List", resultMenuL2List);
        respData.put("resultMenuL3List", resultMenuL3List);
        return respData;
    }
    // 업무화면 상단
    @RequestMapping(value = "/comm/contentTop.do")
    public String contentTop() throws Exception {
        return "common/contentTop";
    }
    // 업무화면 하단
    @RequestMapping(value = "/comm/contentBottom.do")
    public String contentBottom() throws Exception {
        return "common/contentBottom";
    }
    // 로그인정보 가져오기
    @RequestMapping(value = "/comm/getLoginInfo.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getLoginInfo(@RequestBody LReqData reqData, HttpServletRequest req) throws Exception {
        LoginVO loginVO = (LoginVO) req.getSession().getAttribute("loginVO");

        LRespData respData = new LRespData();
        respData.put("loginVO", loginVO);
        return respData;
    }
    // 프린터정보 가져오기
    @RequestMapping(value = "/comm/getPrintInfo.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getPrintInfo(@RequestBody LReqData reqData, HttpServletRequest req) throws Exception {
        // PrintVO printVO = (PrintVO) req.getSession().getAttribute("printVO");
        LDataMap param = new LDataMap();
        param.put("USERCD", LoginInfo.getUsercd());
        PrintVO printVO = commonBiz.getPrint(param);
        
        LRespData respData = new LRespData();
        respData.put("printVO", printVO);
        return respData;
    }

    // 메인화면 - 셀러.
    @RequestMapping(value = "/comm/mainContentSeller.do")
    public String mainContentSeller(ModelMap model) throws Exception {
        List<CodeVO> CODE_WHCD = commonBiz.getWhcdList(LoginInfo.getCompcd()); // 창고코드.
        String GCODE_DOCSTS = commonBiz.getCommonCodeOnlyNameGrid("DOCSTS"); // 전자결재상태.
        LDataMap map = commonBiz.getCountryList(); // 프리미엄 공통 국가 코드.
        LDataMap map2 = commonBiz.getCountryList2(); // DHL 공통 국가 코드.
        LDataMap map3 = commonBiz.getCountryList3(); // UPS 공통 국가 코드.
        model.addAttribute("CODE_WHCD", CODE_WHCD);
        model.addAttribute("GCODE_DOCSTS", GCODE_DOCSTS);
        model.addAllAttributes(map);
        model.addAllAttributes(map2);
        model.addAllAttributes(map3);
        return "common/mainContentSeller";
    }

    // 메인화면 - 관리자.
    @RequestMapping(value = "/comm/mainContent.do")
    public String mainContent4(ModelMap model) throws Exception {
        List<CodeVO> CODE_WHCD = commonBiz.getWhcdList(LoginInfo.getCompcd()); // 창고코드.
        String GCODE_DOCSTS = commonBiz.getCommonCodeOnlyNameGrid("DOCSTS"); // 전자결재상태.

        model.addAttribute("CODE_WHCD", CODE_WHCD);
        model.addAttribute("GCODE_DOCSTS", GCODE_DOCSTS);
        return "common/mainContent";
    }

    // 메인 화면 데이터 조회.
    @RequestMapping(value = "/comm/getMainContentData.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getMainContentData(@RequestBody LReqData reqData) throws Exception {
        logger.info("LReqData :" + reqData.toString());
        LDataMap paramData = reqData.getParamDataMap("paramData");
        // 공지사항. - 셀러, 관리자.
        List<LDataMap> resultNoticeList = commonBiz.getNoticeList(paramData);
        // 메모 현황. - 셀러
        List<LDataMap> resultMemoCnt = commonBiz.getMemoCnt(paramData);
        // 주문 배송 현황. - 셀러
        List<LDataMap> resultOrderShippingCnt = commonBiz.getOrderShippingCnt(paramData);
        
        // 주간 주문상태 현황
        List<LDataMap> resultOrderList = commonBiz.getOrderList(paramData);
        // 월간 주문등록/입고완료 현황(리스트)
        List<LDataMap> resultOrderShippedCntList = commonBiz.getOrderShippedCntList(paramData);
        // 월간 주문등록/입고완료 현황
        LDataMap resultOrderShippedCnt = commonBiz.getOrderShippedCnt(paramData);
        // 월 누적 발송량
        List<LDataMap> resultOrderCntList = commonBiz.getOrderCntList(paramData);
        // 배송 국가 현황
        List<LDataMap> resultOrderNationCntList = commonBiz.getOrderNationCntList(paramData);
        // 당월 일자목록
        List<LDataMap> resultThisMonthList = commonBiz.getTorderThisMonthList(paramData);

        LRespData respData = new LRespData();
        respData.put("resultNoticeList", resultNoticeList);
        respData.put("resultMemoCnt", resultMemoCnt);
        respData.put("resultOrderShippingCnt", resultOrderShippingCnt);
        respData.put("resultOrderList", resultOrderList);
        respData.put("resultOrderShippedCntList", resultOrderShippedCntList);
        respData.put("resultOrderShippedCnt", resultOrderShippedCnt);
        respData.put("resultOrderCntList", resultOrderCntList);
        respData.put("resultOrderNationCntList", resultOrderNationCntList);
        respData.put("resultThisMonthList", resultThisMonthList);
        return respData;
    }
    // 공통 버튼 권한 가져오기
    @RequestMapping(value = "/comm/commonBtnInfo.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getCommBtnInfo(@RequestBody LReqData reqData) throws Exception {
        String appurl = reqData.getParamDataVal("appurl");
        String menul1key = reqData.getParamDataVal("menul1key");
        String menul2key = reqData.getParamDataVal("menul2key");
        String appkey = reqData.getParamDataVal("appkey");

        LDataMap param = new LDataMap();
        param.put("LANGCD", CookieUtils.getCookie("Language"));
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("USERCD", LoginInfo.getUsercd());
        param.put("APPURL", appurl);
        param.put("MENUL1KEY", menul1key);
        param.put("MENUL2KEY", menul2key);
        param.put("APPKEY", appkey);

        List<LDataMap> resultCommBtnInfo = commonBiz.getCommBtnInfo(param);
        
        LRespData respData = new LRespData();
        respData.put("resultCommBtnInfo", resultCommBtnInfo);
        return respData;
    }
    // 공통 버튼 권한 가져오기(대메뉴/중메뉴에 존재하지 않는 프로그램에 대한 권한 가져오기)
    @RequestMapping(value = "/comm/commonBtnInfo2.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getCommBtnInfo2(@RequestBody LReqData reqData) throws Exception {
        String appurl = reqData.getParamDataVal("appurl");
        String menul1key = reqData.getParamDataVal("menul1key");
        String menul2key = reqData.getParamDataVal("menul2key");
        String appkey = reqData.getParamDataVal("appkey");

        LDataMap param = new LDataMap();
        param.put("LANGCD", CookieUtils.getCookie("Language"));
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("USERCD", LoginInfo.getUsercd());
        param.put("APPURL", appurl);
        param.put("MENUL1KEY", menul1key);
        param.put("MENUL2KEY", menul2key);
        param.put("APPKEY", appkey);

        List<LDataMap> resultCommBtnInfo = commonBiz.getCommBtnInfo2(param);
        
        LRespData respData = new LRespData();
        respData.put("resultCommBtnInfo", resultCommBtnInfo);
        return respData;
    }
    // 쿼리 캐시 초기화
    @RequestMapping(value = "/sql/initcache.do", method = RequestMethod.POST)
    public void initcache() throws Exception {
        CacheManager.getInstance().clearAll();
    }
    // 회사별 상품정보/로트속성 4,5
    @RequestMapping(value = "/comm/compItemSearch.do")
    public String compItemSearch(ModelMap model) throws Exception {

        List<CodeVO> codeLOT4 = commonBiz.getCommonCodeOnlyName("LOT4");
        List<CodeVO> codeLOT5 = commonBiz.getCommonCodeOnlyName("LOT5");

        model.addAttribute("gCodeLOT4", Util.getCommonCodeGridAll(codeLOT4));
        model.addAttribute("gCodeLOT5", Util.getCommonCodeGridAll(codeLOT5));

        List<CodeVO> codeFUSER01 = commonBiz.getCommonCodeOnlyName("FUSER01");
        List<CodeVO> codeFUSER02 = commonBiz.getCommonCodeOnlyName("FUSER02");
        List<CodeVO> codeFUSER03 = commonBiz.getCommonCodeOnlyName("FUSER03");
        List<CodeVO> codeFUSER04 = commonBiz.getCommonCodeOnlyName("FUSER04");
        List<CodeVO> codeFUSER05 = commonBiz.getCommonCodeOnlyName("FUSER05");

        model.addAttribute("codeFUSER01", codeFUSER01);
        model.addAttribute("codeFUSER02", codeFUSER02);
        model.addAttribute("codeFUSER03", codeFUSER03);
        model.addAttribute("codeFUSER04", codeFUSER04);
        model.addAttribute("codeFUSER05", codeFUSER05);
        model.addAttribute("gCodeFUSER01", Util.getCommonCodeGrid(codeFUSER01));
        model.addAttribute("gCodeFUSER02", Util.getCommonCodeGrid(codeFUSER02));
        model.addAttribute("gCodeFUSER03", Util.getCommonCodeGrid(codeFUSER03));
        model.addAttribute("gCodeFUSER04", Util.getCommonCodeGrid(codeFUSER04));
        model.addAttribute("gCodeFUSER05", Util.getCommonCodeGrid(codeFUSER05));

        return "common/compItemSearch";
    }
    // 유비리포트 라벨 팝업
    // 프린트 1번(송장)
    @RequestMapping(value = "/comm/report/ubiReportLabel.do")
    public String ubiReportLabel(HttpServletRequest request, ModelMap model) throws Exception {
        String dir = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
        model.addAttribute("DIR", dir);
        return "common/ubiReportLabel";
    }
    // 유비리포트 라벨 팝업
    // 프린트 3번(등록증 및 기타)
    @RequestMapping(value = "/comm/report/ubiReportLabelEtc.do")
    public String ubiReportLabelEtc(HttpServletRequest request, ModelMap model) throws Exception {
        String dir = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
        model.addAttribute("DIR", dir);
        return "common/ubiReportLabelEtc";
    }

    @RequestMapping(value = "/error/error.do")
    public String error() {
        return "error/error";
    }
    
    // 개인정보취급방침 팝업.
    @RequestMapping(value = "/comm/privacyPolicy.do", method = RequestMethod.GET)
    public String privacyPolicyView() throws Exception {
        return "common/privacyPolicy";
    }
    
    // 이용약관 팝업.
    @RequestMapping(value = "/comm/agreement.do", method = RequestMethod.GET)
    public String agreementView() throws Exception {
        return "common/agreement";
    }
    
    // 셀러 메인 페이지 배송비 계산.
    @RequestMapping(value = "/comm/calc.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData calc(@RequestBody LDataMap paramMap)throws Exception{
        LRespData resData = new LRespData();
        LDataMap calcResult = weightCalculationBiz.getWeightCalculation(paramMap);
        resData.put("resultPrice", calcResult.getString("resultPrice"));
        return resData;
    }
    

}