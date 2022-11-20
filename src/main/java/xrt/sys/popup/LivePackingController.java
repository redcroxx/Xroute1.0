package xrt.sys.popup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;


@Controller
@RequestMapping(value = "/livePacking")
public class LivePackingController {

	Logger logger = LoggerFactory.getLogger(LivePackingController.class);

	LivePackingBiz biz;

	@Autowired
	public LivePackingController(LivePackingBiz livePackingBiz) {
		this.biz = livePackingBiz;
	}
	
	@RequestMapping(value = "/view.do", method = RequestMethod.POST)
	public String view(HttpServletRequest request, ModelMap model) throws Exception {
		logger.debug("[view] xrtInvcSno : "+ request.getParameter("xrtInvcSno"));
		String xrtInvcSno = request.getParameter("xrtInvcSno") != null? request.getParameter("xrtInvcSno").toString():"";
		String orgcd = request.getParameter("orgcd") != null? request.getParameter("orgcd").toString():"";

		model.addAttribute("xrtInvcSno", xrtInvcSno);
		model.addAttribute("orgcd", orgcd);

		return "sys/popup/LivePacking";
	}

	@RequestMapping(value = "/upload.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData upload(HttpServletRequest request) throws Exception {
		logger.debug("orgcd : "+ request.getParameter("orgcd"));
		MultipartRequest multipartReq = (MultipartRequest) request;
		MultipartFile multipartFile = multipartReq.getFile("file");

		logger.debug("filName : "+ multipartFile.getOriginalFilename() +", fileSzie : "+ multipartFile.getSize());
		String s3Url = biz.upload(multipartFile);

		HttpSession session = request.getSession();
		LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
		String clientIp = request.getHeader("X-FORWARDED-FOR");
		String usercd = loginVo == null ? "system":loginVo.getUsercd();
		String orgcd = request.getParameter("orgcd") == null ? "9999":request.getParameter("orgcd");
		if (clientIp == null) {
			clientIp = request.getRemoteAddr();
		}
		
		LDataMap paramMap = new LDataMap();
		paramMap.put("xrtInvcSno", multipartFile.getOriginalFilename());
		paramMap.put("s3Url", s3Url);
		paramMap.put("usercd", usercd);
		paramMap.put("orgcd", orgcd);
		paramMap.put("terminalcd", clientIp);
		biz.insert(paramMap);

		LRespData retMap = new LRespData();
		return retMap;
	}
}
