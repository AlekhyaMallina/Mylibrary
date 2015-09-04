import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;
  
public class checklogin {  
public static boolean validate(String email,String pass){  
	String query;
    String dbemail, dbpassword;
    boolean login = false;

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");
        Statement stmt = (Statement) con.createStatement();
        query = "SELECT Email, Password FROM signup;";
        stmt.executeQuery(query);
        ResultSet rs = stmt.getResultSet();

        while(rs.next()){
            dbemail = rs.getString("Email");
            dbpassword = rs.getString("Password");

            if(dbemail.equals(email) && dbpassword.equals(pass)){
                login = true;
            }
           
        }
    } catch (InstantiationException e) {
        e.printStackTrace();
    } catch (IllegalAccessException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return login;  
}  
}  