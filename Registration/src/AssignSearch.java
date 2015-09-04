

import java.sql.ResultSet;
 import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class search
 */
@WebServlet("/search")
public class AssignSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AssignSearch() {
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
		String b=request.getParameter("search1");
		b=b.trim();
		
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
		  
			PreparedStatement ps1=con.prepareStatement("select * from Library where bookname like ? OR author like ? OR assignedname like ?"); 
			ps1.setString(1, "%"+b+"%");
			ps1.setString(2, "%"+b+"%");
			ps1.setString(3, "%"+b+"%");
			
			ResultSet rs =ps1.executeQuery();
			 
			 if(rs.next())
			 {
				
			     request.setAttribute("assignsearch", "%"+b+"%");
			     request.setAttribute("assignsuccess", b +" is availble in Assigned Books ");
			     RequestDispatcher rd = request.getRequestDispatcher("library.jsp");
		         rd.forward(request, response);
			 
			 }
			 else
			 {
				 request.setAttribute("assignerror", b +" is not available in Assigned Books ");
				  
				   RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
				   rd.forward(request,response);
				  
			 }

		
		}
		catch(Exception e1)
		{
			System.out.println(e1);
		}
		
		doGet(request, response);
	}

}