<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  <link rel="stylesheet" href="/css/board/faq.css">
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
	if(${bd_type} == 2){
		$('#bd_type_btn2').addClass('active');
	}else if(${bd_type} == 3){
		$('#bd_type_btn3').addClass('active');
	}
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
<script type="text/javascript">
function save(){
	if($("#bd_type").val() == "0"){
		alert("게시판을 선택해 주세요.");
		$("#bd_type").focus();
		return;
	}
	if($("#bd_title").val() == '') {
		alert("제목을 입력해 주세요.");
		$("#bd_title").focus();
		return;
	}
	if($("#bd_contents").val() == '') {
		alert("내용을 입력해 주세요.");
		$("#bd_contents").focus();
		return;
	}

	var formData = new FormData();
	formData.append("bd_type", $("#bd_type").val());
	formData.append("bd_title", urlHarmonyEncode($('#bd_title').val()) );
	formData.append("bd_isnotice", "0");
	formData.append("bd_viewcnt", "0");
	formData.append("bd_contents",urlHarmonyEncode($('#bd_contents').val()) );
//	formData.append("bd_contents",$("#bd_contents").val() );
	formData.append("bd_isdel", "0");
	if($('#attechFiles')[0].files[0])
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
				location.href = "/bbs/board_faq?bd_type=${bd_type}";
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
        <div class="main_bg_hrmbbs">
            <div class="title_hrmbbs">
                <h2>자주하는 질문</h2>
                <span>자주하는 질문을 확인해보세요.</span>
            </div>
        </div>

        <div class="search_hrmbbs">
            <form action="" method="POST" onSubmit="return searchForm(this)" id="scForm" name="scForm">
                <div class="input_box_hrmbbs">
                	<input type="hidden" name="bd_type" values="${bd_type }">
                    <input type="text" placeholder="궁금한 점을 검색해보세요. ex)해지시 계약금"  id="search" name="search">
                    <figure>
                         <img src="/images/others/search.png" alt="" onclick="submitForm();">
                    </figure>
                </div>

                <div class="btn_hrmbbs">
                    <button type="button" id="bd_type_btn2" onclick="location.href='board_faq?bd_type=2'">계약 관련</button>
                    <button type="button" id="bd_type_btn3" onclick="location.href='board_faq?bd_type=3'">차량이용 관련</button>
                </div>
            </form>
        </div>

        <div class="accodian_hrmbbs">
            <div class="title_hrmbbs">
                <h2>전체</h2>
            </div>

            <div class="menu_list_hrmbbs">
 <c:forEach var="boardVO" items="${boardVO }" varStatus="board">
                <div class="txt_htmbbs">
                    <span>${boardVO.bd_title }</span>
                    <em></em>
                </div>
                <div class="sub_menu_list_hrmbbs">
                    <p>${boardVO.bd_contents }</p>
                    <div class="sub_btn_hrmbbs">
                        <span>${boardVO.bd_filename }</span>
                        <button type="button" onclick="location.href='${boardVO.bd_filelink }'">다운로드</button>
                    </div>
                </div>
</c:forEach>

            </div>
        </div>
<c:if test="${userLevel > 5}">
        <div class="footer_btn_hrmbbs">
            <button type="button" onclick="modalOn()">게시물 등록</button>
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
                            <select name="bd_type" id="bd_type">
                                <option value="0">게시판을 선택해 주세요.</option>
                                <option value="2">계약관련</option>
                                <option value="3">차량이용 관련</option>
                            </select>
                        </div>

                        <div class="input_box_hrmbbs">
                            <input type="text" placeholder="제목을 입력해주세요." id="bd_title" name="bd_title">
                        </div>

                        <div class="input_box_hrmbbs">
                            <textarea  id="bd_contents" name="bd_contents" placeholder="답변을 입력해주세요."></textarea>
                        </div>

                        <div class="input_box_hrmbbs">
                            <input type="file" name="attechFiles" id="attechFiles">
                            <div class="modal_btn_hrmbbs">
                                <button type="button"  onClick="save()">등록</button>
                            </div>
                        </div>
                    </div>


                </form>
            </div>
        </div>
    </div>
</div>
</c:if>
<script>
var acodian = {
    click: function (target) {
        var $target = $(target);
        $target.on('click', function () {

            if ($(this).hasClass('on')) {
                slideUp($target);
            } else {
                slideUp($target);
                $(this).addClass('on').next().slideDown();
            }

            function slideUp($target) {
                $target.removeClass('on').next().slideUp();
            }

        });
    }
};
acodian.click('.menu_list_hrmbbs .txt_htmbbs');


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
</script>

      
