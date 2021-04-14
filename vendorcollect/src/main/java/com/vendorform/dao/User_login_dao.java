package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class User_login_dao {

	public void login_user(HttpSession session, String name, String pass,
			HttpServletResponse response) {
		try {
			Connection con =  Connection_Utility.getConnectionMaster();
			/*Connection con =  Connection_Utility.getLocalUserConnection();*/
			boolean flag = false;
			 
			PreparedStatement ps=null, ps1 =null;
			ResultSet rs =null, rs1 =null;
			String dept_name = "";
			
			ps = con.prepareStatement("select * from baker_user where username='"+ name +"' and password='"+pass+"' and enable=1");
			rs  = ps.executeQuery();
			while(rs.next()){ 
					flag=true;
					session.setAttribute("uid", rs.getInt("id"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("username", rs.getString("username"));
					session.setMaxInactiveInterval(-1); 
					session.setAttribute("access", rs.getString("access"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("vend_custName", rs.getString("vend_custName"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("vendor_Code", rs.getString("vendor_Code"));
					session.setMaxInactiveInterval(-1);
					session.setAttribute("is_cust", rs.getInt("is_cust"));
					session.setMaxInactiveInterval(-1); 
					
					if(rs.getInt("is_cust")==0){
						response.sendRedirect("Home.jsp");
					}else{
						response.sendRedirect("Vendor_Summary.jsp");
					}
			}
			if(flag==false){
				String error = "Invalid login details, Please try again....";
				response.sendRedirect("Login.jsp?error="+error);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}