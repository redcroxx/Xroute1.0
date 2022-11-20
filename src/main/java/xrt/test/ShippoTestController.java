package xrt.test;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
public class ShippoTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@Resource private ShippoTestBiz biz;

	@RequestMapping(value = "/test/sampleShippoTest.do")
	public String viewShippo(ModelMap model) throws Exception {

		return "test/sampleShippoTest";
	}
	
	@RequestMapping(value = "/test/getShippoSend.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getShippoSend(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LRespData result = biz.getShippoSend(paramData);

		LRespData respData = new LRespData();
		respData.put("result", result);

		return respData;
	}
	
}
