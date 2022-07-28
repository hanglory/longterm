<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Happy+Monkey&display=swap" rel="stylesheet">
<!--  script src="https://kit.fontawesome.com/8087639611.js" crossorigin="anonymous"></script -->
<script>
	function logout() {
		location.replace('${CPATH}/user/logout');
	}

</script>
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
<header class="noselect">
<c:if test="${userLevel > 0 }">
		<div class="login-info">
			<span>${userId} 님</span>
			<button onclick="location.href='${CPATH}/member/${userId}/estimatelist';">마이페이지</button>
			<c:if test="${userLevel == 10 }">
			<button onclick="location.href='${CPATH}/admin/estimatelist'" value="관리자">관리자</button>
			</c:if>
			<button onclick="javascript:logout();" value="로그아웃">로그아웃</button>
		</div>
</c:if>		
</header>


    <nav class="nav_head_menu">
      <div class="logo__nav">
        <a href="/"><img src="${RPATH}/images/logo.png" alt="" /></a>
      </div>
      <ul class="nav-links">
            <li><a href="${CPATH}/">Home</a></li>
            <li><a href="${CPATH}/company">회사소개</a></li>
            <li><a href="${CPATH}/totalrent">견적내기</a></li>
            <li><a href="${CPATH}/bbs/usedcarRealNew">즉시출고신차</a></li>
            <li><a href="${CPATH}/bbs/usedcarReal">즉시출고중고</a></li>
            <li><a href="${CPATH}/bbs/board">자료실</a></li>
            <li><a href="${CPATH}/bbs/board_faq">FAQ</a></li>
	
<c:if test="${userLevel == null }">
       <li><a href="/member">로그인</a></li>
</c:if>
<c:if test="${userLevel > 0 }">
        <li><a href="/download">계약/설명서</span></a></li>
</c:if>

      </ul>
      <div class="burger">
        <div class="line1"></div>
        <div class="line2"></div>
        <div class="line3"></div>
      </div>
<% if( isMobile ==1 ){ %>
	<c:if test="${fn:indexOf(URI,'main') >= 0 }">
<div id="tbtn2" style="width: 80px;"> 
            <img src ="${RPATH}/images/btn_call2.png"/>
	      </div>
	 </c:if>
<% } %>	      
    </nav>



<script>
//모바일 전화버튼 누를시 번호안내로 스크롤
	$(document).ready(function(){

		$('#tbtn2').click(function(){

			var offset = $('#customer').offset(); //선택한 태그의 위치를 반환

                //animate()메서드를 이용해서 선택한 태그의 스크롤 위치를 지정해서 0.4초 동안 부드럽게 해당 위치로 이동함 

	        $('html').animate({scrollTop : offset.top}, 400);

		});

	});
        </script>

<script>
// 메뉴 768 이하일때 햄버거 메뉴로 변경하고 클릭시 메뉴리스트 보여줌.
const burger = document.querySelector(".burger");
const nav = document.querySelector(".nav-links");
const navlinks = document.querySelectorAll(".nav-links li");
const navAnimation = () => {
  navlinks.forEach((link, index) => {
    // 애니메이션이 있을 때
    if (link.style.animation) {
      // 애니메이션 비움
      link.style.animation = "";
    } else {
      // 애니메이션 없을 때 애니메이션을 추가
      // 딜레이 간격을 줘서 li가 하나씩 차례대로 나타나도록 설정
      
      link.style.animation = `navLinkFade 0.0s ease forwards ${
        index / 7 + 0.0       
      }s`;
    }
  });
};
const handleNav = () => {
  nav.classList.toggle("nav-active");
  //nav Animation
  navAnimation();
  //burger Animation
  burger.classList.toggle("toggle");
};
const navSlide = () => {
  burger.addEventListener("click", handleNav);
};

const setNavTransition = (width) => {
  if (width > 768) {
    nav.style.transition = "";
  } else {
    nav.style.transition = "transform 0.5s ease-in";
  }
};

const handleResize = () => {
  const width = event.target.innerWidth;
  setNavTransition(width);
};

const init = () => {
  // Toggle Nav
  window.addEventListener("resize", handleResize);
  navSlide();
};

init();
</script>
