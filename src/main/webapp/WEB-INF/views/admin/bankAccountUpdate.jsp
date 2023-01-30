<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


  <link rel="stylesheet" href="/css/static.css">
  <link rel="stylesheet" href="/css/admin.css">
  <link rel="stylesheet" href="/css/admin-estimatelist.css" />
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#used_code").val("${bankAccountVo.used_code }").prop("selected",true);
	});
	
	function save(){
		if($("#bank_name").val() == '') {
			alert("은행명을 입력하세요.");
			$("#bankAccountVo #bank_name").focus();
			return;
		}
		if($("#account").val() == '') {
			alert("계좌번호를 입력하세요.");
			$("#bankAccountVo #account").focus();
			return;
		}
	
		var formData = new FormData();
		formData.append("seqno","${bankAccountVo.seqno }");
		formData.append("bank_name", $('#bank_name').val());
		formData.append("account", $('#account').val());
		formData.append("carno", $('#carno').val());
		formData.append("user_name", $('#user_name').val());
		formData.append("reg_id", $('#reg_id').val());
		formData.append("used_code", $('#used_code').val());
		
		$.ajax({
			url : '/admin/bankAccountAction',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(data) {
				if(data.resultCode == "NOT_LOGGED"){
					alert('로그인이 만료되었습니다.');
					return;
				} else if(data.resultCode == "0000"){
					moveList();
				} else {
					alert('정보 저장에 실패했습니다.');
					return;
				}
			},error:function(xhr, textStatus) {
				alert('정보 저장에 실패했습니다.');
				return;
			},complete : function(result) {
			}
		});
	}
	
	// 상세
	function moveList() {
		var url = "/admin/bankAccount";
		location.href = url;
	}	
	
</script>
	
    <div class="main_content content_box">
    <h2>
      계좌 정보 수정
    </h2>
<div class="cont-area">    
 <form id="userVO" action="bankAccountAction">
	<input type="hidden" id="seqno" value="${bankAccountVo.seqno}"/>
    <div class="register_wrap">
      <div class="left_area">
        <h3 class="sub_title">
          계좌정보
        </h3>
        <ul class="info_list">
          <li class="info_item">
            <p class="info_title">은행명</p>
            <div class="input_wrap">
              <input type="text" id="bank_name" name="bank_name" value="${bankAccountVo.bank_name }" placeholder="입력창(텍스트)">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">계좌번호</p>
            <div class="input_wrap">
              <input type="text" id="account" name="account" value="${bankAccountVo.account }" placeholder="입력창(텍스트)">
            </div>
          </li>		
          
          <li class="info_item">
            <p class="info_title">차량번호</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="carno" id="carno" value="${bankAccountVo.carno }">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">이용자명</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="user_name" id="user_name" value="${bankAccountVo.user_name }" style="width: 100%">
            </div>
          </li>
          <li class="info_item">
            <p class="info_title">관리자ID</p>
            <div class="input_wrap">
              <input type="text" placeholder="입력창(텍스트)" name="reg_id" id="reg_id" value="${bankAccountVo.reg_id }">
            </div>
          </li>

          <li class="info_item">
            <p class="info_title">사용여부</p>
            <div class="input_wrap">
              <select class="box_style" name="used_code" id="used_code">
                <option value="0">미발급</option> 
                <option value="1">발급</option>
              </select>
            </div>
          </li>
         </ul>
       </div>
    </div>
    <div class="bottom_area" >
      <div class="button_wrap">
        <button type="button" onClick="save()">등록</button>
      </div>
    </div>
  </div>
</form>
</div>	

