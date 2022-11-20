package xrt.sys.promotionCode;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/sys/promotionCode")
public class PromotionCodeController {

    Logger logger = LoggerFactory.getLogger(PromotionCodeController.class);

    private PromotionCodeBiz promotionCodeListBiz;

    @Autowired
    public PromotionCodeController(PromotionCodeBiz promotionCodeListBiz) {
        this.promotionCodeListBiz = promotionCodeListBiz;
    }

    /**
     * 최초 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        return "sys/promotionCode/PromotionCodeList";
    }

    /**
     * 등록 팝업
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/create/view.do")
    public String popCreateView(ModelMap model) throws Exception {
        return "sys/promotionCode/PromotionCodePop";
    }

    /**
     * 수정 팝업
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/update/view.do")
    public String popUpdateView(HttpServletRequest request, ModelMap model) throws Exception {

        LDataMap paramMap = new LDataMap();
        paramMap.put("promotionCodeSeq", request.getParameter("promotionCodeSeq"));
        
        model.addAttribute("data", promotionCodeListBiz.popUpdateView(paramMap));
        return "sys/promotionCode/PromotionCodeMPop";
    }

    /**
     * 프로모션 코드 입력 팝업
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/input/view.do")
    public String popInputView(ModelMap model) throws Exception {
        return "sys/popup/PromotionCodeInputPop";
    }

    /**
     * PROMOTION CODE LIST 조회
     * 
     * @param LRespData
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        LRespData resData = promotionCodeListBiz.getSearch(paramMap);
        return resData;
    }

    /**
     * 프로모션 코드 등록
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    public LRespData setSave(@RequestBody PromotionCodeVO paramVO) throws Exception {
        logger.info("paramVO => " + paramVO.toString());

        LRespData retMap = promotionCodeListBiz.setSave(paramVO);
        return retMap;
    }

    /**
     * 프로모션 코드 입력 수정
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/setUpdate.do", method = RequestMethod.POST)
    public LRespData setUpdate(@RequestBody PromotionCodeVO paramVO) throws Exception {
        logger.info("paramVO => " + paramVO.toString());

        LRespData retMap = promotionCodeListBiz.setUpdate(paramVO);
        return retMap;
    }

    /**
     * 프로모션 코드 입력 저장
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/deletePromotionCode.do", method = RequestMethod.POST)
    public LRespData deletePromotionCode(@RequestBody LReqData reqData) throws Exception {
        logger.info("reqData => ");
        reqData.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });
        
        List<LDataMap> dataList = reqData.getParamDataList("dataList");

        LRespData retMap = promotionCodeListBiz.deletePromotionCode(dataList);
        return retMap;
    }

    /**
     * 프로모션 코드 입력 저장
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/input/setPromotionCode.do", method = RequestMethod.POST)
    public LRespData setPromotionCode(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap => ");
        paramMap.entrySet().forEach(entry -> {
            logger.info("" + entry.getKey() + " : " + entry.getValue());
        });

        LRespData retMap = promotionCodeListBiz.setPromotionCode(paramMap);
        return retMap;
    }
}
