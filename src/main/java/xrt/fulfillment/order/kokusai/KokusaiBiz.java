package xrt.fulfillment.order.kokusai;

import java.util.List;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Service
public class KokusaiBiz extends DefaultBiz{

    public List<KokusaiVO> getSearch(CommonSearchVo paramVo) throws Exception{
        List<KokusaiVO> resultList = dao.selectList("KokusaiMapper.getSearch", paramVo);

        for (int i = 0; i < resultList.size(); i++) {
            int unitPrice = Integer.parseInt(resultList.get(i).getUnitPrice());
            resultList.get(i).setUnitPrice(Integer.toString(unitPrice));
            resultList.get(i).setConsigneePostalcode(resultList.get(i).getConsigneePostalcode().replace("〒", "").trim());
        }
        return resultList;
    }

    public LRespData updateKokusai(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList");

        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            KokusaiVO kokusaiVO = new KokusaiVO();
            kokusaiVO.setOrderNo1(dataList.get(i).getString("orderNo1"));
            kokusaiVO.setPurchaseUrl(dataList.get(i).getString("purchaseUrl").equals("") || dataList.get(i).getString("purchaseUrl").equals(null) ? "" : dataList.get(i).getString("purchaseUrl"));
            dao.update("KokusaiMapper.updateKokusai", kokusaiVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
