package com.ncomz.nshop.domain.admin.delivery;

public class DeliveryInfoDetail {
   
   private String time;
   private String where;
   private String kind;
   
   public DeliveryInfoDetail(String time, String where, String kind) {
      super();
      this.time = time;
      this.where = where;
      this.kind = kind;
   }

   public String getTime() {
      return time;
   }

   public void setTime(String time) {
      this.time = time;
   }

   public String getWhere() {
      return where;
   }

   public void setWhere(String where) {
      this.where = where;
   }

   public String getKind() {
      return kind;
   }

   public void setKind(String kind) {
      this.kind = kind;
   }

   @Override
   public String toString() {
      return "DeliveryInfoDetail [time=" + time + ", where=" + where + ", kind=" + kind + "]";
   }
   
   
}