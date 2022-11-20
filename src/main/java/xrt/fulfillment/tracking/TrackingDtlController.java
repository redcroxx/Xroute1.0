package xrt.fulfillment.tracking;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/tracking/trackingDtl")
public class TrackingDtlController {

	Logger logger = LoggerFactory.getLogger(TrackingDtlController.class);

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private TrackingDtlBiz biz;

	// 팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "fulfillment/tracking/TrackingDtl";
	}

	// 국가조회 검색
	@RequestMapping(value = "/getCountryList.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getCountryList(@RequestBody CommonSearchVo paramVo) throws Exception {

		List<CodeVO> countrylist = commonBiz.getCommonCode("COUNTRYLIST");
		LRespData retMap = new LRespData();
		retMap.put("resultList", countrylist);
		return retMap;
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVo) throws Exception {

		List<StockHistoryVo> stockHistoryList = biz.getSearch(paramVo);
		LRespData retMap = new LRespData();
		retMap.put("resultList", stockHistoryList);
		return retMap;
	}

	//
	@RequestMapping(value = "/save.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData process(HttpServletRequest request, @RequestBody List<StockHistoryVo> paramList) throws Exception {

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		String terminalCd = request.getHeader("X-FORWARDED-FOR");
		if ( terminalCd == null ) {
			terminalCd = request.getRemoteAddr();
		}

		for (StockHistoryVo stockHistoryVo : paramList) {
			stockHistoryVo.setTerminalcd(terminalCd);
			stockHistoryVo.setAddusercd(loginVo.getUsercd());
			stockHistoryVo.setUpdusercd(loginVo.getUsercd());
		}

		LDataMap lDataMap = biz.process(paramList);
		LRespData retMap = new LRespData();
		return retMap;
	}

	//
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData delete(@RequestBody StockHistoryVo paramVo) throws Exception {

		LDataMap lDataMap = biz.delete(paramVo);
		LRespData retMap = new LRespData();
		return retMap;
	}
}
