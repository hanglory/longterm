package com.jssolution.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import org.junit.Test;



public class test {

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/harmony?useSSL=false&serverTimezone=Asia/Seoul"; // jdbc:mysql://127.0.0.1:3306/여러분이
																							// 만드신 스키마이름
	private static final String USER = "root"; // DB 사용자명
	private static final String PW = "rlatnsdhr2"; // DB 사용자 비밀번호

	@Test
	public void testConnection() throws Exception {
		Class.forName(DRIVER);

		try (Connection con = DriverManager.getConnection(URL, USER, PW)) {

			System.out.println("성공");
			System.out.println(con);
			
			Statement stmt = con.createStatement();
			String sql = "select * from trimview";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println(rs.getString("model_name"));
			}
		} catch (Exception e) {
			System.out.println("에러발생");
			e.printStackTrace();
		}
	}

}
