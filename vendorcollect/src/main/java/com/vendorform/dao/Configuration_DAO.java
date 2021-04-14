package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletResponse;

import com.vendorform.vo.Configuration_vo;

public class Configuration_DAO {

	public void rejectAll(Configuration_vo vo, HttpServletResponse response) {
		try { 
		// ****************************************************************************************************************
		java.util.Date date = null;
		java.sql.Timestamp timeStamp = null;
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(new Date());
		java.sql.Date dt = new java.sql.Date(calendar.getTimeInMillis());
		java.sql.Time sqlTime=new java.sql.Time(calendar.getTime().getTime());
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		date = simpleDateFormat.parse(dt.toString()+" "+sqlTime.toString());
		timeStamp = new java.sql.Timestamp(date.getTime());
		Connection con = Connection_Utility.getConnectionMaster();
		// ****************************************************************************************************************
		String disp_query = "";
		int upCnt=0, enable_cnt = 0;
		PreparedStatement ps_upload = null;
		
		if(vo.getYes_no().equalsIgnoreCase("yes")){
			enable_cnt=0;
		}else{
			enable_cnt=1;
		}
	 
		if (vo.getVendor_Code().equalsIgnoreCase("all")) {
			disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where datetime_sheet between '"
					+ vo.getDate_from()
					+ "' and '"
					+ vo.getDate_to()
					+ "' and result like '%REJECT%'";
			ps_upload = con.prepareStatement(disp_query);
			ps_upload.setInt(1, enable_cnt);
			ps_upload.setString(2, vo.getName());
			ps_upload.setTimestamp(3, timeStamp);
			upCnt = ps_upload.executeUpdate();
			if(upCnt>0){
				response.sendRedirect("Config_Disp.jsp?success='Done........'");
			}
		} else {
			disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where datetime_sheet between '"
					+ vo.getDate_from()
					+ "' and '"
					+ vo.getDate_to()
					+ "' and vendor_code= '"
					+ vo.getVendor_Code()
					+ "' and result like '%REJECT%'";
			ps_upload = con.prepareStatement(disp_query);
			ps_upload.setInt(1, enable_cnt);
			ps_upload.setString(2, vo.getName());
			ps_upload.setTimestamp(3, timeStamp);
			upCnt = ps_upload.executeUpdate();
			if(upCnt>0){
				response.sendRedirect("Config_Disp.jsp?success='Done........'");
			}
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void rejectAllSelected(Configuration_vo vo, HttpServletResponse response) {
		try {
		
		// ****************************************************************************************************************
				java.util.Date date = null;
				java.sql.Timestamp timeStamp = null;
				Calendar calendar=Calendar.getInstance();
				calendar.setTime(new Date());
				java.sql.Date dt = new java.sql.Date(calendar.getTimeInMillis());
				java.sql.Time sqlTime=new java.sql.Time(calendar.getTime().getTime());
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				date = simpleDateFormat.parse(dt.toString()+" "+sqlTime.toString());
				timeStamp = new java.sql.Timestamp(date.getTime());
				Connection con = Connection_Utility.getConnectionMaster();
		// ****************************************************************************************************************
		// ****************************************************************************************************************
		String disp_query = "";
		int upCnt=0, enable_cnt = 0;
		PreparedStatement ps_upload = null; 
		StringBuilder sb = new StringBuilder();
		for (int p = 0; p < vo.getAll_SelecetdSet().size(); p++) {
		
		disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where id=" + Integer.valueOf(vo.getAll_SelecetdSet().get(p).toString());
		ps_upload = con.prepareStatement(disp_query);
		ps_upload.setInt(1, enable_cnt);
		ps_upload.setString(2, vo.getName());
		ps_upload.setTimestamp(3, timeStamp);
		upCnt = ps_upload.executeUpdate();  
		sb.append(vo.getAll_SelecetdSet().get(p).toString());
		sb.append(",");
		}
		//System.out.println("Print data = " + sb.toString());
		sb.deleteCharAt(sb.length()-1);
		//System.out.println("Print data 22 = " + sb.toString());
		// *************************************************************************************************************
				// ******************************************** For Enable disabled ******************************************** 
				// *************************************************************************************************************
				
				if (vo.getVendor_Code().equalsIgnoreCase("all")) {
					disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where datetime_sheet between '"
							+ vo.getDate_from()
							+ "' and '"
							+ vo.getDate_to()
							+ "' and id not in ("+sb.toString()+")";
					ps_upload = con.prepareStatement(disp_query);
					ps_upload.setInt(1, 1);
					ps_upload.setString(2, vo.getName());
					ps_upload.setTimestamp(3, timeStamp);
					upCnt = ps_upload.executeUpdate();
					 
				} else {
					disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where datetime_sheet between '"
							+ vo.getDate_from()
							+ "' and '"
							+ vo.getDate_to()
							+ "' and vendor_code= '"
							+ vo.getVendor_Code()
							+ "' and id not in ("+sb.toString()+")";
					
					ps_upload = con.prepareStatement(disp_query);
					ps_upload.setInt(1, 1);
					ps_upload.setString(2, vo.getName());
					ps_upload.setTimestamp(3, timeStamp);
					upCnt = ps_upload.executeUpdate();
					
				} 
		
		
		
		
	   
		// ****************************************************************************************************************
		// ****************************** **********************************************************************************		
		if(upCnt>0){
			response.sendRedirect("Config_Disp.jsp?success='Done........'");
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//*********************************************************************************************************************
	//  If all columns set to null === >
	//*********************************************************************************************************************
	public void rejectAllSelected_Blank(Configuration_vo vo,
			HttpServletResponse response) {
		try {
			
			Connection con = Connection_Utility.getConnectionMaster();
			// ****************************************************************************************************************
			java.util.Date date = null;
			java.sql.Timestamp timeStamp = null;
			Calendar calendar=Calendar.getInstance();
			calendar.setTime(new Date());
			java.sql.Date dt = new java.sql.Date(calendar.getTimeInMillis());
			java.sql.Time sqlTime=new java.sql.Time(calendar.getTime().getTime());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			date = simpleDateFormat.parse(dt.toString()+" "+sqlTime.toString());
			timeStamp = new java.sql.Timestamp(date.getTime()); 
			// ****************************************************************************************************************
			String disp_query = "";
			int upCnt=0;
			PreparedStatement ps_upload = null;
			if (vo.getVendor_Code().equalsIgnoreCase("all")) {
				disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where datetime_sheet between '" + vo.getDate_from() + "' and '" + vo.getDate_to() + "'";
				ps_upload = con.prepareStatement(disp_query);
				ps_upload.setInt(1, 1);
				ps_upload.setString(2, vo.getName());
				ps_upload.setTimestamp(3, timeStamp);
				upCnt = ps_upload.executeUpdate();
				 
				//System.out.println("in loop 1 == " + vo.getDate_from() + " = " + vo.getDate_to() + " cnt = " + upCnt);
				if(upCnt>0){
					response.sendRedirect("Config_Disp.jsp?success='Done........'");
				}
			} else {
				disp_query = "update baker_summary set enable=?,changed_by=?,changed_date=? where datetime_sheet between '"
						+ vo.getDate_from()
						+ "' and '"
						+ vo.getDate_to()
						+ "' and vendor_code= '"
						+ vo.getVendor_Code()
						+ "'";
				ps_upload = con.prepareStatement(disp_query);
				ps_upload.setInt(1, 1);
				ps_upload.setString(2, vo.getName());
				ps_upload.setTimestamp(3, timeStamp);
				upCnt = ps_upload.executeUpdate(); 
				//System.out.println("in loop 2 == ");
				if(upCnt>0){
					response.sendRedirect("Config_Disp.jsp?success='Done........'");
				}
			} 
			/*
				 * if(upCnt>0){ response.sendRedirect("Config_Disp.jsp?success='Done........'");
				 * }
				 */
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}