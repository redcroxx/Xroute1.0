package xrt.fulfillment.bol;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * SBL Controller
 * 
 * @since 2020-12-17
 * @author wnkim
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/bol/shipment/bl")
public class ShipmentBLController {

    Logger logger = LoggerFactory.getLogger(ShipmentBLController.class);

    private ShipmentBLBiz shipmentBLBiz;

    @Autowired
    public ShipmentBLController(ShipmentBLBiz shipmentBLBiz) {
        super();
        this.shipmentBLBiz = shipmentBLBiz;
    }

    /**
     * 최초 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {
        return "fulfillment/bol/ShipmentBLList";
    }

    /**
     * SHIPMENT_BL 조회
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.debug("CommonSearchVO : " + paramVO.toString());
        LRespData resData = shipmentBLBiz.getSearch(paramVO);
        return resData;
    }
    
    /**
     * SBL 상태를 완료처리
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/setComplete.do", method = RequestMethod.POST)
    public LRespData setComplete(@RequestBody LReqData paramMap) throws Exception {
        logger.debug("LReqData : " +  paramMap.toString());
        LRespData resData = shipmentBLBiz.setComplete(paramMap);
        return resData;
    }
    
    /**
     * 최초 팝업 화면 반환
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {
        return "fulfillment/bol/ShipmentBLPop";
    }

    /**
     * SBL 정보 조회
     * 
     * @param LDataMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/getShipmentBl.do")
    @ResponseBody
    public LRespData getShipmentBL(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LDataMap : " + paramMap.toString());
        LRespData resData = shipmentBLBiz.getShipmentBL(paramMap);
        return resData;
    }
    
    /**
     * SBL 주문 정보 조회
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/pop/getOrderList.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getOrderList(@RequestBody LDataMap paramMap) throws Exception {
       logger.debug("LDataMap : " + paramMap.toString());
       LRespData resData = shipmentBLBiz.getOrderList(paramMap);
       return resData;
    }
    
    /**
     * SBL 주문 내용 삭제
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/deleteTOrder.do", method = RequestMethod.POST)
    public LRespData deleteTOrder(@RequestBody LReqData paramMap) throws Exception {
        logger.debug("LReqData : " + paramMap.toString());
        LRespData resData = shipmentBLBiz.deleteTOrder(paramMap);
        return resData;
    }

    /**
     * SBL 수정 및 상태변경
     * 
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/pop/setSave.do", method = RequestMethod.POST)
    public LRespData setPopSave(@RequestBody LDataMap paramMap) throws Exception {
        logger.debug("LDataMap : " + paramMap.toString());
        LRespData resData = shipmentBLBiz.setPopSave(paramMap);
        return resData;
    }
    
    /**
     * 선택 SBL 행 엑셀 다운로드
     * 
     * @param paramMap
     * @return
     * @throws Exception
     */
    
    @RequestMapping(value = "/excelDownload.do")
    public void excelDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String shipmentBlNos = request.getParameter("shipmentBlNos");
        
        String[] shipmentBlArr = shipmentBlNos.split(";");
        List<LDataMap> shipmentBlList = new ArrayList<>(); // 배열을 list로 변환.
        
        for (int i = 0; i < shipmentBlArr.length; i++) {
            LDataMap dataMap = new LDataMap();
            dataMap.put("shipmentBlNos", shipmentBlArr[i]);
            shipmentBlList.add(dataMap);
        }
        
        LDataMap paramMap = new LDataMap();
        paramMap.put("dataList", shipmentBlList);
        
        logger.info("shipmentBlList : " + shipmentBlList.toString());
        
        List<LDataMap> excelList = shipmentBLBiz.makeExcelList(paramMap);
        SXSSFWorkbook workbook = shipmentBLBiz.excelFileDownloadProcess(excelList);
        
        Locale locale = Locale.KOREA;
        String workbookName = "ShipmentBl_XrtInvcSno";
        
        // 겹치는 파일 이름 중복을 피하기 위해 시간을 이용해서 파일 이름에 추가.
        Date date = new Date();
        SimpleDateFormat dayFormat = new SimpleDateFormat("yyyyMMdd", locale);
        SimpleDateFormat hourFormat = new SimpleDateFormat("hhmmss", locale);
        
        String day = dayFormat.format(date);
        String hour = hourFormat.format(date);
        String fileName = workbookName + "_" + day + "_" + hour;
        
        // 입력된 내용 파일로 쓰기
        try {
            response.setContentType( "application/download; UTF-8" );
            response.setHeader("Content-Type", "application/octet-stream");
            response.setHeader("Content-Transfer-Encoding", "binary;");
            response.setHeader("Pragma", "no-cache;");
            response.setHeader("Expires", "-1;");
            response.setHeader("Set-Cookie", "fileDownload=true; path=/");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
            workbook.write(response.getOutputStream());
            response.getOutputStream().flush();
            response.getOutputStream().close();
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if(workbook!=null) {
                    workbook.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
