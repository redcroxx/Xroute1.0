package xrt.fulfillment.order.comingsoon;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 페이지 준비중
 *
 */
@Controller
@RequestMapping(value = "/CommingSoon")
public class CommingSoonController {
	// 페이지 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		return "commingsoon/CommingSoon";
	}

	// 페이지 호출2
	@RequestMapping(value = "/view2.do")
	public String view2(ModelMap model) throws Exception {

		return "commingsoon/CommingSoon2";
	}

}
