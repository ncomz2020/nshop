package com.ncomz.nshop.dao.admin.settlement;

import java.util.List;
import org.springframework.stereotype.Component;

import com.ncomz.nshop.domain.admin.settlement.SettlementHistInfo;
import com.ncomz.nshop.domain.admin.settlement.SettlementInfo;

@Component
public interface SettlementHistMapper {
	int insertCalCulHistAction(SettlementHistInfo settlementHistInfo);
	
	List<SettlementHistInfo> getCalculHistList(SettlementInfo settlementInfo);
}
