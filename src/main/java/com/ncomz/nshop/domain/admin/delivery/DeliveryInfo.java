package com.ncomz.nshop.domain.admin.delivery;

import java.util.ArrayList;

public class DeliveryInfo {
   private String invoiceNo;
   private String recipient;
   private String senderName;
   private String receiverAddr;
   private ArrayList<DeliveryInfoDetail> deliveryInfoDetail;

   public DeliveryInfo(String invoiceNo, String recipient, String senderName, String receiverAddr,
         ArrayList<DeliveryInfoDetail> deliveryInfoDetail) {
      super();
      this.invoiceNo = invoiceNo;
      this.recipient = recipient;
      this.senderName = senderName;
      this.receiverAddr = receiverAddr;
      this.deliveryInfoDetail = deliveryInfoDetail;
   }

   public String getInvoiceNo() {
      return invoiceNo;
   }

   public void setInvoiceNo(String invoiceNo) {
      this.invoiceNo = invoiceNo;
   }

   public String getRecipient() {
      return recipient;
   }

   public void setRecipient(String recipient) {
      this.recipient = recipient;
   }

   public String getsenderName() {
      return senderName;
   }

   public void setsenderName(String senderName) {
      this.senderName = senderName;
   }

   public String getReceiverAddr() {
      return receiverAddr;
   }

   public void setReceiverAddr(String receiverAddr) {
      this.receiverAddr = receiverAddr;
   }

   public ArrayList<DeliveryInfoDetail> getDeliveryInfoDetail() {
      return deliveryInfoDetail;
   }

   public void setDeliveryInfoDetail(ArrayList<DeliveryInfoDetail> deliveryInfoDetail) {
      this.deliveryInfoDetail = deliveryInfoDetail;
   }

   @Override
   public String toString() {
      return "DeliveryInfo [invoiceNo=" + invoiceNo + ", recipient=" + recipient + ", senderName=" + senderName
            + ", receiverAddr=" + receiverAddr + ", deliveryInfoDetail=" + deliveryInfoDetail + "]";
   }
   
}