package xrt.fulfillment.payment;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.alexcloud.common.vo.CommonSearchVo;
import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.exceptions.LingoException;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/fulfillment/payment/passBookList")
public class PassBookListController {

    Logger logger = LoggerFactory.getLogger(PassBookListController.class);

    private PassBookListBiz passBookListBiz;

    @Autowired
    public PassBookListController(CommonBiz commonBiz, PassBookListBiz passBookListBiz) {
        super();
        this.passBookListBiz = passBookListBiz;
    }

    // 화면 호출
    @RequestMapping(value = "/view.do")
    public String view(ModelMap model) throws Exception {

        LDataMap map = passBookListBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/payment/PassBookList";
    }

    // 검색
    @RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getSearch(@RequestBody CommonSearchVo paramVO) throws Exception {
        logger.info("CommonSearchVo : " + paramVO.toString());

        LRespData retMap = passBookListBiz.getSearch(paramVO);
        return retMap;
    }

    // 화면 호출
    @RequestMapping(value = "/regular/view.do")
    public String regularView(ModelMap model) throws Exception {

        LDataMap map = passBookListBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/payment/PassBookRegularList";
    }

    // 검색
    @RequestMapping(value = "/regular/getSearch.do", method = RequestMethod.POST)
    public @ResponseBody LRespData getRegularSearch(@RequestBody LDataMap paramMap) throws Exception {
        logger.info("paramMap {");
        paramMap.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");

        LRespData retMap = passBookListBiz.getRegularSearch(paramMap);
        return retMap;
    }

    // 검색
    @RequestMapping(value = "/setCancel.do", method = RequestMethod.POST)
    public @ResponseBody LRespData setCancel(@RequestBody LReqData reqData) throws Exception {
        logger.info("reqData {");
        reqData.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");
        List<LDataMap> dataList = reqData.getParamDataList("dataList");

        LRespData retMap = passBookListBiz.setCancel(dataList);
        return retMap;
    }

    // 화면 호출
    @RequestMapping(value = "/pop/view.do")
    public String popView(ModelMap model) throws Exception {

        LDataMap map = passBookListBiz.view();
        model.addAllAttributes(map);
        return "fulfillment/payment/PassBookPayPop";
    }

    // 검색
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/pop/setUpload.do", method = RequestMethod.POST)
    public @ResponseBody LRespData setUpload(@RequestBody LReqData reqData) throws LingoException {
        logger.info("reqData {");
        reqData.entrySet().forEach(entry -> {
            logger.info("    " + entry.getKey() + " : " + entry.getValue());
        });
        logger.info("}");
        List<LDataMap> dataList = reqData.getParamDataList("dataList");
        String type = reqData.getParamDataVal("type");
        LDataMap validMap = passBookListBiz.valid(dataList);
        List<LDataMap> reqList = (List<LDataMap>) validMap.get("data");
        if (reqList == null) {
            throw new LingoException("데이터가 없습니다.");
        }

        String code = validMap.getString("code");
        if (!code.equals("200")) {
            throw new LingoException("추가결제 파일 업로드시 \n 오류가 발생 하였습니다.");
        }

        LRespData retMap = passBookListBiz.setUpload(reqList, type);
        return retMap;
    }
}