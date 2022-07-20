package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.LunchDto;

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
		sql += "(regname, title, menu, zip, addr1, addr2, writeday, lat, lng) ";
		sql += "values(?,?,?,?,?,?,now(),?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("regname"));
		pstmt.setString(2, request.getParameter("title"));
		pstmt.setString(3, request.getParameter("menu"));
		pstmt.setString(4, request.getParameter("zip"));
		pstmt.setString(5, request.getParameter("addr1"));
		pstmt.setString(6, request.getParameter("addr2"));
		pstmt.setString(7, request.getParameter("lat"));
		pstmt.setString(8, request.getParameter("lng"));
		pstmt.executeUpdate();
		
		close();
		response.sendRedirect("list.jsp");
	}
	
	public void list(HttpServletRequest request) throws Exception {
		
		String sql = "select * from lunch order by id desc";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<LunchDto> list = new ArrayList<LunchDto>();
		
		while(rs.next()) {
			LunchDto dto = new LunchDto();
			dto.setId(rs.getInt("id"));
			dto.setTitle(rs.getString("title"));
			dto.setMenu(rs.getString("menu"));
			dto.setRegname(rs.getString("regname"));
			dto.setZip(rs.getString("zip"));
			dto.setAddr1(rs.getString("addr1"));
			dto.setAddr2(rs.getString("addr2"));
			dto.setReadnum(rs.getInt("readnum"));
			dto.setWriteday(rs.getString("writeday"));
			dto.setLat(rs.getString("lat"));
			dto.setLng(rs.getString("lng"));
			
			list.add(dto);
		}
		
		request.setAttribute("list", list);
		
		rs.close();
		close();
	}
	
	
	
	
	
	
	
	
}
