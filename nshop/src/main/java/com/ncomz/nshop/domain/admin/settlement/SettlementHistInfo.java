package com.ncomz.nshop.domain.admin.settlement;

import com.ncomz.nshop.domain.common.Paging;

public class SettlementHistInfo extends Paging {
	
	private String calcul_hist_seq;			// 정산히스토리 번호
	private String calcul_seq;				// 정산번호
	private String sts_update_datetime;		// 상태 변경 일시
	private String updater_id;				// 변경자 ID
	private String calcul_sts_cd;				// 정산상태코드
	private String calcul_sts_cd_nm;				// 정산상태코드네임
	private String calcul_memo;				// 정산메모
	
	
	
	public String getCalcul_hist_seq() {
		return calcul_hist_seq;
	}
	public void setCalcul_hist_seq(String calcul_hist_seq) {
		this.calcul_hist_seq = calcul_hist_seq;
	}
	public String getCalcul_seq() {
		return calcul_seq;
	}
	public void setCalcul_seq(String calcul_seq) {
		this.calcul_seq = calcul_seq;
	}
	public String getSts_update_datetime() {
		return sts_update_datetime;
	}
	public void setSts_update_datetime(String sts_update_datetime) {
		this.sts_update_datetime = sts_update_datetime;
	}
	public String getUpdater_id() {
		return updater_id;
	}
	public void setUpdater_id(String updater_id) {
		this.updater_id = updater_id;
	}
	public String getCalcul_sts_cd() {
		return calcul_sts_cd;
	}
	public void setCalcul_sts_cd(String calcul_sts_cd) {
		this.calcul_sts_cd = calcul_sts_cd;
	}
	public String getCalcul_memo() {
		return calcul_memo;
	}
	public void setCalcul_memo(String calcul_memo) {
		this.calcul_memo = calcul_memo;
	}
	public String getCalcul_sts_cd_nm() {
		return calcul_sts_cd_nm;
	}
	public void setCalcul_sts_cd_nm(String calcul_sts_cd_nm) {
		this.calcul_sts_cd_nm = calcul_sts_cd_nm;
	}
	
	

}
