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


<style>
 
 a .downbtn {
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer; 
  width :200px;
        
    }
    
    .downspan {
        
        font-size: 20px;
       
    }  
    
     .downdiv {
        width :550px;
        margin:0 auto;
        
    }
    
    </style>

<div class = "downdiv">  
    
   <!-- <span class = "downspan" >" 필요하신 파일 버튼을 누르시면 저장하실 수 있습니다. <br> &nbsp 저장하신 후 프린트 하시면 됩니다. " </span> -->
    
<br><br>
       <a href="${RPATH}/images/hi-rent.pdf" download><button class = "downbtn" style = "background-color: #4CAF50; margin-top: 100px;" >하이렌트 상품설명서 <br> 다운로드</button></a>
       <a href="${RPATH}/images/midas-rent.pdf" download><button class = "downbtn" style = "background-color: #4CAF50; margin-top: 100px;" >마이다스 상품설명서 <br> 다운로드</button></a>
        
        

    
<br>

	<a href="${RPATH}/images/hi_contract.hwp" download><button class = "downbtn" style = "background-color: #008CBA;">하이렌트 계약서 <br> 다운로드</button></a>
        	<a href="${RPATH}/images/mi_contract.hwp" download><button class = "downbtn" style = "background-color: #008CBA;" >마이다스 계약서 <br> 다운로드</button></a>
        
   
    
<br>

        <a href="${RPATH}/images/menu_guide.pdf" download><button class = "downbtn" style = "background-color: #4CAF50; " >홈페이지 메뉴얼 <br> 다운로드</button></a>
    <a href="${RPATH}/images/onwer_contract.hwp" download><button class = "downbtn" style = "background-color: #4CAF50; " >오너형 계약서 <br> 다운로드</button></a>

<br>

 <a href="${RPATH}/images/process.pdf" download><button class = "downbtn" style = "background-color: #008CBA; margin-bottom: 100px; " >계약진행 프로세스</button></a>
 
</div> 
