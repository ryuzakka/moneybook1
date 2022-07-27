<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:if test="${userid == null}">
	<c:redirect url="list.jsp" />
</c:if>
<%@ page import="dao.BoardDao" %>
<%
	BoardDao dao = new BoardDao();
	dao.readnum(request, response);
%>