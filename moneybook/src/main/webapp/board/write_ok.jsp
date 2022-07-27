<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDao" %>
<c:if test="${userid == null}">
	<c:redirect url="list.jsp" />
</c:if>
<%
	BoardDao dao = new BoardDao();
	dao.write(request, response, session);
%>