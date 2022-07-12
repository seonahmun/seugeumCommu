<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>스금커뮤 :: 공지사항</title>
<meta charset="utf-8">
<meta name="viewport" content="width--device-width, initial-scale=1">
<link rel="stylesheet" href="./css/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="./css/egovframework/board.css">
<script src="./js/jquery-3.5.1.min.js"></script>
<script src="./css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
	$(document).ready(function() {
		$("#idx").attr("readonly", true);
		$("#name").attr("readonly", true);
		$("#indate").attr("readonly", true);

		// 등록/수정 btn 노출
		if($("#title").val() == ""){
			$("#modifyBtn").css({"display":"none"});
		} else {
			$("#addBtn").css({"display":"none"});
		}
		
	})

	function cancel() {
		location.href = "<c:url value='/noticeList.do'/>";
	}

	function add() {
		if ($("#title").val() == '') {
			alert("제목을 입력하세요");
			$("#title").focus();
			return;
		}
		if ($("#contents").val() == '') {
			alert("내용을 입력하세요");
			$("#contents").focus();
			return;
		}
		if (!confirm("등록하시겠습니까?")) {
			return;
		}

		document.boardRegForm.action = "<c:url value='noticeMgmt.do'/>?mode=add";
		document.boardRegForm.submit();
	}

	function modify() {
		if ($("#title").val() == '') {
			alert("제목을 입력하세요");
			$("#title").focus();
			return;
		}
		if ($("#contents").val() == '') {
			alert("내용을 입력하세요");
			$("#contents").focus();
			return;
		}
		if (!confirm("수정 하시겠습니까?")) {
			return;
		}
		document.boardRegForm.action = "<c:url value='noticeMgmt.do'/>?mode=modify";
		document.boardRegForm.submit();
	}
	function moveMain() {
		location.href = "<c:url value='/mainList.do'/>";
	}
	function moveNotice() {
		location.href = "<c:url value='/noticeList.do'/>";
	}
	function moveFreeBoard() {
		location.href = "<c:url value='/freeBoardList.do'/>";
	}
</script>
</head>
<body>
	<section class="author-archive">
		<div class="container">
			<h1><img src="./images/egovframework/example/logo.png"></h1>
			<input type="radio" id="All" name="categories" value="HOME" checked
				onclick="moveMain();"> <input type="radio" id="CSS"
				name="categories" value="공지사항" onclick="moveNotice();"> <input
				type="radio" id="JavaScript" name="categories" value="자유게시판"
				onclick="moveFreeBoard();">
			<ol class="filters">
				<li><label for="All">HOME</label></li>
				<li><label for="CSS">공지사항</label></li>
				<li><label for="JavaScript"><c:out value="${freeBoardName}" /></label></li>
			</ol>
		</div>
	</section>
	<div class="container">
		<h1 style="text-align:left"> 
			<c:out value="${mgmtMode}" />
		</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				
			</div>
			<div class="panel-body">
				<form class="form-horizontal" id="boardRegForm" name="boardRegForm"
					method="post" action="/">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물아이디:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="idx" name="idx"
								placeholder="자동발번" value="${boardVO.idx }">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">제목:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="title" name="title"
								placeholder="제목을 입력하세요" maxLength="100"
								value="${boardVO.title }">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">게시판 종류:</label> <input
							type="hidden" class="form-control" id="boardId" name="boardId"
							placeholder="등록자를 입력하세요" maxLength="15"
							style="float: left; width: 40%" value="${sessionScope.boardId}">
						<input type="hidden" class="form-control" id="writer"
							name="writer" placeholder="등록자를 입력하세요" maxLength="15"
							style="float: left; width: 40%" value="${sessionScope.id}">
						<input type="text" class="form-control" id="name" name="name"
							placeholder="등록자를 입력하세요" maxLength="15"
							style="float: left; width: 40%" value="${sessionScope.name}">
						<%-- <input type="text" class="form-control" id="indate" name="indate"
						placeholder="등록일을 입력하세요" maxLength="10"
						style="float: left; width: 40%"
						value="${fn:substring(boardVO.indate,0, fn:length(boardVO.indate)-2)}"> --%>
						<c:set var="indate" value="${boardVO.indate}" />
						<c:if test="fn:length(indate >9)">
							<c:set var="indate"
								value="${fn:substring(indate,0, fn:length(indate)-2) }" />
						</c:if>
						<input type="text" class="form-control" id="indate" name="indate"
							placeholder="등록일을 입력하세요" maxLength="10"
							style="float: left; width: 40%" value="${indate}">

					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">내용:</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="5" id="contents"
								name="contents" maxlength="1000">${boardVO.contents }</textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="panel-footer">

				<button type="button" class="btn btn-default" onclick="add();" id="addBtn">등록</button>
				<button type="button" class="btn btn-default" onclick="modify();" id="modifyBtn">수정</button>
				<button type="button" class="btn btn-default" onclick="cancel();">취소</button>

			</div>

		</div>
	</div>
	
</body>

</html>
