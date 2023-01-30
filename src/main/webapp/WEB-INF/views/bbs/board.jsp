<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <link rel="stylesheet" href="/css/board/static.css">
  <link rel="stylesheet" href="/css/board/board.css">
  <link rel="stylesheet" href="/css/board/reset.css">
<script>
var usedcar = {
		maker : "",
		trim_name : "",
		car_no:"",
		rentfee_min : "",
		rentfee_max : "",
		deposit : "",
		orderby : "",
		car_type : "중고차"
	}

$(document).ready(function(){
});

function submitForm(){
	if(searchForm(this))
		$("#scForm").submit();
}
function searchForm(frm){
	if($("#search").val() ==''){
		alert("검색 내용을 입력해 주세요.");
		$("#search").focus();
		return false;
	}
	return true;
}
</script>
<c:if test="${userLevel > 5}">
<script>
function save(){
	if($("#bd_title").val() == '') {
		alert("제목을 입력해 주세요.");
		$("#bd_title").focus();
		return;
	}

	var formData = new FormData();
	formData.append("bd_type","1");
	formData.append("bd_title", urlHarmonyEncode($('#bd_title').val()) );
	formData.append("bd_isnotice", $('#bd_isnotice').val());
	formData.append("bd_viewcnt", "0");
//	formData.append("bd_contents",urlHarmonyEncode($('#bd_contents').val()) );
	formData.append("bd_contents","");
	formData.append("bd_isdel", "0");
	formData.append('attechFiles', $('#attechFiles')[0].files[0]);
	
	$.ajax({
		url : '${ctx}/bbs/boardAction',
		processData : false,
		contentType : false,
		data : formData,
		type : 'POST',
		success : function(data) {
			if(data.resultCode == "NOT_USER"){
				alert('등록권한이 없습니다.');
				return;
			} else if(data.resultCode == "0000"){
				location.href = "/bbs/board?bd_type=1";
			} else {
				alert('게시물 저장에 실패했습니다.');
				return;
			}
		},error:function(xhr, textStatus) {
			alert('게시물 저장에 실패했습니다.');
			return;
		},complete : function(result) {
		}
	});
}
function urlHarmonyEncode(url) {
	url = url.toString();
	return encodeURIComponent(url);
	//  return encodeURIComponent(url.replace(/&lt;/gi, "%PP_%").replace(/&gt;/gi, "%_PP%").replace(/</gi, "%P_%").replace(/>/gi, "%_P%").replace(/href=/gi, "%href_P%"));
}
</script>
</c:if>

<div class="container_hrmbbs">

        <div class="search_hrmbbs">
            <form id="scForm" name="scForm" action="" method="POST" onSubmit="return searchForm(this)">
                <div class="input_box_hrmbbs">
             		<input type="hidden" name="bd_type" values="${bd_type }">
                    <input type="text" placeholder="Search" id="search" name="search">
                    <figure>
                        <img src="/images/others/search.png" alt="" onclick="submitForm();">
                    </figure>
                </div>
            </form>
        </div>

        <div class="table_hrmbbs">
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>다운로드</th>
                    </tr>
                </thead>

                <tbody>
 <c:forEach var="boardVO" items="${boardVO }" varStatus="board">
 <c:set var="fileName" value="${fn:split(boardVO.bd_filelink, '/')}" />

                    <tr>
                        <td>${board.count }</td>
                        <td>${boardVO.bd_title }</td>
                        <td><a href="${boardVO.bd_filelink}">${fileName[fn:length(fileName)-1]}</a></td>
                    </tr>
</c:forEach>
                 </tbody>
            </table>
        </div>
<c:if test="${userLevel > 5}">
        <div class="btn_hrmbbs">
            <button type="button" onclick="modalOn()">자료등록</button>
        </div>
</c:if>        
    </div>

<c:if test="${userLevel > 5}">
    <div class="modal_hrmbbs">
        <div class="bg_hrmbbs" onclick="modalOff()"></div>
        <div class="content_hrmbbs">
            <div class="top_area_hrmbbs">
                <figure onclick="modalOff()">
                    <img src="/images/others/x.png" alt="">
                </figure>
            </div>
            <div class="bottom_area_hrmbbs">
                <form action="">
                    <div class="input_inner_hrmbbs">
                        <div class="input_box_hrmbbs">
                            <label for="">첨부파일</label>
                            <input type="file" name="attechFiles" id="attechFiles">
                        </div>
                        <div class="input_box_hrmbbs">
                            <label for="">제목</label>
                            <input type="text" placeholder="TEXT" name="bd_title" id="bd_title">
                        </div>
                        <div class="input_box_hrmbbs">
                            <label for="">출력순서</label>
                            <select name="bd_isnotice" id="bd_isnotice">
                                <option value="1">상위노출</option>
                                <option value="0">순차노출</option>
                            </select>
                        </div>
                    </div>

                    <div class="modal_btn_hrmbbs">
                        <button type="button" onClick="save()">자료등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:if>
</div>
<script>
    $('.sub_li_hrmbbs').click(function () {
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
        } else {
            $(this).addClass('active');
        }
    })

    function modalOn() {
        $('.modal_hrmbbs').fadeIn(500);
        $('.bg_hrmbbs').css('display', 'block');
        $('body').css('overflow', 'hidden');
    }

    function modalOff() {
        $('.modal_hrmbbs').fadeOut(500);
        $('.bg_hrmbbs').css('display', 'none');
        $('body').css('overflow', 'unset');
    }    

window.addEventListener("load", function() {
	//getEstimateList();
});
</script>
