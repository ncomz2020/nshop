<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
	$(document).ready(function() {
		selectBoxSetting();
		searchList(1);

		$("#productListForm input").keyup(function(event) {
			if (event.keyCode == 13) {
				searchList(1);
			}
		});

		$('#searchFormBtn').click(function() {
			var param = $('#productListForm').serialize();
			$.ajax({
			url : "listAction.ajax",
			type : "POST",
			data : param,
			success : function(data) {
				$("#listActionDiv").html(data);
			},
			error : function() {
				swal({
			        title: '<spring:message code="label.common.fail.action"/>'
			    });				
			}
			});
		});
	});

	function selectBoxSetting() {
		var categorySelectBox = [ {
		'codeType' : 'category',
		'parent_id' : '0',
		'selectId' : 'category_1',
		'defaultName' : '<spring:message code="label.product.prod.category.all_1"/>'
		} ];
		var statusSelectBox = [ {
		'codeType' : 'commCode',
		'grp_cd' : 'P001',
		'selectId' : 'search_status',
		'defaultName' : '<spring:message code="label.common.all"/>'
		} ];

		// 상담분류 selectBox 세팅
		var category_1 = "${info.category_1}";
		var category_2 = "${info.category_2}";
		var category_3 = "${info.category_3}";
		var category_4 = "${info.category_4}";

		if (category_1 != null && category_1 != "") {
			// 초기 대분류  세팅
			callAajaxJson(categorySelectBox);
			setTimeout(function() {
				$("#category_1 > option[value=" + category_1 + "]").attr("selected", "true");
			}, 500);

			// 초기 중분류  세팅
			var category_2SelectBox = [ {
			'codeType' : 'category',
			'parent_id' : '${cnslDtlInfo.category_1}',
			'selectId' : 'category_2',
			'defaultName' : '<spring:message code="label.product.prod.category.all_2"/>'
			} ];
			callAajaxJson(category_2SelectBox);

			setTimeout(function() {
				$("#category_2 > option[value=" + category_2 + "]").attr("selected", "true");
			}, 500);

			// 초기 소분류  세팅
			var category_3SelectBox = [ {
			'codeType' : 'category',
			'parent_id' : '${cnslDtlInfo.category_2}',
			'selectId' : 'category_3',
			'defaultName' : '<spring:message code="label.product.prod.category.all_3"/>'
			} ];
			callAajaxJson(category_3SelectBox);
			setTimeout(function() {
				$("#category_3 > option[value=" + category_3 + "]").attr("selected", "true");
			}, 500);

			// 초기 소분류  세팅
			var category_4SelectBox = [ {
			'codeType' : 'category',
			'parent_id' : '${cnslDtlInfo.category_3}',
			'selectId' : 'category_3',
			'defaultName' : '<spring:message code="label.product.prod.category.all_4"/>'
			} ];
			callAajaxJson(category_4SelectBox);
			setTimeout(function() {
				$("#category_4 > option[value=" + category_4 + "]").attr("selected", "true");
			}, 500);

		} else {
			callAajaxJson(categorySelectBox);
			setDefaultName('category_2', '<spring:message code="label.product.prod.category.all_2"/>');
			setDefaultName('category_3', '<spring:message code="label.product.prod.category.all_3"/>');
			setDefaultName('category_4', '<spring:message code="label.product.prod.category.all_4"/>');
		}

		// 중분류 세팅
		$('#category_1').change(function() {
			var data = $(this).val();

			var category_2 = [ {
			'codeType' : 'category',
			'parent_id' : $(this).val(),
			'selectId' : 'category_2',
			'defaultName' : '<spring:message code="label.product.prod.category.all_2"/>'
			} ];

			/* setTimeout(function() {
				setDefaultName('category_3', '<spring:message code="label.product.prod.category.all_3"/>');
			}, 200); */

			if ($(this).val() == '') {
				childInitialized('category_2', '<spring:message code="label.product.prod.category.all_2"/>');
				childInitialized('category_3', '<spring:message code="label.product.prod.category.all_3"/>');
				childInitialized('category_4', '<spring:message code="label.product.prod.category.all_4"/>');
			} else {
				callAajaxJson(category_2);

				setTimeout(function() {
					if ($('#category_2').children('option').length == 1) {
						childInitialized('category_2', '<spring:message code="label.product.prod.category.all_2"/>');
						childInitialized('category_3', '<spring:message code="label.product.prod.category.all_3"/>');
						childInitialized('category_4', '<spring:message code="label.product.prod.category.all_4"/>');
					}
				}, 200);
			}
		});

		// 소분류 세팅
		$('#category_2').change(function() {
			var selectId = 'category_2';
			var data = $(this).val();
			var category_3 = [ {
			'codeType' : 'category',
			'parent_id' : data,
			'selectId' : 'category_3',
			'defaultName' : '<spring:message code="label.product.prod.category.all_3"/>'
			} ];

			if ($(this).val() == '') {
				// $("#" + selectId).html("");
				childInitialized('category_3', '<spring:message code="label.product.prod.category.all_3"/>');
				childInitialized('category_4', '<spring:message code="label.product.prod.category.all_4"/>');
			} else {
				callAajaxJson(category_3);
				/* console.log('depth3 ===> '+JSON.stringify(callAajaxJson(category_3))); */
			}
		});

		// 소분류 세팅
		$('#category_3').change(function() {
			var selectId = 'category_3';
			var data = $(this).val();
			var category_4 = [ {
			'codeType' : 'category',
			'parent_id' : data,
			'selectId' : 'category_4',
			'defaultName' : '<spring:message code="label.product.prod.category.all_4"/>'
			} ];

			if ($(this).val() == '') {
				// $("#" + selectId).html("");
				childInitialized('category_4', '<spring:message code="label.product.prod.category.all_4"/>');
			} else {
				callAajaxJson(category_4);
				/* console.log('depth4 ===> '+JSON.stringify(callAajaxJson(category_4))); */
			}
		});

		// 판매상태 조회
		callAajaxJson(statusSelectBox);
		/* console.log('status ===> '+JSON.stringify(callAajaxJson(statusSelectBox))); */
	}

	function searchList(page) {
		$("#page").val(page);
		var param = $('#productListForm').serialize();
		$.ajax({
		url : "listAction.ajax",
		type : "POST",
		data : param,
		success : function(data) {
			$("#listActionDiv").html(data);
		},
		error : function() {
			swal({
		        title: '<spring:message code="label.common.fail.action"/>'
		    });
		}
		});
	}
</script>
<!-- rowBox 반복단위 -->
<div class="rowBox mgT30">
	<div class="g_column w_1_1">
		<form id="productListForm" name="productListForm">
			<input type="hidden" id="page" name="page">
			<div class="unitBox searchBox" style="">
				<table class="amb_form_table">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 25%;" />
						<col style="width: 10%;" />
						<col style="width: 25%;" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="label.product.category"/></th>
							<td colspan="3">
								<select id="category_1" name="category_1" style="width: 150px;"></select>
								<select id="category_2" name="category_2" style="width: 150px;"></select>
								<select id="category_3" name="category_3" style="width: 150px;"></select>
								<select id="category_4" name="category_4" style="width: 150px;"></select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.product.prod.stat"/></th>
							<td>
								<select id="search_status" name="search_status"></select>
							</td>
							<th><spring:message code="label.common.reg.period"/></th>
								<td>
									<span class="datepickerRange">
										<input type="text" id="start_date"  name="start_date" class="inp datepicker startDate"  value="<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />" placeholder="date" />
										~
										<input type="text" id="end_date" name="end_date" class="inp datepicker endDate"  value="<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" />" placeholder="date" />
									</span>
						    	</td>							
						</tr>
						<tr>
							<th><spring:message code="label.product.prod.price"/></th>
							<td colspan="3">
								<input type="text" id="start_price" name="start_price" class="inp" style="width: 200px;" />
								<spring:message code="label.product.prod.price.unit"/> &nbsp;~&nbsp;
								<input type="text" id="end_price" name="end_price" class="inp" style="width: 200px;" />
								<spring:message code="label.product.prod.price.unit"/>
							</td>
						</tr>
						<tr>
							<th><spring:message code="label.common.search"/></th>
							<td colspan="3">
								<select id="searcㅣh_type" name="search_type">
									<option value="N"><spring:message code="label.product.prod.name"/></option>
									<option value="D"><spring:message code="label.product.prod.desc"/></option>
									<option value="C"><spring:message code="label.product.prod.code"/></option>
									<option value="R"><spring:message code="label.product.create.user.name"/></option>
								</select>
								&nbsp;&nbsp;
								<input type="text" id="search_txt" name="search_txt" class="inp" style="width: 68%;" placeholder='<spring:message code="label.product.prod.input.search"/>' />
							</td>
						</tr>
					</tbody>
				</table>
				<span class="searchFormBtn">
					<a href="javascript:searchList(1);" class="amb_btnstyle black middle"><spring:message code="label.common.search"/></a>
				</span>
			</div>
		</form>
	</div>
</div>
<div id="listActionDiv" class="nh_conBox"></div>