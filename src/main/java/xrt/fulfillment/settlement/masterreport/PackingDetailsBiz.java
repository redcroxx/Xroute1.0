package xrt.fulfillment.settlement.masterreport;

import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class PackingDetailsBiz extends DefaultBiz {
    
    Logger logger = LoggerFactory.getLogger(PackingDetailsBiz.class);

	// 검색
	List<LDataMap> getSearch(LDataMap paramData) throws Exception {
	    List<LDataMap> shipmentBlList = new ArrayList<>();
	    String[] shipmentBlArr = null;
	    
	    String shipmentBlNos = paramData.getString("shipmentBlNo");
	    // 구분자 체크.
	    if (shipmentBlNos.contains(",")) {
	        shipmentBlArr = shipmentBlNos.split(",");
	        for (int i = 0; i < shipmentBlArr.length; i++) {
	            LDataMap dataMap = new LDataMap();
	            dataMap.put("shipmentBlNos", shipmentBlArr[i]);
	            shipmentBlList.add(dataMap);
	        }
	        paramData.put("dataList", shipmentBlList);
        }else {
            if (!shipmentBlNos.equals("")) {
                LDataMap dataMap = new LDataMap();
                dataMap.put("shipmentBlNos", shipmentBlNos);
                shipmentBlList.add(dataMap);
            }
            paramData.put("dataList", shipmentBlList);
        }
		return dao.selectList("PackingDetailsMapper.getSearch", paramData);
	}

    public List<LDataMap> getSblNoSearch(LDataMap paramData) throws Exception{
        return dao.select("PackingDetailsMapper.getSblNoSearch", paramData);
    }

    public LDataMap view() throws Exception{
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("DhlCountryZoneMapper.getDhlCountryCode", param);
        
        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        return retMap;
    }
}
