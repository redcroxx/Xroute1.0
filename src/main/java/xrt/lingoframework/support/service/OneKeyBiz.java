package xrt.lingoframework.support.service;

import javax.annotation.Resource;

import xrt.lingoframework.support.dao.OneKeyDao;

public abstract class OneKeyBiz {

	@Resource(name = "OneKeyDao")
	protected OneKeyDao dao;

}
