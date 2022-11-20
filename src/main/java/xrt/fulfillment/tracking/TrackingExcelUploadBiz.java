package xrt.fulfillment.tracking;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class TrackingExcelUploadBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(TrackingExcelUploadBiz.class);

	public LDataMap process(List<StockHistoryVo> paramList) throws Exception {
		logger.debug("paramList : "+ paramList.toString());

		LDataMap validMap = this.valid(paramList);
		List<StockHistoryVo> stockHistoryList = (List<StockHistoryVo>) validMap.get("data");

		for (StockHistoryVo stockHistoryVo : stockHistoryList) {
			dao.insert("TrackingExcelUploadMapper.insertTStockHistory", stockHistoryVo);
		}

		LDataMap lDataMap = new LDataMap();
		return lDataMap;
	}

	public LDataMap valid(List<StockHistoryVo> paramList) throws Exception {

		String statusCd = "10,30,40,50,60,80";
		List<String> statusList = new ArrayList<String>(Arrays.asList(statusCd.split(",")));
		List<String> countryList = dao.selectList("TrackingExcelUploadMapper.getCountryList", new HashMap<>());
		List<StockHistoryVo> resList = new ArrayList<StockHistoryVo>();

		for (StockHistoryVo stockHistoryVo : paramList) {
			Object ordCd = dao.selectOne("TrackingExcelUploadMapper.getXrtInvcSno", stockHistoryVo);

			if (stockHistoryVo.getInvcSno() == null) {
				throw new LingoException("데이터가 없습니다.");
			} else if (stockHistoryVo.getInvcSno().equals("")) {
				throw new LingoException("데이터가 없습니다.");
			} else if (ordCd.toString().equals("")) {
				throw new LingoException("등록되지 않은 오더입니다.");
			} else if (!ordCd.toString().equals("")) {
				stockHistoryVo.setOrdCd(ordCd.toString());
			}

			if (stockHistoryVo.getAdddatetime() == null) {
				throw new LingoException("데이터가 없습니다.");
			} else if (stockHistoryVo.getAdddatetime().equals("")) {
				throw new LingoException("데이터가 없습니다.");
			} else if (!validDateType(stockHistoryVo.getAdddatetime())) {
				throw new LingoException("형식이 틀립니다 (예: 2020-01-01 00:00:00)");
			}

			if (stockHistoryVo.getStatusCd() == null) {
				throw new LingoException("데이터가 없습니다.");
			} else if (stockHistoryVo.getStatusCd().equals("")) {
				throw new LingoException("데이터가 없습니다.");
			} else if (!statusList.contains(stockHistoryVo.getStatusCd())) {
				throw new LingoException("tag값이 잘못 되었습니다.");
			}

			if (stockHistoryVo.getNation() == null) {
				throw new LingoException("데이터가 없습니다.");
			} else if (stockHistoryVo.getNation().equals("")) {
				throw new LingoException("데이터가 없습니다.");
			} else if (!countryList.contains(stockHistoryVo.getNation())) {
				throw new LingoException("tag값이 잘못 되었습니다.");
			}

			resList.add(stockHistoryVo);
		}

		LDataMap lDataMap = new LDataMap();
		lDataMap.put("data", resList);
		return lDataMap;
	}

	public Boolean validDateType(String dateString) {
		logger.debug("dateString : "+ dateString);

		Boolean bRetVal = false;

		String yyyyMMdd = dateString.split(" ")[0];
		String time = dateString.split(" ")[1];

		logger.debug("yyyyMMdd : "+ yyyyMMdd);
		if (yyyyMMdd == null) {
			return bRetVal;
		} else if (yyyyMMdd.equals("")) {
			return bRetVal;
		}

		logger.debug("time : "+ time);
		if (time == null) {
			return bRetVal;
		} else if (time.equals("")) {
			return bRetVal;
		}

		String yyyy = yyyyMMdd.split("-")[0];
		int mm = Integer.parseInt(yyyyMMdd.split("-")[1]);
		int dd = Integer.parseInt(yyyyMMdd.split("-")[2]);
		int hour = Integer.parseInt(time.split(":")[0]);
		int min = Integer.parseInt(time.split(":")[1]);
		int sec = Integer.parseInt(time.split(":")[2]);

		if (yyyy.length() != 4) {
			return bRetVal;
		}

		if (mm < 1 && mm > 12) {
			return bRetVal;
		} else if (mm == 2) {
			if (dd > 29) {
				return bRetVal;
			}
		}

		if (dd > 31) {
			return bRetVal;
		}

		if (hour > 24) {
			return bRetVal;
		}

		if (min > 59) {
			return bRetVal;
		}

		if (sec > 59) {
			return bRetVal;
		}

		bRetVal = true;

		return bRetVal;
	}
}
