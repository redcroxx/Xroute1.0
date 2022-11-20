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
 * 선적 대기 Controller
 * 
 * @since 2020-12-15
 * @author wnkim
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/bol/shipment/wait")
public class ShipmentWaitController {

    Logger logger = LoggerFactory.getLogger(ShipmentWaitController.class);

    private ShipmentWaitBiz shipmentWaitBiz;

    @Autowired
    public ShipmentWaitController(ShipmentWaitBiz shipmentWaitBiz) {
        super();
        this.shipmentWaitBiz = shipmentWaitBiz;
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

        LDataMap map = shipmentWaitBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/bol/ShipmentWaitList";
    }

    /**
     * TOrder 조회
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVO : " + paramVO.toString());
        LRespData resData = shipmentWaitBiz.getSearch(paramVO);
        return resData;
    }

    /**
     * 최초 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/orderView.do")
    public String orderView(ModelMap model) throws Exception {
        LDataMap map = shipmentWaitBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/bol/BOLOrderList";
    }

    /**
     * 주문 정보 목록
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getOrderSearch.do", method = RequestMethod.POST)
    public LRespData getOrderSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVO : " + System.lineSeparator() + paramVO.toString());
        LRespData resData = shipmentWaitBiz.getOrderSearch(paramVO);
        return resData;
    }

    /**
     * 최초 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        LDataMap map = shipmentWaitBiz.popView();
        model.addAllAttributes(map);
        return "fulfillment/bol/ShipmentWaitPop";
    }

    /**
     * 선적 등록
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    public LRespData setPopSave(@RequestBody LReqData paramMap) throws Exception {
        logger.debug("LReqData : " + paramMap.toString());
        // ClientInfo.getClntIP(), LoginInfo;
        LRespData resData = shipmentWaitBiz.setPopSave(paramMap);
        return resData;
    }
}
