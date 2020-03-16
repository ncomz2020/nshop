package com.ncomz.nshop.service.admin.common.code;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.ncomz.nshop.dao.admin.common.code.CodeMapper;
import com.ncomz.nshop.domain.Consts;
import com.ncomz.nshop.domain.admin.common.Code;
import com.ncomz.nshop.domain.admin.common.Menu;
import com.ncomz.nshop.domain.admin.common.UserGroup;
import com.ncomz.nshop.domain.common.DynatreeNode;
import com.ncomz.nshop.utillty.MessageUtil;
import com.ncomz.nshop.utillty.StringUtil;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

@Service
public class CodeService {

	@Autowired
	private CodeMapper codeMapper;
	
	public DynatreeNode getTreeAction() {
		Locale locale = LocaleContextHolder.getLocale();
		String language = locale.getLanguage();
		Code code = new Code();
		code.setLanguage(language);
		
		DynatreeNode root = new DynatreeNode();
		root.setKey("0");
		root.setTitle(MessageUtil.getMessage("label.code.manage"));
		root.setIsFolder(true);
		root.setChildren(this.buildTree(codeMapper.getCodeList(code), "0", 1));
		return root;
	}
	
	public List<DynatreeNode> buildTree(List<Code> codeList, String grp_cd, int depth) {
		List<DynatreeNode> tree = new ArrayList<DynatreeNode>();
		for (int i=0;i<codeList.size();i++) {
			Code code = codeList.get(i);
			if (StringUtil.compare(code.getGrp_cd(), grp_cd) == 0 && StringUtil.parseInt(code.getDepth()) == depth) {
				DynatreeNode node = new DynatreeNode();
				node.setKey(code.getDtl_cd());
				node.setTitle(code.getDtl_nm());
				List<DynatreeNode> children = this.buildTree(codeList, code.getDtl_cd(), depth+1);
				if (children.size() > 0) {
					node.setIsFolder(true);
				}
				if (StringUtil.CompareNoCase(code.getUse_yn(), "N") == 0) {
					node.setAddClass("node_font_red");
				}
				node.setChildren(children);
				tree.add(node);
			}
		}
		return tree;
	}
	
	@Transactional
	public String insertAction(Code code) {
		try {
			if (codeMapper.checkDuplicate(code) > 0) {
				return "이미 존재하는 코드입니다.";
			}
			codeMapper.insertCode(code);
			
			String[] languageCode = code.getLanguageCode();
			String[] languageTitle = code.getLanguageTitle();
			for (int i=0;i<languageCode.length;i++) {
				Code codeLanguage = new Code();
				codeLanguage.setGrp_cd(code.getGrp_cd());
				codeLanguage.setDepth(code.getDepth());
				codeLanguage.setDtl_cd(code.getDtl_cd());
				codeLanguage.setLanguage(languageCode[i]);
				codeLanguage.setDtl_nm(languageTitle[i]);
				codeMapper.insertCodeLanguage(codeLanguage);
			}
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public Code getCode(Code code) {
		return codeMapper.getCode(code);
	}
	
	@Transactional
	public String updateAction(Code code) {
		try {
			codeMapper.updateCodeInfo(code);
			
			codeMapper.deleteCodeLanguage(code);
			
			String[] languageCode = code.getLanguageCode();
			String[] languageTitle = code.getLanguageTitle();
			for (int i=0;i<languageCode.length;i++) {
				Code codeLanguage = new Code();
				codeLanguage.setGrp_cd(code.getGrp_cd());
				codeLanguage.setDepth(code.getDepth());
				codeLanguage.setDtl_cd(code.getDtl_cd());
				codeLanguage.setLanguage(languageCode[i]);
				codeLanguage.setDtl_nm(languageTitle[i]);
				codeMapper.insertCodeLanguage(codeLanguage);
			}
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String moveAction(Code code) {
		try {
			Code old = codeMapper.getCode(code);
			// 기존 부모 하위의 display_order 를 업데이트
			codeMapper.updateOldDisplayOrders(old);
			
			// 새로운 부모 하위의 display_order 를 업데이트
			codeMapper.updateNewDisplayOrders(code);
			
			// category 위치 업데이트
			codeMapper.updateCodePosition(code);
			
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String deleteAction(Code code) {
		try {
			if (codeMapper.getChildrenCount(code) > 0) {
				return "하위 코드가 존재하는 코드를 삭제할 수 없습니다.";
			}
			codeMapper.deleteCodeInfo(code);
			codeMapper.deleteCodeLanguage(code);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	@Transactional
	public String updateUseYnAction(Code code) {
		try {
			codeMapper.updateCodeUseYn(code);
			return "succ";
		} catch (Exception ex) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}
	
	public List<Code> getLanguageList() {
		return codeMapper.getGroupCodeList(Consts.LanguageCode.GROUPCODE);
	}
	
	public List<Code> getCodeLanguageList(Code code) {
		return codeMapper.getCodeLanguageList(code);
	}
	
}
