<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.vendorform.dao.SPC_DataDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>SPC Summary</title>
<link href="js/datepicker/bootstrap-combined.min.css" rel="stylesheet"/> 
	<script type="text/javascript" src="js/datepicker/jquery.min.js"> </script>
	<script type="text/javascript" src="js/datepicker/bootstrap.min.js"> </script>
	<script type="text/javascript" src="js/datepicker/datepicker.js"> </script>
	<link rel="stylesheet" type="text/css" media="screen" href="js/datepicker/bootstrap-datetimepicker.min.css"/> 
	<script type="text/javascript" src="js/datepicker/bootstrap-datetimepicker.pt-BR.js"> </script>
 <link href='dist/rome.css' rel='stylesheet' type='text/css' />
<link href='example/example.css' rel='stylesheet' type='text/css' />
  
<!--  Graph  -->
<script type="text/javascript" src="js/loader.js"></script>

<style>
.button {
	background-color: #f48342;
	border: none;
	color: white;
	padding: 13px 28px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	font-weight: bold;
	margin: 3px 1px;
	cursor: pointer;
	margin: 3px 1px;
}

.dropbtn {
	background-color: black;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
	font-family: Arial;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	font-family: Arial;
	position: absolute;
	background-color: #3b7687;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: black;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: black;
}

.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
 
<style type="text/css">
.tftable {
	font-family: Arial;
	font-size: 12px;
	color: #333333;
}

.tftable tr {
	background-color: white;
	font-size: 13px;
}

.tftable td {
	font-size: 12px;
	font-family: Arial;
	padding: 3px;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style4 {
	font-size: 12px
}

.style5 {
	font-weight: bold;
	font-size: 12px;
}

.style6 {
	color: #FF0000
}
</style>
</head>
<body>
 
	<%
		try {
			Connection conMaster = Connection_Utility.getConnectionMaster();
			SPC_DataDAO dao = new SPC_DataDAO();
			Date date = new Date();
			String toDate = new SimpleDateFormat("dd/MM/yyyy").format(date);
			DecimalFormat df = new DecimalFormat("00.0000");
			DecimalFormat df5 = new DecimalFormat("00.00000");
			
			Calendar c = Calendar.getInstance();
			c.set(Calendar.DAY_OF_MONTH, 1);
			String fromDate = new SimpleDateFormat("dd/MM/yyyy").format(c.getTime());

			// ------------------Next Date for sql between loop ---------------------------		    
			Calendar c1 = Calendar.getInstance();
			c1.setTime(date);
			c1.add(Calendar.DATE, 1);
			Date currentDatePlusOne = c1.getTime();
			String nextDate = new SimpleDateFormat("dd/MM/yyyy").format(currentDatePlusOne);

			Date datesql_from = new SimpleDateFormat("dd/MM/yyyy").parse(fromDate);
			Timestamp timeStampFromDate = new Timestamp(datesql_from.getTime());
			 
			Date datesql_to = new SimpleDateFormat("dd/MM/yyyy").parse(toDate);
			Timestamp timeStampToDate = new Timestamp(datesql_to.getTime());
			
			Date datesql_Nextto = new SimpleDateFormat("dd/MM/yyyy").parse(nextDate);
			Timestamp timeStampToNextDate = new Timestamp(datesql_Nextto.getTime());
			// ----------------------------------------------------------------------------
			// System.out.println("date from =  " + datesql_from + "to  = = " + datesql_to);
			
			
			ArrayList xLarge = new ArrayList();
			ArrayList xSmall = new ArrayList();
			ArrayList xAvg = new ArrayList();
			ArrayList xRange = new ArrayList();
			ArrayList parameter = new ArrayList(); 
			
			ArrayList row1 = new ArrayList(); 
			ArrayList row2 = new ArrayList(); 
			ArrayList row3 = new ArrayList(); 
			ArrayList row4 = new ArrayList(); 
			ArrayList row5 = new ArrayList(); 
			ArrayList date_pass = new ArrayList();  
			ArrayList datafor = new ArrayList(); 
			
			boolean flagView=false;
			
			if (request.getAttribute("xLarge") != null  && request.getAttribute("xSmall") != null && 
					request.getAttribute("xAvg") != null && request.getAttribute("xRange") != null) {
				xLarge = (ArrayList) request.getAttribute("xLarge");
				xSmall = (ArrayList) request.getAttribute("xSmall");
				xAvg = (ArrayList) request.getAttribute("xAvg");
				xRange = (ArrayList) request.getAttribute("xRange");
				parameter = (ArrayList) request.getAttribute("parameter");
				row1 = (ArrayList) request.getAttribute("row1");
				row2 = (ArrayList) request.getAttribute("row2");
				row3 = (ArrayList) request.getAttribute("row3");
				row4 = (ArrayList) request.getAttribute("row4");
				row5 = (ArrayList) request.getAttribute("row5");
				date_pass = (ArrayList) request.getAttribute("date_pass");		
				datafor = (ArrayList) request.getAttribute("datafor");
				
				flagView=true;
				//System.out.println("There are values in the arraylist" + xLarge + " = " + xSmall + " =" + xAvg + " = " + xRange + " = " + parameter + " = " + datafor);
			} else {
				//System.out.println("There are no values in the arraylist");
			}
	%>
	<div id="container">
		<div id="content">
			<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
			<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			<%@include file="Header.jsp"%>
			<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			 
				<%
					if (request.getParameter("success") != null) {
				%>
				<script type="text/javascript">alert("<%=request.getParameter("success")%>"); </script>
				<%
					}
				%>
<form action="SPC_DataControl" method="post" id="SPC_DataControl">
				<table class="tftable" style="width: 60%;">
					<tr
						style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
						<td>Date From</td>
						<td>Date To</td>
						<td>Vendor</td>
						<td>Parameter</td>
						<td>Submit</td>
					</tr>
					
					<tr>
					
					<%
					if(flagView==false){
					%>
					<td>
 	<input id='dt' class='input' name="fromDate" id="fromDate" value="<%=timeStampFromDate%>"/>
 					</td>
					<td>
	<input id='dt1' class='input' name="toDate" id="toDate" value="<%=timeStampToDate%>"/>  
					</td>		
					<%
					}else{
						%>
						<td>
	 	<input id='dt' class='input' name="fromDate" id="fromDate" value="<%=date_pass.get(0)%>"/>
	 					</td>
						<td>
		<input id='dt1' class='input' name="toDate" id="toDate" value="<%=date_pass.get(1)%>"/>  
						</td>		
						<%	
					}
					%>
					
								
					<td>
					<select  class='input' id="datafor" name="datafor" style="font-weight: bold;">
								<%
									if (access.equalsIgnoreCase("FULL")) {
										String query ="";	
								if(flagView==true){
									if(!datafor.get(0).toString().equalsIgnoreCase("all")){
								   query ="SELECT site_name,sapcode  FROM Baker_site where enable=1 and sapcode='"+datafor.get(0).toString()+"'";	
								  PreparedStatement ps_vendor = conMaster.prepareStatement(query);
								  ResultSet rs_vendor = ps_vendor.executeQuery();
								  while (rs_vendor.next()) {
								%>
								<option value="<%=rs_vendor.getInt("sapcode")%>"><%=rs_vendor.getString("site_name")%></option>
								<%
									} 	
									}
										}
								%>
								<option value="all">- - - - - ALL Vendors - - - - -</option>
								<% 
										    query ="SELECT distinct site_name,sapcode  FROM Baker_site where enable=1";
											PreparedStatement ps_vendor = conMaster.prepareStatement(query);
											ResultSet rs_vendor = ps_vendor.executeQuery();
											while (rs_vendor.next()) {
								%>
								<option value="<%=rs_vendor.getInt("sapcode")%>"><%=rs_vendor.getString("site_name")%></option>
								<%
									}
										} else {
											String query = "SELECT  *  FROM Baker_site where enable=1  and sapcode= '" + vendor_Code + "'";
											PreparedStatement ps_vendor = conMaster.prepareStatement(query);
											ResultSet rs_vendor = ps_vendor.executeQuery();
											while (rs_vendor.next()) {
								%>
								<option value="<%=rs_vendor.getInt("sapcode")%>"><%=rs_vendor.getString("site_name")%></option>
								<%
									}
										}
								%>
						</select></td>




<td>
					<select  class='input' id="parameter" name="parameter" style="font-weight: bold;">
								<%
								String query ="";
								if(flagView==true){ 
									query = "SELECT *  FROM Baker_HeaderData where id="+Integer.valueOf(parameter.get(3).toString());
									PreparedStatement ps_header = conMaster.prepareStatement(query);
									ResultSet rs_header = ps_header.executeQuery();
									while (rs_header.next()) {
						%>
						<option value="<%=rs_header.getInt("id")%>"><%=rs_header.getString("parameter")%> <%=rs_header.getString("range_from")%> - <%=rs_header.getString("range_to")%></option>
						<%
							} 
								}
								
								query = "SELECT *  FROM Baker_HeaderData where range_from!='' and range_to!=''";
											PreparedStatement ps_header = conMaster.prepareStatement(query);
											ResultSet rs_header = ps_header.executeQuery();
											while (rs_header.next()) {
								%>
								<option value="<%=rs_header.getInt("id")%>"><%=rs_header.getString("parameter")%> <%=rs_header.getString("range_from")%> - <%=rs_header.getString("range_to")%></option>
								<%
									}
								%>
						</select></td>





						<td>
						<input type="submit" value="GO" style="font-weight: bold;"/>
						<!-- <button onclick="GetAllFilterResults()">
								<strong>GO</strong>
							</button> --> 
						</td>
					</tr>
				</table> 
</form>
 
<%
if(flagView==true){
	int snNo=1; 
		String viewVendor=datafor.get(0).toString();
		if(!datafor.get(0).toString().equalsIgnoreCase("all")){
		PreparedStatement ps_datafor = conMaster.prepareStatement("select site_name from Baker_site where sapcode='"+datafor.get(0).toString()+"'");
		ResultSet rs_datafor = ps_datafor.executeQuery();
		while(rs_datafor.next()){
			viewVendor = rs_datafor.getString("site_name");
		}
		} 
%>
<div style="width: 50%;float: left;font-size: 12px;">
<table class="tftable" style="width: 100%;margin-left: 1px;">
<tr style="background-color: green;color:white; font-weight: bold;">
						<td colspan="4"><strong style="font-size: 15px;"><%=parameter.get(0).toString() %></strong> <strong style="font-size: 15px;">[ <%=parameter.get(1).toString() %> - <%=parameter.get(2).toString() %> ]</strong></td>
						<td colspan="4" align="left"><strong style="font-size: 15px;">Vendor : <%=viewVendor %></strong> </td>
						<td colspan="3" align="left"><strong style="font-size: 15px;">No of Readings : 50</strong> </td> 
					</tr>
					<tr style="font-size: 12px;text-align:center; background-color: gray;color:white; font-weight: bold;">
						<td>S.No</td>
						<td>1</td>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
						<td>7</td>
						<td>8</td>
						<td>9</td>
						<td>10</td>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row1.size();i++){
					%>					
					<td><%=row1.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr> 
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row2.size();i++){
					%>					
					<td><%=row2.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row3.size();i++){
					%>					
					<td><%=row3.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row4.size();i++){
					%>					
					<td><%=row4.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row5.size();i++){
					%>					
					<td><%=row5.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">X Large</td>
					<%
					for(int i=0;i<xLarge.size();i++){
					%>					
					<td><%=xLarge.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">X Small</td>
					<%
					for(int i=0;i<xSmall.size();i++){
					%>					
					<td><%=xSmall.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">Range</td>
					<%
					for(int i=0;i<xRange.size();i++){
					%>					
					<td><%=xRange.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">AVG</td>
					<%
					for(int i=0;i<xAvg.size();i++){
					%>					
					<td><%=xAvg.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr> 		
</table>					
</div>
<div style="width: 49.9%; float: right;font-size: 12px;">
<%
double sampleValuea2=0.0,sampleValued4=0.0;
PreparedStatement ps_sample = conMaster.prepareStatement("SELECT a2,d4  FROM baker_sample where id = 5 and enable=1");
ResultSet rs_sample = ps_sample.executeQuery();
while(rs_sample.next()){
	sampleValuea2 = Double.valueOf(rs_sample.getString("a2"));
	sampleValued4 = Double.valueOf(rs_sample.getString("d4"));
}
 

ArrayList xMax = new ArrayList();
ArrayList xMin = new ArrayList();
Double xBar = 0.0; 
Double rBar = 0.0; 
Double ucl_xBar=0.0, lcl_xBar=0.0;
Double ucl_rBar=0.0, lcl_rBar=0.0;
Double xbalValue = 0.0, rRangeval=0.0;
Double std_dev=0.0;
ArrayList alldata=new ArrayList();

xMax.add(Collections.max(xLarge));
xMin.add(Collections.max(xSmall));

for(int i=0;i<10;i++){
	xbalValue = xbalValue + (Double.parseDouble(row1.get(i).toString()) + Double.parseDouble(row2.get(i).toString()) 
			+ Double.parseDouble(row3.get(i).toString()) + Double.parseDouble(row4.get(i).toString())
			+ Double.parseDouble(row5.get(i).toString()));
	alldata.add(xbalValue);
}
xBar =Double.valueOf(df.format(xbalValue/50));
Double xaverage =0.0;

for(int i=0;i<10;i++){
	rRangeval = rRangeval + Double.parseDouble(xRange.get(i).toString());
	xaverage = xaverage + Double.parseDouble(xAvg.get(i).toString());
}
xaverage =  Double.valueOf(df.format(xaverage/10));

rBar = Double.valueOf(df.format(rRangeval/10));

ucl_xBar = Double.valueOf(df.format(xBar + (sampleValuea2*rBar)));
lcl_xBar = Double.valueOf(df.format(xBar- (sampleValuea2*rBar)));
ucl_rBar = Double.valueOf(df.format(rBar*sampleValued4));
lcl_rBar = Double.valueOf(df.format(rBar*0));

 Double sumstdDev = xbalValue/50,sumDevcheck=0.0;
 for(int i=0;i<10;i++){
	 sumDevcheck = sumDevcheck + (Math.pow((Double.parseDouble(row1.get(i).toString())-sumstdDev),2) + Math.pow((Double.parseDouble(row2.get(i).toString())-sumstdDev),2)
				+ Math.pow((Double.parseDouble(row3.get(i).toString())-sumstdDev),2) + Math.pow((Double.parseDouble(row4.get(i).toString())-sumstdDev),2)
				+ Math.pow((Double.parseDouble(row5.get(i).toString())-sumstdDev),2));		
	}
 
 Double range2 =Double.valueOf(parameter.get(2).toString());
 Double range1 =Double.valueOf(parameter.get(1).toString()); 
 Double tolerance = range2 - range1;
 
 sumDevcheck = sumDevcheck/50;
 Double stdDev = Double.valueOf(df.format(Math.sqrt(sumDevcheck)));
 Double specWidth= Math.abs(Double.valueOf(df5.format(tolerance)));
 
/*  Double cp = Double.valueOf(df.format((6*stdDev)/tolerance)); */

Double cp = Double.valueOf(df.format(specWidth/(stdDev*6)));

Double designCenter =(range1+range2)/2;
Double shiftXbar = Math.abs(xBar-designCenter);
Double indexK=(2*shiftXbar)/specWidth;
Double avgLsl=0.0;		
 //Double cpk =Double.valueOf(df.format( (1-indexK)*cp));  xaverage  
 //System.out.println("std dev = " + stdDev + " avg =  " + xaverage); 

 /* Double cpk_uSL = Double.valueOf(df.format((3*stdDev)/(range2-xaverage))); */
 Double cpk_uSL = Double.valueOf(df.format(((1-indexK)*cp)));
 
 // System.out.println(cp + "cpk_uSL = " + cpk_uSL+" = " + specWidth + " = " + tolerance + " = " + shiftXbar); 
 %>
<table class="tftable" style="width: 100%;">
<tr style="background-color: gray;color:white; font-weight: bold;">
<td>X Max </td>
<td>X Min</td>
<td>R Bar</td>
<td>X Bar</td>
<td>U.C.L. X BAR</td>
<td>U.C.L. R BAR</td>
</tr>
<tr align="right">
<td><strong><%=xMax.get(0).toString() %></strong></td>
<td><strong><%=xMin.get(0).toString() %></strong></td>
<td><strong><%=rBar %></strong></td>
<td><strong><%=xBar %></strong></td>
<td><strong><%=ucl_xBar %></strong></td>
<td><strong><%=ucl_rBar %></strong></td>
</tr>
<tr style="background-color: gray;color:white; font-weight: bold;">
<td>L.C.L. X BAR </td>
<td>L.C.L. R BAR </td>
<td>Std.Dev.</td>
<td>Specification Width(S)</td>
<td>Cp</td>
<td>Cpk</td>
</tr>
<tr align="right">
<td><strong><%=lcl_xBar %></strong></td>
<td><strong><%=lcl_rBar %></strong></td>
<td><strong><%=df5.format(stdDev) %></strong></td> 
<td><strong><%=specWidth %></strong></td>
<td><strong><%=cp %></strong></td>
<td><strong><%=cpk_uSL%></strong></td>
</tr>
</table>   

</div> 
<script>
/* google.charts.load('44', {
	  callback: drawChart,
	  packages: ['line', 'corechart']
	}); */
	
	google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart);
    google.charts.setOnLoadCallback(drawChart1);
	
	
	function drawChart() {
	  var data= google.visualization.arrayToDataTable(
	    [['X - Chart', 'AVG','U.C.L.','L.C.L.','X-BAR'], 
	    	<%
	    	for(int i=0;i<10;i++){
	    	%>
	    	[<%=i+1%>,  <%= Double.valueOf(xAvg.get(i).toString())%> ,  <%=ucl_xBar%> , <%=lcl_xBar%> , <%=xBar%> ],
	    	<%
	    	}
	    	%> 
	    ]);
 
	  // format numbers in second column to 5 decimals
	  var formatter = new google.visualization.NumberFormat({
	    pattern: '#,##0.0000'
	  });
	  formatter.format(data, 1); 
	  var options1 = {
			  width: 600,
		        height: 300, 
	    axes: {
	      x: {
	        0: {side: 'down'}
	      }
	    },
	    vAxis: {format: '#,##0.0000'}
	  }; 
 
	  var chart1 = new google.charts.Line(document.getElementById('x_chart')); 
	  chart1.draw(data, google.charts.Line.convertOptions(options1)); 
	   
	} 
	
	
	
	
	function drawChart1() {
		  var data1= google.visualization.arrayToDataTable(
		    [['R - Chart', 'Range','U.C.L.','L.C.L.','R-BAR'], 
		    	<%
		    	for(int i=0;i<10;i++){
		    	%>
		    	[<%=i+1%>,  <%= Double.valueOf(xRange.get(i).toString())%> ,  <%=ucl_rBar%> , <%=lcl_rBar%> , <%=rBar%> ],
		    	<%
		    	}
		    	%> 
		    ]);
	 
		  // format numbers in second column to 5 decimals
		  var formatter1 = new google.visualization.NumberFormat({
		    pattern: '#,##0.0000'
		  });
		  formatter1.format(data1, 1); 
		  var options2 = {
				  width: 600,
			        height: 300, 
		    axes: {
		      x: {
		        0: {side: 'down'}
		      }
		    },
		    vAxis: {format: '#,##0.0000'}
		  }; 
	 
		  var chart1 = new google.charts.Line(document.getElementById('r_chart')); 
		  chart1.draw(data1, google.charts.Line.convertOptions(options2)); 
		   
		}  
</script>  
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<div id="x_chart" style="width: 49.9%;float: left;font-size: 12px;margin-top: 10px;"></div>
  <div id="r_chart" style="width: 49.9%;float: left;font-size: 12px;margin-top: 10px;"></div>
 

<!-- <div id="chart_div" style="float: left;font-size: 12px;  height: 300px;width: 500px;"></div>
 <script type="text/javascript">
  
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart4);
      function drawChart4() {
    	  var data = google.visualization.arrayToDataTable([
    	                                                    ['Dinosaur', 'Length'],
    	                                                    ['Acrocanthosaurus (top-spined lizard)', 12.222],
    	                                                    ['Albertosaurus (Alberta lizard)', 9.2221],
    	                                                    ['Allosaurus (other lizard)', 12.2],
    	                                                    ['Apatosaurus (deceptive lizard)', 22.9222],
    	                                                    ['Archaeopteryx (ancient wing)', 0.9222],
    	                                                    ['Argentinosaurus (Argentina lizard)', 36.6222],
    	                                                    ['Baryonyx (heavy claws)', 9.1],
    	                                                    ['Brachiosaurus (arm lizard)', 30.5222],
    	                                                    ['Ceratosaurus (horned lizard)', 6.134],
    	                                                    ['Coelophysis (hollow form)', 2.347],
    	                                                    ['Compsognathus (elegant jaw)', 0.934],
    	                                                    ['Deinonychus (terrible claw)', 2.7333],
    	                                                    ['Diplodocus (double beam)', 27.134],
    	                                                    ['Dromicelomimus (emu mimic)', 3.434],
    	                                                    ['Gallimimus (fowl mimic)', 5.534],
    	                                                    ['Mamenchisaurus (Mamenchi lizard)', 21.034],
    	                                                    ['Megalosaurus (big lizard)', 7.934],
    	                                                    ['Microvenator (small hunter)', 1.234],
    	                                                    ['Ornithomimus (bird mimic)', 4.6],
    	                                                    ['Oviraptor (egg robber)', 1.5],
    	                                                    ['Plateosaurus (flat lizard)', 7.9],
    	                                                    ['Sauronithoides (narrow-clawed lizard)', 2.034],
    	                                                    ['Seismosaurus (tremor lizard)', 45.7],
    	                                                    ['Spinosaurus (spiny lizard)', 12.2],
    	                                                    ['Supersaurus (super lizard)', 30.5],
    	                                                    ['Tyrannosaurus (tyrant lizard)', 15.2],
    	                                                    ['Ultrasaurus (ultra lizard)', 30.5],
    	                                                    ['Velociraptor (swift robber)', 1.8]]);


    	  var formatter1 = new google.visualization.NumberFormat({
  		    pattern: '#,##0.000'
  		  });
  		  formatter1.format(data, 1);                                               
  		  var options = {
    	    title: 'Charges of subatomic particles',
    	    legend: { position: 'top', maxLines: 2 },
    	    colors: ['#5C3292', '#1A8763', '#871B47', '#999999'],
    	    interpolateNulls: false,
    	    vAxis: {format: '#,##0.000'}
    	  };

        var chart = new google.visualization.Histogram(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>  -->
<%
lcl_xBar=0.0;   lcl_rBar=0.0;   specWidth=0.0;   cp=0.0;   cpk_uSL=0.0; 
}
%>




































 
			 
			
			
			<!-- <div id="main" style="height: 500px;">
				<div style="width: 100%; float: left; height: 500px;">
					<span id="ajaxData">
					 
					</span>
				</div>
			</div> -->
		</div>
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%> 
	
	<script src='dist/rome.js'></script>
<script src='example/example.js'></script>
</body>
</html>