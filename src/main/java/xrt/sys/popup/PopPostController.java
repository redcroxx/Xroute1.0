package xrt.sys.popup;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 우편번호 팝업
 */
@Controller
@RequestMapping(value = "/sys/popup/popPost")
public class PopPostController {

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception {
		return "sys/popup/PopPost";
	}
}