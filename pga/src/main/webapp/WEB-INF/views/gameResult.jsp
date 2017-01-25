<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<style type="text/css">
.holeGrade {
	width: 30px;
	-webkit-appearance: none; 
	margin: 0; 
}
input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    margin: 0; 
}
</style>
</head>
<body>
<select name="gameId">
	<c:forEach var="item" items="${games}">
		<option value="${item.game_id}">${item.game_name}</option>
	</c:forEach>
</select>
<table border="1">
<tr>
<td>1홀</td>
<td>2홀</td>
<td>3홀</td>
<td>4홀</td>
<td>5홀</td>
<td>6홀</td>
<td>7홀</td>
<td>8홀</td>
<td>9홀</td>
</tr>
<tr>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
<td><input type="number" class="holeGrade"></td>
</tr>
</table>
</body>
</html>
