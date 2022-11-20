package xrt.fulfillment.order.memo;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.alexcloud.common.CommonConst;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.LoginVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;
import xrt.lingoframework.utils.LoginInfo;

/**
 * 메모 목록 Controller
 */
@Controller
@RequestMapping(value = "/fulfillment/order/orderMemoList")
public class OrderMemoListController {

    private static final Logger logger = LoggerFactory.getLogger(OrderMemoListController.class);

    private OrderMemoListBiz orderMemoListBiz;

    @Autowired
    public OrderMemoListController(CommonBiz commonBiz, OrderMemoListBiz orderMemoListBiz) {
        super();
        this.orderMemoListBiz = orderMemoListBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        Map<String, Object> constMap = new HashMap<String, Object>();
        constMap.put("XROUTE_CD", CommonConst.XROUTE_COMPCD);
        constMap.put("XROUTE_ADMIN", CommonConst.XROUTE_ADMIN);
        constMap.put("CENTER_ADMIN", CommonConst.CENTER_ADMIN);
        constMap.put("CENTER_SUPER", CommonConst.CENTER_SUPER_USER);
        constMap.put("CENTER_USER", CommonConst.CENTER_USER);
        constMap.put("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        constMap.put("SELLER_SUPER", CommonConst.SELLER_SUPER_USER);
        constMap.put("SELLER_USER", CommonConst.SELLER_USER);

        return "fulfillment/order/memoList/OrderMemoList";
    }

    // 검색.
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody LDataMap paramVo) throws Exception {
        List<OrderMemoMasterVo> orderMemoList = orderMemoListBiz.getSearch(paramVo);
        LRespData retMap = new LRespData();
        retMap.put("resultList", orderMemoList);
        return retMap;
    }

    // 상세보기 팝업.
    @RequestMapping(value = "/infoView.do", method = RequestMethod.GET)
    public String infoView(HttpServletRequest request, Model model) throws Exception {
        String xrtInvcSno = request.getParameter("xrtInvcSno");
        String orderMemoSeq = request.getParameter("orderMemoSeq");

        OrderMemoMasterVo masterVo = new OrderMemoMasterVo();
        masterVo.setOrderMemoSeq(orderMemoSeq);
        masterVo.setXrtInvcSno(xrtInvcSno);

        OrderMemoMasterVo orderMemoInfo = orderMemoListBiz.getSearchMemoInfo(masterVo);
        model.addAttribute("orderMemoSeq", orderMemoSeq);
        model.addAttribute("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        String memoFilePath = "";
        
        String memoMultiFile = orderMemoInfo.getMemoFilePath();
        if (memoFilePath == null || memoMultiFile.equals("")) {
            memoFilePath = "첨부파일이 존재하지 않습니다.";
        } else {
            memoFilePath = FilenameUtils.getBaseName(memoMultiFile) + "." + FilenameUtils.getExtension(memoMultiFile);
        }
        if (orderMemoInfo.getMemoAuthority().equals("total")) {
            model.addAttribute("memoAuthority", "전체");
        }
        if (orderMemoInfo.getMemoAuthority().equals("admin")) {
            model.addAttribute("memoAuthority", "관리자");
        }
        if (orderMemoInfo.getMemoType().equals("shipping")) {
            model.addAttribute("memoType", "배송관련문의");
        }
        if (orderMemoInfo.getMemoType().equals("payment")) {
            model.addAttribute("memoType", "결제관련문의");
        }
        if (orderMemoInfo.getMemoType().equals("others")) {
            model.addAttribute("memoType", "기타문의");
        }
        model.addAttribute("xrtInvcSno", orderMemoInfo.getXrtInvcSno());
        model.addAttribute("addusercd", orderMemoInfo.getAddusercd());
        model.addAttribute("adddatetime", orderMemoInfo.getAdddatetime());
        model.addAttribute("contents", orderMemoInfo.getContents());
        model.addAttribute("memoFilePath", memoFilePath);
        model.addAttribute("memoMultiFile", memoMultiFile);

        return "fulfillment/order/memoList/OrderMemoListInfo";
    }

    @RequestMapping(value = "/updateView.do", method = RequestMethod.POST)
    public String updateView(HttpServletRequest request, Model model) throws Exception {
        String xrtInvcSno = request.getParameter("xrtInvcSno");
        String orderMemoSeq = request.getParameter("orderMemoSeq");

        OrderMemoMasterVo masterVo = new OrderMemoMasterVo();
        masterVo.setOrderMemoSeq(orderMemoSeq);
        masterVo.setXrtInvcSno(xrtInvcSno);

        OrderMemoMasterVo orderMemoInfo = orderMemoListBiz.getSearchMemoInfo(masterVo);
        
        String memoFilePath = "";
        String memoMultiFile = orderMemoInfo.getMemoFilePath();
        if (memoMultiFile.equals("")) {
            memoFilePath = "첨부파일이 존재하지 않습니다.";
        } else {
            memoFilePath = FilenameUtils.getBaseName(memoMultiFile) + "." + FilenameUtils.getExtension(memoMultiFile);
        }
        model.addAttribute("xrtInvcSno", xrtInvcSno);
        model.addAttribute("orderMemoSeq", orderMemoSeq);
        model.addAttribute("memoFilePath", memoFilePath);
        model.addAttribute("memoAuthority", orderMemoInfo.getMemoAuthority());
        model.addAttribute("memoType", orderMemoInfo.getMemoType());
        model.addAttribute("addusercd", orderMemoInfo.getAddusercd());
        model.addAttribute("adddatetime", orderMemoInfo.getAdddatetime());
        model.addAttribute("contents", orderMemoInfo.getContents());
        model.addAttribute("memoMultiFile", memoMultiFile);
        model.addAttribute("SELLER_ADMIN", CommonConst.SELLER_ADMIN);
        return "fulfillment/order/memoList/OrderMemoUpdate";
    }

    @RequestMapping(value = "/updateMemoStatus.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap updateMemoStatus(@RequestBody OrderMemoMasterVo orderMemoMasterVo) throws Exception {
        orderMemoListBiz.updateMemoStatus(orderMemoMasterVo);
        LDataMap map = new LDataMap();
        map.put("result", true);
        return map;
    }

    @RequestMapping(value = "/fileDownload.do")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response, OrderMemoMasterVo memoMasterVo, Model model) throws Exception {

        OrderMemoMasterVo orderMemoMasterVo = orderMemoListBiz.getSearchFilePath(memoMasterVo);
        String memoMultiFile = orderMemoMasterVo.getMemoFilePath();
        String memoFilePath = FilenameUtils.getBaseName(memoMultiFile) + "." + FilenameUtils.getExtension(memoMultiFile);

        model.addAttribute("memoFilePath", memoFilePath);
        
        // 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환.
        byte fileByte[] = FileUtils.readFileToByteArray(new File(memoMultiFile));
        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(memoFilePath, "UTF-8") + "\";");
        response.getOutputStream().write(fileByte);
        response.getOutputStream().flush();
        response.getOutputStream().close();
    }
    
    // 메모 답글 등록.
    @RequestMapping(value = "/insertReply.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> insertReply(HttpServletRequest request, @RequestBody OrderMemoReplyVo param) throws Exception{
        HttpSession session = request.getSession();
        LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
        String clientIp = request.getHeader("X-FORWARDED-FOR");
        String compcd = loginVo.getCompcd() == null ? "1000":loginVo.getCompcd();
        String orgcd = loginVo.getOrgcd() == null ? "9999":loginVo.getOrgcd();
        String whcd = loginVo.getWhcd() == null ? "9999":loginVo.getWhcd();
        if ( clientIp == null ) {
            clientIp = request.getRemoteAddr();
        }
        param.setCompcd(compcd);
        param.setOrgcd(orgcd);
        param.setWhcd(whcd);
        param.setAddusercd(loginVo.getUsercd());
        param.setUpdusercd(loginVo.getUsercd());
        param.setTerminalcd(clientIp);

        orderMemoListBiz.insertReply(param);
        LRespData retMap = new LRespData();
        retMap.put("code", "200");
        return retMap;
    }
    
    // 메모 답글 목록.
    @RequestMapping(value = "/getReplyList.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> getReplyList(HttpServletRequest request, @RequestBody LDataMap param)throws Exception{
        HttpSession session = request.getSession();
        LoginVO loginVo = (LoginVO) session.getAttribute("loginVO");
        String clientIp = request.getHeader("X-FORWARDED-FOR");
        if ( clientIp == null ) {
            clientIp = request.getRemoteAddr();
        }
        param.put("orgcd", loginVo.getOrgcd());

        List<OrderMemoReplyVo> replyList = orderMemoListBiz.getReplyList(param);
        LRespData retMap = new LRespData();
        retMap.put("resultList", replyList);
        retMap.put("userGroup", Integer.parseInt(LoginInfo.getUsergroup()));
        retMap.put("sellerAdmin", Integer.parseInt(CommonConst.SELLER_ADMIN));
        return retMap;
    }
}