<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		
		<title>조편성표 출력</title>

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

.group table {
    border-collapse: collapse;
}


.group table, th, td {
    border: 1px solid black;
}
		</style> 
<script type="text/javascript">
$.fn.rowspan = function(colIdx, isStats) {       
	return this.each(function(){      
		var that;     
		$('tr', this).each(function(row) {      
			$('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
				
				if ($(this).html() == $(that).html()
					&& (!isStats 
							|| isStats && $(this).prev().html() == $(that).prev().html()
							)
					) {            
					rowspan = $(that).attr("rowspan") || 1;
					rowspan = Number(rowspan)+1;

					$(that).attr("rowspan",rowspan);
					
					// do your action for the colspan cell here            
					$(this).hide();
					
					//$(this).remove(); 
					// do your action for the old cell here
					
				} else {            
					that = this;         
				}          
				
				// set the that if not already set
				that = (that == null) ? this : that;      
			});     
		});    
	});  
}; 

$(function() {

	<c:set var="byGroup" value="${fn:split(members, ';')}" />
	<c:set var="varStatus" value="1" />
	<c:forEach var="item" items="${byGroup}">
			<!-- table class="groupTable" style="border:0;width:300px" -->

		<c:set var="eachMember" value="${fn:split(item, ',')}" />
		<c:forEach var="member" items="${eachMember}">
			<c:set var="onlyMember" value="${fn:split(member, '/')}" />
			<c:if test="${fn:length(onlyMember) > 1}">
				<c:set var="groupName" value="${fn:replace(onlyMember[0], '{group_members=', '')}" />
				<c:set var="selectMember" value="${onlyMember[1]}" />
			</c:if>
			<c:if test="${fn:length(onlyMember) == 1}">
				<c:set var="selectMember" value="${onlyMember[0]}" />
			</c:if>
			
			<c:forEach var="item" items="${allMember}">
				<c:if test="${item.member_seq == selectMember}">
				var groupName = '${groupName}';
				 $('#group' + groupName.replace(/-[0-9]/g, '')).append('<tr><td>${groupName}</td><td>${item.region}</td><td>${item.name}</td></tr>');
				</c:if>
			</c:forEach>
		</c:forEach>
	</c:forEach>
	$('table').rowspan(0);
});
</script>
	<body>
<table style="border-collapse:collapse; border:1px gray solid;float:left" id="groupA">
</table>

<table style="border-collapse:collapse; border:1px gray solid;float:left;margin-left:10px;" id="groupB">
</table>

<table style="border-collapse:collapse; border:1px gray solid;float:left;margin-left:10px;" id="groupC">
</table>

<table style="border-collapse:collapse; border:1px gray solid;float:left;margin-left:10px;" id="groupD">
</table>
	</body>
</html>
