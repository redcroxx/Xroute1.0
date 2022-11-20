package xrt.lingoframework.support.service;

import javax.annotation.Resource;

import xrt.lingoframework.support.dao.NlfDao;

public abstract class NlfBiz {

	@Resource(name = "NlfDao")
	protected NlfDao dao;

}
