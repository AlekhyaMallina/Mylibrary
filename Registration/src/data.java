

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class data
 */
@WebServlet("/data")
public class data extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
     * @see HttpServlet#HttpServlet()
     */
    public data() {
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
		PrintWriter out = response.getWriter();  
		ResultSet rs = null;
		String a=""; //Author
		 String day="";
		 String email="";
		Integer count1 = new Integer(0);
		String b=request.getParameter("book");//book  
		String p="";//Person
	
		int hitcount = 0;
		Connection con=null;
		boolean st_error=false;
		
		/*  checking whether the book is present in List database or not  */
		
		try
		{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/mydb","root","root");
		PreparedStatement ps_check=con.prepareStatement("select * from List where bookname=?"); 
		ps_check.setString(1, b);
		rs =ps_check.executeQuery();
		st_error=rs.next();

		}
		catch(Exception e1)
		{
			System.out.println(e1);
		}
		
		if(!st_error)//Displaying the error message if book is not present List database
		{
			request.setAttribute("bookerror", b +" book is not available in Library ");
	
			   RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
			   rd.forward(request,response);
	
		}
		else//if book is present
		{
		 
			/*   Validating the assignment of the particular book to a person only once  */

			
	   try {
			a = rs.getString(2);
			count1=rs.getInt(3);//Number of copies a book
			hitcount=rs.getInt(4);//Assigned hit count of a book
			
			if(count1 != 0)//If copies of a book are present in the library
			{
				ResultSet rs_check=null,rs_email=null;
				boolean st_check=false;
				  p=request.getParameter("person");
				  day=request.getParameter("days");
				   email= request.getParameter("email");
				   PreparedStatement ps_email =con.prepareStatement("select * from signup where Email=? ");
				   ps_email.setString(1, email);
				  
			          rs_email =ps_email.executeQuery();
			          if(rs_email.next())
			          {
			          
				PreparedStatement ps_assign =con.prepareStatement("select * from Library where bookname= ? and  assignedname = ? and status = 'a' ");
				ps_assign.setString(1, b);
		         ps_assign.setString(2, p);
		          rs_check =ps_assign.executeQuery();
		         st_check=rs_check.next();
		         
				if(!st_check) //Issuing the book if the person not assigned with the same book
				{
					//Updating the number of copies and hit count for a book
					count1=count1-1;
					hitcount=hitcount+1;
					PreparedStatement ps_update=con.prepareStatement("UPDATE List SET count = ?,hitcount=? WHERE bookname =?"); 
					ps_update.setInt(1, count1);
					ps_update.setInt(2, hitcount);
					ps_update.setString(3, b);
				    ps_update.executeUpdate();
					
					 //Adding Date to table 
				   
					Calendar c1 = Calendar.getInstance();
				   //formatting date in Java using SimpleDateFormat
			        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yyyy");
			        
			        String date1 = DATE_FORMAT.format(c1.getTime());
			        
			        
			        Calendar c2 = Calendar.getInstance();
			        SimpleDateFormat DATE_FORMAT1 = new SimpleDateFormat("dd-MM-yyyy");
			        c2.add(Calendar.DATE, Integer.parseInt(day));
			        String date2 = DATE_FORMAT1.format(c2.getTime());
			        
			        
						 //Updating the Assigned books Table in Library Database
						
						try{  
							Class.forName("com.mysql.jdbc.Driver");
							Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
						  
						PreparedStatement ps=con1.prepareStatement( "insert into Library (bookname,author,assignedname,date,status,daystoreturn,email,emailsent) values(?,?,?,?,?,?,?,?)");  
						String s = "a";
						ps.setString(1,rs.getString(1));  
						ps.setString(2,a);  
						ps.setString(3,p);  
						ps.setString(4,date1);  
						ps.setString(5,s);
						ps.setString(6, date2);
						ps.setString(7, email);
						ps.setString(8, "F");
						ps.executeUpdate();
						request.setAttribute("success_as", b +" Book is successfully assigned to "+p);
						
						RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
						   rd.forward(request,response);
						
						}
						catch(Exception e1)
						{
							System.out.println(e1);
						}			 
					 
					 
				}
				else // Displaying the error message if that particular book is already assigned to that person 
				{
				
					request.setAttribute("bookerror", b +" Book already assigned to "+p);
					RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
					   rd.forward(request,response);
				
				
			
				}
			 
			 
			 
			
			}
			else{
				request.setAttribute("bookerror", email +" is not registered");
				RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
				   rd.forward(request,response);
			}
			}
			else //Displaying the error message if the copies of the book reaches Zero 
			{
				request.setAttribute("bookerror", b +" books are Completed, take someother time  ");
				RequestDispatcher rd=request.getRequestDispatcher("library.jsp");
				   rd.forward(request,response);
			}
			

		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		} 
		
		}
		out.close();  
		doGet(request, response);
	
	}
}