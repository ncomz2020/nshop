package com.ncomz.nshop.utillty;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelViewer extends AbstractExcelView {

	Logger log;

	HSSFWorkbook workbook = null;

	public ExcelViewer() {
		this.log = LoggerFactory.getLogger(this.getClass());
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		this.workbook = workbook;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		List<LinkedHashMap<String, String>> list = (List<LinkedHashMap<String, String>>) model.get("list");
		this.buildExcelSheet(workbook, list);

		Date now = new Date();
		String uri = request.getRequestURI();
		String sFileName = StringUtil.getFileName(uri);
		StringBuilder filename = new StringBuilder();
		filename.append(sFileName+ "-" + format.format(now) + ".xls");
		filename.insert(0, "attachment; filename=\"");
		filename.append('\"');
		response.setHeader("Content-Disposition", filename.toString());
	}

	private void buildExcelSheet(Workbook workbook, List<LinkedHashMap<String, String>> list) {
		int nMaxRow = 65536;
		// nMaxRow = 100;

		List<List<LinkedHashMap<String, String>>> listList = new ArrayList<List<LinkedHashMap<String, String>>>();
		if (list != null) {
			int nSize = list.size();
			if (nSize >= nMaxRow) {
				// 65535 건 초과시
				List<LinkedHashMap<String, String>> sheetList = new ArrayList<LinkedHashMap<String, String>>();
				for (int i = 0; i < nSize; i++) {
					sheetList.add(list.get(i));
					if (((i + 1) % (nMaxRow - 1) == 0) || i == nSize - 1) {
						// 엑셀 최대 행은 65536, Title 행이 있으므로 65535 건마다 sheet 를 새로 만듬
						listList.add(sheetList);
						sheetList = new ArrayList<LinkedHashMap<String, String>>();
					}
				}
			} else {
				listList.add(list);
			}
		}

		CellStyle csString = workbook.createCellStyle();
		csString.setDataFormat(HSSFDataFormat.getBuiltinFormat((String) "text"));
		csString.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		this.setBorder(csString);

		CellStyle csInt = workbook.createCellStyle();
		csInt.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		csInt.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		this.setBorder(csInt);

		CellStyle csFloat = workbook.createCellStyle();
		csFloat.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
		csFloat.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		this.setBorder(csFloat);

		int sheetIndex = 0;
		for (List<LinkedHashMap<String, String>> sheetList : listList) {
			Sheet sheet = workbook.createSheet();
			if (sheetIndex == 0) {
				if (sheetList.size() == 0) {
					Row row = sheet.createRow(0);
					Cell cell = row.createCell(0);
					cell.setCellValue(MessageUtil.getMessage("label.common.empty.list"));
					break;
				}
			}
			int rowNum = 0;
			Row headerRow = sheet.createRow(rowNum++);
			this.buildTitleRow(headerRow, sheetList);

			for (LinkedHashMap<String, String> rowData : sheetList) {
				Row dataRow = sheet.createRow(rowNum++);
				int cellIndex = 0;
				for (String title : list.get(0).keySet()) {
					Cell cell = dataRow.createCell(cellIndex);
					String value = String.valueOf(rowData.get(title));
					if (StringUtil.isInteger(value)) {
						cell.setCellStyle(csInt);
						cell.setCellValue(Double.parseDouble(value));
					} else if (StringUtil.isFloat(value)) {
						cell.setCellStyle(csFloat);
						cell.setCellValue(Double.parseDouble(value));
					} else if (StringUtil.isLong(value)) {
						cell.setCellStyle(csInt);
						cell.setCellValue(Integer.parseInt(value));
					} else {
						cell.setCellStyle(csString);
						cell.setCellValue(value);
					}
					cellIndex++;
				}
			}

			if (sheetList != null && sheetList.size() > 0) {
				for (int i = 0; i < sheetList.get(0).keySet().size(); i++) {
					sheet.autoSizeColumn(i);
					sheet.setColumnWidth(i, (sheet.getColumnWidth(i) + 512));
				}
			}

			sheetIndex++;
		}
	}
	
	private void setBorder(CellStyle cellStyle) {
		cellStyle.setBorderTop(CellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
		cellStyle.setBorderRight(CellStyle.BORDER_THIN);
		cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
	}

	private void buildTitleRow(Row row, List<LinkedHashMap<String, String>> list) {
		Font font = this.workbook.createFont();
		font.setColor(HSSFColor.WHITE.index);

		CellStyle cellStyle = this.workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat((String) "text"));
		cellStyle.setFillForegroundColor(HSSFColor.BLACK.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		cellStyle.setFont(font);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		if (list == null || list.size() == 0) {
			return;
		}
		int cellIndex = 0;
		for (String title : list.get(0).keySet()) {
			Cell cell = row.createCell(cellIndex);
			cell.setCellStyle(cellStyle);
			cell.setCellValue(MessageUtil.getMessage(title.replaceAll("_", ".")));
			cellIndex++;
		}
	}

}