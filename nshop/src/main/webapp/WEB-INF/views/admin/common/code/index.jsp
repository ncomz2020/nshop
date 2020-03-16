<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<style>
span.node_font_red  a {color:#f00;}
span.dynatree-active.node_font_red a {background-color:#f00!important;}
</style>
<script>
	$(document).ready(function() {
		var activateKey = "${param.grp_cd}";
		if (isEmpty(activateKey)) {
			activateKey = "0";
		}
		$("#activateKey").val(activateKey);
		initTree();
	});

	function refreshScreen(grp_cd) {
		var param = new Object();
		param.grp_cd = grp_cd;
		movePage("", param);
	}

	function initTree() {
		$("#tree").dynatree({
		title : '<spring:message code="label.code.manage"/>',
		clickFolderMode : 1, // 1:activate, 2:expand, 3:activate and expand
		fx : {
		height : "toggle",
		duration : 100
		},
		autoFocus : false,
		initAjax : {
		url : "getTreeAction.json",
		type : "POST",
		},
		onPostInit : function(isReloading, isError) {
			var activateKey = $("#activateKey").val();
			this.getNodeByKey(activateKey).activate();
			expandAll("tree");
		},
		onActivate : function(node) {
			$("#activateKey").val(node.data.key);
		},
		onDblClick : function(node, event) {
			goUpdate(node);
		},
		dnd : {
		onDragStart : function(node) {
			return true;
		},
		autoExpandMS : 1000,
		preventVoidMoves : true, // Prevent dropping nodes 'before self', etc.
		onDragEnter : function(node, sourceNode) {
			if (node.parent !== sourceNode.parent) {
				return false;
			}
			return ["before", "after"];
		},
		onDrop : function(node, sourceNode, hitMode, ui, draggable) {
			logMsg("tree.onDrop(%o, %o, %s)", node, sourceNode, hitMode);
			sourceNode.move(node, hitMode);

			var algn_ord;
			var childList = sourceNode.parent.childList;
			for (var i = 0; i < childList.length; i++) {
				var child = childList[i];
				if (child.data.key == sourceNode.data.key) {
					algn_ord = i + 1;
					break;
				}
			}

			var param = new Object();
			param.grp_cd = sourceNode.parent.data.key;
			param.depth = getNodeDepth(sourceNode) - 1;
			param.dtl_cd = sourceNode.data.key;
			param.algn_ord = algn_ord;
			$.ajax({
			url : "moveAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					$("#tree").dynatree("getTree").reload();
				} else {
					swal({
				        title: result
				    });
				}
			},
			});
		},
		onDragLeave : function(node, sourceNode) {
		}
		},
		});
	}

	function goAdd() {
		var activeNode = $("#tree").dynatree("getActiveNode");
		if (activeNode == null) {
			swal({
		        title: '<spring:message code="label.code.valid.select.parent"/>'
		    });
			return;
		}
		var url = "insert.ajax";
		var param = new Object();
		param.grp_cd = activeNode.parent.data.key;
		param.depth = getNodeDepth(activeNode) - 1;
		param.dtl_cd = activeNode.data.key;
		openModal(url, "insertModal", param,"500");
	}

	function goUpdate(node) {
		if (getNodeDepth(node) == 1) {
			return;
		}
		var url = "update.ajax";
		var param = new Object();
		param.grp_cd = node.parent.data.key;
		param.depth = getNodeDepth(node) - 1;
		param.dtl_cd = node.data.key;
		openModal(url, "updateModal", param,"500");
	}
</script>

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<div class="unitBox lineBox menuTreeBox" style="">
			<h4>
				<span class="title"><spring:message code="label.code.manage"/></span>
				<div class="fr btnArea middle">
					<a href="javascript:expandAll('tree');" class="amb_btnstyle white middle onlyIcon">
						<i class="ambicon-098_tree_open"></i>
					</a>
					<a href="javascript:collapseAll('tree');" class="amb_btnstyle white middle onlyIcon">
						<i class="ambicon-099_tree_close"></i>
					</a>
					<a href="javascript:goAdd();" class="amb_btnstyle white middle">
						<i class="ambicon-100_tree_plus"></i>
					</a>
				</div>
			</h4>
			<input type="hidden" id="activateKey" value="0">
			<div id="tree"></div>
		</div>
	</div>
</div>
<!-- rowBox 반복단위 -->


