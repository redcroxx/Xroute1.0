package xrt.alexcloud.api.atomy;

import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.fulfillment.order.shippinglist.ShippingListBiz;
import xrt.fulfillment.system.WeightCalculationBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/schedule")
public class AtomyApiOrderScheduler {

	Logger logger = LoggerFactory.getLogger(AtomyApiOrderScheduler.class);

	private AtomyApiOrderListController apiOrderListController;
	private AtomyApiOrderListBiz atomyApiOrderListBiz;
	private UnipassAPI unipassAPI;
	private WeightCalculationBiz weightCalculationBiz;
	private ShippingListBiz shippingListBiz;

	@Autowired
	public AtomyApiOrderScheduler(AtomyApiOrderListBiz atomyApiOrderListBiz, UnipassAPI unipassAPI,
			AtomyApiOrderListController apiOrderListController, ShippingListBiz shippingListBiz) {
		this.atomyApiOrderListBiz = atomyApiOrderListBiz;
		this.unipassAPI = unipassAPI;
		this.apiOrderListController = apiOrderListController;
	}

	// ATOMY 주문정보 가져오기 (5시 스케쥴러)
	@Scheduled(cron = "0 00 17 * * *")
	public LDataMap getAtomyOrdersSchedule() throws Exception {
		logger.info("17:00 Scheduled : getAtomyOrdersSchedule");
		CommonSearchVo paramVo = new CommonSearchVo();
		String startDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		paramVo.setsToDate(startDate);
		paramVo.setsFromDate(startDate);
		paramVo.setsPeriodType("1st");
		return apiOrderListController.getAtomyOrderInfo(paramVo);
	}

	// XROUTE 주문서 생성 (8시 스케쥴러)
	@Scheduled(cron = "0 00 08 * * *")
	public LDataMap setAtomyOrderSchedule() throws Exception {
		logger.info("8:00 Scheduled : setAtomyOrderSchedule");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.DATE, -1); // 날짜를 하루 뺌.
		String yesterDate = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		CommonSearchVo paramVo = new CommonSearchVo();
		paramVo.setsToDate(yesterDate);
		paramVo.setsFromDate(yesterDate);
		paramVo.setsPeriodType("2nd");
		apiOrderListController.getAtomyOrderInfo(paramVo);
		return apiOrderListController.setAtomyOrder(paramVo);
	}

	// UNIPASS 선적대기 호출 (9시 17시) -> 2시간마다로 변경
	//    @RequestMapping(value = "/unipass.do", method = RequestMethod.GET)
	//    @ResponseBody    
	@Scheduled(cron = "0 0 0/2 * * *")
	public LDataMap getUnipassTrackingStatus() throws Exception {
		logger.info("UNIPASS Controller");
		return unipassAPI.getUnipassTrackingStatus();
	}
	
	@Scheduled(cron = "0 0 00 * * *")
    public LRespData shippingStatusRefresh() throws Exception {
        logger.debug("shippingStatusRefresh");
        List<LDataMap> orders = shippingListBiz.shippingGetOrders();
        LRespData resData = shippingListBiz.setAtomyHistoryRefresh(orders);        
        return resData;
    }

	@RequestMapping(value = "/testAPI.do", method = RequestMethod.POST)
	@ResponseBody
	public LDataMap testAPI() throws Exception {

		LDataMap retMap = new LDataMap();
		CommonSearchVo vo = new CommonSearchVo();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

		vo.setsToDate(dateFormat.format(cal.getTime()));
		vo.setsFromDate(dateFormat.format(cal.getTime()));

		try {
			// 1. 주문 갯수 호출.
			retMap = atomyApiOrderListBiz.getTotalcountDirect(vo); // 1. 출하요청 개수 조회 (역직구 전용).

		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}
	

	
	
    @RequestMapping(value = "/test.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap calcTest()throws Exception{
        return unipassAPI.getNormalSellerUnipassTrackingStatus();
    }
}