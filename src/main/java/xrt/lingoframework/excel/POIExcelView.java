package xrt.lingoframework.excel;

public class POIExcelView {
	/* extends AbstractPOIExcelView
	@SuppressWarnings("unchecked")
	protected void buildExcelDocument(Map<String, Object> param, XSSFWorkbook wb, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		LinkedHashMap<String, Object> headerMap = (LinkedHashMap<String, Object>) param.get("header");
		List<HashMap<String, Object>> dataList = (List<HashMap<String, Object>>) param.get("data");
		String title = Util.NVL(param.get("title"));
		
		//브라우저가 IE인지 확인할 플래그
		boolean MSIE = req.getHeader("user-agent").toUpperCase().indexOf("MSIE") != -1;
		boolean MSIE11 = req.getHeader("user-agent").toUpperCase().indexOf("RV:11.0") != -1;
		String UTF8FileName = "";

		if (MSIE || MSIE11) {
		    // 공백이 '+'로 인코딩된것을 다시 공백으로 바꿔준다.
		    UTF8FileName = URLEncoder.encode(title, "UTF-8").replaceAll("\\+", " ");
		} else {
		    UTF8FileName = new String(title.getBytes("UTF-8"), "8859_1");
		}
		
		resp.setHeader("Content-Disposition", "attachment; filename=\"" + UTF8FileName + ".xlsx\"");

        XSSFSheet sheet = wb.createSheet(title);
        sheet.setDefaultColumnWidth(12);
        
        XSSFCellStyle headerCS = wb.createCellStyle();
        headerCS.setFillBackgroundColor(new XSSFColor(new Color(203, 208, 229)));
        headerCS.setFillForegroundColor(new XSSFColor(new Color(203, 208, 229)));
        headerCS.setFillPattern(CellStyle.SOLID_FOREGROUND);
        headerCS.setAlignment(HorizontalAlignment.CENTER);
        headerCS.setVerticalAlignment(VerticalAlignment.CENTER);
        
        XSSFCellStyle bodyCS = wb.createCellStyle();
        bodyCS.setVerticalAlignment(VerticalAlignment.CENTER);
        bodyCS.setAlignment(HorizontalAlignment.LEFT);
        
        XSSFRow row = sheet.createRow(0);
        XSSFCell cell = row.createCell(0);
        cell.setCellStyle(headerCS);
        cell.setCellValue("NO");
        sheet.setColumnWidth(0, 40 * 35);

        Iterator<Entry<String, Object>> iterator = headerMap.entrySet().iterator();
        int k = 1;
        while (iterator.hasNext()) {
        	cell = row.createCell(k);
    		cell.setCellStyle(headerCS);
			cell.setCellValue(Util.NVL(iterator.next().getValue()));
    		k++;
        }
        
    	int cnt = 1, dataSize = dataList.size();
    	for (int i=0; i<dataSize; i++) {
    		HashMap<String, Object> rowmap = dataList.get(i);
			row = sheet.createRow(i + 1);
			row.createCell(0).setCellValue(String.valueOf(i + 1));
			sheet.setColumnWidth(0, 40 * 35);
			cnt = 1;
			iterator = headerMap.entrySet().iterator();
			
			while (iterator.hasNext()) {
    	        sheet.setColumnWidth(cnt, 40 * 80);
    			cell = row.createCell(cnt);
    			cell.setCellStyle(bodyCS);
    			cell.setCellValue(Util.NVL(rowmap.get(iterator.next().getKey())));
    			cnt++;
			}
        }
    }*/
}