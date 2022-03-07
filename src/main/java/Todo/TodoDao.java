package Todo;


import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import BBS.BBS;

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
  //String SQL = "INSERT INTO todolist VALUES (1,2,3,4,5,6,7)";
    
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
        pstmt.setString(7, "접수");
        pstmt.setInt(6, 1);
        return pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
}
     public ArrayList<TodoDto> getList(String to_,int pageNumber) throws UnsupportedEncodingException    
    {
    	 
    		String to = "";
    		if(to_ != null && !to_.equals(""))
    			to = to_;   // view 페이지에서 던진 값을 여기서 받음 
    	 
         //to = new String(to.getBytes("iso-8859-1"),"euc-kr");
         
    String SQL = "     SELECT * FROM"
    		+ "    		(SELECT A.*, RANK() OVER(ORDER BY TODOID DESC) RNUM FROM TODOLIST A WHERE todoavailable = 1"
    		+ "			AND TODO like ? ) "
    		+ "    		WHERE RNUM >= ? AND RNUM <= ? ";
    ArrayList<TodoDto> list = new ArrayList<TodoDto>();
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, to+"%");
        pstmt.setInt(2, (pageNumber - 1 ) * 10 + 1);
        pstmt.setInt(3, (pageNumber - 1 ) * 10 + 10);
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
     public boolean nextPage(String to_,int pageNumber) {
    	 
 		String to = "";
 		if(to_ != null && !to_.equals(""))
 			to = to_;   // view 페이지에서 던진 값을 여기서 받음 
    	 
         String SQL = "SELECT * FROM TODOLIST WHERE todoavailable = 1 and TODOID < ? and TODO like ?  "; 
         try {
             PreparedStatement pstmt = conn.prepareStatement(SQL);
             pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
             pstmt.setString(2, to+"%");
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
 
     
     
/**
  * @Method Name : gettodo
  * @작성일 : 2022. 2. 9.
  * @작성자 : bluem
  * @변경이력 : 
  * @Method 설명 : todolist에 data 입력하는 method  ( 함수 != method)
  * @param todoID
  * @return
  */
public TodoDto gettodo(int todoID)
{
        String SQL = "SELECT * FROM TODOLIST WHERE TODOID = ?";  //select * 쓰지말것
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


 public int update (int todoID,String todos,String todotitle, String todocontent) throws UnsupportedEncodingException {
	  String title;
	  title = new String(todotitle.getBytes("iso-8859-1"),"euc-kr");
	  String content;
	  content = new String(todocontent.getBytes("iso-8859-1"),"euc-kr");
	  String todo;
	  todo = new String(todos.getBytes("iso-8859-1"),"euc-kr");
	 String SQL = "UPDATE TODOLIST SET todotitle = ?, todo = ?,  todocontent = ?WHERE  todoID = ? ";

  	try {
	       PreparedStatement pstmt = conn.prepareStatement(SQL);
           pstmt.setString(1, title);
           pstmt.setString(2, todo);
           pstmt.setString(3, content);
	       pstmt.setInt(4, todoID);
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
  * @Method 설명 : TODO LIST 완료 처리 여부에 대한 Method 입력값은 가접수, 접수, 할당, 완료로 제한, 접수를 Default 
  * @param todoID
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

public ArrayList<TodoDto> getList1(String field_, String query_, int page) {
	
	String field = "todo";
	if(field_ != null && !field_.equals(""))
		field = field_;
	
	String query = "";
	if(query_ != null && !query_.equals(""))
		query = query_;
	
	
	ArrayList<TodoDto> list= new ArrayList<TodoDto>();		
	
    String SQL = "     SELECT * FROM"
    		+ "    		(SELECT A.*, RANK() OVER(ORDER BY TODOID DESC) RNUM FROM TODOLIST A WHERE todoavailable = 1"
    		+ "			WHERE upper("+field+") IN upper(?)) " //조회필드
    		+ "    		WHERE RNUM >= ? AND RNUM <= ? ";
	
	try {

		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, "%"+query+"%" ); //조회기준 
        pstmt.setInt(2, (page - 1 ) * 10 + 1);
        pstmt.setInt(3, (page - 1 ) * 10 + 10);
		rs = pstmt.executeQuery();
		
		   while (rs.next()) {
			   TodoDto tododto = new TodoDto();
			   tododto.setTodoid(rs.getInt(1));
			   tododto.setTodotitle(rs.getString(2));
			   tododto.setUserid(rs.getString(3));
			   tododto.setTododata(rs.getString(4));
			   tododto.setTodocontent(rs.getString(5));
			   tododto.setTodoavailable(rs.getString(6));
		       list.add(tododto);
		   }
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return list; 
}

}
	    
	    