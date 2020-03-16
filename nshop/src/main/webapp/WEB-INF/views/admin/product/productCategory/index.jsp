<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<script>
	$(document).ready(function() {
		initTree();
	});

	function initTree() {
		$("#tree").dynatree({
		title : '<spring:message code="label.product.category.manage"/>',
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
			// expandAll("tree");
			$(document).scrollTop($("#tree").data("scrollTop"));
			/* setTimeout(function() {
				$(document).scrollTop($("#tree").data("scrollTop"));
			}, 0); */
		},
		onActivate : function(node) {
			$("#activateKey").val(node.data.key);
		},
		onDblClick : function(node, event) {
			goUpdate(node.data.key);
		},
		onExpand : function(flag, node) {
			var param = new Object();
			param.category_id = node.data.key;
			if (flag) {
				param.expand = "Y";
			} else {
				param.expand = "N";
			}
			$.ajax({
				url : "updateExpandAction.json",
				type : "POST",
				data : param,
				dataType : "json",
				success : function(data) {
					var result = data.result;
					if (result == "succ") {
					} else {
						swal({
					        title: result
					    });
					}
				},
				});
		},
		dnd : {
		onDragStart : function(node) {
			return true;
		},
		autoExpandMS : 1000,
		preventVoidMoves : true, // Prevent dropping nodes 'before self', etc.
		onDragEnter : function(node, sourceNode) {
			node.activate();
			return true;
		},
		onDragOver : function(node, sourceNode, hitMode) {
			if (node.isDescendantOf(sourceNode)) {
				return false;
			}
			if (!node.data.isFolder && hitMode === "over") {
				return "after";
			}
		},
		onDrop : function(node, sourceNode, hitMode, ui, draggable) {
			logMsg("tree.onDrop(%o, %o, %s)", node, sourceNode, hitMode);
			sourceNode.move(node, hitMode);

			var display_order;
			var childList = sourceNode.parent.childList;
			for (var i = 0; i < childList.length; i++) {
				var child = childList[i];
				if (child.data.key == sourceNode.data.key) {
					display_order = i + 1;
					break;
				}
			}

			var param = new Object();
			param.category_id = sourceNode.data.key;
			param.parent_id = node.data.key;
			param.display_order = display_order;
			$.ajax({
			url : "moveAction.json",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data) {
				var result = data.result;
				if (result == "succ") {
					refreshTree("tree");
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
		        title: '<spring:message code="label.product.category.valid.select.parent"/>'
		    });
			return;
		}
		var url = "insert.ajax";
		var param = new Object();
		param.category_id = activeNode.data.key;
		openModal(url, "insertModal", param,"500");
	}

	function goUpdate(category_id) {
		if (category_id == "0") {
			return;
		}
		var url = "update.ajax";
		var param = new Object();
		param.category_id = category_id;
		openModal(url, "updateModal", param);
	}
</script>

<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<div class="unitBox lineBox menuTreeBox" style="">
			<h4>
				<span class="title"><spring:message code="label.product.category.manage"/></span>
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

