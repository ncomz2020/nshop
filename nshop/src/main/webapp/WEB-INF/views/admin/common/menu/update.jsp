<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
	$(document).ready(function() {
		$("#iconList i").click(function() {
			$("#iconList i").css("background-color", "");
			$(this).css("background-color", "#bbb");
			$("#update_icon").val($(this).attr("class"));
		});
		var icon = "${menu.icon}";
		if (!isEmpty(icon)) {
			$("#iconList i." + icon).css("background-color", "#bbb");
		}
	});

	function updateAction() {
		if ($("#update_title").val() == "") {
			swal({
		        title: '<spring:message code="label.menu.valid.input.name"/>'},function() {
					$("#update_title").focus();
			});			
			return;
		}
		var param = $("#updateForm").serialize();
		$.ajax({
		url : "updateAction.json",
		type : "POST",
		data : param,
		dataType : "json",
		success : function(data) {
			var result = data.result;
			if (result == "succ") {
				swal({
			        title: '<spring:message code="label.common.success.save"/>'},function() {
						refreshScreen($("#activateKey").val());
				});				
			} else {
				swal({
			        title: result
			    });
			}
		},
		});
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
			var param = $("#updateForm").serialize();
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
			      			refreshScreen("0");
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
</script>
<div class="amb_layout_common amb_admin_layout_temp_01 modal-dialog">
<div class="modal-content">
	<h1 class="popupHeader">
		<span class="title"><spring:message code="label.menu.modify"/></span>
		<a href="javascript:;" class="close" onClick="javascript:closeModal(this);">
			<i class="ambicon-015_mark_times"></i>
		</a>
	</h1>

	<div id="content" class="content">
		<div class="rowBox">
			<div class="unitBox" style="">
				<form id="updateForm" action="javascript:updateAction();">
					<input type="hidden" name="menu_id" value="${menu.menu_id}">
					<input type="hidden" id="update_icon" name="icon" value="${menu.icon}">
					<table class="amb_form_table lineAll">
						<colgroup>
							<col style="width: 25%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="center"><spring:message code="label.menu.name"/></th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="update_title" name="title" placeholder="메뉴명" maxlength="50" autofocus value="<c:out value="${menu.title}"/>" onfocus="this.value = this.value;">
								</td>
							</tr>
							<tr>
								<th class="center">URL</th>
								<td>
									<input type="text" class="inp" style="width: 100%;" id="update_url" name="url" placeholder="URL" maxlength="50" value="<c:out value="${menu.url}"/>" onfocus="this.value = this.value;">
								</td>
							</tr>
							<tr>
								<th class="center">Icon</th>
								<td id="iconList">
									<i class="ambicon-001_arrow_right"></i> <i class="ambicon-002_arrow_left"></i> <i class="ambicon-003_arrow_down"></i> <i class="ambicon-004_arrow_up"></i> <i class="ambicon-005_arrow_last"></i> <i class="ambicon-006_arrow_first"></i> <i class="ambicon-007_arrow2_right"></i> <i class="ambicon-008_arrow2_left"></i> <i class="ambicon-009_arrow2_up"></i> <i class="ambicon-010_arrow2_down"></i> <i class="ambicon-011_scale_up"></i> <i class="ambicon-012_scale_down"></i> <i class="ambicon-013_mark_plus"></i> <i class="ambicon-014_mark_minus"></i> <i class="ambicon-015_mark_times"></i> <i class="ambicon-016_mark_divide"></i> <i class="ambicon-017_list_default"></i> <i class="ambicon-018_align_all"></i> <i class="ambicon-019_align_left"></i> <i class="ambicon-020_align_right"></i> <i class="ambicon-021_align_center"></i> <i class="ambicon-022_newwindow"></i> <i class="ambicon-023_trash"></i> <i class="ambicon-024_view_big"></i> <i class="ambicon-025_view_small"></i> <i
										class="ambicon-026_search"></i> <i class="ambicon-027_setting"></i> <i class="ambicon-028_reflash"></i> <i class="ambicon-029_doc_single"></i> <i class="ambicon-030_doc_add"></i> <i class="ambicon-031_doc_remove"></i> <i class="ambicon-032_doc_multi"></i> <i class="ambicon-033_human"></i> <i class="ambicon-034_pencel"></i> <i class="ambicon-035_key_lock"></i> <i class="ambicon-036_key_unlock"></i> <i class="ambicon-037_alert_line"></i> <i class="ambicon-038_alert_full"></i> <i class="ambicon-039_star_line"></i> <i class="ambicon-040_star_full"></i> <i class="ambicon-041_home_line"></i> <i class="ambicon-042_home_full"></i> <i class="ambicon-043_layout_all"></i> <i class="ambicon-044_layout_left"></i> <i class="ambicon-045_layout_right"></i> <i class="ambicon-046_check_circle"></i> <i class="ambicon-047_check_square"></i> <i class="ambicon-048_check"></i> <i class="ambicon-049_radiobox"></i> <i class="ambicon-050_monitor"></i> <i class="ambicon-051_print"></i> <i
										class="ambicon-052_folder"></i> <i class="ambicon-053_loard_up"></i> <i class="ambicon-054_loard_down"></i> <i class="ambicon-055_weather_sun"></i> <i class="ambicon-056_weather_cloud"></i> <i class="ambicon-057_weather_humidity"></i> <i class="ambicon-058_weather_moon"></i> <i class="ambicon-059_weather_temperature"></i> <i class="ambicon-060_weather_rain"></i> <i class="ambicon-061_weather_thunder"></i> <i class="ambicon-062_chatting"></i> <i class="ambicon-063_battary"></i> <i class="ambicon-064_money_bill"></i> <i class="ambicon-065_cross_arrow"></i> <i class="ambicon-066_letter"></i> <i class="ambicon-067_graph_bar"></i> <i class="ambicon-068_graph_bar2"></i> <i class="ambicon-069_graph_line"></i> <i class="ambicon-070_graph_pie"></i> <i class="ambicon-071_list_colum"></i> <i class="ambicon-072_calendar"></i> <i class="ambicon-072_frame"></i> <i class="ambicon-073_wallet"></i> <i class="ambicon-074_get_out"></i> <i class="ambicon-075_get_in"></i> <i
										class="ambicon-076_box_plus"></i> <i class="ambicon-077_box_minus"></i> <i class="ambicon-078_bullet_donut"></i> <i class="ambicon-079_bullet_plus"></i> <i class="ambicon-080_bullet_minus"></i> <i class="ambicon-081_bullet_box_minus"></i> <i class="ambicon-082_bullet_box_plus"></i> <i class="ambicon-083_employee_s1"></i> <i class="ambicon-084_employee_s2"></i> <i class="ambicon-085_list_s1"></i> <i class="ambicon-086_photo"></i> <i class="ambicon-087_flieadd"></i> <i class="ambicon-088_view_detail"></i> <i class="ambicon-098_tree_open"></i> <i class="ambicon-099_tree_close"></i> <i class="ambicon-091_mtree_1dpAdd"></i> <i class="ambicon-100_tree_plus"></i> <i class="ambicon-093_mtree_all"></i> <i class="ambicon-094_mtree_read"></i>
										<i class="ambicon-096_camera"></i> <i class="ambicon-097_shoppingbag"></i> <i class="ambicon-098_tree_open"></i> <i class="ambicon-099_tree_close"></i> <i class="ambicon-100_tree_plus"></i> 
										<i class=""></i>
								</td>
							</tr>
							<c:forEach items="${languageCodeList}" var="code" varStatus="status">
								<tr>
									<th class="center"><c:out value="${code.dtl_nm}"/></th>
									<td>
										<input type="hidden" name="languageCode" value="<c:out value="${code.dtl_cd}"/>">
										<c:set var="languageTitle" value=""/>
										<c:forEach items="${menuLanguageList}" var="menuLanguage" varStatus="status">
											<c:if test="${code.dtl_cd == menuLanguage.language}">
												<c:set var="languageTitle" value="${menuLanguage.title}"/>
											</c:if>
										</c:forEach>
										<input type="text" class="inp" style="width: 100%;" name="languageTitle" placeholder="<c:out value="${code.dtl_nm}"/>" maxlength="50" value="<c:out value="${languageTitle}"/>">
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<div class="fr btnArea middle">
					<a href="javascript:updateAction();" class="amb_btnstyle gray middle"><spring:message code="label.common.save"/></a>
					<a href="javascript:deleteConfirm();" class="amb_btnstyle gray middle"><spring:message code="label.common.delete"/></a>
				</div>
			</div>
		</div>
		<!-- rowBox 반복단위 -->
	</div>
 </div>
</div>