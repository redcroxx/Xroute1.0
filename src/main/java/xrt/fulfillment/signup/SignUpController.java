package xrt.fulfillment.signup;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

/**
 * 사용자 회원가입
 */
@Controller
@RequestMapping(value = "/signup")
public class SignUpController {

	@Resource
	private SignUpBiz biz;

	// 회원가입 화면
	@RequestMapping(value = "/SignUp.do")
	public String signUp() throws Exception {
		return "fulfillment/signup/SignUp";
	}

	// 가입신청 완료 화면
	@RequestMapping(value = "/SignUpSave.do")
	public String signUpSave() throws Exception {
		return "fulfillment/signup/SignUpSave";
	}

	// 아이디 체크
	@RequestMapping(value = "/IdCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData idCheck(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = new LDataMap();

		paramData.put("id", reqData.get("id"));
		LDataMap resultData = biz.idCheck(paramData);
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		return respData;
	}

	// 파일 업로드
	@RequestMapping(value = "/setFile.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setFile(MultipartHttpServletRequest request) throws Exception {
		Iterator<String> itr = request.getFileNames();

		LDataMap resultAttachFile = new LDataMap();
		LRespData respData = new LRespData();
		int n = 0;

		while (itr.hasNext()) {

			MultipartFile uploadfile = request.getFile(itr.next());
			String fileName = "";
			String realFileName = "";

			//상대경로
			//String uploadPath = request.getSession().getServletContext().getRealPath("/") + Constants.SELLER_FILEPATH;
			
			//절대경로
			String uploadPath = Constants.SELLER_ABSOLUTE_FILE_PATH;

			if (uploadfile != null) {
				fileName = uploadfile.getOriginalFilename();

				try {
					String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date()); // 현재시간
					int i = -1;
					i = fileName.lastIndexOf("."); // 파일 확장자 위치
					realFileName = now + fileName.substring(i, fileName.length()); // 현재시간과 원본 확장자 합치기
					File saveFolder = new File(uploadPath);

					// 디렉토리 생성
					if (!saveFolder.exists() || saveFolder.isFile()) {
						saveFolder.mkdirs();
					}

					uploadfile.transferTo(new File(uploadPath + File.separator + realFileName));

				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			resultAttachFile.put("FILENM" + n, fileName);
			resultAttachFile.put("ORIGINFILENM" + n, realFileName);

			n = n + 1;
		}
		respData.put("resultAttachFile", resultAttachFile);

		return respData;

	}

	// 가입신청
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap pramData = reqData.getParamDataMap("objList");
		pramData.put("COMPCD", CommonConst.XROUTE_COMPCD);
		LDataMap resultData = biz.setSave(pramData);
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		return respData;
	}

}
