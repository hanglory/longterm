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
<script language="JavaScript"> function setCookie( name, value, expiredays )
 { var todayDate = new Date(); todayDate.setDate( todayDate.getDate() + expiredays ); 
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" }
 function closeWin() { if ( document.notice_form.chkbox.checked ){ setCookie( "maindiv", "done" , 1 ); }
 document.all['divpop'].style.visibility = "hidden"; } 
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





</style>


<!--
	<div class="sector1">
		<div class="box">
			<div class="col6 midas">
				<a href="./totalrent">
					<img src="${RPATH}/images/total-top.jpg" alt="" />
				</a>
			</div>

			<div class="col6 hi24" style="float:right">
				<a href="./totalrent">
					<img src="${RPATH}/images/hi24-top.gif" alt="" />
				</a>
			</div>
		</div>
	</div>
  -->					
	
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
	


