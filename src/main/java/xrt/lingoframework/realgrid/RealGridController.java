package xrt.lingoframework.realgrid;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.excel.POIExcelViewGrid;
import xrt.lingoframework.realgrid.biz.RealGridBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/comm/realgrid")
public class RealGridController {

	@Resource private RealGridBiz biz;

	//그리드 엑셀 저장
	@RequestMapping(value = "/getExcel.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getExcel(@RequestBody LReqData reqData, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("colModel", reqData.getParamDataList("colModel"));
		param.put("gridData", reqData.getParamDataList("gridData"));
		param.put("title", reqData.getParamDataVal("title"));
		param.put("groupHeaderName", reqData.getParamDataList("groupHeaderName"));

		POIExcelViewGrid excelview = new POIExcelViewGrid();
		byte[] binary = excelview.buildExcelXSSF(param, req, resp);
		String binaryStr = DatatypeConverter.printBase64Binary(binary);

		LRespData respData = new LRespData();
		respData.put("exceldata", binaryStr);

		return respData;
	}

	//그리드 컬럼 정보 검색
	@RequestMapping(value = "/getColumns.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getColumns(@RequestBody LReqData reqData) throws Exception {
		LDataMap param = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getColumns(param);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	
	//그리드 컬럼 정보 변경 팝업 호출
	@RequestMapping(value = "/popRealGridColModify/view.do")
	public String popRealGridColModify() throws Exception {
		return "popup/PopRealGridColModify";
	}

	//그리드 컬럼 정보 저장
	@RequestMapping(value = "/setColumns.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setColumns(@RequestBody LReqData reqData) throws Exception {
		LDataMap param = reqData.getParamDataMap("paramData");

		biz.setColumns(param);

		LRespData respData = new LRespData();

		return respData;
	}

	//그리드 컬럼 정보 초기화
	@RequestMapping(value = "/deleteColumns.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData deleteColumns(@RequestBody LReqData reqData) throws Exception {
		LDataMap param = reqData.getParamDataMap("paramData");

		biz.deleteColumns(param);

		LRespData respData = new LRespData();

		return respData;
	}
}