<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>스금커뮤 :: 회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width--device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/egovframework/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="./js/jquery-3.5.1.min.js"></script>
<script src="./css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

	function joinCheck(){
		document.qq.action = "<c:url value='/joins.do'/>";
		alert("가입을 환영합니다 ~_~")
		document.qq.submit();
	}
	
	$( document).ready(function(){
		<c:if test="${!empty msg}">
			alert("${msg}");
		</c:if>
		
		$("#btn_idCheck").click(function(){
			
			let id = $.trim($("#id").val());
			if (id == "") {
				alert("학번을 입력해주세요");
				$("#id").focus();
				return false;
			}

		
			 $.ajax({
				type:"POST",
				data:{"id" : id},
				url:"idCheck.do",
				dataType:"text",
				
				success: function(result){
					if (result == "ok") {
						alert("등록되지 않은 학번 입니다.");
					} else {
						alert("등록된 학번으로 회원가입이 가능합니다.");
					}
				},
				error: function() {
					 alert("오류발생");
				}
				
			 }) 
		
		})
		
		$("#btn_nicCheck").click(function(){
			
			 let nickname = $.trim($("#nickname").val());
			 if (nickname == "") {
				alert("닉네임을 입력해주세요");
				$("#nickname").focus();
				return false;
			 }

		
			 $.ajax({
				type:"POST",
				data:{"nickname" : nickname},
				url:"nicCheck.do",
				dataType:"text",
				
				success: function(result){
					if (result == "ok") {
						alert("사용 가능한 닉네임입니다.");
					} else {
						alert("이미 사용중인 닉네임입니다.");
					}
				},
				error: function() {
					 alert("오류발생");
				}
			
			 }) 
		
		 })
		
		
		$("#btn_jCheck").click(function(){
			
			 let id = $.trim($("#id").val());
			 if (id == "") {
				alert("학번을 입력해주세요");
				$("#id").focus();
				return false;
			 }

		
			 $.ajax({
				type:"POST",
				data:{"id" : id},
				url:"jCheck.do",
				dataType:"text",
				
				success: function(result){
					if (result == "ok") {
						alert("회원가입 가능한 학번입니다.");
					} else {
						alert("이미 회원가입한 학번입니다.");
					}
				},
				error: function() {
					 alert("오류발생");
				}
				
			 }) 
			 
		 })
		 
		 $("#btn_passCheck").click(function(){
      
		      let password = $.trim($("#password").val());
		      let pw = $("#password").val();
		      let num = pw.search(/[0-9]/g);
		      let eng = pw.search(/[a-z]/ig);
		      let spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		      
		      if (password == "") {
		         alert("비밀번호를 입력해주세요");
		         $("#password").focus();
		         return false;
		      } else if(pw.length < 8 || pw.length > 20){
		
		           alert("8자리 ~ 20자리 이내로 입력해주세요.");
		           $("#password").focus();
		      } else if(pw.search(/\s/) != -1){
		           alert("비밀번호는 공백 없이 입력해주세요.");
		           return false;
		          }else if(num < 0 || eng < 0 || spe < 0 ){
		           alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
		           return false;
		      } else {
		         alert("가능한 비밀번호 입니다."); 
		      }
  		 })
	})

</script>
<style>
	body {
		background-image: url('./images/egovframework/example/bgLogin.jpg');
	}
	.container {
		width: 720px;	
	}
	.container .inputBox {
		display: flex;
	}
	.container .inputBox .iconAndInputBox {
		position: relative;
		flex: auto;
		width: 100%;
		margin-right: 10px;
	}
	.container .inputBox .miniBtn {
		background: rgba(252, 177, 49, 1);
		border: none;
		width: 160px;
    	padding: 15px 5px;
    	color: #fff;
    	border-radius: 45px;
	}
	.container .inputBox .idBtnWidth {
		width: 120px;
		margin-right: 10px;
	}
	.container .confirmBtn {
		text-align: left;
	}
	.container .submitBox {
		text-align: center;
	}
	.container .inputBox button:hover {
		background: rgba(254, 102, 14, 1);
		transition: .3s;
		box-shadow: 1px 2px 6px gray;
	}
	@media(max-width: 720px){
		body {
			font-size: 13px;
		}
		.container {
			width: 80%;
			padding: 90px 20px;
		}
		.container .inputBox input {
			width: 100%;
		}
	}
	@media(max-width: 570px){
		.container {
			padding: 20px 13px;
		}
		.container h1 {
			padding-bottom: 0;
		}
		.container .inputBox .idBtnWidth {
			width: 150px !important;
		}
		.container .inputBox .miniBtn {
			width: 218px;
		}
	}
</style>
</head>
<body>
	<div class="bg"></div>
	<div class="container">
		<h1>회원가입</h1>
		<form name="formName" action="/joins.do" method="post">
			<div class="inputBox">
				<div class="iconAndInputBox">
					<span class="iconBox"><i class="fa-solid fa-user"></i></span>
					<input type="text" name="id" id="id" placeholder="학번을 입력해주세요">
				</div>
				<!-- <button type="button" id="btn_idCheck" class="miniBtn idBtnWidth">학번 확인</button> -->
				<button type="button" id="btn_jCheck" class="miniBtn">회원가입 확인</button>
			</div>
			<div class="inputBox">
				<span class="iconBox"><i class="fa-solid fa-key"></i></span>
				<input type="text" name="name" id="name" placeholder="이름을 입력해주세요">
			</div>
			<div class="inputBox">
				<span class="iconBox"><i class="fa-solid fa-key"></i></span>
				<input type="text" name="birth" id="birth" placeholder="생년월일을 입력해주세요 ex) 19950606">
			</div>
			<div class="inputBox confirmBtn">
				<div class="iconAndInputBox">
					<span class="iconBox"><i class="fa-solid fa-key"></i></span>
					<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요" required>
				</div>
				<button type="button" id="btn_passCheck" class="miniBtn">비밀번호 확인</button>
			</div>
			<div class="inputBox confirmBtn">
				<div class="iconAndInputBox">
					<span class="iconBox"><i class="fa-solid fa-key"></i></span>
					<input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해주세요" required>
				</div>
				<button type="button" id="btn_nicCheck" class="miniBtn nicknameBtnWidth">닉네임 중복 확인</button>
			</div>
			<div class="inputBox submitBox">
				<input type="submit" id="joinCheck" onclick="joinCheck()" value="가입하기">
			</div>
		</form>
	</div>
</body>

<!-- 

<body>

	<div class="container">
		<h1>회원가입</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<form class="form-horizontal" name="formName" action="/joins.do" method="post">

					<div class="form-group">
						<label for="id"> 학번 </label> 
						<input type="text" name="id" id="id">
						<button type="button" id="btn_idCheck">학번 확인</button>
						<button type="button" id="btn_jCheck">회원가입 확인</button>
					</div>
					<div class="form-group">
						<label for="name"> 이름 </label> 
						<input type="text" name="name" id="name">
					</div>
					<div class="form-group">
						<label for="birth"> 생년월일 </label> 
						<input type="text" name="birth" id="birth"> ex) 19950101
					</div>
					<div class="form-group">
						<label for="password"> 비밀번호 </label> 
						<input type="password" name="password" id="password" required>
						<button type="button" id="btn_passCheck">비밀번호 확인</button>
					</div>
					<div class="form-group">
						<label for="nickname"> 닉네임 </label> 
						<input type="text" name="nickname" id="nickname" required>
						<button type="button" id="btn_nicCheck">닉네임 중복 확인</button>
					</div>
					<div class="panel-footer">
						<button type="submit" id="joinCheck" onclick="joinCheck()">가입하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body> -->
</html>