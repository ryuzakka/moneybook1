<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.LunchDao" %>
<%
	LunchDao dao = new LunchDao();
	dao.content(request);
%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=70a5855d29c102d6c8f57bfa08052026&libraries=services"></script>
<c:import url="../top.jsp" />
<style>
	#section {
		width:1100px;
		height:600px;
		margin:auto;
		margin-top:80px;
		text-align:center;
	}
</style>
<script>
	window.onload = function() {

		var container = document.getElementById('map'); // 지도를 표시할 div
		var options = {
	        center: new kakao.maps.LatLng(${lunch.lat}, ${lunch.lng}), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
		var map = new kakao.maps.Map(container, options); 
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(${lunch.lat}, ${lunch.lng}); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	}
	
	function delCheck(id) {
		var chk = confirm('삭제하시겠습니까?');
		if(chk)
			location = "delete.jsp?id="+id;
		else
			return false;
	}
	
</script>
<div id="section">
	
	<h2>${lunch.title}</h2>
	<table width="800" align="center" border="1">
		<tr>
			<td> 이 름 </td>
			<td> ${lunch.title} </td>
		</tr>
		<tr>
			<td> 주메뉴 </td>
			<td> ${lunch.menu} </td>
		</tr>
		<tr>
			<td> 작성자 </td>
			<td> ${lunch.regname} </td>
		</tr>
		<tr>
			<td> 작성일 </td>
			<td> ${lunch.writeday} </td>
		</tr>
		<tr>
			<td> 주소 </td>
			<td> ${lunch.addr1} </td>
		</tr>
		<tr>
			<td> 위치 </td>
			<td> <div id="map" style="width:470px;height:280px;margin:8px;"></div> </td>
		</tr>
	</table>
	<p>
	
	<c:if test="${sessionScope.userid == 'admin'}">
		<a href="update.jsp?id=${lunch.id}"><input type="button" value="수정"></a>
		<a href="delete.jsp?id=${lunch.id}"><input type="button" value="삭제"></a> <p>
	</c:if>
	
	<a href="list.jsp"><input type="button" value="목록"></a>
	
</div>