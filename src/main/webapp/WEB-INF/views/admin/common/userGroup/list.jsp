<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script src="/js/dynatree/jquery.dynatree.js"></script>
<link rel="stylesheet" href="/js/dynatree/skin/ui.dynatree.css">
<script>
	$(document).ready(function() {
		var page = "${param.page}";
		if (isEmpty(page)) {
			page = 1;
		}
		searchList(page);
	});

	function goDetail(ppl_id) {
		var param = new Object();
		param.ppl_id = ppl_id;
		movePage("detail", param);
	}

	function searchList(page) {
		var param = new Object();
		param.page = page;
		param.perPage = 10;
		$.ajax({
		url : "listAction.ajax",
		type : "POST",
		data : param,
		success : function(data) {
			$("#listActionDiv").html(data);
		},
		});
	}
</script>
<div id="listActionDiv"></div>