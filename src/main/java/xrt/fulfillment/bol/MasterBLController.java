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
 * MBL Controller
 * 
 * @since 2020-12-23
 * @author wnkim
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/bol/master/bl")
public class MasterBLController {

    Logger logger = LoggerFactory.getLogger(MasterBLController.class);

    private MasterBLBiz masterBlBiz;

    @Autowired
    public MasterBLController(MasterBLBiz masterBlBiz) {
        super();
        this.masterBlBiz = masterBlBiz;
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
        return "fulfillment/bol/MasterBLList";
    }

    /**
     * MASTER_BL 조회
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVO : " + paramVO.toString());
        LRespData resData = masterBlBiz.getSearch(paramVO);
        return resData;
    }
    
    /**
     * MBL 상태완료 처리
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/setComplete.do", method = RequestMethod.POST)
    public LRespData setComplete(@RequestBody LReqData paramMap) throws Exception {
        logger.debug("LReqData : " +  paramMap.toString());
        LRespData resData = masterBlBiz.setComplete(paramMap);
        return resData;
    }
    
    /**
     * 최초 MBL 수정 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        return "fulfillment/bol/MasterBLPop";
    }
    
    /**
     * HBL 목록 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/getSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getPopSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LDataMap : " +  paramMap.toString());
        LRespData resData = masterBlBiz.getPopSearch(paramMap);
        return resData;
    }
    
    /**
     * HBL 정보 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/getMasterBL.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getHouseBL(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LDataMap : " +  paramMap.toString());
       LRespData resData = masterBlBiz.getMasterBl(paramMap);
       return resData;
    }
    
    /**
     * 최초 MBL 수정 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/deleteHouseBL.do")
    @ResponseBody
    public LRespData deleteShipmentBL(@RequestBody LReqData dataMap) throws Exception {
        logger.debug("LReqData : " + dataMap.toString());
        LRespData resData = masterBlBiz.deleteHouseBl(dataMap);
        return resData;
    }
    
    /**
     * MBL 수정 및 상태변경
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    public LRespData setPopSave(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LReqData : " + paramMap.toString());
        LRespData resData = masterBlBiz.setPopSave(paramMap);
        return resData;
    }
    
    /**
     * 최초 MBL 생성 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/create/view.do")
    public String createPopView(ModelMap model) throws Exception {
        return "fulfillment/bol/CreateMasterBLPop";
    }
    
    /**
     * MBL 수정 및 상태변경
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/create/setSave.do", method = RequestMethod.POST)
    public LRespData setCreatePopSave(@RequestBody LReqData dataMap) throws Exception {
        logger.debug("LReqData : " + dataMap.toString());
        LRespData resData = masterBlBiz.setCreatePopSave(dataMap);
        return resData;
    }
}
