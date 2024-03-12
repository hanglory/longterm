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
    
    
<script>
 
    let carzone = [
    { name: "010-3704-3028 | 메가모터스(서울시 성동구 성수이로 26길19 (성수동2가)) \n", favorites: "서울시 성동구" },
    { name: "010-4310-9344 | 대성자동차(서울시 도봉구도봉로150다길42(방학동)) \n", favorites: "서울시 도봉구" },
    { name: "010-4042-3689 | M모터스(경기도 고양시 일산동구 견달산로225번길 66) \n", favorites: "경기도 고양시 일산동구" },
    { name: "010-8942-0001 | 동일공업사(경기도 포천시 소홀읍 죽엽산로 28) \n", favorites: "경기도 포천시 소홀" },
    { name: "010-6267-4985 | 제일공업사(경기도 수원시 권선구 매송고색로 804번길 21) \n", favorites: "경기도 수원시 권선구" },
    { name: "010-3936-0150 | 대한모터스(경기도 부천시 오정동 805-4) \n", favorites: "경기도 부천시 오정동" },
    { name: "010-6314-7537 | 서부중앙(경기도 안산시 단원구 선이로4길 9) \n", favorites: "경기도 안산시 단원구" },
    { name: "010-3057-0621 | 발안정비(경기도 화성시 팔탄면 삼천병마로 355-23) \n", favorites: "경기도 화성시 팔탄, 병마" },
    { name: "010-5264-8346 | 한도하이테크(경기도 평택시 이화로 359) \n", favorites: "경기도 평택시 이화로" },
    { name: "010-9316-5230 | 안양 현대서비스(경기도 안양시 동안구 시민대로 63 (호계동899-7)) \n", favorites: "경기도 안양시 동안구" },
    { name: "010-8915-5071 | 부광모터스(경기도 파주시 월롱면 도감로 164) \n", favorites: "경기도 파주시 월롱면 도감로" },
    { name: "010-5091-1007 | 서일 자동차 공업사(인천시 남동구 논현고잔로 130번길25) \n", favorites: "인천시 남동구,인천광역시, 고잔로" },
    { name: "010-3444-3069 | 태전공업사(대전 서구 월평동 127) \n", favorites: "대전광역시 , 대전시, 월평동, 서구" },
    { name: "010-3525-9877 | 신원모터스(대구 서구 중리동 1060-3) \n", favorites: "대구광역시 서구, 대구시, 중리동, 서구" },
    { name: "010-9350-1115 | 프로모터스(경북 안동시 앙실2길 13) \n", favorites: "경상북도 안동시,경상도" },
    { name: "010-4533-5845 | 쌍용 포항 정비(경북 포항시 북구 소티재로 66) \n", favorites: "경상북도 포항시,경상도, 북구" },
    { name: "010-4848-3855 | 세창공업사(경남 창원시 마산 합포구 산호동 204-10) \n", favorites: "경상남도 창원시,경상도, 합포구" },
    { name: "010-8420-0112 | 대운모터스(경남 진주시 큰돌로 126번길 7) \n", favorites: "경상남도 진주시, 경상도, 큰돌로" },
    { name: "010-5899-9525 | 문성 정비(경남 거제시 옥포 성안로 67) \n", favorites: "경상남도 거제시,경상도, 옥포, 성안로" },
    { name: "010-3871-8633 | 광명 정비(부산광역시 사상구 삼락동 낙동대로 1354) \n", favorites: "부산광역시,부산시,경상도, 사상구, 삼락동" },
    { name: "010-9409-7559 | 신범공업사(충북 제천시 내토로 55길 7-10) \n", favorites: "충청북도 제천시,충북,충청도, 내토로" },
    { name: "010-5462-6050 | 아진공업사(충북 청주시 흥덕구 신봉동 209-1) \n", favorites: "충청북도 청주시 흥덕구 신봉동,충북,충청도" },
    { name: "010-4284-3100 | 조운공업사(충북 충주시 금봉대로 424) \n", favorites: "충청북도 충주시, 충북, 충청도, 금봉" },
    { name: "010-6421-0519 | 충남 자동차 공업사(충남 아산시 실옥동 346-5) \n", favorites: "충청남도 아산시 실옥동, 충남, 충청도" },
    { name: "010-6409-3870 | 서산 종합 자동차 정비(충남 서산시 예천동 659-1) \n", favorites: "충청남도 서산시 예천동, 충남, 충청도" },
    { name: "010-5437-0845 | 부여 현대공업사(충남 부여군 규암면 흥수로 860) \n", favorites: "충남 부여군 규암면 흥수로 , 충청남도, 충청도" },
    { name: "010-3802-1443 | (주)강남일급정비공장(강원 춘천시 신동면 김유정로 1577) \n", favorites: "강원도, 강원도 춘천시 신동면,김유정로" },
    { name: "010-4031-6866 | 골드 자동차정비(강원도 원주시 현충로 12) \n", favorites: "강원도 원주시 현충로" },
    { name: "010-3354-4982 | 우리 자동차정비(강원도 동해시 발한로 56) \n", favorites: "강원도 동해시 발한로" },
    { name: "010-7362-6150 | 속초 대명1급 공업사(강원도 속초시 번영로 176) \n", favorites: "강원도 속초시 번영로" },
    { name: "010-3277-8115 | 형제 모터스(강원도 태백시 화전동 14-39) \n", favorites: "강원도 태백시 화전동" },
    { name: "010-3689-2772 | 오라 1급공업사(전북 김제시 교월동 벽골제로 853) \n", favorites: "전라북도 김제시,전북,교월동" },
    { name: "010-9476-0057 | 우성공업사(전북 전주시 덕진구 서귀로 23길) \n", favorites: "전락북도 전주시 덕진구 서귀로, 전북" },
    { name: "010-3623-7799 | 뉴중흥공업사(광주 북구 중흥동 제봉로 277-1) \n", favorites: "광주광역시 북구 중흥동, 전라남도,전라도,광주시" },
    { name: "010-3623-8612 | 진남공업사(전남 여수시 둔덕8길 6) \n", favorites: "전남 여수시,전라남도 여수,둔덕" },
    { name: "010-3462-3329 | 강진공업사(전남 강진군 강진읍 해강로 1404) \n", favorites: "전남 강진군,강진시,해강로,강진읍" },
    { name: "010-5322-4757 | 하당공업사(전남 목포시 남악로 58번길 16) \n", favorites: "전남 목포시,전라남도 목포시,남악로" },
    { name: "010-3690-3336 | 조흥공업사(제주 선반로 10길 5) \n", favorites: "제주,제주 선반로,제주시,서귀포시" },
    
        
];
    
  /*for (let i = 0; i < students.length; i++) {
   
    document.querySelectorAll("#students li .name")[i].innerText = students[i].name;
    document.querySelectorAll("#students li .favorites")[i].innerText = students[i].favorites;
     
}  */
    
    function searchFilter(data, type, search) {
    // data 값을 하나하나 꺼내와서
    return data.map((d) => {
        // 만약 해당 데이터가 search 값을 가지고 있다면 리턴한다.
        if (d[type].includes(search)) {
            return d;
        }
    });
}
    
    
    function search() {
        
        
    // 폼에 입력된 값
    let sel = document.getElementById("search-select").value;
    let text = document.getElementsByClassName("search-text")[0].value;
        
      if(text == ''){
        alert('검색어를 입력하세요.');
    }else{    

    // res [undefined, {id:, name: favorites:}, undefined] 이런식으로 리턴
    // 따라서 undefined 값을 제거해줘야하기 때문에 filter 메소드 적용
    let res = searchFilter(carzone, sel, text).filter((d) => d !== undefined);


        // 결과 값 화면 출력
    document.getElementById("result").innerText = res.map((d) => d.name);
    }
    
}

// 클릭 시 search 함수 호출
document.getElementById("btn").addEventListener("click", search);  
</script>
    
    
    
    
    
 <div style = "margin-top:150px;">
 
 <h1 align="CENTER" style="color:#0081ff;"> <!-- h1 사이즈로 내용 출력  -->

정비 협력업체 안내

</h1>
   </div>
    
  <br>
    <br>
<div style="text-align:center;">  
<div style="font-size:15px;">
    정비받을 지역(ex.서울,제주) 혹은 정비소 이름을 입력해 주세요.
    <!--<span id="students">
        <li>
            <span class="id"></span> | <span class="name"></span> |
            <span class="favorites"></span>
        </li>
        <li>
            <span class="id"></span> | <span class="name"></span> |
            <span class="favorites"></span>
        </li>
        <li>
            <span class="id"></span> | <span class="name"></span> |
            <span class="favorites"></span>
        </li>
    </span>-->
</div>
    
    
<br />
<form>
<select id="search-select">
    
   <option value="favorites">지역</option>
    <option value="name">정비소이름</option>
    
</select>
<input type="text" class="search-text" />
<button id="btn" onclick="search();return false">검색</button>
<br>
<br><br>
</form>
<div>
   <h2> 결과 </h2> <br>
    <span id="result" style="font-size:18px;color:#ff2300;"></span>
</div>    

    
    </div>
 <!--   
<form name="search" align="center" style="margin-right:70px; margin-left:30px;" method = "get"  action ="insurance_search.jsp" onsubmit="return keyword_check()">



<td>

  <input type="text" name="keyword"> 

  </td>

<td>

<input type="submit" style="width:50px; margin-left:10px;" value="검색">

</td>  

</form> -->  
    
    
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



