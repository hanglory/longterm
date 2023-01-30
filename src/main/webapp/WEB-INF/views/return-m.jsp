<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script> <!-- JQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-rwdImageMaps/1.6/jquery.rwdImageMaps.min.js"></script>       
    
    
<script type='text/javascript'> 
window.onpageshow =  function(event) {
    //back 이벤트 일 경우
    if (event.persisted) {
    		//todo
    		window.location.reload();
    }
}
window.onload = function(){ 
	if(navigator.userAgent.match(/inapp|NAVER|KAKAOTALK|Snapchat|Line|WirtschaftsWoche|Thunderbird|Instagram|everytimeApp|WhatsApp|Electron|wadiz|AliApp|zumapp|iPhone(.*)Whale|Android(.*)Whale|kakaostory|band|twitter|DaumApps|DaumDevice\/mobile|FB_IAB|FB4A|FBAN|FBIOS|FBSS|SamsungBrowser\/[^1]/i))
	{ 
		document.body.innerHTML = ''; 
		if(navigator.userAgent.match(/iPhone|iPad/i)){ 
			window.open(location.href, "_self");
		}else{ 
			location.href='intent://'+location.href.replace(/https?:\/\//i,'')+'#Intent;scheme=http;package=com.android.chrome;end'; 
		} 
	} 
} 
</script>

	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "14e79358f12c520";
if(window.wcs) {
wcs_do();
}
</script>
    
    


<div style= "text-align: center; margin-top:0px;">
<img src="/images/returninfo1.jpg" alt="" usemap = "#imagemap" style="max-width:100%; height:auto;">
    
    <map name="imagemap" id="imagemap">
    <area shape="rect" coords="565,139,724,198" href="tel:1588-5802" target="_blank" >
</map>
       
    </div>

<div style= "text-align: center; margin-top:0px;">
<img src="/images/returninfo2.jpg" alt="" usemap = "#imagemap2" style="max-width:100%; height:auto;" >
    
       <map name="imagemap2" id="imagemap2">
    <area shape="rect" coords="476,925,640,985" href="tel:010-7604-1262" target="_blank" >
</map>
    
    </div>

<div style= "text-align: center; margin-top:0px;">
<img src="/images/returninfo3.png" alt="" style="max-width:100%; height:auto;" /></div>
    
    <script type="text/javascript">
    // rwdImageMaps로 이미지맵 동적 할당하도록 설정
    $('img[usemap]').rwdImageMaps();
    </script>
