package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import dto.MemberDto;

public class MemberDao {

	Connection conn;
	PreparedStatement pstmt;
	
	public MemberDao() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		String db = "jdbc:mysql://localhost:3306/moneybook";
		conn = DriverManager.getConnection(db, "root", "1234");
	}
	
	public void close() throws Exception {
		pstmt.close();
		conn.close();
	}
	
	
	public void signup(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		response.sendRedirect("signup_success.jsp");
	}
	
	// member_input.jsp => ID중복체크
	public void useridCheck(HttpServletRequest request, JspWriter out) throws Exception {
		String sql = "select count(*) cnt from member where userid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("userid"));
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		out.print(rs.getString("cnt"));
	}
	
	public void login(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		String sql = "select * from member where userid=? and pwd=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("userid"));
		pstmt.setString(2, request.getParameter("pwd"));
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("name", rs.getString("name"));
			session.setAttribute("blog", rs.getString("blog"));
			session.setAttribute("sns", rs.getString("sns"));
			
			rs.close();
			close();
			
			response.sendRedirect("../main/index.jsp");
		} else {
			rs.close();
			close();
			
			response.sendRedirect("login.jsp?chk=1");
		}
	}
	
	// logout.jsp => 로그아웃
	public void logout(HttpSession session, HttpServletResponse response) throws Exception {
		session.invalidate();
		response.sendRedirect("../main/index.jsp");
	}
	
	// member_info.jsp => 회원정보 조회
	public void getUserInfo(HttpServletRequest request, HttpSession session) throws Exception {
		String userid = session.getAttribute("userid").toString();
		String sql = "select * from member where userid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		MemberDto dto = new MemberDto();
		dto.setId(rs.getInt("id"));
		dto.setUserid(rs.getString("userid"));
		dto.setName(rs.getString("name"));
		dto.setBlog(rs.getString("blog"));
		dto.setSns(rs.getString("sns"));
		dto.setState(rs.getInt("state"));
		
		request.setAttribute("member", dto);
		rs.close();
		close();
	}
	
	// 비밀번호 검증 => 회원정보/비밀번호 수정때 활용
	public boolean pwdCheck(String id, String pwd) throws Exception {
		String sql = "select * from member where userid=? and pwd=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			rs.close(); 
			return true;
		}
		else {
			rs.close();
			return false;
		}
	}
	
	// pwd_change_ok.jsp => 회원 비밀번호 수정
	public void pwdChange(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		request.setCharacterEncoding("UTF-8");
		String id = session.getAttribute("userid").toString();
		String pwd = request.getParameter("oldpwd");
		
		if(pwdCheck(id, pwd)) {
			String newpwd = request.getParameter("newpwd2");
			String sql = "update member set pwd=? where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newpwd);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			
			close();
			logout(session, response);
		} else {
			close();
			response.sendRedirect("pwd_change.jsp?chk=1");
		}
	}
	
	// member_update_ok.jsp => 회원정보수정
	public void memberUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		if(pwdCheck(userid, pwd)) {
			String sql = "update member set ";
			sql += "blog=?, sns=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, request.getParameter("blog"));
			pstmt.setString(2, request.getParameter("sns"));
			pstmt.setString(3, request.getParameter("id"));
			pstmt.executeUpdate();
			
			close();
			response.sendRedirect("../main/index.jsp");
		} else {
			close();
			response.sendRedirect("member_update.jsp?chk=1");
		}
	}
	
	
	
	
	
	
}
