package xrt.sys.s000008;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/sys/s000008")
public class S000008Controller{

	@Resource private CommonBiz commonBiz;
	@Resource private S000008Biz biz;
	
	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception{
		return "sys/s000008/S000008";
	}
	
	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getSearch(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultList",resultList);
		return respData;
	}
	
	//디테일 마스터(중메뉴) 검색
	@RequestMapping(value = "/getMstList.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetailList(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getMstList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	//디테일 리스트(소메뉴) 검색
	@RequestMapping(value = "/getDetailList.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getDetailList2(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> resultList = biz.getDetailList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}
	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap mGridData = reqData.getParamDataMap("mGridData");
		List<LDataMap> dGridDataList = reqData.getParamDataList("dGridDataList");
		LDataMap resultData = biz.setSave(mGridData,dGridDataList);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
		
	}
	//중메뉴 삭제
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		LDataMap resultData = biz.setDelete(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
	}
	//소메뉴 삭제
	@RequestMapping(value = "/setDelete2.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete2(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		LDataMap resultData =biz.setDelete2(paramData);
		
		LRespData respData = new LRespData();
		respData.put("resultData",resultData);
		
		return respData;
	}
}
