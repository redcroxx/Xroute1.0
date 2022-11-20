<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.awt.*" %>
<%    
	//System.setProperty("sun.java2d.fontpath", "font_location_path");		
	//System.setProperty("java.awt.headless", "true");
	String[] fontNames = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames(); 
	for (int i=0; i<fontNames.length; i++) 
	{ 
		out.println(fontNames[i]+"<br>"); 
	}
%>