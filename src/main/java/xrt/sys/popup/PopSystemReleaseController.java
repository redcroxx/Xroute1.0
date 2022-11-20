package xrt.sys.popup;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 시스템 업데이트 정보 팝업
 */
@Controller
@RequestMapping(value = "/sys/popup/popSystemRelease")
public class PopSystemReleaseController {
	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception {
		return "sys/popup/PopSystemRelease";
	}
}