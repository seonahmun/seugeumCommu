<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	pageContext.setAttribute("crcn", "\r\n"); // Space, Enter  
	pageContext.setAttribute("br", "<br/>"); // br태그
%>
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
		$("#name").attr("readonly", true);
		$("#indate").attr("readonly", true);
	})
	function add() {
		if ($("#writer").val() == '') {
			alert("작성자를 입력하세요");
			$("#writer").focus();
			return;
		}
		if ($("#reply").val() == '') {
			alert("댓글을 입력하세요");
			$("#title").focus();
			return;
		}

		if (!confirm("댓글을 작성하시겠습니까?")) {
			return;
		}

		document.formReply.action = "<c:url value='reply.do'/>";
		document.formReply.submit();
	}

	function cancel() {
		location.href = "<c:url value='/noticeList.do'/>";
	}

	function list() {
		location.href = "<c:url value='/noticeList.do'/>";
	}

	function modify() {
		location.href = "<c:url value='/noticeMgmt.do'/>?idx=${boardVO.idx}";
	}

	function del() {
		
		var cnt = ${ fn:length(resultList) };
		
		if( cnt > 0 ){
			alert("댓글이 있는 게시물은 삭제할 수 없습니다");
			return;
		}
		
		if (!confirm("삭제하시겠습니까?")) {
			return;
		}
		
		document.viewForm.action = "<c:url value='noticeMgmt.do'/>?mode=del&idx=${boardVO.idx}";
		document.viewForm.submit();
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
		<h1 style= "text-align :left">상세</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<label for="">${sessionScope.userName }</label>
			</div>
			<div class="panel-body">
				<form class="form-horizontal" method="post" action="/"
					name="viewForm" id="viewForm">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물아이디:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${boardVO.idx}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">제목:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${boardVO.title}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${boardVO.name}" />
							/
							<c:out value="${boardVO.indate}" />
						</div>
						<%-- <input type="text" class="form-control" id="indate" name="indate"
						placeholder="등록일을 입력하세요" maxLength="10"
						style="float: left; width: 40%"
						value="${fn:substring(boardVO.indate,0, fn:length(boardVO.indate)-2)}"> --%>

					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">내용:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${fn:replace(boardVO.contents, crcn, br)}"
								escapeXml="false" />
						</div>
					</div>
				</form>
			</div>
			<div class="panel-footer">
				<c:if test="${sessionScope.id == boardVO.writer}">
					<button type="button" class="btn btn-default" onclick="modify();">수정</button>
					<button type="button" class="btn btn-default" onclick="del();">삭제</button>
				</c:if>
				<button type="button" class="btn btn-default" onclick="list();">목록</button>
			</div>

		</div>

		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="well well-sm">
				<c:out value="${result.name}" />
				/
				<fmt:formatDate value="${result.indate}"
					pattern="yyyy-MM-dd hh:mm:ss" />
				<br />
				<c:out value="${fn:replace(result.reply, crcn, br)}"
					escapeXml="false" />
			</div>
		</c:forEach>


		<div class="well well-lg">
			<form class="form-horizontal" id="formReply" name="formReply"
				method="post" action="">
				<div class="form-group">
					<input type="hidden" name="idx" value="${boardVO.idx}" /> <input
						type="hidden" name="boardId" value="${sessionScope.boardId}" /> <input
						type="hidden" class="form-control" id="writer" name="writer"
						placeholder="등록자를 입력하세요" maxLength="15"
						style="float: left; width: 40%" value="${sessionScope.id}">
					<label class="control-label col-sm-2" for="pwd">작성자/작성일:</label>
					<div class="col-sm-10 control-label" style="text-align: left;">
						<input type="text" class="form-control" id="name" name="name"
							value="${sessionScope.name}" maxLength="15"
							style="float: left; width: 40%">
						<input type="text" class="form-control" id="indate" name="indate"
							placeholder="작성일을 입력하세요" maxLength="10"
							style="float: left; width: 40%" value="${strToday}">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">내용:</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="3" id="reply" name="reply"
							maxlength="300"></textarea>
					</div>
				</div>
				<button type="button" class="btn btn-default" onclick="add();">작성</button>
			</form>
		</div>
	</div>
	</div>
</body>

</html>
