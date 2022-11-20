package xrt.fulfillment.atomy;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class AtomyBarcordBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(AtomyBarcordBiz.class);

    public LRespData getSearch(LDataMap paramMap) throws Exception {
        LRespData resData = new LRespData();
        List<AtomyBoxSizeVO> atomyBoxSizeList = dao.selectList("atomyBarcordMapper.getSearch", paramMap);
        resData.put("resultList", atomyBoxSizeList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception {
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.

        dao.delete("atomyBarcordMapper.deleteAtomyBarcord", dataList);

        for (int i = 0; i < dataList.size(); i++) {
            LDataMap paramMap = new LDataMap();
            paramMap.put("compcd", LoginInfo.getCompcd());
            paramMap.put("krProductCode", dataList.get(i).getString("krProductCode"));
            paramMap.put("krProductName", dataList.get(i).getString("krProductName"));
            paramMap.put("barcord", dataList.get(i).getString("barcord"));
            paramMap.put("addusercd", LoginInfo.getUsercd());
            paramMap.put("updusercd", LoginInfo.getUsercd());
            paramMap.put("terminalcd", ClientInfo.getClntIP());
            dao.insert("atomyBarcordMapper.insertAtomyBarcord", paramMap);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData setUpdate(LReqData reqData) throws Exception {
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.

        for (int i = 0; i < dataList.size(); i++) {
            LDataMap paramMap = new LDataMap();
            paramMap.put("atomyBarcordSeq", dataList.get(i).getString("atomyBarcordSeq"));
            paramMap.put("compcd", LoginInfo.getCompcd());
            paramMap.put("krProductCode", dataList.get(i).getString("krProductCode"));
            paramMap.put("krProductName", dataList.get(i).getString("krProductCode"));
            paramMap.put("barcord", dataList.get(i).getString("krProductCode"));
            paramMap.put("updusercd", LoginInfo.getUsercd());
            dao.update("atomyBarcordMapper.updateAtomyBarcord", paramMap);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
