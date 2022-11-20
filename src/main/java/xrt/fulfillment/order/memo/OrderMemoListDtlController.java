
package xrt.fulfillment.order.memo;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

/**
 * 배송조회상세팝업
 *
 */
@Controller
@RequestMapping(value = "/fulfillment/order/orderMemoListDtl")
public class OrderMemoListDtlController {

	Logger logger = LoggerFactory.getLogger(OrderMemoListDtlController.class);
	
	@Resource
	private CommonBiz commonBiz;
	@Resource
	private OrderMemoListDtlBiz biz;

	// shippingList에서 메모 그림 클릭 시 팝업 호출.
	@RequestMapping(value = "/view.do", method = RequestMethod.GET)
	public String view(HttpServletRequest request, Model model) throws Exception {
		String xrtInvcSno = request.getParameter("xrtInvcSno");
		model.addAttribute("xrtInvcSno", xrtInvcSno);
		model.addAttribute("sEtcCd1", "shippingMemo");
		return "fulfillment/order/memoList/OrderMemoListDtl";
	}
	
	// 셀러 메인 페이지에서 메모 갯수 클릭 시 팝업 호출.
	@RequestMapping(value = "/mainMemoView.do", method = RequestMethod.GET)
	public String mainMemoView(HttpServletRequest request, Model model) throws Exception {
		String closeYn = "";
		if (request.getParameter("closeYn") != null) {
			closeYn = request.getParameter("closeYn");
		}
		model.addAttribute("closeYn", closeYn);
		model.addAttribute("sEtcCd1", "mainMemo");
		return "fulfillment/order/memoList/OrderMemoListDtl";
	}
	
	// 메모 목록 팝업.
	@RequestMapping(value = "/getSearchMemo.do", method = RequestMethod.POST)
	public @ResponseBody LRespData getSearchMemo(@RequestBody CommonSearchVo param, HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		if (loginVo.getOrgcd() == null) {
			param.setsOrgCd("");
		}else {
			param.setsOrgCd(loginVo.getOrgcd());
		}
		
		String sEtcCd1 = param.getsEtcCd1();
		List<OrderMemoMasterVo> memoList = null;
		if (sEtcCd1.equals("shippingMemo")) {
		    memoList = biz.getSearchShippingMemo(param);
        }else if (sEtcCd1.equals("mainMemo")) {
            memoList = biz.getSearchMainMemo(param);
        }
		LRespData retMap = new LRespData();
		retMap.put("resultList", memoList);
		return retMap;
	}
	
	// 검색.
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getSearch(HttpServletRequest request, @RequestBody LDataMap param) throws Exception {
		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		String clientIp = request.getHeader("X-FORWARDED-FOR");
		if ( clientIp == null ) {
			clientIp = request.getRemoteAddr();
		}

		param.put("orgcd", loginVo.getOrgcd());

		List<OrderMemoMasterVo> orderMemoList = biz.getSearch(param);

		LRespData retMap = new LRespData();
		retMap.put("resultList", orderMemoList);
		return retMap;
	}
}
