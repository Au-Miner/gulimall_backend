package com.atguigu.gulimall.thirdparty;

import com.aliyun.oss.OSSClient;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;


@RunWith(SpringRunner.class)

@SpringBootTest
public class GulimallThirdPartyApplicationTests {

	@Resource
	OSSClient ossClient;

	@Test
	public void testUpload() throws FileNotFoundException {
//		String endpoint = "oss-cn-hangzhou.aliyuncs.com";
//		String accessKeyId = "LTAI5tPAuVtxBtP6Hexc2GCH";
//		String accessKeySecret = "ctQqY5ivzq2Ov3bOIIDE7RpBm25bbp";
//		OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
		InputStream inputStream = new FileInputStream("/Users/au_miner/Desktop/pic1.png");
		ossClient.putObject("gulimall-4712", "pic1.png", inputStream);
		ossClient.shutdown();
		System.out.println("ok!!!");
	}

}
