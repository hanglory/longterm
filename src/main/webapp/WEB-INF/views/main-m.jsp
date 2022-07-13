<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-06Y9Z40Y53"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-06Y9Z40Y53');
</script>
<script language="JavaScript"> 
function setCookie( name, value, expiredays )
{ 
	var todayDate = new Date(); todayDate.setDate( todayDate.getDate() + expiredays ); 
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
}
function closeWin() {
	if ( document.notice_form.chkbox.checked ){ setCookie( "maindiv", "done" , 1 ); }
 	document.all['divpop'].style.visibility = "hidden"; 
 } 
</script>

<style>

#customer{

    border-bottom: 1px solid #d7d7d7;
    border-top: 1px solid #d7d7d7;
}

#customer h1 {
    margin-top: 15px;
    padding: 0 0 10px 30px;
    font-weight: 600;
    font-size: 18px;
    color: #242424;
    display: block;
    border-bottom: 1px solid #d7d7d7;
}

#customer div {
    padding: 5px;
}

#customer div div.box1 span {
    font-weight: bold;
    font-size: 22px;
 
}

#customer div div.box1 span a {
    color: #0564b5;
}

#customer div div.box2 span a {
    color: #0564b5;
}
#customer div div.box2 ul {
    font-weight: bold;
}

#customer div div.box2 ul li {
    line-height: 20px;
    color: #909090;
}

#customer div div.box2 ul li span {
    color: #707070;
}



	.sector1 {
		--height: 972px;
		background-size: cover;
		
	}
	
	.sector2 {
		--overflow: hidden;
		position: relative;
		--padding-bottom:56.25%;
		margin: auto;
		--background-color: #0074e3;
		 border-bottom: 1px solid #d7d7d7;
		text-align:center;
	}	
	.sector2 img {
		
		width: 370px;
		margin: auto;
		vertical-align: middle;
		
		
	}

	.sector3 {
		--background-color: #0074e3;
		--height: 300px;
		--background-color: #f7f3f0;
		position: absolute;
		bottom:80px;
		
	}
	
	
	.box {
		--display: flex;
		--width: 720px;
		height: 100%;
		margin: 0px auto;
		--padding: 20px 0;
		text-align:center;
		
		
	}
	
	.col6 {
		width: 50%;
		height: 50%;
		--display: inline;
		--float: left;
		display: inline-block;
		
		margin: 0 auto;
		--padding: 50px;
	}
	
	.col3 {
		
	}

	.col3 img {
		width: 100%;
		float:bottom;
	
	}

	.col4 img {

		width: 100%;
		float:bottom;
		margin-top:20px;;
	
	}
	.sector1::after {
	}
	
	.col6 img {
		--display: block;
		width: 100%;
		margin : 0 auto;
	}
	.col6 img:hover {
		transform: scale(1.1);
	}

#hd_pop {z-index:1000;position:relative;margin:0 auto;width:970px;height:0;}
#hd_pop h2 {position:absolute;font-size:0;line-height:0;overflow:hidden}
.hd_pops {position:absolute;border:1px solid #e9e9e9;background:#fff}
.hd_pops_con {}
.hd_pops_footer {padding:10px 0;background:#000;color:#fff;text-align:right;opacity : 1.0;}
.hd_pops_footer button {margin-right:5px;padding:5px 10px;border:0;background:#393939;color:#fff}


#quick{width:127px; top:102px; right:137px; position:absolute;}
#quick .quick-input{width:200px; border:1px solid #478ed1; background:#f1f6f6; float:left;}
#quick .quick-btn{width:195px; margin-top:5px; float:left;}

#quick .quick-input h1{padding-top:20px; font-weight:600; font-size:16px; text-align:center; color:#478ed1; display:block;}
#quick .quick-input ul{padding:5px 25px 15px; float:left;}
#quick .quick-input ul li{margin-top:3px; float:left;}
#quick .quick-input ul li input{width:150px; height:24px; border:1px solid #242424; background:#fbfbfb;}
#quick .quick-input span{margin-right:1px; position:relative; _display:inline; float:left;}
#quick .quick-input span label{top:5px; left:6px; position:absolute; letter-spacing:-1px; color:#999;}
#quick .quick-input div.agree{width:140px; margin-top:2px; margin-left:30px; font-size:11px; color:#999; float:left;}
#quick .quick-input div.agree a{margin:3px 5px; text-align:center; display:block;}
#quick .quick-input div.submit{width:127px; float:left;}
#quick .quick-input div.submit input{width: 200px; height:29px; font-weight:600; color:#fff; border:0; background:#478ed1;}
#vagree2{width:254px; height:236px; padding:10px; top:0; left:-254px; z-index:10000; border:2px solid #222; background:#fff; position:absolute;}
#vagree2 h2{font-weight:bold; font-family:"NanumGothic"; color:#444; font-size:100%}
#vagree2 div{width:232px; border:1px solid #d7d7d7; height:190px; margin-top:5px; padding:10px; background:#fbfbfb; overflow-y:scroll; scrollbar-face-color:#fff; scrollbar-shadow-color:#eaeaea; scrollbar-highlight-color:#eaeaea; scrollbar-3dlight-color:#fff; scrollbar-darkshadow-color:#fff; scrollbar-track-color:#fff; scrollbar-arrow-color:#eaeaea; float:left;}
#vagree2 div h3{font-weight:bold; font-family:"NanumGothic"; color:#707070; font-size:100%}
#vagree2 div ul{margin:5px 0 10px;}
#vagree2 div ul li{font-size:11px; line-height:20px; color:#909090;}
.dn{display:none;}

</style>

<c:if test="${siteinfoVO.id > 0 }">
	<c:if test="${cookie.maindiv.value ne 'done' }">

<div id="hd_pop">
    <h2>팝업레이어 알림</h2>

    <div id="hd_pops_40" class="hd_pops" style="top:${siteinfoVO.top_postion }px;left:${siteinfoVO.left_postion}px">
        <div class="hd_pops_con" style="width:${siteinfoVO.width }px;height:${siteinfoVO.height }px">
            <p><a href="${siteinfoVO.link_url }"><img src="${siteinfoVO.contents }" title="광고이미지" alt="광고이미지" /></a><br style="clear:both;" /> </p>        </div>
        <div class="hd_pops_footer">
            <button class="hd_pops_reject hd_pops_40 24"><strong>24</strong>시간 동안 다시 열람하지 않습니다.</button>
            <button class="hd_pops_close hd_pops_40">닫기</button>
        </div>
    </div>
</div>

<script>
$(function() {
    $(".hd_pops_reject").click(function() {
        $('#hd_pop').css("display", "none");
        setCookie( "maindiv", "done" , 1 );
    });
    $('.hd_pops_close').click(function() {
        var idb = $(this).attr('class').split(' ');
        $('#hd_pop').css('display','none');
    });
//    $("#hd").css("z-index", 1000);
});

$(document).ready(function(){
	cookiedata = document.cookie; 
	if ( cookiedata.indexOf("maindiv=done") < 0 ){ 
	//	document.all['hd_pop'].style.visibility = "visible";
		$('#hp_pop').show();
	} else { 
		$('#hp_pop').hide(); 
	}
});
</script>

</c:if>
</c:if>
	
	<div class="sector2">

						<img src="${RPATH}/images/mb_main2.png"  name = "mainvisualimg" usemap="#Map" >

	<map name= "Map" id="Map">
    		<area shape="rect" coords="84,283,188,362" href="https://www.harmonyrent.co.kr/totalrent" onfocus="blur();"/>
    		<area shape="rect" coords="229,300,335,377" href="https://harmonyrentcar.com/bbs/usedcarRealNew" onfocus="blur();"/>
    		<area shape="rect" coords="49,370,145,479" href="https://harmonyrentcar.com/bbs/usedcarReal" onfocus="blur();"/>
    		<area shape="rect" coords="184,393,318,507" href="https://harmonyrentcar.com/bbs/usedcarDetail?car_id=368" onfocus="blur();"/>
	</map>
		<!--<video autoplay muted loop>
			<source src="${RPATH}/images/harmony.mp4" type="video/mp4">-->
	
		<!--<video width="427" height="240" controls>
  		<source src="${RPATH}/images/harmony.mp4" type="video/mp4">
  			<source src="${RPATH}/images/harmony.ogg" type="video/ogg">
			Your browser does not support the video tag.
			</video>-->
		<!--<img src="${RPATH}/images/total-top.jpg" alt="" />-->
		
</div>
		<!--<div class="sector3">
			<div class="col4">
				<a href="./totalrent">
				<img src="${RPATH}/images/mb_totalrent.png" alt="" />
				</a>
			</div>
			<div class="col4">
				<a href="/bbs/usedcarRealNew">
				<img src="${RPATH}/images/mb_new.png" alt="" />
				</a>
			</div>
			<div class="col4">
			<a href="/bbs/usedcarReal">
				<img src="${RPATH}/images/mb_used.png" alt="" />
			</a>
			</div>
			
		</div>-->

			<!--<div class="col3">
			
				<img src="${RPATH}/images/mb_main.png" alt="" />
			</div>-->

	

<div id="customer">
	<h1>고객센터</h1>
<div>	
		<div class="box1">
			<span><a href="tel:1588-5802">1588-5802</a></span>
		</div>
		<div class="box2">
			<ul>
				<li>평일 : <span>09:00-18:00</span>  /  점심시간 : <span>12:30-13:30</span></li>
			</ul>
		</div>
	</div>
</div>

<div id="customer">
	<h1>렌트문의</h1>
	<div>
		<div class="box1">
			<span><a href="tel:1661-9763">1661-9763</a>
		</div>
		<div class="box2">
			<ul>
				<li><span>신차 및 중고 장기렌트 / 오너형렌트 </span></li>
			</ul>
		</div>
	</div>
</div>

<div id="customer">
	<h1>사고접수</h1>
	<div>
		<div class="box1">
			<span><a href="tel:1661-7977">1661-7977</a>
		</div>
		<div class="box2">
			<ul>
				<li>평일/주말 : <span>24시간 상담 가능</span></li>
			</ul>
		</div>
	</div>
</div>


	<!--임시레이어팝업
	<div id="divpop" style="position:absolute;left:100px;top:150px;z-index:200;visibility:hidden;"> 
	<table width=490px height=340px cellpadding=0 cellspacing=0> 
	<tr> <td style="border:1px #666666 solid" height=340px align=center bgcolor=white>
	 <a href="/"><img src="${RPATH}/images/layer.png" width=700px height=794px alt="설명설명"></a> </td> </tr>
	 <tr> <td height=10 bgcolor="#000000"> </td> </tr>
	 <tr> <form name="notice_form"> <td height=25 align=right bgcolor="#000000" valign=middle> 
	<input type="checkbox" name="chkbox" value="checkbox"> <font color=#eeeeee>오늘 하루 이 창을 열지 않음 </font> 
	<a href="javascript:closeWin();"> <font color=#eeeeee> <B>[닫기]</B> </font></a> </td> </form> </tr> </table> </div>	-->			





<script language="Javascript"> cookiedata = document.cookie; if ( cookiedata.indexOf("maindiv=done") < 0 )
{ document.all['divpop'].style.visibility = "visible"; } else { document.all['divpop'].style.visibility = "hidden"; } </script>
	


