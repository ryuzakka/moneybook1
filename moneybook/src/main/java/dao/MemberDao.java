package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberDao {

	Connection conn;
	PreparedStatement pstmt;
	
	public MemberDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/moneybook";
		conn = DriverManager.getConnection(db, "root", "5032");
	}
	
	public void close() throws Exception {
		pstmt.close();
		conn.close();
	}
	
	
	public void signin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String sql = "insert into member";
		sql += "(userid,name,pwd,blog,sns,writeday)";
		sql += "values(?,?,?,?,?,now())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("userid"));
		pstmt.setString(2, request.getParameter("name"));
		pstmt.setString(3, request.getParameter("pwd"));
		pstmt.setString(4, request.getParameter("blog"));
		pstmt.setString(5, request.getParameter("sns"));
		pstmt.executeUpdate();
		
		close();
		response.sendRedirect("signin_success.jsp");
	}
	
	
	
	
	
}
