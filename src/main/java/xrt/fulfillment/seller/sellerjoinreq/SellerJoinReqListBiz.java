package xrt.fulfillment.seller.sellerjoinreq;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.utils.SendMail;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class SellerJoinReqListBiz extends DefaultBiz {

	@Autowired
	SendMail sendMail;

	// 검색
	public List<LDataMap> getSearch(LDataMap param) throws Exception {
		return dao.select("SellerJoinReqListMapper.getSearch", param);
	}

	// 저장
	public LDataMap setSave(List<LDataMap> paramList) throws Exception {

		// 마스터 신규 저장 처리
		for (int i = 0; i < paramList.size(); i++) {
			LDataMap map = paramList.get(i);
			map.put("LOGIN_USERCD", LoginInfo.getUsercd());
			map.put("LOGIN_IP", ClientInfo.getClntIP());

			if ("I".equals(map.getString("IDU"))) {
				int orgcdChk = (int) dao.selectOne("SellerJoinReqListMapper.orgcdChk", map);
				int compcdChk = (int) dao.selectOne("P000001Mapper.getCompChk", map);
				if (orgcdChk == 1) {
					throw new LingoException("사용 중인 셀러코드[" + map.getString("ORGCD") + "]가 존재합니다.");
				}
				if (compcdChk == 0) {
					throw new LingoException("회사코드[" + map.getString("COMPCD") + "]가 존재하지 않습니다.");
				}
				dao.insert("SellerJoinReqListMapper.insertMst", map);

			} else if ("U".equals(map.getString("IDU"))) {
				dao.update("SellerJoinReqListMapper.updateMst", map);
			}
		}
		LDataMap resultmap = new LDataMap(paramList.get(0));

		return resultmap;
	}

	// 승인
	public LDataMap setApproval(LDataMap paramMap) throws Exception {

		// 마스터 신규 저장 처리
		LDataMap map = paramMap;
		map.put("LOGIN_USERCD", LoginInfo.getUsercd());
		map.put("LOGIN_IP", ClientInfo.getClntIP());

		// 창고, 로케이션, 메뉴 등록
		String strWhcd = (String) dao.selectOne("SellerJoinReqListMapper.getWhcd", map);
		map.put("WHCD", strWhcd);
		dao.insert("SellerJoinReqListMapper.insertCago", map);

		dao.update("SellerJoinReqListMapper.setApproval_P002", map);
		dao.update("SellerJoinReqListMapper.setApproval_P003", map);
		dao.update("SellerJoinReqListMapper.setApproval_S010", map);

		List<LDataMap> whcdInfolist = new ArrayList<LDataMap>();
		LDataMap whcdInfo = new LDataMap();
		whcdInfo.put("LOCCD", "STAGE");
		whcdInfo.put("LOCNAME", "입고존");
		whcdInfo.put("LOCGROUP", "A");
		whcdInfo.put("LOCTYPE", "6");
		whcdInfolist.add(whcdInfo);

		whcdInfo = new LDataMap();
		whcdInfo.put("LOCCD", "RACK");
		whcdInfo.put("LOCNAME", "보관존");
		whcdInfo.put("LOCGROUP", "C");
		whcdInfo.put("LOCTYPE", "1");
		whcdInfolist.add(whcdInfo);

		whcdInfo = new LDataMap();
		whcdInfo.put("LOCCD", "CART");
		whcdInfo.put("LOCNAME", "출고존");
		whcdInfo.put("LOCGROUP", "B");
		whcdInfo.put("LOCTYPE", "5");
		whcdInfolist.add(whcdInfo);

		for (int i = 0; i < whcdInfolist.size(); i++) {
			map.put("LOCCD", whcdInfolist.get(i).get("LOCCD").toString());
			map.put("LOCNAME", whcdInfolist.get(i).get("LOCNAME").toString());
			map.put("LOCGROUP", whcdInfolist.get(i).get("LOCGROUP").toString());
			map.put("LOCTYPE", whcdInfolist.get(i).get("LOCTYPE").toString());

			// 로케이션 등록
			dao.insert("SellerJoinReqListMapper.insertLocation", map);
		}

		List<LDataMap> menuList = new ArrayList<LDataMap>();

		// 셀러
		LDataMap menu = new LDataMap();
		menu.put("MENUL1KEY", "80");
		menu.put("MENUL2KEY", "20");
		menu.put("APPKEY", "P000002");
		menuList.add(menu);
		
		// 오더리스트
        menu = new LDataMap();
        menu.put("MENUL1KEY", "30");
        menu.put("MENUL2KEY", "100");
        menu.put("APPKEY", "OrderList");
        menuList.add(menu);

		// 주문결제리스트
		menu = new LDataMap();
		menu.put("MENUL1KEY", "70");
		menu.put("MENUL2KEY", "10");
		menu.put("APPKEY", "PaymentList");
		menuList.add(menu);

		//주문내역조회
		menu = new LDataMap();
		menu.put("MENUL1KEY", "70");
		menu.put("MENUL2KEY", "10");
		menu.put("APPKEY", "PaymentContentsList");
		menuList.add(menu);
        
		// 주문배송조회
        menu = new LDataMap();
        menu.put("MENUL1KEY", "7");
        menu.put("MENUL2KEY", "10");
        menu.put("APPKEY", "ShippingList");
        menuList.add(menu);
        
        // 정기 결제 목록.
        menu = new LDataMap();
        menu.put("MENUL1KEY", "70");
        menu.put("MENUL2KEY", "20");
        menu.put("APPKEY", "PassBookList");
        menuList.add(menu);
        
       /* // 정산내역
        menu = new LDataMap();
        menu.put("MENUL1KEY", "60");
        menu.put("MENUL2KEY", "10");
        menu.put("APPKEY", "SettlemetList");
        menuList.add(menu);*/
		
        /*// 해외 배송 소포 수령증
        menu.put("MENUL1KEY", "60");
        menu.put("MENUL2KEY", "10");
        menu.put("APPKEY", "ParceIproof");
        menuList.add(menu);*/
        
		for (int i = 0; i < menuList.size(); i++) {
			map.put("MENUL1KEY", menuList.get(i).get("MENUL1KEY").toString());
			map.put("MENUL2KEY", menuList.get(i).get("MENUL2KEY").toString());
			map.put("APPKEY", menuList.get(i).get("APPKEY").toString());

			// 메뉴 등록
			dao.insert("SellerJoinReqListMapper.insertMenu", map);
		}

		sendMail.sendApproval(paramMap);

		LDataMap resultmap = new LDataMap(paramMap);

		return resultmap;
	}
}
