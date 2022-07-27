<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.LunchDao" %>
<%@ page import="dao.BoardDao" %>
<%
	LunchDao ldao = new LunchDao();
	ldao.mainList(request);
	BoardDao bdao = new BoardDao();
	bdao.mainList(request);
%>
<style>
	#fifth .place {
		cursor:pointer;
	}
	#fourth .article {
		cursor:pointer;
	}
</style>
<c:import url="../top.jsp" />
<div id="section">
	<div id="third">
		<div id="mainImg"><img src="../img/main_street.jpg" width="1100" height="400"></div>
	</div>
	
	<div id="fifth">
		<h3 align="center" style="padding-left:90px;">최근에 등록된 맛집 <a href="../lunch/list.jsp"><input type="button" value="맛집 더보기"></a></h3>
		<c:forEach items="${list}" var="place">
			<div class="place" onclick="javascript:location='../lunch/readnum.jsp?id=${place.id}'">
				<div class="placeTitle">${place.title}</div>
				<div class="placeMenu">${place.menu}</div>
				<div class="placeAddr">${place.addr1}</div>
				<div class="placeRegname">${place.regname}</div>
			</div>
		</c:forEach>
	</div>
	
	<div id="fourth">
		<h3 align="center" style="padding-left:90px;">자유게시판 최신글<a href="../board/list.jsp" style="padding-left:10px;"><input type="button" value="게시판 더보기"></a></h3>
		<c:forEach items="${blist}" var="board">
			<div class="article" onclick="javascript:location='../board/readnum.jsp?id=${board.id}'">
				<div class="articleTitle">${board.title}</div>
				<div class="articleName">${board.name}</div>
				<div class="articleDay">${board.writeday}</div>
			</div>
		</c:forEach>
	</div>
</div>	
<c:import url="../bottom.jsp" />