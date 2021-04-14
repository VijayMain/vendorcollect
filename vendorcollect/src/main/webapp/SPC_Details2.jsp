<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
 
 
  <script src="js/jquery.min.js"></script>
  <script src="js/raphael-min.js"></script>
  <script src="js/morris.js"></script>
  <script src="js/prettify.min.js"></script>
  <script src="lib/example.js"></script>
  <link rel="stylesheet" href="lib/example.css"/>
  <link rel="stylesheet" href="js/prettify.min.css"/>
  <link rel="stylesheet" href="js/morris.css"/>
 <link rel="stylesheet" type="text/css" href="css/style1.css" />
<link rel="stylesheet" type="text/css" href="css/style2.css" />
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
			Date date = new Date();
			String toDate = new SimpleDateFormat("dd/MM/yyyy").format(date);

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
				
				
				flagView=true;
				//System.out.println("There are values in the arraylist" + xLarge + " = " + xSmall + " =" + xAvg + " = " + xRange + " = " + parameter);
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
			<div style="text-align: center;">
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
					<td>
 	<input id='dt' class='input' name="fromDate" id="fromDate" value="<%=timeStampFromDate%>"/>
 					</td>
					<td>
	<input id='dt1' class='input' name="toDate" id="toDate" value="<%=timeStampToDate%>"/>  
					</td>					
					<td>
					<select  class='input' id="datafor" name="datafor" style="font-weight: bold;">
								<%
									if (access.equalsIgnoreCase("FULL")) {
								%>
								<option value="all">- - - - - ALL Vendors - - - - -</option>
								<%
									String query = "SELECT  distinct site_name,sapcode  FROM Baker_site where enable=1";
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
									String query = "SELECT *  FROM Baker_HeaderData where range_from!='' and range_to!=''";
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
%>
<table class="tftable" style="width: 60%;">
<tr style="background-color: green;color:white; font-weight: bold;">
						<td colspan="7"><strong style="font-size: 20px;">Parameter : <%=parameter.get(0).toString() %></strong> </td>
						<td colspan="4" align="left"><strong style="font-size: 20px;"><%=parameter.get(1).toString() %> - <%=parameter.get(2).toString() %></strong></td> 
					</tr>
					<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
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











<!-- <div style="width: 50%">
X Chart
</div> -->

<div style="width: 50%">
<h1><%=parameter.get(0).toString() %> [ <%=parameter.get(1).toString() %> - <%=parameter.get(2).toString() %> ]</h1>
<div id="graph">
</div>

<pre id="code" class="prettyprint linenums" style="visibility: hidden;"> 

var month_data = [
 
 <%
Double valCheck =0.00;
 for(int i=0;i<10;i++){
	 valCheck = Double.parseDouble(xAvg.get(i).toString());
 %>
{"Sample": "<%=i+1 %>", "Value": <%=valCheck %>},
<%
valCheck=0.0;
}
%> 
  <!-- {"Sample": "1", "Value": 229.20},
  {"Sample": "2", "Value": 239.29},
  {"Sample": "3", "Value": 259.28},
  {"Sample": "4", "Value": 229.21},
  {"Sample": "5", "Value": 229.29},
  {"Sample": "6", "Value": 269.24},
  {"Sample": "7", "Value": 229.23},
  {"Sample": "8", "Value": 279.20},
  {"Sample": "9", "Value": 229.24},
  {"Sample": "10", "Value":229.20} 

 -->

];


Morris.Line({
  element: 'graph',
  data: month_data,
  xkey: 'Sample',
  ykeys: ['Value', 'Double'],
  labels: ['Value', 'X Chart'],
  smooth: true
});
</pre>

</div>
<%
}
%>

















			</div>
			
			 
			
			
			<div id="main" style="height: 500px;">
				<div style="width: 100%; float: left; height: 500px;">
					<span id="ajaxData">
					 
					</span>
				</div>
			</div>
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