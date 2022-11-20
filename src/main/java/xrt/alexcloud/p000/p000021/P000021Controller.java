package xrt.alexcloud.p000.p000021;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import xrt.lingoframework.common.biz.CommonBiz;
import xrt.lingoframework.common.vo.CodeVO;
import xrt.lingoframework.utils.LDataMap;
import xrt.lingoframework.utils.LReqData;
import xrt.lingoframework.utils.LRespData;
/**
 * 회사별 품목지정
 */
@Controller
@RequestMapping(value = "/alexcloud/p000/p000021")
public class P000021Controller {

	@Resource private CommonBiz commonBiz;
	@Resource private P000021Biz biz;

	//화면 호출
	@RequestMapping(value = "/view.do")
	public String view(ModelMap model) throws Exception {
		
		List<LDataMap> codeINVC = biz.getVariableCode("INVC_PRN_SEQ");		//송장출력순서
		List<LDataMap> codeLPROD = biz.getVariableCode("PROD_REG_YN");		//상품코드등록
		List<LDataMap> codeBARCODE = biz.getVariableCode("BARCODE_PRN_TYPE");	//바코드프린터종류
		List<LDataMap> codeTRAN = biz.getVariableCode("TRAN_PRINT_YN");		//거래명세서자동출력
		List<LDataMap> codePICKUP = biz.getVariableCode("PICKUP_ALLOC");		//픽업반편성 기준
		List<LDataMap> codeDAS = biz.getVariableCode("DAS_ALLOC_CNT");		//DAS슬롯수
		List<LDataMap> codeSERIALNUM = biz.getVariableCode("SERIAL_NO_NUM");	//시리얼번호총자릿수
		List<LDataMap> codeSERIALPROD = biz.getVariableCode("SERIAL_NO_PROD");//시리얼번호내제품자릿수
		List<LDataMap> codeMICHUL = biz.getVariableCode("MICHUL_PROC");		//미출처리기준
		
		List<CodeVO> gCodeINVC = variable(codeINVC);
		List<CodeVO> gCodeLPROD = variable(codeLPROD);
		List<CodeVO> gCodeBARCODE = variable(codeBARCODE);
		List<CodeVO> gCodeTRAN = variable(codeTRAN);
		List<CodeVO> gCodePICKUP = variable(codePICKUP);
		List<CodeVO> gCodeDAS = variable(codeDAS);
		List<CodeVO> gCodeSERIALNUM = variable(codeSERIALNUM);
		List<CodeVO> gCodeSERIALPROD = variable(codeSERIALPROD);
		List<CodeVO> gCodeMICHUL = variable(codeMICHUL);
		
		model.addAttribute("gCodeINVC", gCodeINVC);
		model.addAttribute("gCodeLPROD", gCodeLPROD);
		model.addAttribute("gCodeBARCODE", gCodeBARCODE);
		model.addAttribute("gCodeTRAN", gCodeTRAN);
		model.addAttribute("gCodePICKUP", gCodePICKUP);
		model.addAttribute("gCodeDAS", gCodeDAS);
		model.addAttribute("gCodeSERIALNUM", gCodeSERIALNUM);
		model.addAttribute("gCodeSERIALPROD", gCodeSERIALPROD);
		model.addAttribute("gCodeMICHUL", gCodeMICHUL);
		
		return "alexcloud/p000/p000021/P000021";
	}

	//검색
	@RequestMapping(value = "/getSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData getSearch(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		List<LDataMap> resultList = biz.getSearch(paramData);
		
		LDataMap resultData=new LDataMap();
		for(int i=0; i<resultList.size(); i++) {
			resultData.put(resultList.get(i).getString("ENV_CD"), resultList.get(i).getString("ENV_VAL"));
		}
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		return respData;
	}

	//저장
	@RequestMapping(value = "/setSave.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setSave(@RequestBody LReqData reqData) throws Exception {
		
		LDataMap paramData = reqData.getParamDataMap("paramData");
		
		List<LDataMap> paramList=new ArrayList<LDataMap>(); 
		LDataMap lm1= new LDataMap();
		LDataMap lm2= new LDataMap();
		LDataMap lm3= new LDataMap();
		LDataMap lm4= new LDataMap();
		LDataMap lm5= new LDataMap();
		LDataMap lm6= new LDataMap();
		LDataMap lm7= new LDataMap();
		LDataMap lm8= new LDataMap();
		
		lm1.put("ENV_CD", "SERIAL_NO_NUM");
		lm1.put("ENV_VAL", paramData.get("SERIAL_NO_NUM"));
		lm1.put("COMPCD", paramData.get("COMPCD"));
		lm1.put("ORGCD", paramData.get("S_ORGCD"));
		lm1.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm1.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm2.put("ENV_CD", "TRAN_PRINT_YN");
		lm2.put("ENV_VAL", paramData.get("TRAN_PRINT_YN"));
		lm2.put("COMPCD", paramData.get("COMPCD"));
		lm2.put("ORGCD", paramData.get("S_ORGCD"));
		lm2.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm2.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm3.put("ENV_CD", "MICHUL_PROC");
		lm3.put("ENV_VAL", paramData.get("MICHUL_PROC"));
		lm3.put("COMPCD", paramData.get("COMPCD"));
		lm3.put("ORGCD", paramData.get("S_ORGCD"));
		lm3.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm3.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm4.put("ENV_CD", "INVC_PRN_SEQ");
		lm4.put("ENV_VAL", paramData.get("INVC_PRN_SEQ"));
		lm4.put("COMPCD", paramData.get("COMPCD"));
		lm4.put("ORGCD", paramData.get("S_ORGCD"));
		lm4.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm4.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm5.put("ENV_CD", "PICKUP_ALLOC");
		lm5.put("ENV_VAL", paramData.get("PICKUP_ALLOC"));
		lm5.put("COMPCD", paramData.get("COMPCD"));
		lm5.put("ORGCD", paramData.get("S_ORGCD"));
		lm5.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm5.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm6.put("ENV_CD", "SERIAL_NO_PROD");
		lm6.put("ENV_VAL", paramData.get("SERIAL_NO_PROD"));
		lm6.put("COMPCD", paramData.get("COMPCD"));
		lm6.put("ORGCD", paramData.get("S_ORGCD"));
		lm6.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm6.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm7.put("ENV_CD", "DAS_ALLOC_CNT");
		lm7.put("ENV_VAL", paramData.get("DAS_ALLOC_CNT"));
		lm7.put("COMPCD", paramData.get("COMPCD"));
		lm7.put("ORGCD", paramData.get("S_ORGCD"));
		lm7.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm7.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		lm8.put("ENV_CD", "PROD_REG_YN");
		lm8.put("ENV_VAL", paramData.get("PROD_REG_YN"));
		lm8.put("COMPCD", paramData.get("COMPCD"));
		lm8.put("ORGCD", paramData.get("S_ORGCD"));
		lm8.put("LOGIN_USERCD", paramData.get("LOGIN_USERCD"));
		lm8.put("LOGIN_IP", paramData.get("LOGIN_IP"));
		
		paramList.add(lm1);
		paramList.add(lm2);
		paramList.add(lm3);
		paramList.add(lm4);
		paramList.add(lm5);
		paramList.add(lm6);
		paramList.add(lm7);
		paramList.add(lm8);
	
		LDataMap resultData = biz.setSave(paramList);
		LRespData respData = new LRespData();
		respData.put("resultData", resultData);
		
		return respData;
	}
	
	//삭제
	@RequestMapping(value = "/setDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public LRespData setDelete(@RequestBody LReqData reqData) throws Exception {
		LDataMap paramData = reqData.getParamDataMap("paramData");

		LDataMap resultData = biz.setDelete(paramData);

		LRespData respData = new LRespData();
		respData.put("resultData", resultData);

		return respData;
	}
	
	
	//변수설정 데이터 변환
	public List<CodeVO> variable(List<LDataMap> code){
		
		String vv=code.get(0).getString("ALLOW_VALS");
		
		String[] sa = vv.split("\\|");
		
		List<CodeVO> codes = new ArrayList<CodeVO>();
		
		for(int i=0;i<sa.length;i++) {
			CodeVO vo= new CodeVO();
			vo.setCode(sa[i]);
			vo.setValue(sa[i]);
			
			codes.add(vo);
		}
		
		return codes;
	}
}
