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

<c:forEach var="car" items="${cars}" varStatus="status" begin="0" end="0">
	<div>
	<img src='${RPATH}/images/car/${car.image }'></img>
	<span>${car.model_id }</span>
	</div>

</c:forEach>

<div id="trimlist">
</div>

<div id="colorlist">
</div>

<button>추가</button>
<table class="modellist">
<c:forEach var="car" items="${cars}" varStatus="status">
	<tr onclick="javascript:getTrimList('${car.model_id }')">
		<td>
			${car.maker}
		</td>
		<td>
			${car.model_id }
		</td>
		<td>
			${car.model_name }
		</td>
		<td>
			${car.lineup }
		</td>
		<td>
			${car.trim_id }
		</td>
		<td>
			${car.car_type }
		</td>
		<td>
			${car.tax_type }
		</td>
		<td>
			${car.tax_rate }
		</td>
						
		<td>
			${car.janga24 }
		</td>
		<td>
			${car.janga36 }
		</td>
		<td>
			${car.janga48 }
		</td>		
		<td>
			${car.cal_rate_10_24 }
		</td>
		<td>
			${car.cal_rate_10_36 }
		</td>
		<td>
			${car.cal_rate_10_48 }
		</td>		
		<td>
			${car.cal_rate_50_24 }
		</td>
		<td>
			${car.cal_rate_50_36 }
		</td>
		<td>
			${car.cal_rate_50_48 }
		</td>
		<td>
			${car.maintain_fee_10_24 }
		</td>
		<td>
			${car.maintain_fee_10_36 }
		</td>
		<td>
			${car.maintain_fee_10_48 }
		</td>		
		<td>
			${car.maintain_fee_50_24 }
		</td>
		<td>
			${car.maintain_fee_50_36 }
		</td>
		<td>
			${car.maintain_fee_50_48 }
		</td>

		<td>
			<button class="btn-save" data-maker='${car.maker}' data-name='${car.model_name }'>저장</button>
		
		</td>
	</tr>
</c:forEach>
</table>


<h1>Color List</h1>
<table>
<c:forEach var="bc" items="${basecolors }" varStatus="status">
	<tr>
		<td>
			${bc.idcolor }
		</td>
		<td>
			${bc.color_name }
		</td>
		<td style="background-color:${bc.color_value }">
			${bc.color_value }
		</td>
		<td>
			${bc.color_code }
		</td>

	</tr>
</c:forEach>
</table>

<script>

var goOption = function(trim_id) {
	console.log(trim_id);
	
	var newForm = document.createElement('form'); // set attribute (form) 
	newForm.name = 'newForm'; 
	newForm.method = 'post'; 
	newForm.action = '${CPATH}/admin/optionlist'; 
	newForm.target = '_blank';

	var input1 = document.createElement('input'); 
	// set attribute (input) 
	input1.setAttribute("type", "hidden"); 
	input1.setAttribute("name", "trim_id"); 
	input1.setAttribute("value", trim_id); 

	// append input (to form) 
	newForm.appendChild(input1); 

	// append form (to body) 
	document.body.appendChild(newForm); 
	// submit form 
	newForm.submit();
	
}

var getColorList = function(model_id) {
	var xhr = new XMLHttpRequest();
 	var data = {};
 	data.model_id = model_id;

	xhr.onreadystatechange = function(e) {
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		
		if (req.readyState == XMLHttpRequest.DONE ) {
			
			if (req.status == 200 ) {
				
				var colorStr = "<table>";
				var data = JSON.parse(req.responseText);
				console.log(req.responseText);

				for(var i=0; i<data.length; i++) {

					colorStr += "<tr>"
						+ "<td>" + data[i].color_id + "</td>"
						+ "<td>" + data[i].color_name + "</td>"
						+ "<td>" + data[i].price + "</td>"
						+ "</tr>";


				}
				colorStr += "</table>";
				//console.log(colorStr);
				document.getElementById("colorlist").innerHTML = colorStr;
			}
			else {
				console.log(xhr.responseText);
			}
		}

	}
	
 	xhr.open("POST", "${CPATH}/car/colorlist", false);
	xhr.setRequestHeader("content-type", "application/json");
	xhr.send(JSON.stringify(data));
	
	return false;
}

var getTrimList = function(model_id) {

	var xhr = new XMLHttpRequest();
 	var data = {};
 	data.model_id = model_id;

	xhr.onreadystatechange = function(e) {
		// XMLHttpRequest를 이벤트 파라미터에서 취득
		let req = e.target;
		
		if (req.readyState == XMLHttpRequest.DONE ) {
			
			if (req.status == 200 ) {
				
				var trimStr = "<table>";
				var data = JSON.parse(req.responseText);

				for(var i=0; i<data.length; i++) {
					var item = data[i];
					trimStr += "<tr onclick='javascript:goOption(" + data[i].trim_id + ")'>"
							+ "<td>" + data[i].trim_name + "</td>"
							+ "</tr>";

				}
				trimStr += "</table>";
				document.getElementById("trimlist").innerHTML = trimStr;
				
				getColorList(model_id);
				console.log(trimStr);
				console.log(model_id);
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



</script>