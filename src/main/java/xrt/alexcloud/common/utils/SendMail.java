package xrt.alexcloud.common.utils;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class SendMail {

	Logger logger = LoggerFactory.getLogger(SendMail.class);

	@Value("#{config['c.gmailMailUserId']}")
	private String gmailMailUserId;

	@Value("#{config['c.hiworksMailUserId']}")
	private String hiworksMailUserId;

	@Value("#{config['c.hiworksMailServer']}")
	private String hiworksMailServer;

	@Value("#{config['c.hiworksMailPort']}")
	private String hiworksMailPort;

	@Value("#{config['c.gmailMailServer']}")
	private String gmailMailServer;

	@Value("#{config['c.gmailMailPort']}")
	private String gmailMailPort;

	public Properties setMailServer() {
		logger.debug("[setMailServer] start!");

		Properties properties = new Properties();

		/* gmail smtp 정보
		properties.put("mail.smtp.starttls.enable", "true");	// gmail은 무조건 true 고정
		properties.put("mail.smtp.host", gmailMailServer);		// smtp 서버 주소
		properties.put("mail.smtp.auth","true");				// gmail은 무조건 true 고정
		properties.put("mail.smtp.port", gmailMailPort);				// gmail 포트
		 */

		/* hiworks */
		properties.put("mail.smtp.ssl.enable", "true");	// hiworks은 무조건 true 고정
		properties.put("mail.smtp.host", hiworksMailServer);	// hiworks 서버 주소
		properties.put("mail.smtp.auth","false");				// hiworks은 무조건 false 고정 (TLS 인증관련)
		properties.put("mail.smtp.port", hiworksMailPort);				// hiworks 포트

		return properties;
	}

	public Map<String, Object> sendPaymentWating(Map<String, Object> paramMap) {

		Authenticator auth = new MailAuth();
		Properties porps = this.setMailServer();
		Session session = Session.getDefaultInstance(porps, auth);
		MimeMessage msg = new MimeMessage(session);

		String xrtInvcSno = paramMap.get("xrtInvcSno").toString();
		String goodsNm = paramMap.get("goodsNm").toString();
		String xrtShippingPrice = paramMap.get("xrtShippingPrice").toString();
		String toEmail = paramMap.get("email").toString();


		try {

			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress(hiworksMailUserId));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("Xroute 입금 확인", "UTF-8");

			String content = "<html>";
			content += "<body>";
			content += "<div> <b>Xroute 입금 확인</b><br><br></div>";
			content += "<div> xroute 송장번호 : " + xrtInvcSno +"</div>";
			content += "<div> 상품명 : " + goodsNm +"</div>";
			content += "<div> 금액 : " + xrtShippingPrice +"<br><br></div>";
			content += "<div> 오더관리 > 주문결제리스트 메뉴에서 해당 건들을 확인할 수 있습니다.</div>";
			content += "<div> 해당메뉴에서 결제를 하시면 입고처리가 진행됩니다.</div>";
			content += "<di> xroute@logifocus.co.kr 메일로는 회신이 안됩니다.</div>";
			content += "<div> 문의 사항은 010-4800-9121로 연락주시길 바랍니다.</div>";
			content += "</body>";
			content += "</html>";

			msg.setContent(content, "text/html;charset=UTF-8");

			logger.debug("msg : "+ msg.toString());

			Transport.send(msg);

		} catch(Exception e) {
			logger.error("Exception : " + e.fillInStackTrace());
		}


		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}


	public Map<String, Object> sendCompleteInbound(Map<String, Object> paramMap) {

		Authenticator auth = new MailAuth();
		Properties porps = this.setMailServer();
		Session session = Session.getDefaultInstance(porps, auth);
		MimeMessage msg = new MimeMessage(session);

		String xrtInvcSno = paramMap.get("xrtInvcSno").toString();
		String toEmail = paramMap.get("email").toString();


		try {

			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress(hiworksMailUserId));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("Xroute 입금 확인", "UTF-8");

			String content = "<html>";
			content += "<body>";
			content += "<div> xroute 송장번호 : " + xrtInvcSno +"의 입고처리가 완료되었습니다.</div>";
			content += "</body>";
			content += "</html>";

			msg.setContent(content, "text/html;charset=UTF-8");

			logger.debug("msg : "+ msg.toString());

			Transport.send(msg);

		} catch(Exception e) {
			logger.error("Exception : " + e.fillInStackTrace());
		}


		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}

	public Map<String, Object> sendApproval(Map<String, Object> paramMap) {

		Authenticator auth = new MailAuth();
		Properties porps = this.setMailServer();
		Session session = Session.getDefaultInstance(porps, auth);
		MimeMessage msg = new MimeMessage(session);

		String toEmail = paramMap.get("email").toString();

		try {

			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress(hiworksMailUserId));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("Xroute 회원가입 승인완료.", "UTF-8");

			String content = "<html>";
			content += "<body>";
			content += "<div> Xroute 회원가입이 승인되었습니다.</div>";
			content += "</body>";
			content += "</html>";
			msg.setContent(content, "text/html;charset=UTF-8");

			Transport.send(msg);

		} catch(Exception e) {
			logger.error("Exception : " + e.fillInStackTrace());
		}

		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("code", "200");
		retMap.put("message", "정상적으로 처리되었습니다.");
		return retMap;
	}
}
