package com.vendorform.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vendorform.vo.ImportMaster_VO;

import it.muthagroup.connectionUtility.Connection_Utility;

public class SPC_DataDAO {

	public void generateGraph(ImportMaster_VO vo, ArrayList idList, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
		try {
			DecimalFormat df = new DecimalFormat("00.000");
			String column="";
			int ct=0,ct1=0,ct2=0,ct3=0,ct4=0;
			Connection conMaster = Connection_Utility.getConnectionMaster(); 	
			PreparedStatement ps_check = null;
			ResultSet rs_check=null;
			
			ArrayList datafor=new ArrayList();
			datafor.add(vo.getDatafor());
			
			ArrayList date_pass=new ArrayList();
			date_pass.add(vo.getFromDate());
			date_pass.add(vo.getToDate());
			
			ArrayList row1=new ArrayList();
			ArrayList row2=new ArrayList();
			ArrayList row3=new ArrayList();
			ArrayList row4=new ArrayList();
			ArrayList row5=new ArrayList();
			
			
			
			ArrayList verVal1=new ArrayList();
			ArrayList verVal2=new ArrayList();
			ArrayList verVal3=new ArrayList();
			ArrayList verVal4=new ArrayList();
			ArrayList verVal5=new ArrayList();
			ArrayList verVal6=new ArrayList();
			ArrayList verVal7=new ArrayList();
			ArrayList verVal8=new ArrayList();
			ArrayList verVal9=new ArrayList();
			ArrayList verVal10=new ArrayList();
			
			ArrayList xLarge=new ArrayList();
			ArrayList xSmall=new ArrayList();
			ArrayList xRange=new ArrayList();
			ArrayList xAvg=new ArrayList();
			
			 for (int i = 0; i < 10; i++) { 		
				row1.add(0);
				row2.add(0);
				row3.add(0);
				row4.add(0);
				row5.add(0);
			}
			 
			
			if (vo.getParameter() == 6) {
				column="top_id";
			}
			if (vo.getParameter() == 7) {
				column="bot_id";
			}
			if (vo.getParameter() == 8) {
				column="top_oval";
			}
			if (vo.getParameter() == 9) {
				column="bot_oval";
			} 
			if (vo.getParameter() == 10) {
				column="taper";
			}
			if (vo.getParameter() == 11) {
				column="od";
			}
			if (vo.getParameter() == 12) {
				column="mh_ht";
			}
			if (vo.getParameter() == 13) {
				column="parality";
			}
			if (vo.getParameter() == 14) {
				column="th_ht";
			}
			  
			
			 for (int counter = 0; counter < idList.size(); counter++) { 		      
		         if(counter<10 && counter>=0) {
		        	 ps_check = conMaster.prepareStatement("SELECT *  FROM baker_summary where id="+Integer.valueOf(idList.get(counter).toString()));
		        	 rs_check = ps_check.executeQuery();
		        	 while (rs_check.next()) {
		        		 row1.set(ct, Double.valueOf(rs_check.getString(column)));	
					} 
		        	 ct++;
		         }
		         if(counter<20 && counter>=10) {
		        	 ps_check = conMaster.prepareStatement("SELECT *  FROM baker_summary where id="+Integer.valueOf(idList.get(counter).toString()));
		        	 rs_check = ps_check.executeQuery();
		        	 while (rs_check.next()) {
		        		 row2.set(ct1, Double.valueOf(rs_check.getString(column)));	
					} 
		        	 ct1++;
		         }
		         if(counter<30 && counter>=20) {
		        	 ps_check = conMaster.prepareStatement("SELECT *  FROM baker_summary where id="+Integer.valueOf(idList.get(counter).toString()));
		        	 rs_check = ps_check.executeQuery();
		        	 while (rs_check.next()) {
		        		 row3.set(ct2, Double.valueOf(rs_check.getString(column)));	
					} 
		        	 ct2++;
		         }
		         if(counter<40 && counter>=30) {
		        	 ps_check = conMaster.prepareStatement("SELECT *  FROM baker_summary where id="+Integer.valueOf(idList.get(counter).toString()));
		        	 rs_check = ps_check.executeQuery();
		        	 while (rs_check.next()) {
		        		 row4.set(ct3, Double.valueOf(rs_check.getString(column)));	
					} 
		        	 ct3++;
		         }
		         if(counter<50 && counter>=40) {
		        	 ps_check = conMaster.prepareStatement("SELECT *  FROM baker_summary where id="+Integer.valueOf(idList.get(counter).toString()));
		        	 rs_check = ps_check.executeQuery();
		        	 while (rs_check.next()) {
		        		 row5.set(ct4, Double.valueOf(rs_check.getString(column)));	
					} 
		        	 ct4++;
		         }
		          
		      }   
			
			// System.out.println(column +" = "+ row1 + " = " + row2 + " = "  + row3 + " = " + row4 + " = " + row5);
			 
			 /*********************************************************************************/
				/* to get Xlarge and X Min */
			 
				 verVal1.add(Double.valueOf(row1.get(0).toString()));
				 verVal1.add(Double.valueOf(row2.get(0).toString()));
				 verVal1.add(Double.valueOf(row3.get(0).toString()));
				 verVal1.add(Double.valueOf(row4.get(0).toString()));
				 verVal1.add(Double.valueOf(row5.get(0).toString()));
				 
				 verVal2.add(Double.valueOf(row1.get(1).toString()));
				 verVal2.add(Double.valueOf(row2.get(1).toString()));
				 verVal2.add(Double.valueOf(row3.get(1).toString()));
				 verVal2.add(Double.valueOf(row4.get(1).toString()));
				 verVal2.add(Double.valueOf(row5.get(1).toString()));
				 
				 verVal3.add(Double.valueOf(row1.get(2).toString()));
				 verVal3.add(Double.valueOf(row2.get(2).toString()));
				 verVal3.add(Double.valueOf(row3.get(2).toString()));
				 verVal3.add(Double.valueOf(row4.get(2).toString()));
				 verVal3.add(Double.valueOf(row5.get(2).toString()));
				 
				 
				 verVal4.add(Double.valueOf(row1.get(3).toString()));
				 verVal4.add(Double.valueOf(row2.get(3).toString()));
				 verVal4.add(Double.valueOf(row3.get(3).toString()));
				 verVal4.add(Double.valueOf(row4.get(3).toString()));
				 verVal4.add(Double.valueOf(row5.get(3).toString()));
				 
				 verVal5.add(Double.valueOf(row1.get(4).toString()));
				 verVal5.add(Double.valueOf(row2.get(4).toString()));
				 verVal5.add(Double.valueOf(row3.get(4).toString()));
				 verVal5.add(Double.valueOf(row4.get(4).toString()));
				 verVal5.add(Double.valueOf(row5.get(4).toString()));
				 
				 
				 verVal6.add(Double.valueOf(row1.get(5).toString()));
				 verVal6.add(Double.valueOf(row2.get(5).toString()));
				 verVal6.add(Double.valueOf(row3.get(5).toString()));
				 verVal6.add(Double.valueOf(row4.get(5).toString()));
				 verVal6.add(Double.valueOf(row5.get(5).toString()));
				 
				 
				 verVal7.add(Double.valueOf(row1.get(6).toString()));
				 verVal7.add(Double.valueOf(row2.get(6).toString()));
				 verVal7.add(Double.valueOf(row3.get(6).toString()));
				 verVal7.add(Double.valueOf(row4.get(6).toString()));
				 verVal7.add(Double.valueOf(row5.get(6).toString()));
				 
				 
				 verVal8.add(Double.valueOf(row1.get(7).toString()));
				 verVal8.add(Double.valueOf(row2.get(7).toString()));
				 verVal8.add(Double.valueOf(row3.get(7).toString()));
				 verVal8.add(Double.valueOf(row4.get(7).toString()));
				 verVal8.add(Double.valueOf(row5.get(7).toString()));
				 
				 
				 verVal9.add(Double.valueOf(row1.get(8).toString()));
				 verVal9.add(Double.valueOf(row2.get(8).toString()));
				 verVal9.add(Double.valueOf(row3.get(8).toString()));
				 verVal9.add(Double.valueOf(row4.get(8).toString()));
				 verVal9.add(Double.valueOf(row5.get(8).toString()));
				 
				 
				 verVal10.add(Double.valueOf(row1.get(9).toString()));
				 verVal10.add(Double.valueOf(row2.get(9).toString()));
				 verVal10.add(Double.valueOf(row3.get(9).toString()));
				 verVal10.add(Double.valueOf(row4.get(9).toString()));
				 verVal10.add(Double.valueOf(row5.get(9).toString()));
			 
			 //System.out.println(row1+ " =\n " + row2 + " =\n " + row3 + " =\n " + row4+ " =\n " + row5 + " \n\n");
			 //System.out.println(verVal1+" =\n " + verVal2 + " =\n " + verVal3 + "=\n" + verVal4 + " =\n " + verVal5 + " =\n " + verVal6+" =\n " + verVal7 + " =\n " + verVal8 + "=\n" + verVal9 + " =\n " + verVal10);
			 
			
				 xLarge.add((Double) Collections.max(verVal1));
				 xLarge.add((Double) Collections.max(verVal2));
				 xLarge.add((Double) Collections.max(verVal3));
				 xLarge.add((Double) Collections.max(verVal4));
				 xLarge.add((Double) Collections.max(verVal5));
				 xLarge.add((Double) Collections.max(verVal6));
				 xLarge.add((Double) Collections.max(verVal7));
				 xLarge.add((Double) Collections.max(verVal8));
				 xLarge.add((Double) Collections.max(verVal9));
				 xLarge.add((Double) Collections.max(verVal10));
				 
				 xSmall.add((Double) Collections.min(verVal1));
				 xSmall.add((Double) Collections.min(verVal2));
				 xSmall.add((Double) Collections.min(verVal3));
				 xSmall.add((Double) Collections.min(verVal4));
				 xSmall.add((Double) Collections.min(verVal5));
				 xSmall.add((Double) Collections.min(verVal6));
				 xSmall.add((Double) Collections.min(verVal7));
				 xSmall.add((Double) Collections.min(verVal8));
				 xSmall.add((Double) Collections.min(verVal9));
				 xSmall.add((Double) Collections.min(verVal10));
			
				 
				 
				 for(int i=0;i<10;i++) {
				 xRange.add(df.format(Double.valueOf(xLarge.get(i).toString()) - Double.valueOf(xSmall.get(i).toString())));
				 }
				 
				 
				 Double avgValue1=0.0, avgValue2=0.0, avgValue3=0.0,avgValue4=0.0,avgValue5=0.0,avgValue6=0.0,avgValue7=0.0,avgValue8=0.0,avgValue9=0.0,avgValue10=0.0;
				 for(int i=0;i<5;i++) {
					avgValue1 = avgValue1 + Double.valueOf(verVal1.get(i).toString());
					avgValue2 = avgValue2 + Double.valueOf(verVal2.get(i).toString());
					avgValue3 = avgValue3 + Double.valueOf(verVal3.get(i).toString());
					avgValue4 = avgValue4 + Double.valueOf(verVal4.get(i).toString());
					avgValue5 = avgValue5 + Double.valueOf(verVal5.get(i).toString());
					avgValue6 = avgValue6 + Double.valueOf(verVal6.get(i).toString());
					avgValue7 = avgValue7 + Double.valueOf(verVal7.get(i).toString());
					avgValue8 = avgValue8 + Double.valueOf(verVal8.get(i).toString());
					avgValue9 = avgValue9 + Double.valueOf(verVal9.get(i).toString());
					avgValue10 = avgValue10 + Double.valueOf(verVal10.get(i).toString());
				 }
				 
				 //System.out.println("XRange = " + xRange);
				 
				 xAvg.add(df.format(avgValue1/5));
				 xAvg.add(df.format(avgValue2/5));
				 xAvg.add(df.format(avgValue3/5));
				 xAvg.add(df.format(avgValue4/5));
				 xAvg.add(df.format(avgValue5/5));
				 xAvg.add(df.format(avgValue6/5));
				 xAvg.add(df.format(avgValue7/5));
				 xAvg.add(df.format(avgValue8/5));
				 xAvg.add(df.format(avgValue9/5));
				 xAvg.add(df.format(avgValue10/5));
				 
				 //System.out.println("X LArge = " + xLarge);
				 //System.out.println("X Small = " + xSmall);
				 //System.out.println("X Avg = " + xAvg);
				 
				 
				 ArrayList parameter = new ArrayList();
					
				 ps_check = conMaster.prepareStatement("SELECT *  FROM Baker_HeaderData where id="+vo.getParameter());
				 rs_check = ps_check.executeQuery();
				 while (rs_check.next()) {
					 parameter.add(rs_check.getString("parameter"));
					 parameter.add(rs_check.getString("range_from"));
					 parameter.add(rs_check.getString("range_to")); 
					 parameter.add(rs_check.getInt("id")); 
				}
				 
				 
			 /*********************************************************************************/
			 /*********************************************************************************/
			 /*********************************************************************************/
			 /*********************************************************************************/
				 RequestDispatcher rd = request.getRequestDispatcher("/SPC_Details.jsp");
					request.setAttribute("xLarge", xLarge);
					request.setAttribute("xSmall", xSmall);
					request.setAttribute("xAvg", xAvg);
					request.setAttribute("xRange", xRange);
					request.setAttribute("parameter", parameter);
					 
					request.setAttribute("row1", row1);
					request.setAttribute("row2", row2);
					request.setAttribute("row3", row3);
					request.setAttribute("row4", row4);
					request.setAttribute("row5", row5);
					request.setAttribute("date_pass", date_pass);
					request.setAttribute("datafor", datafor);
					
					 
					rd.forward(request, response);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
 
	
}
