package Tableocl;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import User.User;

public class DbDao {
	Connection conn = null; // JDBC 설정 연결하기
	PreparedStatement pstmt = null; // 쿼리문 설정 및 실행
	ResultSet rs; // 결과값 받아오는 객체

	public DbDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "web_user", "pass");
		} catch (Exception e) {
			e.printStackTrace(); // connection부터 이까지 한 덩어리//
		}
	}

	public String getDate() // 현재시간을 get ~ , 다른 Dao에서 상속해도 될 거 같은데.....
	{
		String SQL = "SELECT SYSDATE FROM DUAL"; // 현재 시간 찍기
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
  }
	
/*	//근속개월을 계산하기 위한 함수 - 
	public int Month() {
		String SQL = "INSERT INTO bbs VALUES (?,?,?,?,?)"   // SQL 에서 근속개월수를 계산하는 쿼리문을 작성 - 
		 
		
		/* SELECT
		'83/05/12' "입사일", sysdate "현재날짜",

		trunc(mod(months_between(sysdate,'1983-05-12') /12,1) *12) "근속월"
		FROM dual ;*/
		
		//코딩할 부분 - month가 getData기준으로 3이면 계약직1 , 12이면 계약직2 , 24면 무기계약직, Case문으로 고용전환 계약일정 세팅 
		// Case별로 나눈 다음에 마지막에는 조건문을 빠져나가게 코딩하고...
		// try 문 이하부분으로 사번 / 이름 / 입사일 / 고용전환 건수를 list로 만들어 준 다음에 popup2로 뿌려줄 예정 
		
		
		
	/*	
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Tableocl.getNum());
			pstmt.setString(3, Tableocl.getUserName());
			pstmt.setString(4, Tableocl.MOnth());
			pstmt.setString(5, Tableocl.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
*/
				
				