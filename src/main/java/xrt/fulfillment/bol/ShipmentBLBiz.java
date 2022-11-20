package xrt.fulfillment.bol;

import java.util.List;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import xrt.alexcloud.common.CommonConst;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.ShippingListVO;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * SBL Biz
 * 
 * @since 2020-12-16
 * @author wnkim
 *
 */
@Service
public class ShipmentBLBiz extends DefaultBiz {

    Logger logger = LoggerFactory.getLogger(ShipmentBLBiz.class);

    /**
     * Shipment_BL 테이블 조회
     * 
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LRespData getSearch(CommonSearchVo paramVO) throws Exception {
        LRespData resData = new LRespData();
        if (paramVO.getsCompCd().equals(CommonConst.XROUTE_COMPCD)) {
            paramVO.setsCompCd(CommonConst.XROUTE_COMPCD);
        }
        List<ShipmentBLVO> torderList = dao.selectList("shipmentBlMapper.getSearch", paramVO);
        resData.put("resultList", torderList);

        return resData;
    }

    /**
     * SBL 상태를 완료처리
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData setComplete(LReqData paramMap) throws Exception {
        List<LDataMap> completaList = paramMap.getParamDataList("dataList");

        for (int i = 0; i < completaList.size(); i++) {

            String shipmentBlNo = completaList.get(i).getString("shipmentBlNo");

            boolean bCloseYn = this.checkCloseYN(shipmentBlNo);
            if (bCloseYn) {
                throw new LingoException("완료된 SBL 입니다.");
            }

            ShipmentBLVO shipmentBLVO = new ShipmentBLVO();
            shipmentBLVO.setShipmentBlNo(shipmentBlNo);
            shipmentBLVO.setCloseYn("Y");
            shipmentBLVO.setUpdusercd(LoginInfo.getUsercd());

            dao.update("shipmentBlMapper.updateShipmentBL", shipmentBLVO);
        }

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * SBL 정보 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData getShipmentBL(LDataMap paramMap) throws Exception {
        List<ShipmentBLVO> shipmentBLList = dao.selectList("shipmentBlMapper.getShipmentBL", paramMap);
        LRespData resData = new LRespData();
        resData.put("resultData", shipmentBLList);
        return resData;
    }

    /**
     * SBL 주문 정보 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData getOrderList(LDataMap paramMap) throws Exception {
        List<ShippingListVO> orderList = dao.selectList("shipmentBlMapper.getOrderList", paramMap);
        LRespData resData = new LRespData();
        resData.put("resultList", orderList);
        return resData;
    }

    /**
     * SBL 주문 삭제
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData deleteTOrder(LReqData paramMap) throws Exception {
        String shipmentBlNo = paramMap.getParamDataVal("shipmentBlNo");
        List<LDataMap> xrtInvcSnos = paramMap.getParamDataList("dataList");

        boolean bCloseYn = this.checkCloseYN(shipmentBlNo);
        if (bCloseYn) {
            throw new LingoException("완료된 SBL 입니다.");
        }

        for (int i = 0; i < xrtInvcSnos.size(); i++) {
            LDataMap updateMap = new LDataMap();
            updateMap.put("statusCd", CommonConst.ORD_STATUS_CD_STOCK_COMP);
            updateMap.put("statusNm", CommonConst.ORD_STATUS_NM_STOCK_COMP);
            updateMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_STOCK_COMP);
            updateMap.put("usercd", LoginInfo.getUsercd());
            updateMap.put("terminalcd", ClientInfo.getClntIP());
            updateMap.put("deleteYn", "Y");
            updateMap.put("xrtInvcSno", xrtInvcSnos.get(i).getString("xrtInvcSno"));

            dao.update("shipmentBlMapper.updateTOrder", updateMap);
            dao.update("shipmentBlMapper.insertTrackingHistory", updateMap);
        }

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * SBL 수정 및 상태 변경
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    public LRespData setPopSave(LDataMap paramMap) throws Exception {
        String type = paramMap.getString("type");
        boolean bCloseYn = this.checkCloseYN(paramMap.getString("shipmentBlNo"));
        if ("data".equals(type) || "".equals(type) && "".equals(paramMap.getString("closeYn"))) {
            if (bCloseYn) {
                throw new LingoException("완료된 SBL 입니다.");
            }
        }

        ShipmentBLVO shipmentBLVO = new ShipmentBLVO();
        shipmentBLVO.setShipmentBlNo(paramMap.getString("shipmentBlNo"));
        shipmentBLVO.setRemark(paramMap.getString("remark"));
        shipmentBLVO.setCloseYn(paramMap.getString("closeYn"));
        shipmentBLVO.setUpdusercd(LoginInfo.getUsercd());

        dao.update("shipmentBlMapper.updateShipmentBL", shipmentBLVO);

        LRespData resData = new LRespData();
        return resData;
    }

    /**
     * 상태 체크 true : 완료, false : 진행 중
     * 
     * @param shipmentBlNo
     * @return
     * @throws Exception
     */
    public boolean checkCloseYN(String shipmentBlNo) throws Exception {
        boolean bRet = false;

        if (shipmentBlNo == null || "".equals(shipmentBlNo)) {
            throw new LingoException("SBL 번호가 없습니다.");
        }

        LDataMap checkMap = new LDataMap();
        checkMap.put("shipmentBlNo", shipmentBlNo);
        checkMap.put("compcd", LoginInfo.getCompcd());
        Object vo = dao.selectOne("shipmentBlMapper.getShipmentBL", checkMap);
        ShipmentBLVO shipmentBLVO = (ShipmentBLVO) vo;

        logger.debug("shipmentBLVO : " + shipmentBLVO.toString());
        if ("Y".equals(shipmentBLVO.getCloseYn().trim().toUpperCase())) {
            bRet = true;
        }

        return bRet;
    }

    public List<LDataMap> makeExcelList(LDataMap paramMap) throws Exception{
        List<LDataMap> excelList = dao.selectList("shipmentBlMapper.getTorder", paramMap);
        
        for (int i = 0; i < excelList.size(); i++) {
            logger.info("excelList[" + i + "] : " + excelList.get(i));
        }
        return excelList;
    }
    
    public SXSSFWorkbook excelFileDownloadProcess(List<LDataMap> excelList) throws Exception{
        
        // 워크북 생성.
        SXSSFWorkbook workbook = new SXSSFWorkbook();
        // 워크시트 생성.
        SXSSFSheet sheet = (SXSSFSheet) workbook.createSheet("Shipment_XrtInvcSno");
        // 행 생성.
        SXSSFRow row = (SXSSFRow) sheet.createRow(0);
        // 셀 생성.
        SXSSFCell cell;
        
        CellStyle style = workbook.createCellStyle(); //스타일 생성 
        style.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex()); //색 설정.
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        // 셀 길이 설정.
        sheet.setColumnWidth(0, 5000);
        
        // 헤더 정보 구성 .
        cell = row.createCell(0);
        cell.setCellValue("SBL 번호");
        cell.setCellStyle(style); //스타일 적용
        cell = row.createCell(1);
        cell.setCellValue("XRT 송장번호");
        cell.setCellStyle(style); //스타일 적용
        
        // 내용 행 및 셀 생성.
        for (int i = 0; i < excelList.size(); i++) {
            // 셀 길이 설정.
            sheet.setColumnWidth(0 + i, 5000);
            // 행 생성.
            row = sheet.createRow(i + 1);
            // 셀 생성.
            cell = row.createCell(0);
            cell.setCellValue(excelList.get(i).getString("shipmentBlNo"));
            cell = row.createCell(1);
            cell.setCellValue(excelList.get(i).getString("xrtInvcSno"));
        }
        return workbook; 
    }
}
