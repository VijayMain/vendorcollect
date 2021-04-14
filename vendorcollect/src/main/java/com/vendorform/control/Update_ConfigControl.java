package com.vendorform.control;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vendorform.dao.Configuration_DAO;
import com.vendorform.vo.Configuration_vo;
 

@WebServlet("/Update_ConfigControl")
public class Update_ConfigControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try { 
			Configuration_DAO dao = new Configuration_DAO();
			Configuration_vo vo = new Configuration_vo();
			HttpSession session = request.getSession();
			String uname = session.getAttribute("username").toString();
			String access = session.getAttribute("access").toString();
			ArrayList all_SelecetdSet = new ArrayList();
			 // ****************************************************************************************************
			 // ********************************** All from Selected Date ******************************************
			 // ****************************************************************************************************
			if(request.getParameter("yes_no")!=null){
				vo.setDate_from(request.getParameter("date_from"));
				vo.setDate_to(request.getParameter("date_to"));
				vo.setYes_no(request.getParameter("yes_no"));
				vo.setVendor_Code(request.getParameter("vendor_Code"));
				vo.setName(uname);
				vo.setAccess(access);
				dao.rejectAll(vo, response); 
			 // ****************************************************************************************************
			 // ****************************************************************************************************
			}else{
		     // ****************************************************************************************************
			 // ***************************** Selected Rejected Columns ********************************************
		     // ****************************************************************************************************
			 
			if(request.getParameterValues("hideMe")!=null){
			String[] checkedIds = request.getParameterValues("hideMe");
	        for (int i=0; i<checkedIds.length; i++)
	        {
	            //System.out.println(checkedIds[i].toString());
	            all_SelecetdSet.add(checkedIds[i].toString());
	        }
	        
	        
	        vo.setDate_from(request.getParameter("date_from"));
			vo.setDate_to(request.getParameter("date_to"));
			vo.setYes_no(request.getParameter("yes_no"));
			vo.setVendor_Code(request.getParameter("vendor_Code"));
			vo.setName(uname);
			vo.setAccess(access);
			
	        vo.setAll_SelecetdSet(all_SelecetdSet);
	         
	        /*System.out.println("data from hide me =  " + request.getParameter("date_from"));
			System.out.println("data to =  " + request.getParameter("date_to"));
			System.out.println("data =  " + request.getParameter("yes_no"));*/
			dao.rejectAllSelected(vo, response);
	        
			}else{
				
				// ****************************************************************************************************
				 // ***************************** If all blank Selected ********************************************
			     // ****************************************************************************************************
				  
		        vo.setDate_from(request.getParameter("date_from"));
				vo.setDate_to(request.getParameter("date_to"));
				vo.setYes_no(request.getParameter("yes_no"));
				vo.setVendor_Code(request.getParameter("vendor_Code"));
				vo.setName(uname);  
				dao.rejectAllSelected_Blank(vo, response);
				 
				// response.sendRedirect("Config_Disp.jsp?success='No Data Selected to Change......'");
			}
			
			// ****************************************************************************************************
			// ****************************************************************************************************
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
