package xrt.lingoframework.support.service;

import javax.annotation.Resource;

import xrt.lingoframework.support.dao.DefaultDao;

public abstract class DefaultBiz {

	@Resource(name = "defaultDao")
	protected DefaultDao dao;

}
