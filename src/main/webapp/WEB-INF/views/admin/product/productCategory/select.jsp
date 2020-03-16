<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<style>
.selectedCategory {
	background: #f6f8f9; /* Old browsers */ background : -moz-linear-gradient( top, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%); /* FF3.6-15 */ background : -webkit-linear-gradient( top, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%); /* Chrome10-25,Safari5.1-6 */ background : linear-gradient( to bottom, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */ filter : progid : DXImageTransform.Microsoft.gradient ( startColorstr = '#f6f8f9', endColorstr = '#f5f7f9', GradientType = 0);
	width: calc(100% - 2px);
	height: 22px;
	padding: 2px;
	margin: 1px;
	border: 1px solid #ddd;
	border-radius: 3px;
	background: -moz-linear-gradient(top, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%); /* FF3.6-15 */
	background: -webkit-linear-gradient(top, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%); /* Chrome10-25,Safari5.1-6 */
	background: linear-gradient(to bottom, #f6f8f9 0%, #e5ebee 50%, #d7dee3 51%, #f5f7f9 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f6f8f9', endColorstr='#f5f7f9', GradientType=0);
}
</style>
<script>
	$(document).ready(function() {
		initCategoryTree();
	});

	function initCategoryTree() {
		$("#categoryTree").dynatree({
		title : '<spring:message code="label.product.category.select"/>',
		clickFolderMode : 1, // 1:activate, 2:expand, 3:activate and expand
		fx : {
		height : "toggle",
		duration : 100
		},
		autoFocus : false,
		initAjax : {
		url : "/admin/product/productCategory/getTreeAction.json",
		type : "POST",
		},
		onPostInit : function(isReloading, isError) {
			expandUntil("categoryTree", 1);
			var selectedCategoryId = "${param.selectedCategoryId}";
			if (!isEmpty(selectedCategoryId)) {
				var arr = selectedCategoryId.split(",");
				for (var i=0;i<arr.length;i++) {
					var key = arr[i];
					var node = this.getNodeByKey(key);
					if (node != null) {
						selectCategory(node);
					}
				}
			}
		},
		onActivate : function(node) {
		},
		onDblClick : function(node, event) {
			selectCategory(node);
		},
		});
	}

	function getNodePath(node) {
		var ret = "";
		if (node.parent != null && node.parent.data.key != "0") {
			ret += getNodePath(node.parent) + " > ";
		}
		ret += node.data.title;
		return ret;
	}

	function selectCategory(node) {
		var category_id = node.data.key;
		if ($("#selectedCategoryList").find("[data-category_id=" + category_id + "]").length > 0) {
			return;
		}
		var sHtml = "";
		sHtml += "<div class=\"selectedCategory\" data-category_id=\"" + category_id + "\">";
		sHtml += getNodePath(node);
		sHtml += "<div style=\"float:right;\"><a href=\"javascript:disselectCategory('" + category_id + "');\"><i class=\"ambicon-015_mark_times\"></i></a></div>";
		sHtml += "</div>";
		$("#selectedCategoryList").append(sHtml);
		$("#selectedCategoryList").scrollTop(9999);
	}

	function disselectCategory(category_id) {
		$("#selectedCategoryList").find("[data-category_id=" + category_id + "]").remove();
	}

	function selectCategoryAction() {
		var arr = new Array();
		$("#selectedCategoryList > div").each(function() {
			var path = $(this).text();
			var title = path.substring(path.lastIndexOf(" > ") + 3, path.length);
			var obj = new Object();
			obj.category_id = $(this).data("category_id");
			obj.path = path;
			obj.title = title;
			arr.push(obj);
		});
		var callback = "${param.callback}";
		if (!isEmpty(callback)) {
			eval(callback + "(arr)");
		}
		$("#selectCategoryModal a.close").trigger("click");
	}
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="usr_grp_nm"><spring:message code="label.product.category.select"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="g_column w_1_1">
				<div class="unitBox lineBox menuTreeBox" style="">
					<h4>
						<span class="title"><spring:message code="label.product.category.select"/></span>
						<div class="fr btnArea middle">
							<a href="javascript:expandAll('categoryTree');" class="amb_btnstyle white middle onlyIcon">
								<i class="ambicon-098_tree_open"></i>
							</a>
							<a href="javascript:collapseAll('categoryTree');" class="amb_btnstyle white middle onlyIcon">
								<i class="ambicon-099_tree_close"></i>
							</a>
						</div>
					</h4>
					<div style="width: 100%; height: 250px; overflow-y: auto;">
						<div id="categoryTree"></div>
					</div>
				</div>
				<div class="unitBox lineBox menuTreeBox" style="margin-top: 3px;">
					<div id="selectedCategoryList" style="width: 100%; height: 140px; overflow-y: auto;"></div>
				</div>
				<div class="fr btnArea middle">
					<a href="javascript:selectCategoryAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.confirm"/></a>
				</div>
			</div>
		</div>

	</div>
	</div>
</div>