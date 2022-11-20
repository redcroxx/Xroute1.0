package xrt.lingoframework.common.biz;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Service
public class LoginBiz extends DefaultBiz {

    private static final Logger logger = LoggerFactory.getLogger(LoginBiz.class);

    // 로그인 체크
    public LoginVO getLogin(LDataMap paramMap) throws Exception {

        LoginVO loginVO = (LoginVO) dao.selectOne("LoginMapper.getLogin", paramMap);
        LDataMap logininfo = new LDataMap();

        // 아이디 유무 체크
        if ((LoginVO) dao.selectOne("LoginMapper.getLogin", paramMap) == null) {
            logininfo.put("REMARK", "존재하지 않는 아이디 입력");
            logininfo.put("STATUS", "F");
        }
        // 비밀번호 비교
        else if ("N".equals(loginVO.getPass())) {
            loginVO.setReturnCode("P");
            logininfo.put("REMARK", "비밀번호 입력 오류");
            logininfo.put("STATUS", "F");
        }
        // 비번 초기화 여부 확인
        else if ("Y".equals(loginVO.getInituseryn())) {
            loginVO.setReturnCode("I");
            logininfo.put("REMARK", "신규계정");
            logininfo.put("STATUS", "성공");
        }
        // 계정 잠김 여부 확인
        else if ("Y".equals(loginVO.getIslock())) {
            loginVO.setReturnCode("L");
            logininfo.put("REMARK", "잠긴 계정");
            logininfo.put("STATUS", "F");
        }
        // 최종 로그인 성공이후 90일 지났는지 확인
        else if ("Y".equals(loginVO.getLast3month())) {
            loginVO.setReturnCode("N");
            logininfo.put("REMARK", "최근 로그인 시간 90일 지남");
            logininfo.put("STATUS", "F");
        }
        // 비밀번호 90일 지났는지 확인
        else if ("Y".equals(loginVO.getPwdchgyn())) {
            loginVO.setReturnCode("O");
            logininfo.put("REMARK", "비밀번호 변경 후 90일 지남");
        } else {
            Integer paymentType = loginVO.getPaymentType() == null ? 0 : Integer.parseInt(loginVO.getPaymentType());
            int userGroup = Integer.parseInt(loginVO.getUsergroup());
            int centerUser = Integer.parseInt(CommonConst.CENTER_USER);
            if (userGroup < centerUser) {
                if (paymentType < 3) {
                    if (loginVO.getPassBookAuthYn().equals("N")) {
                        loginVO.setReturnCode("PT");
                        logininfo.put("STATUS", "PT");
                        logininfo.put("REMARK", "정기결제 변경");
                    } else {
                        dao.insert("LoginMapper.updateP002", paramMap);
                        logininfo.put("STATUS", "R");
                        logininfo.put("REMARK", "다시 로그인 시도");
                        loginVO.setReturnCode("R");
                    }
                } else if (paymentType == 3) {
                    if (loginVO.getPassBookAuthYn().equals("N")) {
                        loginVO.setReturnCode("PT");
                        logininfo.put("STATUS", "PT");
                        logininfo.put("REMARK", "정기결제 변경");
                    } else {
                        loginVO.setReturnCode("S"); // 로그인 성공
                        logininfo.put("STATUS", "S");
                    }
                } else {
                    loginVO.setReturnCode("S"); // 로그인 성공
                    logininfo.put("STATUS", "S");
                }
            } else {
                loginVO.setReturnCode("S"); // 로그인 성공
                logininfo.put("STATUS", "S");
            }
        }

        if (loginVO != null && !("O").equals(loginVO.getReturnCode())) {
            logininfo.put("HISTORYTYPE", "LOGIN");
            logininfo.put("COMPCD", loginVO.getCompcd());
            logininfo.put("USERCD", paramMap.getString("USERCD").toUpperCase());
            logininfo.put("USERIP", ClientInfo.getClntIP());
            logininfo.put("USERLOCALIP", ClientInfo.getClntLocalIP());
            logininfo.put("USEROS", ClientInfo.getClntOsInfo());
            logininfo.put("USERBROWSER", ClientInfo.getClntWebKind());
            logininfo.put("EMAIL", loginVO.getEmail());
            // 로그인이력 등록
            dao.insert("LoginMapper.insertLoginHistory", logininfo);
            // 최근 5회 로그인 실패내역
            List<LDataMap> loginFailInfo = dao.selectList("LoginMapper.getLoginFail", logininfo);
            int failCnt = 0;
            for (int i = 0; i < loginFailInfo.size(); i++) {
                if (("F").equals(loginFailInfo.get(i).get("STATUS").toString()))
                    failCnt = failCnt + 1;
                else
                    break;
            }
            // 5회 연속 실패시
            if (failCnt == 5) {
                dao.update("updateAccountLock", logininfo);
            }
            // 최근 로그인시간 90일 지났음. 계정 잠김처리
            if (("N").equals(loginVO.getReturnCode())) {
                dao.update("updateAccountLock", logininfo);
            }
            // 로그인 실패 횟수
            loginVO.setFailCnt(failCnt);
        }
        return loginVO;
    }

    /**
     * @author 양동근, 원키 우체국 API 임시 함수 오픈 후 삭제예정
     * @param param
     * @return
     * @throws Exception
     */
    public LoginVO getLogin2(LDataMap param) throws Exception {
        LoginVO loginVO = (LoginVO) dao.selectOne("LoginMapper.getLogin", param);
        loginVO.setReturnCode("S"); // 로그인 성공
        return loginVO;
    }

    // 그리드 정보 가져오기
    public List<LDataMap> getGridColInfoAll(LoginVO loginVO) throws Exception {
        return dao.select("LoginMapper.getGridColInfoAll", loginVO);
    }

    // 로그아웃 이력 등록
    public void setLogout() throws Exception {
        LDataMap logininfo = new LDataMap();
        logininfo.put("HISTORYTYPE", "LOGOUT");
        logininfo.put("COMPCD", LoginInfo.getCompcd());
        logininfo.put("USERCD", LoginInfo.getUsercd());
        logininfo.put("USERIP", ClientInfo.getClntIP());
        logininfo.put("USERLOCALIP", ClientInfo.getClntLocalIP());
        logininfo.put("USEROS", ClientInfo.getClntOsInfo());
        logininfo.put("USERBROWSER", ClientInfo.getClntWebKind());
        logininfo.put("STATUS", "S");

        // 로그아웃이력 등록
        dao.insert("LoginMapper.insertLoginHistory", logininfo);
    }
}
