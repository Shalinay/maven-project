<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<h1 class="page-heading">Secure Area Access Request</h1>
<div>

	<s:actionerror style="color:red;" />

</div>

<script type="text/javascript" charset="utf-8" language="javascript">

</script>
<style>
.claro .dijitCalendarCurrentDate {
	text-decoration: underline;
	font-weight: bold;
	border-collapse: separate;
}
/* .linkalign
{
  float:right;
} */
</style>

<script type="text/javascript" charset="utf-8" language="javascript">
  var requestorDet = <%=request.getAttribute("requestorDetails")%>;
	function AJAXHttpRequest() {
		var httpRequest;
		if (window.XMLHttpRequest) {
			httpRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return httpRequest; 
	}
		 	
	function numbercheck()
	{
		var casBadgeNum = document.getElementById("casBadgeNum").value;
		if(isNaN(casBadgeNum))
		{
			alert("Enter only numbers for Access Card ID");
			document.getElementById('casBadgeNum').value='';
			return false;
	}
	}
	
	function grantFun(){
 	    var nonphotoGrant = '<s:property value="artControls.badgeNumEnabled" />';
 	    var flg = true;
	    if(nonphotoGrant ==="true"){
	    var casBadgeNum = document.getElementById("casBadgeNum").value;
	    if(casBadgeNum ==="" || casBadgeNum ==null){
	    alert("Access card number can not empty");
	    flg=false;
	    return false;
	    } else if (casBadgeNum.length > 15) {
	    alert("Access card length can not be more then 15 digit ");
	    flg=false;
	    return false;
	    }
	    }
	    if(flg){
		 document.commonform.action = "grantRequest.action";
		 document.commonform.submit();
		 }
		 }
		 
   function revokeFun(){
		 document.commonform.action = "revokeRequest.action";
		 document.commonform.submit();
		 }
  
	function approveButtonFun(){
	 
		var isHostManager = document.getElementById("isHostManager").value;
		var flag = true;
		var a = document.getElementById("eroEditableByHost").value;
		if(isHostManager === "TRUE" && eroEditableByHost){
			var purposetext= document.getElementById("purposetext").value;
			var eroIsSourceTechProvider= document.getElementById("eroIsSourceTechProvider").value;
			var srccodeselectdescinpid= document.getElementById("srcTechSelectionRemarks").value;
			if(document.getElementById("sourcecodedescription") != null)
			var sourcecodedescription= document.getElementById("sourcecodedescription").value;
			
			if(purposetext == ''){
				alert("Please Enter Ero purpose");
				flag = false;
			} else if(eroIsSourceTechProvider == ''){
				alert ("Please select Sourcecode Technology being provided");
				flag = false;
			} else if(srccodeselectdescinpid == ''){
				alert("Please Enter the basis of selection of Source code/Technology");
				flag = false;
			}else if(eroIsSourceTechProvider == 'Y' || eroIsSourceTechProvider == 'M'){
				if(sourcecodedescription == ''){
					alert("Please Enter description for Source code/Technology");
					flag = false;
				}
			}else if(eroIsSourceTechProvider == 'N'){
				document.getElementById("sourcecodedescription").value = "";
			}
		}
		if(flag){ 
	     	var comment= document.getElementById("approvalComment").value;
	     	if(comment ==="" || comment ==null){
	     		alert("Please fill the approval comment before approving");
	     		flag = false;
	     	}else{
				document.commonform.action = "approverRequest.action";
		 		document.commonform.submit(); 
		 		}
			}
			return flag; 
		 }
		 
    function rejectButtonFun(){
		 var comment= document.getElementById("approvalComment").value;
	     if(comment ==="" || comment ==null){
	     alert("Please fill the reject comment before rejecting");
	     return false;
	     }else {
		 document.commonform.action = "rejectRequest.action";
		 document.commonform.submit();
		 }	 
		 }
	function cancelButtonFun(){
	    var comment= document.getElementById("approvalComment").value;
	     if(comment ==="" || comment ==null){
	     alert("Please fill the cancel comment before canceling");
	     return false;
	     }
	    else{
		 document.commonform.action = "cancelRequest.action";
		 document.commonform.submit();
		 }
		 }
    function deactiveButtonFun(){	   
	     var comment= document.getElementById("approvalComment").value;
	     if(comment ==="" || comment ==null){
	     alert("Please fill the comment before deactivating");
	     return false;
	     }else {
		 document.commonform.action = "deactivateRequest.action";
		 document.commonform.submit();
		 }	
		 }
	function renewButtonFun(){
		
	     var comment= document.getElementById("approvalComment").value;
	     var buChng= document.getElementById("buChange").value;
	     if(comment ==="" || comment ==null){
	     alert("Please fill the renew comment before renewing");
	     return false;}
	     if(buChng){
	    	 alert("Follow up with Host,ERO manager and SAM for access (based on BU of profile in the request)");
	     }
		 document.commonform.action = "renewSubmit.action";
		 document.commonform.submit();
		 return true;
	     }
		 
	function reqValidate(){
		 var comment= document.getElementById("approvalComment").value;
	     if(comment ==="" || comment ==null){
	     alert("Please fill the validation comment before validating");
	     return false;}
	     var selectedAllRequestId = "<s:property value="requestId" />";
	     document.commonform.selectedAllRequestId.value = selectedAllRequestId;
		 document.commonform.action = "validateIndividualRequest.action";
		 document.commonform.submit();
		 return true;
	}
	
	
	function updateButtonFun()
	{ 	
		document.getElementById("mode").value = "edit";
		return true;	
	}
	 
	//for Date Validation	 
	var selectedStartDateConstraint = function(changedDate) {
		var val1 = document.getElementById("startDate").value;
		if (val1 != '') {
			var newStartFromDate = parseStringToDate(val1);
			minDateConstraint("endDate", newStartFromDate);
		}
	};

	var selectedEndDateConstraint = function(changedDate) {
		var val2 = document.getElementById("endDate").value;
		if (val2 != '') {
			var newStartToDate = parseStringToDate(val2);
			maxDateConstraint("startDate", newStartToDate);
		}
	};

	attachOnChangeEvtToDateTxtBox("startDate", selectedStartDateConstraint);
	attachOnChangeEvtToDateTxtBox("endDate", selectedEndDateConstraint); 
	 
	
	function limitText(limitField,countdown,limitNum){
		
		 if (limitField.value.length > limitNum) {
	            limitField.value = limitField.value.substring(0, limitNum);
	          } else {
	        	  countdown.value = limitNum - limitField.value.length;
	          }
     }
	</script>


<s:form name="commonform" id="xyz" theme="simple" method="post"
	validate="true" enctype="multipart/form-data"
	cssStyle=" margin-left:4px;">
	<s:hidden name="pscaListId" id="pscaListId" />
	<s:hidden name="accessForEmp" id="AccessFor" />
	<s:hidden name="pscaId" id="pscaId" />
	<s:hidden name="entranceType" id="entranceType" />
	<s:hidden name="location" id="location" />
	<s:hidden name="campusId" id="campusId" />
	<s:hidden name="buildingId" id="buildingId" />
	<s:hidden name="floorId" id="floorId" />
	<s:hidden name="wingsId" id="wingsId" />
	<s:hidden name="cnumId" />
	<s:hidden name="notesId" />
	<s:hidden name="ownerDeptCd" />
	<s:hidden name="reqBusiUnit" />
	<s:hidden name="eroIsSourceTechProvider" id="eroIsSourceTechProvider"></s:hidden>
	<s:hidden name="ownerCnumId" id="ownerCnumId" />
	<s:hidden name="approveManagerCnum" id="approveManagerCnum" />
	<s:hidden name="requestedForId" id="requestedForId" />
	<s:hidden name="requestId" id="requestId" />
	<s:hidden name="requestName" id="requestName"></s:hidden>
	<s:hidden name="requestedEmpTypeofAccess" />
	<s:hidden name="requestedBynotesId" />
	<s:hidden name="renewDateEnabled" />
	<s:hidden name="extendedEndDate" />
	<s:hidden name="renewAllowed" />
	<s:hidden name="workflowStatus" />
	<s:hidden name="requestStatus" />
	<s:hidden name="res" />
	<s:hidden name="editAllowed" id="editAllowed" />
	<s:hidden name="mode" id="mode" />
	<s:hidden name="editBtnEnabled" id="editBtnEnabled" />
	<s:hidden name="approveRejectBtnEnabled" id="approveRejectBtnEnabled" />
	<s:hidden name="eroId" id="eroId" />
	<s:hidden name="selectedAllRequestId" id="selectedAllRequestId" />
	<s:hidden name="isHostManager" id="isHostManager" />
	<s:hidden name="eroEditableByHost" id="eroEditableByHost"></s:hidden>
	<s:hidden name="buChange" id="buChange" />
	<s:hidden name="labBu" id="labBu" />
	<s:hidden name="hostManager" id="hostManager" />

	<table border="0" width="100%" style="height: 50px;" id="data_table"
		class="ibm-results-table">
		<tr></tr>
		<tr>
			<td width="9%"><b><FONT COLOR="#ab1a86"><label
						for="_reqAccessFor">Access For :</label></FONT></b></td>
			<td width="22%"><b><FONT COLOR="#ab1a86"><s:property
							value="accessForValue" /> </FONT></b></td>
			<td width="10%"><b><FONT COLOR="#ab1a86"><label
						for="_reqEmpPSCAName"> Secure Area Name :</label></FONT></b></td>
			<td width="25%" style="padding-left: 10px;"><b><FONT
					COLOR="#ab1a86"><s:property value="pscaName" /> </FONT></b></td>
		</tr>
		<tr>
			<th scope="row"></th>
		</tr>
	</table>
	<table border="0" width="100%" style="height: 50px;" id="data_table"
		class="ibm-results-table">
		<tr>
			<td width="14%"><b><label for="_requestName">Request
						ID :</label></b></td>
			<td width="20%"><s:property value="requestName" /></td>
			<td width="14%"><b><label for="_requestStatus">Request
						Status :</label></b></td>
			<td width="20%"><s:property value="requestStatus" /></td>
			<td width="12%"><b><label for="_workFlowStatus">WorkFlow
						Status :</label></b></td>
			<td width="25%" style="padding-left: 5px;"><s:property
					value="workflowStatus" /></td>

		</tr>
		<tr>
			<th scope="row"></th>
		</tr>
	</table>


	<table border="0" width="100%" style="height: 50px;" id="data_table"
		class="ibm-results-table">
		<tr id="startandEnddate">
			<s:if test='entranceType == "B"'>

				<td id="typeofAccess" width="10%"><b><label
						for="type_ofAccess">Type of Access :</label></b></td>
				<td width="14%" style="padding-left: 5px;"><s:property
						value="requestedEmpTypeofAccess" /></td>
			</s:if>
			<td style="padding-top: 5px;" width="14%"><b><label
					for="accessStartDate"><s:text name="Start Date " />:&nbsp;</label></b></td>
			<td style="padding-top: 5px;" width="20%"><s:if
					test="artControls.startEndDatesEnabled">
					<s:textfield id="startDate" name="startDate"
						cssClass="ibm-date-picker" />
					<label for="startDate"><span
						class="ibm-access ibm-date-format">dd-MMM-yyyy</span></label>
				</s:if> <s:else>
					<s:property value="startDate" />
				</s:else></td>
			<td style="padding-top: 5px;" width="14%"><b><label
					for="accessEndtDate"><s:text name="End Date " />:&nbsp; </label></b></td>
			<td style="padding-top: 5px;"><s:if
					test="artControls.startEndDatesEnabled">
					<s:textfield id="endDate" name="endDate" cssClass="ibm-date-picker" />
					<label for="endDate"><span
						class="ibm-access ibm-date-format">dd-MMM-yyyy</span></label>
					<br>
				</s:if> <s:else>
					<s:property value="endDate" />
				</s:else></td>
		</tr>

		<tr>
			<th scope="row"></th>
		</tr>
		<tr>
			<s:if test='entranceType == "B"'>

				<td id="justification" width="14%"><b><label
						for="justification"> Justification :</label></b></td>
				<td width="20%" style="padding-left: 5px;"><s:property
						value="justificationType" /></td>
			</s:if>
			<td width="14%"><b> <label for="_remarks">Remarks :</label></b></td>
			<td width="252" colspan="3"><label><s:property
						value="remarks" /></label></td>

		</tr>
		<tr>
			<th scope="row"></th>
		</tr>
		<s:if test="artControls.renewDateEnabled">
			<tr>
				<td id="extendeddaterow" width="14%"></td>
				<td width="25%"></td>

				<td width="14%"><b><label for="_remarks">End Date
							Extend :</label></b></td>
				<td width="25%" colspan="3"><s:textfield
						id="extendedEndDateRenew" name="extendedEndDateRenew"
						cssClass="ibm-date-picker" /> <label for="extendedEndDateRenew"><span
						class="ibm-access ibm-date-format">dd-MMM-yyyy</span></label></td>
			</tr>

		</s:if>

		<tr>
			<th scope="row"></th>
		</tr>
		<tr>
			<s:if test="artControls.approveCommentTextBoxEnabled">
				<td width="14%"><label><s:property
							value="artControls.commentsTextBoxLabel" /><span
						class="ibm-required">*</span></label></td>
				<td width="252" colspan="3"><s:textarea name="approvalComment"
						id="approvalComment" cols="80" rows="2"
						onkeyup="return limitText(approvalComment,countdown,1000);"
						onkeydown="return limitText(approvalComment,countdown,1000);"
						maxlength="1000"></s:textarea> <input readonly type="text"
					name="countdown" size="2" value="1000"> chars left</td>
			</s:if>
		</tr>
		<s:if
			test="%{requestedEmpTypeofAccess=='Temporary 7 Days' || requestedEmpTypeofAccess=='Temporary'}">
			<tr>
				<td id="disclaimer" colspan="4"><label>"Please
						note-'This temporary access is for performing NON BILLABLE
						ACTIVITY only, performing any billable activity would be
						considered as a violation" </label> <br> <br></td>
			</tr>
		</s:if>

	</table>
	<s:hidden name="tabSelected" id="tabSelected" />


	<div class="ibm-col-1">
		<div class="ibm-columns ibm-graphic-tabs">
			<div class="ibm-tab-section">
				<h2 class="ibm-access">Access Request Tab navigation</h2>
				<ul class="ibm-tabs" id="requestTabs">
					<li onclick="javascript:toggleTabSelected(this);"
						class="ibm-active"><a href="javascript:displayTab(1);">Requestor
							/Owner Details</a></li>
					<li onclick="javascript:toggleTabSelected(this);"><a
						href="javascript:displayTab(2);">Secure Area Details</a></li>

					<s:if test="%{(eroEnabled != 0)}">
						<li onclick="javascript:toggleTabSelected(this);"><a
							href="javascript:displayTab(3);">ERO Details</a></li>
					</s:if>
					<li onclick="javascript:toggleTabSelected(this);"><a
						href="javascript:displayTab(4);">Work Flow</a></li>
					<li onclick="javascript:toggleTabSelected(this);"><a
						href="javascript:displayTab(5);">Audit Trail</a></li>
				</ul>
			</div>

			<%-- TAB ONE --%>
			<div id="requestedForTAB" title="Requestor / Owner Details"
				aria-label="Requested For">

				<div id="firstrow">
					<table width="100%" border="0" class="ibm-results-table">
						<tr>
							<s:if test='requestedForId == "S"'>
								<td width="15%"><label>Request Raised For :</label></td>
								<td width="18%"><s:property value="requestedFor" /></td>
								<td width="12%">
								<td width="15%"></td>
							</s:if>
							<s:if test='requestedForId == "O"'>
								<td width="15%"><label>Request Raised For:</label></td>
								<td width="18%"><s:property value="requestedFor" /></td>
								<td width="12%"><label>Request Raised By :</label></td>
								<s:hidden id="requestedBynotesId" name="requestedBynotesId"></s:hidden>
								<td width="15%"><s:property value="requestedBynotesId" /></td>
							</s:if>
							<s:if test='requestedForId == "B"'>

								<td width="13%"><label>Request Raised For :</label></td>
								<td width="11%"><s:property value="requestedFor" /></td>
								<td width="5%"></td>
								<td width="11%"><label>Request Raised By :</label></td>
								<s:hidden id="requestedBynotesId" name="requestedBynotesId"></s:hidden>
								<td width="13%"><s:property value="requestedBynotesId" /></td>
							</s:if>
						</tr>
						<tr>
							<th scope="row"></th>
						</tr>
					</table>
				</div>

				<s:if test='requestedForId != "B"'>
					<div id="Secondrow">
						<table width="100%" border="0" class="ibm-results-table">
							<tr id="empCnumAndNotes">

								<td id=empCumLabel width="25%"><label for="_ownerCnumId">Employee
										CNUM ID :</label></td>
								<td id=empCnumText width="22%"><s:property value="cnumId" />
								</td>
								<td id="empNotesLabel" width="20%"><label
									for="_ownerNotesId">Notes ID / Name :</label></td>
								<td id="empNotesText"><s:property value="notesId" /></td>
							</tr>
							<tr>
								<th scope="row"></th>
							</tr>
							<tr id="deptAndPemId">

								<td id="deptLabel" width="25%"><label for="_ownerDeptCd">Department
										Code :</label></td>
								<td id="deptText" width="30 %"><s:property
										value="ownerDeptCd" /></td>

								<td id="empPmnLabel" width="20%"><label
									for="_reqManagerNotesId">People Manger Notes ID :</label></td>
								<td id="empPmnText"><s:property value="ownerMgrNotesId" /></td>

							</tr>

							<tr>
								<th scope="row" colspan="4"></th>
							</tr>
							<tr id="busiunitAndApproverNotesId">
								<td id="businessLabel" width="25%" nowrap="nowrap"><label
									for="_ownerBusiUnit">Business Unit :</label></td>
								<td id="businessText" width="30%"><s:property
										value="reqBusiUnit" /></td>
								<td id=empBadgeNumber width="25%"><label for="_badgeNum">Approver
										Manager Notes ID :</label></td>
								<td width="30%"><s:property value="approveManagerNotesId" />
								</td>

							</tr>

							<tr>
								<th scope="row" colspan="4"></th>
							</tr>
							<tr>
								<td width="25%" nowrap="nowrap"></td>
								<td width="25%"></td>

								<s:if test="artControls.badgeNumEnabled">
									<td id=empBadgeNumber width="25%"><label for="_badgeNum">Access
											card ID:<span class="ibm-required">*</span>
									</label></td>
									<td width="30%"><s:textfield name="casBadgeNum"
											maxlength="15" id="casBadgeNum" onkeyup="numbercheck()" />
								</s:if>
								<s:if
									test="%{requestStatus=='Active' || requestStatus=='Initiated deactivation, Pending Revoke' || requestStatus=='Active, Pending Renewal'}">
									<td id=empBadgeNumber width="25%"><label for="_badgeNum">Access
											card ID :</label></td>
									<td width="30%"><s:property value="casBadgeNum" /></td>
								</s:if>
							</tr>

						</table>
					</div>
				</s:if>
				<s:elseif test='requestedForId == "B"'>
					<div id="Thirdrow">
						<table width="100%" border="0" class="ibm-results-table">

							<tr id="nonPhotoNameANdNotesId">
								<td id="empNameLabel" width="25%" nowrap="nowrap"><label
									for="_ownerName">Employee Name :</label></td>
								<td id="empText" width="30%"><s:property
										value="nonPhotoOwnerName" /></td>
								<td id="empNotesLabel" width="20%"><label
									for="_ownerNotesId">People Manger NotesId :</label></td>
								<td id="empNotesText"><s:property
										value="nonPhotoMgrNotesId" /></td>

								<!-- <input type="button" value="Edit ApproverNotesId" id="nonempApproverNotesId" onclick="linkEnableApproverNotesId();"> -->
							</tr>
							<!-- <tr>
								<th scope="row"></th>
							</tr> -->
							<tr>
								<td width="25%"></td>
								<td width="30%"><s:if test="editAllowed && !editBtnEnabled">

										<td width="20%" nowrap="nowrap"><label for="_ownerName">Search
												and Add :</label>
										<td width="20%">
											<%--  <s:if test="editAllowed && !editBtnEnabled"> --%> <s:hidden
												name="empNonPhotApproverCnum" id="empNonPhotApproverCnum" />
											<input type="text" name="empNonPhotApproverNotesId"
											id="empNonPhotApproverNotesId" size="40">
									</s:if> <%-- </s:if> --%> <!-- <input type="text" name="empNonPhotApproverNotesId" id="empNonPhotApproverNotesId"
													size="40"> --></td>
							</tr>
							<tr>
								<th scope="row"></th>
							</tr>
							<tr id="nonPhotoBatchAndEmplyeeNo">
								<td id="badgeLabel" width="25%" nowrap="nowrap"><label
									for="_badgeNumber">Badge Number :</label></td>
								<td id="badgeText" width="30%"><s:property
										value="badgeNumber" /></td>
								<td id="empCodeLabel" width="20%"><label for="_empCode">Employee
										Serial No :</label></td>
								<td id="empCodeText"><s:property value="empCode" /></td>
							</tr>

						</table>
					</div>
				</s:elseif>
			</div>

			<%-- TAB TWO --%>
			<div id="requestDetailsTAB" title="Secure Area Details"
				aria-label="Secure Area Details" style="display: 'none';">
				<table border="0" width="50%" id="data_table3"
					class="ibm-results-table">

					<tr>
						<td width="114"><label for="_reqEmpPSCAManager">Secure
								Area Manager :</label></td>
						<td width="190" nowrap="nowrap"><s:property
								value="pscaManager" /></td>


						<td width="114" style="visibility: hidden"><label
							for="_reqAcessControlId">AccessControl ID :</label></td>
						<td width="252" nowrap="nowrap" style="visibility: hidden"><s:textfield
								name="ownerAccessControlId" id="_ownerAccessControlOId"
								size="40" readonly="true" /></td>

					</tr>

					<tr>
						<td width="114"><label for="_empLocation">Location :</label></td>
						<td width="190" nowrap="nowrap"><s:property
								value="locationName" /></td>

						<td width="114"><label for="_reqEmpCampus">Campus :</label></td>
						<td width="190" nowrap="nowrap"><s:property
								value="campusName" /></td>

					</tr>
					<tr>
						<th scope="row"></th>
					</tr>

					<tr>
						<td width="114"><label for="_reqEmpCampus">Building :</label></td>
						<td width="190"><s:property value="buildingName" /></td>

						<td width="114"><label for="_reqEmpFloor">Floor :</label></td>
						<td width="190"><s:property value="floorName" /></td>
					</tr>
					<tr>
						<th scope="row"></th>
					</tr>

					<tr>
						<td width="114"><label for="_reqEmpWing">Wing :</label></td>
						<td width="190" nowrap="nowrap"><s:property value="wingName" /></td>
					</tr>

				</table>
			</div>

			<%-- TAB THREE --%>
			<s:if test="%{(eroEnabled != 0)}">
				<div id="ERO_section_TAB" title="ERO Section"
					aria-label="ERO Section" style="display: 'none';">
					<table border="0" id="data_table3" width="100%"
						class="ibm-results-table">
						<s:if
							test="requestStatus=='Active' && artControls.renewBtnEnabled">
							<tr>
								<td><label for="eroManager_id" name="eroManagerid">ERO
										Manager NotesID :</label></td>
								<td><s:property value="eromanagerid" /></td>
							</tr>
							<tr>
								<th scope="row"></th>
							</tr>
							<tr>
								<s:if test="buChange">
									<td><label for="isdl_host_manager_id">Host:<span
											class="ibm-required">*</span></label>
									<label>(BluePage Search)</label></td><td></td>
									<td><input type="text" id="hostManager1"
										name="hostManager1" value="" size="30" /><br>
									<label>(Type to fetch Employee Details)</label></td>
								</s:if>
							</tr>
<tr>
								<th scope="row"></th>
							</tr>
							<tr id="purposeRow">
								<!-- If host manager provide edit option-->

								<td width="114"><label for="_purpose">Purpose of access to Secure Area :<span
										class="ibm-required">*</span></label><br>
								<span style="font-size: x-small">(100 char)</span></td><td></td>
								<td><s:textarea id="purposetext"
										name="purposeOfCitizenship" maxlength="100" cols="100"></s:textarea>
								</td>

							</tr>


							<tr>
								<th scope="row"></th>
							</tr>
							<s:if test="!(buChange) && %{(eroIsSourceTechProvider == null) && (srcTechSelectionRemarks == null) && (scodedescription == null)}">
								<tr id="srcTechProviderRow">

									<td width="200"><label
										for="Source code technology being provided">Will the visitor get access to Source Code / technology ?(Link to Technology Chart  for reference: <a href = "https://w3-01.ibm.com/chq/ero/ero.nsf/ObjectFileDocView/IBM+Technologies+Chart.pdf/$File/IBM+Technologies+Chart.pdf">Link</a>
                                       <span class="ibm-required">*</span>
									</label></td>
									<td><s:radio id="isSourcCode1"
											name="eroIsSourceTechProvidername"
											list="#{'1':'Yes','2':'No', '3':'May be' }"
											onclick="handleEroSrcTchChange(this);" /></td>
								</tr>
								<tr>
									<th scope="row"></th>
								</tr>


								<tr id="srcTechSelectionRemarksRow">
									<td><label for="srcTechSelectionRemarks">Explain briefly the basis of your assessment for determining visitor's access to Source Code/technology<span class="ibm-required">*</span>
									</label><br>
									<span style="font-size: x-small">(100 char)</span></td>
									<td><s:textarea id="srcTechSelectionRemarks"
											name="srcTechSelectionRemarks" cols="100" maxlength="100"></s:textarea></td>

								</tr>
								<tr>
								<th scope="row"></th>
							</tr>
								<tr id="descriptionRow">
									<td id="srcdesclabel"><label for="sourcecodedescription">Description of Source Code / technology :<span class="ibm-required">*</span>
									</label><br>
									<span style="font-size: x-small">(100 char)</span></td>
									<td id="sourcecodedesccol2"><s:textarea
											id="sourcecodedescription" name="scodedescription" cols="100"
											maxlength="100"></s:textarea></td>

								</tr>
								<tr>
								<th scope="row"></th>
							</tr>
								<tr><td></td><td  width="200" ><div id="hostMgrNoteId"><p>The IBM host is responsible for ensuring any software source code or technology that may be disclose to their guest is authorized by US export regulation. Please contact your location export regulation coordinator(ERC) for 
			assistance if source code or technology is being provided</p></div></td></tr>
							</s:if>
						</s:if>
						<s:elseif test="%{isHostManager == 'TRUE' && eroEditableByHost}">
							<tr>
								<td><label for="eroManager_id" name="eroManagerid">ERO
										Manager NotesID :</label></td>
								<td><s:property value="eromanagerid" /></td>
							</tr>
<tr>
								<th scope="row"></th>
							</tr>
							<tr id="purposeRow">
								<!-- If host manager provide edit option-->

								<td ><label for="_purpose">Purpose of access to Secure Area :<span
										class="ibm-required">*</span></label><br>
								<span style="font-size: x-small">(100 char)</span></td>
								
								<td><s:textarea id="purposetext"
										name="purposeOfCitizenship" maxlength="100" cols="100"></s:textarea>
							</tr>


							<tr>
								<th scope="row"></th>
							</tr>

							<tr id="srcTechProviderRow">

								<td ><label
									for="Source code technology being provided">Will the visitor get access to Source Code / technology ? <a href = "https://w3-01.ibm.com/chq/ero/ero.nsf/ObjectFileDocView/IBM+Technologies+Chart.pdf/$File/IBM+Technologies+Chart.pdf">(Link to Technology Chart  for reference : </a><span class="ibm-required">*</span>
								</label></td>
								<td><s:radio id="isSourcCode1"
										name="eroIsSourceTechProvidername"
										list="#{'1':'Yes','2':'No', '3':'May be' }"
										onclick="handleEroSrcTchChange(this);" /></td>
							</tr>
							<tr>
								<th scope="row"></th>
							</tr>


							<tr id="srcTechSelectionRemarksRow">
								<td><label for="srcTechSelectionRemarks">Explain briefly the basis of your assessment for determining visitor's access to Source Code/technology<span class="ibm-required">*</span>
								</label><br>
								<span style="font-size: x-small">(100 char)</span></td>
								<td><s:textarea id="srcTechSelectionRemarks"
										name="srcTechSelectionRemarks" cols="100" maxlength="100"></s:textarea></td>

							</tr>
							<tr>
								<th scope="row"></th>
							</tr>
							<tr id="descriptionRow">
								<td id="srcdesclabel"><label for="sourcecodedescription">Description of Source Code / technology<span class="ibm-required">*</span>
								</label><br>
								<span style="font-size: x-small">(100 char)</span></td>
								<td id="sourcecodedesccol2"><s:textarea
										id="sourcecodedescription" name="scodedescription" cols="100"
										maxlength="100"></s:textarea></td>

							</tr>
<tr><td></td><td width="200"><div id="hostMgrNoteId"><p>The IBM host is responsible for ensuring any software source code or technology that may be disclose to their guest is authorized by US export regulation. Please contact your location export regulation coordinator(ERC) for 
			assistance if source code or technology is being provided</p></div></td></tr>
						</s:elseif>

						<s:else>
							<tr>
								<td><label for="eroManager_id" name="eroManagerid">ERO
										Manager NotesID :</label></td>
								<td><s:property value="eromanagerid" /></td>
							</tr>
<tr>
								<th scope="row"></th>
							</tr>
                     
							<tr id="purposeRow">
								<!-- If host manager provide edit option-->
								<s:if test="%{(!purposeOfCitizenship.isEmpty())}">
								<s:if test ="%{(purposeOfCitizenship!=null)}">
									<td width="114"><label for="_purpose">Purpose of access to Secure Area :<span
											class="ibm-required">*</span></label><br>
									<span style="font-size: x-small"></span></td>
									<td><s:property value="purposeOfCitizenship" /></td>
									</s:if>
								</s:if>
							</tr>
							
							<tr>
								<th scope="row"></th>
							</tr>
							<tr id="srcTechProviderRow">
								<s:if test="%{(eroIsSourceTechProvider != null)}">
									<td width="200"><label
										for="Source code technology being provided">Will the visitor get access to Source Code / technology ? <a href = "https://w3-01.ibm.com/chq/ero/ero.nsf/ObjectFileDocView/IBM+Technologies+Chart.pdf/$File/IBM+Technologies+Chart.pdf">(Link to Technology Chart  for reference)</a> :<span class="ibm-required">*</span>
									</label><br></td>
									<td><s:property value="eroIsSourceTechProvider" /></td>
								</s:if>
							</tr>
							<tr>
								<th scope="row"></th>
							</tr>
							<tr id="srcTechSelectionRemarksRow">
							<s:if test="%{(!srcTechSelectionRemarks.isEmpty())}" >
								<s:if test="%{(srcTechSelectionRemarks!=null)}">
									<td><label for="srcTechSelectionRemarks">Explain briefly the basis of your assessment for determining visitor's access to Source Code/technology<span class="ibm-required">*</span>
									</label><br>
									<span style="font-size: x-small"></span></td>
									<td><s:property value="srcTechSelectionRemarks"/></td>
								</s:if>
								</s:if>
							</tr>
							<tr>
								<th scope="row"></th>
							</tr>
							<tr id="descriptionRow">
								<s:if test="%{(!scodedescription.isEmpty())}">
								<s:if test="%{(scodedescription != null)}">
									<td id="srcdesclabel"><label for="sourcecodedescription">Description of Source Code / technology :<span class="ibm-required">*</span>
									</label><br>
									<span style="font-size: x-small"></span></td>
									<td id="sourcecodedesccol2"><s:property
											value="scodedescription" /></td>
											</s:if></s:if>
							
							</tr>
                            
						</s:else>
						<%--  <s:else>
				    <div id="requestDetailsTAB" title="Secure Area Details"
				aria-label="Secure Area Details" style="visibility :'hidden';"></div> 
				</s:else> --%>

					</table>
					
					
				</div>
			</s:if>


			<!-- tab four -->
			<div id="Work_Flow_TAB" title="Work Flow" aria-label="Work Flow"
				style="display: 'none';">
				<table border="0" id="data_table4" width="100%"
					class="ibm-results-table">
					<thead>
						<tr>
							<th scope="col" style='vertical-align: top;' width="9%"
								class="ibm-date ibm-sort"><span><s:text
										name="Actioned By" /></span><span class="ibm-icon">&nbsp;</span></th>
							<th scope="col" style='vertical-align: top;' width="10%"
								class="ibm-date ibm-sort"><span><s:text
										name="Status" /></span><span class="ibm-icon">&nbsp;</span></th>

							<th scope="col" style='vertical-align: top;' width="10%"><span><s:text
										name="Time Stamp" /></span><span class="ibm-icon">&nbsp;</span></th>

							<th scope="col" style='vertical-align: top;' width="10%"><span><s:text
										name="Approver's Comment" /></span><span class="ibm-icon">&nbsp;</span></th>
							<th scope="col" style='vertical-align: top;' width="10%"><span><s:text
										name="Follow Up Action" /></span><span class="ibm-icon"></span></th>


						</tr>
					</thead>
					<tbody>
						<s:iterator value="wkDtoLi">
							<tr>
								<td style='vertical-align: top;'><s:property
										value="actionedByDisplay" /></td>
								<td style='vertical-align: top;'><s:property
										value="approverAction.value" /></td>
								<td style='vertical-align: top;'><s:property
										value="formattedDate" /></td>
								<td style='vertical-align: top;'><s:property
										value="approverComments" /></td>
								<td style='vertical-align: top;'><s:property
										value="wfStatus.value" /></td>
							</tr>
						</s:iterator>
					</tbody>

				</table>
			</div>

			<!-- tab five -->
			<div id="Audit_TAB" title="Audit Trial" aria-label="Audit Trial"
				style="display: 'none';">
				<s:iterator value="auditTrial">
					<s:property />
					<br>
					<br>
				</s:iterator>
			</div>
		</div>

		<div align="center">
			<span class="button-blue"> <s:if test='requestedForId == "B"'>
					<s:if test="editAllowed">
						<s:if test="editBtnEnabled">
							<s:submit value="Update ApproverNotesId" id="apprNotesId"
								onclick="updateButtonFun()"></s:submit>
						</s:if>
					</s:if>
				</s:if> <s:if test="artControls.approveRejectBtnEnabled">
					<s:submit value="Approve" id="Approve"
						onclick="return approveButtonFun()"></s:submit>
					<s:submit value="Reject" id="Reject"
						onclick="return rejectButtonFun()"></s:submit>
				</s:if> <s:if test="artControls.grantBtnEnabled">
					<s:submit value="Grant" id="Grant" onclick="grantFun()"></s:submit>
				</s:if> <s:if test="artControls.revokeBtnEnabled">
					<s:submit value="Revoke" id="Revoke" onclick="revokeFun()"></s:submit>
				</s:if> <s:if test="artControls.cancelBtnEnabled">
					<s:submit value="Cancel" id="Cancel" onclick="cancelButtonFun()"></s:submit>
				</s:if> <s:if test="artControls.deactivateBtnEnabled">
					<s:submit value="Deactivate" id="Deactive"
						onclick="deactiveButtonFun()"></s:submit>
				</s:if> <s:if test="artControls.renewBtnEnabled">
					<s:submit value="Renew" id="Renew" onclick="renewButtonFun()"></s:submit>
				</s:if> <s:if test='pendingForValidate=="true"'>
					<s:submit value="Validate" id="Validate"
						onclick="return reqValidate();"></s:submit>
				</s:if>
			</span>
		</div>
	</div>
</s:form>

<script type="text/javascript" charset="utf-8" language="javascript">

dojo.addOnLoad(function() { 
	dojo.ready(function() {
		
	 	 displayTab(1);
		 var val1 = "<s:property value='startDate'/>";
	     var val2 = "<s:property value='endDate'/>";
		 var startDate = parseStringToDate(val1);
		 var endDateVale = parseStringToDate(val2);
		 var isPastStartDate = <s:property value="startDatePassed"/>;
		 var startEndEnable= <s:property value="artControls.startEndDatesEnabled"/>;
		 var renewenableTrue= <s:property value="artControls.renewDateEnabled"/>;
		 var endExtendedDateInt = <s:property value="endDateExtendLong"/>;
		 var workFlowStatus ='<s:property value="workflowStatus"/>';
		 if(renewenableTrue == true) {
				var newExtendedEndDateValue = new Date(endExtendedDateInt);
				minDateConstraint("extendedEndDateRenew", endDateVale);
				setDateToFieldId("extendedEndDateRenew", newExtendedEndDateValue, document);
				if(workFlowStatus !="Pending with People Manager" && workFlowStatus !="Pending with Secure Area Manager" && workFlowStatus !="Pending with ERO Manager"){  
				var enddateLimit = addYearsToDate(endDateVale, 10);
				maxDateConstraint("extendedEndDateRenew",enddateLimit);
				}
		 } 
		 if(startEndEnable){
		 minDateConstraint("startDate", new Date());
		 if(isPastStartDate){
			 setDateToFieldId("startDate", new Date(), document); 
			 startDateOnChangeHandler(new Date());
		 }
		 else{
		 	setDateToFieldId("startDate", startDate, document);
		 	startDateOnChangeHandler(startDate);
		 }
		 }
		 
	});
	
});

var requestedForTAB = document.getElementById('requestedForTAB');
var requestDetailsTAB = document.getElementById('requestDetailsTAB');
var ERO_section_TAB = document.getElementById('ERO_section_TAB');
//display for ero fields
var srcTechSelectionRemarks = "<s:property value='srcTechSelectionRemarks'/>";
var purposeOfCitizenship =  "<s:property value='purposeOfCitizenship'/>";
var sourceCodeYesOrNo =  "<s:property value='sourceCodeYesOrNo'/>";
var scodedescription =  "<s:property value='scodedescription'/>";
var isHostManager = "<s:property value='isHostManager'/>"
//

function displayTab(tabId){ 
	if(tabId == 1) {
		requestedForTAB.style.display = 'block';
		requestDetailsTAB.style.display = 'none';
		Work_Flow_TAB.style.display = 'none';
		Audit_TAB.style.display = 'none';
		if(ERO_section_TAB)
		ERO_section_TAB.style.display = 'none';
	} else if(tabId == 2) {
		requestedForTAB.style.display = 'none';
		requestDetailsTAB.style.display = 'block';
		Work_Flow_TAB.style.display = 'none';
		Audit_TAB.style.display = 'none';
		if(ERO_section_TAB)
		ERO_section_TAB.style.display = 'none';
	} else if(tabId == 3) {
		requestedForTAB.style.display = 'none';
		requestDetailsTAB.style.display = 'none';
		Work_Flow_TAB.style.display = 'none';
		Audit_TAB.style.display = 'none';
		/* //
		if((srcTechSelectionRemarks ==null ||srcTechSelectionRemarks =='')&& isHostManager != 'TRUE')
			document.getElementById("srcTechSelectionRemarksRow").style.display ='none';
		if((purposeOfCitizenship ==null || purposeOfCitizenship =='')&& isHostManager != 'TRUE')
			document.getElementById("purposeRow").style.display ='none';
		if((sourceCodeYesOrNo ==null || sourceCodeYesOrNo =='')&& isHostManager != 'TRUE')
			document.getElementById("srcTechProviderRow").style.display ='none';
		if((scodedescription ==null ||scodedescription =='')&& isHostManager != 'TRUE')
			document.getElementById("descriptionRow").style.display ='none'; 
		// */
		if( ERO_section_TAB){
		ERO_section_TAB.style.display = 'block';
		}
		
	}else if(tabId == 4) {
		requestedForTAB.style.display = 'none';
		requestDetailsTAB.style.display = 'none';
		Work_Flow_TAB.style.display = 'block';
		Audit_TAB.style.display = 'none';
		if(ERO_section_TAB)
		ERO_section_TAB.style.display = 'none';
	
	}else if(tabId == 5) {
		requestedForTAB.style.display = 'none';
		requestDetailsTAB.style.display = 'none';
		Work_Flow_TAB.style.display = 'none';
		Audit_TAB.style.display = 'block';
		if(ERO_section_TAB)
		ERO_section_TAB.style.display = 'none';
	}
} 

var labBu = document.getElementById('labBu').value;
configureFaceSearchForEmpDeptDefault(document.getElementById('hostManager1'),labBu,
		function(artEmp) {
	document.getElementById('hostManager').value = artEmp.cnumID;
			return person['notes-id'];
		});
</script>



<script type="text/javascript" charset="utf-8" language="javascript">

	
	function startDateOnChangeHandler(ApprovalStartDate)
	 { 
		 var val2 = document.getElementById("endDate").value;
			if (val2 != '') {
				var newStartToDate = parseStringToDate(val2);
				maxDateConstraint("startDate", newStartToDate);
			}
			
		 //attachOnChangeEvtToDateTxtBox("startDate", startDateOnChangeHandler);
		 var empRequestedType = '<s:property value="requestedEmpTypeofAccess"/>' ;
		 if(empRequestedType == 'Temporary')
	      {
		   	 //document.getElementById('disclaimer').style.visibility="visible";
			 	
			 //var enddateLimit = addMonthsToDate(ApprovalStartDate, 3);
			 //maxDateConstraint("endDate",enddateLimit);
			 minDateConstraint("endDate", ApprovalStartDate);
		 }
		 else
			 {
				// document.getElementById('disclaimer').style.visibility="hidden";	
			 	//var enddateLimit = addYearsToDate(ApprovalStartDate, 10);
			 	//maxDateConstraint("endDate",enddateLimit);
			 	minDateConstraint("endDate", ApprovalStartDate);
			 }
	 } 
</script>
<script type="text/javascript" charset="utf-8" language="javascript">

                    configureFaceSearchForManager(
					document.getElementById('empNonPhotApproverNotesId'),
					function(person) {
						if (confirm("Do you want to add " + person['notes-id']
								+ " as People Manager?")) {
							document.getElementById('empNonPhotApproverNotesId').value = person.managerCnumID;
							document.getElementById("empNonPhotApproverCnum").value = person.uid;
							document.commonform.action = 'updateNonPhotoBadgeApproverManager.action';
							document.commonform.submit();
							return person['notes-id'];
						} else {
							return false;
						}

					});

                    
                    var noSrcTechDisclaimerText = "<%=request.getAttribute("noSrcTechDisclaimerText")%>";
	var eroWorkForDisclaimerJson = <%=request.getAttribute("getwrkforDisclaimerJsonMap")%>;

	function showdEroDisclaimer(selectedvalue) {
		var workfordropdownval = selectedvalue.value;
		for ( var wrkDisclMap in eroWorkForDisclaimerJson) {
			if (eroWorkForDisclaimerJson[wrkDisclMap].id == workfordropdownval) {
				document.getElementById("workfordisclaimer").innerHTML = eroWorkForDisclaimerJson[wrkDisclMap].value;
				break;
			}
		}
	}

	function handleEroSrcTchChange(selectedVal) {
		var val = selectedVal.value;
		document.getElementById('eroIsSourceTechProvider').value = val;
		var hostMgrNoteId = document.getElementById('hostMgrNoteId');
		var sd = document.getElementById('eroIsSourceTechProvider').value;
	
		if (val === "1" || val === "3") {
			document.getElementById('srcdesclabel').style.visibility = 'visible';
			document.getElementById('sourcecodedesccol2').style.visibility = 'visible';
			//document.getElementById('sourcecodedesccol2').style.visibility = 'visible';
			//  document.getElementById('workingfor').style.visibility='visible';
			//  document.getElementById('workfordisclaimer').style.visibility='visible';
			//  document.getElementById("eroIsSourceTechProvider").value = true; 
		//	hostMgrNoteId.style.display = 'none';
		} else {
			document.getElementById('srcdesclabel').style.visibility = 'hidden';
			document.getElementById('sourcecodedesccol2').style.visibility = 'hidden';
			//document.getElementById('sourcecodedesccol2').style.visibility = 'hidden';
			// document.getElementById('sourcecodedesc').style.display='inline';
			//  document.getElementById('workingfor').style.visibility='hidden';
			//  document.getElementById('workfordisclaimer').style.visibility='hidden';
			//  document.getElementById('sourcetechNodisclaimer').innerHTML=noSrcTechDisclaimerText;
		//	hostMgrNoteId.style.display = 'block';
		}
	}
</script>
