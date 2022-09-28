<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.harmony.longterm.session.SessionConfig" %> 




  <header>
    <div class="top_area">
      <h1>
        하모니렌트카 관리자
      </h1>
      <div class="button_wrap">
        <button onclick="javascript:logout();">로그아웃</button>
      </div>
    </div>
    <nav class="main_nav">
      <ul class="main_nav content_box">
        <li class="main_item"><a href="${CPATH}/totalrent">견적페이지</a></li>
        <li class="main_item"><a href="/admin/estimatelist">견적리스트</a></li>
        <li class="main_item">
          즉시출고
          <ul class="sub_nav">
            <li class="sub_item"><a href="${CPATH}/admin/usedcarlist">즉시출고리스트</a></li>
            <li class="sub_item"><a href="${CPATH}/admin/usedcarform">즉시출고등록</a></li>
          </ul>
        </li>
         <li class="main_item"><a href="/admin/userList">이용자리스트</a></li>
         <li class="main_item"><a href="/admin/siteinfoList">사이트관리</a></li>
         <li class="main_item"><a href="/admin/bankAccount">계좌관리</a></li>
         <li class="main_item"><a href="https://analytics.google.com/analytics/web/?authuser=1#/p307749999/reports/reportinghub?params=_u..nav%3Dmaui" target="_new">구글통계</a></li>
        
      </ul>
    </nav>
  </header>

<script>
	function logout() {
		location.replace('${CPATH}/user/logout');
	}

</script>
