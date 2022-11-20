package xrt.alexcloud.api.atomy;

import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import xrt.alexcloud.api.aftership.AfterShipAPI;
import xrt.alexcloud.api.aftership.vo.AfterShipTrackingVo;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.OrderVo;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;

@Service
public class AtomyOrderListBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(AtomyOrderListBiz.class);
    
    @Value("#{config['c.debugtype']}")
    private String debugtype;
    
    private AfterShipAPI afterShipAPI;
    private AtomyAPIBiz atomyAPIBiz;
    
    @Autowired
    public AtomyOrderListBiz(AfterShipAPI afterShipAPI, AtomyAPIBiz atomyAPIBiz) {
        this.afterShipAPI = afterShipAPI;
        this.atomyAPIBiz = atomyAPIBiz;
    }

    public List<OrderVo> getSearch(CommonSearchVo paramVo) throws Exception{
        
        // 오더등록일자 Default설정.
        if (paramVo.getsToDate() == null || "".equals(paramVo.getsToDate())) {
            paramVo.setsToDate(Util.getTodayFormat("yyyyMMdd"));
        }
        if (paramVo.getsFromDate() == null || "".equals(paramVo.getsFromDate())) {
            paramVo.setsFromDate(Util.getTodayFormat("yyyyMMdd"));
        }
        return dao.selectList("AtomyOrderListMapper.getSearch", paramVo);
    }
    
    public String checkXrtInvcSno(LDataMap param) throws Exception {
        return dao.selectStrOne("AtomyOrderListMapper.checkXrtInvcSno", param);
    }
    
    public String checkExpNo(LDataMap param) throws Exception{
        return dao.selectStrOne("AtomyOrderListMapper.checkExpNo", param);
    }
    /**
     * 데이터 검증
     * @param paramMap
     * @param dataList
     * @return
     * @throws Exception
     */
    public LDataMap valid(List<LDataMap> dataList) throws Exception {
        for (int i = 0; i < dataList.size(); i++) {
            String checkXrtInvcSno = this.checkXrtInvcSno(dataList.get(i));
            String checkExpNo = this.checkExpNo(dataList.get(i));
            /*if (dataList.get(i).getString("xrtInvcSno").equals("")) {
                throw new LingoException("xrtInvcSno가 없습니다.");
            }

            if (dataList.get(i).getString("invcSno1").equals("")) {
                throw new LingoException("invcSno1가 없습니다.");
            }*/
            
            if (checkExpNo.equals("false")) {
                throw new LingoException("애터미 통관서류 탭에서 수출신고필증번호 번호를 업로드하세요.");
            }
            
            if (checkXrtInvcSno.equals("false")) {
                throw new LingoException("해당 송장번호가없습니다.");
            }
        }

        LDataMap retMap = new LDataMap();
        retMap.put("code", "200");
        retMap.put("message", "성공하였습니다.");
        return retMap;
    }

    /**
     * Order List를 Torder 수정 적용
     * @param orderList
     * @return
     * @throws Exception
     */
    public LDataMap setTorder(List<LDataMap> orderList) throws Exception {
        LDataMap retMap = new LDataMap();
        
        for (int i = 0; i < orderList.size(); i++) {
            // 강제 오더 수정 시 입고일자가 없는 경우에만 오더수정탭에서 입고일자 입력. 그리고 입고일자가 있을 경우 변동이 안되고 기존 입고 일자 유지.
            
            LDataMap dataMap = new LDataMap();
            dataMap.put("xrtInvcSno", orderList.get(i).getString("xrtInvcSno"));
            dataMap.put("invcSno1", orderList.get(i).getString("invcSno1"));
            
            if (dataMap.getString("invcSno1").equals("")) {
                throw new LingoException((i + 1) + "행의 송장번호가 없습니다.");
            }
            
            dao.update("OrderModifyMapper.updateTorder", dataMap);
           
            AfterShipTrackingVo afterShipTrackingVo = new AfterShipTrackingVo();
            
            LDataMap orders = (LDataMap) dao.selectOne("AfterShipMapper.getOrderData", orderList.get(i));
            
            if (!orderList.get(i).getString("invcSno1").equals("")) {
                afterShipTrackingVo.setSlug(orders.getString("localShipper").toLowerCase());
                afterShipTrackingVo.setTrackingNumber(orderList.get(i).getString("invcSno1"));
                afterShipTrackingVo.setTitle("");

                List<String> emails = new ArrayList<>();
                emails.add("xroute@logifocus.co.kr");
                afterShipTrackingVo.setEmails(emails);
                afterShipTrackingVo.setOrderId(orders.getString("ordNo"));
                afterShipTrackingVo.setOrderIdPath("");

                Map<String, Object> customFileds = new HashMap<>();
                customFileds.put("productName", orders.getString("goodsNm"));
                customFileds.put("productPrice", orders.getString("price"));

                afterShipTrackingVo.setCustomFields(customFileds);
                afterShipTrackingVo.setLanguage("en");
                afterShipTrackingVo.setOrderPromisedDeliveryDate("");
                afterShipTrackingVo.setDeliveryType("pickup_at_courier");
                afterShipTrackingVo.setPickupLocation(orders.getString("eNation").toUpperCase());
                afterShipTrackingVo.setPickupNote("");
                afterShipAPI.createTrackings(afterShipTrackingVo);
            }
        }
        
        this.setShippingInvoiceUpdate(orderList);
        
        retMap.put("CODE", "1");
        retMap.put("MESSAGE", "배송송장입력 상태 변경 API 호출 완료.");
        return retMap;
    }
    
    public LDataMap setShippingInvoiceUpdate(List<LDataMap> orderList) throws Exception{
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        
        LDataMap paramMap = new LDataMap();
        paramMap.put("orgCd", orgcd);
        paramMap.put("dataList", orderList);
        
        List<LDataMap> bodyList = dao.select("AtomyOrderListMapper.getAtomyOrderResult", paramMap);
        
        if (bodyList.size() == 0) {
            throw new LingoException("주문 정보가 없습니다.");
        }
        
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < bodyList.size(); i++) {
            sb.append("{");
            sb.append("\"SaleNum\": \"" + bodyList.get(i).getString("ordNo") + "\",");
            sb.append("\"Seq\": \"" + bodyList.get(i).getString("ordSeq") + "\",");
            sb.append("\"InvoiceNo\": \"" + bodyList.get(i).getString("invcSno1") + "\",");
            sb.append("\"TagSms\": \"" + bodyList.get(i).getString("localShipper") + "\",");
            sb.append("\"EntryNum\": \"" + bodyList.get(i).getString("expNo") + "\"");
            if ((i + 1) == bodyList.size()) {
                sb.append("}");
            } else {
                sb.append("},");
            }
        }
        sb.append("]");
        
        String queryString = "/apiglobal/scm/kr/v1/status/invoiceDirect";
        String apiType = "invoiceDirect";
        String httpMethod = "PUT";

        HttpURLConnection conn = atomyAPIBiz.setHttpHeader(queryString, httpMethod, apiType);
        JSONObject jsonObject = atomyAPIBiz.setHttpBody(conn, apiType, sb);

        LDataMap resMap = new ObjectMapper().readValue(jsonObject.toJSONString(), LDataMap.class);
        
        logger.info("resMap : " + resMap.toString());
        
        String status = resMap.getString("Status");
        String message = resMap.getString("StatusDetailCode");
        
        logger.info("status : " + status);
        logger.info("message : " + message);
        logger.info("bodyList : " + bodyList.toString());
        
        if (status.equals("1")) {
            for (int i = 0; i < bodyList.size(); i++) {
                LDataMap updParam = bodyList.get(i);
                dao.update("AtomyOrderListMapper.updateInvoiceYn", updParam);
            }
        }
        
        LDataMap retMap = new LDataMap();
        retMap.put("code", status); // 코드. 1이면 성공. 0이면 실패.
        retMap.put("message", message);
        return retMap;
    }
}
