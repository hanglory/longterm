<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<form style="display:none;" id="sel-form" method="post" name="selItem"
				<c:if test="${not empty userId}" > 
				action= "${CPATH}/member/${userId}/estimate"
				</c:if>
				<c:if test="${empty userId}" > 
				action= "${CPATH}/estimate"
				</c:if>
				>
		<input type="text" id="sel-type" name="type" value="M"/>
		<input type="text" id="sel-model" name="model" value=""/>
		<input type="text" id="sel-trim" name="trim_id" value=""/>
		<input type="text" id="sel-options" name="options" value=""/>
		<input type="text" id="sel-optionlist" name="optionlist" value=""/>
		<input type="text" id="sel-color" name="color" value=""/>
		<input type="text" id="sel-colorprice" name="colorprice" value=""/>
		<input type="text" id="sel-colorid" name="colorid" value=""/>
		<input type="text" id="sel-period" name="period" value=""/>
		<input type="text" id="sel-deposit" name="deposit" value=""/>
		<input type="text" id="sel-depositratio" name="depositratio" value=""/>
		<input type="text" id="sel-distance" name="distance" value=""/>
		<input type="text" id="sel-trimprice" name="trimprice" value=""/>
		<input type="text" id="sel-optionprice" name="optionprice" value=""/>
		<input type="text" id="sel-image" name="image" value=""/>
		<input type="text" id="sel-deposit" name="deposit" value=""/>
		<input type="text" id="sel-rentfee" name="rentfee" value=""/>
		<input type="text" id="sel-acquisition" name="acquisition" value=""/>
		<input type="text" id="sel-agent-fee-rate" name="agent_fee_rate" value=""/>
		<input type="text" id="sel-agent-fee" name="agent_fee" value=""/>
		<input type="text" id="sel-etcprice" name="etcprice" value=""/>
		<input type="text" id="sel-tagsong" name="tagsong" value=""/>
		<input type="text" id="sel-blackbox" name="blackbox" value=""/>
		
		<input type="submit" value="전송" />
	</form>