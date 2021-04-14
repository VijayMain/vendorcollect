package com.vendorform.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.DateFormat;

import com.vendorform.vo.ImportMaster_VO;

public class ImportMaster_DAO {
	public void attach_File(HttpServletResponse response, ImportMaster_VO bean,
			HttpSession session) {
		try {
			// *******************************************************************************************************************************************************************
			java.util.Date date = null;
			java.sql.Timestamp timeStamp = null;
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new Date());
			java.sql.Date dt = new java.sql.Date(calendar.getTimeInMillis());
			java.sql.Time sqlTime = new java.sql.Time(calendar.getTime()
					.getTime());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			SimpleDateFormat cellDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			date = simpleDateFormat.parse(dt.toString() + " "
					+ sqlTime.toString());
			timeStamp = new java.sql.Timestamp(date.getTime());

			// *******************************************************************************************************************************************************************

			Connection con = Connection_Utility.getConnectionMaster();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			String uname = session.getAttribute("username").toString();
			String statusRecord = "";

			String datafor = bean.getDatafor();
			String data_vendName = "";
			PreparedStatement ps_vend = con
					.prepareStatement("SELECT * FROM Baker_site where sapcode='"
							+ datafor + "'");
			ResultSet rs_vend = ps_vend.executeQuery();
			while (rs_vend.next()) {
				data_vendName = rs_vend.getString("site_name");
			}

			PreparedStatement ps = con
					.prepareStatement("insert into baker_fileupload (filename,attachment,datetime)values(?,?,?)");
			ps.setString(1, bean.getFileName());
			ps.setBlob(2, bean.getFile_blob());
			ps.setTimestamp(3, timeStamp);
			int up = ps.executeUpdate();
			if (up > 0) {
				/* ____________________________________________________________________________________________________ */
				int ct = 0, val = 0;
				PreparedStatement ps_ct = con
						.prepareStatement("select MAX(id) as maxid from baker_fileupload");
				ResultSet rs_ct = ps_ct.executeQuery();
				while (rs_ct.next()) {
					ct = rs_ct.getInt("maxid");
				}
				PreparedStatement ps_blb = con
						.prepareStatement("select * from baker_fileupload where id="
								+ ct);
				ResultSet rs_blb = ps_blb.executeQuery();
				while (rs_blb.next()) {
					Blob blob = rs_blb.getBlob("attachment");
					InputStream in = blob.getBinaryStream();
					ArrayList alistFile = new ArrayList();
					File folder = new File("C:/reportxls");
					File[] listOfFiles = folder.listFiles();
					String listname = "";
					val = listOfFiles.length + 1;
					File exlFile = new File("C:/reportxls/DataSAPVendor" + val
							+ ".xls");
					OutputStream out = new FileOutputStream(exlFile);
					byte[] buff = new byte[4096]; // how much of the blob to
													// read/write at a time
					int len = 0;
					while ((len = in.read(buff)) != -1) {
						out.write(buff, 0, len);
					}
				}

				/*
				 * ps_ct = con.prepareStatement(
				 * "delete FROM [SAPMaster].[dbo].[fileupload]  where id=" +
				 * ct); int upt = ps_ct.executeUpdate();
				 */

				String EXCEL_FILE_LOCATION = "C:/reportxls/DataSAPVendor" + val + ".xls";
				Workbook wrk1 = Workbook.getWorkbook(new File(
						EXCEL_FILE_LOCATION));
				/* ____________________________________________________________________________________________________ */
				Sheet sheet1 = wrk1.getSheet(0);
				int rows = sheet1.getRows();
				int cols = sheet1.getColumns();
				PreparedStatement ps_check = null, ps_upload = null;
				ResultSet rs_check = null, rs_upload = null;
				int cnt = 0;
				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// -------------------------------------------------------------------------
				// Master Configuration Template Upload
				// ------------------------------------------------------
				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				if (datafor.equalsIgnoreCase("1")) {
					for (int i = 1; i < rows; i++) {
						Cell colArow1 = sheet1.getCell(0, i);
						Cell colArow2 = sheet1.getCell(1, i);
						Cell colArow3 = sheet1.getCell(2, i);
						Cell colArow4 = sheet1.getCell(3, i);
						Cell colArow5 = sheet1.getCell(4, i);
						Cell colArow6 = sheet1.getCell(5, i);
						Cell colArow7 = sheet1.getCell(6, i);
						Cell colArow8 = sheet1.getCell(7, i);
						Cell colArow9 = sheet1.getCell(8, i);
						Cell colArow10 = sheet1.getCell(9, i);

						String str_colArow1 = colArow1.getContents();
						String str_colArow2 = colArow2.getContents();
						String str_colArow3 = colArow3.getContents();
						String str_colArow4 = colArow4.getContents();
						String str_colArow5 = colArow5.getContents();
						String str_colArow6 = colArow6.getContents();
						String str_colArow7 = colArow7.getContents();
						String str_colArow8 = colArow8.getContents();
						String str_colArow9 = colArow9.getContents();
						String str_colArow10 = colArow10.getContents();

						String query = "select * from Baker_HeaderData where parameter ='"
								+ str_colArow1
								+ "' and range_from='"
								+ str_colArow2
								+ "' and range_to='"
								+ str_colArow3
								+ "' and position='"
								+ str_colArow4
								+ "' and vendor='"
								+ str_colArow5
								+ "' and vendor_SAPCode='"
								+ str_colArow6
								+ "' and part_name='"
								+ str_colArow7
								+ "' and enable=1";

						ps_check = con.prepareStatement(query);
						rs_check = ps_check.executeQuery();
						if (!rs_check.next()) {
							ps_upload = con.prepareStatement("insert into  Baker_HeaderData(parameter,range_from,range_to,position,vendor,vendor_SAPCode,part_name,enable,created_by,datetime,upload_date,creator)values(?,?,?,?,?,?,?,?,?,?,?,?)");
							ps_upload.setString(1, str_colArow1);
							ps_upload.setString(2, str_colArow2);
							ps_upload.setString(3, str_colArow3);
							ps_upload.setString(4, str_colArow4);
							ps_upload.setString(5, str_colArow5); 
							ps_upload.setString(6, str_colArow6); 
							ps_upload.setString(7, str_colArow7);
							ps_upload.setInt(8, Integer.valueOf(str_colArow8));
							ps_upload.setString(9, str_colArow9);
							ps_upload.setString(10, str_colArow10);
							ps_upload.setTimestamp(11, timeStamp);
							ps_upload.setString(12, uname);

							cnt = ps_upload.executeUpdate();
							statusRecord = "Import Successful....";
						} else {
							statusRecord = "Already Available....";
						}
					}

					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					// -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				} else {

					for (int i = 3; i < rows; i++) {
						Cell colArow1 = sheet1.getCell(0, i);
						Cell colArow2 = sheet1.getCell(1, i);
						Cell colArow3 = sheet1.getCell(2, i);
						
						String value ="";
						if (colArow3.getType() == CellType.DATE) {
						DateCell dCell = (DateCell) colArow3;
						TimeZone gmtZone = TimeZone.getTimeZone("GMT"); 
						cellDateFormat.setTimeZone(gmtZone);
						value = cellDateFormat.format(dCell.getDate());
						} 
						
						Cell colArow4 = sheet1.getCell(3, i);
						Cell colArow5 = sheet1.getCell(4, i);
						Cell colArow6 = sheet1.getCell(5, i);
						Cell colArow7 = sheet1.getCell(6, i);
						Cell colArow8 = sheet1.getCell(7, i);
						Cell colArow9 = sheet1.getCell(8, i);
						Cell colArow10 = sheet1.getCell(9, i);
						Cell colArow11 = sheet1.getCell(10, i);
						Cell colArow12 = sheet1.getCell(11, i);
						Cell colArow13 = sheet1.getCell(12, i);

						Cell colArow14 = sheet1.getCell(13, i);
						Cell colArow15 = sheet1.getCell(14, i);
						Cell colArow16 = sheet1.getCell(15, i);

						String str_colArow1 = colArow1.getContents();
						String str_colArow2 = colArow2.getContents();
						String str_colArow3 = value;
						String str_colArow4 = colArow4.getContents();
						String str_colArow5 = colArow5.getContents();
						String str_colArow6 = colArow6.getContents();
						String str_colArow7 = colArow7.getContents();
						String str_colArow8 = colArow8.getContents();
						String str_colArow9 = colArow9.getContents();

						String str_colArow10 = colArow10.getContents();
						String str_colArow11 = colArow11.getContents();
						String str_colArow12 = colArow12.getContents();
						String str_colArow13 = colArow13.getContents();
						String str_colArow14 = colArow14.getContents();
						String str_colArow15 = colArow15.getContents();
						String str_colArow16 = colArow16.getContents();
						
 						value="";
						ps_upload = con.prepareStatement("insert into  baker_summary(sr1,serial_no,datetime_sheet,batch,machine,operator,top_id,bot_id,top_oval,"
										+ "bot_oval,taper,od,mh_ht,parality,th_ht,result,datetimeRegister,vendor_code,vendor_name,enable,userName,uid)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						ps_upload.setString(1, str_colArow1);
						ps_upload.setString(2, str_colArow2);
						ps_upload.setString(3, str_colArow3);
						ps_upload.setString(4, str_colArow4);
						ps_upload.setString(5, str_colArow5);
						ps_upload.setString(6, str_colArow6);
						ps_upload.setString(7, str_colArow7);
						ps_upload.setString(8, str_colArow8);
						ps_upload.setString(9, str_colArow9);
						ps_upload.setString(10, str_colArow10);
						ps_upload.setString(11, str_colArow11);
						ps_upload.setString(12, str_colArow12);
						ps_upload.setString(13, str_colArow13);
						ps_upload.setString(14, str_colArow14);
						ps_upload.setString(15, str_colArow15);
						ps_upload.setString(16, str_colArow16);
						ps_upload.setTimestamp(17, timeStamp);
						ps_upload.setString(18, datafor);
						ps_upload.setString(19, data_vendName);
						ps_upload.setInt(20, 1);
						ps_upload.setString(21, uname);
						ps_upload.setInt(22, uid);

						cnt = ps_upload.executeUpdate();
						statusRecord = "Import Successful....";
					}
				}
				// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				/* __________________________________________________________________________________________________________________________________________________________________ */
				response.sendRedirect("Home.jsp?success=" + statusRecord);
			} else {
				response.sendRedirect("Home.jsp?success=" + statusRecord);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
