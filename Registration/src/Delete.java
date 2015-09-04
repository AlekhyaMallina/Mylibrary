

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");  
		String myVariable = request.getParameter("bookname");
		//System.out.println(myVariable);
		try
		{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
		

		if(myVariable!=null)
		{
		
			PreparedStatement ps1=con1.prepareStatement("delete from Library where bookname=?"); 
			ps1.setString(1, myVariable);
			 int i =ps1.executeUpdate();
			 if(i>0)
			 response.sendRedirect("library.jsp");
			
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		
		doGet(request, response);
	}

}