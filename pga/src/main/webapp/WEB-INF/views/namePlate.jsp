<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		
		<title>이름표 출력</title>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script> 
	<body>
<table border="0">
<tr>
<td>
<c:set var="byGroup" value="${fn:split(groupMembers, ';')}" />
<c:set var="varStatus" value="1" />
<c:forEach var="item" items="${byGroup}">
	<c:set var="eachMember" value="${fn:split(item, ',')}" />
	<c:forEach var="member" items="${eachMember}">
		<c:set var="onlyMember" value="${fn:split(member, '/')}" />
		<c:if test="${fn:length(onlyMember) > 1}">
			<c:set var="groupName" value="${onlyMember[0]}" />
			<c:set var="selectMember" value="${onlyMember[1]}" />
		</c:if>
		<c:if test="${fn:length(onlyMember) == 1}">
			<c:set var="selectMember" value="${onlyMember[0]}" />
		</c:if>
		
		<c:forEach var="item" items="${allMember}">
			<c:if test="${item.member_seq == selectMember}">
				<table background="/static/images/nameplate_bg.png" border="0" style="width: 360px;height: 215px;margin-top:5px;margin-left:5px;float:left">
					<tr style="height:40px">
						<td style="text-align:center"><font style="font-size:20px;font-weight:bold">${game.game_name}</font></td>
					</tr>
					<tr>
						<td style="height:44px;font-size:30px;font-weight:bold">${fn:replace(groupName, '{group_members=', '')} ${item.region}</td>
					</tr>
					<tr>
						<td style="font-size:60px;font-weight:bold;text-align:center;vertical-align: text-top;" valign="top">${item.name}</td>
					</tr>
					<tr>
						<td style="height:25px;"></td>
					</tr>
				</table>
			<c:if test="${varStatus != 0 && varStatus mod 2 == 0}">
			</td>
			</tr>
			<tr>
			<td>
			<c:if test="${varStatus mod 6 == 0}">
			<p style="page-break-after:always;"></p>
			</c:if>
			</c:if>
			<c:set var="varStatus" value="${varStatus + 1}" />
			</c:if>
		</c:forEach>
		
	</c:forEach>
</c:forEach>
</table>
	</body>
</html>
