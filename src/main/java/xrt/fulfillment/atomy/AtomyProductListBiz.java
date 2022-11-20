package xrt.fulfillment.atomy;

import java.text.DecimalFormat;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class AtomyProductListBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(AtomyProductListBiz.class);
    
    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {
        LRespData resData = new LRespData();
        List<AtomyProductVO> atomyProductList = dao.selectList("AtomyProductListMapper.getSearch", paramVO);
        for (int i = 0; i < atomyProductList.size(); i++) {
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int price = Integer.parseInt(atomyProductList.get(i).getPrice());
            atomyProductList.get(i).setPrice(decimalFormat.format(price).toString());
        }
        
        resData.put("resultList", atomyProductList);
        return resData;
    }
    
    public LRespData setSave(LReqData reqData) throws Exception{
        // LDataMap paramData = reqData.getParamDataMap("paramData"); // 국가.
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 목록은 삭제.
        dao.delete("AtomyProductListMapper.deleteAtomyProductList", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyProductVO atomyProductVO = new AtomyProductVO();
            atomyProductVO.setType(dataList.get(i).getString("TYPE"));
            atomyProductVO.setKrProductName(dataList.get(i).getString("KR_PRODUCT_NAME"));
            atomyProductVO.setKrProductCode(dataList.get(i).getString("KR_PRODUCT_CODE"));
            atomyProductVO.setOdpCode(dataList.get(i).getString("ODP_CODE"));
            atomyProductVO.setUsaFdaProductNo(dataList.get(i).getString("USA_FDA_PRODUCT_NO") == null ? "" : dataList.get(i).getString("USA_FDA_PRODUCT_NO"));
            atomyProductVO.setCanadaFdaProductNo(dataList.get(i).getString("CANADA_FDA_PRODUCT_NO") == null ? "" : dataList.get(i).getString("CANADA_FDA_PRODUCT_NO"));
            atomyProductVO.setPrice(dataList.get(i).getString("PRICE").replace(",", ""));
            atomyProductVO.setLength(dataList.get(i).getString("LENGTH"));
            atomyProductVO.setWidth(dataList.get(i).getString("WIDTH"));
            atomyProductVO.setHeight(dataList.get(i).getString("HEIGHT"));
            atomyProductVO.setKg(dataList.get(i).getString("KG"));
            atomyProductVO.setCbm(dataList.get(i).getString("CBM"));
            atomyProductVO.setVolumeWeight(dataList.get(i).getString("VOLUME_WEIGHT"));
            atomyProductVO.setEnProductName(dataList.get(i).getString("EN_PRODUCT_NAME"));
            atomyProductVO.setHsCode(dataList.get(i).getString("HS_CODE"));
            atomyProductVO.setOrigin(dataList.get(i).getString("ORIGIN"));
            atomyProductVO.setZone(dataList.get(i).getString("ZONE"));
            atomyProductVO.setRack(dataList.get(i).getString("RACK"));
            atomyProductVO.setAddusercd(LoginInfo.getUsercd());
            atomyProductVO.setUpdusercd(LoginInfo.getUsercd());
            atomyProductVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("AtomyProductListMapper.insertAtomyProductList", atomyProductVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateAtomyProduct(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.

        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyProductVO atomyProductVO = new AtomyProductVO();
            atomyProductVO.setAtomyProductSeq(dataList.get(i).getString("atomyProductSeq"));
            atomyProductVO.setType(dataList.get(i).getString("type"));
            atomyProductVO.setKrProductName(dataList.get(i).getString("krProductName"));
            atomyProductVO.setKrProductCode(dataList.get(i).getString("krProductCode"));
            atomyProductVO.setOdpCode(dataList.get(i).getString("odpCode"));
            atomyProductVO.setUsaFdaProductNo(dataList.get(i).getString("usaFdaProductNo") == null ? "" : dataList.get(i).getString("usaFdaProductNo"));
            atomyProductVO.setCanadaFdaProductNo(dataList.get(i).getString("canadaFdaProductNo") == null ? "" : dataList.get(i).getString("canadaFdaProductNo"));
            atomyProductVO.setPrice(dataList.get(i).getString("price").replace(",", ""));
            atomyProductVO.setLength(dataList.get(i).getString("length"));
            atomyProductVO.setWidth(dataList.get(i).getString("width"));
            atomyProductVO.setHeight(dataList.get(i).getString("height"));
            atomyProductVO.setKg(dataList.get(i).getString("kg"));
            atomyProductVO.setCbm(dataList.get(i).getString("cbm"));
            atomyProductVO.setVolumeWeight(dataList.get(i).getString("volumeWeight"));
            atomyProductVO.setEnProductName(dataList.get(i).getString("enProductName"));
            atomyProductVO.setHsCode(dataList.get(i).getString("hsCode"));
            atomyProductVO.setOrigin(dataList.get(i).getString("origin"));
            atomyProductVO.setZone(dataList.get(i).getString("zone"));
            atomyProductVO.setRack(dataList.get(i).getString("rack"));
            atomyProductVO.setUpdusercd(LoginInfo.getUsercd());
            atomyProductVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("AtomyProductListMapper.updateAtomyProductList", atomyProductVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
