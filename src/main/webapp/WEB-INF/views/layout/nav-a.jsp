<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type='text/javascript'> 
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
<style>
nav li {
	display: block;
	list-style: none;
	height: 80px;
	width: 100%;
	border: 1px solid #aaa;
}
</style>

<nav>
	<ul>
		<li><a href="./">메인</a></li>
		<li><a href="./estimatelist">견적서</a></li>
		<li><a href="./member">멤버정보</a></li>
		<li><a href="../member/">견적페이지</a></li>
		<li><a href="/admin/usedcarlist">즉시출고</a></li>
	</ul>
</nav>