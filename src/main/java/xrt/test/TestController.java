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
public class TestController {
	
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@Resource private TestBiz biz;
	
	//화면 호출
	@RequestMapping(value = "/test/sampletest.do")
	public String view(ModelMap model) throws Exception {

		return "test/sampletest";
	}
	
	//보내기
	@RequestMapping(value = "/test/getSend.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSend(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LRespData result = biz.getSend(paramData);

		LRespData respData = new LRespData();
		respData.put("result", result);

		return respData;
	}
	
}
