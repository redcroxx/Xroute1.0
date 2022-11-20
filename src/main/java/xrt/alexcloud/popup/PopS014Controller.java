package xrt.alexcloud.popup;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 공지사항 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popS014")
public class PopS014Controller {

	@Resource private PopS014Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception {
		return "alexcloud/popup/PopS014";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}


	//첨부파일 검색
	@RequestMapping(value = "/getFile.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getFile(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getFile(paramData);

		LRespData respData = new LRespData();
		respData.put("resultList", resultList);

		return respData;
	}


	//첨부파일 다운로드
	@RequestMapping(value = "/noticeDownloadFile.do")
	public void noticeDownloadFile(@RequestParam(value = "realFilename") String realFilename,
			@RequestParam(value = "filename") String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String uploadPath = Constants.SELLER_ABSOLUTE_FILE_PATH;

		File uFile = new File(uploadPath, realFilename);
		int fSize = (int) uFile.length();

		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
			String mimetype = "text/html;charset=utf-8";
			//String mimetype = servletContext.getMimeType(filename);

			response.setContentType(mimetype);
			response.setBufferSize(fSize);
			String convName = java.net.URLEncoder.encode(realFilename, "UTF-8");
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
			printwriter.println("alert('해당 파일이 존재하지 않습니다 : " + realFilename + "');");
			printwriter.println("window.close();");
			printwriter.println("</script>");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}
}