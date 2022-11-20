package xrt.alexcloud.api.atomy;

import java.util.List;
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
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.OrderVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/atomy/orderList")
public class AtomyOrderListController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(AtomyOrderListController.class);
    
    private CommonBiz commonBiz;
    private AtomyOrderListBiz atomyOrderListBiz;

    @Autowired
    public AtomyOrderListController(CommonBiz commonBiz, AtomyOrderListBiz atomyOrderListBiz) {
        this.commonBiz = commonBiz;
        this.atomyOrderListBiz = atomyOrderListBiz;
    }
    
    @Value("#{config['c.debugtype']}")
    private String debugtype;
    
    // 화면 호출.
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        
        String atomyOrgcd = CommonConst.ATOMY_DEV_ORGCD;
        
        if (debugtype.equals("REAL")) {
            atomyOrgcd = CommonConst.ATOMY_REAL_ORGCD;
        }

        List<CodeVO> countrylist = commonBiz.getCommonCode("UPS_NATION");
        List<CodeVO> orderkeyword = commonBiz.getCommonCode("ORDERKEYWORD");
        List<CodeVO> shopeeCountry = commonBiz.getCommonCode("SHOPEE_COUNTRY");
        List<CodeVO> fileseqlist = commonBiz.getCommonCode("FILESEQLIST");

        String XROUTE_ADMIN = CommonConst.XROUTE_ADMIN;
        String CENTER_ADMIN = CommonConst.CENTER_ADMIN;
        String SELLER_ADMIN = CommonConst.SELLER_ADMIN;

        // 권한.
        model.addAttribute("sOrgCd", atomyOrgcd);
        model.addAttribute("XROUTE_ADMIN", XROUTE_ADMIN);
        model.addAttribute("CENTER_ADMIN", CENTER_ADMIN);
        model.addAttribute("SELLER_ADMIN", SELLER_ADMIN);
        model.addAttribute("countrylist", countrylist);
        model.addAttribute("shopeeCountry", shopeeCountry);
        model.addAttribute("orderkeyword", orderkeyword);
        model.addAttribute("fileseqlist", fileseqlist);

        return "fulfillment/atomy/AtomyOrderList";
    }
    
    // 검색.
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {
        List<OrderVo> orderList = atomyOrderListBiz.getSearch(paramVo);
        LRespData retMap = new LRespData();
        retMap.put("resultList", orderList);
        return retMap;
    }
    
    // 애터미 오더수정 팝업.
    @RequestMapping(value = "/pop/view.do")
    public String popView() throws Exception {
        return "fulfillment/atomy/AtomyOrderModifyPop";
    }
    
    /**
     * 공통 파라메터 및 아마존 주문 목록 검증 및 xroute Torder, TorderDtl 데이터 변환 후 저장
     * @param reqData
     * @return JSON
     * @throws Exception
     */
    @RequestMapping(value = "/upload.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData upload(@RequestBody LReqData reqData) throws Exception {

        List<LDataMap> dataList = reqData.getParamDataList("dataList");

        LDataMap validMap = atomyOrderListBiz.valid(dataList);
        String code = validMap.getString("code");
        if (!code.equals("200")) {
            throw new LingoException("오더 수정 파일 업로드시 \n 오류가 발생 하였습니다.");
        }

        LDataMap procgMap = atomyOrderListBiz.setTorder(dataList);

        LRespData respData = new LRespData();
        respData.put("CODE", procgMap.getString("CODE"));
        respData.put("MESSAGE", procgMap.getString("MESSAGE"));
        return respData;
    }
}
