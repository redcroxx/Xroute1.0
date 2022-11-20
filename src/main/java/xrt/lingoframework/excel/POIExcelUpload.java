package xrt.lingoframework.excel;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.Util;

public class POIExcelUpload {
	/**
	 * 엑셀 업로드 처리
	 * @param uploadfile : file폼 데이터
	 * @param header : 헤더명 배열
	 */
	public List<LDataMap> excelUpload(MultipartFile uploadfile, String[] header) throws Exception {
		return excelUpload(uploadfile, header, 0);
	}

	/**
	 * 엑셀 업로드 처리
	 * @param uploadfile : file폼 데이터
	 * @param header : 헤더명 배열
	 */
	public List<LDataMap> excelUpload(MultipartFile uploadfile, String[] header, int iStartRow) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String savepath = request.getSession().getServletContext().getRealPath("/");
		List<LDataMap> list = new ArrayList<LDataMap>();

		if (uploadfile == null) {
			return list;
		}

		//엑셀파일 업로드 처리
		String fileName = uploadfile.getOriginalFilename();

		if (fileName.substring(fileName.lastIndexOf("."), fileName.length()).equals(".xlsx")) {
			File file = new File(savepath + "upload\\" + fileName);

			if (!file.exists()) {
				file.mkdirs();
			}

			uploadfile.transferTo(file);

			OPCPackage opcp = OPCPackage.open(file);
			XSSFWorkbook workbook = new XSSFWorkbook(opcp);
			opcp.close();

			XSSFSheet sheet = workbook.getSheetAt(0);
			Iterator<Row> rowIte = sheet.iterator();
			int blankCnt = 0, rowidx = 0, colidx = 0;

			while (rowIte.hasNext()) {
				Row row = rowIte.next();
				Iterator<Cell> cellIte = row.cellIterator();
				LDataMap map = new LDataMap();
				blankCnt = 0;
				colidx = 0;

				if (rowidx >= iStartRow) {
					continue;
				}

				while (cellIte.hasNext()) {
					Cell cell = cellIte.next();
					String val = "";

					if (!Util.isEmpty(cell)) {
						switch (cell.getCellTypeEnum()) {
							case BLANK:
								val = "";
								break;
							case BOOLEAN:
								val = String.valueOf(cell.getBooleanCellValue());
								break;
							case STRING:
								val = cell.getStringCellValue().trim();
								break;
							case NUMERIC:
								val = isNumberOrDate(cell);
								break;
							case FORMULA:
								val = processFormula(workbook, cell);
								break;
							default:
								val = "";
					}

						map.put(header[colidx], val);
					} else {
						blankCnt++;
					}

					colidx++;
				}

				if (blankCnt == colidx) {
					continue;
				}

				list.add(map);
				rowidx++;
			}

			// 엑셀 파일 제거
			file.delete();
		}

		return list;
	}

	private String isNumberOrDate(Cell cell) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String retVal;

		if (DateUtil.isCellDateFormatted(cell)) {
			retVal = dateFormat.format(cell.getDateCellValue());
		} else {
			retVal = String.valueOf(cell.getNumericCellValue());
		}

		return retVal;
	}

	private String processFormula(XSSFWorkbook workbook, Cell cell) {
		//DataFormatter formatter = new DataFormatter();
		//FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String retVal = "";

		if (cell.getCachedFormulaResultTypeEnum() == CellType.ERROR) {
			retVal = "#VALUE!";
		} else {
			if (DateUtil.isCellDateFormatted(cell)) {
				retVal = dateFormat.format(cell.getDateCellValue());
			} else {
				retVal = String.valueOf(cell.getNumericCellValue());
			}
		}

		return retVal;
	}
}
