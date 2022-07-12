<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>스금커뮤 :: 비밀번호 찾기</title>
<meta charset="utf-8">
<meta name="viewport" content="width--device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/egovframework/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="./js/jquery-3.5.1.min.js"></script>
<script src="./css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
	function check() {
		if ($("#name").val() == "") {
			alert("이름을 입력하세요");
			return false;
		}
		if ($("#id").val() == "") {
			alert("학번을 입력하세요");
			return false;
		}
		if ($("#id").val().length != 5) {
			alert("학번을 확인하세요" );
			return false;
		}
	
		
		return true;
	}
	
	function findId() {
		location.href = "<c:url value='/findId.do'/>";
	}
	function login() {
		location.href = "<c:url value='/login.do'/>";
	}
	$(document).ready(function(){
		<c:if test="${!empty id}">
		alert("학번은 ${id}");
		
		</c:if>
	})
	$(document).ready(function(){
		<c:if test="${!empty msg}">
		alert("${msg}");
		
		</c:if>
	})
	
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
		<h1>비밀번호 찾기</h1>
		<form action="/userFindPw.do" method="post">
			<div class="inputBox">
				<span class="iconBox"><i class="fa-solid fa-file-signature"></i></span>
				<input type="text" name="name" id="name" placeholder="이름을 입력해주세요">
			</div>
			<div class="inputBox">
				<span class="iconBox"><i class="fa-solid fa-user"></i></span>
				<input type="text" name="id" id="id" placeholder="학번을 입력해주세요">
			</div>
			<div class="inputBox confirmBtn">
				<input type="submit" id="findSubmitBtn" onclick="return check();" value="확인">
				<button type="button" onclick="findId();">학번 찾기</button>
				<button type="button" onclick="login();">로그인</button>
			</div>
		</form>
	</div>
</body>

<!-- 
<div class="container">
	<h1>비밀번호 찾기</h1>
	<div class="panel panel-default">
		<div class="panel-heading">
			<form class="form-horizontal" method="post" action="/userFindPw.do"> 
				<div class="form-group">
					<label for="name">이름:</label> 
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요">
				</div>
				<div class="form-group">
					<label for="id">학번:</label> 
					<input type="text" class="form-control" id="id" name="id" placeholder="학번을 입력하세요">
				</div>
				<button type="submit" class="btn btn-default" onclick="return check();">확인</button>
				<button type="button" class="btn btn-default" onclick="findId();">학번 찾기</button>
				false인 경우 로그인 폼의 action이 수행되지 않게하기 위해 return
			</form>
		</div>
	</div>
</div> -->
</html>