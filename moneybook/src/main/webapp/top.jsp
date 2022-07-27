<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.GongjiDao" %>
<%
	GongjiDao gdao = new GongjiDao();
	gdao.notice(request);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="../etc/moneybook.css" />
	<script src="../etc/moneybook.js"></script>
	<title>Madu-Java-Class</title>
	<meta name="description" content="EZEN-Community(Madu-Java-Class)">
	<script>
		function view(n) {
			document.getElementsByClassName('sub')[n].style.visibility = "visible";
		}
		function hide(n) {
			document.getElementsByClassName('sub')[n].style.visibility = "hidden";
		}
	</script>
</head>
<body>

	<div id="first">
		<div id="noti">
			<div id="notiTitle" align="center">알립니다.</div>
			<table width="400" align="center" border="0">
				<c:forEach items="${notice}" var="noti">
					<tr><td><a href="../gongji/content.jsp?id=${noti.id}">${noti.title}</a></td></tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div id="second">
		<div id="left">
			<a href="../main/index.jsp"><img src="../img/logo.png" width="35px"></a>
			EZEN-Community
		</div>
		<div id="right">
			<ul class="menu">
				<li id="menu" onmouseover="view(0)" onmouseout="hide(0)">
					<div>뭐먹지?</div>
					<ul class="sub">
						<li><a href="../lunch/list.jsp">맛집리스트</a></li>
					</ul>
				</li>
				<li id="menu" onmouseover="view(1)" onmouseout="hide(1)">
					<div>나의소비</div>
					<ul class="sub" style="display:none;">
						<li></li>
					</ul>
				</li>
				<li id="menu" onmouseover="view(2)" onmouseout="hide(2)">
					<div>커뮤니티</div>
					<ul class="sub">
						<li><a href="../gongji/list.jsp">공지사항</a></li>
						<li id="qna"><a href="../qna/list.jsp">문의하기</a></li>
						<li><a href="../board/list.jsp">자유게시판</a></li>
					</ul>
				</li>
				
				<li id="menu" onmouseover="view(3)" onmouseout="hide(3)">
					<c:if test="${userid == null}">
						<div>회원서비스</div>
						<ul class="sub">
							<li><a href="../member/login.jsp">로그인</a></li>
							<li><a href="../member/signup.jsp">회원가입</a></li>
						</ul>
					</c:if>
					<c:if test="${userid != null}">
						<div>${name} 님</div>
						<ul class="sub">
							<li><a href="../member/member_info.jsp">회원정보</a></li>
							<li><a href="../member/logout.jsp">로그아웃</a></li>
						</ul>
					</c:if>
				</li>
			</ul>
		</div>
	</div>
	
	<%-- <c:set var="main" value="index.jsp" />
	<c:if test="${url != main}">
	<div id="noti">
		<div id="notiTitle" align="center">알립니다.</div>
		<table width="400" align="center" border="0">
			<c:forEach items="${notice}" var="noti">
				<tr><td><a href="../gongji/content.jsp?id=${noti.id}">${noti.title}</a></td></tr>
			</c:forEach>
		</table>
	</div>
	<hr>
	</c:if> --%>
	
	