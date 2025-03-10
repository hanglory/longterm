<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 100; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 0;
  border: 1px solid #888;
  width: 80%;
  max-width: 500px;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  -webkit-animation-name: animatetop;
  -webkit-animation-duration: 0.4s;
  animation-name: animatetop;
  animation-duration: 0.4s
}

/* Add Animation */
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}

@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}

/* The Close Button */
.close {
  color: white;
  float: right;
  font-size: 28px;
  font-weight: bold;
  line-height: 20px;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

.modal-header {
	font-family: "Noto Sans CJK KR";
	padding: 2px 16px;
	background-color: #59a;
	color: white;
}

.modal-body {
	padding: 20px 20px;
	font-size: 20px;
	line-height: 30px;
}

.modal-footer {
  padding: 2px 16px;
  background-color: #5cb85c;
  color: white;
}

#option1, #option2 {
	font-weight: 900;
	color: #39f;
}
</style>


<!-- Trigger/Open The Modal -->
<!-- <button id="myBtn">Open Modal</button> -->

<!-- The Modal -->
<div id="myModal" class="modal">

	<!-- Modal content -->
	<div class="modal-content">
		<div class="modal-header">
			<span class="close">&times;</span>
			<h2>알림</h2>
		</div>
	    <div class="modal-body">
			<span>[</span>            
			<span id="option1"></span><span>] 옵션과 [</span>
			<span id="option2"></span>
			<span>] 옵션은 동시에 선택이 불가합니다.</span>
	    </div>

	</div>

</div>

<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
var showModal = function(data1, data2) {
	document.getElementById("option1").innerText = data1;
	document.getElementById("option2").innerText = data2;
  	modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  	modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.addEventListener("click", function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
});

</script>

<div id="dialog-message" title="선택하세요." style='display:none'>
선택하신 모델과 트림은 본사 프로모션차량으로 빠른출고와 납입금 절감(무심사기준)이 가능합니다. 영업담당자에게 문의주세요.
</div>
<script>
async function crayBtn1()
{
	$('#dialog-message').dialog({
		modal: true, 
		buttons: {
			"프로모션보기": await function() { $(this).dialog('close'); return true},
			"견적서보기": await function() { $(this).dialog('close'); return false}
		}
	});
}
</script>

<!-- The Modal -->
	<!-- Modal content -->
	<div id="modal_dialog" class="modal-content" style='display:none' >
	    <div class="modal-body">
			<span>선택하신 모델과 트림은 </span>            
			<span id="option1">프로모션차량</span><span>으로 빠른출고와 납입금 절감(무심사기준)이 가능합니다.</span>
			<span id="option2">영업담당자에게 문의주세요.</span>
	    </div>
    	<div style="text-align: center;" class="button_wrap" >
    		<input type='button' value='프로모션보기' id='btnYes' style="padding: 8px 22px;"/>
    		<input type='button' value='견적서보기' id='btnNo' style="padding: 8px 22px;"/>
        </div>
	</div>





<script>
function dialog(message, yesCallback, noCallback) {
    $('.confirm_title').html(message);
    var dialog = $('#modal_dialog').dialog({      title: '프로모션',
        modal: true, width:'auto',height:'auto'});

    $('#btnYes').click(function() {
        dialog.dialog('close');
        yesCallback();
    });
    $('#btnNo').click(function() {
        dialog.dialog('close');
        noCallback();
    });
}
</script>
