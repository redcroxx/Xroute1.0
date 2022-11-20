package xrt.alexcloud.common.utils;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

public class MailAuth extends Authenticator {

	Logger logger = LoggerFactory.getLogger(MailAuth.class);


	@Value("#{config['c.hiworksMailUserId']}")
	private String hiworksMailUserId;

	@Value("#{config['c.hiworksMailUserPassword']}")
	private String hiworksMailUserPassword;

	@Value("#{config['c.gmailMailUserId']}")
	private String gmailMailUserId;

	@Value("#{config['c.gmailMailUserPassword']}")
	private String gmailMailUserPassword;

	PasswordAuthentication pa;

	public MailAuth() {
		logger.debug("[MailAuth] Start!");
		pa = new PasswordAuthentication(hiworksMailUserId, hiworksMailUserPassword);
	}

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
