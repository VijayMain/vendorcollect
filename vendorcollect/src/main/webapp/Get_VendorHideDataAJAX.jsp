<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get data</title>
</head>
<body>
<%
try{
 	String fromDate = request.getParameter("fromDate");
 	String toDate = request.getParameter("toDate");
 	Connection conMaster = Connection_Utility.getConnectionMaster(); 	
 	String datafor = request.getParameter("datafor");
 	
 	
 	
 	// System.out.println("DAta = " + fromDate + " = " + toDate);
 	
 	/* SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
    Date fromParseDate = dateFormat.parse(fromDate);
    Timestamp timestampfrom = new java.sql.Timestamp(fromParseDate.getTime()); 
     
    Date parsedtoDate = dateFormat.parse(toDate);
    Timestamp timestampto = new java.sql.Timestamp(parsedtoDate.getTime());
 	
 	System.out.println("date = = " +timestampfrom+ " = =" + timestampto); */
 	
 	// ------------------------- Next Date to run between query ----------------------------------------------- 
 	/* Date date = new SimpleDateFormat("yyyy-MM-dd").parse(toDate);
 	Calendar c1 = Calendar.getInstance();
    c1.setTime(date);
	c1.add(Calendar.DATE, 1); 
	Date currentDatePlusOne = c1.getTime();
	toDate= new SimpleDateFormat("yyyy-MM-dd").format(currentDatePlusOne);  
	 
	// -------------------------------------------------------------------------------------------------------- 
 	Date datesql_from = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
	Timestamp timeStampFromDate = new Timestamp(datesql_from.getTime());
	Date datesql_to = new SimpleDateFormat("yyyy-MM-dd").parse(toDate);
	Timestamp timeStampToDate = new Timestamp(datesql_to.getTime()); */
	// -------------------------------------------------------------------------------------------------------- 
	//System.out.println("vendor = " + datafor);
%> 
<span id="ajaxData">
<%
String disp_query = "";
if (datafor.equalsIgnoreCase("all")) {
	disp_query = "SELECT * FROM baker_summary where datetime_sheet between '"
			+ fromDate
			+ "' and '"
			+ toDate
			+ "'";
} else {
	disp_query = "SELECT * FROM baker_summary where datetime_sheet between '"
			+ fromDate
			+ "' and '"
			+ toDate
			+ "' and vendor_code= '"
			+ datafor
			+ "'";
}
%>
<input type="hidden" name="date_from" id="date_from" value="<%=fromDate%>"/>
<input type="hidden" name="date_to" id="date_to" value="<%=toDate%>"/>
<input type="hidden" name="vendor_Code" id="vendor_Code" value="<%=datafor%>"/> 
<%-- <input type="hidden" name="yes_no" id="yes_no" value="<%= request.getParameter("yes_no")%>"/> --%>
						<table class="tftable" style="width: 100%;">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold; text-align: center;">
								<%
								PreparedStatement ps_head = conMaster.prepareStatement("SELECT * FROM Baker_HeaderData where enable=1");
								ResultSet rs_head = ps_head.executeQuery();
								while(rs_head.next()){
								%>
								<td><%=rs_head.getString("parameter") %> 
								<%if(!rs_head.getString("range_from").equalsIgnoreCase("")){ %><br/>
								[<%=rs_head.getString("range_from") %>/<%=rs_head.getString("range_to") %>]  <%} %></td> 
								<% 
								}
								%> 
								<td>vendor_name</td> 
								<td>userName</td>
								<td>Hide</td>
							</tr>
							<% 
									PreparedStatement ps_summary = conMaster.prepareStatement(disp_query);
									ResultSet rs_summary = ps_summary.executeQuery();
									while (rs_summary.next()) {
							%>
							<tr>
								<%-- <td><%=rs_summary.getString("sr1")%></td> --%>
								<td><%=rs_summary.getString("serial_no")%></td>
								<td><%=rs_summary.getString("datetime_sheet")%></td>
								<td><%=rs_summary.getString("batch")%></td>
								<td><%=rs_summary.getString("machine")%></td>
								<td><%=rs_summary.getString("operator")%></td>
								<td><%=rs_summary.getString("top_id")%></td>
								<td><%=rs_summary.getString("bot_id")%></td>
								<td><%=rs_summary.getString("top_oval")%></td>
								<td><%=rs_summary.getString("bot_oval")%></td>
								<td><%=rs_summary.getString("taper")%></td>
								<td><%=rs_summary.getString("od")%></td>
								<td><%=rs_summary.getString("mh_ht")%></td>
								<td><%=rs_summary.getString("parality")%></td>
								<td><%=rs_summary.getString("th_ht")%></td>
								<td>
								<%
								if(rs_summary.getString("result").equalsIgnoreCase("ACCEPT")){
								%>
								<strong style="background-color: green;color: white;"><%=rs_summary.getString("result")%></strong>   
								<%
								}else{
								%>
								<strong style="background-color: red;color: white;"><%=rs_summary.getString("result")%></strong>   
								<%	
								}
								%>
								</td>
								<td><%=rs_summary.getString("vendor_name")%></td>
								<td><%=rs_summary.getString("userName")%></td>
								<td>
								<%
								int define_chk=rs_summary.getInt("enable"); 
								if(define_chk==1){
								%>
								<input type="checkbox" name="hideMe" id="hideMe" style="border-style: solid;" value="<%=rs_summary.getInt("id")%>"/> 
								<%
								}else{
								%>
								<input type="checkbox" name="hideMe" id="hideMe" checked="checked" style="border-style: solid;" value="<%=rs_summary.getInt("id")%>"/>
								<%	
								}
								%>
								</td>
							</tr>
							<%
								}
							%>
					</table>
</span>
<%
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>