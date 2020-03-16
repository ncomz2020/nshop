package com.ncomz.nshop.utillty;

import static org.mockito.Matchers.anyString;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibm.icu.util.ChineseCalendar;

public class HolidayUtil {
	
	private static Logger logger = LoggerFactory.getLogger(NumberUtil.class);
	
	
	private static String[] solarArr = new String[]{"0101", "0301", "0505", "0606", "0815", "1225"};
    private static String[] lunarArr = new String[]{"0101", "0102", "0408", "0814", "0815", "0816"};
    
    /**
     * 해당일자가 법정공휴일, 대체공휴일, 토요일, 일요일인지 확인
     * @param date 양력날짜 (yyyyMMdd)
     * @return 법정공휴일, 대체공휴일, 일요일이면 true, 오류시 false
     */
    public static boolean isHoliday(String date) {
        try {
            return isHolidaySolar(date) || isHolidayLunar(date) || isHolidayAlternate(date) || isWeekend(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 토요일 또는 일요일이면 true를 리턴한다.
     * @param date 양력날짜 (yyyyMMdd)
     * @return 일요일인지 여부
     * @throws ParseException
     */
    private static boolean isWeekend(String date) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar cal = Calendar.getInstance();
        cal.setTime(sdf.parse(date));
        return cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY || cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY;
    }
    
    /**
     * 해당일자가 대체공휴일에 해당하는 지 확인
     * @param 양력날짜 (yyyyMMdd)
     * @return 대체 공휴일이면 true
     */
    private static boolean isHolidayAlternate(String date) {
        
        String[] altHoliday = new String[] {
                "20150929", "20160210", "20170130", "20180613", "20180926", 
                "20180507", "20190506", "20200127", "20220912", 
                "20230124", "20240212", "20240506", "20251008", 
                "20270209", "20290924", "20290507"}; 
        
        return Arrays.asList(altHoliday).contains(date); 
    }
    
    /**
     * 해당일자가 음력 법정공휴일에 해당하는 지 확인
     * @param 양력날짜 (yyyyMMdd)
     * @return 음력 공휴일이면 true
     */
    private static boolean isHolidayLunar(String date) {
        try {
            Calendar cal = Calendar.getInstance();
            ChineseCalendar chinaCal = new ChineseCalendar();
            
            cal.set(Calendar.YEAR, Integer.parseInt(date.substring(0, 4)));
            cal.set(Calendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
            cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6)));
            
            chinaCal.setTimeInMillis(cal.getTimeInMillis());
            
            // 음력으로 변환된 월과 일자
            int mm = chinaCal.get(ChineseCalendar.MONTH) + 1;
            int dd = chinaCal.get(ChineseCalendar.DAY_OF_MONTH);
            
            StringBuilder sb = new StringBuilder();
            sb.append(String.format("%02d", mm));
            sb.append(String.format("%02d", dd));
                        
            // 음력 12월의 마지막날 (설날 첫번째 휴일)인지 확인
            if (mm == 12) {
                int lastDate = chinaCal.getActualMaximum(ChineseCalendar.DAY_OF_MONTH);
                if (dd == lastDate) {
                    return true;
                }
            }
 
            // 음력 휴일에 포함되는지 여부 리턴
            return Arrays.asList(lunarArr).contains(sb.toString()); 
        } catch(Exception ex) {
            System.out.println(ex.getStackTrace());
            return false;
        }
    }
 
 
    /**
     * 해당일자가 양력 법정공휴일에 해당하는 지 확인
     * @param date 양력날짜 (yyyyMMdd)
     * @return 양력 공휴일이면 true
     */
    private static boolean isHolidaySolar(String date) {
        try {
            // 공휴일에 포함 여부 리턴 
            return Arrays.asList(solarArr).contains(date.substring(4));
        } catch(Exception ex) {
            System.out.println(ex.getStackTrace());
            return false;
        }
    }
    
    
    /**
     * 음력날짜를 양력날짜로 변환
     * @param 음력날짜 (yyyyMMdd)
     * @return 양력날짜 (yyyyMMdd)
     */
    private static String convertLunarToSolar(String yyyymmdd) {
        ChineseCalendar cc = new ChineseCalendar();
        Calendar cal = Calendar.getInstance();
 
        if (yyyymmdd == null)
            return "";
 
        String date = yyyymmdd.trim();
        if (date.length() != 8) {
            if (date.length() == 4)
                date = date + "0101";
            else if (date.length() == 6)
                date = date + "01";
            else if (date.length() > 8)
                date = date.substring(0, 8);
            else
                return "";
        }
 
        cc.set(ChineseCalendar.EXTENDED_YEAR, Integer.parseInt(date.substring(0, 4)) + 2637);
        cc.set(ChineseCalendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
        cc.set(ChineseCalendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6)));
        
        cal.setTimeInMillis(cc.getTimeInMillis());
 
        int y = cal.get(Calendar.YEAR);
        int m = cal.get(Calendar.MONTH) + 1;
        int d = cal.get(Calendar.DAY_OF_MONTH);
 
        StringBuffer ret = new StringBuffer();
        ret.append(String.format("%04d", y));
        ret.append(String.format("%02d", m));
        ret.append(String.format("%02d", d));
 
        return ret.toString();
    }
    
    /**
     * 양력날짜의 요일을 리턴
     * @param 양력날짜 (yyyyMMdd)
     * @return 요일(int)
     */
    private static int getDayOfWeek(String day) {
        int y = Integer.parseInt(day.substring(0, 4));
        int m = Integer.parseInt(day.substring(4, 6)) - 1;
        int d = Integer.parseInt(day.substring(6));
        Calendar c = Calendar.getInstance();
        c.set(y, m, d);
        return c.get(Calendar.DAY_OF_WEEK);
    }
    
    /**
     * n영업일 이후의 날짜를 리턴
     * @param countDay		countDay n영업일 
     * @param dataFormat	날짜형식
     * @return	n영업일 이후의 날짜 dataFormat형식
     */
    public static String getBusinessDay(int countDay, String dataFormat){
    	int businessDayCount = 0;
    	String nowDate = "";
    	
    	Calendar calendar = Calendar.getInstance();
    	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");	//yyyyMMdd
    	String bDate ="";
    	bDate = format.format(calendar.getTime());
    	
    	while(businessDayCount < countDay){
    		calendar.add(calendar.DATE, +1);
    		bDate = format.format(calendar.getTime());
    		if(!isHoliday(bDate)){
    			businessDayCount++;
    		}
    	}
    	
    	if(!"yyyyMMdd".equals(dataFormat)){
    		format = new SimpleDateFormat(dataFormat);
    		bDate = format.format(calendar.getTime());
    	}
    	return bDate;
    }
    
   public static void main(String[] args) {
    	// +2 영업일 구하기
	   System.out.println(getBusinessDay(2,"yyyyMMdd"));
	   System.out.println(getBusinessDay(10, "yyyy-MM-dd"));
	}

}
