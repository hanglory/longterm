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
<img src="/images/company01.jpg" alt="" style="max-width:100%; height:auto;" /></div>


<div style= "text-align: center; margin-top:0px;">
<img src="/images/company02.jpg" alt="" style="max-width:100%; height:auto;" />
</div>

<h1 style="text-align:center; margin-top: 20px; margin-bottom:10px;">10주년 소개 영상</h1>

<p align ="middle">
<iframe width="410" height="230" src="https://www.youtube.com/embed/dr6fGoTLX1o" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe>
</p>