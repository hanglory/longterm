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

    <script>
    
     function keyword_check(){

  if(document.search.keyword.value==''){ //검색어가 없을 경우  

  alert('검색어를 입력하세요'); //경고창 띄움 

  document.search.keyword.focus(); //다시 검색창으로 돌아감 

  return false; 

  }

  else return true;

 }   
    
    </script>
    <div style = "margin-top:150px;">
 
 <h1 align="CENTER"> <!-- h1 사이즈로 내용 출력  -->

정비받을 지역을 입력하세요

</h1>
   </div>
    
  <br>
    <br>
    
<form name="search" align="center" style="margin-right:70px; margin-left:30px;" method = "get"  action ="insurance_search.jsp" onsubmit="return keyword_check()">

<!-- align : 정렬 , style : 스타일 정보 포함 (margin : 여백 설정) , method : 전달 방식 ,  action : submit 시 이동 경로 ,onsubmit : submit 클릭시 호출 조건 (true 일 때 action으로 넘어감 )-->

<td>

  <input type="text" name="keyword"> 

  </td>

<td>

<input type="submit" style="width:50px; margin-left:10px;" value="검색">

</td>  

</form>   
    
    
<!--    
<form method="post" action="insurance_search.jsp">
<div class="col-lg-4">
	<input type="text" class="form-control pull-right" placeholder="Search" name="searchWord" />
	</div>
	<button class="btn btn-primary" type="submit" >
	<span class="glyphicon glyphicon-search">
	</span>
	</button>
</form>  -->
    
    
    
    
    
    
    
    
<div style= "text-align: center; margin-top:200px;">
    
<img src="/images/insurance.jpg" alt="" style="max-width:100%; height:auto;" />
    
    
</div>



