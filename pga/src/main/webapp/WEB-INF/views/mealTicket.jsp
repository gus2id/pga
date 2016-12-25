<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		
		<title>식권 출력</title>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
		<style type="text/css">
		
@media print
{
  table { page-break-after:auto }
  tr    { page-break-inside:avoid; page-break-after:auto }
  td    { page-break-inside:avoid; page-break-after:auto }
  thead { display:table-header-group }
  tfoot { display:table-footer-group }
}
		</style> 
	<body>

<table>
<tr>
<c:forEach var="item" begin="1" end="${count}" varStatus="varStatus">
	<td style="page-break-after:always;">
		<table style="border:1px solid black;width:300px">
			<tr>
				<td>제 ${param.date}-<fmt:formatNumber value="${varStatus.count}" minIntegerDigits="3"/></td>
			</tr>
			<tr>
				<td>${param.top}</td>
			</tr>
			<tr>
				<td align="center">${param.left} <img src="/static/images/mark.png" /> ${param.right}</td>
			</tr>
			<tr>
				<td align="center">${param.bottom}</td>
			</tr>
			<tr>
				<td align="center">${param.host}</td>
			</tr>
		</table>
	</td>
<c:if test="${varStatus.index mod 3 == 0}">
</tr>
<tr>
</c:if>
</c:forEach>
</tr>
</table>
	</body>
</html>
