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

</script>