/**
 * 
 */


// includes는 IE에서 동작하지 않아서 indexOf를 사용
var userAgent = window.navigator.userAgent;
var isChrome = userAgent.indexOf('Chrome') == -1 ? false : true;
var isChromeMobile = userAgent.indexOf('CriOS') == -1 ? false : true;
var isSamsungBrowser = userAgent.indexOf('SamsungBrowser') == -1 ? false : true;
var isWindows = userAgent.indexOf('Windows NT') == -1 ? false : true;
var isEdge = userAgent.indexOf('Edge') == -1 ? false : true;
var isIE = userAgent.indexOf('Trident') == -1 ? false : true;
var isSafari = userAgent.indexOf('safari') == -1 ? false : true;
var isPhoneAuth = false;

var car = {
	maker : "",
	model : "",
	lineup : "",
	trim : "",
	total_option_name : "",
	model_id : -1,
	trim_id : -1,
	trim_price : 0,
	total_option_price : 0,
	deposit_ratio : 0.5,
	deposit: 0,
	period : 48,

	deposit_ratio_hi : 0.1,
	period_hi : 48,
	deposit_ratio_my : 0.5,
	period_my : 48,
	deposit_ratio_ou : 0.7,
	period_ou : 48,
	deposit_ratio_no : 0.1,
	period_no : 48,
	rentfee_hi : 0,
	rentfee_my : 0,
	rentfee_ou : 0,
	rentfee_no : 0,
	rentnames : "",
	deposit_hi : 0,
	deposit_my : 0,
	deposit_ou : 0,
	deposit_no : 0,
	acquisition_hi: 0,
	acquisition_my: 0,
	acquisition_ou: 0,
	acquisition_no: 0,
	preprice_hi :0,
	preprice_my :0,
	preprice_ou :0,
	preprice_no :0,
	jangrate_hi : 0,
	jangrate_my : 0,
	jangrate_ou : 0,
	jangrate_no : 0,
	prepayment:0,
	agentfee_hi:0,
	agentfee_my:0,
	agentfee_ou:0,

	distance : 30000,
	image : "",
	options : "",
	color_id: 0,
	color_name: "",
	color_price: "0",
	rentfee: 0,
	acquisition: 0,
	agent_fee_rate: 0,
	agent_fee_rate_no:1,
	agent_fee: 0,
	tagsong : "",
	tagsong_price : 0,
	blackbox : "",
	blackbox_price: 0,
	optionlist:"",
	cal_price:0,
	phone:"",
	customer:"",
	authNumber:""

}
	
var updateOptionList = function () {
	var optionStr = new Array();

	$('input:checkbox[name="option"]').each(function() {
		let jsonObj = new Object();;
		jsonObj.id = $(this).data('id');
		jsonObj.name = $(this).data('name'); 
		jsonObj.price = $(this).data('price');

		if(this.checked) {//checked 처리된 항목의 값
			jsonObj.state = "on";
		}
		else
			jsonObj.state = "off";
		optionStr.push(jsonObj);
			
	});
	
	car.options = optionStr;
}

//kind : 5=전체 확인,1=하이렌트, 2=마이렌트, 3=오너형, 4=무심사		
var UpdateSummary = function(kind=5) {

	if (car.trim_id == -1) return;
	updateOptionList();
	
	$("#carname").html(car.maker + " " + car.model + " " +  car.lineup + " " + car.trim);
	$('#car-price').html(Number(car.trim_price).toLocaleString('en'));
	$('#option-price').html(car.total_option_name + "(" +Number(car.total_option_price).toLocaleString('en')+")");
	$('#period-summary').html(car.period + " 개월");
	//$('#distance-summary').html(car.distance / 10000 + "만Km/년");
	$('#price-total').html(Number(car.trim_price + car.total_option_price + car.color_price).toLocaleString('en'));
	$('#agency-fee-rate').html(car.agent_fee_rate + " %");
	
	var color = car.color_name;
	if (car.color_price != 0) color = color + "(+" + Number(car.color_price).toLocaleString('en') + ")";
	$('#color-name').html(color);


  if(kind == 1 || kind ==5){
 // 하이렌트
		car.deposit_ratio = car.deposit_ratio_hi;
		car.period = car.period_hi;
		car.prepayment = car.preprice_hi*10000;
	$.ajax({ 
		type: "POST",
		url: baseUrl+"car/rentfee",
		data: JSON.stringify(car),
		//dataType: "json",          // ajax 통신으로 받는 타입
		contentType: "application/json",  // ajax 통신으로 보내는  타입
		success: function(data) {
			car.rentfee_hi = data.rentfee;
			//car.rentfee_hi = data.rentfee + ((data.org_price * 0.006413) + 94097);
			car.deposit_hi = data.deposit;
			car.acquisition_hi = data.acquisition;
//			car.jangrate_hi = data.jang_rate;
			car.agent_fee = data.agent_fee;
			car.agentfee_hi = data.agent_fee;
			car.cal_price = data.cal_price;
		
			
//			$('#rentfee_hi').html(Number(Math.round( car.rentfee_hi - (car.preprice_hi*10000/car.period_hi))).toLocaleString('en') + "원/월");
//			car.rentfee_hi = Math.round( car.rentfee_hi - (car.preprice_hi*10000/car.period_hi));
			$('#deposit_hi').html(Number(Math.round( data.deposit / 10000)).toLocaleString('en') + "만원");
			$('#rentfee_hi').html(Number(car.rentfee_hi).toLocaleString('en') + "원/월");
			
			$('#deposit-summary').html(car.deposit_ratio * 100 + " %   " + Number(car.deposit).toLocaleString('en'));
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		    alert("실패.")
		}		
	});	
  }
  if(kind == 2 || kind ==5){	
// 마이렌트
		car.deposit_ratio = car.deposit_ratio_my;
		car.period = car.period_my;
		car.prepayment = car.preprice_my*10000;
	$.ajax({	
		type: "POST",
		url: baseUrl+"car/rentfee",
		data: JSON.stringify(car),
		//dataType: "json",          // ajax 통신으로 받는 타입
		contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {
			car.rentfee_my = data.rentfee;
			car.deposit_my = data.deposit;
			car.acquisition_my = data.acquisition;
//			car.jangrate_my = data.jang_rate;
			car.agentfee_my = data.agent_fee;
			car.cal_price = data.cal_price;
			
//			$('#rentfee_my').html(Number(Math.round( car.rentfee_my - (car.preprice_my*10000/car.period_my))).toLocaleString('en') + "원/월");
//			car.rentfee_my = Math.round( car.rentfee_my - (car.preprice_my*10000/car.period_my));
			$('#deposit_my').html(Number(Math.round( data.deposit / 10000)).toLocaleString('en') + "만원");
			$('#rentfee_my').html(Number(data.rentfee).toLocaleString('en') + "원/월");
			
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		    alert("실패.")
		}		
	});	
  }

  if(kind == 3 || kind ==5){
//오너형
		car.deposit_ratio = car.deposit_ratio_ou;
		car.period = car.period_ou;
		car.prepayment = car.preprice_ou*10000;
	$.ajax({   
		type: "POST",
		url: baseUrl+"car/rentfee_ou",
		data: JSON.stringify(car),
		//dataType: "json",          // ajax 통신으로 받는 타입
		contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {


			car.rentfee_ou = data.rentfee;
			car.deposit_ou = data.deposit;
			car.acquisition_ou = data.acquisition;
			car.jangrate_ = data.jang_rate;
//			car.agentfee_ou = data.agent_fee;
			
//			$('#rentfee_ou').html(Number(Math.round( car.rentfee_ou - (car.preprice_ou*10000/car.period_ou))).toLocaleString('en') + "원/월");
			$('#deposit_ou').html(Number(Math.round( data.deposit / 10000)).toLocaleString('en') + "만원");
			$('#rentfee_ou').html(Number(data.rentfee).toLocaleString('en') + "원/월");

		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		    alert("실패.")
		}		
	});
  }

  if(kind == 4 || kind ==5){
 //무심사
 		if (car.trim_price + car.total_option_price + car.color_price > 50000000){
 			car.deposit_ratio = 0.2;
 			car.deposit_ratio_no = 0.2;
 		}else{
 			car.deposit_ratio = 0.1;
 			car.deposit_ratio_no = 0.1;
 		}
		car.period = car.period_no;
		car.prepayment = car.preprice_no*10000;
		car.agent_fee_rate = 0;	//무심사의 경우 수수료가 없다.
	$.ajax({   
		type: "POST",
		url: baseUrl+"car/rentfee",
		data: JSON.stringify(car),
		//dataType: "json",          // ajax 통신으로 받는 타입
		contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {
			car.rentfee_no = Number(data.rentfee) + Math.floor(((car.trim_price + car.total_option_price + car.color_price)*0.002)/1000)*1000;
			car.deposit_no = data.deposit;
			car.acquisition_no = data.acquisition;
			car.agent_fee_rate = car.agent_fee_rate_no;
			var no_price = Math.floor((car.preprice_no*10000/car.period_no)/1000)*1000;
			
//			$('#rentfee_no').html(Number( car.rentfee_no - no_price).toLocaleString('en') + "원/월");
			//car.rentfee_no = Number( car.rentfee_no - no_price);
			$('#deposit_no').html(Number(Math.round( data.deposit / 10000)).toLocaleString('en') + "만원");
			$('#depositrate_no').html(Number(car.deposit_ratio_no * 100 ).toLocaleString('en') + "%");
			$('#rentfee_no').html(Number(car.rentfee_no).toLocaleString('en') + "원/월");
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		    alert("실패.")
			
			
		}		
	});	
  }

}



$(function(){

	
//	$(window).scroll(function(){
//		var $el = $('.longterm-main');
//		if ($el == null) return;
//
//		var margin = $el.position().top;
//		var height = $('.longterm-result').height();
//		var bottomPos = $('#lower-section').position().top;
//		
//		console.log($el + " " + margin);
//		
//		if (margin < $(this).scrollTop()) {
//			$('.longterm-result').css('top', -(margin - $(this).scrollTop() - 10));
//			
//			var b = $('.longterm-result').position().top + $('.longterm-result').outerHeight(true);;
//				
//			if (b > bottomPos) {
//				$('.longterm-result').css('top', (-margin -height + bottomPos - 10));
//			}
//		}
//		else{
//			$('.longterm-result').css('top', 0);
//		}
//	});
	
	
	$('.maker').click(function() {
		let selStr = $(this).data('maker');
		let modelStr = "";
		car.maker = selStr;
		car.model = "";
		car.lineup = "";
		car.trim = "";
		car.trim_id = -1;
		car.trim_price = 0;

		$('.maker').removeClass('selected');
		$(this).addClass('selected');
		
		
		$.ajax({
			type: "POST",
			url: baseUrl+"car/modellist",
			//dataType: "json",
            contentType: "application/json",
			data: JSON.stringify(car),
			success: function(data) {
				
				for(let i=0; i<data.length; i++) {
					if (data[i].maker == selStr) {

						modelStr += "<li class='model' data-model='"+ data[i].model_name + "'>";
						modelStr += "<div class='wrap_thumb'>";
					//	modelStr += "<img src='" + baseUrl + "images/car/" + data[i].image + "' alt=''></img>";
						modelStr += "<span>" + data[i].model_name + "</span></div></li>";
						
					}
				}
				
				$('#model').html(modelStr);
				$('#lineup').html("");
				$('#trim').html("");
				$('#option').html("");
				$('#colortable').html("");

				checkHasItems();
				// IE가 아닌경우
				if (isIE == false)
				document.getElementById('model-header').scrollIntoView({behavior:"smooth", block:"center"});
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                alert("실패.")
			}
		});
		
		//car.UpdateSummary();
	});
	
	$('.occupancy').click(function() {
		let selStr = $(this).val();
		car.deposit_ratio = selStr;		
		UpdateSummary();
		
	});

/*	
	$('.period').click(function(e) {
		let selStr = $(this).find('input').val();
		car.period = selStr;	

		$(this).find('input').prop("checked", true);
		UpdateSummary();
		
		return false;
	});
*/

	$('#period_hi').change(function(e) {
		
		car.period_hi = $("#period_hi option:selected").val();
		car.period = $("#period_hi option:selected").val();
		console.log(car.period_hi);
		UpdateSummary(1);
		
		return false;
	});
	$('#period_my').change(function(e) {
		
		car.period_my = $("#period_my option:selected").val();
		car.period = $("#period_my option:selected").val();
		console.log(car.period_my);
		UpdateSummary(2);
		
		return false;
	});	
	$('#period_ou').change(function(e) {
		
		car.period_ou = $("#period_ou option:selected").val();
		car.period = $("#period_ou option:selected").val();
		UpdateSummary(3);
		
		return false;
	});
	$('#period_no').change(function(e) {
		
		car.period_no = $("#period_no option:selected").val();
		car.period = $("#period_no option:selected").val();
		UpdateSummary(4);
		
		return false;
	});
	
	$('#tagsong').change(function(e) {
	
		let selStr = $("#tagsong option:selected").val();
		car.tagsong = selStr;	
		car.tagsong_price = $("#tagsong option:selected").data('price');
		
		UpdateSummary();
		
		return false;
	});
	
	$('#blackbox').change(function(e) {
		
		let selStr = $("#blackbox option:selected").val();

		car.blackbox = selStr;	
		car.blackbox_price = $("#blackbox option:selected").data('price');

		UpdateSummary();
		
		return false;
	});
	
	$('#depositratio_hi').change(function(e) {
			
		car.deposit_ratio_hi = $("#depositratio_hi option:selected").val();
		if (car.trim_price + car.total_option_price + car.color_price > 50000000){
			if(car.deposit_ratio_hi < 0.2){
				alert('차량가격이 5000만원 이상이면 보증금은 20%부터 선택이 가능 합니다');
				$("#depositratio_hi").val("0.2");
				car.deposit_ratio_hi = 0.2;
			}
		}
		UpdateSummary(1);
		
		return false;
	});	


	$('#depositratio_ou').change(function(e) {
		
		car.deposit_ratio_ou = $("#depositratio_ou option:selected").val();
		console.log(car.deposit_ratio_ou);
		UpdateSummary(3);
		
		return false;
	});	

	
	$('#distance-summary').click(function() {
		let selStr = $("#distance-summary option:selected").val();
		car.distance = selStr;		
		UpdateSummary();
	});
	
	$(document).on("click", '.model', function() {
		let selStr = $(this).data('model');
		let lineupStr = "";
		car.model = selStr;
		car.lineup = "";
		car.trim = "";
		car.trim_id = -1;
		car.trim_price = 0;
		$('.model').removeClass('selected');
		$(this).addClass('selected');
		
		// lineup 정보 업데이트
		$.ajax({
			type: "POST",
			url: baseUrl+"car/lineuplist",
			data: JSON.stringify(car),
			//dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {

				for(let i=0; i<data.length; i++) {

					if (data[i].model_name == selStr) {

						lineupStr += "<li class='lineup' data-model_id='" + data[i].model_id + "'>" +
									"<div class='toggle-select__item'><input type='radio' id='model-" + data[i].model_id + "' name='lineup' " +
									" value='"+ data[i].model_id + "'>" +  
									"</input>" +
									"<label for='model-" + data[i].model_id + "'>" + data[i].lineup +
									"</label></div>" + 
									"</li>";
					}

				}
				
				$('#lineup').html(lineupStr);
				$('#trim').html("");
				$('#option').html("");
				$('#colortable').html("");

				checkHasItems();

				// IE가 아닌경우
				if (isIE == false)
				document.getElementById('lineup-header').scrollIntoView({behavior:"smooth", block:"center"});
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                alert("실패.")
			}
		});	
	});

	$(document).on("click", '.lineup', function() {
		var selStr = $(this).data('model_id');

		$(this).find('input').prop("checked", true);

		var trimStr = "";
		car.lineup = $(this).text();
		car.trim = "";
		car.trim_id = -1;
		car.trim_price = 0;
		
		car.model_id = selStr;
		$('.lineup').removeClass('selected');
		$(this).addClass('selected');
		
		$.ajax({
			type: "POST",
			url: baseUrl+"car/trimlist",
			data: JSON.stringify(car),
			//dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {

				for(let i=0; i<data.length; i++) {
					trimStr += "" +
						"<li class='trim toggle-select-row' data-trim_id='" + data[i].trim_id + 
						"' data-name='" + data[i].trim_name + "' data-price='" + data[i].price +"'>" + 
						"<div class='toggle-select__item'>" +
						"<input type='radio' id='trim-" + data[i].trim_id + 
						"' name='trim' value='" + data[i].trim_id +  
						"' />" +
						"<label for='trim-" + data[i].trim_id + "'><span>" + data[i].trim_name + "</span></label>" +
						"</div><div class='toggle-select__item select-price'><span>" +
						Number(Math.ceil(data[i].price/10000)).toLocaleString('en') + " 만원" + 
						"</span></div></li>" +
						"";
						
					car.image = data[i].image;
				}
				
				//console.log(trimStr);
				$('#trim').html(trimStr);
				$('#option').html("");
				$('#colortable').html("");

				checkHasItems();

				// IE가 아닌경우
				if (isIE == false)
				document.getElementById('trim-header').scrollIntoView({behavior:"smooth", block:"center"});
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                alert("실패.")
			}
		});	
		
		return false;
	});
	
	
	$(document).on("click", '.trim', function() {

		var selStr = $(this).data('trim_id');
		var optionStr = "";
		car.trim_id = selStr;
				
		car.trim = $(this).data('name');
		car.trim_price = $(this).data('price');
		car.total_option_price = 0;
		
		$('.trim').removeClass('selected');
		$(this).addClass('selected');
		$(this).find('input').prop("checked", true);
		
		$.ajax({
			type: "POST",
			url: baseUrl+"car/optionlist",
			data: JSON.stringify(car),
			//dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {

				for(let i=0; i<data.length; i++) {

					optionStr += "<li class='option toggle-select-row'" +
						"<div class='toggle-select-row'><div class='toggle-select__item'>" +
						"<input type='checkbox' id='option-" + data[i].option_id + 
						"'  name='option' data-price='" + data[i].price + 
						"' data-id='" + data[i].option_id +
						"' data-name='" + data[i].name +
						"' data-exc='" + data[i].exc + 
						"'/>" +
						
						"<label for='option-" + data[i].option_id + "'><span>" + data[i].name + "</span></label>" +
						"</div><div class='toggle-select__item select-price'><span>" +
						Number(data[i].price/10000).toLocaleString('en') + " 만원" + 
						"</span></div></div></li>";
				}

				$('#option').html(optionStr);
		
				checkHasItems();

				// IE가 아닌경우
				if (isIE == false)
				document.getElementById('option-header').scrollIntoView({behavior:"smooth", block:"center"});
			},
			// 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			error: function(XMLHttpRequest, textStatus, errorThrown){ 
                alert("OPTION 실패.")
			}
		});	
		
		// 색상 정보 업데이트
		var colorStr = "";
		car.color_name = "";
		car.color_price = 0;
		$.ajax({
			type: "POST",
			url: baseUrl+"car/colorlist",
			data: JSON.stringify(car),
			//dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {
				
				if (data.length == 0) {
					colorStr = "<li>색상 정보가 없습니다.</li>";
				}
				for(let i=0; i<data.length; i++) {

					colorStr += "<li class='color' data-color_name='" + data[i].color_name +
								"' data-price='" + data[i].price +
								"' data-color_id='" + data[i].idtrimcolor +
								"' >" +
								"<div class='color-box' style='background:" + data[i].color_value + ";' > </div>" + 
								"<div class='color-name'> " + data[i].color_name + "</div>" +  
								"</li>";
				}

				$('#colortable').html(colorStr);
				//  차량 이미지
				$('#car-image img').attr("src", baseUrl + "images/car/" + car.image);
				//.html("<img src=" + baseUrl + "images/car/" + car.image + " alt=''/> ");

				checkHasItems();
		},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                alert("COLOR 실패.")
			}
		});
		
		UpdateSummary();
		return false;	
	});

	$(document).on("click", '.color', function() {
		var selStr = $(this).data('color_name');
		car.color_name = selStr;
		car.color_price = $(this).data('price');
		car.color_id = $(this).data('color_id');
		
		$('.color').removeClass('selected');
		$(this).addClass('selected');
		
		UpdateSummary();
	}); // <------ color

		
	$('#option-check-all').on('click', function() {
		var optionList = document.querySelectorAll("input[name='option']");	
		for(var i=0; i<optionList.length; i++) {
			optionList[i].checked = $(this).is(":checked");
		}
		var sum = 0;
		$('input:checkbox[name="option"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
				sum += $(this).data('price');
			}
		});
		
		car.total_option_price = sum;
		UpdateSummary();
		
	});
	
	$(document).on("click", '.option', function() {
		var sum = 0;
		var option_name = "";
		var id = $(this).find('input').attr('id');

		var excs = "";
		if ($(this).find('input').data('exc') != null) {
			excs = $(this).find('input').data('exc').toString().split(':');
		}
		var excCheck = false;
		// child input을 찾아서 상태에 따라 변경해 준다.
		if($(this).find('input').prop("checked") == true) {
			$(this).find('input').prop("checked", false);
		} else {
			$(this).find('input').prop("checked", true);
			excCheck = true;
		}
		
		// 배타적 선택 기능
		if (excCheck) {
			var inputs = document.querySelectorAll(".option input[type='checkbox']:checked");
			for(let i=0; i<inputs.length; i++){
			
				if (id != inputs[i].id) {
					if(excs.indexOf(inputs[i].id.substring(7, id.length)) != -1) {
						showModal($(this).find('input').data('name'), inputs[i].dataset.name);
						//inputs[i].checked = false;
						//inputs[i].parentElement.parentElement.classList.remove("selected");
						
						$(this).click();
						break;
					}
				}
			}
		}
	
		$('input:checkbox[name="option"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
				sum += $(this).data('price');
				option_name += "<li class='ellipsis_two'>"+$(this).data('name')+"</li>";
			}
		});
		
		if ($(this).hasClass("selected")) {
			$(this).removeClass("selected");
		}
		else {
			$(this).addClass("selected");
		}
		
	
		car.total_option_price = sum;
		car.total_option_name = option_name;
		UpdateSummary();
		
		return false;
	});
	
	$('#commission').on("input", function() {
		var value = $(this).val();
		if (value == "") value = 0;
		if (parseInt(value) < 0)
			value = 0.0;
		else if (parseInt(value) > 3.0)
			value = 3.0;
			
		car.agent_fee_rate = value;
		car.agent_fee_rate_no = value;
		UpdateSummary();
	});

//선납금
	$('#preprice_hi').on("input", function() {
		var value = $(this).val();
		if (value == "") value = 0;
		if( parseInt(value) > parseInt((car.trim_price + car.total_option_price + car.color_price)/10000)){
			alert('선납금은 총차량가를 초과할 수 없습니다.');
			value = parseInt((car.trim_price + car.total_option_price + car.color_price) /10000);
			$(this).val(value);
		}
		car.preprice_hi = value;
		
		
		UpdateSummary(1);
	});
	$('#preprice_my').on("input", function() {
		var value = $(this).val();
		if (value == "") value = 0;
		if( parseInt(value) > parseInt((car.trim_price + car.total_option_price + car.color_price)/10000)){
			alert('선납금은 총차량가를 초과할 수 없습니다.');
			value = parseInt((car.trim_price + car.total_option_price + car.color_price) /10000);
		}
			
		car.preprice_my = value;
		UpdateSummary(2);
	});	
	$('#preprice_ou').on("input", function() {
		var value = $(this).val();
		if (value == "") value = 0;
		if( parseInt(value) > parseInt((car.trim_price + car.total_option_price + car.color_price)/10000)){
			alert('선납금은 총차량가를 초과할 수 없습니다.');
			value = parseInt((car.trim_price + car.total_option_price + car.color_price) /10000);
		}
		car.preprice_ou = value;
		UpdateSummary(3);
	});	
	$('#preprice_no').on("input", function() {
		var value = $(this).val();
		if (value == "") value = 0;
		if( parseInt(value) > parseInt((car.trim_price + car.total_option_price + car.color_price)/10000)){
			alert('선납금은 총차량가를 초과할 수 없습니다.');
			value = parseInt((car.trim_price + car.total_option_price + car.color_price) /10000);
		}
		car.preprice_no = value;
		UpdateSummary(4);
	});	

	$("#phone").on("propertychange change keyup paste input", function() {
		var _val = $(this).val();
		
		var tel_val = autoHypenPhone(_val) ;
		$(this).val(tel_val);
/*		
		if( parseInt(value) > parseInt((car.trim_price + car.total_option_price + car.color_price)/10000)){
			alert('선납금은 총차량가를 초과할 수 없습니다.');
			value = parseInt((car.trim_price + car.total_option_price + car.color_price) /10000);
		}
		car.preprice_no = value;
		UpdateSummary(4);
*/		
	});	

	
////////////////////////////// 왜 안되니 너는.
	$(document).on("click", '.choice', function() {
		alert('test');
		var excCheck = false;
		// child input을 찾아서 상태에 따라 변경해 준다.
		if($(this).find('input').prop("checked") == true) {
			$(this).find('input').prop("checked", false);
		} else {
			$(this).find('input').prop("checked", true);
			excCheck = true;
		}
		$('input:checkbox[name="choice"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
			console.log($(this).data('id'));
				if($(this).data('id') == 'hi'){
				}else if($(this).data('id') == 'my'){
				}else if($(this).data('id') == 'ou'){
				}else if($(this).data('id') == 'no'){
				}
			}
		});
	});


	
	$(document).on("click", '#choice', function() {
		var excCheck = false;
		
		// child input을 찾아서 상태에 따라 변경해 준다.
		if($(this).find('input').prop("checked") == true) {
			$(this).find('input').prop("checked", false);
			car.rentname_hi = $(this).data('name');
		} else {
			$(this).find('input').prop("checked", true);
			excCheck = true;
			car.rentname
		}
		$('input:checkbox[name="choice"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
				console.log($(this).data('id'));
				if($(this).data('id') == 'hi'){
					if (car.trim_price + car.total_option_price + car.color_price > 50000000){
						if(car.deposit_ratio_hi < 0.2){
							alert('차량가격이 5000만원 이상이면 보증금은 20%부터 선택이 가능 합니다');
							$("#depositratio_hi").val("0.2");
							car.deposit_ratio_hi = 0.2;
							UpdateSummary(1);
						}
					}
				}else if($(this).data('id') == 'my'){
				}else if($(this).data('id') == 'ou'){
				}else if($(this).data('id') == 'no'){
//					alert('무심사는 수수료가 적용되지 않습니다.');
				}
			}
		});
	 });
	

	
	var checkHasItems = function() {
		$('.menu-header').each(function(index, item) {
			if($(item).siblings('.content').find('li').length) {
				$(item).find('.index').addClass('hasItems');
			}
			else if($(item).siblings('.content').find('select').length) {
				$(item).find('.index').addClass('hasItems');
			}
			else {
				$(item).find('.index').removeClass('hasItems');
			}
		});
	}
	
	$('.folder').click(function() {

		if ($(this).hasClass('expanded')) {
			$(this).removeClass('expanded');
			$(this).siblings('.content').addClass('hide');
		} else {
			$(this).addClass('expanded');
			$(this).siblings('.content').removeClass('hide');
		}
	});
	
	$(document).on("click", "button[name='authHpno']", function() {
		var telval= document.getElementById("phone");
		var phoneval="";
		var customerval = "";
		if(telval != null){
			phoneval = document.getElementById("phone").value;
			customerval = document.getElementById("customer").value;
			if(!fn_mbtlnumChk(phoneval) ){
				document.getElementsByName('tel')[0].focus();
				return false;
			}
			if(isPhoneAuth){
				alert('문자전송중 입니다. 잠시 기다려 주세요. 문자를 받지 못하셨으면 스팸함을 확인해 주세요.');
				return false;
			}
			isPhoneAuth = true;
			$("#authNumber").show();
		}
//		$(this).val('인증번호확인');
//		addClass('selected');
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
	}); // <------ 현드폰번호 인증
	
	// 견적서 보기
	$('#btn-estimate2').click(function() {
		
		if (car.trim_id == -1) {
			alert("트림을 선택하세요.");
			return;
		}
		var telval= document.getElementById("phone");
		var phoneval="";
		var customerval = "";
		if(telval != null){
			phoneval = document.getElementById("phone").value;
			customerval = document.getElementById("customer").value;
			if(!fn_mbtlnumChk(phoneval) ){
				document.getElementsByName('tel')[0].focus();
				return false;
			}
			if( isPhoneAuth == false){
				alert('핸드폰 번호 인증받기를 눌러 주세요');
				return false;
			}
			if($('.authNumber').val() != car.authNumber){
				alert('전송받은 인증번호를 입력해 주세요.');
				$('.authNumber').focus();
				return false;
			}
		}
		var input = document.getElementById("sel-model");
		input.focus();
		input.value = car.maker + " " + car.model + " " + car.lineup + " " + car.trim;
		
		input = document.getElementById("sel-trim");
		input.focus();
		input.value = car.trim_id;
		
		var optionStr = "";
		var optionList = "";
		var link_url = "";
		$('input:checkbox[name="option"]').each(function() {
			let jsonObj = new Object();;
			jsonObj.id = $(this).data('id');
			jsonObj.name = $(this).data('name'); 
			jsonObj.price = $(this).data('price');
	
			if(this.checked) {//checked 처리된 항목의 값
				jsonObj.state = "on";
				//optionStr.push($(this).data('name'));
				optionStr += "<li class='ellipsis_two'>"+$(this).data('name')+"("+$(this).data('price')+")</li>";
				optionList += $(this).data('id') + " ";
			}
			else
				jsonObj.state = "off";
				
		});
		car.optionlist = optionList;
		var choiceList = 0;
		$('input:checkbox[name="choice"]').each(function() {
			if(this.checked) {//checked 처리된 항목의 값
				choiceList++;
				if( $(this).data('id') == "hi"){
					document.getElementById("sel-rentname_hi").value = "하이렌트";
					if (car.trim_price + car.total_option_price + car.color_price > 50000000){
						if(car.deposit_ratio_hi < 0.2){
							alert('차량가격이 5000만원 이상이면 보증금은 20%부터 선택이 가능 합니다');
							return;
						}
					}					
				}else if( $(this).data('id') == "my"){
					document.getElementById("sel-rentname_my").value = "마이렌트";
				}else if( $(this).data('id') == "ou"){
					document.getElementById("sel-rentname_ou").value = "오너형";
				}else if( $(this).data('id') == "no"){
					document.getElementById("sel-rentname_no").value = "무심사";
				}
			}
		});
		if(choiceList == 0){
			alert('상품견적을 선택해 주세요');
			input = document.getElementById("choice");
			input.focus();
			return ;
		}
		var idOK = false;
		$.ajax({
			type: "POST",
			url: baseUrl+"car/holdingcarlist",
			data: JSON.stringify(car),
			async: false,
			//dataType: "json",          // ajax 통신으로 받는 타입
            contentType: "application/json",  // ajax 통신으로 보내는 타입
			success: function(data) {
				if(data.length > 0){
					link_url = data[0].link_url;
//					idOK =  crayBtn1();
/*					
    				customPopup.confirm("진행하시겠습니까?", function(){
 
        				customPopup.loading("처리중입니다.", function(){});
					});
*/					
//					idOK = confirm('선택하신 모델과 트림은 본사 프로모션차량으로 빠른출고와 납입금 절감(무심사기준)이 가능합니다. 영업담당자에게 문의주세요.\n 취소버튼 누를시, 상세견적서로 이동합니다.');
//					return false;
					idOK = true;
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                alert("실패.")
                return false;
			}
		});

		var form = document.getElementById("sel-form");
		input = document.getElementById("sel-phone");
		input.focus();
		input.value = phoneval;
		input = document.getElementById("sel-customer");
		input.focus();
		input.value = customerval;
		
		input = document.getElementById("sel-kindcnt");
		input.focus();
		input.value = choiceList;
		
		input = document.getElementById("sel-options");
		input.focus();
		input.value = optionStr;
		
		input = document.getElementById("sel-optionlist");
		input.focus();
		input.value = optionList;

		input = document.getElementById("sel-colorprice");
		input.focus();
		input.value = car.color_price;
				
		input = document.getElementById("sel-colorid");
		input.focus();
		input.value = car.color_id;
				
		input = document.getElementById("sel-color");
		input.focus();
		input.value = car.color_name;
				
		input = document.getElementById("sel-period");
		input.focus();
		input.value = car.period;

		input = document.getElementById("sel-distance");
		input.focus();
		input.value = car.distance;

		input = document.getElementById("sel-trimprice");
		input.focus();
		input.value = car.trim_price;
		
		input = document.getElementById("sel-optionprice");
		input.focus();
		input.value = car.total_option_price;
		
		input = document.getElementById("sel-image");
		input.focus();
		input.value = car.image;
		
		input = document.getElementById("sel-deposit");
		input.focus();
		input.value = car.deposit;
		
		input = document.getElementById("sel-depositratio");
		input.focus();
		input.value = car.deposit_ratio;

		input = document.getElementById("sel-rentfee");
		input.focus();
		input.value = car.rentfee;

		input = document.getElementById("sel-acquisition");
		input.focus();
		input.value = car.acquisition;
		
		input = document.getElementById("sel-agent-fee-rate");
		input.focus();
		input.value = car.agent_fee_rate_no;
		
		input = document.getElementById("sel-agent-fee");
		input.focus();
		input.value = car.agent_fee;
		
		input = document.getElementById("sel-etcprice");
		input.focus();
		input.value = parseInt(car.tagsong_price) + parseInt(car.blackbox_price);
		
		input = document.getElementById("sel-tagsong");
		input.focus();
		input.value = car.tagsong;
		
		input = document.getElementById("sel-blackbox");
		input.focus();
		input.value = car.blackbox;
		
		input = document.getElementById("sel-acquisition_hi");
		input.focus();
		input.value = car.acquisition_hi;
		input = document.getElementById("sel-acquisition_my");
		input.focus();
		input.value = car.acquisition_my;
		input = document.getElementById("sel-acquisition_ou");
		input.focus();
		input.value = car.acquisition_ou;
		input = document.getElementById("sel-acquisition_no");
		input.focus();
		input.value = car.acquisition_no;

		input = document.getElementById("sel-jangrate_hi");
		input.focus();
		input.value = car.jangrate_hi;
		input = document.getElementById("sel-jangrate_my");
		input.focus();
		input.value = car.jangrate_my;
		input = document.getElementById("sel-jangrate_ou");
		input.focus();
		input.value = car.jangrate_ou;
		input = document.getElementById("sel-jangrate_no");
		input.focus();
		input.value = car.jangrate_no;

		input = document.getElementById("sel-deposit_hi");
		input.focus();
		input.value = car.deposit_hi;
		input = document.getElementById("sel-deposit_my");
		input.focus();
		input.value = car.deposit_my;
		input = document.getElementById("sel-deposit_ou");
		input.focus();
		input.value = car.deposit_ou;
		input = document.getElementById("sel-deposit_no");
		input.focus();
		input.value = car.deposit_no;
		
		input = document.getElementById("sel-depositratio_hi");
		input.focus();
		input.value = car.deposit_ratio_hi;
		input = document.getElementById("sel-depositratio_my");
		input.focus();
		input.value = car.deposit_ratio_my;
		input = document.getElementById("sel-depositratio_ou");
		input.focus();
		input.value = car.deposit_ratio_ou;
		input = document.getElementById("sel-depositratio_no");
		input.focus();
		input.value = car.deposit_ratio_no;

		input = document.getElementById("sel-period_hi");
		input.focus();
		input.value = car.period_hi;
		input = document.getElementById("sel-period_my");
		input.focus();
		input.value = car.period_my;
		input = document.getElementById("sel-period_ou");
		input.focus();
		input.value = car.period_ou;
		input = document.getElementById("sel-period_no");
		input.focus();
		input.value = car.period_no;

		input = document.getElementById("sel-rentfee_hi");
		input.focus();
		input.value = car.rentfee_hi;
		input = document.getElementById("sel-rentfee_my");
		input.focus();
		input.value = car.rentfee_my;
		input = document.getElementById("sel-rentfee_ou");
		input.focus();
		input.value = car.rentfee_ou;
		input = document.getElementById("sel-rentfee_no");
		input.focus();
		input.value = car.rentfee_no;

		input = document.getElementById("sel-preprice_hi");
		input.focus();
		input.value = car.preprice_hi;
		input = document.getElementById("sel-preprice_my");
		input.focus();
		input.value = car.preprice_my;
		input = document.getElementById("sel-preprice_ou");
		input.focus();
		input.value = car.preprice_ou;
		input = document.getElementById("sel-preprice_no");
		input.focus();
		input.value = car.preprice_no;		

		input = document.getElementById("sel-agentfee_hi");
		input.focus();
		input.value = car.agentfee_hi;
		input = document.getElementById("sel-agentfee_my");
		input.focus();
		input.value = car.agentfee_my;
		input = document.getElementById("sel-agentfee_ou");
		input.focus();
		input.value = car.agentfee_ou;

		input = document.getElementById("sel-cal_price");
		input.focus();
		input.value = car.cal_price;


		if(idOK) {
		 	var btnValue=true;
			dialog('',
			    function() {	//프로모션 가기
			    	if(link_url.length > 0)
			    	form.action=link_url;
			    	form.submit();
//			    		location.href=link_url;
			        return false;
			    },
			    function() {
			//초기화
					$('input:checkbox[name="choice"]').each(function() {
						this.checked = false;
					});
					if(car.preprice_hi > 0)	$('#preprice_hi').val("");
					if(car.preprice_my > 0)	$('#preprice_my').val("");
					if(car.preprice_no > 0)	$('#preprice_no').val("");
					if(car.phone != "") $("#phone").val("");
//					if(car.customer != "")	$("#customer").val("");
					if(car.agent_fee_rate_no > 0) $('#commission').val("");
		    		initValue();
			       form.submit();
			    }
			);		 	
		}else{
	//초기화
			$('input:checkbox[name="choice"]').each(function() {
				this.checked = false;
			});
			if(car.preprice_hi > 0)	$('#preprice_hi').val("");
			if(car.preprice_my > 0)	$('#preprice_my').val("");
			if(car.preprice_no > 0)	$('#preprice_no').val("");
			if(car.phone != "") $("#phone").val("");
//			if(car.customer != "")	$("#customer").val("");
			if(car.agent_fee_rate_no > 0) $('#commission').val("");
		
			initValue();
			form.submit();
		}
		return false;
	});
	
	$(window).scroll(function(){
		var navEl = document.querySelector(".pc-menu");
		if (navEl == null)
			navEl = document.querySelector(".header-box");
//		if (navEl.getBoundingClientRect().top <= 0) {
//			navEl.classList.add("top-sticky");
//		}
//		else {
//			navEl.classList.remove("top-sticky");
//		}
	});

});



// Channel Plugin Scripts
(function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
  

var user;
ChannelIO('boot', 
	{"pluginKey": "de8e28c2-b3e3-4dd8-9301-051a4dca86ef"}, 
    function onBoot(error, user) {
		if (error) {
			console.error(error);
		} else {
			window.user = user;
			//console.log('boot success', user)
		}
	}
);


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
/*
var cellPhone = document.getElementById('phone');
cellPhone.onkeyup = function(event){
	event = event || window.event;
	var _val = this.value.trim();
	_val = autoHypenPhone(_val) ;
}
*/
/**
 *  alert, confirm 대용 팝업 메소드 정의 <br/>
 *  timer : 애니메이션 동작 속도 <br/>
 *  alert : 경고창 <br/>
 *  confirm : 확인창 <br/>
 *  open : 팝업 열기 <br/>
 *  close : 팝업 닫기 <br/>
 */ 
var action_popup = {
    timer: 500,
    confirm: function (txt, callback) {
        if (txt == null || txt.trim() == "") {
            console.warn("confirm message is empty.");
            return;
        } else if (callback == null || typeof callback != 'function') {
            console.warn("callback is null or not function.");
            return;
        } else {
            $(".type-confirm .btn_ok").on("click", function () {
                $(this).unbind("click");
                callback(true);
                action_popup.close(this);
            });
            this.open("type-confirm", txt);
        }
    },

    alert: function (txt) {
        if (txt == null || txt.trim() == "") {
            console.warn("confirm message is empty.");
            return;
        } else {
            this.open("type-alert", txt);
        }
    },

    open: function (type, txt) {
        var popup = $("." + type);
        popup.find(".menu_msg").text(txt);
        $("body").append("<div class='dimLayer'></div>");
        $(".dimLayer").css('height', $(document).height()).attr("target", type);
        popup.fadeIn(this.timer);
    },

    close: function (target) {
        var modal = $(target).closest(".modal-section");
        var dimLayer;
        if (modal.hasClass("type-confirm")) {
            dimLayer = $(".dimLayer[target=type-confirm]");
            $(".type-confirm .btn_ok").unbind("click");
        } else if (modal.hasClass("type-alert")) {
            dimLayer = $(".dimLayer[target=type-alert]")
        } else {
            console.warn("close unknown target.")
            return;
        }
        modal.fadeOut(this.timer);
        setTimeout(function () {
            dimLayer != null ? dimLayer.remove() : "";
        }, this.timer);
    }
}
function initValue(){
	car.maker = "";
	car.model = "";
	car.lineup = "";
	car.trim = "";
	car.total_option_name = "";
	car.model_id = -1;
	car.trim_id = -1;
	car.trim_price = 0;
	car.total_option_price = 0;
	car.deposit_ratio = 0.5;
	car.deposit= 0;
	car.period = 48;

	car.deposit_ratio_hi = 0.1;
	car.period_hi = 48;
	car.deposit_ratio_my = 0.5;
	car.period_my = 48;
	car.deposit_ratio_ou = 0.7;
	car.period_ou = 48;
	car.deposit_ratio_no = 0.1;
	car.period_no = 48;
	car.rentfee_hi = 0;
	car.rentfee_my = 0;
	car.rentfee_ou = 0;
	car.rentfee_no = 0;
	car.rentnames = "";
	car.deposit_hi = 0;
	car.deposit_my = 0;
	car.deposit_ou = 0;
	car.deposit_no = 0;
	car.acquisition_hi= 0;
	car.acquisition_my= 0;
	car.acquisition_ou= 0;
	car.acquisition_no= 0;
	car.preprice_hi =0;
	car.preprice_my =0;
	car.preprice_ou =0;
	car.preprice_no =0;
	car.prepayment=0
	car.agentfee_hi=0
	car.agentfee_my=0;
	car.agentfee_ou=0;

	car.distance = 30000
	car.image = "";
	car.options = "";
	car.color_id= 0;
	car.color_name= "";
	car.color_price= "0";
	car.rentfee= 0;
	car.acquisition= 0;
	car.agent_fee_rate= 0;
	car.agent_fee_rate_no=1;
	car.agent_fee= 0;
	car.tagsong = "";
	car.tagsong_price = 0;
//	car.blackbox = ""
//	car.blackbox_price= 0;
	car.optionlist="";
	car.cal_price=0;
	car.phone="";
	car.customer="";
}
