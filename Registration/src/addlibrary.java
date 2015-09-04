

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addtolib
 */
@WebServlet("/addtolib")
public class addlibrary extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addlibrary() {
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
		response.setContentType("text/html");  
		
		ResultSet rs = null;
		/* Adding new books to the library in List database with their number of copies   */
		String b=request.getParameter("book");//book  
		String a =request.getParameter("author");//author
		String c =request.getParameter("number");//additional copies count
		int a_c = Integer.parseInt( c );

		boolean st=false;
		
		// Updating the number of books in library
		
        //formatting date in Java using SimpleDateFormat
		
        Calendar c1 = Calendar.getInstance();
        SimpleDateFormat DATE_FORMAT1 = new SimpleDateFormat("dd-MM-yyyy");
        String date1 = DATE_FORMAT1.format(c1.getTime());
		
		try
		{
		
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
			
		//checking whether the book is already present in the library
		
		PreparedStatement ps_check=con.prepareStatement("select * from List where bookname=?");
		ps_check.setString(1, b);
		rs =ps_check.executeQuery();
		st=rs.next();
		
		// Adding new entry of book if it is not present in library
		
		if(!st) 
		{
			
		PreparedStatement ps_new=con.prepareStatement("insert into List" + "(bookname,author,count,status,Date) VALUES"+"(?,?,?,?,?)"); 
		
		ps_new.setString(1, b);
		ps_new.setString(2, a);
		ps_new.setInt(3, a_c);
		ps_new.setString(4, "N");
		ps_new.setString(5, date1);
		ps_new.executeUpdate();
	
		}
		// updating the value of number of copies of the book if it is already present
		
		else
		{
			ResultSet rs_getcnt = null;
			PreparedStatement ps_getcnt=con.prepareStatement("SELECT * from List WHERE bookname =?");
			ps_getcnt.setString(1, b);
			rs_getcnt=ps_getcnt.executeQuery();
			if(rs_getcnt.next())
			{
				int count = rs_getcnt.getInt(3);//getting previous count of copies
				count = count + a_c;//adding additional count with previous count of copies
			PreparedStatement ps_add=con.prepareStatement("UPDATE List SET count = ?  WHERE bookname =?"); 
			ps_add.setInt(1, count);
			ps_add.setString(2, b);
			ps_add.executeUpdate();
			
			}
		}
		
		//for printing the success message when book is added to the library
		
		request.setAttribute("success_ad", b +" book is successfully added to the Library");
		RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
		   rd.forward(request,response);
		}
		catch(Exception e1)
		{
			System.out.println(e1);
		}
		
		doGet(request, response);
	}


}