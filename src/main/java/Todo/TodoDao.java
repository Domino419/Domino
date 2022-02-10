package Todo;


import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


/**
  * @FileName : TodoDao.java
  * @Project : Jsptest
  * @Date : 2022. 2. 9. 
  * @작성자 : bluem
  * @변경이력 :
  * @프로그램 설명 :
  */
/**
  * @FileName : TodoDao.java
  * @Project : Jsptest
  * @Date : 2022. 2. 9. 
  * @작성자 : bluem
  * @변경이력 :
  * @프로그램 설명 :
  */
public class TodoDao {

  Connection conn = null;       //JDBC 설정 연결하기  
  PreparedStatement pstmt = null;      //쿼리문 설정 및 실행 
  ResultSet rs;                    //결과값 받아오는 객체  	

  public TodoDao() { try{ Class.forName("oracle.jdbc.driver.OracleDriver");
  conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass"); 
  }catch 
	  (Exception e)
			  { e.printStackTrace() ;    //connection부터 이까지 한 덩어리//
    }
  }		 	   

public String getDate() // 현재시간을 넣어주기위해
{
    String SQL = "SELECT SYSDATE FROM DUAL"; // 현재 시간 찍기 
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        if(rs.next()) {
            return rs.getString(1);
        }        
    } catch (Exception e) {
        e.printStackTrace();
    }
    return ""; // 데이터베이스 오류
}

public int getNext()   //게시글 번호 가져오기 
{
     String SQL = "SELECT MAX(TodoID) FROM Todolist";   
	//String SQL = "SELECT bbsID from bbsjsp order by bbsID desc";   
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        while (rs.next()) {
        int a = rs.getInt(1) + 1 ;
        return a;
        }
       }catch (Exception e) {
          e.printStackTrace();
       }
   return -1; //
}
public int write(String todoTitle, String userID, String todoContent) {
    String SQL = "INSERT INTO todolist VALUES (?,?,?,?,?,?,?)";
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        String title;
        title = new String(todoTitle.getBytes("iso-8859-1"),"euc-kr");
        String content;
        content = new String(todoContent.getBytes("iso-8859-1"),"euc-kr");
        pstmt.setInt(1, getNext());
        pstmt.setString(2, title);
        pstmt.setString(3, userID);
        pstmt.setString(4, getDate());
        pstmt.setString(5, content);
        pstmt.setString(6, "접수");
        pstmt.setInt(7, 1);
        return pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
}
     public ArrayList<TodoDto> getList(int pageNumber)    
    {
    String SQL = "     SELECT * FROM"
    		+ "    		(SELECT A.*, RANK() OVER(ORDER BY TODOID DESC) RNUM FROM TODOLIST A WHERE todoavailable = 1) "
    		+ "    		WHERE RNUM >= ? AND RNUM <= ? ";
    ArrayList<TodoDto> list = new ArrayList<TodoDto>();
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
       // pstmt.setInt(1, 10);        
        pstmt.setInt(1, (pageNumber - 1 ) * 10 + 1);
        pstmt.setInt(2, (pageNumber - 1 ) * 10 + 10);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            TodoDto tododto = new TodoDto();

            tododto.setTodoid(rs.getInt(1));
            tododto.setTodotitle(rs.getString(2));
            tododto.setUserid(rs.getString(3));
            tododto.setTododata(rs.getString(4));
            tododto.setTodocontent(rs.getString(5));
            tododto.setTodoavailable(rs.getString(6));
            tododto.setTodo(rs.getString(7));
            list.add(tododto);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list; 
}
     public boolean nextPage(int pageNumber) {
         String SQL = "SELECT * FROM TODOLIST WHERE todoavailable = 1 and TODOID < ? "; 
         try {
             PreparedStatement pstmt = conn.prepareStatement(SQL);
             pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
             rs = pstmt.executeQuery();
             if (rs.next())
             {
                 return true;
             }
         } catch (Exception e) {
             e.printStackTrace();
         }
         return false; 
     }
 
public TodoDto gettodo(int todoID)
{
        String SQL = "SELECT * FROM TODOLIST WHERE TODOID = ?"; 
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, todoID);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
            	TodoDto tododto = new TodoDto();
            	//구조.     =    기능 // 
            	tododto.setTodoid(todoID);
            	tododto.setTodotitle(rs.getString(2));
            	tododto.setUserid(rs.getString(3));
            	tododto.setTododata(rs.getNString(4));
            	tododto.setTodocontent(rs.getString(5));
            	tododto.setTodoavailable(rs.getString(6));
            	tododto.setTodo(rs.getString(7));
                return tododto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; 
    }


 public int update (int todoID, String todotitle, String todocontent) throws UnsupportedEncodingException {
	  String title;
	  title = new String(todotitle.getBytes("iso-8859-1"),"euc-kr");
	  String content;
	  content = new String(todocontent.getBytes("iso-8859-1"),"euc-kr");
	 String SQL = "UPDATE TODOLIST SET todotitle = ?, todocontent = ? WHERE  todoID = ? ";

  	try {
	       PreparedStatement pstmt = conn.prepareStatement(SQL);
           pstmt.setString(1, title);
           pstmt.setString(2, content);
	       pstmt.setInt(3, todoID);
	       return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
   } 
 
public int delete(int todoID)
{
    String SQL = "UPDATE TODOLIST SET todoavailable = 0  WHERE todoID = ?";
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, todoID);
        return pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
}


/**
  * @Method Name : complete
  * @작성일 : 2022. 2. 9.
  * @작성자 : bluem
  * @변경이력 : 아직 구현 전 (-_-)
  * @Method 설명 : TODO LIST 완료 처리 여부에 대한 프로그램 / 웹 드롭박스에서 선택값을 db에 반영해주는 함수
  * @param 
  * @return
  */
public int complete(int todoID)
{
    String SQL = "UPDATE TODOLIST SET todoavailable = 0  WHERE todoID = ?";
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, todoID);
        return pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
}

}
	    
	    