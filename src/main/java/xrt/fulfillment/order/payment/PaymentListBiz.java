package xrt.fulfillment.order.payment;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import xrt.alexcloud.api.settlebank.SettleBankAPI;
import xrt.alexcloud.api.settlebank.vo.SettleBankResNotiVO;
import xrt.alexcloud.api.settlebank.vo.TCartDtlVo;
import xrt.alexcloud.api.settlebank.vo.TCartVo;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class PaymentListBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(PaymentListBiz.class);

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    @Value("#{config['c.devUsercd']}")
    private String devUsercd;

    @Value("#{config['c.realUsercd']}")
    private String realUsercd;

    @Autowired
    private SettleBankAPI settleBankAPI;

    public List<ShippingListVO> getSearch(CommonSearchVo paramVO) throws Exception {
        return dao.selectList("paymentListMapper.getSearch", paramVO);
    }

    public List<ShippingListVO> getPopSearch(LDataMap paramMap) throws Exception {
        return dao.selectList("paymentListMapper.getPopSearch", paramMap);
    }

    public LDataMap cartProcess(LDataMap paramMap) throws Exception {
        logger.debug("01. cart Count 조회");
        List<LDataMap> tCartCount = dao.selectList("paymentListMapper.getTCartCount", paramMap);

        logger.debug("02. cart.size : " + tCartCount.size());
        if (tCartCount.size() > 0) {
            dao.delete("paymentListMapper.deleteTCart", paramMap);
            dao.delete("paymentListMapper.deleteTCartDtl", paramMap);
        }

        List<LDataMap> cartList = dao.selectList("paymentListMapper.getTCartList", paramMap);

        BigDecimal totalPrice = (BigDecimal) cartList.get(0).get("totalPrice");
        String name = (String) cartList.get(0).get("name");
        String email = (String) cartList.get(0).get("email");
        String tel = (String) cartList.get(0).get("tel1");
        String usercd;

        if (debugtype.equals("REAL")) {
            usercd = realUsercd;
        } else {
            usercd = devUsercd;
        }

        logger.debug("03. TCart Insert 설정");
        TCartVo tCartVO = new TCartVo();
        tCartVO.setCompcd(paramMap.getString("compcd"));
        tCartVO.setOrgcd(paramMap.getString("orgcd"));
        tCartVO.setPamt(totalPrice.toString());
        tCartVO.setPmname("로지포커스");
        tCartVO.setPuname(name);
        tCartVO.setPename("LOGIFOCUS");
        tCartVO.setPgoods("물품배송비");
        tCartVO.setPbname("로지포커스㈜");
        tCartVO.setUsercd(usercd);
        tCartVO.setAddusercd(paramMap.getString("usercd"));
        tCartVO.setUpdusercd(paramMap.getString("usercd"));
        tCartVO.setTerminalcd(paramMap.getString("clientIp"));

        dao.insert("paymentListMapper.insertTCart", tCartVO);

        int cartDtlCount = 0;
        for (Map<String, Object> cartMap : cartList) {

            BigDecimal xrtShippingPrice = (BigDecimal) cartMap.get("xrtShippingPrice");
            TCartDtlVo tCartDtlVO = new TCartDtlVo();
            tCartDtlVO.setPoid(tCartVO.getPoid());
            tCartDtlVO.setPseq(cartDtlCount + 1 + "");
            tCartDtlVO.setCompcd(paramMap.getString("compcd"));
            tCartDtlVO.setOrgcd(paramMap.getString("orgcd"));
            tCartDtlVO.setOrdCd((String) cartMap.get("ordCd"));
            tCartDtlVO.setXrtInvcSno((String) cartMap.get("xrtInvcSno"));
            tCartDtlVO.setXrtShippingPrice(xrtShippingPrice.toString());
            tCartDtlVO.setAddusercd(paramMap.getString("usercd"));
            tCartDtlVO.setUpdusercd(paramMap.getString("usercd"));
            tCartDtlVO.setTerminalcd(paramMap.getString("clientIp"));

            cartDtlCount += dao.insert("paymentListMapper.insertTCartDtl", tCartDtlVO);
        }

        if (cartDtlCount != cartList.size()) {
            new LingoException("상세 데이터 저장시 오류가 발생 하였습니다.");
        }

        LDataMap retMap = new LDataMap();
        retMap.put("pOid", tCartVO.getPoid());
        retMap.put("pEmail", email);
        retMap.put("pPhone", tel);
        retMap.put("pGoods", tCartVO.getPgoods());
        retMap.put("pMid", tCartVO.getUsercd());
        retMap.put("PAmt", tCartVO.getPamt());
        retMap.put("pMname", tCartVO.getPmname());
        retMap.put("pUname", tCartVO.getPuname());
        retMap.put("pBname", tCartVO.getPbname());
        retMap.put("pUserid", tCartVO.getUsercd());

        return retMap;
    }

    public LDataMap resSettleBankData(SettleBankResNotiVO paramVO) throws Exception {
        logger.debug("SettleBankResNotiVO : " + paramVO.toString());
        LDataMap retMap = settleBankAPI.getSettleBankResult(paramVO);
        return retMap;
    }
}
