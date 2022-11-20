package xrt.alexcloud.popup;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 공지사항 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popS014_1")
public class PopS014_1Controller {

	@Resource private PopS014_1Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do" , method = RequestMethod.GET)
	public String view(HttpServletRequest httpServletRequest,Model model) throws Exception {
		LDataMap param = new LDataMap();
		param.put("NTKEY", httpServletRequest.getParameter("ntkey"));

		LDataMap resultData = biz.getSearch(param);
		model.addAttribute("TITLE", resultData.get("TITLE"));
		model.addAttribute("CONTENTS", resultData.get("CONTENTS"));
		model.addAttribute("ADDUSERCD", resultData.get("ADDUSERCD"));
		model.addAttribute("ADDDATETIME", resultData.get("ADDDATETIME"));
		model.addAttribute("NTKEY", resultData.get("NTKEY"));

		return "alexcloud/popup/PopS014_1";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getNoticeList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}


	//첨부파일 검색
/*	@RequestMapping(value = "/getFile.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getFile(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getFile(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}*/


	//첨부파일 다운로드
/*	@RequestMapping(value = "/noticeDownloadFile.do")
	public void noticeDownloadFile(@RequestParam(value = "realFilename") String realFilename,
			@RequestParam(value = "filename") String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String uploadPath = request.getSession().getServletContext().getRealPath("/") + Constants.NOTICE_FILEPATH;

		File uFile = new File(uploadPath, realFilename);
		int fSize = (int) uFile.length();

		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			String mimetype = "text/html;charset=utf-8";
			//String mimetype = servletContext.getMimeType(filename);

			response.setContentType(mimetype);
			response.setBufferSize(fSize);
			String convName = java.net.URLEncoder.encode(filename, "UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=\""
					+ convName + "\"");
			response.setContentLength(fSize);

			FileCopyUtils.copy(in, response.getOutputStream());
			in.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} else {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<script type='text/javascript'>");
			printwriter.println("alert('File not found : " + filename + "');");
			printwriter.println("window.close();");
			printwriter.println("</script>");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}*/
}