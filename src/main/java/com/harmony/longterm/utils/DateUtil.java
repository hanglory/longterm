package com.harmony.longterm.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

/**
 * <pre>
 * 설명 : date util
 * com.moneta.common
 *   |_ DateUtil.java
 * </pre>
 * @Author  : 224ok
 * @Date    : 2017. 3. 24.
 * @History
 *  이름     : 일자          : 변경내용
 * ------------------------------------------------------
 *  224ok : 2017. 3. 24. : 신규 개발.
 */
public class DateUtil {

    /**
     * 현재시간 형식에 맞춰 가져오기
     * @param pattern (yyyyMMddHHmmss)
     * @return String
     */
    public static String getCurrentTimeFormat(String pattern){
        Calendar current = Calendar.getInstance();
        SimpleDateFormat fmt = new SimpleDateFormat(pattern);
        String date = fmt.format(current.getTime());

        return date;
    }

    /**
     * 현재날짜 형식에 맞춰 가져오기
     * @param formatString
     * @return
     */
    public static String getCurDate(String formatString){
        SimpleDateFormat formatter  = new SimpleDateFormat(formatString);
        Date currentTime= new Date();
        return formatter.format(currentTime);
    }

    /**
     * 현재날짜 형식에 맞춰 가져오기
     * @param formatString
     * @return
     */
    public static String getDateFormat(Date date, String formatString){
        SimpleDateFormat formatter  = new SimpleDateFormat(formatString);
        return formatter.format(date);
    }

    public static Date getConvertStringToDate(String dateTxt, String formatString) throws ParseException {
        DateFormat format = new SimpleDateFormat(formatString);
        Date parsed = format.parse(dateTxt);
        java.sql.Date sqlDt = new java.sql.Date(parsed.getTime());
        return sqlDt;
    }

    /**
     * 날짜비교. 현재날짜보다 작은지
     * @param paramDateTxt
     * @return (크면거나 같으면 true / 작으면 false)
     * @throws ParseException
     */
    public static boolean isAfterDay(String paramDateTxt) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String paramDate = paramDateTxt.replaceAll("-", "");

        Date curDate = new Date();
        String curDateTxt = dateFormat.format(curDate);

        if(curDateTxt.compareTo(paramDate)==1)return false;

        return true;
    }

    /**
     * 날짜비교, 이미 종료되었는지 체크
     * @param paramDateTxt
     * @return (크면 true / 작거나 같으면 false)
     * @throws ParseException
     */
    public static boolean isOverDate(String paramDateTxt) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String paramDate = paramDateTxt.replaceAll("-", "");

        Date curDate = new Date();
        String curDateTxt = dateFormat.format(curDate);

        if(0 < curDateTxt.compareTo(paramDate))return true;

        return false;
    }


	public static String getTodayDate()
	{
		Calendar cal = new GregorianCalendar();

		String months[] = { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"};
		int year = cal.get(Calendar.YEAR);
		String month = months[cal.get(Calendar.MONTH)];
		int day = cal.get(Calendar.DATE);

		String sYear = String.valueOf(year);
		String sDay = "";
		if(day < 10){
			sDay = "0"+ String.valueOf(day);
		}else{
			sDay = String.valueOf(day);
		}
		String today = sYear+month+sDay;
		return today;
	}

	public static String getTodayWithHMS() {
		return fullformat(new Date());
	}

	public static String fullformat(Date date) {
		SimpleDateFormat FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return FORMAT.format(date);
	}

	public static String getTodayWithHMS3() {
		SimpleDateFormat FORMAT = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return FORMAT.format(new Date());
	}

	public static String getWriteDate(String todayTime, String szTime) {
		String writeDate="";
		//long tDate = System.currentTimeMillis();
		long tDate=0;
		long tDayDate=0; //오늘 자정 기준의 시간.

		if("".equals(todayTime)) {
			//tDate = new SimpleDateFormat("yyyyMMddHHmmss").parse(getSysDate(System.currentTimeMillis()/1000L,"e"), new ParsePosition(0)).getTime();
			tDate = System.currentTimeMillis();
			tDayDate = new SimpleDateFormat("yyyyMMddHHmmss").parse(getTodayDate()+"000000", new ParsePosition(0)).getTime();

		}else {
			tDate = new SimpleDateFormat("yyyyMMddHHmmss").parse(todayTime, new ParsePosition(0)).getTime();
		}

		long wDate = new SimpleDateFormat("yyyyMMddHHmmss").parse(szTime, new ParsePosition(0)).getTime();

		if(tDate-wDate>0) {

				tDayDate = tDayDate+(1000*60*60*24);					//다음날 자정 기준의 시간

				if((tDayDate-wDate)/(1000*60*60*24)>=1){
					writeDate = (tDayDate-wDate)/(1000*60*60*24)+"일전";
				}else{
					writeDate = "오늘";
				}
		}else {
			writeDate=tDate-wDate+"";
		}

		return writeDate;
	}

	public static String getSysDate(long szTime, String gubun ){
		String date = "";
		if(szTime>0) {
		}else {
			szTime = System.currentTimeMillis()/1000L;
		}
		if("a".equals(gubun)) {
			date = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date(szTime*1000));
		}else if("b".equals(gubun)) {
			date = new SimpleDateFormat("yyyy/MM/dd").format(new Date(szTime*1000));
		}else if("c".equals(gubun)) {
			date = new SimpleDateFormat("HH:mm:ss").format(new Date(szTime*1000));
		}else if("d".equals(gubun)) {
			date = new SimpleDateFormat("HH:mm").format(new Date(szTime*1000));
		}else if("e".equals(gubun)) {
			date = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date(szTime*1000));
		}else if("f".equals(gubun)) {
			date = new SimpleDateFormat("MM.dd HH:mm").format(new Date(szTime*1000));
		}else if("g".equals(gubun)) {
			date = new SimpleDateFormat("yyyyMMddHHmm").format(new Date(szTime*1000));
		}
		return date;
	}

	/**
	* UTC
	*/
	public static String getDate(long szTime, boolean type){
		SimpleDateFormat dfOnlyDate = new SimpleDateFormat("yyyy/MM/dd") ;
		SimpleDateFormat dfOnlyTime = new SimpleDateFormat("HH:mm") ;

		java.util.Date newDate = new java.util.Date( szTime * 1000 );
		if( type)
			return dfOnlyDate.format( newDate );
		else
			return dfOnlyTime.format( newDate );
	}

	public static String getDate2(long szTime){
		SimpleDateFormat dfOnlyDate = new SimpleDateFormat("MM/dd") ;
		java.util.Date newDate = new java.util.Date( szTime * 1000 );
		return dfOnlyDate.format( newDate );
	}

	public static String getDateTime(long szTime){
		SimpleDateFormat dfDateTime = new SimpleDateFormat("yyyy/MM/dd HH:mm") ;
		java.util.Date newDate = new java.util.Date( szTime * 1000 );
		return dfDateTime.format( newDate );
	}

	public static String getTradeDateMMDD(long szTime){
		SimpleDateFormat dfOnlyDate = new SimpleDateFormat("MM월dd일") ;
		java.util.Date newDate = new java.util.Date( szTime * 1000 );
		return dfOnlyDate.format( newDate );
	}

	public static String getDateMMDD(long szTime){
		SimpleDateFormat dfOnlyDate = new SimpleDateFormat("MM월dd일") ;
		java.util.Date newDate = new java.util.Date( szTime * 1000 );
		return dfOnlyDate.format( newDate );
	}

	//UTC형의 날짜 값을 해당 날짜 형식으로 변환
	public static String getTradeDate(long szTime, boolean type){
		SimpleDateFormat dfOnlyDate = new SimpleDateFormat("yyyy/MM/dd") ;
		SimpleDateFormat dfOnlyTime = new SimpleDateFormat("HH:mm") ;
		java.util.Date newDate = new java.util.Date(szTime * 1000);

		if( szTime <= 0){
				return "";
		}
		else{
			if( type)
				return dfOnlyDate.format(newDate);
			else
				return dfOnlyTime.format(newDate);
		}
	}

/*	public static String getTradeTimeTypeA(){
		return getTradeTimeTypeA(null);
	}

	public static String getTradeTimeTypeA(String szCode){
		String szTradeTimeStr	= "";
		int szTradeTime 		= 0;
		int szMarket 			= -1;

		if(szCode==null){
			szCode = "KRI001000000"; //기본코스피지수로 통일
		}

		try{
			SiseCache siseCache = SiseCacheManager.getInstance();
			PaxfeedPacketTrade ptksp = siseCache.getTradeReal(szCode);
			szMarket = ptksp.getMarket();
			szTradeTime = ptksp.getTradeTime();

			if(szMarket==1 || szMarket==2){
				szTradeTimeStr = "개장전 "+getTradeDateMMDD(szTradeTime)+"";
			}
			else if(szMarket==3){
				szTradeTimeStr = "장중/실시간 "+getTradeDate(szTradeTime, false)+"";
			}
			else{
				szTradeTimeStr = "장마감 "+getTradeDateMMDD(szTradeTime)+"";
			}
		}
		catch( Exception e ){
		}

		return szTradeTimeStr;
	}*/

	 public static String formatDateTime( String str, String sep1, String sep2 ) {
	   	if( str == null || str.length() != 14 ) return "";
	   		return str.substring(0,4) + sep1 + str.substring(4,6) + sep1 + str.substring(6,8)
	   		+ " " + str.substring(8,10) + sep2 + str.substring(10,12) + sep2 + str.substring(12,14);
	 }

	 /**
	     * 시스템 날짜에 n월을 더해서(혹은 빼서) "YYYYMMDD" 포맷으로 리턴
	     *
	     * @param 더할(혹은 뺄) 월수
	     * @return "YYYYMMDD" 형식의 8자리 날짜
	     */
/*	 public static String addMonthToSysdate(int iAddMonth) {

		 TimeZone timeZone = TimeZone.getTimeZone("GMT+09:00");
	     Calendar calendar = Calendar.getInstance(timeZone, Locale.KOREA);

	     calendar.add(Calendar.MONTH, iAddMonth);

	     String strRslt = Integer.toString(calendar.get(Calendar.YEAR))
	                  + StringUtil.get2ByteInt(calendar.get(Calendar.MONTH) + 1)
	                  + StringUtil.get2ByteInt(calendar.get(Calendar.DATE));
	     return strRslt;
	 }*/

	 public static String addDays(long szTime, int days) {
		Date date = null;
		if(szTime>0) {
		}else {
			szTime = System.currentTimeMillis()/1000L;
		}
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		date = new Date(szTime*1000);
		date.setTime(date.getTime() + days * 1000L * 60L * 60L * 24L);

		return fmt.format(date);
    }

	public static String addDays(String datetime, int days) {
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = fmt.parse(datetime);
			date.setTime(date.getTime() + days * 1000L * 60L * 60L * 24L);
			datetime = fmt.format(date);
		} catch (ParseException e) {
			datetime = getTodayWithHMS();
		}

		return datetime;
	}

	public static long getSysLongDate(String todayTime) {
		long tDate=0;

		if("".equals(todayTime)) {
			tDate = System.currentTimeMillis();
		}else {
			tDate = new SimpleDateFormat("yyyyMMddHHmmss").parse(todayTime, new ParsePosition(0)).getTime();
		}
		return tDate;
	}

	/* timeZone 적용한 시간을 return */
	public static String getTimeOfTimezone( long time, String timezone, String format ) {

		 long publishMillis = time * 1000L;
		 Calendar calPublishImsi = Calendar.getInstance();
		 calPublishImsi.setTimeInMillis(publishMillis);

		 SimpleDateFormat sdfDebug = new SimpleDateFormat(format);	//"yyyy/MM/dd HH:mm:ss z"
		 sdfDebug.setTimeZone(TimeZone.getTimeZone("GMT"));

		 String strRemoteTimezoneID = timezone;
		 sdfDebug.setTimeZone(TimeZone.getTimeZone(strRemoteTimezoneID));
		 String strLocaltime = sdfDebug.format(calPublishImsi.getTime());

		 return strLocaltime;
	}

	/* Day 일 이전 날짜 */
	public static String preDay(int day){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, -day);

		String time = sdf.format(cal.getTime());
		return time;
	}
	/* Day 일 이전 날짜 포멧팅 */
	public static String preDay(int day, String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.KOREA);
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, -day);

		String time = sdf.format(cal.getTime());
		return time;
	}

	/* Day 일 이후의 날짜 */
	public static String nextDay(int day){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, day);

		String time = sdf.format(cal.getTime());
		return time;
	}

	public static long longNextDay(String day) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		Date date = sdf.parse(day);
		long time = date.getTime();

		return time;
	}

	public static long longToday() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		Date date = new Date();
		String temp = sdf.format(date);
		Date date2 = sdf.parse(temp);
		long time = date2.getTime();

		return time;
	}


	public static String addMin(String datetime, int minute) throws Exception {
		SimpleDateFormat FORMAT = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

		Calendar cal = Calendar.getInstance();
		cal.setTime(FORMAT.parse(datetime));
		cal.add(Calendar.MINUTE, minute);
		return FORMAT.format(cal.getTime());
	}

}
