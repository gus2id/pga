<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		
		<title>script.aculo.us의 Sortable</title>
		<style type="text/css">
		body{background-color:#1b2d3d;color:#fff;font-size:12px}div.container{width:300px;min-height:100px;background-color:#324d65;margin-left:50px;float:left}div.widjet{width:250px;background-color:#d0e95d;min-height:100px;color:#000;margin-top:12px}div.widjet .handler{width:250px;background-color:#98b125;min-height:20px;color:#000;cursor:move}.dummyDestinationStyle{border:3px dashed silver;margin-top:12px;position:absolute}#message{width:500px;background-color:#a2a2a2;min-height:100px;color:#000;margin-left:50px;margin-top:50px}
		.group {
			min-height:50px !important;
		}
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script> 
		<script src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js"></script> 
		<script src="http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/effects.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/dragdrop.js"></script>

		<script type="text/javascript">
jQuery.noConflict();
var j$ = jQuery;

var dragoption = {
    tag: 'div',
    handle: 'handler',
    constraint: false,
    containment: ['container1'],
    dropOnEmpty: true,
    delay: 300,
    scroll: window,
    onUpdate: function(tab) {
        if ($("dummyDestinationDiv")) {
            $("dummyDestinationDiv").remove();
        }
        showMessage();
    },
    onChange: function(elem) {
        if ($("dummyDestinationDiv")) {
            $("dummyDestinationDiv").remove();
        }
        elem.insert({
            before: '<div id="dummyDestinationDiv" class="dummyDestinationStyle" style="width:' + (elem.getWidth() - 7) + 'px; height:' + (elem.getHeight() - 15) + 'px;"></div>'
        });
    }
}

function showMessage() {
    $("message").update("container1 : " + Sortable.serialize('container1') + "<br/>container2 : " + Sortable.serialize('container2'));
}
document.observe('dom:loaded', function() {
    Sortable.create('container1', dragoption);
    Sortable.create('container2', dragoption);
    Sortable.create('container3', dragoption);
    console.log(j$('#container2').length)
	$("groupCount").observe('change', function() {
		var count = $('groupCount').value;
		var maxCount = 10;
        count = count;
		for (var index = 0; (index) < maxCount; index++) {
			if (j$('#container' + (index + 2)).length > 0) {
				j$('#container' + (index + 2)).hide();
			}
		}
		for (var index = 0; (index) < count; index++) {
			if (j$('#container' + (index + 2)).length > 0) {
				j$('#container' + (index + 2)).show();
			}
		}
    });
});
		</script>
	</head>
	<body>
		<div id="container1" class="container">
			<c:forEach var="item" items="${member}" varStatus="status">
			<div id="out_${status.count}">
				<div class="handler">${item.name}</div>
			</div>
			</c:forEach>
		</div>
		<select id="groupCount">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
		</select>
		<div id="container2" class="container group">
			<div>A 조</div>
		</div>
		<div id="container3" class="container group" style="display:none;">
			<div>B 조</div>
		</div>
		<div id="container4" class="container group" style="display:none;">
			<div>C 조</div>
		</div>
		<div id="container5" class="container group" style="display:none;">
			<div>D 조</div>
		</div>
		<div id="container6" class="container group" style="display:none;">
			<div>E 조</div>
		</div>
		<div id="container7" class="container group" style="display:none;">
			<div>F 조</div>
		</div>
		<div id="container8" class="container group" style="display:none;">
			<div>G 조</div>
		</div>
		<div id="container9" class="container group" style="display:none;">
			<div>H 조</div>
		</div>
		<div id="container10" class="container group" style="display:none;">
			<div>I 조</div>
		</div>
		<div style="clear:both;"></div>
		<div id="message">
			
		</div>
	</body>
</html>
