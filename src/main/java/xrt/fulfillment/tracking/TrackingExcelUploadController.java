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

import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/tracking/excel")
public class TrackingExcelUploadController {

	Logger logger = LoggerFactory.getLogger(TrackingExcelUploadController.class);

	@Resource
	private CommonBiz commonBiz;
	@Resource
	private TrackingExcelUploadBiz biz;

	// 팝업 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		return "fulfillment/tracking/TrackingExcelUpload";
	}

	// 국가조회 검색
	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	public 	@ResponseBody LRespData upload(HttpServletRequest request, @RequestBody List<StockHistoryVo> paramList) throws Exception {

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		String terminalCd = request.getHeader("X-FORWARDED-FOR");
		if ( terminalCd == null ) {
			terminalCd = request.getRemoteAddr();
		}

		for (StockHistoryVo stockHistoryVo : paramList) {
			stockHistoryVo.setAdddatetime(stockHistoryVo.getCheckPointDate());
			stockHistoryVo.setStatusCd(stockHistoryVo.getTag().toUpperCase());
			stockHistoryVo.setTerminalcd(terminalCd);
			stockHistoryVo.setAddusercd(loginVo.getUsercd());
			stockHistoryVo.setUpdusercd(loginVo.getUsercd());
		}

		LDataMap lDataMap = biz.process(paramList);
		LRespData retMap = new LRespData();
		return retMap;
	}
}
