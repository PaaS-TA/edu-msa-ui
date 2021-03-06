<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Micro Service Architecture Board</title>
<script src="/js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
	$('#selectBtn').click(function(){
		$('#page').val("1");
		$.fn.search();
	});
	
	$('#writeBtn').click(function(){
		location.href = 'boardDetail';
	});
	
	$('#btnJoin').click(function(){
		location.href = 'user/join';
	});
	
	$('#btnLogin').click(function(){
		location.href = 'user/login';
	});
	
	$('#btnLogout').click(function(){
		location.href = 'user/logout';
	});

	$('#list').children('tr').click(function(){
		location.href = 'boardDetail?boardSeq=' + $(this).attr("boardSeq");
	});
	$.fn.drawPagination();
});

$.fn.drawPagination = function() {
	var page = $('#page').val();
	var lastPage = Math.ceil($('#count').val() / $('#pagePerCount').val());
	var startPage = 1;
	
	
	if(page > 2) {
		startPage = page - 2;
	}
	
	var html = "<span class=\"firstPage\">&laquo;</span>";
	for(var i = startPage ; i < startPage + 5 && i <= lastPage; i++) {
		html += "<span class=\"numberPage " + (i==page?"selected":"") + "\">" + i + "</span>";
	}
	html += "<span class=\"lastPage\">&raquo;</span>";
	
	$('.pagination').html(html);
	$('.pagination').children('.numberPage').click(function(){
		$('#page').val($(this).text());
		$.fn.search();
	});
	$('.pagination').children('.firstPage').click(function(){
		$('#page').val("1");
		$.fn.search();
	});
	$('.pagination').children('.lastPage').click(function(){
		$('#page').val(lastPage);
		$.fn.search();
	});
	
	if(page > lastPage) {
		$('#page').val("1");
		$.fn.search();
	}
}
$.fn.search = function() {
	$.ajax({
	    url:'./boardJSON',
        type:'get',
        data:$('#search').serialize(),
	    success:function(data){
	    	var result = data.resultData;
	    	$('#countText').text(result.boardCount);
	    	$('#count').val(result.boardCount);
	    	
	    	var tableList = "";
	    	if(result.boardCount > 0) {
	    		var list = result.boardList;
		    	for(var i=0;i<list.length;i++) {
		    		tableList += "<tr boardSeq=\"" + list[i].boardSeq + "\">";
		    		tableList += "<td class=\"center\">" + list[i].boardNo +  "</td>";
		    		tableList += "<td>" + list[i].boardTitle + "</td>";
		    		tableList += "<td class=\"center\">" + list[i].writeUserName + "</td>";
		    		tableList += "<td class=\"center\">" + list[i].createDt + "</td>";
		    		tableList += "</tr>";
		    	}
			} else {
				tableList = "<tr>"
					+ "<td class=\"center\" colspan=\"4\">???????????? ???????????? ????????????.</td>"
					+ "</tr>";
			}
	    	
	    	$('#list').html(tableList);
	    	
	    	$('#list').children('tr').click(function(){
	    		location.href = 'boardDetail?boardSeq=' + $(this).attr("boardSeq");
	    	});
	    	$.fn.drawPagination();
	    }
	});
}
</script>
<style type="text/css">
html, body {
	margin: 0;
	padding: 0;
	height: 100%;
}

div.header {
	margin: 0;
	padding: 0;
	height: 15%;
}

div.body {
	margin: 0;
	padding: 0;
	height: 70%;
	margin: 0% 15%;
	/* 	background-color: #EEEEEE; */
}

div.footer {
	margin: 0;
	padding: 0;
	height: 15%;
}

table {
	margin: 0;
	padding: 0;
	border: 0px;
    border-collapse: collapse;
	width: 100%;
	border-top: solid 2px;
	border-bottom: solid 2px;
}

table thead {
	height: 30px;
	border-top: solid 1px;
	border-bottom: solid 1px #404040;
}

table tbody tr {
	border-bottom: solid 1px #DDDDDD;
	height: 30px;
}

.searchArea {
	text-align: right;
	padding: 3px;
}

/* ????????? ????????? ?????? */
.pagination {
	width: 100%;
	text-align: center;
	margin: 1% 0;
}

.pagination span {
	color: black;
	padding: 4px 8px;
	cursor: pointer;
	text-decoration: none;
}

.pagination .selected {
	font-weight: bold !important;
}
/* ????????? ????????? ?????? */

/* selectbox ????????? ??????*/
select {

    -webkit-appearance: none;  /* ???????????? ?????? ????????? */
    -moz-appearance: none;
    appearance: none;
    
    width: 70px; /* ????????? ???????????? */
    padding: .3em .5em; /* ???????????? ?????? ?????? */
    font-family: inherit;  /* ?????? ?????? */
    background: url('/images/select_icon.jpg') no-repeat 95% 50%; /* ???????????? ???????????? ????????? ???????????? ?????? */
    border: 1px solid #999;
    border-radius: 0px; /* iOS ??????????????? ?????? */
    -webkit-appearance: none; /* ???????????? ?????? ????????? */
    -moz-appearance: none;
    appearance: none;
    
}

/* IE 10, 11??? ???????????? ????????? ????????? */
select::-ms-expand {
    display: none;
}
/* selectbox ????????? ??????*/

/* input ????????? ??????*/
input[type=text] {
    -webkit-appearance: none;  /* ???????????? ?????? ????????? */
    -moz-appearance: none;
    appearance: none;
    
    width: 150px; /* ????????? ???????????? */
    padding: .3em .5em; /* ???????????? ?????? ?????? */
    font-family: inherit;  /* ?????? ?????? */
    border: 1px solid #999;
    border-radius: 0px; /* iOS ??????????????? ?????? */
    -webkit-appearance: none; /* ???????????? ?????? ????????? */
    -moz-appearance: none;
    appearance: none;
}
/* input ????????? ??????*/

.button {
    -webkit-appearance: none;  /* ???????????? ?????? ????????? */
    -moz-appearance: none;
    appearance: none;
    font-family: inherit;  /* ?????? ?????? */
    font-size: 0.85em;
    border: 1px solid #999;
    padding: .3em .5em; /* ???????????? ?????? ?????? */
    border-radius: 0px; /* iOS ??????????????? ?????? */
    -webkit-appearance: none; /* ???????????? ?????? ????????? */
    -moz-appearance: none;
    appearance: none;
	background-color: #EEEEEE;
	cursor: pointer;
}

.left {
	text-align: left;
}
.right {
	text-align: right;
}
.center {
	text-align: center;
}
</style>

</head>
<body>
	<div class="header" style="text-align: right; padding: 3px;">
		<c:if test="${session.session_id.value eq null}">
			<span id="btnJoin" style="float:left;" class="button">????????????</span>
			<span id="btnLogin" style="float:left;" class="button">?????????</span>
		</c:if>
		<c:if test="${session.session_id.value ne null}">
			<span id="btnLogout" style="float:left;" class="button">????????????</span>
		</c:if>
 	</div>
	<div class="body">
		<article>
			<form id="search"  action="javascript:return false;">
				<div class="right"><span>??? <span id="countText">${resultData.boardCount}</span>??? ?????????????????????.</span></div>
				<input type="hidden" id="count" value="${resultData.boardCount}">
				<input type="hidden" id="page" name="page" value="${resultData.page}">
				<input type="hidden" id="pagePerCount" name="pagePerCount" value="${resultData.pagePerCount}">
				<table>
					<thead>
						<tr>
							<th style="width:10%;">??????</th>
							<th style="width:60%;">??????</th>
							<th style="width:10%;">?????????</th>
							<th style="width:20%;">?????????</th>
						</tr>
					</thead>
					<tbody id="list">
						<c:choose>
							<c:when test="${resultData.boardCount eq '0'}">
								<tr>
									<td class="center" colspan="4">???????????? ???????????? ????????????.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="row" items="${resultData.boardList}" varStatus="status">
									<tr boardSeq="${row.boardSeq}">
										<td class="center">${row.boardNo}</td>
										<td>${row.boardTitle}</td>
										<td class="center">${row.writeUserName}</td>
										<td class="center">${row.createDt}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="searchArea">
					<select name="searchType">
						<option value="boardTitle">??????</option>
						<option value="boardText">??????</option>
						<option value="writeUserName">?????????</option>
					</select>
					<input type="text" name="searchValue" onKeypress="javascript:if(event.keyCode==13) {$.fn.search();}"/>
					<span id="selectBtn" class="button">??????</span>
					<c:if test="${session.session_id.value ne null}">
						<span id="writeBtn" class="button">??????</span>
					</c:if>
				</div>
				<div id="pagination" class="pagination" page=""></div>
			</form>
		</article>
	</div>
	<div class="footer"></div>
</body>
</html>
