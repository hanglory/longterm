<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<style>
.modellist {
	
}

.modellist td {
	border: 1px solid #ddd;
}
</style>

<img id="s-carimage" style="display:block" src="" alt="" />

<select id="s-maker" onchange="javascript:changeMaker()">
	<option />
	<option value="현대">현대</option>
	<option value="기아">기아</option>
	<option value="제네시스">제네시스</option>
	<option value="쉐보레">쉐보레</option>
	<option value="르노삼성">르노삼성</option>
	<option value="쌍용">쌍용</option>
	
</select>


<select id="s-model" onchange="javascript:changeModel()">
</select>


<select id="s-lineup" onchange="javascript:changeLineup()">
</select>

<select id="s-trim" onchange="javascript:changeTrim()">
</select>

<textarea id="s-trim-info" rows='20' style="width:100%"></textarea>


<form action="">
	<input type="text" id="maker" value=""/>
	<input type="text" id="model_name" />
	<input type="text" id="lineup" />
	<input type="text" id="image" />
	<input type="text" id="trim_name" />
	<input type="number" id="displacement" />
	<input type="number" id="price" />
	<input type="number" id="janga24" />
	<input type="number" id="janga36" />
	<input type="number" id="janga48" />
	<input type="tax_rate" id="tax_rate" />
	<input type="number" id="cal_rate_10_24" />
	<input type="number" id="cal_rate_10_36" />
	<input type="number" id="cal_rate_10_48" />
	<input type="number" id="cal_rate_50_24" />
	<input type="number" id="cal_rate_50_36" />
	<input type="number" id="cal_rate_50_48" />
	<input type="number" id="maintain_fee_10_24" />
	<input type="number" id="maintain_fee_10_36" />
	<input type="number" id="maintain_fee_10_48" />
	<input type="number" id="maintain_fee_50_24" />
	<input type="number" id="maintain_fee_50_36" />
	<input type="number" id="maintain_fee_50_48" />

	<select name="" id="fuel">
		<option value="휘발유">휘발유</option>
		<option value="경유">경유</option>
		<option value="LPG">LPG</option>
		<option value="하이브리드">하이브리드</option>
		<option value="전기">전기</option>
	</select>	

	<select name="" id="cartype">
		<option value="승용차">승용차</option>
		<option value="승합차">승합차</option>
		<option value="SUV">SUV</option>
		<option value="경차">경차</option>
	</select>	

	<select name="" id="tax_type">
		<option value="과세">과세</option>
		<option value="면세">면세</option>
	</select>	


</form>

<p>color</p>

<p>option</p>

<table class="modellist">
<c:forEach var="car" items="${cars}" varStatus="status">
	<tr onclick="javascript:goLineup('${car.maker}', '${car.model_name }')">
		<td>
			${car.maker}
		</td>
		<td contenteditable>
			${car.model_ranking }
		</td>
		<td>
			${car.model_name }
		</td>
		<td contenteditable>
			${car.image }
		</td>
		<td>
			<button class="btn-save" data-maker='${car.maker}' data-name='${car.model_name }'>저장</button>
		
		</td>
	</tr>
</c:forEach>
</table>


<script>

var goLineup = function(maker, model) {
	console.log(maker + " " + model);
	
	var newForm = document.createElement('form'); // set attribute (form) 
	newForm.name = 'newForm'; 
	newForm.method = 'post'; 
	newForm.action = '${CPATH}/admin/lineuplist'; 
	newForm.target = '_blank';

	var input1 = document.createElement('input'); 
	var input2 = document.createElement('input'); 
	// set attribute (input) 
	input1.setAttribute("type", "hidden"); 
	input1.setAttribute("name", "maker"); 
	input1.setAttribute("value", maker); 
	input2.setAttribute("type", "hidden"); 
	input2.setAttribute("name", "model_name"); 
	input2.setAttribute("value", model);

	// append input (to form) 
	newForm.appendChild(input1); 
	newForm.appendChild(input2); 
	// append form (to body) 
	document.body.appendChild(newForm); 
	// submit form 
	newForm.submit();
	
}
//document.addEventListener("load", function() {
	var buttons = document.querySelectorAll('.btn-save');
	for(let i=0; i<buttons.length; i++) {
		buttons[i].addEventListener("click", function(e) {
			console.log("click " + i);
			var TR = e.target.parentElement.parentElement;
			
			var image = TR.querySelector("td:nth-child(4)").innerHTML.trim();
			image=image.replace(/(?:\r\n|\r|\n)/g,'');

			console.log(TR.querySelector("td:nth-child(2)").innerHTML.trim());
			updateModelRanking(e.target.dataset.maker, e.target.dataset.name,
					TR.querySelector("td:nth-child(2)").innerHTML.trim(),
					image
					);
		});
	}
//});

/**
 * 모델 순서 (ranking)과 이미지 정보를 업데이트 한다.
 */
var updateModelRanking = function(maker, name, ranking, image) {

	var xhr = new XMLHttpRequest();
	var data = {};
	data.maker = maker;
	data.model_name = name;
	data.model_ranking = ranking;
	data.image = image;
	
	console.log(maker, name, ranking);
	xhr.onreadystatechange = function() {
		if (xhr.readystate == xhr.DONE ) {
			location.reload();
		}
		else {
			console.log(xhr.responseText);
		}
	}
	
	xhr.open("POST", "${CPATH}/car/updatemodelranking");
	xhr.setRequestHeader("content-type", "application/json");
	xhr.send(JSON.stringify(data));
}

var changeMaker = function() {
	var elem = document.getElementById("s-maker");
	var maker = elem.options[elem.selectedIndex].value;
	
	if(maker.length == 0) {
		return false;
	}
	
	console.log(maker);
	
	var xhr = new XMLHttpRequest();
 	var data = {};
 	data.maker = maker;

	xhr.onreadystatechange = function(e) {
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		
		if (req.readyState == XMLHttpRequest.DONE ) {
			
			if (req.status == 200 ) {
				
				var modelStr = "<option />";
				var data = JSON.parse(req.responseText);
				//console.log(req.responseText);
				console.log(data.length);
				for(var i=0; i<data.length; i++) {

					modelStr += ""
						+ "<option value='" + data[i].model_name + "'" 
						+ " data-image='" + data[i].image + "'"
						+ ">"
						+ data[i].model_name
						
						+ "</option>";
				}
				console.log(modelStr);
				document.getElementById("s-model").innerHTML = modelStr;
				document.getElementById("s-lineup").innerHTML = "";
				document.getElementById("s-trim").innerHTML = "";
			}
			else {
				console.log(xhr.responseText);
			}
		}

	}
	
 	xhr.open("POST", "${CPATH}/car/modellist", false);
	xhr.setRequestHeader("content-type", "application/json");
	xhr.send(JSON.stringify(data));
	
	return false;
}

var changeModel = function() {
	var elem = document.getElementById("s-maker");
	var maker = elem.options[elem.selectedIndex].value;
	elem = document.getElementById("s-model");
	var model = elem.options[elem.selectedIndex].value;
	if(model.length == 0) {
		document.getElementById("s-carimage").src = "";
		document.getElementById("s-lineup").innerHTML = "";
		document.getElementById("s-trim").innerHTML = "";
		return false;
	}

	console.log(model);
	
	document.getElementById("s-carimage").src = 
		"${RPATH}/images/car/" + elem.options[elem.selectedIndex].dataset.image;
	
	console.log(maker);
	
	var xhr = new XMLHttpRequest();
 	var data = {};
 	data.maker = maker;
 	data.model = model;

	xhr.onreadystatechange = function(e) {
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		
		if (req.readyState == XMLHttpRequest.DONE ) {
			
			if (req.status == 200 ) {
				
				var modelStr = "<option />";
				var data = JSON.parse(req.responseText);
				console.log(req.responseText);
				//console.log(data.length);
				for(var i=0; i<data.length; i++) {

					modelStr += ""
						+ "<option value='" + data[i].lineup + "' "
						+ " data-model_id='" + data[i].model_id + "'"
						+ ">"
						+ data[i].lineup
						
						+ "</option>";
				}
				console.log(modelStr);
				document.getElementById("s-lineup").innerHTML = modelStr;
				document.getElementById("s-trim").innerHTML = "";
				
			}
			else {
				console.log(xhr.responseText);
			}
		}

	}
	
 	xhr.open("POST", "${CPATH}/car/lineuplist", false);
	xhr.setRequestHeader("content-type", "application/json");
	xhr.send(JSON.stringify(data));
	
	return false;
}

var changeLineup = function() {
	var elem = document.getElementById("s-lineup");
	var model_id = elem.options[elem.selectedIndex].dataset.model_id;
	
	if(model_id === undefined) {
		document.getElementById("s-trim").innerHTML = "";
		return false;
	}

	var xhr = new XMLHttpRequest();
 	var data = {};
 	data.model_id = model_id;

	xhr.onreadystatechange = function(e) {
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		
		if (req.readyState == XMLHttpRequest.DONE ) {
			
			if (req.status == 200 ) {
				
				var trimStr = "<option />";
				var data = JSON.parse(req.responseText);
				console.log(req.responseText);
				console.log(data.length);
				for(var i=0; i<data.length; i++) {

					trimStr += ""
						+ "<option value='" + data[i].trim_name + "'"
						+ " data-trim_id='" + data[i].trim_id + "'"
						+ ">"
						+ data[i].trim_name
						
						+ "</option>";
				}
				console.log(trimStr);
				document.getElementById("s-trim").innerHTML = trimStr;
			}
			else {
				console.log(xhr.responseText);
			}
		}

	}
	
 	xhr.open("POST", "${CPATH}/car/trimlist", false);
	xhr.setRequestHeader("content-type", "application/json");
	xhr.send(JSON.stringify(data));
	
	return false;
}

var changeTrim = function() {
	var elem = document.getElementById("s-trim");
	var trim_id = elem.options[elem.selectedIndex].dataset.trim_id;
	
	if(trim_id === undefined) {
		return false;
	}
	
	console.log(trim_id);
	var xhr = new XMLHttpRequest();
 	var data = {};
 	data.trim_id = trim_id;
 	data.deposit = "0";
 	data.period = "0";

	xhr.onreadystatechange = function(e) {
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		var fields = "";
		if (req.readyState == XMLHttpRequest.DONE ) {
			
			if (req.status == 200 ) {
				
				var trimStr = "<option />";
				var data = JSON.parse(req.responseText);
				console.log(data.price);
				
				// form 요소를 채운다.
				document.getElementById("maker").value = data['maker'];
				document.getElementById("model_name").value = data['model_name'];
				document.getElementById("lineup").value = data['lineup'];
				document.getElementById("image").value = data['image'];
				document.getElementById("trim_name").value = data['trim_name'];
				document.getElementById("displacement").value = data['displacement'];
				document.getElementById("price").value = data['price'];
				document.getElementById("fuel").value = data['fuel'];
				document.getElementById("cartype").value = data['cartype'];
				document.getElementById("tax_type").value = data['tax_type'];
				document.getElementById("janga24").value = data['janga24'];
				document.getElementById("janga36").value = data['janga36'];
				document.getElementById("janga48").value = data['janga48'];
				document.getElementById("tax_rate").value = data['tax_rate'];
				document.getElementById("cal_rate_10_24").value = data['cal_rate_10_24'];
				document.getElementById("cal_rate_10_36").value = data['cal_rate_10_36'];
				document.getElementById("cal_rate_10_48").value = data['cal_rate_10_48'];
				document.getElementById("cal_rate_50_24").value = data['cal_rate_50_24'];
				document.getElementById("cal_rate_50_36").value = data['cal_rate_50_36'];
				document.getElementById("cal_rate_50_48").value = data['cal_rate_50_48'];
				document.getElementById("maintain_fee_10_24").value = data['maintain_fee_10_24'];
				document.getElementById("maintain_fee_10_36").value = data['maintain_fee_10_36'];
				document.getElementById("maintain_fee_10_48").value = data['maintain_fee_10_48'];
				document.getElementById("maintain_fee_50_24").value = data['maintain_fee_50_24'];
				document.getElementById("maintain_fee_50_36").value = data['maintain_fee_50_36'];
				document.getElementById("maintain_fee_50_48").value = data['maintain_fee_50_48'];

				for(key in data)
					fields += key + " " + data[key] + "\n";
				document.getElementById("s-trim-info").innerHTML = fields;
			}
			else {
				console.log(xhr.responseText);
			}
		}

	}
	
 	xhr.open("POST", "${CPATH}/car/trim", false);
	xhr.setRequestHeader("content-type", "application/json");
	//xhr.setRequestHeader("content-type", "application/x-www-form-urlencoded");
	xhr.send(JSON.stringify(data));
	//xhr.send("trim_id="+trim_id);
	return false;
}

</script>