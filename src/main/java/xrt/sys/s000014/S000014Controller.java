package xrt.sys.s000014;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 공지사항 등록
 */
@Controller
@RequestMapping(value = "/sys/s000014")
public class S000014Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private S000014Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {

		model.addAttribute("CODE_NTTYPE", commonBiz.getCommonCode("NTTYPE"));
		model.addAttribute("CODE_ISUSING", commonBiz.getCommonCode("ISUSING"));
		model.addAttribute("CODE_NTTARGET", commonBiz.getCommonCode("NTTARGET"));
		model.addAttribute("CODE_YN", commonBiz.getCommonCode("YN"));

		return "sys/s000014/S000014";
	}

	// 에디터 관련 페이지 호출
	@RequestMapping(value = "/editor.do")
	public String editor(ModelMap model) throws Exception {
		return "sys/s000014/SmartEditor2Skin";
	}

	@RequestMapping(value = "/smart_editor2_inputarea.do")
	public String smart_editor2_inputarea(ModelMap model) throws Exception {
		return "sys/s000014/smart_editor2_inputarea";
	}

	@RequestMapping(value = "/smart_editor2_inputarea_ie8.do")
	public String smart_editor2_inputarea_ie8(ModelMap model) throws Exception {
		return "sys/s000014/smart_editor2_inputarea_ie8";
	}

	@RequestMapping(value = "/photo_uploader.do")
	public String photo_uploader(ModelMap model) throws Exception {
		return "sys/s000014/photo_uploader";
	}

	//검색
	@RequestMapping(value = "/getInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getInfo(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.getInfo(paramData);
		List<LDataMap> resultList = biz.getTargetList(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		respData.put("resultList", resultList);

		return respData;
	}

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");
		List<LDataMap> paramList = reqData.getParamDataList("paramList");
		LDataMap paramFile = reqData.getParamDataMap("paramFile");

		LDataMap resultData = biz.setSave(paramData, paramList, paramFile);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}

	//첨부파일 업로드
	@RequestMapping(value = "/setFile.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setFile(MultipartHttpServletRequest request) throws Exception {
		Iterator<String> itr = request.getFileNames();

		LDataMap resultAttachFile = new LDataMap();
		LRespData respData = new LRespData();

		int n = 0;

		while(itr.hasNext()) {

			MultipartFile uploadfile = request.getFile(itr.next());
			String fileName = "";
			String realFileName = "";
			String uploadPath = request.getSession().getServletContext().getRealPath("/") + Constants.NOTICE_FILEPATH;

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

			resultAttachFile.put("FILENM" + n, fileName);
			resultAttachFile.put("ORIGINFILENM" + n, realFileName);

			n = n + 1;
		}
		respData.put("resultAttachFile", resultAttachFile);

		return respData;
	}

	// html5기반 드래그 앤 드랍 이미지 업로드 처리
	@RequestMapping("/file_uploader_html5")
	public void file_uploader_html5(HttpServletRequest request, HttpServletResponse response) {
		try {
		//파일정보
		String sFileInfo = "";
		//파일명을 받는다 - 일반 원본파일명
		String filename = request.getHeader("file-name");
		//파일 확장자
		String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
		//확장자를소문자로 변경
		filename_ext = filename_ext.toLowerCase();
		//이미지 검증 배열변수
		String[] allow_file = {"jpg","png","bmp","gif"};
		//돌리면서 확장자가 이미지인지
		int cnt = 0;
		for(int i=0; i<allow_file.length; i++) {
			if(filename_ext.equals(allow_file[i])){
				cnt++;
			}
		}
		//이미지가 아님
		if (cnt == 0) {
			PrintWriter print = response.getWriter();
			print.print("NOTALLOW_"+filename);
			print.flush();
			print.close();
		} else {
			//이미지이므로 신규 파일로 디렉토리 설정 및 업로드
			//파일 기본경로
			String dftFilePath = request.getSession().getServletContext().getRealPath("/");
			//파일 기본경로 _ 상세경로
			//String filePath = dftFilePath + "resources" + File.separator + "editor" + File.separator +"multiupload" + File.separator;
			String filePath = dftFilePath + Constants.NOTICE_IMAGEPATH + File.separator;
			File file = new File(filePath);
			if (!file.exists()) {
				file.mkdirs();
			}
			String realFileNm = "";
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			String today= formatter.format(new java.util.Date());
			realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
			String rlFileNm = filePath + realFileNm;
			///////////////// 서버에 파일쓰기 /////////////////
			InputStream is = request.getInputStream();
			OutputStream os=new FileOutputStream(rlFileNm);
			int numRead;
			byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
			while((numRead = is.read(b,0,b.length)) != -1){
				os.write(b,0,numRead);
			}
			if (is != null) { is.close(); }
			os.flush();
			os.close();
			///////////////// 서버에 파일쓰기 /////////////////
			// 정보 출력
			sFileInfo += "&bNewLine=true";
			// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
			sFileInfo += "&sFileName="+ filename;
			//sFileInfo += "&sFileURL="+"/resources/editor/multiupload/"+realFileNm;
			sFileInfo += "&sFileURL="+Constants.NOTICE_IMAGEPATH+"/"+realFileNm;
			PrintWriter print = response.getWriter();
			print.print(sFileInfo);
			print.flush();
			print.close();
		}
	} catch (Exception e) { e.printStackTrace(); }
}

	// 일반 이미지 업로드 처리
	@RequestMapping("/file_uploader")
	public String file_uploader(HttpServletRequest request, HttpServletResponse response, Editor editor){
		String return1=request.getParameter("callback");
		String return2="?callback_func=" + request.getParameter("callback_func");
		String return3="";
		String name = "";
		try {
			if(editor.getFiledata() != null && editor.getFiledata().getOriginalFilename() != null && !editor.getFiledata().getOriginalFilename().equals("")) {
				// 기존 상단 코드를 막고 하단코드를 이용
				name = editor.getFiledata().getOriginalFilename().substring(editor.getFiledata().getOriginalFilename().lastIndexOf(File.separator)+1);
				String filename_ext = name.substring(name.lastIndexOf(".")+1);
				filename_ext = filename_ext.toLowerCase();
				String[] allow_file = {"jpg","png","bmp","gif"};
				int cnt = 0;
				for(int i=0; i<allow_file.length; i++) {
					if(filename_ext.equals(allow_file[i])){ cnt++; }
				}
				if(cnt == 0) {
					return3 = "&errstr="+name;
				} else {
					//파일 기본경로
					String dftFilePath = request.getSession().getServletContext().getRealPath("/");
					//파일 기본경로 _ 상세경로
					//String filePath = dftFilePath + "resources"+ File.separator + "editor" + File.separator +"upload" + File.separator;
					String filePath = dftFilePath + Constants.NOTICE_IMAGEPATH + File.separator;
					File file = new File(filePath);
					if(!file.exists()) { file.mkdirs(); }
					String realFileNm = "";
					SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
					String today= formatter.format(new java.util.Date());
					realFileNm = today+UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
					String rlFileNm = filePath + realFileNm;
					///////////////// 서버에 파일쓰기 /////////////////
					editor.getFiledata().transferTo(new File(rlFileNm));
					///////////////// 서버에 파일쓰기 /////////////////
					return3 += "&bNewLine=true";
					return3 += "&sFileName="+ name;
					//return3 += "&sFileURL=/resources/editor/upload/"+realFileNm;
					return3 += "&sFileURL="+Constants.NOTICE_IMAGEPATH+"/"+realFileNm;
				}
			} else {
				return3 += "&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:"+return1+return2+return3;
	}

	public class Editor {
		private MultipartFile Filedata;
		public MultipartFile getFiledata() {
			return Filedata;
		}
		public void setFiledata(MultipartFile filedata) {
			Filedata = filedata;
		}
	}

	//파일 삭제
	@RequestMapping(value = "/setFileDel.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setFileDel(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setFileDel(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
}