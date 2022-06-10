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

var car = {
	maker : "",
	model : "",
	lineup : "",
	trim : "",
	model_id : -1,
	trim_id : -1,
	trim_price : 0,
	total_option_price : 0,
	deposit_ratio : 0.5,
	deposit: 0,
	period : 48,
	distance : 30000,
	image : "",
	options : "",
	color_id: 0,
	color_name: "",
	color_price: "0",
	rentfee: 0,
	acquisition: 0,
	agent_fee_rate: 0,
	agent_fee: 0,
	tagsong : "",
	tagsong_price : 0,
	blackbox : "",
	blackbox_price: 0,
	prepayment: 0
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
		
var UpdateSummary = function() {

	if (car.trim_id == -1) return;
	updateOptionList();
	
	$("#carname").html(car.maker + " " + car.model + " " +  car.lineup + " " + car.trim);
	$('#car-price').html(Number(car.trim_price).toLocaleString('en'));
	$('#option-price').html(Number(car.total_option_price).toLocaleString('en'));
	$('#period-summary').html(car.period + " 개월");
	$('#distance-summary').html(car.distance / 10000 + "만Km/년");
	$('#price-total').html(Number(car.trim_price + car.total_option_price + car.color_price).toLocaleString('en'));
	$('#agency-fee-rate').html(car.agent_fee_rate + " %");
	
	var color = car.color_name;
	if (car.color_price != 0) color = color + "(+" + Number(car.color_price).toLocaleString('en') + ")";
	$('#color-name').html(color);
	
	$.ajax({
		type: "POST",
		url: baseUrl+"car/rentfee",
		data: JSON.stringify(car),
		//dataType: "json",          // ajax 통신으로 받는 타입
		contentType: "application/json",  // ajax 통신으로 보내는 타입
		success: function(data) {


			car.rentfee = data.rentfee;
			car.deposit = data.deposit;
			car.acquisition = data.acquisition;
			car.agent_fee = data.agent_fee;
			$('#rentfee').html(Number(data.rentfee).toLocaleString('en') + "원");
			$('#deposit-summary').html(car.deposit_ratio * 100 + " %   " + Number(car.deposit).toLocaleString('en'));
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		    alert("실패.")
		}
	});	

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
						//modelStr += "<img src='" + baseUrl + "images/car/" + data[i].image + "' alt=''></img>";
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
	
	$('.period').click(function(e) {
		e.stopPropagation();
		let selStr = $(this).find('input').val();
		car.period = selStr;	

		$(this).find('input').prop("checked", true);
		UpdateSummary();
		
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
	
	$('#depositratio').change(function(e) {
		
		car.deposit_ratio = $("#depositratio option:selected").val();
		console.log(car.deposit_ratio);
		UpdateSummary();
		
		return false;
	});	
		
	$('.distance').click(function() {
		let selStr = $(this).val();
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
			}
		});
		
		if ($(this).hasClass("selected")) {
			$(this).removeClass("selected");
		}
		else {
			$(this).addClass("selected");
		}
		
	
		car.total_option_price = sum;
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
		UpdateSummary();
		
		
	});
	
//	$(document).on("click", '#recalc', function() {
//		 $.ajax({
//			type: "POST",
//			url: baseUrl+"/car/rentfee",
//			data: JSON.stringify(car),
//			//dataType: "json",          // ajax 통신으로 받는 타입
//        	contentType: "application/json",  // ajax 통신으로 보내는 타입
//			success: function(data) {
//				
//				$('#rentfee').html(Number(data.rentfee).toLocaleString('en') + "원");
//			},
//			error: function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
//	            alert("실패.")
//			}
//		});	
//	 });
	

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
	
	
	// 견적서 보기
	$('#btn-estimate').click(function() {
		var form = document.getElementById("sel-form");
		
		if (car.trim_id == -1) {
			alert("트림을 선택하세요.");
			return;
		}
		
		var input = document.getElementById("sel-model");
		input.focus();
		input.value = car.maker + " " + car.model + " " + car.lineup + " " + car.trim;
		
		input = document.getElementById("sel-trim");
		input.focus();
		input.value = car.trim_id;
		
		var optionStr = "";
		var optionList = "";
		$('input:checkbox[name="option"]').each(function() {
			let jsonObj = new Object();;
			jsonObj.id = $(this).data('id');
			jsonObj.name = $(this).data('name'); 
			jsonObj.price = $(this).data('price');
	
			if(this.checked) {//checked 처리된 항목의 값
				jsonObj.state = "on";
				//optionStr.push($(this).data('name'));
				optionStr += $(this).data('name') + "<br>";
				optionList += $(this).data('id') + " ";
			}
			else
				jsonObj.state = "off";
				
		});
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
		input.value = car.agent_fee_rate;
		
		input = document.getElementById("sel-agent-fee");
		input.focus();
		input.value = car.agent_fee;
		
		input = document.getElementById("sel-etcprice");
		input.focus();
		input.value = car.tagsong_price + car.blackbox_price;
		
		input = document.getElementById("sel-tagsong");
		input.focus();
		input.value = car.tagsong;
		
		input = document.getElementById("sel-blackbox");
		input.focus();
		input.value = car.blackbox;
		
		form.submit();
		
		// 새창 띄우기
		//var strWindowFeatures = "menubar=no,location=no,resizable=yes,scrollbars=yes,status=yes,width=1280, height=800";
		//var estimateWin = window.open(baseUrl + '/estimate/estimate', '견적서', strWindowFeatures);
	});
/*	
	$(window).scroll(function(){
		var navEl = document.querySelector(".pc-menu");
		if (navEl == null)
			navEl = document.querySelector(".header-box");
		if (navEl.getBoundingClientRect().top <= 0) {
			navEl.classList.add("top-sticky");
		}
		else {
			navEl.classList.remove("top-sticky");
		}
	});
*/
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

  
