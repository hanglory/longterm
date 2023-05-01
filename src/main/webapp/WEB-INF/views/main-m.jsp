<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script> <!-- JQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-rwdImageMaps/1.6/jquery.rwdImageMaps.min.js"></script>       
    
      
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

	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "14e79358f12c520";
if(window.wcs) {
wcs_do();
}
</script>






<script language="JavaScript"> function setCookie( name, value, expiredays )
 { var todayDate = new Date(); todayDate.setDate( todayDate.getDate() + expiredays ); 
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" }
 function closeWin() { if ( document.notice_form.chkbox.checked ){ setCookie( "maindiv", "done" , 1 ); }
 document.all['divpop'].style.visibility = "hidden"; } 
</script>

    
<script language="JavaScript"> 
var isPhoneAuth = false;
var isAuthBtn = false;
var getAuthNum = "0";
function setCookie( name, value, expiredays ){ 
	var todayDate = new Date(); todayDate.setDate( todayDate.getDate() + expiredays ); 
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
}

function sendSmsMsg(formVal) {
//	var telval= formVal.re_phone.value();
	var phoneval="";
	var customerval = "";
		phoneval = document.getElementById("re_phone").value;
		customerval = document.getElementById("re_name").value;
		//authNumber = document.getElementById("re_auth").value; 인증번호
		carKindSel = formVal.re_credit.value;
		if(!fn_mbtlnumChk(phoneval) ){
			document.getElementById("re_phone").focus();
			return false;
		}

		var smsSendAuth = {phoneNo: phoneval,
				customerNm: customerval,
				carKindSel: carKindSel,
			 	keyType:"MAIN_STATIC"
			 };
	
		if($('#submitbtn').val() == "인증번호받기"){
			$('#submitbtn').val("신청하기");
			smsSendAuth.keyType = "STATIC";
			$.ajax({
				type: "POST",
				url: baseUrl+"bbs/smsSendAjax",
				data    :JSON.stringify(smsSendAuth),
				async: false,
				//dataType: "json",          // ajax 통신으로 받는 타입
				contentType: "application/json",  // ajax 통신으로 보내는 타입
				success: function(data) {
					data.smsCode;
					data.keyValue;
					getAuthNum = data.authKey;
					if(data.smsCode != "0000"){
						alert("인증문자 전송 실패");
						isAuthBtn = false;
						return false;
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("실패.")
					return false;
				}
			});			
			return false;
		}
	
    /*
    if(authNumber.length != 4) {
			alert('인증문자를 입력해 주세요');
			return false;
		}
		if(authNumber != getAuthNum){
			alert('인증번호가 맞지 않습니다.');
			return false;
		}
		if(isPhoneAuth){
			alert('문자전송중 입니다. 잠시 기다려 주세요. 문자를 받지 못하셨으면 스팸함을 확인해 주세요.');
			return false;
		}
    
    */
		isPhoneAuth = true;
//		$('#submitbtn').val("신청하기");
		
//	$(this).val('인증번호확인');
//	addClass('selected');
	
	$.ajax({
		type: "POST",
		url: baseUrl+"bbs/smsSendHelpAjax",
		data    :JSON.stringify(smsSendAuth),
		async: false,
		//dataType: "json",          // ajax 통신으로 받는 타입
        contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {
				data.smsCode;
				data.keyValue;
				car.authNumber = data.authKey;
				if(data.smsCode == "0000"){
					alert("상담요청이 완료 되었습니다. 곧 상담원이 전화 연락 드리겠습니다.");
					isPhoneAuth = false;
					return false;
				}else{
					alert("현재 문자 전송이 원활하지 않습니다. 잠시후 다시 이용해 주세요.");
					return false;
				}
            
            this.change();
            this.changedaum();
            
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
            alert("문자 전송 실패.")
            return false;
		}
	});
} // <------ 현드폰번호 인증	

function authSms(){
	var smsSendAuth = {phoneNo: phoneval,
		 	keyType:"STATIC"
		 };
	$.ajax({
		type: "POST",
		url: baseUrl+"bbs/smsSendAjax",
		data    :JSON.stringify(smsSendAuth),
		async: false,
		//dataType: "json",          // ajax 통신으로 받는 타입
		contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {
			data.smsCode;
			data.keyValue;
			car.authNumber = data.authKey;
			if(data.smsCode != "0000"){
				alert("인증문자 전송 실패");
				isPhoneAuth = false;
				return false;
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			alert("실패.")
			return false;
		}
	});
}


function fn_mbtlnumChk(mbtlnum){
	  var regExp = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))(-\d{4})$/;
	  if(!regExp.test(mbtlnum)){
	    alert(mbtlnum+"휴대폰번호가 올바르지 않습니다.");
	    return false;
	  }
	  return true;
}
function autoHypenPhone(str){
    str = str.replace(/[^0-9]/g, '');
    var tmp = '';
    if( str.length < 4){
        return str;
    }else if(str.length < 7){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3);
        return tmp;
    }else if(str.length < 11){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 3);
        tmp += '-';
        tmp += str.substr(6);
        return tmp;
    }else{              
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 4);
        tmp += '-';
        tmp += str.substr(7);
        return tmp;
    }
    return str;
}
jQuery(document).ready(function(){

	$("#re_phone").on("propertychange change keyup paste input", function() {
		var _val = $(this).val();
		
		var tel_val = autoHypenPhone(_val) ;
		$(this).val(tel_val);
	});	
});

</script>    
    
    
	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "14e79358f12c520";
if(window.wcs) {
wcs_do();
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
		
		position: relative;
		
		margin: auto;
		
	/* border-bottom: 3px solid #015ec6;*/
      
		text-align:center;
	}	
	.sector2 img {
		
		width: 100%;
		margin: auto;
		vertical-align: middle;
		border-bottom: 2px solid #c2c1c1;
		
	}
    
    .sector2_call {
		
		position: relative;
		
		margin: auto;
		
	/* border-bottom: 3px solid #015ec6;*/
      
		text-align:center;
	}	
	.sector2_call img {
		
		width: 100%;
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


.dn{display:none;}

    
    
    
.car_list {
  display: flex;
  flex-wrap: wrap;
}

.car_item {
  width: 285px;
  display: flex;
  flex-direction:column;
  margin-bottom: 20px;
}

.car_item:not(:nth-child(4n)){
  margin-right: 20px;
}

.car_item img {
  width: 100%;
  height: 188px;
}
    
    
    .car_item2 {
  width: 285px;
  display: flex;
  flex-direction:column;
  margin-bottom: 20px;
}

.car_item2:not(:nth-child(4n)){
  margin-right: 20px;
}

.car_item2 img {
  width: 100%;
  height: 188px;
}


.car_content {
  display: flex;
  justify-content: space-between;
  flex-direction: column;
  border: 1px solid #eee;
  padding-top: 16px;
    padding-left:10px;
  height: 175px
}

.car_content .top_area {
  display: flex;
  justify-content: space-between;
}

.car_content .left_area {
  padding-left: 16px;
  width: calc(100% - 60px);
}

.car_content .left_area h3 {
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 3px;
}
.car_content .left_area li {
  display: flex;
}

.car_content .left_area li span{
  white-space: nowrap;
  font-size: 14px;
}
.car_content .left_area .title {
  color: #cacaca;
  display: inline-block;
  margin-right: 8px;
}
  
.car_content .right_area strong {
  display: block;
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
  font-size: 13px;
  color: #fff;
  padding: 2px 0;
  width: 75px;
  margin-bottom: 4px;
  text-align: center;
}

.car_content .right_area strong.red {
 background-color: #005ec6;
}
.car_content .right_area strong.orange {
 background-color: #2db2c8;
}

.car_content .bottom_area {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-left: 16px;
  margin-top: 20px;
  margin-bottom: 20px;
}

.car_content .label {
  width: 51px;
  height: 60px;
  border-top-right-radius: 40px;
  border-top-left-radius: 40px;
  font-size: 13px;
  font-weight: 500;
  display: flex;
  justify-content: center;
  align-items: flex-end;
  padding-bottom: 6px;
  background-color: #7accc8;
}
.car_content .label.new {
  color: #f90000;
}
.car_content .label.used {
  color: #0a10ff;
}
.car_content .rent {
  padding-right: 16px;
  font-size: 18px;
  font-weight: 500;
}
.car_content .rent .title{
  color: #c2bfbf;
  font-weight: inherit;
  margin-right: 10px;
}
.car_content .rent .price{
  color: #d52323;
  font-weight: inherit;
}

.car_list.thumbnail {
  justify-content: flex-start;				/* space-between;*/
  padding: 0 20px;
 
  margin-left: auto;
  margin-right: auto;
}

.car_list.thumbnail .car_item{
  width: 370px;
  height: 420px;
  margin-right: 16px;
}

.car_list.thumbnail .car_item img {
  height: 250px;
}
    
    .car_list.thumbnail .car_item2{
  width: 370px;
  height: 420px;
  margin-right: 16px;
}

.car_list.thumbnail .car_item2 img {
  height: 240px;
}
.car_list.thumbnail .car_content .rent {
  text-align: center;
  /*width: calc(100% - 51px ); */
  display: flex;
  justify-content: center;
}
.car_list.thumbnail .car_content .label{
  background-color: #e1e1e1;
}

/*슬라이드버튼 */  
    
    
    
 /*모바일문자상담창 스타일*/
    
    
.quick {
  width: 100%;
  height: 450px;
  display: flex;
  align-items: center;
  justify-content: center;
  /*background: rgba(0, 0, 0, 0.1);*/
}

.quick-input {
  width: 80%;
  height: 400px;
  background: white;
  border-radius: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 6px solid #015ec6;
  flex-direction: column;
  margin-top: 15px;
  margin-bottom: 15px;
    padding-left:20px;
    padding-right:20px;
}

h2 {
  color: tomato;
  font-size: 2em;
}

.quick-input_id {
   /*margin-top: 20px;*/
  width: 100%;
}

.quick-input_id input {
  width: 100%;
  height: 50px;
  /*border-radius: 30px;*/
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid #bebebe;
  outline: none;
}

.quick-input_pw {
  /*margin-top: 20px;*/
  width: 100%;
}

.quick-input_pw input {
  width: 100%;
  height: 50px;
  /*border-radius: 30px;*/
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid #c2c3c3;
  outline: none;
}

.quick-input_etc {
  padding: 10px;
  width: 100%;
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.submit {
  /*margin-top: 50px;*/
  width: 100%;
}
.submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to left, rgb(47, 147, 255), rgb(46, 101, 255));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
}
    
    /*모바일 문자상담창 끝*/
    
    
    
 .call_btn {
  width: 80%;
  height: 50px;
  border: 0;
  outline: none;
  /*border-radius: 40px;*/
  background: linear-gradient(to left, rgb(47, 147, 255), rgb(46, 101, 255));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
    margin-top:5px;
}   
    
     .call_btn2 {
  width: 80%;
  height: 50px;
  border: 0;
  outline: none;
  /*border-radius: 40px;*/
  background: linear-gradient(to left, rgb(46, 101, 255), rgb(47, 147, 255));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
    margin-top:15px;
}  
    
 .mb_call img{
  width: 80%;
  height: 50px;
  border: 0;
  outline: none;
  /*border-radius: 40px;*/
  background: linear-gradient(to left, rgb(46, 101, 255), rgb(47, 147, 255));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
    margin-top:15px;
}  
  
    
    
@media screen and (max-width: 790px) {
  .car_list {
    display: block;
  }
  
  .car_item {
    width: 100%;
    display: flex;
    flex-direction:column;
    margin-bottom: 16px;
  }
  
  .car_item:not(:nth-child(4n)){
    margin-right: 0;
  }
  
  .car_item img {
    height: 220px;
  }
    
      .car_item2 {
    width: 100%;
    display: flex;
    flex-direction:column;
    margin-bottom: 16px;
  }
  
  .car_item2:not(:nth-child(4n)){
    margin-right: 0;
  }
  
  .car_item2 img {
    height: 220px;
  }
  
 
  
  .car_content .left_area {
    padding-left: 14px;
  }

  .car_content .left_area li span{
    white-space: nowrap;
    font-size: 13px;
  }

  .car_content .bottom_area {
    padding-left: 14px;
    margin-top: 16px;
  }
  
  .car_content .label {
    width: 45px;
    height: 50px;
    border-top-right-radius: 22px;
    border-top-left-radius: 22px;
    font-size: 12px;
    padding-bottom: 5px;
  }

  .car_content .rent {
    padding-right: 14px;
    font-size: 16px;
  }
  .car_content .rent .title{
    margin-right: 8px;
  }
  
  .car_list.thumbnail {
    justify-content: space-between;
    padding: 0;
   /* margin: 20px 0 0 0; */
    /*text-align: center;*/
  }
  
.car_list.thumbnail .car_item{
    width: 100%;
    height: 420px;
    margin-right: 0;
    margin-bottom: 15px;
  }
    
    .car_list.thumbnail .car_item2{
    width: 100%;
    height: 420px;
    margin-right: 0;
    margin-bottom: 15px;
  }
  
    .car_list.thumbnail .car_content .rent {
    text-align: right;
    width: calc(100% - 45px);
    justify-content: flex-end;
  }
    
    .btn1 {
        
  background-color: #005ec6;
  border: none;
  color: white;
  padding: 7px 11px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin-right: 4px 2px;
  cursor: pointer;
        
  float:right;

    }
   
}    
      
     slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

/* 이미지를 숨기는데 사용 */
.mySlides {
    display: none;
}
   
    
</style>
    
<link rel="stylesheet" href="/css/static.css">
 <link rel="stylesheet" href="/css/style.css">
    
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
        
        
<!-- Layer popup start --> <script language="JavaScript"> function setCookie( name, value, expiredays ) { var todayDate = new Date(); todayDate.setDate( todayDate.getDate() + expiredays ); 
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" } function closeWin() { if ( document.notice_form.chkbox.checked ){ setCookie( "maindiv", "done" , 1 ); }
 document.all['divpop'].style.visibility = "hidden"; } </script> <!-- Layer popup end -->


<div id="divpop" style="position:absolute;left:0px;top:80px;z-index:200;visibility:hidden;"> 
<table width=350px height=340px cellpadding=0 cellspacing=0> 
<tr> <td style="border:1px #666666 solid" height=340px align=center bgcolor=white> <a href="https://harmonyrent.co.kr/images/board/wjdwlgp26/aicc%EC%B2%A8%EB%B6%80%ED%8C%8C%EC%9D%BC.png"><img src="${RPATH}/images/aicc_popup_mb.jpg" width=350px height=463px alt="aicc팝업"></a> </td> </tr> 
<tr> <td height=10 bgcolor="#000000"> </td> </tr> <tr> <form name="notice_form"> <td height=25 align=right bgcolor="#000000" valign=middle>
 <input type="checkbox" name="chkbox" value="checkbox"> <span style="color:#eeeeee">오늘 하루 이 창을 열지 않음 </span> <a href="javascript:closeWin();"> <span style="color:#eeeeee"> <B style="color:#eeeeee">[닫기]</B> </span></a> </td> </form> </tr> </table> </div>


<script language="Javascript"> cookiedata = document.cookie; if ( cookiedata.indexOf("maindiv=done") < 0 ){ document.all['divpop'].style.visibility = "visible"; } else { document.all['divpop'].style.visibility = "hidden"; } </script>
        
 <!-- Layer popup finish -->          
        
        
        
        
        
        

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

<script>
    var index = 0;   //이미지에 접근하는 인덱스
    window.onload = function(){
        slideShow();
    }
    
    function slideShow() {
    var i;
    var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
    }
    index++;
    if (index > x.length) {
        index = 1;  //인덱스가 초과되면 1로 변경
    }   
    x[index-1].style.display = "block";  //해당 인덱스는 block으로
    setTimeout(slideShow, 5000);   //함수를 4초마다 호출
 
}
      
      
      
function currentSlide(n) {
  showSlides(slideIndex = n);
}      
</script>    
    
    
    
    <div class = "sector2">
    
  <a href ="tel:1661-9763"><img class="slide1" src="${RPATH}/images/m_main11.jpg"></a>
  <a href ="tel:1661-9763"><img class="slide1" src="${RPATH}/images/m_main22.jpg"></a>
  <a href ="tel:1661-9763"><img class="slide1" src="${RPATH}/images/m_main33.jpg"></a>
    
    
    </div>
    
      <!--<div style="text-align:center;">
      <a href ="tel:1661-9763"><img style="width:80%;height:50px;margin-top:15px;" src="${RPATH}/images/kakaochat.jpg"></a></div>--> 
       
    <!--<div style="text-align:center;">
    <a href ="https://open.kakao.com/o/swhk8rFe"><button type="button" class = "call_btn2" id="call_btn2">카카오톡 상담연결</button></a></div>-->
    
    
     <div class="sector2_call" style="text-align:center;">
         
    					<img src="${RPATH}/images/mb_call.png"  name = "mainvisualimg" usemap="#Map" >

	<map name= "Map" id="Map">
    		<area shape="rect" coords="22,23,211,232" href="tel:1588-5802" onfocus="blur();"/>
    		<area shape="rect" coords="276,20,455,236" href="https://open.kakao.com/o/swhk8rFe" onfocus="blur();"/>
    		<area shape="rect" coords="522,13,670,235" href="tel:1661-9763" onfocus="blur();"/>
	</map>     
         
         
         
    <!--<a href ="tel:1661-9763"><button type="button" class = "call_btn" id="call_btn">1661 - 9763 상담연결</button></a>-->
    
    </div> 
    
    
    <!-- 문자상담창 -->
    
    <div id="quick" class ="quick">
        <div class="quick-input">
            <div style="display: inline-block;text-align: center;align-items: center;">
            <form method="post" id="frequestform" name="frequestform" onSubmit="return sendSmsMsg(this)" action="#">
            <input type="hidden" id="re_divi" name="re_divi" value="quick" />
            <h4 style="font-size: 22px; color: #005fbd; font-weight: 600; background-color: white;">상담문의</h4>
            <div class="quick-input_id">
                <!--<h4>이름</h4>-->
                <input type="text" id="re_name" name="re_name" required class="focusInput" placeholder="&nbsp;&nbsp;이름"/>
            </div>
            <div class="quick-input_pw">
                <!--<h4>전화번호</h4>-->
                <input type="text" id="re_phone" name="re_phone" required class="focusInput" pattern="(010)-\d{3,4}-\d{4}" placeholder="&nbsp;&nbsp;010-1234-5678"/>
            </div>
            <!--<div class="quick-input_pw">
                <!--<h4>인증번호</h4>--
                <input type="text" id="re_auth" name="re_auth" class="focusInput" placeholder="&nbsp;&nbsp;인증번호" />
            </div>-->
            <div class="quick-input_pw">
                <!--<h4>희망차종</h4>-->
                <input type="text" id="re_credit" name="re_credit" required class="required" placeholder="희망차종"/>
            </div>
            <div class="quick-input_etc">
                <div class="checkbox">
                <input type="checkbox" id="agree" name="agree" required value="1" />&nbsp;&nbsp;개인정보동의 
                </div>
        
            </div>
            <div class="submit">
                <input type="submit" value="신청하기" id="submitbtn">
            </div>
                
            </form>
        </div>
        </div>
    </div>
    
    <!-- 문자상담창 끝 -->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
	<!--<div class="sector2">

						<img src="${RPATH}/images/mb_main2.png"  name = "mainvisualimg" usemap="#Map" >

	<map name= "Map" id="Map">
    		<area shape="rect" coords="84,283,188,362" href="${RPATH}/totalrent" onfocus="blur();"/>
    		<area shape="rect" coords="229,300,335,377" href="${RPATH}/bbs/usedcarRealNew" onfocus="blur();"/>
    		<area shape="rect" coords="49,370,145,479" href="${RPATH}/bbs/usedcarReal" onfocus="blur();"/>
    		<area shape="rect" coords="184,393,318,507" href="${RPATH}/bbs/usedcarRealNew?isList=1" onfocus="blur();"/>
	</map>	
        
</div>-->
    
    
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
    
    
    
    
<!--신차/중고 차량 리스트 --> 
     <div style="display: table; margin:auto;">
     
         
 <!--<h1 style=" font-size:24px; font-weight: 600; color:#7a7a7a;"> 즉시출고 신차장기렌트</h1> 
<!--<h1 style="padding-left:20px;  font-size:28px; font-weight: 600; color:##7a7a7a;"> 즉시출고 신차장기렌트</h1>-->
         
 <div style="width:100%;"><a href="${RPATH}/bbs/usedcarRealNew"><img src="${RPATH}/images/m_newrent.jpg" style="width:100%;margin-top:5px;" alt=""></a></div>
         
         
<ul class='car_list thumbnail'>  
   
<c:forEach var="usedCarVO" items="${newUsedCarVO }">
    
<li class="car_item">
<a href="/bbs/usedcarDetail?car_id=${usedCarVO.id}"><img src="${usedCarVO.image}" alt="">
  <div class="car_content">
    <div class="top_area">
      <div class="left_area">
      <h3>${usedCarVO.trim_name}</h3>
      <ul>
        <li>
          <span class="title">차량유종</span>
          <span class="ellipsis">${usedCarVO.fuel}</span>
        </li>
      </ul>
    </div>
    <div class="right_area">
       <strong class="red">선택항목</strong>
       <script>
        iconList = "${usedCarVO.icon}".split('|');
		for(var nCnt in iconList){
			if(iconList[nCnt] != "")
				document.writeln('<strong class="orange">'+iconList[nCnt]+'</strong>');
		}
		</script>
    </div>
  </div>
  <div class="bottom_area">
    <p class="rent">
      <span class="title">월렌트료(vat포함)</span>
      <span class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee_1}" /> 원</span>
        
        <!--<span class="price">${ usedCarVO.rentfee_1}원</span>-->
    </p>
  </div>
</div></a>

<button style="margin-top:15px;" onclick="plusDivs(-1)" style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9664;&#9664;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
<button onclick="plusDivs(+1)">&#9654;&#9654;</button>
    
<script>
    
    var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("car_item");
  if (n > x.length) {slideIndex = 1}
  if(n>3) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length} ;
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  x[slideIndex-1].style.display = "block";
     
}
 
         </script> 
    
</li>

   
    
    
</c:forEach>
 
<button class="btn1" onclick="location.href='${RPATH}/bbs/usedcarRealNew';">신차장기렌트 더보기</button>    
    
</ul>
         
      <!-- <div><a href ="${RPATH}/bbs/usedcarRealNew"><h1 style="text-align:right; font-size:20px; font-weight: 600;padding-right:40px; color:black"> ->&nbsp;신차 더보기</h1></a></div>-->

       
         
<!--<h1 style="padding-left:20px; margin-top:20px; font-size:28px; font-weight: 600; color:##7a7a7a;"> 검증완료 중고재렌트</h1>
 <h1 style="margin-top:20px; font-size:24px; font-weight: 600; color:#7a7a7a;"> 검증완료 중고재렌트</h1>--> 
         
 <div style="width:100%;"><a href="${RPATH}/bbs/usedcarReal"><img src="${RPATH}/images/m_usedrent.jpg" style="width:100%;" alt=""></a></div>         
         
         
<ul class='car_list thumbnail'>
<c:forEach var="usedCarVO" items="${oldUsedCarVO }">
<li class="car_item2">
  <a href="/bbs/usedcarDetail?car_id=${usedCarVO.id}"><img src="${usedCarVO.image}" alt="">
   <div style="padding-bottom:10px;" class="car_content">
    <div style="display: flex;flex-wrap: wrap; margin-bottom: 10px;">
<script>
        iconList = "${usedCarVO.icon}".split('|');
		for(var nCnt in iconList){
			if(iconList[nCnt] != "")
				document.writeln('<span style="font-size: 12px;color: #fff;border-radius: 5px;padding: 2px 18px;background-color: #4e6c8a;">'+iconList[nCnt]+'</span>');
		}
</script>
    </div>
      <h3>${ usedCarVO.trim_name}</h3>
      <ul>
        <li>
          <span class="title">차량유종</span>
          <span class="ellipsis">${usedCarVO.fuel}</span>
        </li>
        <li>
          <span class="title">주행거리</span>
         
              <span class="ellipsis"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.distance}" /> Km</span>
            <!--<span class="ellipsis">${usedCarVO.distance} Km</span>-->
        </li>
        <li>
          <span class="title">약정개월</span>
          <span class="ellipsis">${ usedCarVO.period} 개월</span>
        </li>
      </ul>        
    <p class="rent">
      <span class="title">월렌트료(vat포함)</span>
   <span class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${usedCarVO.rentfee}" />원</span> 
       <!--<span class="price">${ usedCarVO.rentfee}원</span>--> 
    </p>
          
   </div>
  </a>
    
  <button style="margin-top:15px;" onclick="plusDivs2(-1)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#9664;&#9664;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
<button onclick="plusDivs2(+1)">&#9654;&#9654;</button>  
    
      <script>
    var slideIndex = 1;
showDivs2(slideIndex);

function plusDivs2(n) {
  showDivs2(slideIndex += n);    
}

function showDivs2(n) {
  var i;
  var x = document.getElementsByClassName("car_item2");
  if (n > x.length) {slideIndex = 1}
  if(n>3) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length} ;
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  x[slideIndex-1].style.display = "block";
     
}
 
         </script>  
    
    
    <!-- 전환페이지 설정 -->
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> 
<script type="text/javascript">

function change(){

var _nasa={};
if(window.wcs) _nasa["cnv"] = wcs.cnv("1","10"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고

}
</script> 

    <!-- 카카오전환페이지 설정 --> 
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/kas/static/kp.js"></script>
<script type="text/javascript">

	function changedaum(){
      kakaoPixel('3481025403756984027').pageView();
      kakaoPixel('3481025403756984027').signUp('Subscription');
}
</script>    
    
    
</li>
</c:forEach>
    
      <button class="btn1" onclick="location.href='${RPATH}/bbs/usedcarReal';">중고장기렌트 더보기</button>
    
</ul>
        
      
    </div>
	<div style="margin-top:20px;">
        <a href="${RPATH}/totalrent"><img src="${RPATH}/images/main_totalrent.jpg" style="width:100%;" alt=""></a></div>
	

<div id="customer">
	<h1>고객센터</h1>
<div>	
		<div class="box1">
			<span><a href="tel:1588-5802" onclick="change();changedaum();">1588-5802</a></span>
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
			<span><a href="tel:1661-9763" onclick="change();changedaum();">1661-9763</a>
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
	

 <script type="text/javascript">
    // rwdImageMaps로 이미지맵 동적 할당하도록 설정
    $('img[usemap]').rwdImageMaps();
    </script>


