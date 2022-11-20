package xrt.fulfillment.atomy;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/fulfillment/atomy/livePacking")
public class AtomyLivePackingController {
    
    @RequestMapping(value = "/view.do")
    public String view(HttpServletRequest request, ModelMap model) throws Exception{
        String xrtInvcSno = request.getParameter("xrtInvcSno") != null? request.getParameter("xrtInvcSno").toString():"";
        String orgcd = request.getParameter("orgcd") != null? request.getParameter("orgcd").toString():"";

        model.addAttribute("xrtInvcSno", xrtInvcSno);
        model.addAttribute("orgcd", orgcd);

        return "fulfillment/atomy/AtomyLivePacking";
    }
}
