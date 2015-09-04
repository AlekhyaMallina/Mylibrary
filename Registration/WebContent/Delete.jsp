<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

String myVariable = request.getParameter("bookname");
String person = request.getParameter("person");

try
{
Class.forName("com.mysql.jdbc.Driver");
Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
 
ResultSet rs,rs1;

if(myVariable!=null)
{
	 //Adding Return Date to table 
    
	 long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis);
		SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yyyy");
     String date1= DATE_FORMAT.format(date);
	PreparedStatement ps_del=con1.prepareStatement("update Library set status = 'r' , retruneddate =? where bookname="+myVariable+"&&"+" assignedname=?");
	ps_del.setString(1, date1);
	ps_del.setString(2, person);
	
	 int i =ps_del.executeUpdate();
	 PreparedStatement ps_check=con1.prepareStatement("select * from List where bookname="+myVariable); 
		
		rs =ps_check.executeQuery();
		int count1=0;
		if(rs.next())
		{
		count1=rs.getInt(3);
		count1=count1+1;//Increment the count when particular book is unassigned.
		PreparedStatement ps_update=con1.prepareStatement("UPDATE List SET count = ? WHERE bookname ="+myVariable);
		ps_update.setInt(1, count1);
		
		int i1 =ps_update.executeUpdate();
		
		}
	 if(i>0)
	 response.sendRedirect("library.jsp");
	
}
}
catch(Exception e)
{
	System.out.println(e);

}











%>
</body>
</html>