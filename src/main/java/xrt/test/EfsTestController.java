package xrt.test;

import java.util.Map;

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
public class EfsTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(EfsTestController.class);
	
	@Resource private EfsTestBiz biz;
	
	//화면 호출
	@RequestMapping(value = "/test/sampleEfsTest.do")
	public String view(ModelMap model) throws Exception {

		return "test/sampleEfsTest";
	}
	
	//보내기
	@RequestMapping(value = "/test/getEfsSend.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSend(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		Map<String, Object> result = biz.efsCreateShipment(paramData);

		LRespData respData = new LRespData();
		respData.put("result", result);

		return respData;
	}

}
