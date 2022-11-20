package xrt.alexcloud.popup;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 사업자등록증 수정 팝업
 */
@Controller
@RequestMapping(value = "/alexcloud/popup/popP000002")
public class PopP000002Controller {

	@Resource private PopP000002Biz biz;

	//팝업 호출
	@RequestMapping(value = "/view.do")
	public String view() throws Exception {
		return "/alexcloud/popup/PopP000002";
	}

	//검색
	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData search(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getSearch(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//첨부파일 업로드
	@RequestMapping(value = "/setFile.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setFile(MultipartHttpServletRequest request, @RequestParam("originfilenm") String name) throws Exception {
		Iterator<String> itr = request.getFileNames();

		LDataMap resultAttachFile = new LDataMap();
		LRespData respData = new LRespData();

		int n = 0;

		while(itr.hasNext()) {

			MultipartFile uploadfile = request.getFile(itr.next());
			String fileName = "";
			String realFileName = "";

			//상대경로
			//String uploadPath = request.getSession().getServletContext().getRealPath("/") + Constants.SELLER_FILEPATH;

			//절대경로
			String uploadPath = Constants.SELLER_ABSOLUTE_FILE_PATH;


			//파일 업로드
			if (uploadfile != null) {
				fileName = uploadfile.getOriginalFilename();

				try {
					String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  //현재시간
					int i = -1;
					i = fileName.lastIndexOf("."); // 파일 확장자 위치
					realFileName = now + fileName.substring(i, fileName.length());  //현재시간과 파일명 합치기

					File saveFolder = new File(uploadPath);

					// 디렉토리 생성
					if (!saveFolder.exists() || saveFolder.isFile()) {
						saveFolder.mkdirs();
					}

					uploadfile.transferTo(new File(uploadPath + "/" + realFileName));
				} catch (Exception e) {

				}
			}

			//기존파일 삭제
			File originFile = new File(uploadPath + "/" + name);

			try {
				if(originFile.isFile()) { //해당 파일이 존재할 경우
					if(!originFile.isDirectory()) { //디렉토리가 아닐 경우
						originFile.delete();
					}
				}
			} catch (Exception e) {

			}


			resultAttachFile.put("FILENM", fileName);
			resultAttachFile.put("ORIGINFILENM", realFileName);

			n = n + 1;
		}
		respData.put("resultAttachFile", resultAttachFile);

		return respData;
	}


	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setSave(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}