<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>스금커뮤 :: 비밀번호 변경</title>
<meta charset="utf-8">
<meta name="viewport" content="width--device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/egovframework/login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="./js/jquery-3.5.1.min.js"></script>
<script src="./css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
   
   $( document).ready(function(){
      <c:if test="${!empty msg}">
      alert("${msg}");   
      </c:if>
      
      $("#id").attr("readonly", true);
      
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

      function check() {
        
        let password = $.trim($("#password").val());
         let pw = $("#password").val();
         let num = pw.search(/[0-9]/g);
         let eng = pw.search(/[a-z]/ig);
         let spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
       
    
      if ($("#password").val() == "") {
         $("#password").focus();
            alert("비밀번호를 입력해주세요.");
            return false;
      }   
      else if ($("#changePwCheck").val() == "") {
            $("#changePwCheck").focus();
            alert("비밀번호를 한번 더 입력해주세요");
            return false;
   
       } 
      else if ($("#password").val() != $("#changePwCheck").val() || $("#password").val().length != $("#changePwCheck").val().length) {
            alert("비밀번호가 일치하지않습니다.");
            return false;
       } 
      else if(pw.length < 8 || pw.length > 20){
              alert("8자리 ~ 20자리 이내로 입력해주세요.");
              $("#password").focus();
              return false;
       } 
      else if(pw.search(/\s/) != -1){
              alert("비밀번호 확인을 진행해주세요."); 
              return false;
       }else if(num < 0 || eng < 0 || spe < 0 ){
              alert("비밀번호 확인을 진행해주세요.");
              return false;
       } 
      else if ( $("#password").val() != $("#changePwCheck").val() ){
            alert("변경 비밀번호가 일치하지 않습니다.");
            $("#password").focus();
            $("#changePwCheck").focus();
            return false;
      }
      else{
         alert("비밀번호가 변경되었습니다.");
         document.modifyForm.action = "<c:url value='userChangePw.do'/>"
         document.modifyForm.submit();
         return true;
      }
      /* else if ( $("#password").val() == $("#changePwCheck").val()  ) {
         alert("비밀번호가 변경되었습니다.");
         document.modifyForm.action = "<c:url value='userChangePw.do'/>"
         document.modifyForm.submit();
         return true;
      } */
      

   }

</script>
<style>
   body {
      background-image: url('./images/egovframework/example/bgLogin.jpg');
   }
   .container .inputBox {
      display: flex;
   }
   .container .inputBox #id {
      background-color: lightgray;
   }
   .container .inputBox #id:hover {
      box-shadow: none;
   }
   .container .inputBox #btn_passCheck {
      background: rgba(252, 177, 49, 1);
      border: none;
      width: 108px;
       padding: 15px 5px;
       color: #fff;
   }
   .container .inputBox .iconAndInputBox {
      position: relative;
      flex: auto;
      width: 100%;
      margin-right: 10px;
   }
   .container .inputBox #btn_passCheck:hover {
      background: rgba(254, 102, 14, 1);
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
      <h1>비밀번호 변경</h1>
      <form action="/userChangePw.do" method="post" id="modifyForm" name="modifyForm">
         <div class="inputBox">
            <span class="iconBox"><i class="fa-solid fa-file-signature"></i></span>
            <input type="text" name="id" id="id" value="${id}">
         </div>
         <div class="inputBox">
            <div class="iconAndInputBox">
               <span class="iconBox"><i class="fa-solid fa-key"></i></span>
               <input type="password" name="password" id="password" placeholder="새 비밀번호를 입력해주세요" class="inputPassword">
            </div>
            <input type="button" id="btn_passCheck" value="비밀번호 확인">
         </div>
         <div class="inputBox">
            <span class="iconBox"><i class="fa-solid fa-key"></i></span>
            <input type="password" name="changePwCheck" id="changePwCheck" placeholder="변경 비밀번호를 한 번 더 입력해주세요">
         </div>
         <div class="inputBox confirmBtn">
            <input type="submit" id="findSubmitBtn" onclick="return check();" value="확인">
         </div>
      </form>
   </div>
</body>

 <%-- <div class="container">
   <h1>비밀번호 수정</h1>
   <div class="panel panel-default">
   
      <div class="panel-heading">
         
         <form class="form-horizontal" method="post" id="modifyForm" name="modifyForm" action="/userChangePw.do"> 
         
            <div class="form-group">
            
               <label for="name">학번:</label>       
               <input type="text" class="form-control" id="id" name="id" value="${id}" >
            </div>
            <div class="form-group">
            
               <label for="id">변경 비밀번호:</label> 
               <input type="password" class="form-control" id="password" name="password" placeholder="새 비밀번호를 입력하세요">
               <button type="button" id="btn_passCheck">비밀번호 확인</button>
               
            </div>
            <div class="form-group">
               <label for="id">변경 비밀번호 확인:</label> 
               <input type="password" class="form-control" id="changePwCheck" name="changePwCheck" placeholder="새 비밀번호를 입력하세요">
            </div>
            
            <button type="submit" class="btn btn-default" onclick="return check();">확인</button> 
            
            <!-- false인 경우 로그인 폼의 action이 수행되지 않게하기 위해 return -->
         </form>
         
      </div>
   </div>
</div>   --%>
</html>