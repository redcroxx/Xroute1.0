package xrt.alexcloud.api.atomy;

import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class AtomySettlementBiz extends DefaultBiz {

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    public List<AtomySettlementVO> getSearch(CommonSearchVo paramVO) throws Exception {
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        paramVO.setsOrgCd(orgcd);
        paramVO.setsUserCd(CommonConst.ATOMY_USERCD);

        List<AtomySettlementVO> resultList = dao.selectList("AtomySettlementMapper.getSearch", paramVO);

        return resultList;
    }

    public LDataMap view() throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", "USE_COUNTRY");
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("CodeCacheMapper.getCommonCode", param);

        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        return retMap;
    }

    public LRespData updateCommercialInvoice(LReqData reqData) throws Exception {
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터

        for (int i = 0; i < dataList.size(); i++) {
            dao.update("AtomySettlementMapper.updateAtomySettlement", dataList.get(i));
        }
        
        LRespData respData = new LRespData();
        return respData;
    }
}
