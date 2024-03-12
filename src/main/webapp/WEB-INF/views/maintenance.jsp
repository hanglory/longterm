<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type='text/javascript'> 
window.onpageshow =  function(event) {
    //back 이벤트 일 경우
    if (event.persisted) {
    		//todo
    		window.location.reload();
    }
}
window.onload = function(){
/*	
	if(navigator.userAgent.match(/inapp|NAVER|KAKAOTALK|Snapchat|Line|WirtschaftsWoche|Thunderbird|Instagram|everytimeApp|WhatsApp|Electron|wadiz|AliApp|zumapp|iPhone(.*)Whale|Android(.*)Whale|kakaostory|band|twitter|DaumApps|DaumDevice\/mobile|FB_IAB|FB4A|FBAN|FBIOS|FBSS|SamsungBrowser\/[^1]/i))
	{ 
		document.body.innerHTML = ''; 
		if(navigator.userAgent.match(/iPhone|iPad/i)){ 
			window.open(location.href, "_self");
		}else{ 
			location.href='intent://'+location.href.replace(/https?:\/\//i,'')+'#Intent;scheme=http;package=com.android.chrome;end'; 
		} 
	}
*/	
} 
</script>
    
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
 <script src="http://mattstow.com/experiment/responsive-image-maps/jquery.rwdImageMaps.min.js"></script>
    
    
	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "14e79358f12c520";
if(window.wcs) {
wcs_do();
}
</script>

<div style= "text-align: center; margin-top:30px;">
    
<img src="/images/maintenance.jpg" alt="" style="max-width:100%; height:auto;" usemap="#imagemap">
    <map name="imagemap" id="imagemap">
    <area shape="rect" coords="477,839,1225,865" href="tel:1661-7977" target="_blank">
    <area shape="rect" coords="531,1113,1008,1140" href="tel:080-600-6000" target="_blank">
    <area shape="rect" coords="513,1151,1007,1177" href="tel:080-200-2000" target="_blank">
    <area shape="rect" coords="571,1188,1034,1214" href="tel:080-300-3000" target="_blank"> 
    <area shape="rect" coords="415,1226,887,1251" href="tel:080-3000-5000" target="_blank"> 
    <area shape="rect" coords="354,1461,712,1540" href="https://www.car.go.kr/home/gate.do" target="_blank">
</map>
    
    
    </div>
    
     <script>
$(function(){
	$('img[usemap]').rwdImageMaps();
	
});
</script>



