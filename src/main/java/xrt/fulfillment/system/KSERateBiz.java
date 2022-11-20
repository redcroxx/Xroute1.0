package xrt.fulfillment.system;

import java.text.DecimalFormat;
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

/**
 * RateBiz
 * 
 * @since 2020-12-24
 * @author ljh
 *
 */
@Service
public class KSERateBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(KSERateBiz.class);

    /**
     * 국가별 rate 테이블 조회
     * 
     * @param reqData
     * @return
     * @throws Exception
     */
    public LRespData getSearch(LReqData reqData) throws Exception {
        LRespData resData = new LRespData();
        KSERateVO kseRateVO = new KSERateVO();
        
        List<KSERateVO> rateList = dao.selectList("KSERateMapper.getSearch", kseRateVO);
        for (int i = 0; i < rateList.size(); i++) {
            String sagawa = rateList.get(i).getSagawa();
            String nekopos = rateList.get(i).getNekopos();

            
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            if (sagawa.equals("") || sagawa == null) {
                rateList.get(i).setSagawa("");
            }else {
                int iSagawa = Integer.parseInt(rateList.get(i).getSagawa());
                rateList.get(i).setSagawa(decimalFormat.format(iSagawa).toString());
            }
            
            if (nekopos.equals("") || nekopos == null) {
                rateList.get(i).setNekopos("");
            }else {
                int iNekopos = Integer.parseInt(rateList.get(i).getNekopos());
                rateList.get(i).setNekopos(decimalFormat.format(iNekopos).toString());
            }
        }
        resData.put("resultList", rateList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception {
        
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터

        dao.delete("KSERateMapper.deleteKSERate", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            KSERateVO kseRateVO = new KSERateVO();
            kseRateVO.setWgt(dataList.get(i).getString("wgt"));
            kseRateVO.setSagawa(dataList.get(i).getString("sagawa").replaceAll(",", ""));
            kseRateVO.setNekopos(dataList.get(i).getString("nekopos").replaceAll(",", ""));
            kseRateVO.setSmallCargo(dataList.get(i).getString("smallCargo"));
            kseRateVO.setkPacket(dataList.get(i).getString("kPacket"));
            kseRateVO.setAddusercd(LoginInfo.getUsercd());
            kseRateVO.setUpdusercd(LoginInfo.getUsercd());
            kseRateVO.setTerminalcd(ClientInfo.getClntIP());

            dao.insert("KSERateMapper.insertKSERate", kseRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateRateList(LReqData reqData) throws Exception {
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터

        for (int i = 0; i < dataList.size(); i++) {
            KSERateVO kseRateVO = new KSERateVO();
            kseRateVO.setWgt(dataList.get(i).getString("wgt"));
            kseRateVO.setSagawa(dataList.get(i).getString("sagawa").replaceAll(",", ""));
            kseRateVO.setNekopos(dataList.get(i).getString("nekopos").replaceAll(",", ""));
            kseRateVO.setSmallCargo(dataList.get(i).getString("smallCargo"));
            kseRateVO.setkPacket(dataList.get(i).getString("kPacket"));
            kseRateVO.setUpdusercd(LoginInfo.getUsercd());
            kseRateVO.setTerminalcd(ClientInfo.getClntIP());

            dao.update("KSERateMapper.updateKSERate", kseRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}