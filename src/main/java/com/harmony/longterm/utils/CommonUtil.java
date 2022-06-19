package com.harmony.longterm.utils;

/*      */ import java.io.BufferedReader;
/*      */ import java.io.File;
/*      */ import java.io.IOException;
/*      */ import java.io.InputStream;
/*      */ import java.io.InputStreamReader;
/*      */ import java.io.UnsupportedEncodingException;
/*      */ import java.lang.reflect.Array;
/*      */ import java.net.MalformedURLException;
/*      */ import java.net.URL;
/*      */ import java.net.URLConnection;
/*      */ import java.net.URLDecoder;
/*      */ import java.net.URLEncoder;
/*      */ import java.text.DecimalFormat;
/*      */ import java.text.ParseException;
/*      */ import java.text.SimpleDateFormat;
/*      */ import java.util.Arrays;
/*      */ import java.util.Calendar;
/*      */ import java.util.Collection;
/*      */ import java.util.Date;
/*      */ import java.util.Enumeration;
/*      */ import java.util.HashMap;
/*      */ import java.util.HashSet;
/*      */ import java.util.Iterator;
/*      */ import java.util.List;
/*      */ import java.util.Map;
/*      */ import java.util.UUID;
/*      */ import javax.servlet.http.Cookie;
/*      */ import javax.servlet.http.HttpServletRequest;
/*      */ import javax.servlet.http.HttpServletResponse;
/*      */ import org.apache.commons.lang.StringUtils;
/*      */ import org.json.JSONArray;
/*      */ import org.json.JSONException;
/*      */ import org.json.JSONObject;

public class CommonUtil {
	/*      */   public static boolean isFormatDate(String checkDate, String StrFormat) {
		/*      */     try {
		/*   72 */       SimpleDateFormat dateFormat = new SimpleDateFormat(StrFormat);
		/*      */       
		/*   74 */       dateFormat.setLenient(false);
		/*   75 */       dateFormat.parse(checkDate);
		/*   76 */       return true;
		/*      */     }
		/*   78 */     catch (ParseException e) {
		/*   79 */       return false;
		/*      */     } 
		/*      */   }

		/*      */   public static boolean isFormatDate(String checkDate) {
		/*   86 */     return isFormatDate(checkDate, "yyyy/MM/dd");
		/*      */   }
		/*      */ 
		/*      */   public static boolean isNumberic(String s) {
		/*      */     try {
		/*   92 */       Double.parseDouble(s);
		/*   93 */       return true;
		/*   94 */     } catch (NumberFormatException e) {
		/*   95 */       return false;
		/*      */     } 
		/*      */   }
		/*      */ 
		/*      */   public static int getMonthsDifference(String strDate1, String strDate2) {
		/*  102 */     int nRlt = 0;
		/*      */     
		/*  104 */     SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		/*      */     try {
		/*  110 */       Date date1 = format.parse(strDate1);
		/*  111 */       Date date2 = format.parse(strDate2);
		/*      */ 
		/*      */       
		/*  114 */       int month1 = date1.getYear() * 12 + date1.getMonth();
		/*  115 */       int month2 = date2.getYear() * 12 + date2.getMonth();
		/*      */       
		/*  117 */       nRlt = month2 - month1;
		/*      */     }
		/*  119 */     catch (ParseException e) {
		/*  120 */       System.out.println(e);
		/*      */     } 
		/*      */     
		/*  123 */     return nRlt;
		/*      */   }

		/*      */   public static long LongMax(Map mapReq, String Field, long nCompare) {
		/*  131 */     long nRetVal = 0L;
		/*      */     try {
		/*  135 */       nRetVal = nvlLong(nvlMap(mapReq, Field), 0);
		/*      */       
		/*  137 */       if (nRetVal < nCompare)
		/*      */       {
		/*  139 */         nRetVal = nCompare;
		/*      */       
		/*      */       }
		/*      */     }
		/*  143 */     catch (Exception exception) {}
		/*      */     
		/*  147 */     return nRetVal;
		/*      */   }
		/*      */   
		/*      */   public static String getMinuteFormat(String strMinute) {
		/*  155 */     String strVal = "";
		/*      */     try {
		/*  159 */       if (!isNumeric(strMinute)) {
		/*  160 */         return "00:00";
		/*      */       }
		/*      */       
		/*  163 */       int nMinute = Integer.parseInt(strMinute);
		/*  165 */       strVal = String.valueOf(String.format("%02d", new Object[] { Integer.valueOf(nMinute / 60) })) + ":" + String.format("%02d", new Object[] { Integer.valueOf(nMinute % 60) });
		/*      */     
		/*      */     }
		/*  168 */     catch (Exception exception) {}
		/*      */     
		/*  170 */     return strVal;
		/*      */   }
		/*      */   
		/*      */   public static void setPageParam(Map mapReq) {
		/*  188 */     setPageParam(mapReq, 15);
		/*      */   }
		/*      */   
		/*      */   public static void setPageParam(Map<String, Integer> mapReq, int nPageRowCount) {
		/*  193 */     if (mapReq == null) {
		/*      */       return;
		/*      */     }
		/*      */     try {
		/*  197 */       int nCurrPage = getPageNow(mapReq, "page_now");
		/*      */       
		/*  199 */       if (nCurrPage <= 0) {
		/*  200 */         nCurrPage = 1;
		/*      */         
		/*  202 */         mapReq.put("page_now", Integer.valueOf(nCurrPage));
		/*      */       } 
		/*      */       
		/*  205 */       int nStartRow = (nCurrPage - 1) * nPageRowCount + 1;
		/*  206 */       int nEndRow = nCurrPage * nPageRowCount;
		/*      */       
		/*  208 */       mapReq.put("start_row", Integer.valueOf(nStartRow - 1));
		/*      */       
		/*  210 */       mapReq.put("end_row", Integer.valueOf(nPageRowCount));
		/*  211 */       mapReq.put("nPageRowCount", Integer.valueOf(nPageRowCount));
		/*      */     }
		/*  213 */     catch (Exception exception) {}
		/*      */   }
		/*      */   
		/*      */   public static int getPageNow(Map<String, Integer> mapReq, String strMapKey) {
		/*  232 */     int nPage = 1;
		/*      */     
		/*  234 */     if (mapReq == null) {
		/*  235 */       return nPage;
		/*      */     }
		/*      */     try {
		/*  238 */       if (mapReq.get(strMapKey) == null) {
		/*  239 */         mapReq.put(strMapKey, Integer.valueOf(1));
		/*      */       }
		/*  241 */       nPage = Integer.parseInt(nvlMap(mapReq, strMapKey, "1"));
		/*  242 */     } catch (Exception e) {
		/*  243 */       nPage = 1;
		/*      */     } 
		/*      */     
		/*  246 */     return nPage;
		/*      */   }
		/*      */   
		/*      */   public static String getUniqueId() {
		/*  261 */     return UUID.randomUUID().toString();
		/*      */   }
		/*      */   
		/*      */   public static String strDupTextRemove(String strVal) {
		/*  267 */     String strRlt = "";
		/*      */ 
		/*      */     
		/*      */     try {
		/*  271 */       if (strVal == null || "".equals(strVal)) {
		/*  272 */         return "";
		/*      */       }
		/*  274 */       String[] arrVal = strVal.split(",");
		/*      */       
		/*  276 */       arrVal = (String[])(new HashSet(Arrays.asList((Object[])arrVal))).toArray((Object[])new String[0]); byte b; int i;
		/*      */       String[] arrayOfString1;
		/*  278 */       for (i = (arrayOfString1 = arrVal).length, b = 0; b < i; ) { String strArrVal = arrayOfString1[b];
		/*      */         
		/*  280 */         if (!"".equals(strRlt)) {
		/*  281 */           strRlt = String.valueOf(strRlt) + ",";
		/*      */         }
		/*  283 */         strRlt = String.valueOf(strRlt) + strArrVal;
		/*      */         b++; }
		/*      */     
		/*  286 */     } catch (Exception e) {
		/*      */       
		/*  288 */       e.printStackTrace();
		/*      */     } 
		/*      */     
		/*  291 */     return strRlt;
		/*      */   }
		/*      */   
		/*      */   public static String HexToString(int nHex) {
		/*  296 */     char bySp = (char)nHex;
		/*  297 */     return Character.toString(bySp);
		/*      */   }
		/*      */   
		/*      */   public static String nl2br(String strVal) {
		/*  301 */     if (strVal == null || "".equals(strVal)) {
		/*  302 */       return "";
		/*      */     }
		/*  304 */     strVal = strVal.replaceAll(System.getProperty("line.separator"), "<br/>");
		/*      */     
		/*  306 */     strVal = strVal.replaceAll("\r\n", "<br/>");
		/*  307 */     strVal = strVal.replaceAll("\n", "<br/>");
		/*  308 */     strVal = strVal.replaceAll("\r", "");
		/*      */     
		/*  310 */     return strVal;
		/*      */   }
		/*      */   
		/*      */   public static Map mapToLower(Map<String, Object> map) {
		/*  315 */     if (map == null || map.isEmpty())
		/*  316 */       return null; 
		/*  317 */     Map<Object, Object> mapRs = new HashMap<>();
		/*      */     
		/*  319 */     for (String strKey : map.keySet()) {
		/*  320 */       String strVal = nvlMap(map, strKey);
		/*  321 */       mapRs.put(strKey.toLowerCase(), strVal);
		/*      */     } 
		/*      */     
		/*  324 */     return mapRs;
		/*      */   }
		/*      */   
		/*      */   public static String substr(String strVal, int nStart, int nEnd) {
		/*      */     try {
		/*  329 */       if (strVal == null || "".equals(strVal)) {
		/*  330 */         return "";
		/*      */       }
		/*  332 */       int nLen = strVal.length();
		/*      */       
		/*  334 */       if (nLen < nEnd) {
		/*  335 */         return "";
		/*      */       }
		/*  337 */       strVal = strVal.substring(nStart, nEnd);
		/*  338 */     } catch (Exception e) {
		/*  339 */       strVal = "";
		/*      */     } 
		/*      */     
		/*  342 */     return strVal;
		/*      */   }
		/*
		 *    public static Map getRequestMap(HttpServletRequest request) {
		     HashMap<Object, Object> reqMap = new HashMap<>();
		try {
		String strParamKey = "";
		SessionBox box = new SessionBox(request);
		if (box != null) {
		reqMap.put("ses_vendor_nid", box.getValue("VENDOR_NID"));
		reqMap.put("ses_emp_nid", box.getValue("EMP_NID"));
		reqMap.put("ses_emp_nm", box.getValue("USER_NM"));
		} 
		reqMap.put("self_url", request.getRequestURI());
		
		Enumeration<String> parameters = request.getParameterNames();
		
		while (parameters.hasMoreElements()) {
		strParamKey = parameters.nextElement();
		String[] arrParamVal = request.getParameterValues(strParamKey);
		
		String strKey = strParamKey.toString();
		strKey = strKey.toLowerCase();
		
		if (arrParamVal.length <= 1) {
		reqMap.put(strKey, (arrParamVal[0] == null) ? "" : removeXSS(arrParamVal[0].trim()));
		
		continue;
		} 
		for (int nLoop = 0; nLoop < arrParamVal.length; nLoop++) {
		arrParamVal[nLoop] = removeXSS(arrParamVal[nLoop]);
		}
		reqMap.put(strKey, arrParamVal);
		}
		
		} catch (Exception e) {
		System.out.println("CommonUtil getRequestMap()" + e.toString());
		} 
		
		return reqMap;
		}
		/*      */   
		/*      */   public static Map getRequestOriginWordMap(HttpServletRequest request) {
		/*  418 */     HashMap<Object, Object> reqMap = new HashMap<>();
		/*      */     try {
		/*  420 */       String strParamKey = "";
		/*      */ 
		/*      */ 
		/*      */       
		/*  424 */       Enumeration<String> parameters = request.getParameterNames();
		/*      */       
		/*  426 */       while (parameters.hasMoreElements()) {
		/*  427 */         strParamKey = parameters.nextElement();
		/*  428 */         String[] arrParamVal = request.getParameterValues(strParamKey);
		/*      */         
		/*  430 */         String strKey = strParamKey.toString();
		/*      */         
		/*  432 */         if (arrParamVal.length <= 1) {
		/*  433 */           reqMap.put(strKey, (arrParamVal[0] == null) ? "" : removeXSS(arrParamVal[0].trim()));
		/*      */           
		/*      */           continue;
		/*      */         } 
		/*  437 */         for (int nLoop = 0; nLoop < arrParamVal.length; nLoop++) {
		/*  438 */           arrParamVal[nLoop] = removeXSS(arrParamVal[nLoop]);
		/*      */         }
		/*  440 */         reqMap.put(strKey, arrParamVal);
		/*      */       }
		/*      */     
		/*  443 */     } catch (Exception e) {
		/*  444 */       System.out.println("CommonUtil getRequestMap()" + e.toString());
		/*      */     } 
		/*      */     
		/*  447 */     return reqMap;
		/*      */   }

		/*      */   public static String getRequestQueryString(HttpServletRequest request, String[] notParam) {
		/*  457 */     String retQueryString = "";
		/*      */     
		/*  459 */     Map parameter = request.getParameterMap();
		/*  460 */     Iterator it = parameter.keySet().iterator();
		/*  461 */     Object paramKey = null;
		/*  462 */     String[] paramValue = null;
		/*      */ 
		/*      */ 
		/*      */     
		/*  466 */     while (it.hasNext()) {
		/*  467 */       paramKey = it.next();
		/*      */       
		/*  469 */       paramValue = (String[])parameter.get(paramKey);
		/*      */       
		/*  471 */       boolean bParam = true;
		/*  472 */       for (int i = 0; i < paramValue.length; i++) {
		/*  473 */         for (int j = 0; j < notParam.length; j++) {
		/*  474 */           if (paramKey.equals(notParam[j])) {
		/*  475 */             bParam = false;
		/*      */           }
		/*      */         } 
		/*  478 */         if (bParam) {
		/*  479 */           retQueryString = String.valueOf(retQueryString) + "&" + paramKey + "=" + paramValue[i];
		/*      */         }
		/*      */       } 
		/*      */     } 
		/*      */     
		/*  484 */     return retQueryString;
		/*      */   }
		/*      */   
		/*      */   public static String mapToParam(Map parameter) {
		/*  489 */     HashMap<Object, Object> map = new HashMap<>();
		/*      */     
		/*  491 */     String retQueryString = "";
		/*      */     
		/*  493 */     Iterator it = parameter.keySet().iterator();
		/*  494 */     Object paramKey = null;
		/*  495 */     Object objVal = null;
		/*      */     
		/*  497 */     String[] paramValue = null;
		/*      */     
		/*  499 */     while (it.hasNext()) {
		/*  500 */       paramKey = it.next();
		/*  501 */       objVal = parameter.get(paramKey);
		/*      */       
		/*  503 */       if (objVal instanceof String[]) {
		/*  504 */         paramValue = (String[])objVal;
		/*      */       } else {
		/*  506 */         paramValue = new String[] { nvl(objVal) };
		/*      */       } 
		/*      */       
		/*      */       try {
		/*  510 */         for (int i = 0; i < paramValue.length; i++) {
		/*  511 */           if (retQueryString.length() > 0) {
		/*  512 */             retQueryString = String.valueOf(retQueryString) + "&";
		/*      */           }
		/*      */           
		/*  515 */           retQueryString = String.valueOf(retQueryString) + paramKey + "=" + paramValue[i];
		/*      */         }
		/*      */       
		/*  518 */       } catch (Exception e) {
		/*      */         
		/*  520 */         e.printStackTrace();
		/*      */       } 
		/*      */     } 
		/*      */     
		/*  524 */     return retQueryString;
		/*      */   }
		/*      */   
		/*      */   public static String getRequestQueryString(HttpServletRequest request) {
		/*  535 */     HashMap<Object, Object> map = new HashMap<>();
		/*      */     
		/*  537 */     String retQueryString = "";
		/*      */     
		/*  539 */     Map parameter = request.getParameterMap();
		/*  540 */     Iterator it = parameter.keySet().iterator();
		/*  541 */     Object paramKey = null;
		/*  542 */     String[] paramValue = null;
		/*      */     
		/*  544 */     while (it.hasNext()) {
		/*  545 */       paramKey = it.next();
		/*      */       
		/*  547 */       paramValue = (String[])parameter.get(paramKey);
		/*      */       
		/*  549 */       for (int i = 0; i < paramValue.length; i++) {
		/*  550 */         if (retQueryString.length() > 0) {
		/*  551 */           retQueryString = String.valueOf(retQueryString) + "&";
		/*      */         }
		/*  553 */         retQueryString = String.valueOf(retQueryString) + paramKey + "=" + paramValue[i];
		/*      */       } 
		/*      */     } 
		/*      */     
		/*  557 */     return retQueryString;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String removeXSS(String strData) {
		/*  562 */     String[] arrSrcCode = { "<", ">", "\"", "'", "%00", "%" };
		/*  563 */     String[] arrTgtCode = { "&lt;", "&gt;", "&#34;", "&#39;", "null;", "&#37;" };
		/*      */     
		/*  565 */     if (strData == null || "".equals(strData)) {
		/*  566 */       return strData;
		/*      */     }
		/*  568 */     for (int nLoop = 0; nLoop < arrSrcCode.length; nLoop++) {
		/*  569 */       strData = strData.replaceAll(arrSrcCode[nLoop], arrTgtCode[nLoop]);
		/*      */     }
		/*      */     
		/*  572 */     return strData;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String DecodeXSSBR(String strData) {
		/*  577 */     String[] arrSrcCode = { "&lt;", "&gt;", "&#34;", "&#39;", "null;", "&#37;", "\\n" };
		/*  578 */     String[] arrTgtCode = { "<", ">", "\"", "'", "%00", "%", "<br />" };
		/*      */     
		/*  580 */     if (strData == null || "".equals(strData)) {
		/*  581 */       return strData;
		/*      */     }
		/*  583 */     for (int nLoop = 0; nLoop < arrSrcCode.length; nLoop++) {
		/*  584 */       strData = strData.replaceAll(arrSrcCode[nLoop], arrTgtCode[nLoop]);
		/*      */     }
		/*      */     
		/*  587 */     return strData;
		/*      */   }
		/*      */   
		/*      */   public static String DecodeXSS(String strData) {
		/*  593 */     String[] arrSrcCode = { "&lt;", "&gt;", "&#34;", "&#39;", "null;", "&#37;", "&quot;" };
		/*  594 */     String[] arrTgtCode = { "<", ">", "\"", "'", "%00", "%", "\"" };
		/*      */     
		/*  596 */     if (strData == null || "".equals(strData)) {
		/*  597 */       return strData;
		/*      */     }
		/*  599 */     for (int nLoop = 0; nLoop < arrSrcCode.length; nLoop++) {
		/*  600 */       strData = strData.replaceAll(arrSrcCode[nLoop], arrTgtCode[nLoop]);
		/*      */     }
		/*      */     
		/*  603 */     return strData;
		/*      */   }
		/*      */   
		/*      */   public static String removeComma(Map mapReq, String strKey) {
		/*  610 */     if (mapReq == null || mapReq.isEmpty()) {
		/*  611 */       return "";
		/*      */     }
		/*  613 */     return removeComma(nvlMap(mapReq, strKey));
		/*      */   }
		/*      */   
		/*      */   public static String removeComma(String strData) {
		/*  620 */     if (strData == null || "".equals(strData)) {
		/*  621 */       return strData;
		/*      */     }
		/*      */     
		/*  624 */     strData = strData.replaceAll(",", "");
		/*      */     
		/*  626 */     return strData;
		/*      */   }
		/*      */   
		/*      */   public static String removeTime(String strTime) {
		/*  633 */     if (strTime == null || "".equals(strTime)) {
		/*  634 */       return strTime;
		/*      */     }
		/*      */     
		/*  637 */     strTime = strTime.replaceAll(":", "");
		/*      */     
		/*  639 */     return strTime;
		/*      */   }
		/*      */ 
		/*      */   public static String[] getMapValArray(Map mapReq, String strField) {
		/*  661 */     Object objVal = mapReq.get(strField);
		/*      */     
		/*  663 */     if (objVal instanceof String[]) {
		/*  664 */       return (String[])mapReq.get(strField);
		/*      */     }
		/*  666 */     return new String[] { nvl(mapReq.get(strField)) };
		/*      */   }
		/*      */   
		/*      */   public static int nvlMapInt(Map objData, String strKey, int nTrans) {
		/*  681 */     String strVal = nvlMap(objData, strKey);
		/*      */     
		/*  683 */     if ("".equals(strVal)) {
		/*  684 */       return nTrans;
		/*      */     }
		/*  686 */     return Integer.parseInt(strVal);
		/*      */   }
		/*      */   
		/*      */   public static int nvlInt(Object objData, int nTrans) {
		/*  700 */     return Integer.parseInt(getNullTrans(objData, nTrans));
		/*      */   }
		/*      */   
		/*      */   public static double nvlDouble(Object objData, int nTrans) {
		/*  713 */     return Double.parseDouble(getNullTrans(objData, nTrans));
		/*      */   }
		/*      */   
		/*      */   public static long nvlLong(Object objData, int nTrans) {
		/*  726 */     return Long.valueOf(getNullTrans(objData, nTrans)).longValue();
		/*      */   }
		/*      */   
		/*      */   public static String getNullTrans(String sData) {
		/*  737 */     return getNullTrans(sData, "");
		/*      */   }
		/*      */   
		/*      */   public static String getNullTrans(String sData, String sTrans) {
		/*  750 */     if (sTrans == null)
		/*  751 */       sTrans = ""; 
		/*  752 */     if (sData != null && !"".equals(sData) && !"null".equals(sData)) {
		/*  753 */       return removeXSS(sData.trim());
		/*      */     }
		/*  755 */     return removeXSS(sTrans);
		/*      */   }
		/*      */   
		/*      */   public static String getNullTrans(Object oData, String sTrans) {
		/*  769 */     if (sTrans == null)
		/*  770 */       sTrans = ""; 
		/*  771 */     if (oData != null && !"".equals(oData) && !"null".equals(oData)) {
		/*  772 */       return removeXSS(oData.toString().trim());
		/*      */     }
		/*  774 */     return removeXSS(sTrans);
		/*      */   }
		/*      */   
		/*      */   public static String getNullTrans(Object oData, int nTrans) {
		/*  778 */     return getNullTrans(oData, Integer.toString(nTrans));
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getFloatComma(Map reqMap, String strField) {
		/*  783 */     if (reqMap == null || reqMap.isEmpty()) {
		/*  784 */       return "";
		/*      */     }
		/*  786 */     String strVal = nvlMap(reqMap, strField);
		/*      */     
		/*  788 */     if ("".equals(strVal)) {
		/*  789 */       return "";
		/*      */     }
		/*  791 */     strVal = getNullTrans(strVal, "0");
		/*      */     
		/*  793 */     DecimalFormat formatter = new DecimalFormat("#,###,###,##0.0");
		/*      */     
		/*  795 */     return formatter.format(Float.parseFloat(strVal));
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getComma(Map reqMap, String strField) {
		/*  800 */     if (reqMap == null || reqMap.isEmpty()) {
		/*  801 */       return "";
		/*      */     }
		/*  803 */     String strVal = nvlMap(reqMap, strField);
		/*      */     
		/*  805 */     if ("".equals(strVal)) {
		/*  806 */       return "";
		/*      */     }
		/*  808 */     strVal = getNullTrans(strVal, "0");
		/*      */     
		/*  810 */     DecimalFormat formatter = new DecimalFormat("#,###,###,##0");
		/*  811 */     return formatter.format(Long.parseLong(strVal));
		/*      */   }
		/*      */   
		/*      */   public static String getComma(String strVal) {
		/*  823 */     strVal = getNullTrans(strVal, "0");
		/*      */     
		/*  825 */     DecimalFormat formatter = new DecimalFormat("#,###,###,##0");
		/*  826 */     return formatter.format(Long.parseLong(strVal));
		/*      */   }
		/*      */   
		/*      */   public static String getComma(Object objVal) {
		/*  837 */     if (objVal == null) {
		/*  838 */       return "";
		/*      */     }
		/*  840 */     return getComma(objVal.toString());
		/*      */   }
		/*      */   
		/*      */   public static String nvl(Object oData) {
		/*  851 */     return getNullTrans(oData, "");
		/*      */   }
		/*      */   
		/*      */   public static String nvl(Object oData, String sTrans) {
		/*  864 */     return getNullTrans(oData, sTrans);
		/*      */   }
		/*      */   
		/*      */   public static String nvlMap(Map oData, String sKey, String sTrans) {
		/*  877 */     String strValue = "";
		/*  878 */     if (oData != null && oData.containsKey(sKey)) {
		/*  879 */       strValue = String.valueOf(oData.get(sKey));
		/*      */     }
		/*  881 */     return getNullTrans(strValue, sTrans);
		/*      */   }
		/*      */   
		/*      */   public static String nvlMap(Map oData, String sKey) {
		/*  885 */     return nvlMap(oData, sKey, "");
		/*      */   }
		/*      */   
		/*      */   public static String getNullTrans(Object oData) {
		/*  896 */     return getNullTrans(oData, "");
		/*      */   }
		/*      */   
		/*      */   public static String getYearSelectBox(int nStart, int nEnd, String nComp) {
		/*  909 */     String strSel = "";
		/*      */     
		/*  911 */     for (int i = nStart; i >= nEnd; i--) {
		/*  912 */       String strSelected = Integer.toString(i).equals(nComp) ? " selected " : "";
		/*  913 */       strSel = String.valueOf(strSel) + " <option value='" + i + "'" + strSelected + ">" + i + "년</option>\n";
		/*      */     } 
		/*  915 */     return strSel;
		/*      */   }
		/*      */   
		/*      */   public static String getStatsYearSelectBox(int nStart, int nEnd, String nComp) {
		/*  930 */     String strSel = "";
		/*      */     
		/*  932 */     for (int i = nStart; i <= nEnd; i++) {
		/*  933 */       String strSelected = Integer.toString(i).equals(nComp) ? " selected " : "";
		/*  934 */       strSel = String.valueOf(strSel) + " <option value='" + i + "'" + strSelected + ">" + i + "</option>\n";
		/*      */     } 
		/*  936 */     return strSel;
		/*      */   }
		/*      */   
		/*      */   public static String getMonthSelectBox(int nStart, int nEnd, String nComp) {
		/*  949 */     StringBuilder strSel = new StringBuilder();
		/*      */ 
		/*      */ 
		/*      */     
		/*  953 */     for (int i = nStart; i <= nEnd; i++) {
		/*      */       
		/*  955 */       String suffix = String.format("%02d", new Object[] { Integer.valueOf(i) });
		/*      */       
		/*  957 */       String strSelected = suffix.equals(nComp) ? " selected " : "";
		/*  958 */       strSel.append(" <option value='").append(suffix).append("'").append(strSelected).append(">").append(i)
		/*  959 */         .append("월</option>\n");
		/*      */     } 
		/*  961 */     return strSel.toString();
		/*      */   }
		/*      */   
		/*      */   public static String getTimeSelectBox(int nStart, int nEnd, String nComp) {
		/*  975 */     StringBuilder strSel = new StringBuilder();
		/*      */ 
		/*      */ 
		/*      */     
		/*  979 */     for (int i = nStart; i <= nEnd; i++) {
		/*      */       
		/*  981 */       String suffix = String.format("%02d", new Object[] { Integer.valueOf(i) });
		/*      */       
		/*  983 */       String strSelected = suffix.equals(nComp) ? " selected " : "";
		/*  984 */       strSel.append(" <option value='").append(suffix).append("'").append(strSelected).append(">").append(i).append("</option>\n");
		/*      */     } 
		/*  986 */     return strSel.toString();
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String liSelectBox(List<Map> lstRs, String strComp, String strPreFix, String strfnName, String strDepth) {
		/*  991 */     if (lstRs == null || lstRs.isEmpty()) {
		/*  992 */       return "";
		/*      */     }
		/*  994 */     StringBuffer sb = new StringBuffer();
		/*      */     
		/*  996 */     for (int nLoop = 0; nLoop < lstRs.size(); nLoop++) {
		/*  997 */       Map mapRs = lstRs.get(nLoop);
		/*      */       
		/*  999 */       String strCode = nvlMap(mapRs, "CD");
		/* 1000 */       String strName = nvlMap(mapRs, "CD_NM");
		/*      */       
		/* 1002 */       if (strDepth.equals(nvlMap(mapRs, "DEPTH"))) {
		/*      */         
		/* 1006 */         if ("".equals(strfnName)) {
		/*      */           
		/* 1008 */           if (strComp.equals(strCode)) {
		/*      */             
		/* 1010 */             sb.append("<li id='" + strPreFix + "_" + strCode + "'>" + strName + "</li>");
		/*      */           } else {
		/* 1012 */             sb.append("<li id='" + strPreFix + "_" + strCode + "'>" + strName + "</li>");
		/*      */           
		/*      */           }
		/*      */         
		/*      */         }
		/* 1017 */         else if (!"".equals(strComp) && strComp.equals(strCode)) {
		/*      */           
		/* 1019 */           sb.append("<li  id='" + strPreFix + "_" + strCode + "'><a href=\"javascript:" + strfnName + "('" + strCode + "')\" id='" + strPreFix + "_" + strCode + "_ttl'>" + strName + "</a></li>");
		/*      */         } else {
		/* 1021 */           sb.append("<li  id='" + strPreFix + "_" + strCode + "'><a href=\"javascript:" + strfnName + "('" + strCode + "')\" id='" + strPreFix + "_" + strCode + "_ttl'>" + strName + "</a></li>");
		/*      */         } 
		/*      */ 
		/*      */ 
		/*      */         
		/* 1026 */         sb.append("   <input name='dept_cd' id='" + strPreFix + "_" + strCode + "' type='hidden' value='" + strCode + "'>");
		/*      */       } 
		/*      */     } 
		/* 1031 */     return sb.toString();
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String radioSelectBox(List<Map> lstRs, String strComp, String strFieldNm) {
		/* 1036 */     if (lstRs == null || lstRs.isEmpty()) {
		/* 1037 */       return "";
		/*      */     }
		/* 1039 */     StringBuffer sb = new StringBuffer();
		/*      */     
		/* 1041 */     for (int nLoop = 0; nLoop < lstRs.size(); nLoop++) {
		/* 1042 */       Map mapRs = lstRs.get(nLoop);
		/*      */       
		/* 1044 */       String strCode = nvlMap(mapRs, "CD");
		/* 1045 */       String strName = nvlMap(mapRs, "CD_NM");
		/*      */       
		/* 1047 */       sb.append("<label class='mr-20'>");
		/*      */       
		/* 1049 */       if (strComp.equals(strCode)) {
		/* 1050 */         sb.append("<input type='radio'  class='radio'  id='" + strFieldNm + "' name='" + strFieldNm + "' value='" + strCode + "' checked />");
		/*      */       } else {
		/* 1052 */         sb.append("<input type='radio'  class='radio'  id='" + strFieldNm + "' name='" + strFieldNm + "' value='" + strCode + "'  />");
		/*      */       } 
		/*      */       
		/* 1055 */       sb.append(strName);
		/*      */       
		/* 1057 */       sb.append("</label>");
		/*      */     } 
		/*      */     
		/* 1060 */     return sb.toString();
		/*      */   }
		/*      */   
		/*      */   public static String radioSelectBox(List<Map> lstRs, String strComp, String strFieldNm, String strCd, String strNm, String strFunc) {
		/* 1066 */     if (lstRs == null || lstRs.isEmpty()) {
		/* 1067 */       return "";
		/*      */     }
		/* 1069 */     StringBuffer sb = new StringBuffer();
		/*      */     
		/* 1071 */     for (int nLoop = 0; nLoop < lstRs.size(); nLoop++) {
		/* 1072 */       Map mapRs = lstRs.get(nLoop);
		/*      */       
		/* 1074 */       String strCode = nvlMap(mapRs, strCd);
		/* 1075 */       String strName = nvlMap(mapRs, strNm);
		/*      */       
		/* 1077 */       sb.append("<label class='mr-20'>");
		/*      */       
		/* 1079 */       if (strComp.equals(strCode)) {
		/* 1080 */         sb.append("<input type='radio'  class='radio'  id='" + strFieldNm + "' name='" + strFieldNm + "' value='" + strCode + "' checked " + strFunc + " />");
		/*      */       } else {
		/* 1082 */         sb.append("<input type='radio'  class='radio'  id='" + strFieldNm + "' name='" + strFieldNm + "' value='" + strCode + "' " + strFunc + "/>");
		/*      */       } 
		/*      */       
		/* 1085 */       sb.append(strName);
		/*      */       
		/* 1087 */       sb.append("</label>");
		/*      */     } 
		/*      */     
		/* 1090 */     return sb.toString();
		/*      */   }
		/*      */   
		/*      */   public static String checkboxSelectBox(List<Map> lstRs, String strComp, String strFieldNm) {
		/* 1096 */     if (lstRs == null || lstRs.isEmpty()) {
		/* 1097 */       return "";
		/*      */     }
		/* 1099 */     StringBuffer sb = new StringBuffer();
		/*      */     
		/* 1101 */     for (int nLoop = 0; nLoop < lstRs.size(); nLoop++) {
		/* 1102 */       Map mapRs = lstRs.get(nLoop);
		/*      */       
		/* 1104 */       String strCode = nvlMap(mapRs, "CD");
		/* 1105 */       String strName = nvlMap(mapRs, "CD_NM");
		/*      */       
		/* 1107 */       sb.append("<label class='ml-20'>");
		/*      */       
		/* 1109 */       if (strComp.equals(strCode)) {
		/* 1110 */         sb.append("<input type='checkbox'  class='radio'  id='" + strFieldNm + "' name='" + strFieldNm + "' value='" + strCode + "' checked />");
		/*      */       } else {
		/* 1112 */         sb.append("<input type='checkbox'  class='radio'  id='" + strFieldNm + "' name='" + strFieldNm + "' value='" + strCode + "'  />");
		/*      */       } 
		/*      */       
		/* 1115 */       sb.append(strName);
		/*      */       
		/* 1117 */       sb.append("</label>");
		/*      */     } 
		/*      */     
		/* 1120 */     return sb.toString();
		/*      */   }
		/*      */   
		/*      */   public static String getSelectBox(int nStart, int nEnd, String nComp) {
		/* 1136 */     return getStatsYearSelectBox(nStart, nEnd, nComp);
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String randWord(int nLen) {
		/* 1141 */     return shufflePasswd(nLen);
		/*      */   }
		/*      */   
		/*      */   public static String shufflePasswd(int nLen) {
		/* 1151 */     char[] charSet = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 
		/* 1152 */         'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };
		/*      */     
		/* 1154 */     int idx = 0;
		/* 1155 */     StringBuffer sb = new StringBuffer();
		/*      */     
		/* 1157 */     for (int i = 0; i < nLen; i++) {
		/* 1158 */       idx = (int)(charSet.length * Math.random());
		/* 1159 */       sb.append(charSet[idx]);
		/*      */     } 
		/*      */     
		/* 1162 */     return sb.toString();
		/*      */   }
		/*      */   
		/*      */   public static String getDecimalFormat(Double strVal, int nDot) {
		/* 1166 */     return getDecimalFormat(strVal.toString(), nDot);
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getDecimalFormat(String strVal, int nDot) {
		/*      */     DecimalFormat form;
		/* 1172 */     if (nDot == 1) {
		/* 1173 */       form = new DecimalFormat("#0.0");
		/*      */     } else {
		/* 1175 */       form = new DecimalFormat("#0.00");
		/*      */     } 
		/*      */     
		/* 1178 */     double dVal = nvlDouble(strVal, 0);
		/*      */     
		/* 1180 */     return form.format(dVal);
		/*      */   }
		/*      */   
		/*      */   public static String getDateFormat(Map mapReq, String strKey) {
		/* 1186 */     if (mapReq == null) {
		/* 1187 */       return "";
		/*      */     }
		/* 1189 */     return getDateFormat(nvlMap(mapReq, strKey));
		/*      */   }
		/*      */   
		/*      */   public static String getDateFormat(Object objDay) {
		/* 1201 */     if (objDay == null) {
		/* 1202 */       return "";
		/*      */     }
		/* 1204 */     String day = objDay.toString();
		/*      */     
		/* 1206 */     day = day.replaceAll("-", "");
		/* 1207 */     day = day.replaceAll("//.", "");
		/* 1208 */     day = day.replaceAll(":", "");
		/* 1209 */     day = day.replaceAll("\\[", "");
		/* 1210 */     day = day.replaceAll("\\]", "");
		/* 1211 */     day = day.replaceAll(" ", "");
		/*      */     
		/* 1213 */     day = day.replace(".", "");
		/*      */     
		/* 1215 */     if (day.length() == 6)
		/*      */     {
		/* 1217 */       return getDateFormat(day, "."); } 
		/* 1218 */     if (day.length() < 8) {
		/* 1219 */       return objDay.toString();
		/*      */     }
		/*      */     
		/* 1222 */     return getDateFormat(day.substring(0, 8), ".");
		/*      */   }
		/*      */ 
		/*      */   public static String getDateTimeFormat(Object objDay) {
		/* 1235 */     if (objDay == null) {
		/* 1236 */       return "";
		/*      */     }
		/* 1238 */     if (objDay instanceof Date) {
		/* 1239 */       return getDateString((Date)objDay, "yyyy-MM-dd HH:mm:ss");
		/*      */     }
		/*      */     
		/* 1242 */     String day = objDay.toString();
		/*      */     
		/* 1244 */     day = day.replaceAll("-", "");
		/* 1245 */     day = day.replaceAll("//.", "");
		/* 1246 */     day = day.replaceAll(" ", "");
		/* 1247 */     day = day.replaceAll(":", "");
		/*      */     
		/* 1249 */     if (day.length() < 12) {
		/* 1250 */       return objDay.toString();
		/*      */     }
		/* 1252 */     return getDateFormat(day, "-");
		/*      */   }
		/*      */ 
		/*      */   public static String getDateFormat(Object objDay, String delim) {
		/* 1261 */     String tmp = "";
		/*      */     
		/* 1263 */     if (objDay == null)
		/* 1264 */       return tmp; 
		/* 1265 */     String day = objDay.toString();
		/*      */     
		/* 1267 */     day = day.replace(".", "");
		/* 1268 */     day = day.replace("-", "");
		/* 1269 */     day = day.replace("/", "");
		/* 1270 */     day = day.replaceAll(" ", "");
		/*      */     
		/* 1272 */     int iDayLen = day.length();
		/*      */     
		/* 1274 */     if (day == null || day.equals("") || delim == null) {
		/* 1275 */       tmp = "";
		/* 1276 */     } else if (iDayLen == 6) {
		/* 1277 */       tmp = String.valueOf(day.substring(0, 4)) + delim + day.substring(4, 6);
		/* 1278 */     } else if (iDayLen < 8) {
		/* 1279 */       tmp = day;
		/* 1280 */     } else if ("YYMMDD".equals(delim)) {
		/* 1281 */       tmp = String.valueOf(day.substring(2, 4)) + "/ " + day.substring(4, 6) + "/ " + day.substring(6, 8);
		/* 1282 */     } else if ("YMD".equals(delim)) {
		/* 1283 */       tmp = String.valueOf(day.substring(0, 4)) + "년 " + day.substring(4, 6) + "월 " + day.substring(6, 8) + "일";
		/* 1284 */     } else if ("YM".equals(delim)) {
		/* 1285 */       tmp = String.valueOf(day.substring(0, 4)) + "년 " + day.substring(4, 6) + "월";
		/*      */     }
		/* 1287 */     else if ("Y.M.D H".equals(delim) && iDayLen >= 10) {
		/* 1288 */       tmp = String.valueOf(day.substring(0, 4)) + "." + day.substring(4, 6) + "." + day.substring(6, 8) + " " + day.substring(8, 10);
		/*      */     }
		/* 1290 */     else if ("Y.M.D".equals(delim)) {
		/* 1291 */       tmp = String.valueOf(day.substring(0, 4)) + "." + day.substring(4, 6) + "." + day.substring(6, 8);
		/* 1292 */     } else if ("Y-M-D".equals(delim)) {
		/* 1293 */       tmp = String.valueOf(day.substring(0, 4)) + "-" + day.substring(4, 6) + "-" + day.substring(6, 8);
		/*      */     } else {
		/* 1295 */       tmp = String.valueOf(day.substring(0, 4)) + delim + day.substring(4, 6) + delim + day.substring(6, 8);
		/* 1296 */       if (iDayLen > 8) {
		/* 1297 */         tmp = String.valueOf(tmp) + " " + day.substring(8, 10) + ":" + day.substring(10, 12);
		/*      */       }
		/*      */     } 
		/*      */     
		/* 1301 */     return tmp;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getDateTimeSchFormat(Object objDay) {
		/* 1312 */     if (objDay == null) {
		/* 1313 */       return "";
		/*      */     }
		/* 1315 */     String strDate = objDay.toString();
		/*      */     
		/* 1317 */     strDate = strDate.replace("년", ".");
		/* 1318 */     strDate = strDate.replace("월", ".");
		/* 1319 */     strDate = strDate.replace("일", ".");
		/*      */     
		/* 1321 */     return strDate;
		/*      */   }
		/*      */   
		/*      */   public static String removeDateChar(String strDate) {
		/* 1332 */     if (strDate == null) {
		/* 1333 */       return "";
		/*      */     }
		/* 1335 */     strDate = strDate.replaceAll("\\.", "");
		/* 1336 */     strDate = strDate.replace("-", "");
		/* 1337 */     strDate = strDate.replace("/", "");
		/* 1338 */     strDate = strDate.replace(" ", "");
		/*      */     
		/* 1340 */     return strDate;
		/*      */   }
		/*      */   
		/*      */   public static String getWeekdayName(String strDay) {
		/* 1354 */     if (strDay == null || "".equals(strDay)) {
		/* 1355 */       return "";
		/*      */     }
		/* 1357 */     strDay = strDay.replaceAll("-", "");
		/*      */     
		/* 1359 */     int year = Integer.parseInt(strDay.substring(0, 4));
		/* 1360 */     int month = Integer.parseInt(strDay.substring(4, 6));
		/* 1361 */     int day = Integer.parseInt(strDay.substring(6, 8));
		/*      */     
		/* 1363 */     if (month == 1 || month == 2)
		/* 1364 */       year--; 
		/* 1365 */     month = (month + 9) % 12 + 1;
		/* 1366 */     int y = year % 100;
		/* 1367 */     int century = year / 100;
		/* 1368 */     int week = ((13 * month - 1) / 5 + day + y + y / 4 + century / 4 - 2 * century) % 7;
		/* 1369 */     if (week < 0)
		/* 1370 */       week = (week + 7) % 7; 
		/* 1371 */     String strWeek = "";
		/* 1372 */     switch (week) {
		/*      */       case 0:
		/* 1374 */         strWeek = "일";
		/*      */         break;
		/*      */       case 1:
		/* 1377 */         strWeek = "월";
		/*      */         break;
		/*      */       case 2:
		/* 1380 */         strWeek = "화";
		/*      */         break;
		/*      */       case 3:
		/* 1383 */         strWeek = "수";
		/*      */         break;
		/*      */       case 4:
		/* 1386 */         strWeek = "목";
		/*      */         break;
		/*      */       case 5:
		/* 1389 */         strWeek = "금";
		/*      */         break;
		/*      */       case 6:
		/* 1392 */         strWeek = "토";
		/*      */         break;
		/*      */     } 
		/*      */     
		/* 1396 */     return strWeek;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static int getWeekdayNum(String strDay) {
		/* 1409 */     if (strDay == null || "".equals(strDay)) {
		/* 1410 */       return 0;
		/*      */     }
		/* 1412 */     strDay = strDay.replace("-", "");
		/* 1413 */     strDay = strDay.replace(".", "");
		/* 1414 */     strDay = strDay.replace("/", "");
		/*      */     
		/* 1416 */     int year = Integer.parseInt(strDay.substring(0, 4));
		/* 1417 */     int month = Integer.parseInt(strDay.substring(4, 6));
		/* 1418 */     int day = Integer.parseInt(strDay.substring(6, 8));
		/*      */     
		/* 1420 */     if (month == 1 || month == 2)
		/* 1421 */       year--; 
		/* 1422 */     month = (month + 9) % 12 + 1;
		/* 1423 */     int y = year % 100;
		/* 1424 */     int century = year / 100;
		/* 1425 */     int week = ((13 * month - 1) / 5 + day + y + y / 4 + century / 4 - 2 * century) % 7;
		/* 1426 */     if (week < 0) {
		/* 1427 */       week = (week + 7) % 7;
		/*      */     }
		/* 1429 */     return week;
		/*      */   }
		/*      */   
		/*      */   public static String weekdayName(String strNum) {
		/* 1442 */     String strWeek = "";
		/*      */     
		/* 1444 */     if ("1".equals(strNum))
		/* 1445 */       strWeek = "월"; 
		/* 1446 */     if ("2".equals(strNum))
		/* 1447 */       strWeek = "화"; 
		/* 1448 */     if ("3".equals(strNum))
		/* 1449 */       strWeek = "수"; 
		/* 1450 */     if ("4".equals(strNum))
		/* 1451 */       strWeek = "목"; 
		/* 1452 */     if ("5".equals(strNum))
		/* 1453 */       strWeek = "금"; 
		/* 1454 */     if ("6".equals(strNum))
		/* 1455 */       strWeek = "토"; 
		/* 1456 */     if ("7".equals(strNum)) {
		/* 1457 */       strWeek = "일";
		/*      */     }
		/* 1459 */     return strWeek;
		/*      */   }
		/*      */   
		/*      */   public static String leftPad(String str, int size, char padChar) {
		/* 1463 */     return StringUtils.leftPad(str, size, padChar);
		/*      */   }
		/*      */   
		/*      */   public static String rightPad(String str, int size, char padChar) {
		/* 1467 */     return StringUtils.rightPad(str, size, padChar);
		/*      */   }
		/*      */   
		/*      */   public static String padLeftwithString(int convert, int size, String padString) throws IOException {
		/* 1477 */     Integer inTemp = new Integer(convert);
		/* 1478 */     String stTemp = new String();
		/* 1479 */     String stReturn = new String();
		/*      */     
		/* 1481 */     stTemp = inTemp.toString();
		/* 1482 */     if (stTemp.length() < size)
		/* 1483 */       for (int i = 0; i < size - stTemp.length(); i++) {
		/* 1484 */         stReturn = String.valueOf(stReturn) + padString;
		/*      */       } 
		/* 1486 */     return String.valueOf(stReturn) + stTemp;
		/*      */   }
		/*      */   
		/*      */   public static String delRightChar(String str, char delChar) {
		/* 1499 */     String value = str;
		/*      */ 
		/*      */     
		/* 1502 */     while (value.length() > 0) {
		/* 1503 */       int i = value.length() - 1;
		/* 1504 */       if (value.charAt(i) == delChar) {
		/* 1505 */         value = value.substring(0, i); continue;
		/*      */       } 
		/*      */       break;
		/*      */     } 
		/* 1509 */     return value;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getDateString(Date pm_oDate, String pm_sDatePattern) {
		/* 1522 */     SimpleDateFormat lm_oFormat = new SimpleDateFormat(pm_sDatePattern);
		/* 1523 */     return lm_oFormat.format(pm_oDate);
		/*      */   }
		/*      */ 
		/*      */   public static String getNullConv(String strTarget) {
		/* 1536 */     return getNullConv(strTarget, "");
		/*      */   }
		/*      */   
		/*      */   public static String getNullConv(String strTarget, String strConv) {
		/*      */     String szTemp;
		/* 1551 */     if (strConv == null) {
		/* 1552 */       strConv = "";
		/*      */     }
		/* 1554 */     if (strTarget == null || "".equals(strTarget) || "null".equals(strTarget)) {
		/* 1555 */       szTemp = strConv;
		/*      */     } else {
		/* 1557 */       szTemp = strTarget;
		/*      */     } 
		/*      */     
		/* 1560 */     return szTemp;
		/*      */   }
		/*      */   
		/*      */   public static String getChangeString(String str, String index_str, String new_str) {
		/* 1579 */     String temp = "";
		/* 1580 */     if (str != null && str.indexOf(index_str) != -1) {
		/* 1581 */       while (str.indexOf(index_str) != -1) {
		/* 1582 */         temp = String.valueOf(temp) + str.substring(0, str.indexOf(index_str)) + new_str;
		/* 1583 */         str = str.substring(str.indexOf(index_str) + index_str.length());
		/*      */       } 
		/* 1585 */       temp = String.valueOf(temp) + str;
		/*      */     } else {
		/* 1587 */       temp = str;
		/*      */     } 
		/*      */     
		/* 1590 */     return temp;
		/*      */   }
		/*      */   
		/*      */   public static int indexOfaA(String str, String indexstr, int fromindex) {
		/* 1610 */     int index = 0;
		/* 1611 */     indexstr = indexstr.toLowerCase();
		/* 1612 */     str = str.toLowerCase();
		/* 1613 */     index = str.indexOf(indexstr, fromindex);
		/* 1614 */     return index;
		/*      */   }
		/*      */   
		/*      */   public static Map setNullVal(Map<String, String> map, String strKey, String strVal) {
		/* 1629 */     String strMapVal = "";
		/*      */     
		/* 1631 */     if (map.get(strKey) != null && map.get(strKey) != "") {
		/* 1632 */       strMapVal = map.get(strKey).toString().trim();
		/*      */     }
		/* 1634 */     if ("".equals(strMapVal)) {
		/* 1635 */       map.put(strKey, strVal);
		/*      */     }
		/* 1637 */     return map;
		/*      */   }
		/*      */   
		/*      */   public static String getMapVal(Map map, String strKey) {
		/* 1641 */     return getMapVal(map, strKey, "");
		/*      */   }
		/*      */   
		/*      */   public static String getMapVal(Map map, String strKey, String strVal) {
		/* 1645 */     String strMapVal = strVal;
		/*      */     
		/* 1647 */     if (map == null || "".equals(strKey)) {
		/* 1648 */       return strVal;
		/*      */     }
		/* 1650 */     if (map.get(strKey) != null && map.get(strKey) != "") {
		/* 1651 */       strMapVal = map.get(strKey).toString().trim();
		/*      */     }
		/* 1653 */     return strMapVal;
		/*      */   }
		/*      */   
		/*      */   public static String setNullVal(String strKey, String strVal) {
		/* 1657 */     if (strKey == null || "".equals(strKey))
		/* 1658 */       return strVal; 
		/* 1659 */     return strKey;
		/*      */   }
		/*      */   
		/*      */   public static String setNullVal(Object objKey, String strVal) {
		/* 1663 */     if (objKey != null) {
		/* 1664 */       String strKey = objKey.toString().trim();
		/* 1665 */       if (!"".equals(strKey))
		/* 1666 */         return strKey; 
		/*      */     } 
		/* 1668 */     return strVal;
		/*      */   }
		/*      */   
		/*      */   public static String setNullVal(Object objKey) {
		/* 1672 */     return setNullVal(objKey, "");
		/*      */   }
		/*      */ 
		/*      */   public static String removeParam(String strParam, String strNotWord) {
		/* 1688 */     String strRetVal = "";
		/*      */     
		/*      */     try {
		/* 1691 */       if (strParam == null || "".equals(strParam))
		/* 1692 */         return ""; 
		/* 1693 */       if (strNotWord == null || "".equals(strNotWord)) {
		/* 1694 */         return "";
		/*      */       }
		/* 1696 */       int iStartPos = indexOfaA(strParam, strNotWord, 0);
		/*      */       
		/* 1698 */       if (iStartPos < 0) {
		/* 1699 */         return strParam;
		/*      */       }
		/* 1701 */       strRetVal = strParam;
		/* 1705 */       while (iStartPos >= 0) {
		/* 1706 */         int iEndPos = indexOfaA(strRetVal, "&", iStartPos);
		/*      */         
		/* 1708 */         if (iEndPos <= 0) {
		/* 1709 */           iEndPos = strRetVal.length() - 1;
		/*      */         }
		/* 1711 */         strRetVal = String.valueOf(strRetVal.substring(0, iStartPos)) + strRetVal.substring(iEndPos + 1);
		/*      */         
		/* 1713 */         iStartPos = indexOfaA(strRetVal, strNotWord, 0);
		/*      */       } 
		/* 1715 */     } catch (Exception e) {
		/* 1716 */       System.out.println("CommonUtil[removeParam]=>" + e.toString());
		/*      */     } 
		/* 1718 */     return strRetVal;
		/*      */   }
		/*      */ 
		/*      */   public static String rightTrim(String str) {
		/* 1732 */     if (str == null || str.equals("")) {
		/* 1733 */       return str;
		/*      */     }
		/*      */     
		/* 1736 */     int len = str.length();
		/*      */     int i;
		/* 1738 */     for (i = 0; i < len && 
		/* 1739 */       str.charAt(len - i - 1) == ' '; i++);
		/* 1743 */     return str.substring(0, len - i);
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getFileName(Object strFileName) {
		/* 1748 */     if (strFileName != null && !"".equals(strFileName)) {
		/* 1749 */       return getFileName(strFileName.toString());
		/*      */     }
		/* 1751 */     return "";
		/*      */   }
		/*      */ 
		/*      */ 
		/*      */   
		/*      */   public static String getFileName(String strFileName) {
		/* 1757 */     if (strFileName != null && !"".equals(strFileName)) {
		/* 1758 */       return strFileName.substring(strFileName.lastIndexOf("/") + 1, strFileName.length());
		/*      */     }
		/* 1760 */     return "";
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getFileExt(String strFileName) {
		/* 1767 */     if (strFileName != null && !"".equals(strFileName)) {
		/* 1768 */       return strFileName.substring(strFileName.lastIndexOf(".") + 1, strFileName.length());
		/*      */     }
		/* 1770 */     return "";
		/*      */   }
		/*      */   
		/*      */   public static String number_format(Object objNumber) {
		/* 1785 */     return number_format(objNumber, "#,##0");
		/*      */   }
		/*      */   
		/*      */   public static String number_format(Object objNumber, String strFormat) {
		/* 1789 */     String strRetVal = "";
		/*      */     try {
		/* 1791 */       if (objNumber == null || "".equals(objNumber.toString()))
		/* 1792 */         return strRetVal; 
		/* 1793 */       String strNumber = objNumber.toString();
		/*      */       
		/* 1795 */       Double dblNumber = Double.valueOf(strNumber);
		/*      */       
		/* 1797 */       strFormat = "".equals(strFormat) ? "#,##0" : strFormat;
		/*      */       
		/* 1799 */       DecimalFormat formatter = new DecimalFormat(strFormat);
		/* 1800 */       strRetVal = formatter.format(dblNumber);
		/* 1801 */     } catch (Exception exception) {}
		/* 1804 */     return strRetVal;
		/*      */   }
		/*      */   
		/*      */   public static boolean isLong(Map mapReq, String strKey) {
		/* 1810 */     if (mapReq == null || mapReq.isEmpty()) {
		/* 1811 */       return true;
		/*      */     }
		/* 1813 */     String strVal = nvlMap(mapReq, strKey);
		/*      */     
		/* 1815 */     if ("".equals(strVal)) {
		/* 1816 */       return true;
		/*      */     }
		/* 1818 */     return isLong(strVal);
		/*      */   }
		/*      */   
		/*      */   public static boolean isLong(String strVal) {
		/*      */     try {
		/* 1825 */       Long.parseLong(strVal);
		/* 1826 */       return true;
		/*      */     }
		/* 1828 */     catch (NumberFormatException e) {
		/* 1829 */       return false;
		/*      */     } 
		/*      */   }
		/*      */   
		/*      */   public static boolean isDate(Map mapReq, String strKey) {
		/* 1836 */     if (mapReq == null || mapReq.isEmpty()) {
		/* 1837 */       return true;
		/*      */     }
		/* 1839 */     String strVal = nvlMap(mapReq, strKey);
		/*      */     
		/* 1841 */     if ("".equals(strVal)) {
		/* 1842 */       return true;
		/*      */     }
		/* 1844 */     return isDate(strVal);
		/*      */   }
		/*      */   
		/*      */   public static boolean isDate(String checkDate) {
		/*      */     try {
		/* 1853 */       checkDate = removeDateChar(checkDate);
		/*      */       
		/* 1855 */       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		/*      */       
		/* 1857 */       dateFormat.setLenient(false);
		/* 1858 */       dateFormat.parse(checkDate);
		/* 1859 */       return true;
		/*      */     }
		/* 1861 */     catch (ParseException e) {
		/* 1862 */       return false;
		/*      */     } 
		/*      */   }
		/*      */   
		/*      */   public static boolean isNumeric(Map mapReq, String strKey) {
		/* 1871 */     if (mapReq == null || mapReq.isEmpty()) {
		/* 1872 */       return true;
		/*      */     }
		/* 1874 */     String strVal = nvlMap(mapReq, strKey);
		/*      */     
		/* 1876 */     if ("".equals(strVal)) {
		/* 1877 */       return true;
		/*      */     }
		/* 1879 */     return isNumeric(strVal);
		/*      */   }
		/*      */ 
		/*      */ 
		/*      */   
		/*      */   public static boolean isNumeric(String strVal) {
		/*      */     try {
		/* 1886 */       Double.parseDouble(strVal);
		/* 1887 */       return true;
		/*      */     }
		/* 1889 */     catch (NumberFormatException e) {
		/* 1890 */       return false;
		/*      */     } 
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String number_format(int objNumber) {
		/* 1896 */     return number_format(objNumber, "#,##0");
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String number_format(long objNumber) {
		/* 1901 */     return number_format(Long.valueOf(objNumber), "#,##0");
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String number_format(float objNumber) {
		/* 1906 */     return number_format(Float.valueOf(objNumber), "#,##0");
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String number_format(double objNumber) {
		/* 1911 */     return number_format(Double.valueOf(objNumber), "#,##0");
		/*      */   }
		/*      */   
		/*      */   public static String number_format(int objNumber, String strFormat) {
		/* 1915 */     String strRetVal = "0";
		/*      */     try {
		/* 1917 */       if (objNumber <= 0)
		/* 1918 */         return "0"; 
		/* 1919 */       String strNumber = Integer.toString(objNumber);
		/*      */       
		/* 1921 */       Double dblNumber = Double.valueOf(strNumber);
		/*      */       
		/* 1923 */       strFormat = "".equals(strFormat) ? "#,##0" : strFormat;
		/*      */       
		/* 1925 */       DecimalFormat formatter = new DecimalFormat(strFormat);
		/* 1926 */       strRetVal = formatter.format(dblNumber);
		/* 1927 */     } catch (Exception e) {
		/* 1928 */       System.out.println("CommonUtil [number_format] " + e.toString());
		/*      */     } 
		/* 1930 */     return strRetVal;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getTimeFormat(Object objTime, String strFormat) {
		/* 1935 */     String strTime = "";
		/* 1936 */     strFormat = strFormat.toUpperCase();
		/* 1937 */     String strRetTime = "";
		/* 1938 */     String strAmPm = "";
		/* 1939 */     int iHour = 0;
		/*      */     try {
		/* 1941 */       if (objTime == null || "".equals(objTime.toString())) {
		/* 1942 */         return "";
		/*      */       }
		/* 1944 */       strTime = objTime.toString();
		/* 1945 */       if ("".equals(strFormat)) {
		/* 1946 */         strRetTime = String.valueOf(strTime.substring(0, 2)) + ":" + strTime.substring(2, 4);
		/* 1947 */       } else if ("HH24:MM".equals(strFormat)) {
		/* 1948 */         strRetTime = String.valueOf(strTime.substring(0, 2)) + ":" + strTime.substring(2, 4);
		/* 1949 */       } else if ("AM HH:MM".equals(strFormat)) {
		/* 1950 */         iHour = Integer.parseInt(strTime.substring(0, 2));
		/* 1951 */         strAmPm = (iHour <= 12) ? "오전 " : "오후 ";
		/* 1952 */         strRetTime = Integer.toString((iHour > 12) ? (iHour - 12) : iHour);
		/* 1953 */         strRetTime = String.valueOf(strAmPm) + String.format("%02d", new Object[] { strRetTime }) + ":" + strTime.substring(2, 4);
		/*      */       }
		/*      */     
		/* 1956 */     } catch (Exception e) {
		/* 1957 */       System.out.println("Error CommonUtil getTimeFormat() " + e.toString());
		/*      */     } 
		/*      */     
		/* 1960 */     return strRetTime;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getCommonCodeLabel(List resultMapList, String searchCode, String codeFiled, String labelFiled) {
		/* 1965 */     if (resultMapList != null) {
		/* 1966 */       Iterator<Map> iterator = resultMapList.iterator();
		/*      */ 
		/*      */       
		/* 1969 */       while (iterator.hasNext()) {
		/* 1970 */         Map resultMap = iterator.next();
		/* 1971 */         String strCode = nvl(resultMap.get(codeFiled));
		/*      */         
		/* 1973 */         if (strCode.equals(searchCode)) {
		/* 1974 */           return nvl(resultMap.get(labelFiled));
		/*      */         }
		/*      */       } 
		/*      */     } 
		/* 1978 */     return "";
		/*      */   }
		/*      */   
		/*      */   public static String getRight(String str, int len) {
		/* 1982 */     if (str.length() < len) {
		/* 1983 */       return "";
		/*      */     }
		/* 1985 */     return str.substring(str.length() - len);
		/*      */   }
		/*      */   
		/*      */   public static String getFileSize(Object obj) {
		/* 1989 */     String strVal = "";
		/* 1990 */     if (obj == null) {
		/* 1991 */       return "";
		/*      */     }
		/* 1993 */     Long nSize = Long.valueOf(Long.parseLong(obj.toString()));
		/*      */     
		/* 1995 */     nSize = Long.valueOf(nSize.longValue() / 1000L);
		/*      */     
		/* 1997 */     if (nSize.longValue() < 1L) {
		/* 1998 */       nSize = Long.valueOf(1L);
		/*      */     }
		/* 2000 */     if (nSize.longValue() < 1000L) {
		/* 2001 */       strVal = String.format("%dKB", new Object[] { nSize });
		/*      */     } else {
		/* 2003 */       strVal = String.format("%.2fMB", new Object[] { Double.valueOf(nSize.longValue() / 1000.0D) });
		/*      */     } 
		/*      */     
		/* 2006 */     return strVal;
		/*      */   }
		/*      */ 
		/*      */   public static String doubleToStr(double d, int i) {
		/* 2019 */     DecimalFormat decimalformat = null;
		/* 2020 */     String s = "";
		/* 2021 */     if (i == 1) {
		/* 2022 */       decimalformat = new DecimalFormat("######0.#0");
		/* 2023 */     } else if (i == 2) {
		/* 2024 */       decimalformat = new DecimalFormat("#,###,##0");
		/* 2025 */     } else if (i == 3) {
		/* 2026 */       decimalformat = new DecimalFormat("######0");
		/*      */     } else {
		/* 2028 */       decimalformat = new DecimalFormat("#,###,##0.#####");
		/*      */     } 
		/*      */     
		/* 2031 */     s = decimalformat.format(d);
		/* 2032 */     return s;
		/*      */   }
		/*      */ 
		/*      */   public static String doubleStr(double d, int i) {
		/* 2044 */     DecimalFormat decimalformat = null;
		/* 2045 */     String szForm = "######0";
		/* 2046 */     String s = "";
		/*      */     
		/* 2048 */     if (i > 0) {
		/* 2049 */       for (int z = 0; z < i; z++) {
		/* 2050 */         if (z == 0) {
		/* 2051 */           szForm = String.valueOf(szForm) + ".0";
		/*      */         } else {
		/* 2053 */           szForm = String.valueOf(szForm) + "0";
		/*      */         } 
		/*      */       } 
		/*      */     }
		/*      */     
		/* 2058 */     decimalformat = new DecimalFormat(szForm);
		/*      */     
		/* 2060 */     s = decimalformat.format(d);
		/* 2061 */     return s;
		/*      */   }
		/*      */   
		/*      */   public static void setCookieObject(HttpServletResponse response, String name, String value, int iMinute) throws UnsupportedEncodingException {
		/* 2083 */     Cookie cookie = new Cookie(name, URLEncoder.encode(value, "utf-8"));
		/*      */     
		/* 2085 */     cookie.setMaxAge(60 * iMinute);
		/* 2086 */     cookie.setPath("/");
		/* 2087 */     response.addCookie(cookie);
		/*      */   }
		/*      */ 
		/*      */ 
		/*      */   
		/*      */   public static String getCookieObject(HttpServletRequest request, String cookieName) throws UnsupportedEncodingException {
		/* 2093 */     Cookie[] cookies = request.getCookies();
		/*      */     
		/* 2095 */     if (cookies == null)
		/* 2096 */       return null; 
		/* 2097 */     String value = null;
		/* 2098 */     for (int i = 0; i < cookies.length; i++) {
		/*      */       
		/* 2100 */       if (cookieName.equals(cookies[i].getName())) {
		/* 2101 */         value = cookies[i].getValue();
		/* 2102 */         if ("".equals(value)) {
		/* 2103 */           value = null;
		/*      */         }
		/*      */         break;
		/*      */       } 
		/*      */     } 
		/* 2108 */     return (value == null) ? null : URLDecoder.decode(value, "utf-8");
		/*      */   }
		/*      */ 
		/*      */   public static String getStrCut(Object inputString, int max_Length) {
		/* 2123 */     return getStrCut(nvl(inputString), max_Length);
		/*      */   }
		/*      */ 
		/*      */   public static String getStrCut(String inputString, int max_Length) {
		/* 2139 */     String outputString = "";
		/* 2140 */     int string_size = 0;
		/* 2141 */     int new_size = 0;
		/*      */     try {
		/*      */       int i;
		/* 2144 */       for (i = 0; i < max_Length && i < inputString.length(); i++) {
		/* 2145 */         if (Character.getType(inputString.charAt(i)) == 5) {
		/* 2146 */           string_size += 2;
		/* 2147 */         } else if (Character.getType(inputString.charAt(i)) == 1 || 
		/* 2148 */           Character.getType(inputString.charAt(i)) == 2 || 
		/* 2149 */           Character.getType(inputString.charAt(i)) == 15 || 
		/* 2150 */           Character.getType(inputString.charAt(i)) == 24) {
		/* 2151 */           string_size++;
		/*      */         } else {
		/* 2153 */           string_size++;
		/*      */         } 
		/*      */       } 
		/*      */       
		/* 2157 */       if (inputString == null) {
		/* 2158 */         return outputString;
		/*      */       }
		/* 2160 */       if (max_Length < 4 || inputString.length() < max_Length) {
		/* 2161 */         return inputString;
		/*      */       }
		/* 2163 */       for (i = 0; new_size < max_Length - 3; i++) {
		/* 2164 */         if (Character.getType(inputString.charAt(i)) == 5) {
		/* 2165 */           new_size += 2;
		/* 2166 */         } else if (Character.getType(inputString.charAt(i)) == 1 || 
		/* 2167 */           Character.getType(inputString.charAt(i)) == 2 || 
		/* 2168 */           Character.getType(inputString.charAt(i)) == 15 || 
		/* 2169 */           Character.getType(inputString.charAt(i)) == 24) {
		/* 2170 */           new_size++;
		/*      */         } else {
		/* 2172 */           new_size++;
		/*      */         } 
		/*      */         
		/* 2175 */         if (new_size <= max_Length - 3) {
		/* 2176 */           outputString = String.valueOf(outputString) + (new Character(inputString.charAt(i))).toString();
		/*      */         }
		/*      */       } 
		/* 2179 */       outputString = String.valueOf(outputString) + "...";
		/* 2180 */       return outputString;
		/* 2181 */     } catch (Exception E) {
		/*      */       
		/* 2183 */       return inputString;
		/*      */     } 
		/*      */   }
		/*      */   
		/*      */   public static String[] getArrayTime(String strTm) {
		/* 2188 */     String[] retTm = { "", "", "" };
		/*      */     
		/* 2190 */     if (strTm.length() == 4) {
		/* 2191 */       String strHour = strTm.substring(0, 2);
		/*      */       
		/* 2193 */       int iHour = Integer.parseInt(strHour);
		/*      */       
		/* 2195 */       if (iHour > 12) {
		/* 2196 */         retTm[0] = "12";
		/* 2197 */         iHour -= 12;
		/* 2198 */       } else if (iHour == 0) {
		/* 2199 */         retTm[0] = "12";
		/* 2200 */         iHour = 12;
		/*      */       } else {
		/* 2202 */         retTm[0] = "0";
		/*      */       } 
		/*      */       
		/* 2205 */       retTm[1] = getRight("0" + iHour, 2);
		/* 2206 */       retTm[2] = strTm.substring(2);
		/*      */     } 
		/*      */     
		/* 2209 */     return retTm;
		/*      */   }
		/*      */   
		/*      */   public static String getListValueComma(List<Map> rsList, String strField) {
		/* 2213 */     String strRetVal = "";
		/*      */     try {
		/* 2215 */       if (rsList != null && rsList.size() > 0)
		/*      */       {
		/*      */         
		/* 2218 */         for (int iLoop = 0; iLoop < rsList.size(); iLoop++) {
		/* 2219 */           Map dbRow = rsList.get(iLoop);
		/* 2220 */           strRetVal = String.valueOf(strRetVal) + ("".equals(strRetVal) ? nvl(dbRow.get(strField)) : (
		/* 2221 */             "," + nvl(dbRow.get(strField))));
		/*      */         } 
		/*      */       }
		/* 2224 */     } catch (Exception e) {
		/* 2225 */       System.out.println("Error ==> getListValueComma() " + e.toString());
		/*      */     } 
		/* 2227 */     return strRetVal;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static float[] getListToIntArrayFloat(List rsList, String strField) {
		/* 2232 */     return getListToIntArrayFloat(rsList, strField, 0, 0);
		/*      */   }
		/*      */   
		/*      */   public static float[] getListToIntArrayFloat(List<Map> rsList, String strField, int iStartPos, int iEndPos) {
		/* 2236 */     if (rsList == null) {
		/* 2237 */       return null;
		/*      */     }
		/* 2239 */     if (iEndPos > rsList.size())
		/* 2240 */       iEndPos = rsList.size(); 
		/* 2241 */     if (iEndPos <= 0) {
		/* 2242 */       iEndPos = rsList.size();
		/*      */     }
		/* 2244 */     float[] rsArr = new float[iEndPos - iStartPos];
		/*      */     
		/* 2246 */     int iCnt = 0;
		/*      */ 
		/*      */     
		/*      */     try {
		/* 2250 */       for (int iLoop = 0; iLoop < iEndPos; iLoop++) {
		/*      */         
		/* 2252 */         if (iLoop >= iStartPos)
		/*      */         
		/*      */         { 
		/* 2255 */           Map dbRow = rsList.get(iLoop);
		/* 2256 */           rsArr[iCnt++] = Float.parseFloat(nvl(dbRow.get(strField), "0.0")); } 
		/*      */       } 
		/* 2258 */     } catch (Exception e) {
		/* 2259 */       System.out.println("Error ==> getListToArray() " + e.toString());
		/*      */     } 
		/* 2261 */     return rsArr;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static int[] getListToIntArray(List rsList, String strField) {
		/* 2266 */     return getListToIntArray(rsList, strField, 0, 0);
		/*      */   }
		/*      */   
		/*      */   public static int[] getListToIntArray(List<Map> rsList, String strField, int iStartPos, int iEndPos) {
		/* 2270 */     if (rsList == null) {
		/* 2271 */       return null;
		/*      */     }
		/* 2273 */     if (iEndPos > rsList.size())
		/* 2274 */       iEndPos = rsList.size(); 
		/* 2275 */     if (iEndPos <= 0) {
		/* 2276 */       iEndPos = rsList.size();
		/*      */     }
		/* 2278 */     int[] rsArr = new int[iEndPos - iStartPos];
		/*      */     
		/* 2280 */     int iCnt = 0;
		/*      */ 
		/*      */     
		/*      */     try {
		/* 2284 */       for (int iLoop = 0; iLoop < iEndPos; iLoop++) {
		/*      */         
		/* 2286 */         if (iLoop >= iStartPos)
		/*      */         
		/*      */         { 
		/* 2289 */           Map dbRow = rsList.get(iLoop);
		/* 2290 */           rsArr[iCnt++] = Integer.parseInt(nvl(dbRow.get(strField), "0")); } 
		/*      */       } 
		/* 2292 */     } catch (Exception e) {
		/* 2293 */       System.out.println("Error ==> getListToArray() " + e.toString());
		/*      */     } 
		/* 2295 */     return rsArr;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String[] getListToArray(List rsList, String strField) {
		/* 2300 */     return getListToArray(rsList, strField, 0, 0);
		/*      */   }
		/*      */   
		/*      */   public static String[] getListToArray(List<Map> rsList, String strField, int iStartPos, int iEndPos) {
		/* 2304 */     if (rsList == null) {
		/* 2305 */       return null;
		/*      */     }
		/* 2307 */     if (iEndPos > rsList.size())
		/* 2308 */       iEndPos = rsList.size(); 
		/* 2309 */     if (iEndPos <= 0) {
		/* 2310 */       iEndPos = rsList.size();
		/*      */     }
		/* 2312 */     String[] rsArr = new String[iEndPos - iStartPos];
		/*      */     
		/* 2314 */     int iCnt = 0;
		/*      */ 
		/*      */     
		/*      */     try {
		/* 2318 */       for (int iLoop = 0; iLoop < iEndPos; iLoop++) {
		/*      */         
		/* 2320 */         if (iLoop >= iStartPos)
		/*      */         
		/*      */         { 
		/* 2323 */           Map dbRow = rsList.get(iLoop);
		/* 2324 */           rsArr[iCnt++] = nvl(dbRow.get(strField)); } 
		/*      */       } 
		/* 2326 */     } catch (Exception e) {
		/* 2327 */       System.out.println("Error ==> getListToArray() " + e.toString());
		/*      */     } 
		/* 2329 */     return rsArr;
		/*      */   }
		/*      */ 
		/*      */ 
		/*      */   
		/*      */   public static long toLong(Float fNum) {
		/* 2335 */     String strVal = String.valueOf(fNum);
		/*      */     
		/* 2337 */     if (strVal.indexOf('.') > 0)
		/*      */     {
		/* 2339 */       strVal = strVal.substring(0, strVal.indexOf('.'));
		/*      */     }
		/*      */     
		/* 2342 */     return Long.valueOf(strVal).longValue();
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static long toLong(float fNum) {
		/* 2347 */     return toLong(Float.valueOf(fNum));
		/*      */   }
		/*      */   
		/*      */   public static String getSelBoxRepeat(int nStart, int nEnd, int nComp, int nSize) {
		/* 2351 */     return getSelBoxRepeat(nStart, nEnd, String.valueOf(nComp), nSize);
		/*      */   }
		/*      */   
		/*      */   public static String getSelBoxRepeat(int nStart, int nEnd, String strComp, int nSize) {
		/* 2355 */     return getSelBoxRepeat(nStart, nEnd, strComp, nSize);
		/*      */   }
		/*      */   
		/*      */   public static String getSelBoxRepeat(int nStart, int nEnd, Object objComp, int nSize) {
		/* 2359 */     StringBuffer strBuf = new StringBuffer();
		/* 2360 */     String strValue = new String();
		/* 2361 */     String strComp = "";
		/*      */     
		/* 2363 */     if (objComp != null) {
		/* 2364 */       strComp = objComp.toString();
		/*      */     }
		/* 2366 */     String strFormat = "%0" + String.valueOf(nSize) + "d";
		/*      */     
		/* 2368 */     for (int nLoop = nStart; nLoop <= nEnd; nLoop++) {
		/* 2369 */       strBuf.append("<option value='");
		/* 2370 */       if (nSize > 0) {
		/* 2371 */         strValue = String.format(strFormat, new Object[] { Integer.valueOf(nLoop) });
		/*      */       } else {
		/* 2373 */         strValue = String.valueOf(nLoop);
		/* 2374 */       }  strBuf.append(String.valueOf(strValue) + "' ");
		/* 2375 */       if (String.valueOf(nLoop).equals(strComp))
		/* 2376 */         strBuf.append(" selected "); 
		/* 2377 */       strBuf.append(" >" + String.valueOf(nLoop) + " </option> " + "\n");
		/*      */     } 
		/*      */     
		/* 2380 */     return strBuf.toString();
		/*      */   }
		/*      */ 
		/*      */   public static boolean isValCompare(String strVal, String strComp) {
		/* 2398 */     boolean bFlag = false;
		/* 2399 */     if (strVal == null || "".equals(strVal)) {
		/* 2400 */       return false;
		/*      */     }
		/*      */     try {
		/* 2403 */       String[] arrVal = strVal.split(",");
		/*      */       
		/* 2405 */       for (int nLoop = 0; nLoop < arrVal.length; nLoop++) {
		/* 2406 */         if (strComp.equals(arrVal[nLoop])) {
		/* 2407 */           bFlag = true;
		/*      */           
		/*      */           break;
		/*      */         } 
		/*      */       } 
		/* 2412 */     } catch (Exception exception) {}
		/*      */ 
		/*      */     
		/* 2415 */     return bFlag;
		/*      */   }
		/*      */ 
		/*      */   public static String getSelectBox(List listRow, String strCompare, String strCode, String strCodeNm) {
		/* 2438 */     return getSelectBox(listRow, strCompare, strCode, strCodeNm, true);
		/*      */   }
		/*      */   
		/*      */   public static String getSelectBox(List listRow, String strCompare, String strCode, String strCodeNm, boolean isDefOption) {
		/* 2463 */     StringBuilder strVal = new StringBuilder();
		/*      */     
		/*      */     try {
		/* 2466 */       Iterator<Map> iterator = listRow.iterator();
		/* 2467 */       strCompare = getNullTrans(strCompare);
		/*      */ 
		/*      */       
		/* 2470 */       if (isDefOption && listRow.size() > 0) {
		/* 2471 */         strVal.append(" <option value=''>선택</option>\n");
		/*      */       }
		/*      */       
		/* 2479 */       while (iterator.hasNext()) {
		/* 2480 */         Map resultMap = iterator.next();
		/* 2481 */         String strCodeCd = String.valueOf(resultMap.get(strCode));
		/* 2482 */         String strName = String.valueOf(resultMap.get(strCodeNm));
		/*      */         
		/* 2484 */         if (strCodeCd != null) {
		/* 2485 */           strCodeCd = strCodeCd.trim();
		/*      */         }
		/* 2487 */         String strSelected = strCodeCd.equals(strCompare) ? " selected " : " ";
		/*      */         
		/* 2489 */         strVal.append(" <option value='").append(strCodeCd).append("'").append(strSelected).append(">")
		/* 2490 */           .append(strName).append("</option>\n");
		/*      */       }
		/*      */     
		/* 2493 */     } catch (Exception exception) {}
		/*      */ 
		/*      */ 
		/*      */     
		/* 2497 */     return strVal.toString();
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getSelectBox(List listRow, String strCompare, String strCode, String strCodeNm, String strFlag) {
		/* 2522 */     StringBuilder strVal = (new StringBuilder(" <option value='")).append(strFlag).append("'>전체</option>\n");
		/*      */     try {
		/* 2524 */       Iterator<Map> iterator = listRow.iterator();
		/* 2525 */       strCompare = getNullTrans(strCompare);
		/*      */ 
		/* 2532 */       while (iterator.hasNext()) {
		/* 2533 */         Map resultMap = iterator.next();
		/* 2534 */         String strCodeCd = String.valueOf(resultMap.get(strCode));
		/* 2535 */         String strName = String.valueOf(resultMap.get(strCodeNm));
		/*      */         
		/* 2537 */         String strSelected = strCodeCd.equals(strCompare) ? " selected " : " ";
		/*      */         
		/* 2539 */         strVal.append(" <option value='").append(strCodeCd).append("'").append(strSelected).append(">")
		/* 2540 */           .append(strName).append("</option>\n");
		/*      */       }
		/*      */     
		/* 2543 */     } catch (Exception exception) {}
		/* 2547 */     return strVal.toString();
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getSelectBoxValueToName(List listRow, String strCompare, String strCode, String strCodeNm, boolean isDefOption) {
		/* 2574 */     StringBuilder strVal = new StringBuilder();
		/*      */     
		/*      */     try {
		/* 2577 */       Iterator<Map> iterator = listRow.iterator();
		/* 2578 */       strCompare = getNullTrans(strCompare);
		/*      */ 
		/*      */       
		/* 2581 */       if (isDefOption && listRow.size() > 0) {
		/* 2582 */         strVal.append(" <option value=''>선택하세요</option>\n");
		/*      */       }
		/* 2590 */       while (iterator.hasNext()) {
		/* 2591 */         Map resultMap = iterator.next();
		/* 2592 */         String strCodeCd = String.valueOf(resultMap.get(strCode));
		/* 2593 */         String strName = String.valueOf(resultMap.get(strCodeNm));
		/*      */         
		/* 2595 */         String strSelected = strCodeCd.equals(strCompare) ? " selected " : " ";
		/*      */         
		/* 2597 */         strVal.append(" <option value='").append(strName).append("'").append(strSelected).append(">")
		/* 2598 */           .append(strName).append("</option>\n");
		/*      */       }
		/*      */     
		/* 2601 */     } catch (Exception exception) {}
		/* 2605 */     return strVal.toString();
		/*      */   }
		/*      */   
		/*      */   public static Map<String, Object> mapToLowerCaseKeyMap(Map<String, Object> map) {
		/* 2618 */     Map<String, Object> lowerCaseKeyMap = new HashMap<>();
		/*      */     
		/* 2620 */     if (isNotEmpty(map)) {
		/* 2621 */       for (String key : map.keySet()) {
		/* 2622 */         lowerCaseKeyMap.put(key.toLowerCase(), map.get(key));
		/*      */       }
		/*      */     }
		/*      */     
		/* 2626 */     return lowerCaseKeyMap;
		/*      */   }
		/*      */   
		/*      */   public static void mergeMap(Map<String, Object> map, Map<String, Object> target) {
		/* 2641 */     for (String key : map.keySet()) {
		/* 2642 */       if (target.containsKey(key)) {
		/* 2643 */         map.put(key, target.get(key));
		/*      */       }
		/*      */     } 
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static boolean isEmpty(Object o) {
		/* 2666 */     if (o == null)
		/* 2667 */       return true; 
		/* 2668 */     if (o instanceof Map)
		/* 2669 */       return ((Map)o).isEmpty(); 
		/* 2670 */     if (o instanceof Collection)
		/* 2671 */       return ((Collection)o).isEmpty(); 
		/* 2672 */     if (o.getClass().isArray())
		/* 2673 */       return (Array.getLength(o) == 0); 
		/* 2674 */     if (o instanceof String)
		/* 2675 */       return (((String)o).trim().length() == 0); 
		/* 2676 */     if (o instanceof File) {
		/* 2677 */       return !((File)o).exists();
		/*      */     }
		/* 2679 */     return false;
		/*      */   }
		/*      */   
		/*      */   public static boolean isNotEmpty(Object o) {
		/* 2701 */     return !isEmpty(o);
		/*      */   }
		/*      */   
		/*      */   public static boolean isEmptyMapValue(Map<String, Object> map) {
		/* 2714 */     boolean isEmpty = true;
		/*      */     
		/* 2716 */     for (Object o : map.values()) {
		/* 2717 */       if (isNotEmpty(o)) {
		/* 2718 */         isEmpty = false;
		/*      */       }
		/*      */     } 
		/*      */     
		/* 2722 */     return isEmpty;
		/*      */   }
		/*      */   
		/*      */   public static String mapToJson(Map<String, Object> map) {
		/* 2737 */     JSONObject json = new JSONObject();
		/*      */     
		/*      */     try {
		/* 2740 */       for (Map.Entry<String, Object> entry : map.entrySet())
		/*      */       {
		/* 2742 */         String key = entry.getKey();
		/*      */         
		/* 2744 */         Object value = entry.getValue();
		/* 2748 */         json.put(key, value);
		/*      */       }
		/*      */     
		/* 2751 */     } catch (JSONException e) {
		/* 2752 */       System.out.println(e.toString());
		/*      */     } 
		/*      */     
		/* 2755 */     return json.toString();
		/*      */   }
		/*      */   
		/*      */   public static String listToJson(List lstRs) {
		/* 2762 */     String jsonList = "";
		/*      */     
		/*      */     try {
		/* 2765 */       JSONArray json = new JSONArray(lstRs.toArray());
		/*      */       
		/* 2767 */       jsonList = json.toString();
		/*      */     } catch (Exception e) {
		/* 2769 */       e.printStackTrace();
		/*      */     } 
		/* 2771 */     return jsonList;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static String getPageNavi(String link, int totCnt, int pageNow, int pageRowCount, String param, String strFuncNm) {
		/* 2798 */     return getPageNavi(link, totCnt, pageNow, param, 10, pageRowCount, strFuncNm);
		/*      */   }
		/*      */   
		/*      */   public static String getPageNavi(String link, int totCnt, int pageNow, String param) {
		/* 2802 */     return getPageNavi(link, totCnt, pageNow, param, 10, 15, "fPage");
		/*      */   }
		/*      */   
		/*      */   public static String getPageNaviPerPage(String link, int totCnt, int pageNow, String param, int numPerPage) {
		/* 2806 */     return getPageNavi(link, totCnt, pageNow, param, 10, numPerPage, "fPage");
		/*      */   }
		/*      */ 
		/*      */   public static String getPageNavi(String link, int totCnt, int pageNow, String param, int pagePerBlock, int numPerPage, String strFuncNm) {
		/* 2812 */     String rtnNavi = "";
		/* 2813 */     String sDelim = "";
		/* 2814 */     String sPgDlm = "";
		/* 2815 */     String sParam = param;
		/* 2816 */     String strUrl = "";
		/* 2820 */     if (pageNow <= 0) {
		/* 2821 */       pageNow = 1;
		/*      */     }
		/* 2823 */     sParam = removeParam(param, "page_now");
		/*      */ 
		/*      */     
		/* 2826 */     int totalPage = (int)Math.ceil(totCnt / (double)numPerPage * 1.0D);
		/* 2829 */     int currBlock = (int)Math.ceil(pageNow / (double)pagePerBlock * 1.0D);
		/* 2832 */     int totalBlock = (int)Math.ceil(totalPage / (double)pagePerBlock * 1.0D);
		/* 2835 */     int startPage = (currBlock - 1) * pagePerBlock + 1;
		/* 2837 */     int endPage = startPage + pagePerBlock - 1;
		/*      */     
		/* 2839 */     if (endPage > totalPage) {
		/* 2840 */       endPage = totalPage;
		/*      */     }

		/* 2843 */     if (link.indexOf("?") == -1) {
		/* 2844 */       sDelim = "?";
		/*      */     } else {
		/* 2846 */       sDelim = "&";
		/*      */     } 
		/* 2848 */     if (!"".equals(sParam)) {
		/* 2849 */       sPgDlm = "&";
		/*      */     }
		/* 2851 */     strUrl = String.valueOf(link) + sDelim + sParam + sPgDlm;
		/*      */ 
		/*      */     
		/* 2854 */     if (currBlock > 1) {
		/* 2855 */       int iPrev = (currBlock - 1) * pagePerBlock;
		/*      */       
		/* 2857 */       rtnNavi = String.valueOf(rtnNavi) + "<li><a href='javascript:" + strFuncNm + "(1)'>&laquo;</a></li>\n";
		/* 2858 */       rtnNavi = String.valueOf(rtnNavi) + "<li><a href='javascript:" + strFuncNm + "(" + iPrev + ")'>&lsaquo;</a></li>\n";
		/*      */     
		/*      */     }
		/*      */     else {
		/*      */       
		/* 2863 */       rtnNavi = String.valueOf(rtnNavi) + "<li class=\"disabled\"><a href='javascript:" + strFuncNm + "(1)'>&laquo;</a></li>\n";
		/* 2864 */       rtnNavi = String.valueOf(rtnNavi) + "<li class=\"disabled\"><a href='#this'>&lsaquo;</a></li>\n";
		/*      */     } 
		/*      */ 
		/*      */     
		/* 2868 */     if (endPage == 0) {
		/*      */       
		/* 2870 */       rtnNavi = String.valueOf(rtnNavi) + "<li class='active'><a href='#this'>1</a></li>";
		/*      */     } else {
		/*      */       
		/* 2873 */       for (int nLoop = startPage; nLoop <= endPage; nLoop++) {
		/* 2874 */         if (nLoop == pageNow) {
		/* 2875 */           rtnNavi = String.valueOf(rtnNavi) + "<li class='active'><a href='#this'>" + nLoop + "</a></li>\n";
		/*      */         } else {
		/*      */           
		/* 2878 */           rtnNavi = String.valueOf(rtnNavi) + "<li><a href='javascript:" + strFuncNm + "(" + nLoop + ")'>" + nLoop + "</a></li>\n";
		/*      */         } 
		/*      */       } 
		/*      */     } 
		/*      */     
		/* 2883 */     if (currBlock < totalBlock) {
		/* 2884 */       int iNext = currBlock * pagePerBlock + 1;
		/*      */       
		/* 2886 */       rtnNavi = String.valueOf(rtnNavi) + " <li><a href='javascript:" + strFuncNm + "(" + iNext + ")'>&rsaquo;</a></li>  \n";
		/* 2887 */       rtnNavi = String.valueOf(rtnNavi) + " <li><a href='javascript:" + strFuncNm + "(" + totalPage + ")'>&raquo;</a></li> \n";
		/*      */     }
		/*      */     else {
		/*      */       
		/* 2891 */       rtnNavi = String.valueOf(rtnNavi) + " <li class=\"disabled\"><a href='#this'>&rsaquo;</a></li>  \n";
		/* 2892 */       rtnNavi = String.valueOf(rtnNavi) + " <li class=\"disabled\"><a href='javascript:" + strFuncNm + "(" + totalPage + ")'>&raquo;</a></li> \n";
		/*      */     } 
		/*      */ 
		/*      */     
		/* 2896 */     rtnNavi = rtnNavi.replace("\n", " ");
		/* 2897 */     rtnNavi = rtnNavi.replace("\"", "'");
		/*      */     
		/* 2899 */     return rtnNavi;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static long yearDiff(String startDate, String endDate) {
		/* 2904 */     long allYear = 0L;
		/*      */ 
		/*      */     
		/*      */     try {
		/* 2908 */       if (startDate == null || endDate == null) {
		/* 2909 */         return 0L;
		/*      */       }
		/* 2911 */       if (startDate.length() < 4 || endDate.length() < 4) {
		/* 2912 */         return 0L;
		/*      */       }
		/* 2914 */       int nStart = Integer.parseInt(startDate.substring(0, 4));
		/* 2915 */       int nEnd = Integer.parseInt(endDate.substring(0, 4));
		/*      */       
		/* 2917 */       allYear = (nEnd - nStart + 1);
		/*      */     }
		/* 2919 */     catch (Exception exception) {}
		/*      */     
		/* 2921 */     return allYear;
		/*      */   }
		/*      */ 
		/*      */   
		/*      */   public static long monthDiff(String startDate, String endDate) {
		/* 2926 */     long allMonth = 0L;
		/*      */ 
		/*      */     
		/*      */     try {
		/* 2930 */       if (startDate == null || endDate == null) {
		/* 2931 */         return 0L;
		/*      */       }
		/*      */       
		/* 2934 */       startDate = startDate.replaceAll("-", "");
		/* 2935 */       endDate = endDate.replaceAll("-", "");
		/*      */       
		/* 2937 */       String sd2 = startDate.substring(4, 6);
		/*      */       
		/* 2939 */       startDate = getDateFormat(startDate);
		/* 2940 */       endDate = getDateFormat(endDate);
		/*      */ 
		/*      */ 
		/*      */       
		/* 2944 */       SimpleDateFormat fm = new SimpleDateFormat("yyyy.MM.dd");
		/* 2945 */       Date sDate = fm.parse(startDate);
		/* 2946 */       Date eDate = fm.parse(endDate);
		/*      */ 
		/*      */ 
		/*      */       
		/* 2950 */       long diff = eDate.getTime() - sDate.getTime();
		/* 2951 */       long diffDays = diff / 86400000L;
		/*      */       
		/* 2953 */       long difMonth = (diffDays + 1L) / 30L;
		/*      */       
		/* 2955 */       long chkNum = 0L;
		/*      */ 
		/*      */ 
		/*      */       
		/* 2959 */       int j = 0;
		/* 2967 */       for (int i = Integer.parseInt(sd2); j < difMonth; i++) {
		/*      */ 
		/*      */         
		/* 2970 */         if (i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12) {
		/* 2971 */           chkNum += 31L;
		/* 2972 */         } else if (i == 4 || i == 6 || i == 9 || i == 11) {
		/* 2973 */           chkNum += 30L;
		/*      */         } 
		/*      */         
		/* 2976 */         if (i == 2)
		/*      */         {
		/* 2978 */           if (Integer.parseInt(sd2) % 400 == 0) {
		/* 2979 */             chkNum += 29L;
		/*      */           } else {
		/* 2981 */             chkNum += 28L;
		/*      */           } 
		/*      */         }
		/*      */         
		/* 2985 */         j++;
		/*      */         
		/* 2987 */         if (i > 12) { i = 1; j--; }
		/*      */       
		/*      */       } 
		/*      */       
		/* 2991 */       allMonth = (chkNum + 1L) / 30L;
		/* 2992 */       if (diffDays < chkNum) {
		/* 2993 */         allMonth--;
		/*      */       }
		/*      */     }
		/* 3004 */     catch (Exception exception) {}
		/*      */     
		/* 3006 */     return allMonth;
		/*      */   }
		/*      */   
		/*      */   public static String DSEncode(String strIn) {
		/* 3019 */     strIn = String.valueOf(strIn) + "PASSWD";
		/* 3020 */     String retStr = "";
		/* 3021 */     for (int i = 0; i < strIn.length(); i++) {
		/* 3022 */       retStr = String.valueOf(retStr) + (char)(strIn.charAt(i) + i % 2 + 1);
		/*      */     }
		/* 3024 */     return retStr;
		/*      */   }
		/*      */   
		/*      */   public static String DSDecode(String strIn) {
		/* 3036 */     String retStr = "";
		/* 3037 */     for (int i = 0; i < strIn.length(); i++) {
		/* 3038 */       retStr = String.valueOf(retStr) + (char)(strIn.charAt(i) - i % 2 - 1);
		/*      */     }
		/* 3040 */     if (retStr.length() < 2 || !"PASSWD".equals(retStr.substring(retStr.length() - 6))) {
		/* 3041 */       retStr = "";
		/*      */     } else {
		/* 3043 */       retStr = retStr.substring(0, retStr.length() - 6);
		/*      */     } 
		/*      */     
		/* 3046 */     return retStr;
		/*      */   }
		/*      */   
		/*      */   public static void PrefixYear(Map<String, String> mapRs, String strField, int nCurYy) {
		/* 3051 */     String strRet = "";
		/*      */     
		/*      */     try {
		/* 3054 */       if (mapRs == null) {
		/*      */         return;
		/*      */       }
		/* 3057 */       String strVal = nvlMap(mapRs, strField);
		/*      */       
		/* 3059 */       if (strVal == null || "".equals(strVal) || strVal.length() < 2) {
		/*      */         return;
		/*      */       }
		/* 3062 */       int nDataYy = Integer.parseInt(strVal.substring(0, 2));
		/*      */       
		/* 3064 */       if (nDataYy <= nCurYy) {
		/* 3065 */         mapRs.put(strField, "20" + strVal);
		/*      */       } else {
		/* 3067 */         mapRs.put(strField, "19" + strVal);
		/*      */       }
		/*      */     
		/* 3070 */     } catch (Exception exception) {}
		/*      */   }
		/*      */   
		/*      */   public static String getCurrentDate(String StrDelimittoken, String rtnFormmat) {
		/* 3079 */     StringBuilder sb = new StringBuilder();
		/*      */     
		/*      */     try {
		/* 3082 */       Calendar currentWhat = Calendar.getInstance();
		/* 3083 */       int currentYear = currentWhat.get(1);
		/* 3084 */       int currentMonth = currentWhat.get(2) + 1;
		/* 3085 */       int currentDay = currentWhat.get(5);
		/* 3086 */       int currentHour = currentWhat.get(10);
		/* 3087 */       int currentMinute = currentWhat.get(12);
		/* 3088 */       int currentSecond = currentWhat.get(13);
		/*      */       
		/* 3090 */       String yearToday = padLeftwithZero(currentYear, 4);
		/* 3091 */       String monthToday = padLeftwithZero(currentMonth, 2);
		/* 3092 */       String dayToday = padLeftwithZero(currentDay, 2);
		/* 3093 */       String hourToday = padLeftwithZero(currentHour, 2);
		/* 3094 */       String minuteToday = padLeftwithZero(currentMinute, 2);
		/* 3095 */       String secondToday = padLeftwithZero(currentSecond, 2);
		/*      */       
		/* 3097 */       if ("YYYY/MM/DD HH:MI:SS".equals(rtnFormmat)) {
		/* 3098 */         sb.append(yearToday).append("/").append(monthToday).append("/").append(dayToday).append(" ")
		/* 3099 */           .append(hourToday).append(":").append(minuteToday).append(":").append(secondToday);
		/* 3100 */       } else if ("YYYY-MM-DD".equals(rtnFormmat)) {
		/* 3101 */         sb.append(yearToday).append("-").append(monthToday).append("-").append(dayToday);
		/* 3102 */       } else if ("YYYYMMDD-HHMISS".equals(rtnFormmat)) {
		/* 3103 */         sb.append(yearToday).append("").append(monthToday).append("").append(dayToday).append("-")
		/* 3104 */           .append(hourToday).append("").append(minuteToday).append("").append(secondToday);
		/* 3105 */       } else if ("YYYYMMDDHHMISS".equals(rtnFormmat)) {
		/* 3106 */         sb.append(yearToday).append("").append(monthToday).append("").append(dayToday)
		/* 3107 */           .append(hourToday).append("").append(minuteToday).append("").append(secondToday);
		/* 3108 */       } else if ("YYYYMM".equals(rtnFormmat)) {
		/* 3109 */         sb.append(yearToday).append(monthToday);
		/* 3110 */       } else if ("YYYYMMDD".equals(rtnFormmat)) {
		/* 3111 */         sb.append(yearToday).append(monthToday).append(dayToday);
		/* 3112 */       } else if ("YYYYMMDDHH".equals(rtnFormmat)) {
		/* 3113 */         sb.append(yearToday).append(monthToday).append(dayToday).append(hourToday);
		/* 3114 */       } else if ("HH:MI:SS".equals(rtnFormmat)) {
		/* 3115 */         sb.append(hourToday).append(":").append(minuteToday).append(":").append(secondToday);
		/* 3116 */       } else if ("YYYY".equals(rtnFormmat)) {
		/* 3117 */         sb.append(yearToday);
		/* 3118 */       } else if ("MM".equals(rtnFormmat)) {
		/* 3119 */         sb.append(monthToday);
		/* 3120 */       } else if ("DD".equals(rtnFormmat)) {
		/* 3121 */         sb.append(dayToday);
		/* 3122 */       } else if ("HHMI".equals(rtnFormmat)) {
		/* 3123 */         sb.append(hourToday).append(minuteToday);
		/* 3124 */       } else if ("HH:MI".equals(rtnFormmat)) {
		/* 3125 */         sb.append(hourToday).append(":").append(minuteToday);
		/* 3126 */       } else if ("dafault".equals(rtnFormmat)) {
		/* 3127 */         sb.append(yearToday).append(StrDelimittoken).append(monthToday).append(StrDelimittoken).append(dayToday);
		/*      */       } else {
		/* 3129 */         sb.append(yearToday).append(StrDelimittoken).append(monthToday).append(StrDelimittoken).append(dayToday);
		/*      */       } 
		/* 3131 */     } catch (Exception e) {
		/* 3132 */       sb.setLength(0);
		/*      */     } 
		/*      */     
		/* 3135 */     return sb.toString();
		/*      */   }
		/*      */   
		/*      */   public static String getCurrentDate() {
		/* 3139 */     return getCurrentDate("", "");
		/*      */   }
		/*      */   
		/*      */   public static String padLeftwithZero(int convert, int size) throws IOException {
		/* 3148 */     Integer inTemp = new Integer(convert);
		/* 3149 */     String stTemp = new String();
		/* 3150 */     String stReturn = new String();
		/*      */     
		/* 3152 */     stTemp = inTemp.toString();
		/* 3153 */     if (stTemp.length() < size)
		/* 3154 */       for (int i = 0; i < size - stTemp.length(); i++) {
		/* 3155 */         stReturn = String.valueOf(stReturn) + "0";
		/*      */       } 
		/* 3157 */     return String.valueOf(stReturn) + stTemp;
		/*      */   }
		/*      */   
		/*      */   public static String getFileNameGbn(List<Map> lstFile, String strField) {
		/* 3163 */     if (lstFile == null || lstFile.isEmpty()) {
		/* 3164 */       return "";
		/*      */     }
		/* 3166 */     String strFileNm = "";
		/*      */     
		/* 3168 */     for (int nLoop = 0; nLoop < lstFile.size(); nLoop++) {
		/*      */       
		/* 3170 */       Map mapRs = lstFile.get(nLoop);
		/*      */       
		/* 3172 */       if (nvlMap(mapRs, "FILE_GBN").equals(strField)) {
		/* 3173 */         strFileNm = nvlMap(mapRs, "PHY_FILE_NM");
		/*      */         
		/*      */         break;
		/*      */       } 
		/*      */     } 
		/*      */     
		/* 3179 */     return strFileNm;
		/*      */   }
		/*      */   
		/*      */   public static String getFileNameGbn(String strDomain, List<Map> lstFile, String strField) {
		/* 3186 */     if (lstFile == null || lstFile.isEmpty()) {
		/* 3187 */       return "";
		/*      */     }
		/* 3189 */     String strFileNm = "";
		/*      */     
		/* 3191 */     for (int nLoop = 0; nLoop < lstFile.size(); nLoop++) {
		/*      */       
		/* 3193 */       Map mapRs = lstFile.get(nLoop);
		/*      */       
		/* 3195 */       if (nvlMap(mapRs, "FILE_GBN").equals(strField)) {
		/* 3196 */         strFileNm = String.valueOf(strDomain) + nvlMap(mapRs, "PHY_FILE_NM");
		/*      */         
		/*      */         break;
		/*      */       } 
		/*      */     } 
		/*      */     
		/* 3202 */     return strFileNm;
		/*      */   }
		/*      */   
		/*      */   public static JSONArray convertListToJson(List<HashMap<String, Object>> bankCdList) {
		/* 3212 */     JSONArray jsonArray = new JSONArray();
		/* 3213 */     int nIdx = 0;
		/*      */     
		/*      */     try {
		/* 3216 */       for (Map<String, Object> map : bankCdList)
		/*      */       {
		/* 3218 */         jsonArray.put(nIdx++, convertMapToJson(map));
		/*      */       }
		/* 3220 */     } catch (JSONException e) {
		/*      */       
		/* 3222 */       e.printStackTrace();
		/*      */     } 
		/*      */     
		/* 3225 */     return jsonArray;
		/*      */   }
		/*      */   
		/*      */   public static JSONObject convertMapToJson(Map<String, Object> map) {
		/* 3236 */     JSONObject json = new JSONObject();
		/*      */     
		/*      */     try {
		/* 3239 */       for (Map.Entry<String, Object> entry : map.entrySet())
		/*      */       {
		/* 3241 */         String key = entry.getKey();
		/*      */         
		/* 3243 */         Object value = entry.getValue();
		/*      */ 
		/*      */ 
		/*      */         
		/* 3247 */         json.put(key, value);
		/*      */       }
		/*      */     
		/* 3250 */     } catch (JSONException e) {
		/*      */       
		/* 3252 */       e.printStackTrace();
		/*      */     } 
		/*      */     
		/* 3255 */     return json;
		/*      */   }

		/*      */   public static String getHtml(String strUrl) {
		/* 3264 */     StringBuffer sbuf = new StringBuffer();
		/*      */     try {
		/* 3269 */       URL url = new URL(strUrl);
		/* 3272 */       URLConnection urlConn = url.openConnection();
		/* 3275 */       InputStream is = urlConn.getInputStream();
		/* 3276 */       InputStreamReader isr = new InputStreamReader(is, "UTF-8");
		/* 3277 */       BufferedReader br = new BufferedReader(isr);
		/*      */       
		/*      */       String str;
		/* 3280 */       while ((str = br.readLine()) != null) {
		/* 3281 */         sbuf.append(String.valueOf(str) + "\n\r");
		/*      */       }
		/*      */       
		/* 3284 */       System.out.println(strUrl);
		/*      */     }
		/* 3288 */     catch (MalformedURLException e) {
		/* 3289 */       e.printStackTrace();
		/* 3290 */     } catch (IOException e) {
		/* 3291 */       e.printStackTrace();
		/*      */     } 
		/* 3295 */     return sbuf.toString();
		/*      */   }
		/*      */   
		/*      */   public static String getDomain(HttpServletRequest request) {
		/* 3301 */     String strUrl = "";
		/*      */     try {
		/* 3305 */       boolean bSecure = request.isSecure();
		/*      */       
		/* 3307 */       if (bSecure) {
		/* 3308 */         strUrl = "https://";
		/*      */       } else {
		/* 3310 */         strUrl = "http://";
		/*      */       } 
		/*      */       
		/* 3313 */       strUrl = String.valueOf(strUrl) + request.getServerName();
		/*      */       
		/* 3315 */       if (request.getServerPort() != 80) {
		/* 3316 */         strUrl = String.valueOf(strUrl) + ":" + request.getServerPort();
		/*      */       }
		/*      */     }
		/* 3320 */     catch (Exception exception) {}
		/*      */     
		/* 3322 */     return strUrl;
		/*      */   }
		/*      */   
		/*      */   public static Map getListMap(List<Map> lstRs, String strKey, String strVal) {
		/*      */     try {
		/* 3331 */       for (int nLoop = 0; nLoop < lstRs.size(); nLoop++)
		/*      */       {
		/* 3333 */         Map mapRs = lstRs.get(nLoop);
		/*      */         
		/* 3335 */         if (strVal.equals(nvlMap(mapRs, strKey)))
		/*      */         {
		/* 3337 */           return mapRs;
		/*      */         
		/*      */         }
		/*      */       }
		/*      */     
		/*      */     }
		/* 3343 */     catch (Exception exception) {}
		/*      */     
		/* 3345 */     return null;
		/*      */   }
		/*      */   
		/*      */   public static long getDivVal(Map mapRs, String strKey1, String strKey2) {
		/* 3351 */     long nTotDiv = 1L;
		/*      */     try {
		/* 3355 */       long nVal1 = nvlLong(nvlMap(mapRs, strKey1), 0);
		/* 3356 */       long nVal2 = nvlLong(nvlMap(mapRs, strKey2), 0);
		/* 3359 */       nTotDiv = (nVal1 > nVal2) ? nVal1 : nVal2;
		/*      */       
		/* 3361 */       if (nTotDiv == 0L) nTotDiv = 1L;
		/*      */     
		/* 3363 */     } catch (Exception exception) {}
		/*      */     
		/* 3365 */     return nTotDiv;
		/*      */   }
}
