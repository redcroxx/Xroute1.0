package xrt.fulfillment.bol;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * HBL Controller
 * 
 * @since 2020-12-17
 * @author wnkim
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/bol/house/bl")
public class HouseBLController {

    Logger logger = LoggerFactory.getLogger(HouseBLController.class);

    private HouseBLBiz houseBlBiz;

    @Autowired
    public HouseBLController(HouseBLBiz houseBlBiz) {
        super();
        this.houseBlBiz = houseBlBiz;
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
        return "fulfillment/bol/HouseBLList";
    }

    /**
     * HOUSE_BL 조회
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVO : " + paramVO.toString());
        LRespData resData = houseBlBiz.getSearch(paramVO);
        return resData;
    }
    
    /**
     * HBL 완료 처리
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/setComplete.do", method = RequestMethod.POST)
    public LRespData setComplete(@RequestBody LReqData paramMap) throws Exception {
        logger.debug("LReqData : " +  paramMap.toString());
        LRespData resData = houseBlBiz.setComplete(paramMap);
        return resData;
    }
    
    /**
     * 최초 House B/L 수정 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        return "fulfillment/bol/HouseBLPop";
    }
    
    /**
     * 선적 B/L 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getPopSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LDataMap : " +  paramMap.toString());
        LRespData resData = houseBlBiz.getPopSearch(paramMap);
        return resData;
    }
    
    /**
     * 선적 B/L 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/getHouseBL.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getHouseBL(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LDataMap : " +  paramMap.toString());
       LRespData resData = houseBlBiz.getHouseBL(paramMap);
       return resData;
    }
    
    /**
     * 최초 House B/L 수정 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/deleteShipmentBL.do")
    @ResponseBody
    public LRespData deleteShipmentBL(@RequestBody LReqData dataMap) throws Exception {
        logger.debug("LReqData : " + dataMap.toString());
        LRespData resData = houseBlBiz.deleteShipmentBL(dataMap);
        return resData;
    }
    
    /**
     * House B/L 수정 및 상태변경
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    public LRespData setPopSave(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LReqData : " + paramMap.toString());
        LRespData resData = houseBlBiz.setPopSave(paramMap);
        return resData;
    }
    
    /**
     * 최초 House B/L 생성 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/create/view.do")
    public String createPopView(ModelMap model) throws Exception {
        return "fulfillment/bol/CreateHouseBLPop";
    }
    
    /**
     * House B/L 수정 / 선적 상태변경
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/create/setSave.do", method = RequestMethod.POST)
    public LRespData setCreatePopSave(@RequestBody LReqData dataMap) throws Exception {
        logger.debug("LReqData : " + dataMap.toString());
        LRespData resData = houseBlBiz.setCreatePopSave(dataMap);
        return resData;
    }
}
