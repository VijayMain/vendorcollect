<%
int uid = Integer.parseInt(session.getAttribute("uid").toString()), 
is_cust = Integer.parseInt(session.getAttribute("is_cust").toString());
String uname = session.getAttribute("username").toString(), 
access = session.getAttribute("access").toString(), 
vendor_Code = session.getAttribute("vendor_Code").toString();
try{ 
%>
<script>
function didYouCheck() {
	alert("Did you check availability in SAP...?");	
}
</script>
<div id="menu" style="font-size: 16px; font-family: Arial; text-align: right;">
				
				<%
				if(is_cust==0){
				%>
				<a href="Home.jsp"><strong>Home</strong></a> &nbsp;&nbsp; 
				<%
				}
				%>
				<div class="dropdown" style="cursor: pointer; font-family: Arial;">
				<strong style="color: white; font-size: 13px"><a href="Vendor_Summary.jsp"><strong>Upload Summary</strong></a></strong> 
				<div class="dropdown-content"> 
				<a href="SPC_Details.jsp"><strong>SPC Details</strong></a>
					<%
						if(access.equalsIgnoreCase("FULL") && is_cust==0){
					%> 
					<a href="ImportFile.jsp"><strong>Upload Master</strong></a>
					<a href="Config_Disp.jsp"><strong>Display Config</strong></a> 
				<%
						}  
				 %>		
				</div>
					 
				</div>
				<a href="Logout.jsp">&nbsp;&nbsp; <strong>LogOut (<%=uname%>) </strong></a>
			</div>
		<%
		}catch(Exception e){
			e.printStackTrace();
		}
		%>	