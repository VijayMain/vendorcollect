package com.vendorform.vo;

import java.util.ArrayList;

public class Configuration_vo {
	String date_from = "", date_to = "", yes_no = "", name = "", access = "",
			vendor_Code = "";
	ArrayList all_SelecetdSet = null;

	public String getDate_from() {
		return date_from;
	}

	public void setDate_from(String date_from) {
		this.date_from = date_from;
	}

	public String getDate_to() {
		return date_to;
	}

	public void setDate_to(String date_to) {
		this.date_to = date_to;
	}

	public String getYes_no() {
		return yes_no;
	}

	public void setYes_no(String yes_no) {
		this.yes_no = yes_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAccess() {
		return access;
	}

	public void setAccess(String access) {
		this.access = access;
	}

	public String getVendor_Code() {
		return vendor_Code;
	}

	public void setVendor_Code(String vendor_Code) {
		this.vendor_Code = vendor_Code;
	}

	public ArrayList getAll_SelecetdSet() {
		return all_SelecetdSet;
	}

	public void setAll_SelecetdSet(ArrayList all_SelecetdSet) {
		this.all_SelecetdSet = all_SelecetdSet;
	}

}
