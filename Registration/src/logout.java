
 
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/loginsample/LogoutServlet")
public class logout extends HttpServlet {
    private static final long serialVersionUID = 1L;
        
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html");
    	 Cookie loginCookie = null;
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("email")){
                    loginCookie = cookie;
                    System.out.println(loginCookie);
                    break;
                }
            }
            }
        if(loginCookie != null){
            loginCookie.setMaxAge(0);
            response.addCookie(loginCookie);
        }
       
        //invalidate the session if exists
        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
        HttpSession session = request.getSession();
        
        session.removeAttribute("email");
        ((HttpSession) session).invalidate();
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
        }
    }
 
