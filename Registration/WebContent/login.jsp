<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="login.css">
</head>


<body>
<%
if(session.getAttribute("email")!=null)
{
   response.sendRedirect("library.jsp");
} 
%>
    <div class="topnavContainer"></div>
	
	   <div class="col-xs-offset-4 col-xs-6">
	   <div class=" col-xs-6">
							<div class="message form-group" >
					      		<%String signup_msg=(String)request.getAttribute("error");  
                            		if(signup_msg!=null)
                          		 out.println("<font color=red size=3px>"+signup_msg+"</font>");
                           		%>
							</div>
					   </div>
					   <div class="message col-xs-8">
							<div class="form-group" >
					      		<%String msg=(String)request.getAttribute("success_l");  
                            		if(msg!=null)
                          		 out.println("<font color=green size=3px>"+msg+"</font>");
                           		%>
							</div>
					   </div>
					  
		<div class="login">
	      <div class="panel ">
	      <div class="panel-heading"><h3>Login Form</h3></div>
				 <div class="panel-body">
				 
					<form class="form-horizontal" action="/Registration/check" method="post" >
						
					   <div  class="col-xs-7">
						  <div class="form-group">
						     <div class="input-group">
							    <span class="input-group-addon">
                                   <i class="glyphicon glyphicon-user"></i>
                                </span>
								<input type="email" name="email" class="form-control"
									id="inputEmail" placeholder="Email" required>
							 </div>
						     
							 
						 </div>
					   </div>
					   <div  class="col-xs-7">
						 <div class="form-group">
						   <div class="input-group">
						     <span class="input-group-addon">
                                   <i class="glyphicon glyphicon-lock"></i>
                             </span>
								<input type="password" name="password" class="form-control"
									id="inputPassword" placeholder="Password" required>		
							</div>
							 
						 </div>
					   </div>
					   <div  class="col-xs-7">
					   <div class="form-group">
					   <div class="col-xs-offset-4 col-xs-6" align="right"><a href="forgot.jsp">forgot password?</a></div>
					   </div>
					   </div>
					   <div class="col-xs-7">
						<div class="form-group">
							
								<button type="submit" class="btn btn-primary">
									<span class="glyphicon glyphicon-log-in"></span> Login
								</button><span class="col-xs-offset-4">New Here ?<a href="signup.jsp">Signup</a></span>
							    
							</div>
						</div>
						
						
						
					</form>

				</div>
			</div>
		</div>
		</div>
		
</body>
</html>
