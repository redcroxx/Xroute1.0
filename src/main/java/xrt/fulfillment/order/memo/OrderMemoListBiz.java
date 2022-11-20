package xrt.fulfillment.order.memo;

import java.util.List;

import org.springframework.stereotype.Service;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class OrderMemoListBiz extends DefaultBiz {

    // 메모 목록에서 조회.
    public List<OrderMemoMasterVo> getSearch(LDataMap param) throws Exception {
        return dao.selectList("OrderMemoMapper.getSearchList", param);
    }

    // 메모 정보 팝업 조회.
    public OrderMemoMasterVo getSearchMemoInfo(OrderMemoMasterVo masterVo) throws Exception {
        return (OrderMemoMasterVo) dao.selectOne("OrderMemoMapper.getSearchMemoInfo", masterVo);
    }

    // 메모 처리 상태 변경.
    public void updateMemoStatus(OrderMemoMasterVo orderMemoMasterVo) throws Exception{
        dao.update("OrderMemoMapper.updateMemoStatus", orderMemoMasterVo);
    }

    // 파일경로 가져오기.
    public OrderMemoMasterVo getSearchFilePath(OrderMemoMasterVo memoMasterVo) throws Exception{
        return (OrderMemoMasterVo) dao.selectOne("OrderMemoMapper.getSearchFilePath", memoMasterVo);
    }

    // 답글 등록.
    public void insertReply(OrderMemoReplyVo param) throws Exception{
        int number = (Integer) dao.selectOne("OrderMemoMapper.getNumber", param);
        param.setNumber(number + 1);
        dao.insert("OrderMemoMapper.insertReply", param);
    }

    // 답글 목록.
    public List<OrderMemoReplyVo> getReplyList(LDataMap param) throws Exception {
        return dao.selectList("OrderMemoMapper.getMemoReplyList", param);
    }
}
