<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
			<a href="javascript:fnShowPop('popup_event');"><img src="${RPATH}/images/footer.png" alt=""  /></a>
		</div>
 	</footer>
