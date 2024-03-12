package com.harmony.longterm.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.BufferedReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.net.HttpURLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.harmony.longterm.dao.ApiDao;
import com.harmony.longterm.service.IApiService;
import com.harmony.longterm.vo.ApiRecvDataVO;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;



@Service
public class ApiService implements IApiService {
	private static final Logger logger = LoggerFactory.getLogger(ApiService.class);
	
	@Resource(name="configProps")
    private Properties props;
	
	
	@Autowired
	private ApiDao apiDao;

	@Override
	public List<ApiRecvDataVO> selectApiRecvDataList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return apiDao.selectApiRecvDataList(map);
	}
	@Override
	public int insertApiRecvData(ApiRecvDataVO apiHyundaiVO) throws Exception {
		// TODO Auto-generated method stub
		return apiDao.insertApiRecvData(apiHyundaiVO);
	}

	@Override
	public void deleteApiRecvData(ApiRecvDataVO apiHyundaiVO) throws Exception {
		// TODO Auto-generated method stub
		apiDao.deleteApiRecvData(apiHyundaiVO);
	}
	@Override
	public void updateApiRecvData(HttpServletRequest request, HashMap<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		if("SK".equals(param.get("company")) ) {
			String reponse = apiSendSkData(request,param);
		}
//		logger.debug(param.toString());
		apiDao.updateApiRecvData(param);

	}
	
	private String apiSendSkData(HttpServletRequest request, HashMap<String, Object> param) throws Exception {

		String url = "https://apirex.skdirect.co.kr/auc-contracts/"+param.get("cntrId");	//운영

//		String url = "https://apidex.skcarrentalezydirect.com:8443/auc-contracts/"+param.get("cntrId");		//개발
		String viewYn = "Y";
		
		if(param.get("cntrReqSts").equals("A61003")) {
			viewYn = "N";
		}
		String requestBody = "{\"cntrId\":\"" + param.get("cntrId") + "\",\"cntrReqSts\":\"" + param.get("cntrReqSts") + "\",\"viewYn\":\"" +viewYn+"\",\"updUser\":\"harmonyRent\"}";
		
        HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        connection.setRequestProperty("Content-Type", "application/json");
        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(requestBody.getBytes(StandardCharsets.UTF_8));
        outputStream.flush();
        outputStream.close();

        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuilder response = new StringBuilder();
            
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            logger.info("url :" +url);
            logger.info("requestBody :" +requestBody);
            logger.info( "sk response" + response.toString());
            return response.toString();
        } else {
            System.out.println("Failed to get access token, response code: " + responseCode);
            return null;
        }       
	}

	
	/**
	     * 
	     * Base64 복호화 후 AES복호화
	     *
	     * @param encryptedText
	     * @param key
	     * @return
	     * @throws UnsupportedEncodingException
	     * @throws Exception
	
	public static String decryptBase64Test(String encryptedText) throws UnsupportedEncodingException, Exception {

		byte[] cipheredBytes = Base64.decodeBase64(encryptedText);

		byte[] keyBytes = getKeyBytes(ENCRYPT_KEY);
		byte[] ivBytes = getKeyBytes(ENCRYPT_IV);
		
		return new String(decrypt(cipheredBytes, keyBytes, ivBytes), "UTF-8");
	        
	    }

	public static byte[] decrypt(byte[] cipherText, byte[] key, byte[] initialVector) throws Exception {
		
		Cipher cipher = Cipher.getInstance(CIPHER_TRANSFORMATION);

		SecretKeySpec secretKeySpec = new SecretKeySpec(key, AES_ENCRYPTION_ALGORITHM);
		
		IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);

		cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);

		byte[] returnCipherText = cipher.doFinal(cipherText);

		return returnCipherText;
	}

	private static byte[] getKeyBytes(String key) throws UnsupportedEncodingException {

		byte[] keyBytes = new byte[32];
		
		byte[] parameterKeyBytes = key.getBytes(CHARACTER_ENCODING);
		
		System.arraycopy(parameterKeyBytes, 0, keyBytes, 0, Math.min(parameterKeyBytes.length, keyBytes.length));
		
		return keyBytes;
	}
     */
	
}
