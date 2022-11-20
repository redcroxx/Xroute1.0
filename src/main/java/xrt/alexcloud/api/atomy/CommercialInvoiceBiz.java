package xrt.alexcloud.api.atomy;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
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
public class CommercialInvoiceBiz extends DefaultBiz {

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    public List<CommercialInvoiceVO> getSearch(CommonSearchVo paramVO) throws Exception {
        String orgcd = CommonConst.ATOMY_DEV_ORGCD;

        if (debugtype.equals("REAL")) {
            orgcd = CommonConst.ATOMY_REAL_ORGCD;
        }
        paramVO.setsOrgCd(orgcd);
        paramVO.setsUserCd(CommonConst.ATOMY_USERCD);

        List<CommercialInvoiceVO> resultList = dao.selectList("CommercialInvoiceMapper.getSearch", paramVO);

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
        List<CommercialInvoiceVO> xrtInvcSnoList = new ArrayList<CommercialInvoiceVO>();

        // 데이터 검증
        for (int i = 0; i < dataList.size(); i++) {
            CommercialInvoiceVO commercialInvoiceVO = new CommercialInvoiceVO();
            commercialInvoiceVO.setXrtInvcSno(dataList.get(i).getString("xrtInvcSno")); // 송장번호.
            commercialInvoiceVO.setExpNo(dataList.get(i).getString("expNo")); // 수출신고필증번호.
            xrtInvcSnoList.add(commercialInvoiceVO);
        }
        List<CommercialInvoiceVO> xrtInvcSnoGroupByList = new ArrayList<CommercialInvoiceVO>();
        xrtInvcSnoGroupByList.addAll(xrtInvcSnoList.stream().collect(Collectors.toConcurrentMap(CommercialInvoiceVO::getXrtInvcSno, Function.identity(), (p, q) -> p)).values());

        for (int i = 0; i < xrtInvcSnoGroupByList.size(); i++) {
            dao.update("CommercialInvoiceMapper.updateCommercialInvoice", xrtInvcSnoGroupByList.get(i));
        }
        
        LRespData respData = new LRespData();
        return respData;
    }
}
