import java.io.*;  
import java.sql.*;  

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;  
import javax.servlet.http.*;  
  
public class forgot extends HttpServlet {  
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
String p=request.getParameter("password"); 

  
 
          
try{  
	ResultSet  rs;
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
		"jdbc:mysql://localhost:3306/mydb","root","root");  
  
PreparedStatement ps=con.prepareStatement("select * from signup where Email=?");  
ps.setString(1,e); 
rs=ps.executeQuery();
if(rs.next())
{
	PreparedStatement ps_u=con.prepareStatement("UPDATE signup SET Password = ? ,Confirm_password=? WHERE Email= ?");
	ps_u.setString(1,p);
	ps_u.setString(2,p);
	ps_u.setString(3,e);
    int i=ps_u.executeUpdate();
    if(i>0)
    {
    	request.setAttribute("success_l","Password has changed successfully");
    	 RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
    	    rd.include(request,response); 
}   
    }
else{
	request.setAttribute("error","Please check your entered email");
	//out.println("<div align = 'center'><font color = 'red'> " + e2 + "</font></div>");  
    RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
    rd.include(request,response); 
}
}catch (Exception e2) {
	System.out.println(e2);

			}  
          
out.close();  
}  
  
}