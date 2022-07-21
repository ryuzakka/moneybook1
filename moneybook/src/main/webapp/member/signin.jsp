<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- member_input.jsp -->

<c:import url="../top.jsp" />

<style>
	#section {
		width:1100px;
		height:550px;
		margin:auto;
		margin-top:70px;
		text-align:center;
	}
	#section table tr td:first-child {
		width:140px;
	}
	#section table tr td:nth-child(2) {
		text-align:left;
		padding-left:18px;
		
		height:60px;
	}
	#section table tr td:nth-child(2) input[type="text"] {
		width:300px;
		padding:5px;
	}
	#section table tr td:nth-child(2) input[type="password"] {
		width:300px;
		padding:5px;
	}
	#section #idError , #section #pwdError {
		font-size:13px;
		color:red;
	}
</style>

<div id="section">
<form name="memeberInputForm" method="post" action="signin_ok.jsp" onsubmit="return final_check(this)">
	<h2> 회원 가입 </h2>
	<table width="600" align="center" border="1">
		<tr>
			<td> 아이디* </td>
			<td>
				<input type="text" name="userid" onblur="userid_check(this)" required><br>
				<span id="idError"></span>
			</td>
		</tr>
		<tr>
			<td> 닉네임* </td>
			<td>
				<input type="text" name="name" required><br>
				<div style="color:tomato;font-size:12px;">
					<strong>실명은 사용하지 않으셔도 됩니다 !</strong>
					닉네임은 게시판에서 활용됩니다.
				</div>
			</td>
		</tr>
		<tr>
			<td> 비밀번호* </td>
			<td>
				<input type="password" name="pwd" required><br>
			</td>
		</tr>
		<tr>
			<td> 비밀번호 확인* </td>
			<td>
				<input type="password" name="pwd2" onkeyup="pwd_check(this.value)" required><br>
				<span id="pwdError"></span>
			</td>
		</tr>
		<tr>
			<td> 블로그 </td>
			<td>
				<input type="text" name="blog" placeholder="http://">
			</td>
		</tr>
		<tr>
			<td> SNS </td>
			<td>
				<input type="text" name="sns" placeholder="자신의 SNS를 자랑해보세요 !">
			</td>
		</tr>
	</table>
	
	<p><input type="submit" value="가입하기"></p>
	<a href="../main/index.jsp"><input type="button" value="메인으로 가기"></a>
	<a href="../member/login.jsp"><input type="button" value="로그인"></a>
</form>
</div>

<c:import url="../bottom.jsp" />