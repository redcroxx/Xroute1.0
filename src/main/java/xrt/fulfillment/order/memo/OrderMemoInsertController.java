package xrt.fulfillment.order.memo;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.utils.ClientInfo;
import xrt.lingoframework.utils.Constants;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LoginInfo;

@Controller
@RequestMapping(value = "/fulfillment/order/orderMemoInsert")
public class OrderMemoInsertController {

    private static Logger logger = LoggerFactory.getLogger(OrderMemoInsertController.class);

    private OrderMemoInsertBiz orderMemoInsertBiz;
    private OrderMemoListBiz orderMemoListBiz;

    @Autowired
    public OrderMemoInsertController(OrderMemoInsertBiz orderMemoInsertBiz, OrderMemoListBiz orderMemoListBiz) {
        super();
        this.orderMemoInsertBiz = orderMemoInsertBiz;
        this.orderMemoListBiz = orderMemoListBiz;
    }

    @RequestMapping(value = "/view.do", method = RequestMethod.POST)
    public String view(HttpServletRequest request, Model model) throws Exception {

        String sXrtInvcSno = request.getParameter("sXrtInvcSno");
        model.addAttribute("xrtInvcSno", sXrtInvcSno);
        model.addAttribute("usercd", LoginInfo.getUsercd());
        model.addAttribute("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        return "fulfillment/order/memoList/OrderMemoInsert";
    }

    @RequestMapping(value = "/insertMemo.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap insertMemo(OrderMemoMasterVo paramVO) throws Exception {
        String compcd = LoginInfo.getCompcd() == null ? CommonConst.XROUTE_COMPCD : LoginInfo.getCompcd();
        String orgcd = LoginInfo.getOrgcd() == null ? "9999" : LoginInfo.getOrgcd();
        String whcd = LoginInfo.getWhcd() == null ? "9999" : LoginInfo.getWhcd();

        int iUserGroup = Integer.parseInt(LoginInfo.getUsergroup());
        int iSellerAdmin = Integer.parseInt(CommonConst.SELLER_ADMIN);

        // userGroup??? SELLER_ADMIN???????????? ????????? ?????? ?????? ??????("total")?????? ??????.
        if (iUserGroup <= iSellerAdmin) {
            paramVO.setMemoAuthority("total");
        }

        if (paramVO.getMemoMultiFile() == null) {
            paramVO.setMemoFilePath("");
        } else if (paramVO.getMemoMultiFile().isEmpty()) {
            paramVO.setMemoFilePath("");
        } else {
            String uploadPath = Constants.MEMO_FILE_PATH;
            String originalFileName = paramVO.getMemoMultiFile().getOriginalFilename();
            String memoFilePath = uploadFile(uploadPath, originalFileName, paramVO.getMemoMultiFile().getBytes());
            paramVO.setMemoFilePath(memoFilePath);
        }

        paramVO.setCompcd(compcd);
        paramVO.setOrgcd(orgcd);
        paramVO.setWhcd(whcd);
        paramVO.setAddusercd(LoginInfo.getUsercd());
        paramVO.setUpdusercd(LoginInfo.getUsercd());
        paramVO.setTerminalcd(ClientInfo.getClntIP());

        orderMemoInsertBiz.insertMemo(paramVO);
        LDataMap map = new LDataMap();
        map.put("result", true);
        return map;
    }

    @RequestMapping(value = "/updateMemo.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateMemo(HttpServletRequest request, OrderMemoMasterVo paramVO) throws Exception {
        int iUserGroup = Integer.parseInt(LoginInfo.getUsergroup());
        int iSellerAdmin = Integer.parseInt(CommonConst.SELLER_ADMIN);

        // userGroup??? SELLER_ADMIN???????????? ????????? ?????? ?????? ??????("total")?????? ??????.
        if (iUserGroup <= iSellerAdmin) {
            paramVO.setMemoAuthority("total");
        }

        String xrtInvcSno = request.getParameter("xrtInvcSno");
        String orderMemoSeq = request.getParameter("orderMemoSeq");

        OrderMemoMasterVo masterVo = new OrderMemoMasterVo();
        masterVo.setOrderMemoSeq(orderMemoSeq);
        masterVo.setXrtInvcSno(xrtInvcSno);

        OrderMemoMasterVo orderMemoInfo = orderMemoListBiz.getSearchMemoInfo(masterVo);

        String uploadPath = Constants.MEMO_FILE_PATH; // ????????? ????????? ??????.
        String dbFilePath = orderMemoInfo.getMemoFilePath(); // DB?????? ????????? ?????? ?????? ?????????.
        
        if (paramVO.getMemoMultiFile() == null) {
            paramVO.setMemoFilePath(dbFilePath);
        } else {
            String originalFileName = paramVO.getMemoMultiFile().getOriginalFilename(); // ????????? ????????? ????????????.
            String memoFilePath = dbFilePath; // ????????? ????????? ?????????.
            // DB?????? ????????? ?????? ?????? ????????? ?????????,
            if (dbFilePath.equals("")) {
                if (originalFileName.equals(dbFilePath)) { // ???????????? DB??? ??????????????? ?????? ??????,
                    paramVO.setMemoFilePath(dbFilePath); // DB??? ????????????????????? ??????.
                } else { // ???????????? DB??? ?????? ????????? ?????? ??????.
                    memoFilePath = uploadFile(uploadPath, originalFileName, paramVO.getMemoMultiFile().getBytes()); // ??????????????????????????????????????? + ?????????????????????.
                    paramVO.setMemoFilePath(memoFilePath); // ???????????????+??????????????????.
                }
            } else { // DB?????? ????????? ?????? ?????? ????????? ????????????,
                String dbMemoFilePath = FilenameUtils.getBaseName(orderMemoInfo.getMemoFilePath()) + "." + FilenameUtils.getExtension(orderMemoInfo.getMemoFilePath());;
                if (originalFileName.contains(dbMemoFilePath)) {
                    paramVO.setMemoFilePath(dbFilePath);
                } else {
                    // ??? ?????? ??????????????? ????????? ?????? + ????????? ????????????.
                    memoFilePath = uploadFile(uploadPath, originalFileName, paramVO.getMemoMultiFile().getBytes()); 
                    paramVO.setMemoFilePath(memoFilePath); // ????????? ?????? + ???????????? ??????.
                }
            }
        }
        paramVO.setOrderMemoSeq(orderMemoInfo.getOrderMemoSeq()); // DB?????? ????????? ????????? ?????? ??????.
        paramVO.setXrtInvcSno(orderMemoInfo.getXrtInvcSno()); // DB?????? ????????? ????????? ?????? ??????.
        paramVO.setUpdusercd(LoginInfo.getUsercd()); // ????????? ?????? ????????? ?????? ????????? ?????? ?????? ???????????? ??????.
        paramVO.setTerminalcd(ClientInfo.getClntIP());

        orderMemoInsertBiz.updateMemo(paramVO);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("result", true);
        return map;
    }

    @RequestMapping(value = "/deleteMemo.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap deleteMemo(@RequestBody OrderMemoMasterVo paramVO) throws Exception {

        orderMemoInsertBiz.deleteMemo(paramVO);
        LDataMap map = new LDataMap();
        map.put("result", true);
        return map;
    }

    // ?????? ????????? ?????????.
    public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
        String savedName = originalName;
        String savedPath = calcPath(uploadPath);
        File target = new File(uploadPath + savedPath, savedName);
        FileCopyUtils.copy(fileData, target);
        String uploadedFileName = uploadPath + savedPath + File.separator + savedName;
        return uploadedFileName;
    }

    // ?????? ????????? ?????????.
    private static String calcPath(String uploadPath) {
        Calendar cal = Calendar.getInstance(); // ?????? ?????? ??????
        String yearPath = File.separator + cal.get(Calendar.YEAR); // \ + ??????
        String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
        String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
        makeDir(uploadPath, yearPath, monthPath, datePath);
        return datePath;
    }

    // ?????? ?????????.
    private static void makeDir(String uploadPath, String... paths) {
        if (new File(uploadPath + paths[paths.length - 1]).exists())
            return;
        for (String path : paths) {
            File dirPath = new File(uploadPath + path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }
        }
    }
}
