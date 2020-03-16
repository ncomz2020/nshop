package com.ncomz.nshop.service.common;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nshop.dao.common.CommonMapper;

@Service
public class CommonService {
	@Autowired
	private CommonMapper commonMapper;
	
	/**한달전
	 * @return
	 */
	public String getStartDate() {
		return commonMapper.getStartDate();
	}
	
	/**오늘날짜
	 * @return
	 */
	public String getEndDate() {
		return commonMapper.getEndDate();
	}
	
	/**상점 콤보 조회
	 * @return
	 */
	public List<Map<String, String>> listApprovalState(String grpCd){
		return commonMapper.listApprovalState(grpCd);
	}
}
