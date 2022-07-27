<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${userid == null}">
	<c:redirect url="list.jsp" />
</c:if>
<%@ page import="dao.BoardDao" %>
<%
	BoardDao dao = new BoardDao();
	dao.content(request, 1);
%>
<c:import url="../top.jsp" />
<style>
	#section {
		width:1100px;
		height:auto;
		margin:auto;
		margin-top:80px;
		text-align:center;
	}
	#section table {
		border-spacing:0px;
	}
	#section table tr td:nth-child(2) {
		padding:8px 10px;
		text-align:left;
	}
	#section table tr:nth-child(3) td {
		padding:60px 10px;
	}
</style>
<script>
	function delCheck(id) {
		var chk = confirm('정말 삭제하시겠습니까?');
		if(chk)
			location = "delete.jsp?id="+id;
		else
			return false;
	}
</script>
<div id="section">
	
	<div class="pageNav">자유게시판</div>
	<h2></h2>
	
	<table width="700" align="center" border="1">
		<tr>
			<td> 제 목
			<td colspan="2">${content.title}</td>
		</tr>
		<tr>
			<td width="180"> 작성자
			<td>${content.name}</td>
			<td width="120">
				<div id="link">
					<c:if test="${blog != ''}"><a href="${blog}" target="_blank">Blog</a></c:if>
					&nbsp;
					<c:if test="${sns != ''}"><a href="${sns}" target="_blank">SNS</a></c:if>
					<c:if test="${(blog == '') && (sns == '')}"><span style="color:darkgrey;">Blog/SNS 없음</span></c:if>
				</div>
			</td>
		</tr>
		<tr>
			<td> 내 용
			<td colspan="2">${content.content}</td>
		</tr>
		<tr>
			<td> 조회수 
			<td colspan="2">${content.readnum}</td>
		</tr>
		<tr>
			<td> 작성일 
			<td colspan="2">${content.writeday}</td>
		</tr>
	</table>
	
	<p>
	<c:if test="${userid == content.userid}">
		<a href="update.jsp?id=${content.id}"><input type="button" value="수정"></a>
		<a href="javascript:delCheck(${content.id})"><input type="button" value="삭제"></a>
	</c:if>
	<c:if test="${(userid == 'admin') && (userid != content.userid)}">
		<%-- <a href="update.jsp?id=${content.id}"><input type="button" value="수정"></a> --%>
		<a href="javascript:delCheck(${content.id})"><input type="button" value="관리자 권한으로 삭제"></a>
	</c:if>
	</p>
	
	<a href="list.jsp">목록으로</a>
	
</div>
<c:import url="../bottom.jsp" />