package xrt.fulfillment.atomy;

import java.text.DecimalFormat;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class AtomyRateBiz extends DefaultBiz{
    
    Logger logger = LoggerFactory.getLogger(AtomyRateBiz.class);

    public LDataMap view() throws Exception {
        LDataMap param = new LDataMap();
        param.put("COMPCD", LoginInfo.getCompcd());
        param.put("CODEKEY", "ATOMY_COUNTRY");
        param.put("STATUS", "Y");
        List<CodeVO> countrylist = dao.selectList("CodeCacheMapper.getCommonCode", param);

        LDataMap retMap = new LDataMap();
        retMap.put("countrylist", countrylist);
        return retMap;
    }
    

    // 애터미 요율표 목록 조회.
    public LRespData getSearch(LReqData reqData) throws Exception{
        LRespData resData = new LRespData();
        AtomyRateVO atomyRateVO = new AtomyRateVO();
        List<AtomyRateVO> atomyRateList = dao.selectList("AtomyRateMapper.getSearch", atomyRateVO);
        for (int i = 0; i < atomyRateList.size(); i++) {
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int italy = Integer.parseInt(atomyRateList.get(i).getItaly());
            int australia = Integer.parseInt(atomyRateList.get(i).getAustralia());
            int hongKong = Integer.parseInt(atomyRateList.get(i).getHongKong());
            int japan = Integer.parseInt(atomyRateList.get(i).getJapan());
            int malaysia = Integer.parseInt(atomyRateList.get(i).getMalaysia());
            int mongolia = Integer.parseInt(atomyRateList.get(i).getMongolia());
            int newZealand = Integer.parseInt(atomyRateList.get(i).getNewZealand());
            int singapore = Integer.parseInt(atomyRateList.get(i).getSingapore());
            int taiwan = Integer.parseInt(atomyRateList.get(i).getTaiwan());
            int usa = Integer.parseInt(atomyRateList.get(i).getUsa());
            int canada = Integer.parseInt(atomyRateList.get(i).getCanada());
            int france    = Integer.parseInt(atomyRateList.get(i).getFrance());
            int germany = Integer.parseInt(atomyRateList.get(i).getGermany());
            int switzerland = Integer.parseInt(atomyRateList.get(i).getSwitzerland());
            int unitedKingdom = Integer.parseInt(atomyRateList.get(i).getUnitedKingdom());
            int guam = Integer.parseInt(atomyRateList.get(i).getGuam());
            int saipan = Integer.parseInt(atomyRateList.get(i).getSaipan());
            int cambodia = Integer.parseInt(atomyRateList.get(i).getCambodia());
            int thailand = Integer.parseInt(atomyRateList.get(i).getThailand());
            int philippines = Integer.parseInt(atomyRateList.get(i).getPhilippines());
            int spain = Integer.parseInt(atomyRateList.get(i).getSpain());
            int portugal = Integer.parseInt(atomyRateList.get(i).getPortugal());
            int russia = Integer.parseInt(atomyRateList.get(i).getRussia());
            atomyRateList.get(i).setItaly(decimalFormat.format(italy).toString());
            atomyRateList.get(i).setAustralia(decimalFormat.format(australia).toString());
            atomyRateList.get(i).setHongKong(decimalFormat.format(hongKong).toString());
            atomyRateList.get(i).setJapan(decimalFormat.format(japan).toString());
            atomyRateList.get(i).setMalaysia(decimalFormat.format(malaysia).toString());
            atomyRateList.get(i).setMongolia(decimalFormat.format(mongolia).toString());
            atomyRateList.get(i).setNewZealand(decimalFormat.format(newZealand).toString());
            atomyRateList.get(i).setSingapore(decimalFormat.format(singapore).toString());
            atomyRateList.get(i).setTaiwan(decimalFormat.format(taiwan).toString());
            atomyRateList.get(i).setUsa(decimalFormat.format(usa).toString());
            atomyRateList.get(i).setCanada(decimalFormat.format(canada).toString());
            atomyRateList.get(i).setFrance(decimalFormat.format(france).toString());
            atomyRateList.get(i).setGermany(decimalFormat.format(germany).toString());
            atomyRateList.get(i).setSwitzerland(decimalFormat.format(switzerland).toString());
            atomyRateList.get(i).setUnitedKingdom(decimalFormat.format(unitedKingdom).toString());
            atomyRateList.get(i).setGuam(decimalFormat.format(guam).toString());
            atomyRateList.get(i).setSaipan(decimalFormat.format(saipan).toString());
            atomyRateList.get(i).setCambodia(decimalFormat.format(cambodia).toString());
            atomyRateList.get(i).setThailand(decimalFormat.format(thailand).toString());
            atomyRateList.get(i).setPhilippines(decimalFormat.format(philippines).toString());
            atomyRateList.get(i).setSpain(decimalFormat.format(spain).toString());
            atomyRateList.get(i).setPortugal(decimalFormat.format(portugal).toString());
            atomyRateList.get(i).setRussia(decimalFormat.format(russia).toString());
        }
        resData.put("resultList", atomyRateList);
        return resData;
    }
    
    public LRespData getTotalSearch(LReqData reqData) throws Exception{
        LRespData resData = new LRespData();
        AtomyRateVO atomyRateVO = new AtomyRateVO();
        List<AtomyRateVO> atomyRateList = dao.selectList("AtomyRateMapper.getTotalSearch", atomyRateVO);
        for (int i = 0; i < atomyRateList.size(); i++) {
            DecimalFormat decimalFormat = new DecimalFormat("###,###");
            int italy = Integer.parseInt(atomyRateList.get(i).getItaly());
            int australia = Integer.parseInt(atomyRateList.get(i).getAustralia());
            int hongKong = Integer.parseInt(atomyRateList.get(i).getHongKong());
            int japan = Integer.parseInt(atomyRateList.get(i).getJapan());
            int malaysia = Integer.parseInt(atomyRateList.get(i).getMalaysia());
            int mongolia = Integer.parseInt(atomyRateList.get(i).getMongolia());
            int newZealand = Integer.parseInt(atomyRateList.get(i).getNewZealand());
            int singapore = Integer.parseInt(atomyRateList.get(i).getSingapore());
            int taiwan = Integer.parseInt(atomyRateList.get(i).getTaiwan());
            int usa = Integer.parseInt(atomyRateList.get(i).getUsa());
            int canada = Integer.parseInt(atomyRateList.get(i).getCanada());
            int france    = Integer.parseInt(atomyRateList.get(i).getFrance());
            int germany = Integer.parseInt(atomyRateList.get(i).getGermany());
            int switzerland = Integer.parseInt(atomyRateList.get(i).getSwitzerland());
            int unitedKingdom = Integer.parseInt(atomyRateList.get(i).getUnitedKingdom());
            int guam = Integer.parseInt(atomyRateList.get(i).getGuam());
            int saipan = Integer.parseInt(atomyRateList.get(i).getSaipan());
            int cambodia = Integer.parseInt(atomyRateList.get(i).getCambodia());
            int thailand = Integer.parseInt(atomyRateList.get(i).getThailand());
            int philippines = Integer.parseInt(atomyRateList.get(i).getPhilippines());
            int spain = Integer.parseInt(atomyRateList.get(i).getSpain());
            int portugal = Integer.parseInt(atomyRateList.get(i).getPortugal());
            int russia = Integer.parseInt(atomyRateList.get(i).getRussia());
            atomyRateList.get(i).setItaly(decimalFormat.format(italy).toString());
            atomyRateList.get(i).setAustralia(decimalFormat.format(australia).toString());
            atomyRateList.get(i).setHongKong(decimalFormat.format(hongKong).toString());
            atomyRateList.get(i).setJapan(decimalFormat.format(japan).toString());
            atomyRateList.get(i).setMalaysia(decimalFormat.format(malaysia).toString());
            atomyRateList.get(i).setMongolia(decimalFormat.format(mongolia).toString());
            atomyRateList.get(i).setNewZealand(decimalFormat.format(newZealand).toString());
            atomyRateList.get(i).setSingapore(decimalFormat.format(singapore).toString());
            atomyRateList.get(i).setTaiwan(decimalFormat.format(taiwan).toString());
            atomyRateList.get(i).setUsa(decimalFormat.format(usa).toString());
            atomyRateList.get(i).setCanada(decimalFormat.format(canada).toString());
            atomyRateList.get(i).setFrance(decimalFormat.format(france).toString());
            atomyRateList.get(i).setGermany(decimalFormat.format(germany).toString());
            atomyRateList.get(i).setSwitzerland(decimalFormat.format(switzerland).toString());
            atomyRateList.get(i).setUnitedKingdom(decimalFormat.format(unitedKingdom).toString());
            atomyRateList.get(i).setGuam(decimalFormat.format(guam).toString());
            atomyRateList.get(i).setSaipan(decimalFormat.format(saipan).toString());
            atomyRateList.get(i).setCambodia(decimalFormat.format(cambodia).toString());
            atomyRateList.get(i).setThailand(decimalFormat.format(thailand).toString());
            atomyRateList.get(i).setPhilippines(decimalFormat.format(philippines).toString());
            atomyRateList.get(i).setSpain(decimalFormat.format(spain).toString());
            atomyRateList.get(i).setPortugal(decimalFormat.format(portugal).toString());
            atomyRateList.get(i).setRussia(decimalFormat.format(russia).toString());
        }
        resData.put("resultList", atomyRateList);
        return resData;
    }

    public LRespData setSave(LReqData reqData) throws Exception {
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 요율표 목록은 삭제.
        dao.delete("AtomyRateMapper.deleteAtomyRate", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyRateVO atomyRateVO = new AtomyRateVO();
            atomyRateVO.setKg(dataList.get(i).getString("KG"));
            atomyRateVO.setItaly(dataList.get(i).getString("Italy").replace(",",""));
            atomyRateVO.setAustralia(dataList.get(i).getString("Australia").replace(",",""));
            atomyRateVO.setHongKong(dataList.get(i).getString("HongKong").replace(",",""));
            atomyRateVO.setJapan(dataList.get(i).getString("Japan").replace(",",""));
            atomyRateVO.setMalaysia(dataList.get(i).getString("Malaysia").replace(",",""));
            atomyRateVO.setMongolia(dataList.get(i).getString("Mongolia").replace(",",""));
            atomyRateVO.setNewZealand(dataList.get(i).getString("NewZealand").replace(",",""));
            atomyRateVO.setSingapore(dataList.get(i).getString("Singapore").replace(",",""));
            atomyRateVO.setTaiwan(dataList.get(i).getString("Taiwan").replace(",",""));
            atomyRateVO.setUsa(dataList.get(i).getString("USA").replace(",",""));
            atomyRateVO.setCanada(dataList.get(i).getString("Canada").replace(",",""));
            atomyRateVO.setFrance(dataList.get(i).getString("France").replace(",",""));
            atomyRateVO.setGermany(dataList.get(i).getString("Germany").replace(",",""));
            atomyRateVO.setSwitzerland(dataList.get(i).getString("Switzerland").replace(",",""));
            atomyRateVO.setUnitedKingdom(dataList.get(i).getString("UnitedKingdom").replace(",",""));
            atomyRateVO.setGuam(dataList.get(i).getString("Guam").replace(",",""));
            atomyRateVO.setSaipan(dataList.get(i).getString("Saipan").replace(",",""));
            atomyRateVO.setCambodia(dataList.get(i).getString("Cambodia").replace(",",""));
            atomyRateVO.setThailand(dataList.get(i).getString("Thailand").replace(",",""));
            atomyRateVO.setPhilippines(dataList.get(i).getString("Philippines").replace(",",""));
            atomyRateVO.setSpain(dataList.get(i).getString("Spain").replace(",",""));
            atomyRateVO.setPortugal(dataList.get(i).getString("Portugal").replace(",",""));
            atomyRateVO.setRussia(dataList.get(i).getString("Russia").replace(",",""));
            atomyRateVO.setAddusercd(LoginInfo.getUsercd());
            atomyRateVO.setUpdusercd(LoginInfo.getUsercd());
            atomyRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("AtomyRateMapper.insertAtomyRate", atomyRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
    
    public LRespData setTotalSave(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터.
        
        // 등록 전 기존의 요율표 목록은 삭제.
        dao.delete("AtomyRateMapper.deleteAtomyTotalRate", dataList);
        
        // 데이터 검증.
        for (int i = 0; i < dataList.size(); i++) {
            AtomyRateVO atomyRateVO = new AtomyRateVO();
            atomyRateVO.setKg(dataList.get(i).getString("KG"));
            atomyRateVO.setItaly(dataList.get(i).getString("Italy").replace(",",""));
            atomyRateVO.setAustralia(dataList.get(i).getString("Australia").replace(",",""));
            atomyRateVO.setHongKong(dataList.get(i).getString("HongKong").replace(",",""));
            atomyRateVO.setJapan(dataList.get(i).getString("Japan").replace(",",""));
            atomyRateVO.setMalaysia(dataList.get(i).getString("Malaysia").replace(",",""));
            atomyRateVO.setMongolia(dataList.get(i).getString("Mongolia").replace(",",""));
            atomyRateVO.setNewZealand(dataList.get(i).getString("NewZealand").replace(",",""));
            atomyRateVO.setSingapore(dataList.get(i).getString("Singapore").replace(",",""));
            atomyRateVO.setTaiwan(dataList.get(i).getString("Taiwan").replace(",",""));
            atomyRateVO.setUsa(dataList.get(i).getString("USA").replace(",",""));
            atomyRateVO.setCanada(dataList.get(i).getString("Canada").replace(",",""));
            atomyRateVO.setFrance(dataList.get(i).getString("France").replace(",",""));
            atomyRateVO.setGermany(dataList.get(i).getString("Germany").replace(",",""));
            atomyRateVO.setSwitzerland(dataList.get(i).getString("Switzerland").replace(",",""));
            atomyRateVO.setUnitedKingdom(dataList.get(i).getString("UnitedKingdom").replace(",",""));
            atomyRateVO.setGuam(dataList.get(i).getString("Guam").replace(",",""));
            atomyRateVO.setSaipan(dataList.get(i).getString("Saipan").replace(",",""));
            atomyRateVO.setCambodia(dataList.get(i).getString("Cambodia").replace(",",""));
            atomyRateVO.setThailand(dataList.get(i).getString("Thailand").replace(",",""));
            atomyRateVO.setPhilippines(dataList.get(i).getString("Philippines").replace(",",""));
            atomyRateVO.setSpain(dataList.get(i).getString("Spain").replace(",",""));
            atomyRateVO.setPortugal(dataList.get(i).getString("Portugal").replace(",",""));
            atomyRateVO.setRussia(dataList.get(i).getString("Russia").replace(",",""));
            atomyRateVO.setAddusercd(LoginInfo.getUsercd());
            atomyRateVO.setUpdusercd(LoginInfo.getUsercd());
            atomyRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.insert("AtomyRateMapper.insertAtomyTotalRate", atomyRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }

    public LRespData updateAtomyRate(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터

        // 데이터 검증
        for (int i = 0; i < dataList.size(); i++) {
            AtomyRateVO atomyRateVO = new AtomyRateVO();
            atomyRateVO.setKg(dataList.get(i).getString("kg"));
            atomyRateVO.setItaly(dataList.get(i).getString("italy").replace(",",""));
            atomyRateVO.setAustralia(dataList.get(i).getString("australia").replace(",",""));
            atomyRateVO.setHongKong(dataList.get(i).getString("hongKong").replace(",",""));
            atomyRateVO.setJapan(dataList.get(i).getString("japan").replace(",",""));
            atomyRateVO.setMalaysia(dataList.get(i).getString("malaysia").replace(",",""));
            atomyRateVO.setMongolia(dataList.get(i).getString("mongolia").replace(",",""));
            atomyRateVO.setNewZealand(dataList.get(i).getString("newZealand").replace(",",""));
            atomyRateVO.setSingapore(dataList.get(i).getString("singapore").replace(",",""));
            atomyRateVO.setTaiwan(dataList.get(i).getString("taiwan").replace(",",""));
            atomyRateVO.setUsa(dataList.get(i).getString("usa").replace(",",""));
            atomyRateVO.setCanada(dataList.get(i).getString("canada").replace(",",""));
            atomyRateVO.setFrance(dataList.get(i).getString("france").replace(",",""));
            atomyRateVO.setGermany(dataList.get(i).getString("germany").replace(",",""));
            atomyRateVO.setSwitzerland(dataList.get(i).getString("switzerland").replace(",",""));
            atomyRateVO.setUnitedKingdom(dataList.get(i).getString("unitedKingdom").replace(",",""));
            atomyRateVO.setGuam(dataList.get(i).getString("guam").replace(",",""));
            atomyRateVO.setSaipan(dataList.get(i).getString("saipan").replace(",",""));
            atomyRateVO.setCambodia(dataList.get(i).getString("cambodia").replace(",",""));
            atomyRateVO.setThailand(dataList.get(i).getString("thailand").replace(",",""));
            atomyRateVO.setPhilippines(dataList.get(i).getString("philippines").replace(",",""));
            atomyRateVO.setSpain(dataList.get(i).getString("spain").replace(",",""));
            atomyRateVO.setPortugal(dataList.get(i).getString("portugal").replace(",",""));
            atomyRateVO.setRussia(dataList.get(i).getString("russia").replace(",",""));
            atomyRateVO.setAddusercd(LoginInfo.getUsercd());
            atomyRateVO.setUpdusercd(LoginInfo.getUsercd());
            atomyRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("AtomyRateMapper.updateAtomyRate", atomyRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }


    public LRespData updateAtomyTotalRate(LReqData reqData) throws Exception{
        List<LDataMap> dataList = reqData.getParamDataList("paramList"); // 엑셀업로드데이터

        // 데이터 검증
        for (int i = 0; i < dataList.size(); i++) {
            AtomyRateVO atomyRateVO = new AtomyRateVO();
            atomyRateVO.setKg(dataList.get(i).getString("kg"));
            atomyRateVO.setItaly(dataList.get(i).getString("italy").replace(",",""));
            atomyRateVO.setAustralia(dataList.get(i).getString("australia").replace(",",""));
            atomyRateVO.setHongKong(dataList.get(i).getString("hongKong").replace(",",""));
            atomyRateVO.setJapan(dataList.get(i).getString("japan").replace(",",""));
            atomyRateVO.setMalaysia(dataList.get(i).getString("malaysia").replace(",",""));
            atomyRateVO.setMongolia(dataList.get(i).getString("mongolia").replace(",",""));
            atomyRateVO.setNewZealand(dataList.get(i).getString("newZealand").replace(",",""));
            atomyRateVO.setSingapore(dataList.get(i).getString("singapore").replace(",",""));
            atomyRateVO.setTaiwan(dataList.get(i).getString("taiwan").replace(",",""));
            atomyRateVO.setUsa(dataList.get(i).getString("usa").replace(",",""));
            atomyRateVO.setCanada(dataList.get(i).getString("canada").replace(",",""));
            atomyRateVO.setFrance(dataList.get(i).getString("france").replace(",",""));
            atomyRateVO.setGermany(dataList.get(i).getString("germany").replace(",",""));
            atomyRateVO.setSwitzerland(dataList.get(i).getString("switzerland").replace(",",""));
            atomyRateVO.setUnitedKingdom(dataList.get(i).getString("unitedKingdom").replace(",",""));
            atomyRateVO.setGuam(dataList.get(i).getString("guam").replace(",",""));
            atomyRateVO.setSaipan(dataList.get(i).getString("saipan").replace(",",""));
            atomyRateVO.setCambodia(dataList.get(i).getString("cambodia").replace(",",""));
            atomyRateVO.setThailand(dataList.get(i).getString("thailand").replace(",",""));
            atomyRateVO.setPhilippines(dataList.get(i).getString("philippines").replace(",",""));
            atomyRateVO.setSpain(dataList.get(i).getString("spain").replace(",",""));
            atomyRateVO.setPortugal(dataList.get(i).getString("portugal").replace(",",""));
            atomyRateVO.setRussia(dataList.get(i).getString("russia").replace(",",""));
            atomyRateVO.setAddusercd(LoginInfo.getUsercd());
            atomyRateVO.setUpdusercd(LoginInfo.getUsercd());
            atomyRateVO.setTerminalcd(ClientInfo.getClntIP());
            dao.update("AtomyRateMapper.updateAtomyTotalRate", atomyRateVO);
        }
        LRespData respData = new LRespData();
        return respData;
    }
}
