<%--
	String host = "ip:port";
	String app = "myapp";											// WebApplication 명.
	String url = "http://" + host + (app.equals("")?"":("/" + app));// WebApplication URL.
	String jrf_dir = "/WAS/myapp/ubireport/work/";					// 리포트 파일 위치.
	String jrf = "ubi_sample.jrf";									// 리포트 파일명.
	String ds = "jdbc/tutorial";									// WAS에 설정된 DataSource 명.
	String file_url = url + "/ubireport";							// 리포트에서 사용되는 이미지 또는 공통 아이템 정보를 가져오기위한 정보.
	String servlet_url1 = url + "/UbiForm";							// Form 서블릿 URL.
	String servlet_url2 = url + "/UbiData";							// Data 서블릿 URL.
	String args = "arg1#value1#arg2#value2#...#argn#valuen#";		// 아규먼트 정보.
	String export_dir = "/WAS/myapp/ubireport/sample/";				// 파일 저장 경로.
	String export_file = "ubi_sample.pdf";							// 파일명.

	try {

		UbiViewer ubiviewer = new UbiViewer(false, false);	// 객체 생성
		ubiviewer.setParameters(file_url, servlet_url1, servlet_url2, jrf_dir, jrf, ds, args, "TYPE6"); // 파일 저장을 위한 기본 정보 설정
		ubiviewer.isDeflater = true;						//서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
		ubiviewer.isUnicode = false;						//서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
		ubiviewer.isBase64 = true;							//서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
		ubiviewer.isUTF8 = true;							//서버와의 통신 옵션 (ubigateway.property의 속성과 같아야함)
		ubiviewer.fontRevision = true;						// 변경 불가.
		ubiviewer.setFontPath("/java6/jre/lib/fonts/");		//WAS가 설치된 서버의 OS가 Non-Windows인 경우 폰트 정보를 가져오는 부분을 설정.

		ubiviewer.setExportParams("PDF", (export_dir + export_file)); // 파일 저장 설정

		boolean isSuccess = ubiviewer.loadReport(); // 파일 저장 수행.

		if( isSuccess )
			out.println("Export Success!");
		else
			out.println("Export Fail!");
	}
	catch(Exception e) {

		e.printStackTrace();
	}

--%>
