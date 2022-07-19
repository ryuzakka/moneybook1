<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp" />
<style>
	#section {
		width:1100px;
		height:400px;
		margin:auto;
		margin-top:80px;
		text-align:center;
	}
	#section table tr td:nth-child(2) {
		text-align:left;
	}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function addr_search() {	//우편번호 버튼 클릭시 호출 함수명
  new daum.Postcode({
      oncomplete: function(data) {
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.lunchInput.zip.value = data.zonecode; // 우편번호
          document.lunchInput.addr1.value = addr;  // 주소
          // 커서를 상세주소 필드로 이동한다.
          document.lunchInput.addr2.focus();
      }
  }).open();
}
</script>

<div id="section">
	<form name="lunchInput" method="post" action="write_ok.jsp">
		<h2>점심 메뉴 등록</h2>
	<table width="420" border="1" align="center">
		<tr>
			<td> 식당이름 </td>
			<td> <input type="text" name="title" size="30"> </td>
		</tr>
		<tr>
			<td> 위치 </td>
			<td>
				<input type="text" name="zip" size="6">
				<input type="button" value="주소찾기" onclick="addr_search()"><br>
				<input type="text" name="addr1" size="40"><br>
				<input type="text" name="addr2" size="40">
			</td>
		</tr>
		<tr>
			<td> 대표메뉴 </td>
			<td> <input type="text" name="menu" size="30"> </td>
		</tr>
	</table>
	<p><input type="submit" value="저장"></p>
	<a href="list.jsp"><input type="button" value="목록으로"></a>
	</form>
</div>

<c:import url="../bottom.jsp" />