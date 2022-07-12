<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>스금커뮤</title>
<meta charset="utf-8">
<meta name="viewport" content="width--device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/egovframework/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="./js/jquery-3.5.1.min.js"></script>
<script src="./css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

	$( document).ready( function(){
		<c:if test="${!empty msg}">
			alert("${msg}");
		</c:if>
		
	})

	function check() {
		if ($("#id").val() == "") {
			alert("아이디를 입력하세요");
			return false;
		}
		if ($("#password").val() == "") {
			alert("비밀번호를 입력하세요");
			return false;
		}
		return true;
	}
	
	/* -------------------- 성구님 --------------------- */
	function joinBtn(){
		location.href = "<c:url value='/join.do'/>";
	}
	
	/* -------------------- 승수님 --------------------- */
	function findIdBtn(){
		location.href = "<c:url value='/findId.do'/>";
	}
	function findPwBtn(){
		location.href = "<c:url value='/findPw.do'/>";
	}
	
</script>

<style>
	body {
		background-image: url('./images/egovframework/example/bgLogin.jpg');
	}
	@media(max-width: 720px){
		body {
			font-size: 13px;
		}
		.container {
			width: 80%;
			padding: 90px 20px;
		}
	}
</style>
</head>
<body>
	<div class="bg"></div>
	<div class="container">
		<h1><img src="./images/egovframework/example/seuLogo.png"></h1>
		<c:if test="${sessionScope.id ==null || sessionScope.id == '' }">
			<form action="/userLogin.do" method="post">
				<div class="inputBox">
					<span class="iconBox"><i class="fa-solid fa-user"></i></span>
					<input type="text" name="id" id="id" placeholder="학번을 입력해주세요">
				</div>
				<div class="inputBox">
					<span class="iconBox"><i class="fa-solid fa-key"></i></span>
					<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요">
				</div>
				<div class="inputBox confirmBtn">
					<button type="button" onclick="findIdBtn();">학번 찾기</button>
					<button type="button" onclick="findPwBtn();">비밀번호 찾기</button>
					<input type="submit" value="로그인" onclick="return check();">
					<button type="button" onclick="joinBtn();">회원가입</button>
				</div>
			</form>
		</c:if>
	</div>
</body>
<!-- 
<div class="container">
	<h1>로그인</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
			<c:if test="${sessionScope.id ==null || sessionScope.id == '' }">
				<form class="form-inline" method="post" action="/userLogin.do">
					<div class="form-group">
						<label for="user_id">아이디:</label> <input type="text"
							class="form-control" id="id" name="id">
					</div>
					<div class="form-group">
						<label for="password">Password:</label> <input type="password"
							class="form-control" id="password" name="password">
					</div>
					<button type="submit" class="btn btn-default"
						onclick="return check();">로그인</button>
				</form>
			</c:if>
		</div>
		<div class="panel-footer">
			<button type="button" onclick="joinBtn();">회원 가입</button>
			<button type="button" id="" onclick="findIdBtn();">학번 찾기</button>
			<button type="button" id="passBtn" onclick="findPwBtn();">비밀번호 찾기</button>
		</div>
	</div>

</div>
-->


</html>
