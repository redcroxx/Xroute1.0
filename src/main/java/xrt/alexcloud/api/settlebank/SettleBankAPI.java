package xrt.alexcloud.api.settlebank;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.security.MessageDigest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import xrt.alexcloud.api.settlebank.mapper.SettleBankMapper;
import xrt.alexcloud.api.settlebank.vo.SettleBankResNotiVO;
import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.LDataMap;

@Component
public class SettleBankAPI {

    Logger logger = LoggerFactory.getLogger(SettleBankAPI.class);

    private SettleBankMapper settleBankMapper;

    @Value("#{config['c.debugtype']}")
    private String debugtype;

    @Value("#{config['c.devPgAuthKey']}")
    private String devPgAuthKey;

    @Value("#{config['c.realPgAuthKey']}")
    private String realPgAuthKey;

    @Autowired
    public SettleBankAPI(SettleBankMapper settleBankMapper) {
        this.settleBankMapper = settleBankMapper;
    }

    /**
     * 세틀뱅에서 결과 값 또는 입금확인 응답받음.
     *
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LDataMap getSettleBankResult(SettleBankResNotiVO paramVO) throws Exception {
        LDataMap retMap = resSettleBanKData(paramVO);

        StringBuffer sbNoti = new StringBuffer();
        sbNoti.append(paramVO.getPStateCd());
        sbNoti.append(paramVO.getPTrno());
        sbNoti.append(paramVO.getPAuthDt());
        sbNoti.append(paramVO.getPType());
        sbNoti.append(paramVO.getPMid());
        sbNoti.append(paramVO.getPOid());
        sbNoti.append(paramVO.getPAmt());
        String sNoti = sbNoti.toString();

        return retMap;
    }

    /**
     * request 받은 데이터 처리
     *
     * @param paramVO
     * @return
     * @throws Exception
     */
    public LDataMap resSettleBanKData(SettleBankResNotiVO paramVO) throws Exception {
        // 이 페이지는 수정하지 마십시요. 수정시 html태그나 자바스크립트가 들어가는 경우 동작을 보장할 수 없습니다
        // hash데이타값이 맞는 지 확인 하는 루틴은 세틀뱅크에서 받은 데이타가 맞는지 확인하는 것이므로 꼭 사용하셔야 합니다
        // 정상적인 결제 건임에도 불구하고 노티 페이지의 오류나 네트웍 문제 등으로 인한 hash 값의 오류가 발생할 수도 있습니다.
        // 그러므로 hash 오류건에 대해서는 오류 발생시 원인을 파악하여 즉시 수정 및 대처해 주셔야 합니다.
        // 그리고 정상적으로 data를 처리한 경우에도 세틀뱅크에서 응답을 받지 못한 경우는 결제결과가 중복해서 나갈 수 있으므로
        // 관련한 처리도 고려되어야 합니다. (PTrno 가 PAuthDt의 일자(8자리)에 대해 unique 하니 PTrno로 체크
        // 해주세요)
        boolean resp = false;
        String pgAuthKey;
        String rsultData;

        // 세틀뱅크 noti server에서 받은 value
        // paramVo 대체

        // mid가 mid_test인 경우에 사용합니다
        // 해당 회원사 id당 하나의 auth_key가 발급됩니다
        // 발급받으신 auth_key를 설정하셔야 합니다
        // 테스트용 auth_key
        if (debugtype.equals("REAL")) {
            pgAuthKey = realPgAuthKey;
        } else {
            pgAuthKey = devPgAuthKey;
        }

        StringBuffer sbNoti = new StringBuffer();
        sbNoti.append(paramVO.getPStateCd());
        sbNoti.append(paramVO.getPTrno());
        sbNoti.append(paramVO.getPAuthDt());
        sbNoti.append(paramVO.getPType());
        sbNoti.append(paramVO.getPMid());
        sbNoti.append(paramVO.getPOid());
        sbNoti.append(paramVO.getPAmt());

        String sNoti = sbNoti.toString() + pgAuthKey;
        byte[] bNoti = sNoti.getBytes();

        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] digest = md.digest(bNoti);
        StringBuffer strBuf = new StringBuffer();
        for (int i = 0; i < digest.length; i++) {
            int c = digest[i] & 0xff;
            if (c <= 15)
                strBuf.append("0");
            strBuf.append(Integer.toHexString(c));
        }

        String HashedData = strBuf.toString();
        String[] noti = { paramVO.getPStateCd(), paramVO.getPTrno(), paramVO.getPAuthDt(), paramVO.getPType(), paramVO.getPMid(), paramVO.getPOid(), paramVO.getPFnCd1(), paramVO.getPFnCd2(),
                paramVO.getPFnNm(), paramVO.getPUname(), paramVO.getPAmt(), paramVO.getPNoti(), paramVO.getPRmesg1(), paramVO.getPRmesg2(), paramVO.getPAuthNo(), paramVO.getPHash(), HashedData };

        // 관련 db처리는 callback.asp의
        // noti_success(),noti_failure(),noti_hash_err()에서 관련 루틴을 추가하시면 됩니다
        // 각 함수 호출시 값은 배열로 전달되도록 되어 있으므로 처리시 주의하시기 바랍니다.
        // 위의 각 함수에는 현재 결제에 관한 log남기게 됩니다. 회원사서버에서 남기실 절대경로로 맞게 수정하여 주세요
        if (HashedData.trim().equals(paramVO.getPHash())) {
            if (paramVO.getPStateCd().trim().equals("0021"))
                resp = noti_success(noti, paramVO);
            else if (paramVO.getPStateCd().trim().equals("0031"))
                resp = noti_failure(noti, paramVO);
            else if (paramVO.getPStateCd().trim().equals("0051"))
                resp = noti_waiting_pay(noti, paramVO);
            else
                resp = false;
        } else {
            noti_hash_err(noti, paramVO);
        }

        // 세틀뱅크로 전송되어야 하는 값이므로 삭제하지 마세요.
        if (resp) {
            rsultData = "OK";
        } else {
            rsultData = "FALSE";
        }

        LDataMap retMap = new LDataMap();
        retMap.put("rsultData", rsultData);
        return retMap;
    }

    /**
     * 결제 완료 시 실행
     *
     * @param noti
     * @param paramVO
     * @return
     * @throws Exception
     */
    boolean noti_success(String noti[], SettleBankResNotiVO paramVO) throws Exception {
        // 결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
        String fileName = "noti_success.log";

        int count = settleBankMapper.getConfirmCount(paramVO);
        if (count == 0) {
            settleBankMapper.updateTPayment(paramVO);
            settleBankMapper.updateTPaymentDtl(paramVO);
            paramVO.setStatusCd("21");
            settleBankMapper.updateTOrder(paramVO);
            settleBankMapper.insertTStockHistory(paramVO);
            LDataMap dataMap = new LDataMap();
            dataMap.put("statusCd", CommonConst.ORD_STATUS_CD_PAYMENT_COMP);
            dataMap.put("statusNm", CommonConst.ORD_STATUS_NM_PAYMENT_COMP);
            dataMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_PAYMENT_COMP);
            dataMap.put("terminalcd", ClientInfo.getClntIP());
            dataMap.put("POid", paramVO.getPOid());
            settleBankMapper.insertTrackingHistory(dataMap);
            noti_write(CommonConst.SETTLE_BANK_LOG_PATH, fileName, noti);
        }
        return true;
    }

    /**
     * 결제 실패시 실행
     *
     * @param noti
     * @param paramVO
     * @return
     * @throws Exception
     */
    boolean noti_failure(String noti[], SettleBankResNotiVO paramVO) throws Exception {
        // 결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
        String fileName = "noti_failure.log";

        int count = settleBankMapper.getConfirmCount(paramVO);
        if (count == 0) {
            settleBankMapper.updateTPayment(paramVO);
            settleBankMapper.updateTPaymentDtl(paramVO);
            paramVO.setStatusCd("23");
            LDataMap dataMap = new LDataMap();
            dataMap.put("statusCd", CommonConst.ORD_STATUS_CD_PAYMENT_FAIL);
            dataMap.put("statusNm", CommonConst.ORD_STATUS_NM_PAYMENT_FAIL);
            dataMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_PAYMENT_FAIL);
            dataMap.put("terminalcd", ClientInfo.getClntIP());
            dataMap.put("POid", paramVO.getPOid());
            settleBankMapper.insertTrackingHistory(dataMap);
            noti_write(CommonConst.SETTLE_BANK_LOG_PATH, fileName, noti);
        }

        return true;
    }

    /**
     * 보낸 파라메터 와 받은 파라메터 암호화 후 비교해서 달랐을 때 발생
     *
     * @param noti
     * @param paramVO
     * @return
     * @throws Exception
     */
    boolean noti_hash_err(String noti[], SettleBankResNotiVO paramVO) throws Exception {
        // 결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
        String fileName = "noti_hash_err.log";

        int count = settleBankMapper.getConfirmCount(paramVO);
        if (count == 0) {
            settleBankMapper.updateTPayment(paramVO);
            settleBankMapper.updateTPaymentDtl(paramVO);
            noti_write(CommonConst.SETTLE_BANK_LOG_PATH, fileName, noti);
        }

        return true;
    }

    /**
     * 결제 대기시 실행
     *
     * @param noti
     * @param paramVO
     * @return
     * @throws Exception
     */
    boolean noti_waiting_pay(String noti[], SettleBankResNotiVO paramVO) throws Exception {
        // 결제에 관한 log남기게 됩니다. log path수정 및 db처리루틴이 추가하여 주십시요.
        String fileName = "noti_waiting_pay.log";

        int count = settleBankMapper.getConfirmCount(paramVO);
        if (count == 0) {
            settleBankMapper.insertTPayment(paramVO);
            settleBankMapper.insertTPaymentDtl(paramVO);
            settleBankMapper.deleteTCart(paramVO);
            settleBankMapper.deleteTCartDtl(paramVO);
            paramVO.setStatusCd("22");
            settleBankMapper.updateTOrder(paramVO);

            LDataMap dataMap = new LDataMap();
            dataMap.put("statusCd", CommonConst.ORD_STATUS_CD_PAYMENT_WAIT);
            dataMap.put("statusNm", CommonConst.ORD_STATUS_NM_PAYMENT_WAIT);
            dataMap.put("statusEnNm", CommonConst.ORD_STATUS_EN_NM_PAYMENT_WAIT);
            dataMap.put("terminalcd", ClientInfo.getClntIP());
            dataMap.put("POid", paramVO.getPOid());
            settleBankMapper.insertTrackingHistory(dataMap);
            noti_write(CommonConst.SETTLE_BANK_LOG_PATH, fileName, noti);
        }

        return true;
    }

    /**
     * 로그작성 메소드
     *
     * @param noti
     * @param paramVo
     * @return
     * @throws Exception
     */
    void noti_write(String filePath, String fileName, String noti[]) throws Exception {

        File dir = new File(filePath);

        if (!dir.isDirectory()) {
            dir.mkdir();
        }

        StringBuffer strBuf = new StringBuffer();
        strBuf.append("거래상태:" + noti[0] + "::");
        strBuf.append("거래번호:" + noti[1] + "::");
        strBuf.append("승인날짜:" + noti[2] + "::");
        strBuf.append("거래종류:" + noti[3] + "::");
        strBuf.append("회원사ID:" + noti[4] + "::");
        strBuf.append("주문번호:" + noti[5] + "::");
        strBuf.append("금융사코드:" + noti[6] + "::");
        strBuf.append("금융사코드:" + noti[7] + "::");
        strBuf.append("금융사명:" + noti[8] + "::");
        strBuf.append("주문자명:" + noti[9] + "::");
        strBuf.append("거래금액:" + noti[10] + "::");
        strBuf.append("주문정보:" + noti[11] + "::");
        strBuf.append("메세지1:" + noti[12] + "::");
        strBuf.append("메세지2:" + noti[13] + "::");
        strBuf.append("승인번호:" + noti[14] + "::");
        strBuf.append("P_HASH:" + noti[15] + "::");
        strBuf.append("HashedData:" + noti[16]);
        strBuf.append("\n");

        byte b[] = strBuf.toString().getBytes("EUC-KR");
        BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(filePath + fileName, true));
        stream.write(b);
        stream.close();
    }
}
