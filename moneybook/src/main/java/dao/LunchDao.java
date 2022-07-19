package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LunchDao {

	Connection conn;
	PreparedStatement pstmt;
	
	public LunchDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/moneybook";
		conn = DriverManager.getConnection(db, "root", "5032");
	}
	
	public void close() throws Exception {
		pstmt.close();
		conn.close();
	}
	
	public void write(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		request.setCharacterEncoding("utf-8");
		String sql = "insert into lunch";
		sql += "(name,title,menu,zip,addr1,addr2,writeday) ";
		sql += "values(?,?,?,?,?,?,now())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("username").toString());
		pstmt.setString(2, request.getParameter("title"));
		pstmt.setString(3, request.getParameter("menu"));
		pstmt.setString(4, request.getParameter("zip"));
		pstmt.setString(5, request.getParameter("addr1"));
		pstmt.setString(6, request.getParameter("addr2"));
		pstmt.executeUpdate();
	}
	
}
