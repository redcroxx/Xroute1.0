package xrt.interfaces.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.api.settlebank.SettleBankAPI;
import xrt.alexcloud.api.settlebank.vo.SettleBankResNotiVO;
import xrt.interfaces.common.mapper.APIMapper;
import xrt.interfaces.common.service.APIService;
import xrt.interfaces.common.vo.ApiAuthKeyVo;
import xrt.interfaces.common.vo.ParamVo;
import xrt.interfaces.common.vo.ReqOrderVo;
import xrt.interfaces.common.vo.ResResultVo;
import xrt.interfaces.common.vo.TorderVo;
import xrt.lingoframework.utils.LDataMap;

@Controller
@RequestMapping(value = "/api")
public class APIController {

    Logger logger = LoggerFactory.getLogger(APIController.class);

    private APIMapper apiMapper;
    private APIService apiService;
    private SettleBankAPI settleBankAPI;

    @Autowired
    public APIController(APIMapper apiMapper, APIService apiService, SettleBankAPI settleBankAPI) {
        this.apiMapper = apiMapper;
        this.apiService = apiService;
        this.settleBankAPI = settleBankAPI;
    }

    @ResponseBody
    @RequestMapping(value = "/shippo/shipment.do", method = RequestMethod.POST)
    public Map<String, Object> shippoShipment(@RequestBody ParamVo paramVO) {
        logger.debug("[shippoShipment] paramVo : [" + paramVO.toString() + "]");

        Map<String, Object> retMap = new HashMap<>();

        try {
            logger.debug("ParamVo : " + paramVO.toString());
            // 01. Xroute 송장번호 확인 및 ShippoVo 데이터 검증
            Map<String, Object> validMap = apiService.shippoValid(paramVO, "shipment");
            if (!validMap.get("code").equals("200")) {
                retMap.put("code", validMap.get("code"));
                retMap.put("message", validMap.get("message"));
                retMap.put("data", "");
                return retMap;
            }

            // 02. Shipment 생성
            List<TorderVo> shippoList = (List<TorderVo>) validMap.get("data");
            String state = (String) validMap.get("state");
            TorderVo torderVo = shippoList.get(0);
            Map<String, Object> shipmentMap = apiService.shippoShipment(torderVo, state);
            if (!shipmentMap.get("code").equals("200")) {
                retMap.put("code", shipmentMap.get("code"));
                retMap.put("message", shipmentMap.get("message"));
                retMap.put("data", "");
                return retMap;
            }

            // Map<String, Object> aftershipList =
            // apiService.addAfterShipTrackings(paramVo);
            // if (!aftershipList.get("code").equals("200")) {
            // retMap.put("code", aftershipList.get("code"));
            // retMap.put("message", aftershipList.get("message"));
            // retMap.put("data", "");
            // return retMap;
            // }

            retMap.put("code", shipmentMap.get("code"));
            retMap.put("message", shipmentMap.get("message"));
            retMap.put("data", shipmentMap.get("data"));
            return retMap;
        } catch (Exception e) {

            retMap.put("code", "500");
            retMap.put("message", "알수없는 오류가 발생하 였습니다.");
            retMap.put("data", "");
            return retMap;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/shippo/refund.do", method = RequestMethod.POST)
    public Map<String, Object> shippoRefund(ParamVo paramVO) {
        logger.debug("[shippoRefund] paramVo : [" + paramVO.toString() + "]");

        Map<String, Object> retMap = new HashMap<>();

        try {

            // 01. Xroute 송장번호 확인 및 ShippoVo 데이터 검증
            Map<String, Object> validMap = apiService.shippoValid(paramVO, "refund");
            if (!validMap.get("code").equals("200")) {
                retMap.put("code", validMap.get("code"));
                retMap.put("message", validMap.get("message"));
                retMap.put("data", "");
                return retMap;
            }

            // 02. Shipment 생성
            List<TorderVo> shippoList = (List<TorderVo>) validMap.get("data");
            String state = (String) validMap.get("state");
            Map<String, Object> refundMap = apiService.shippoRefund(shippoList, state);
            if (!refundMap.get("code").equals("200")) {
                retMap.put("code", refundMap.get("code"));
                retMap.put("message", refundMap.get("message"));
                retMap.put("data", "");
                return retMap;
            }

            retMap.put("code", refundMap.get("code"));
            retMap.put("message", refundMap.get("message"));
            retMap.put("data", refundMap.get("data"));
            return retMap;
        } catch (Exception e) {

            retMap.put("code", "500");
            retMap.put("message", "알수없는 오류가 발생하 였습니다.");
            retMap.put("data", "");
            return retMap;
        }
    }

    @ResponseBody
    @RequestMapping(value = "/efs/getTrackStatus.do", method = RequestMethod.POST)
    public Map<String, Object> efsGetTrackStatus(ParamVo paramVO) {
        logger.debug("[efsGetTrackStatus] paramVo : [" + paramVO.toString() + "]");

        Map<String, Object> retMap = new HashMap<>();

        try {
            Map<String, Object> refundMap = apiService.efsGetTrackStatus(paramVO);
            if (!refundMap.get("code").equals("200")) {
                retMap.put("code", refundMap.get("code"));
                retMap.put("message", refundMap.get("message"));
                retMap.put("data", "");
                return retMap;
            }

            retMap.put("code", refundMap.get("code"));
            retMap.put("message", refundMap.get("message"));
            retMap.put("data", refundMap.get("data"));
            return retMap;
        } catch (Exception e) {

            retMap.put("code", "500");
            retMap.put("message", "알수없는 오류가 발생하 였습니다.");
            retMap.put("data", "");
            return retMap;
        }
    }

    @RequestMapping(value = "/settle/responseData.do", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE, produces = { MediaType.APPLICATION_ATOM_XML_VALUE,
            MediaType.APPLICATION_JSON_VALUE })
    public LDataMap settleComplateData(SettleBankResNotiVO paramVO) throws Exception {
        logger.debug("SettleBankResNotiVO : " + paramVO.toString());

        LDataMap retMap = settleBankAPI.getSettleBankResult(paramVO);

        retMap.put("code", "200");
        retMap.put("message", "success");
        return retMap;
    }

    @ResponseBody
    @RequestMapping(value = "/order/create.do", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
    public ResResultVo createOrder(HttpServletRequest request, @RequestBody ReqOrderVo paramVo) throws Exception {
        logger.debug("[createOrder] paramVo : [" + paramVo.toString() + "]");

        String authKey = request.getHeader("xrouteHeadData");
        logger.debug("1. Head 정보 확인 xrouteHeadData : " + authKey);
        if (authKey == null || authKey.equals("")) {
            ResResultVo resResultVo = new ResResultVo();
            resResultVo.setResultCode(404);
            resResultVo.setResultMessage("xrouteHeadData정보가 누락되었습니다.");
            return resResultVo;
        }

        String ipAddr = request.getHeader("X-FORWARDED-FOR");
        if (ipAddr == null) {
            ipAddr = request.getRemoteAddr();
        }

        paramVo.setTerminalcd(ipAddr);

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("authKey", authKey);
        ApiAuthKeyVo apiAuthKeyVo = apiMapper.getAuthCheck(paramMap);
        logger.debug("2. 기본 계정 정보 가져오기.");
        if (apiAuthKeyVo == null) {
            ResResultVo resResultVo = new ResResultVo();
            resResultVo.setResultCode(404);
            resResultVo.setResultMessage("등록되지 않은 사용자입니다.");
            return resResultVo;
        }

        ResResultVo resResultVo = apiService.createOrder(paramVo, apiAuthKeyVo);
        return resResultVo;
    }
}
