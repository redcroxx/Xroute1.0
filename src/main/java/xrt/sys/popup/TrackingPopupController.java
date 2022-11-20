package xrt.sys.popup;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import xrt.fulfillment.order.shippinglist.ShippingListBiz;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LRespData;

@Controller
@RequestMapping(value = "/sys/tracking/pop")
public class TrackingPopupController {
    
    private static final Logger logger = LoggerFactory.getLogger(TrackingPopupController.class);
    
    private ShippingListBiz shippingListBiz;
    
    @Autowired
    public TrackingPopupController(ShippingListBiz shippingListBiz) {
        this.shippingListBiz = shippingListBiz;
    }
    
    @RequestMapping(value = "/view.do", method = RequestMethod.GET)
    public String view(HttpServletRequest request, Model model)throws Exception{
        String invcSno = request.getParameter("invcSno");
        if (invcSno == null) {
            invcSno = "";
        }
        model.addAttribute("invcSno", invcSno);
        return "/sys/popup/TrackingPopup";
    }
    
    @RequestMapping(value = "/getOrderSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LRespData getOrderSearch(@RequestBody LDataMap param) throws Exception {
        LDataMap paramMap = shippingListBiz.getOrderSearch(param);
        LRespData resData = shippingListBiz.setTrackingHistory(paramMap);
        return resData;
    }
    
    @RequestMapping(value = "/getProductSearch.do", method = RequestMethod.POST)
    @ResponseBody
    public LDataMap getProductSearch(@RequestBody LDataMap param) throws Exception{
        LDataMap result = shippingListBiz.getOrderSearch(param);
        return result;
    }
}
