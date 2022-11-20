
package xrt.sys.popup;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;

import xrt.lingoframework.support.service.DefaultBiz;
import xrt.lingoframework.utils.LDataMap;

@Service
public class LivePackingBiz extends DefaultBiz {

	Logger logger = LoggerFactory.getLogger(LivePackingBiz.class);

	AmazonS3 s3Client;

	@Value("#{config['c.debugtype']}")
	private String debugtype;

	@Value("#{config['c.awsBucket']}")
	private String bucket;

	@Value("#{config['c.awsAki']}")
	private String accessKey;

	@Value("#{config['c.awsSk']}")
	private String secretKey;

	@Value("#{config['c.awsRegion']}")
	private String region;

	public void setS3Client() {
		AWSCredentials credentials = new BasicAWSCredentials(this.accessKey, this.secretKey);

		s3Client = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(credentials)).withRegion(this.region).build();
	}

	public String upload(MultipartFile file) throws Exception {
		logger.debug("[upload] multipartFile : "+ file.getOriginalFilename());

		this.setS3Client();

		Date today = new Date();
		SimpleDateFormat format1, format2;
		format1 = new SimpleDateFormat("yyyy-MM-dd");
		format2 = new SimpleDateFormat("HHmmss");

		String yyyyMMdd = format1.format(today);
		String[] ymd =  yyyyMMdd.split("-");
		String dirPath;
		String fileName = format2.format(today) +"_"+ file.getOriginalFilename();
		if (debugtype.equals("DEV")) {
			dirPath = "/DEV/"+ ymd[0] +"/"+ ymd[1] +"-"+ ymd[2];
		} else {
			dirPath = "/REAL/"+ ymd[0] +"/"+ ymd[1] +"-"+ ymd[2];
		}

		s3Client.putObject(new PutObjectRequest(bucket + dirPath, fileName, file.getInputStream(), null).withCannedAcl(CannedAccessControlList.PublicRead));
		return s3Client.getUrl(bucket + dirPath, fileName).toString();
	}

	public void insert(LDataMap paramMap) throws Exception {

		LivePackingVo livePackingVo = new LivePackingVo();
		livePackingVo.setOrgcd(paramMap.getString("orgcd"));
		livePackingVo.setS3Url(paramMap.getString("s3Url"));
		livePackingVo.setXrtInvcSno(paramMap.getString("xrtInvcSno").replaceAll(".webm", ""));
		livePackingVo.setAddusercd(paramMap.getString("usercd"));
		livePackingVo.setUpdusercd(paramMap.getString("usercd"));
		livePackingVo.setTerminalcd(paramMap.getString("terminalcd"));

		dao.insert("livePackingMapper.insert", livePackingVo);
	}
}
