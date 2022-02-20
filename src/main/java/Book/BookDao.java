package Book;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BookDao {
	Connection conn = null; // JDBC 설정 연결하기
	PreparedStatement pstmt = null; // 쿼리문 설정 및 실행
	ResultSet rs; // 결과값 받아오는 객체

	public BookDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "web_user", "~~~~");
		} catch (Exception e) {
			e.printStackTrace(); // connection부터 이까지 한 덩어리//
		}
	}

	/**
	 * @Method Name : getDate
	 * @작성일 : 2022. 2. 13.
	 * @작성자 : bluem
	 * @변경이력 :
	 * @Method 설명 : 현재 시간을 넣어주는 역할
	 * @return
	 */
	public String getDate() {
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

	/**
	 * @Method Name : getNext
	 * @작성일 : 2022. 2. 13.
	 * @작성자 : bluem
	 * @변경이력 :
	 * @Method 설명 : BookTable에서 가장 큰 숫자 
	 * @return
	 */
	public int getNext() {
		String SQL = "SELECT MAX(ID) FROM BOOK";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int a = rs.getInt(1) + 1;
				return a;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //
	}
   
	/**
	 * @Method Name : TitleSearch
	 * @작성일 : 2022. 2. 13.
	 * @작성자 : bluem
	 * @변경이력 :
	 * @Method 설명 : view에서 제목 입력받으면 실행시킬 쿼리, Db에서 입력받은 값을 where에 넣어서 검색해주세요 
	 * @param booktitle
	 * @return
	 */
	public int TitleSearch(String booktitle) {
		//String SQL = "SELECT * FROM BOOK WHERE Title like '&?&'";
		String SQL = "SELECT ID, ISBN, TITLE, Writer, Publish, page, price, Pday, memo, Gubun FROM BOOK WHERE Title like '&?&'";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			String title;
			title = new String(booktitle.getBytes("iso-8859-1"), "euc-kr");
			pstmt.setString(1, title); 
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<BookDao> getList()

	{
		String SQL = "SELECT ID, ISBN, TITLE, Writer, Publish, page, price, Pday, memo, Gubun FROM BOOK " ;

		ArrayList<BookDao> list = new ArrayList<BookDao>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
		/* pstmt.setInt(1, 10);
		stmt.setInt(1, (pageNumber - 1) * 10 + 1); 도서목록에서는 페이징 처리 안할꺼임
		stmt.setInt(2, (pageNumber - 1) * 10 + 10); 리스트 한번에 보는 게 편해서.. */
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BookDto book = new BookDto();
				book.setBookid(rs.getInt(1)); // ID int
				book.setIsbn(rs.getInt(2)); /// ISBN int
				book.setBooktitle(rs.getString(3)); // 제목
				book.setBookwriter(rs.getString(4)); // 지은이
				book.setBookpublish(rs.getString(5)); // 출판사
				book.setPage(rs.getInt(6)); // page int
				book.setPday(rs.getString(7)); // 출판일
				book.setBookprice(rs.getInt(8)); // 가격 int
				book.setMemo(rs.getString(9)); // memo
				book.setGubun(rs.getString(10));// 장르구분
				// list.add(book);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
/**
  * @Method Name : WriteSearch
  * @작성일 : 2022. 2. 13.
  * @작성자 : bluem
  * @변경이력 : 
  * @Method 설명 : 작가 이름으로 도서리스트 검색하려고 만든 메소드
  * @param Bookwriter
  * @return
  */
public int WriteSearch (String Bookwriter) {
	// String SQL = "INSERT INTO BOOK VALUES (?,?,?,?,?,?)";
	String SQL = "SELECT * FROM BOOK WHERE Writer like like '&?&'";
	try {
		PreparedStatement pstmt = conn.prepareStatement(SQL);
		String Writer;
		Writer = new String(Bookwriter.getBytes("iso-8859-1"), "euc-kr");
		pstmt.setString(1, Writer); //
		return pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	}
	return -1; // 데이터베이스 오류
}
}
