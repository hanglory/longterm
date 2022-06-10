<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<form style="display:none;" id="sel-form" method="post" name="selItem"
				<c:if test="${not empty userId}" > 
				action= "${CPATH}/member/${userId}/estimate_tot"
				</c:if>
				<c:if test="${empty userId}" > 
				action= "${CPATH}/estimate_tot"
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
		

		<input type="text" id="sel-acquisition_hi" name="acquisition_hi" value=""/>
		<input type="text" id="sel-acquisition_my" name="acquisition_my" value=""/>
		<input type="text" id="sel-acquisition_ou" name="acquisition_ou" value=""/>
		<input type="text" id="sel-acquisition_no" name="acquisition_no" value=""/>
		<input type="text" id="sel-deposit_hi" name="deposit_hi" value=""/>
		<input type="text" id="sel-deposit_my" name="deposit_my" value=""/>
		<input type="text" id="sel-deposit_ou" name="deposit_ou" value=""/>
		<input type="text" id="sel-deposit_no" name="deposit_no" value=""/>
		<input type="text" id="sel-depositratio_hi" name="depositratio_hi" value=""/>
		<input type="text" id="sel-depositratio_my" name="depositratio_my" value=""/>
		<input type="text" id="sel-depositratio_ou" name="depositratio_ou" value=""/>
		<input type="text" id="sel-depositratio_no" name="depositratio_no" value=""/>
		<input type="text" id="sel-period_hi" name="period_hi" value=""/>
		<input type="text" id="sel-period_my" name="period_my" value=""/>
		<input type="text" id="sel-period_ou" name="period_ou" value=""/>
		<input type="text" id="sel-period_no" name="period_no" value=""/>
		<input type="text" id="sel-rentfee_hi" name="rentfee_hi" value=""/>
		<input type="text" id="sel-rentfee_my" name="rentfee_my" value=""/>
		<input type="text" id="sel-rentfee_ou" name="rentfee_ou" value=""/>
		<input type="text" id="sel-rentfee_no" name="rentfee_no" value=""/>
		<input type="text" id="sel-rentname_hi" name="rentname_hi" value=""/>
		<input type="text" id="sel-rentname_my" name="rentname_my" value=""/>
		<input type="text" id="sel-rentname_ou" name="rentname_ou" value=""/>
		<input type="text" id="sel-rentname_no" name="rentname_no" value=""/>
		<input type="text" id="sel-preprice_hi" name="preprice_hi" value=""/>
		<input type="text" id="sel-preprice_my" name="preprice_my" value=""/>
		<input type="text" id="sel-preprice_ou" name="preprice_ou" value=""/>
		<input type="text" id="sel-preprice_no" name="preprice_no" value=""/>
		<input type="text" id="sel-agentfee_hi" name="agentfee_hi" value=""/>
		<input type="text" id="sel-agentfee_my" name="agentfee_my" value=""/>
		<input type="text" id="sel-agentfee_ou" name="agentfee_ou" value=""/>
		<input type="text" id="sel-kindcnt" name="kindcnt" value=""/>
		<input type="text" id="sel-cal_price" name="cal_price" value=""/>
		<input type="text" id="sel-phone" name="phone" value=""/>
		<input type="text" id="sel-customer" name="customer" value=""/>
		
		
			<input type="submit" value="전송" />
	</form>