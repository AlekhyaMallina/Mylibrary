import java.io.*;  
import java.sql.*;  

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;  
import javax.servlet.http.*;  
  
public class register extends HttpServlet {  
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
	
	
	Servlet servlet = new register();
	servlet.init(getServletConfig());
 	
response.setContentType("text/html");  
PrintWriter out = response.getWriter();  
         
String e=request.getParameter("email");
String i=request.getParameter("Employee_ID");
String p=request.getParameter("password"); 

  
 
          
try{  
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
		"jdbc:mysql://localhost:3306/mydb","root","root");  
  
PreparedStatement ps=con.prepareStatement(  
"insert into signup values(?,?,?,?)");  
  
ps.setString(1,e);  
ps.setString(2,i);
ps.setString(3,p);
ps.setString(4,p);
 
          
int j=ps.executeUpdate();  
if(j>0)  
{
	request.setAttribute("success_l","Registered Successfully");	
	 RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
	    rd.include(request,response); 

}
}catch (Exception e2) {
	request.setAttribute("error","Email or Employee_ID you have entered already exits");
	//out.println("<div align = 'center'><font color = 'red'> " + e2 + "</font></div>");  
    RequestDispatcher rd=request.getRequestDispatcher("signup.jsp");
    rd.include(request,response); 

			}  
          
out.close();  
}  
  
}