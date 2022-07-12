<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

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
	function add() {
		location.href = "<c:url value='/noticeMgmt.do'/>";
	}
	function view() {
		location.href = "<c:url value='/noticeView.do'/>";
	}
	function view(idx) {
		location.href = "<c:url value='/noticeView.do'/>?idx=" + idx;
	}
	function out() {
		location.href = "<c:url value='/userLogout.do'/>";
	}
	function page(pageNo) {
		location.href = "<c:url value='/noticeList.do'/>?pageIndex=" + pageNo;
	}
	function moveNotice() {
		location.href = "<c:url value='/noticeList.do'/>";
	}
	function moveMain() {
		location.href = "<c:url value='/mainList.do'/>";
	}
	function moveFreeBoard() {
		location.href = "<c:url value='/freeBoardList.do'/>";
	}
</script>
<style>
	img{
		display: inline;
	}
	#paging {
		text-align: center;
	}
</style>
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
		<h1 style="text-align:left">공지사항</h1>
		<div class="panel panel-default">
			<div class="panel-heading">
				<c:if test="${sessionScope.id !=null && sessionScope.id !='' }"> 
				${sessionScope.name }님 환영합니다
			<button type="button" class="btn btn-default" onclick="out();">로그아웃</button>
				</c:if>
			</div>
			<div class="panel-body">
				<form class="form-inline" method="post" action="/noticeList.do">
					<div class="form-group">
						<label for="searchKeyword">제목:</label> <input type="text"
							class="form-control" id="searchKeyword" name="searchKeyword">
					</div>
					<button type="submit" class="btn btn-default">검색</button>
				</form>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>게시물번호</th>
								<th>제목</th>
								<th>조회수</th>
								<th>댓글수</th>
								<th>등록자</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td><a href="javascript:view('${result.idx}');"><c:out
												value="${result.idx}" /></a></td>
									<td><a href="javascript:view('${result.idx}');"><c:out
												value="${result.title}" /></a></td>
									<td><c:out value="${result.count}" /></td>
									<td><c:out value="${result.reply}" /></td>
									<td><c:out value="${result.name}" /></td>
									<%--<td><c:out value="${result.indate }"/></td> --%>
									<td><fmt:formatDate value="${result.indate}"
											pattern="yyyy-MM-dd hh:mm:ss" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- /List -->
			<div id="paging">
				<ui:pagination paginationInfo="${paginationInfo}" type="image"
					jsFunction="page" />
				<!-- <form:hidden path="pageIndex" /> -->
			</div>
			<div class="panel-footer">
				<c:if test="${sessionScope.groupId == 'U01'}">
					<button type="button" class="btn btn-default" onclick="add();">등록</button>
				</c:if>
			</div>
		</div>
	</div>
</body>

</html>
