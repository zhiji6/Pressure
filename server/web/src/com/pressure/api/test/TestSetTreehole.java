package com.pressure.api.test;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;

/**
 * 
 * @ClassName: TestSetTreehole
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-11-7 下午11:19:49
 */
public class TestSetTreehole {
	public static void main(String[] args) {

		String strURL = "http://127.0.0.1:8080/Pressure/apiTreehole.do?action=setTreehole";
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(strURL);

		try {

			JSONObject object = new JSONObject();
			object.put("id", 2);
			object.put("userId", 1);
			object.put("pictureUrl", "pirtureUrl89");
			object.put("voice", "voice");
			object.put("location", "location");
			object.put("content", "content");

			JSONObject requestObject = new JSONObject();
			requestObject.put("requestData", object.toString());

			RequestEntity entity = new StringRequestEntity(
					requestObject.toString());
			// Part[] parts = { new StringPart("requestData", object.toString())
			// };
			post.setRequestEntity(entity);

			int result = httpclient.executeMethod(post);
			System.out.println("the result of post : " + result);
			System.out.println(" the response of post : "
					+ post.getResponseBodyAsString());

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("error in post");
		} finally {
			post.releaseConnection();
		}
	}
}
