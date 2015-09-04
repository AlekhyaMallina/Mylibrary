
import java.io.IOException;  
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
    
public class check extends HttpServlet {  
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

public void doPost(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {  
  
    response.setContentType("text/html");  
    PrintWriter out = response.getWriter();
    String e=request.getParameter("email");  
    String p=request.getParameter("password");  
          
    if(checklogin.validate(e, p)){  
    	HttpSession session = request.getSession();
    	session.setAttribute("email", e);
    	response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
    	response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
    	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
    	response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
    	String userName = (String) session.getAttribute("email");
    	if (null == userName) {
    	   request.setAttribute("Error", "Session has ended.  Please login.");
    	   RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
    	   rd.forward(request, response);
    	}
        Cookie loginCookie = new Cookie("email",e);
        //setting cookie to expiry in 30 mins
        loginCookie.setMaxAge(30*60);
        response.addCookie(loginCookie);
        response.sendRedirect("library.jsp");
    }  
    else{  
    	
    	request.setAttribute("error","Invalid Email or Password");
        //out.println("<div align='center'><font color = 'red' > Sorry Email or Password error</font></div>");  
    	 RequestDispatcher rd=request.getRequestDispatcher("login.jsp"); 
        rd.include(request,response);  
    }  
          
    out.close();  
    }  
}  