package xrt.alexcloud.api.atomy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LDataMap;

@Controller
@RequestMapping(value = "/atomy/api")
public class AtomyAPIController {

    Logger logger = LoggerFactory.getLogger(AtomyAPIController.class);

    private AtomyAPIBiz atomyAPIBiz;
    
    @Autowired
    public AtomyAPIController(AtomyAPIBiz atomyAPIBiz) {
        super();
        this.atomyAPIBiz = atomyAPIBiz;
    }

    // 애터미가 요율을 조회하는 API.
    @RequestMapping(value = "/getRate.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap getRate(@RequestBody AtomyAPIParamVO paramVO) {
        LDataMap retMap = new LDataMap();
        try {
            LDataMap resultMap = atomyAPIBiz.valid(paramVO);
            AtomyAPIParamVO validVO = (AtomyAPIParamVO) resultMap.get("validVO");
            
            if (resultMap.getString("code").equals("1")) {
                retMap = atomyAPIBiz.getRate(validVO); // 요율 정보.
            }else {
                retMap.put("code", "404");
                retMap.put("message", "faild");
                retMap.put("price", "");
                retMap.put("box", "");
            }
            return retMap;
        } catch (Exception e) {
            retMap.put("code", "500");
            retMap.put("message", e.getMessage());
            retMap.put("price", "");
            retMap.put("box", "");
            return retMap;
        }
    }
    
    // 주문취소가 가능한지 애터미에서 로지포커스 서버로 질의하는 기능 API.
    @RequestMapping(value = "/orderCancelCheck.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap orderCancelCheck(@RequestBody AtomyAPIParamVO paramVO) {
        LDataMap retMap = new LDataMap();
        
        logger.info("paramVO : " + paramVO.toString());
        
        try {
            LDataMap resultMap = atomyAPIBiz.orderCancelValid(paramVO);
            
            if (resultMap.getString("code").equals("1")) {
                AtomyAPIParamVO validVO = (AtomyAPIParamVO) resultMap.get("validVO");
                retMap = atomyAPIBiz.orderCancelCheck(validVO); // 주문번호 확인.
            }else {
                retMap.put("code", "500");
                retMap.put("message", "Parameter Error");
            }
            return retMap;
        } catch (Exception e) {
            retMap.put("code", "500");
            retMap.put("message", "API ERROR");
            return retMap;
        }
    }
    
    // [주문취소가 가능한 상태] (Shipment = 0) 에서 애터미 결제 프로세스 문제로 [주문취소 철회] 신호 받는 API.
    @RequestMapping(value = "/orderCancel.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap orderCancel(@RequestBody AtomyAPIParamVO paramVO) {
        LDataMap retMap = new LDataMap();
        
        logger.info("paramVO : " + paramVO.toString());
        
        try {
            LDataMap resultMap = atomyAPIBiz.saleNumValid(paramVO);
            
            if (resultMap.getString("code").equals("1")) {
                AtomyAPIParamVO validVO = (AtomyAPIParamVO) resultMap.get("validVO");
                retMap = atomyAPIBiz.orderCancelInsert(validVO);
            }else {
                retMap.put("code", "500");
                retMap.put("message", "Parameter Error");
            }
            return retMap;
        } catch (Exception e) {
            retMap.put("code", "500");
            retMap.put("message", "API ERROR");
            return retMap;
        }
    }
    
    @RequestMapping(value = "/getOrderInfo.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap getAtomyOrderInfo(@RequestBody CommonSearchVo paramVo){
        
        LDataMap apiReturnMap = new LDataMap();
        LDataMap retMap = new LDataMap();
        try {
            String status = "";
            String data = "";
            
            // 1. 주문 갯수 호출.
            LDataMap dataMap = atomyAPIBiz.getTotalcountDirect(); // 1. 출하요청 개수 조회 (역직구 전용).
            status = dataMap.getString("Status"); // 상태 코드.
            data = dataMap.getString("Data"); // 데이터 갯수.
            
            // 2. 주문 목록 호출.
            if (status.equals("1")) { // 상태코드가 1이고,
                if (!data.equals("0")) { //  Data의 갯수가 0이 아닐 때 오더리스트 호출.
                    retMap = atomyAPIBiz.getOrderList(data); // 2. 출하요청 목록 조회.
                    apiReturnMap.put("code", "200");
                    apiReturnMap.put("message", "애터미 주문 정보 저장 완료");
                    
                    if (retMap.getString("Status").equals("1")){
                        LDataMap resultMap = new LDataMap();
                        resultMap = atomyAPIBiz.setAtomyOrder(retMap);
                        logger.info("code : " + resultMap.getString("code"));
                        logger.info("message : " + resultMap.getString("message"));
                        
                        if (resultMap.get("code").equals("200")){
                            //LDataMap resMap = new LDataMap();
                            //resMap = atomyAPIBiz.setAtomyStatusUpdate();
                            //logger.info("code : " + resMap.getString("code"));
                            //logger.info("message : " + resMap.getString("message"));
                        }
                    }
                    return apiReturnMap;
                }else {
                    retMap.put("apiType", "requestDirect");
                    retMap.put("Status", "1");
                    retMap.put("StatusDetailCode", "");
                    retMap.put("Data", "0");
                    retMap.put("ErrMsg", "주문 정보가 존재하지 않습니다.");
                    atomyAPIBiz.insertApiHistory(retMap);
                    apiReturnMap.put("code", "500");
                    apiReturnMap.put("message", "주문 정보가 존재하지 않습니다.");
                    return apiReturnMap;
                }
            }else {
                retMap.put("Status", "0");
                retMap.put("StatusDetailCode", "");
                retMap.put("Data", "0");
                retMap.put("apiType", "totalCountDirect");
                retMap.put("ErrMsg", "출하요청 개수 조회 실패");
                atomyAPIBiz.insertApiHistory(retMap);
                apiReturnMap.put("code", "500");
                apiReturnMap.put("message", "출하요청 개수 조회 실패");
                return apiReturnMap;
            }
        } catch (Exception e) {
            apiReturnMap.put("code", "500");
            apiReturnMap.put("message", "API ERROR - " + e.getMessage());
            return apiReturnMap;
        }
    }
    
    // 3. 출하요청 확인 - 신규출고확인 상태변경.
    @RequestMapping(value = "/setAtomyStatusUpdate.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap setAtomyStatusUpdate() throws Exception{
        //LDataMap retMap = atomyAPIBiz.setAtomyStatusUpdate();
        return null;
    }
    
    // 4. 배송송장 입력 - 배송송장입력 상태변경.
    @RequestMapping(value = "/setShippingInvoiceUpdate.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap setShippingInvoiceUpdate() throws Exception{
        LDataMap retMap = atomyAPIBiz.setShippingInvoiceUpdate();
        return retMap;
    }
}
