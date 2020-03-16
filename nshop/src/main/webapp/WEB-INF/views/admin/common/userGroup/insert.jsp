<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	$(document).ready(function() {
		initTree();
	});

	function insertAction() {
		if ($("#insert_usr_grp_nm").val() == "") {
			swal({
		        title: '<spring:message code="label.usergroup.valid.input.name'},function() {
					$("#insert_usr_grp_nm").focus();
			});
			return;
		}
		$("#insert_user_group_auth_string").val(getUserGroupAuthString());
		var param = $("#insertForm").serialize();
		$.ajax({
		url : "insertAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save'},function() {
						var param = new Object();
						param.page = getCurrentPage();
						movePage("", param);
				});
			} else {
				swal({
			        title: result
			    });
			}
		},
		});
	}
	
	function getUserGroupAuthString() {
		var arr = new Array();
		$("#tree").dynatree("getRoot").visit(function(node) {
			var obj = new Object();
			obj.menu_id = node.data.key;
			obj.auth_tp = node.data.auth_tp;
			arr.push(obj);
		});
		var ret = JSON.stringify(arr);
		return ret;
	}

	function deleteConfirm() {
		swal({
	        title: '<spring:message code="label.common.confirm.delete"/>',
	        type: "warning",
	        showCancelButton: true,
	        confirmButtonText: "YES",
	        cancelButtonText: "NO",
	        closeOnConfirm: false
	         },function() {		
			var param = $("#insertForm").serialize();
			$.ajax({
			url : "deleteAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					swal({
				        title: '<spring:message code="label.common.success.delete"/>',
				        type: "success",
			      		confirmButtonText: "CLOSE" },function() {
						$("#insertModal a.close").trigger("click");
					});
				} else {
					swal({
				        title: result
				    });
				}
			},
			});
		});
	}

	function initTree() {
		var param = new Object();
		param.usr_grp_id = "";
		$("#tree").dynatree({
		title : '<spring:message code="label.usergroup.manage"/>',
		clickFolderMode : 1, // 1:activate, 2:expand, 3:activate and expand
		fx : {
		height : "toggle",
		duration : 100
		},
		autoFocus : false,
		initAjax : {
		url : "getTreeAction.json",
		type : "POST",
		data : param,
		},
		onPostInit : function(isReloading, isError) {
			expandAll("tree");
			this.getRoot().visit(function(node) {
				setMenuAuthProc(node, node.data.auth_tp);
			});
		},
		onActivate : function(node) {
		},
		onDblClick : function(node, event) {
		},
		});
	}
	
	function setMenuAuth(auth_tp) {
		var node = $("#tree").dynatree("getActiveNode");
		setMenuAuthProc(node, auth_tp);
		node.visit(function(node) {
			setMenuAuthProc(node, auth_tp);
		});
	}
	
	function setMenuAuthProc(node, auth_tp) {
		node.data.auth_tp = auth_tp;
		var title = node.data.title + " : " + auth_tp;
		if (isEmpty(auth_tp)) {
			title = node.data.title;
		}
		$($(node.li)[0]).find(".dynatree-title").text(title);
	}
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="usr_grp_nm"><spring:message code="label.usergroup.manage"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<form id="insertForm" action="javascript:insertAction();">
					<input type="hidden" id="insert_user_group_auth_string" name="user_group_auth_string">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.usergroup.name"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_usr_grp_nm" name="usr_grp_nm" placeholder='<spring:message code="label.usergroup.name"/>' maxlength="25" autofocus onfocus="this.value = this.value;">
								</td>
							</tr>
							<tr>
								<th class="center"><spring:message code="label.usergroup.description"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="insert_expln" name="expln" placeholder='<spring:message code="label.usergroup.description"/>' maxlength="50" onfocus="this.value = this.value;">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="g_column w_1_1">
				<div class="unitBox lineBox menuTreeBox" style="">
					<h4>
						<span class="title"><spring:message code="label.usergroup.auth.manage"/></span>
						<div class="fr btnArea middle">
							<a href="javascript:expandAll('tree');" class="amb_btnstyle white middle onlyIcon">
								<i class="ambicon-098_tree_open"></i>
							</a>
							<a href="javascript:collapseAll('tree');" class="amb_btnstyle white middle onlyIcon">
								<i class="ambicon-099_tree_close"></i>
							</a>
							<a href="javascript:setMenuAuth('');" class="amb_btnstyle white middle">
								X
							</a>
							<a href="javascript:setMenuAuth('R');" class="amb_btnstyle white middle">
								R
							</a>
							<a href="javascript:setMenuAuth('A');" class="amb_btnstyle white middle">
								A
							</a>
						</div>
					</h4>
					<input type="hidden" id="activateKey" value="0">
					<div style="width:100%;height:310px;overflow-y:auto;">
						<div id="tree"></div>
					</div>
				</div>
				<div class="fr btnArea middle">
					<a href="javascript:insertAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.save"/></a>
<%-- 					<a href="javascript:deleteConfirm();" class="amb_btnstyle gray middle"><spring:message code="label.common.delete"/></a> --%>
				</div>
			</div>
		</div>

	</div>
	</div>
</div>