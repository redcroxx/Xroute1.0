package xrt.lingoframework.utils;

import java.util.ArrayList;
import java.util.List;

public class LDataList extends ArrayList<LDataMap> {

	private static final long serialVersionUID = 1L;

	public LDataList() {
		super();
	}

	public LDataList(List<LDataMap> list) {
		super(list);
	}

	@Override
	public LDataMap get(int index) {
		return new LDataMap(super.get(index));
	}
}