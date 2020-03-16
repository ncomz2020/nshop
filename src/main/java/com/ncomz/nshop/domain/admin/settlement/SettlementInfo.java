package com.ncomz.nshop.domain.admin.settlement;

import java.util.List;

import com.ncomz.nshop.domain.common.Paging;

public class SettlementInfo extends Paging{
	
	private String calcul_seq;			// 정산번호
	private String prod_order_seq;		// 상품주문순번
	private String calcul_fee_div;		// 정산비 구분 (상품금액/배송비)
	private String calcul_fee_div_nm;		// 정산비 구분 (상품금액/배송비)
	private String calcul_sts_cd;			// 정산 상태 코드 (정산요청, 정산확정, 지급완료, 보류, 정산철회)
	private String calcul_sts_cd_nm;			// 정산 상태 코드 (정산요청, 정산확정, 지급완료, 보류, 정산철회)
	private String calcul_req_datetime;	// 정산요청일시
	private String calcul_pre_datetime;	// 정산예정일시
	private String pay_fin_datetime;		// 지급완료일시
	private String payment_amt;			// 결제금액
	private String charge_fee;			// 수수료
	private String calcul_amt;			// 정산금액
	private String prod_order_no;			// 상품주문번호
	private String store_id;			// 상점아이디
	private String store_name;			// 상점이름
	private String settlement_count; 	// 정산건수
	private String order_no;			// 주문번호	
	private String order_seq;			// 주문순번	
	private String payment_way_code;		// 결제코드
	private String user_nm;				// 구매자명
	private String user_id;				// 구매자아이디
	private String bank_cd;				// 은행코드
	private String bank_cd_nm;				// 은행이름
	private String account_no;				// 구매자아이디
	private String calcul_memo;			// 정산히스토리 메모
	private String order_datetime;		// 주문일시
	private String payment_way_cd_nm;	// 결제수단코드
	private String payment_way_cd;	// 결제수단코드
	
	
	private String language;
	
	// 검색조건
	private String search_status;
	private String search_date_type;
	private String start_date;
	private String end_date;
	private String search_type;
	private String search_txt;
	
	
	List<String> calculSeqList;
	List<String> prodOrderSeq;
	
	
	
	
	public String getSearch_date_type() {
		return search_date_type;
	}
	public void setSearch_date_type(String search_date_type) {
		this.search_date_type = search_date_type;
	}
	public String getCalcul_fee_div_nm() {
		return calcul_fee_div_nm;
	}
	public void setCalcul_fee_div_nm(String calcul_fee_div_nm) {
		this.calcul_fee_div_nm = calcul_fee_div_nm;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getSettlement_count() {
		return settlement_count;
	}
	public void setSettlement_count(String settlement_count) {
		this.settlement_count = settlement_count;
	}
	
	public String getProd_order_no() {
		return prod_order_no;
	}
	public void setProd_order_no(String prod_order_no) {
		this.prod_order_no = prod_order_no;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getCalcul_sts_cd_nm() {
		return calcul_sts_cd_nm;
	}
	public void setCalcul_sts_cd_nm(String calcul_sts_cd_nm) {
		this.calcul_sts_cd_nm = calcul_sts_cd_nm;
	}
	public List<String> getCalculSeqList() {
		return calculSeqList;
	}
	public void setCalculSeqList(List<String> calculSeqList) {
		this.calculSeqList = calculSeqList;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_txt() {
		return search_txt;
	}
	public void setSearch_txt(String search_txt) {
		this.search_txt = search_txt;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getSearch_status() {
		return search_status;
	}
	public void setSearch_status(String search_status) {
		this.search_status = search_status;
	}
	public String getCalcul_seq() {
		return calcul_seq;
	}
	public void setCalcul_seq(String calcul_seq) {
		this.calcul_seq = calcul_seq;
	}
	public String getProd_order_seq() {
		return prod_order_seq;
	}
	public void setProd_order_seq(String prod_order_seq) {
		this.prod_order_seq = prod_order_seq;
	}
	public String getCalcul_fee_div() {
		return calcul_fee_div;
	}
	public void setCalcul_fee_div(String calcul_fee_div) {
		this.calcul_fee_div = calcul_fee_div;
	}
	public String getCalcul_sts_cd() {
		return calcul_sts_cd;
	}
	public void setCalcul_sts_cd(String calcul_sts_cd) {
		this.calcul_sts_cd = calcul_sts_cd;
	}
	public String getCalcul_req_datetime() {
		return calcul_req_datetime;
	}
	public void setCalcul_req_datetime(String calcul_req_datetime) {
		this.calcul_req_datetime = calcul_req_datetime;
	}
	public String getCalcul_pre_datetime() {
		return calcul_pre_datetime;
	}
	public void setCalcul_pre_datetime(String calcul_pre_datetime) {
		this.calcul_pre_datetime = calcul_pre_datetime;
	}
	public String getPay_fin_datetime() {
		return pay_fin_datetime;
	}
	public void setPay_fin_datetime(String pay_fin_datetime) {
		this.pay_fin_datetime = pay_fin_datetime;
	}
	public String getPayment_amt() {
		return payment_amt;
	}
	public void setPayment_amt(String payment_amt) {
		this.payment_amt = payment_amt;
	}
	public String getCharge_fee() {
		return charge_fee;
	}
	public void setCharge_fee(String charge_fee) {
		this.charge_fee = charge_fee;
	}
	public String getCalcul_amt() {
		return calcul_amt;
	}
	public void setCalcul_amt(String calcul_amt) {
		this.calcul_amt = calcul_amt;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public List<String> getProdOrderSeq() {
		return prodOrderSeq;
	}
	public void setProdOrderSeq(List<String> prodOrderSeq) {
		this.prodOrderSeq = prodOrderSeq;
	}
	public String getPayment_way_code() {
		return payment_way_code;
	}
	public void setPayment_way_code(String payment_way_code) {
		this.payment_way_code = payment_way_code;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBank_cd() {
		return bank_cd;
	}
	public void setBank_cd(String bank_cd) {
		this.bank_cd = bank_cd;
	}
	public String getAccount_no() {
		return account_no;
	}
	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}
	public String getCalcul_memo() {
		return calcul_memo;
	}
	public void setCalcul_memo(String calcul_memo) {
		this.calcul_memo = calcul_memo;
	}
	public String getOrder_datetime() {
		return order_datetime;
	}
	public void setOrder_datetime(String order_datetime) {
		this.order_datetime = order_datetime;
	}
	public String getPayment_way_cd_nm() {
		return payment_way_cd_nm;
	}
	public void setPayment_way_cd_nm(String payment_way_cd_nm) {
		this.payment_way_cd_nm = payment_way_cd_nm;
	}
	public String getPayment_way_cd() {
		return payment_way_cd;
	}
	public void setPayment_way_cd(String payment_way_cd) {
		this.payment_way_cd = payment_way_cd;
	}
	public String getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(String order_seq) {
		this.order_seq = order_seq;
	}
	public String getBank_cd_nm() {
		return bank_cd_nm;
	}
	public void setBank_cd_nm(String bank_cd_nm) {
		this.bank_cd_nm = bank_cd_nm;
	}
	
	
	
}
