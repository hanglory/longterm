<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
	int isMobile = 0;
	String agent = request.getHeader("USER-AGENT");
	String[] mobileos = {"iPhone","iPod","Android","BlackBerry","Windows CE","Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
	int j = -1;
	for(int i=0 ; i<mobileos.length ; i++) {
		j=agent.indexOf(mobileos[i]);
		if(j > -1 )
		{
			// 모바일로 접근했을 때
			isMobile = 1;
			break;
		}
	}
%>

<style>
#fullscreen_layer { position:absolute; top:0; left:0; bottom:0; right:0; background:#000; z-index:100; display:none;
/* IE 8 */  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=70)";  
/* IE 5-7 */  filter: alpha(opacity=70);
/* Netscape */  -moz-opacity: 0.7;
/* Safari 1.x */  -khtml-opacity: 0.7;
/* Good browsers */ opacity: 0.7; }

.popup { position: absolute; width:1200px; height:2167px; background:transparent; z-index:101; display:none; 
/* IE 8 */  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";  
/* IE 5-7 */  filter: alpha(opacity=0);
/* Netscape */  -moz-opacity: 0;
/* Safari 1.x */  -khtml-opacity: 0;
/* Good browsers */ opacity: 0; }
.popup .relative { position:relative; }
.popup .close { position: absolute; top:-11%; right: -2%; width: 11%; }
</style>
    
 <!-- 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 --> 
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_585d84eea409";
if (!_nasa) var _nasa={};
if(window.wcs){
wcs.inflow();
wcs_do(_nasa);
}
</script>   
    
<script>
function fnShowPop(sGetName){
	var layer = $("#"+ sGetName);
	var nowTop = $(window).scrollTop();
	var calTop = nowTop-(layer.height()/3);
//  var calLeft = ($(window).width()/2)-(layer.width()/2);
	var calLeft = 0;
	if(nowTop == 0) calTop = 20;
	$("#fullscreen_layer").fadeIn(50);
	$("#"+ sGetName).css({"top":70, "left":-1200});
	$("#"+ sGetName).show().stop().animate({
			"top": calTop,
			"opacity": "1", 
			"-ms-filter":"progid:DXImageTransform.Microsoft.Alpha(Opacity=100)",
			"filter": "alpha(opacity=100)", 
			"-moz-opacity": "1", 
			"-khtml-opacity": "1"
	}, 500);
}

function fnHidePop(sGetName){
	var layer = $("#"+ sGetName);
	var nowTop = $(window).scrollTop();
	var calTop = nowTop-(layer.height()/3);
	if(nowTop == 0) calTop = 300;
	$("#fullscreen_layer").fadeOut(200);
	$("#"+ sGetName).stop().animate({
			"top": calTop+60,
			"opacity": "0", 
			"-ms-filter":"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)",
			"filter": "alpha(opacity=0)", 
			"-moz-opacity": "0", 
			"-khtml-opacity": "0"
	}, 200, function(){
			$(this).hide();
	});
}
</script>

<pre class="brush:html;"><div id="fullscreen_layer"></div>
<div class="popup" id="popup_event" style="top: 70px; left: -1200px; opacity: 1;">
	<div class="relative">
		<div class="content">
		<a class="close" href="javascript:void(0);" onclick="fnHidePop('popup_event');"><img src="https://www.harmonyrent.co.kr/images/company.jpg" alt="" /></a>
		</div>
	</div>
</div>
	<footer>
		<div class="footer">
		<% if( isMobile ==1 ){ %>
			<img src="${RPATH}/images/footer.png" alt="" style="max-width: 100%;height:auth;"  />
		<%} else{ %>
			<img src="${RPATH}/images/footer.png" alt="" style="max-width: 100%;height:auth;"  />
		<%} %>
		</div>
 	</footer>
