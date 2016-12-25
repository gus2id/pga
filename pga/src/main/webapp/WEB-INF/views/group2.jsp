<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		
		<title>그룹편성</title>
		<style type="text/css">
ul{
    list-style:none;
    padding:0;
    height:55px;
    
}
.groupContainer {
    float:left;
    margin:10px;
    border:1px solid black;
    min-width:40%;
    
}
#groupContainer div {
	height: 150px;
}
		</style>
		<link rel="stylesheet" href="/static/js/message-box/messagebox.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script> 
		<script src="/static/js/jquery-ui.min.js"></script>
		<script src="/static/js/message-box/messagebox.min.js"></script>
		<script type="text/javascript">
		$(function() {
			/*
			//$("#all-member").sortable({
			//	connectWith: "#selected-member"
			//});
			$("#selected-member").sortable({
		    	connectWith: ".group",
		    	stop: function() {
		    		alert('a')
		    		$('#selected-member .btnAdd').hide();
		    	}
			});
			*/
			var clickedButton;
			$('#selected-member').on('click', '.btnAdd', function() {
				clickedButton = $(this);
				//$('#addMemberPopup').offset({ top: 0, left: 0});
				$('#addMemberPopup').empty();
				$('#addMemberPopup').animate({
				    left: clickedButton.offset().left,
				    height: "toggle",
				    top: clickedButton.offset().top
				  }, 1, function() {
				    // Animation complete.
						$('#addMemberPopup').show();
						$('#groupContainer input[type=text]:visible').each(function(index) {
							if (index % 7 == 0 && index != 0) {
								$('#addMemberPopup').append('<button>' + $(this).val() + '</button><br> ');
							} else {
								$('#addMemberPopup').append('<button>' + $(this).val() + '</button> ');
							}
						});
				  });
				// $('#addMemberPopup').offset({ top: clickedButton.offset().top, left: clickedButton.offset().left});
				
			});
			
			$('#addMemberPopup').on('click', 'button', function() {
				var ul = $('#groupContainer input[value=' + $(this).text() + ']').parents('.eachGroup').find('ul');
				if (ul.find('li').length >= 4 && confirm('4명을 초과합니다. 그래도 추가하시겠습니까?')) {
					var $li = clickedButton.parent();
					$li.find('input[type=button]').hide();
					ul.append($li);
					$('#addMemberPopup').hide();
				}
				
				if (ul.find('li').length < 4) {
					var $li = clickedButton.parent();
					$li.find('input[type=button]').hide();
					ul.append($li);
					$('#addMemberPopup').hide();
				}
				return false;
			})
			$(".group").sortable();
			$('#random').click(function() {
				$('#selected-member li').each(function() {
					var loopCount = 0;
					while (1 == 1) {
						loopCount++;
						var x = Math.floor(Math.random() * ($('#groupContainer ul:visible').length + 1));
						if ($('.group:visible').find('li').length == $('.group').length * 4) {
							addGroup();
						}
						if ($('.group:visible').eq(x - 1).find('li').length == 4) {
							continue;
						}
						var currentText = $(this).text().split('|')[2];
						if ($('.group:visible').eq(x - 1).text().indexOf(currentText) > -1) {
							if (loopCount > 1000) {
								loopCount = 0;
								addGroup();	
							}
							continue;
						}
						$(this).find('input[type=button]').hide();
						$('.group:visible').eq(x - 1).append($(this));
						
						break;
					}
				});
				return false;
			});
			$('#btnSave').click(function() {
				$('input[name=groupMembers]').val('');
				$('#groupContainer div').each(function() {
					if ($(this).is(':visible')) {
						var groupName = $(this).find('[name=groupName]').val();
						var count = $(this).find('li .userSeq').length;
						var userSeq = "";
						for (var index = 0;index < count; index++) {
							userSeq += $(this).find('li .userSeq').eq(index).text() + ",";
						}
						
						//  
						// A/1,2,3;B/4,5,6
						$('input[name=groupMembers]').val($('input[name=groupMembers]').val() + groupName + '/' + userSeq + ';');
					}
				});
				$('.groupContainer ul .userSeq').text()
				
				if ($('[name=gameId]').val() == '') {
					$.MessageBox({
						  input    : true,
						  message  : "대회명을 입력해주세요."
						}).done(function(data){
							$('#gameName').val(data);
							
							$.ajax({
								url: '/group/save',
								data: $('form').serialize() 
							});
						});
					return false;
				} else {
					$('#gameName').val($("[name=gameId] option:selected").text());
					$.ajax({url: '/group/save',
						data: $('form').serialize()
					});
				}
				return false;
			});
			$('#all-member').on('click', '.btnAdd', function() {
				var $li = $(this).parents('li');
				$('#selected-member').append($li);
				// $('#selected-member .btnAdd').hide();
				$('#selected-member .remove').show();
				// $li.remove();
			});
			$('[name=region]').change(function() {
				$.ajax({url: '/group/search', 
					data: {region: $(this).val()},				
					success: function(result) {
						$('#all-member').empty();
						for (var index = 0, count = result.member.length; index < count; index++) {
							var item = result.member[index];
							$('#all-member').append('<li><span class="userSeq" style="display:none;" userSeq="' + item.member_seq + '">' + item.member_seq + '</span>' + item.name +  ' | ' + item.club_name + ' | ' + item.region + ' <span class="remove" style="display:none;">x</span> <input type="button" class="btnAdd" value="Add"></li>');
						}
				}});
			});
			
			$('#btnNamePlate').click(function() {
				location.href = 'namePlate?gameId=' + $('[name=gameId]').val();
				return false;
			});
			
			$('#btnMealTicket').click(function() {
				$('[name=count]').val($('#groupContainer li').length);
				$('#mealTicketTemplate').center();
				$('#mealTicketTemplate').show();
				/*
				$.MessageBox({
					  input    : true,
					  message  : "식권 개수를 입력해주세요."
					}).done(function(data){
						$('#gameName').val(data);
						
						location.href = 'mealTicket?gameId=' + $('[name=gameId]').val() + '&count=' + data + '&date=2016.12.20&top=파크골프&left=식&right=권&bottom=맛있게드세요&host=대구광역시%20파크골프협회';
					});
				*/
				return false;
			});
			$('#mealTicketTemplate input[type="button"]').click(function() {
				location.href = 'mealTicket?' + $('form').serialize();
			})
			
			$('#groupTypeCount').change(function() {
				$('#groupContainer li').each(function() {
					$('#all-member').append($(this));
				});
				$('#groupContainer').empty();
				for (var index = 0, count = $('#groupTypeCount').val().split("").length; index < count; index++) {
					addGroup();
				}
			});
			
			$('[name=gameId').change(function() {
				$.ajax({url:'/ajax/group?gameId=' + $(this).val(), 
						success: function(result) {
							$('#groupContainer').empty();
							$('#gameName').val($("[name=gameId] option:selected").text());
							var allMembers = result.member;
							if (result.groupMembers) {
								var groupMembers = result.groupMembers[0].group_members;
								var groupMember = groupMembers.split(';');
								for (var index = 0, count = groupMember.length; index < count; index++) {
									var group = groupMember[index].split('/')[0];
									var members = groupMember[index].split('/')[1];
									
									if (group != "") {
										addGroup(group);
									} else {
										continue;
									}
									for (var index2 = 0, count2 = members.split(',').length; index2 < count2; index2++) {
										if (members[index2] == "") {
											continue;
										}
										for (var index3 = 0, count3 = allMembers.length; index3 < count3; index3++) {
											if (allMembers[index3].member_seq == members.split(',')[index2]) {
												$('input[value=' + group + ']').parent().parent().find('ul').append('<li><span class="userSeq" style="display:none;" userSeq="' + allMembers[index3].member_seq + '">' + allMembers[index3].member_seq + '</span>' + allMembers[index3].name +  ' | ' + allMembers[index3].club_name + ' | ' + allMembers[index3].region + '<span class="remove" style="display:none;">x</span></li>');
												allMembers = $.grep(allMembers, function( n, i ) {
													return n.member_seq == allMembers[index3].member_seq;
												}, true);
												
												count3--;
											}
										}
									}								
								}
							}
							$('#all-member').empty();
							for (var index = 0, count = allMembers.length; index < count; index++) {
								var item = allMembers[index];
								$('#all-member').append('<li><span class="userSeq" style="display:none;" userSeq="' + item.member_seq + '">' + item.member_seq + '</span>' + item.name +  ' | ' + item.club_name + ' | ' + item.region + ' <span class="remove" style="display:none;">x</span> <input type="button" class="btnAdd" value="Add"></li>');
							}
							$('#groupContainer li').each(function() {
								var addedUserSeq = $(this).find('.userSeq').text();
								$('#all-member span.userSeq').each(function() {
									if ($(this).text() == addedUserSeq) {
										console.log('removed')
										$(this).parents('li').remove();
									}
								});
							});
						}});
			});

			$('form').on('click', '.removeGroup', function() {
				$(this).parents('.eachGroup').hide();
				$(this).parents('.eachGroup').find('li').each(function() {
					$(this).find('input').show();
					$('#selected-member').append($(this));
				});
				return false;
			});
			$('#addGroup').click(addGroup);
			
			$('body').on('click', '.remove', function() {
				var $li = $(this).parents('li');
				$li.find('.btnAdd').show();
				$li.find('.remove').hide();
				$('#all-member').append($li);
				//$li.remove();
			});
			$('#btnPrintTable').click(function() {
				location.href = '/printTable?gameId=' + $('[name=gameId]').val();
				return false;
			});
			
			$('.mealTicketTemplateClose').click(function() {
				$('#mealTicketTemplate').hide();
			});
			
			function addGroup(savedGroupName) {
				var groupNameFirst = $('#groupTypeCount').val().split("");
				var number = "";
				var groupNameIndex = 1;
				var groupName;
				
				number = Math.floor(($('#groupContainer ul').length)/groupNameFirst.length) + 1;
				if (savedGroupName != undefined && typeof savedGroupName === 'string') {
					var groupName = savedGroupName;
				} else {
					var groupName = groupNameFirst[$('#groupContainer ul:visible').length % groupNameFirst.length] + "-" + number;
				}
				$('#groupContainer').append('<div class="groupContainer eachGroup"><h3><input type="text" name="groupName" value="' + groupName + '" />조 <a class="removeGroup">x</a></h3><ul class="group"></ul></div>');
				return false;
			}
			
			for (var index = 0, count = $('#groupTypeCount').val().split("").length; index < count; index++) {
				addGroup();
			}
			
			if ($('[name=gameId]').val() != '') {
				$('[name=gameId]').trigger('change');
			}
		});
		
		jQuery.fn.center = function (leftRight) {
		    this.css("position","absolute");
		    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
		    if (leftRight == 'left') {
		    	this.css("left", '100px');
		    } else {
			    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
		    }
		    return this;
		}
		</script>
	</head>
	<body>
<form>
<div id="addMemberPopup" style="display:none;position:absolute;background-color: #f2f2f2">
</div>
<input type="hidden" name="gameName" id="gameName"/>
<select name="gameId">
	<option value="">새 게임</option>
	<c:forEach var="item" items="${games}">
		<option value="${item.game_id}">${item.game_name}</option>
	</c:forEach>
</select>
<div style="width:100%;border:0;">
<button id="random">무작위</button>
<button id="btnSave">저장</button>
<button id="btnPrintTable">조편성표 출력</button>
<button id="btnNamePlate">이름표 출력</button>
<button id="btnMealTicket">식권 출력</button>
</div>
<div id="mealTicketTemplate" style="display: none;position: absolute;background-color:white;border:1px solid black;">
	<a style="float:right;padding-right:5px;" class="mealTicketTemplateClose">x</a><br>
	<table style="border-top:1px solid black;border-bottom:1px solid black;width:300px;">
		<tr>
			<td>제 <input type="text" name="date" value="2016.12.19">-001</td>
		</tr>
		<tr>
			<td><input type="text" name="top" value="전국시니어파크골프대회"></td>
		</tr>
		<tr>
			<td align="center"><input type="text" name="left" value="식" size="1"> <img src="/static/images/mark.png" /> <input type="text" name="right" value="권" size="1"></td>
		</tr>
		<tr>
			<td align="center"><input type="text" name="bottom" value="15일 중식권"></td>
		</tr>
		<tr>
			<td align="center"><input type="text" name="host" value="대구광역시 파크골프협회"></td>
		</tr>
	</table>
	개수 : <input type="number" name="count" /><input type="button" value="확인" /> 
</div>
<div style="height:300px;overflow:auto;" class="groupContainer">
<h3>선택된 명단</h3>
<ul id="selected-member">
</ul>
</div>

<div style="height:300px;overflow:auto;" class="groupContainer">
<input type="hidden" name="groupMembers" value="" />
<select name="region">
	<option value="">- 전체 -</option>
	<c:forEach var="item" items="${region}">
	<option value="${item.region}">${item.region}</option>
	</c:forEach>
</select>
<h3>전체명단</h3>
<ul id="all-member">
	<c:forEach var="item" items="${member}" varStatus="status">
	<li><span class="userSeq" style="display:none;" userSeq="${item.member_seq}">${item.member_seq}</span>${item.name} | ${item.club_name} | ${item.region} <span class="remove" style="display:none;">x</span> <input type="button" class="btnAdd" value="Add"></input></li>
	</c:forEach>
</ul>
</div>
<div style="clear: left;">
<select name="groupTypeCount" id="groupTypeCount">
	<option value="A">A</option>
	<option value="AB">B</option>
	<option value="ABC">C</option>
	<option value="ABCD" selected="selected">D</option>
</select>
<button id="addGroup">조 추가</button>
</div>
<div id="groupContainer" class="groupContainer">
<!-- 
<div class="groupContainer">
<h3><input type="text" name="groupName" value="A" />조</h3>
<ul class="group">
    
</ul>
</div>
<div class="groupContainer">
<h3><input type="text" name="groupName" value="B" />조</h3>
<ul class="group">
    
</ul>
</div>
 -->
</div>
</form>
</body>
</html>
