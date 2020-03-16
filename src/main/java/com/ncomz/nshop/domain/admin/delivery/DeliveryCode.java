package com.ncomz.nshop.domain.admin.delivery;

public class DeliveryCode {
   
   private String t_key = "ZBDehDj92gWtK79HITajgA";
   private String t_code;
   private String t_invoice;
   
   public DeliveryCode() {
      // TODO Auto-generated constructor stub
   }
   
   public DeliveryCode(String t_key, String t_code, String t_invoice) {
      super();
      this.t_key = t_key;
      this.t_code = t_code;
      this.t_invoice = t_invoice;
   }

   public String getT_key() {
      return t_key;
   }

   public void setT_key(String t_key) {
      this.t_key = t_key;
   }

   public String getT_code() {
      return t_code;
   }

   public void setT_code(String t_code) {
      this.t_code = t_code;
   }

   public String getT_invoice() {
      return t_invoice;
   }

   public void setT_invoice(String t_invoice) {
      this.t_invoice = t_invoice;
   }

   @Override
   public String toString() {
      return "DeliveryCode [t_key=" + t_key + ", t_code=" + t_code + ", t_invoice=" + t_invoice + "]";
   }
   
   
}