package com.ncomz.nshop.dao.admin.delivery;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Component;
import com.ncomz.nshop.domain.admin.delivery.DeliveryInfoMgmt;

@Component
public interface DeliveryMapper {

	List<DeliveryInfoMgmt> list(DeliveryInfoMgmt deliveryInfoMgmt);
	String getStartDate();
	String getEndDate();
	int getDeliveryCount(DeliveryInfoMgmt deliveryInfoMgmt);
	List<LinkedHashMap<String, String>> listExcel(DeliveryInfoMgmt deliveryInfoMgmt);
	int getDeliveryTracknoMessageCount(DeliveryInfoMgmt deliveryInfoMgmt);
	int getDeliveryMemoCount(DeliveryInfoMgmt deliveryInfoMgmt);
	int selectedAddrUpadte(DeliveryInfoMgmt deliveryInfoMgnt);
	int selectedWaybilUpadte(DeliveryInfoMgmt deliveryInfoMgnt);
	String selectedShipCheck(DeliveryInfoMgmt deliveryInfoMgmt);
	void selectedShipUpdate(DeliveryInfoMgmt deliveryInfoMgmt);
	
}
