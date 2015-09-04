

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
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
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
		String b=request.getParameter("search");
		b=b.trim();
		
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
		  
			PreparedStatement ps1=con.prepareStatement("select * from List where bookname like ? OR author like ?"); 
			ps1.setString(1, "%"+b+"%");
			ps1.setString(2, "%"+b+"%");
			ResultSet rs =ps1.executeQuery();
			 
			 if(rs.next())
			 {
				
			    request.setAttribute("booksearch", "%"+b+"%");
			    System.out.println(rs.getString(1));
			    request.setAttribute("listsuccess", b +" book is available in Library "); 
			    RequestDispatcher rd = request.getRequestDispatcher("library.jsp");
		        rd.forward(request, response);
		
			 }
			 else
			 {
				 request.setAttribute("liberror", b +" is not available in Library ");  
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