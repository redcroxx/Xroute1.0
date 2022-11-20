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
public class AtomyBoxSizeBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(AtomyBoxSizeBiz.class);

    public LRespData getSearch(LReqData reqData) throws Exception {
        LRespData resData = new LRespData();
        List<AtomyBoxSizeVO> atomyBoxSizeList = dao.selectList("AtomyBoxSizeMapper.getSearch", reqData);
        resData.put("resultList", atomyBoxSizeList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 목록은 삭제.
        dao.delete("AtomyBoxSizeMapper.deleteBoxSize", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyBoxSizeVO atomyBoxSizeVO = new AtomyBoxSizeVO();
            atomyBoxSizeVO.setCompcd(LoginInfo.getCompcd());
            atomyBoxSizeVO.setNo(dataList.get(i).getString("NO"));
            atomyBoxSizeVO.setLength(dataList.get(i).getString("LENGTH"));
            atomyBoxSizeVO.setWidth(dataList.get(i).getString("WIDTH"));
            atomyBoxSizeVO.setHeight(dataList.get(i).getString("HEIGHT"));
            atomyBoxSizeVO.setCbm(dataList.get(i).getString("CBM"));
            atomyBoxSizeVO.setWeight(dataList.get(i).getString("WEIGHT"));
            atomyBoxSizeVO.setAddusercd(LoginInfo.getUsercd());
            atomyBoxSizeVO.setUpdusercd(LoginInfo.getUsercd());
            atomyBoxSizeVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("AtomyBoxSizeMapper.insertAtomyBoxSize", atomyBoxSizeVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateBoxSize(LReqData reqData) throws Exception {
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.

     // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyBoxSizeVO atomyBoxSizeVO = new AtomyBoxSizeVO();
            atomyBoxSizeVO.setAtomyBozSizeSeq(dataList.get(i).getString("atomyBozSizeSeq"));
            atomyBoxSizeVO.setNo(dataList.get(i).getString("no"));
            atomyBoxSizeVO.setLength(dataList.get(i).getString("length"));
            atomyBoxSizeVO.setWidth(dataList.get(i).getString("width"));
            atomyBoxSizeVO.setHeight(dataList.get(i).getString("height"));
            atomyBoxSizeVO.setCbm(dataList.get(i).getString("cbm"));
            atomyBoxSizeVO.setWeight(dataList.get(i).getString("weight"));
            atomyBoxSizeVO.setUpdusercd(LoginInfo.getUsercd());
            atomyBoxSizeVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("AtomyBoxSizeMapper.updateAtomyBoxSize", atomyBoxSizeVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
