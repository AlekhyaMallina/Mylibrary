<%@ page import="java.sql.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import=" java.util.*"%>
<%@ page import=" javax.mail.*"%>
<%@ page import=" javax.mail.internet.*"%>
<%@ page import=" javax.activation.*"%>
<%@ page import="Email.SendEmail" %>
<%@ page import="java.util.Calendar"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="en" ng-app="MyApp">
<head>
	
  <title>Vedams Library</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="library.css">
<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
<script src="https://rawgithub.com/eligrey/FileSaver.js/master/FileSaver.js" type="text/javascript"></script>

</head>

<script>

angular.module('MyApp', []).controller('MainController', [ '$scope' ,function($scope) {

	$scope.list=true;
	//for displaying form to add books in Library 
	$scope.AddBooks = function() {
		$scope.error=$scope.add;
		$scope.add= !$scope.add;
		    $scope.assign=false;
			$scope.search=false;
			$scope.hit=false;
			$scope.total=false;
			$scope.list=false;
			$scope.due=false;
			$scope.error=true;
			
		};
		//for displaying form to assign books 
		$scope.Assign = function() {
		$scope.error=$scope.assign;
		$scope.assign=!$scope.assign;
		
			$scope.add=false;
			$scope.search=false;
			$scope.hit=false;
			$scope.total=false;
			$scope.list=false;
			$scope.due=false;
			$scope.error=true;
			
		};
		//for dispalying allbooks in library 
		$scope.Showlist = function() {
			$scope.search=!$scope.search;
			$scope.add=false;
			$scope.assign=false;
			$scope.hit=false;
			$scope.total=false;
			$scope.list=false;
			$scope.due=false;
			$scope.error=true;
			
		};
		//for displaying Hit list of assigned books 
		$scope.Hitcount=function() {
			$scope.hit=!$scope.hit;
			$scope.add=false;
			$scope.assign=false;
			$scope.search=false;
			$scope.total=false;
			$scope.list=false;
			$scope.due=false;
			$scope.error=true;
			
		};

		//for displaying assigned history 

		$scope.Totallist=function() {
			$scope.total=!$scope.total;
			$scope.add=false;
			$scope.assign=false;
			$scope.search=false;
			$scope.hit=false;
			$scope.list=false;
			$scope.due=false
			$scope.error=true;
			
		};
		//for displaying bokks available in Library 
		$scope.Home=function() {
			$scope.list=!$scope.list;
			$scope.add=false;
			$scope.assign=false;
			$scope.search=false;
			$scope.hit=false;
			$scope.total=false;
			$scope.due=false;
			$scope.error=true;
			
		};
       //for displaying due list until present date 
		$scope.Duedate=function() {
			$scope.due=!$scope.due;
			$scope.add=false;
			$scope.assign=false;
			$scope.search=false;
			$scope.hit=false;
			$scope.total=false;
			$scope.list=false;
			$scope.error=true;
			
		};
		
		


}]);


</script>

<body ng-controller="MainController">

<!-- allow access only if session exists -->

<% 
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

String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
    if(cookie.getName().equals("email")) userName = cookie.getValue();
}
}
%>
   
   
   
                                    <!-- The whole container code starts here -->
                                    
<div class="container">
	
		<div id="topDIV" class="top">
			<div class = "col-xs-4">
       			<a href="library.jsp"><img id="topLogo" src="vedams.jpg" alt="Library" class="img-responsive"></a>
      		</div></div>
      		
      	
     		
     		
     		        <!-- For displaying Tabs in an aligned manner  -->
     		        
           
 		 <div class ="row">
  
     		
      			<div id="topnavDIV" class="topnavContainer">
          			<div class="container-fluid" style="max-width:1600px;margin-left:0px;padding-left:0;">
             			<ul class="nav nav-pills topnav">
             			     <li ng-click="Home()"><a href ="library.jsp"><span class="glyphicon glyphicon-home"></span>Home</a></li>
                 	 		<% Boolean admin=session.getAttribute("email").equals("sridevir@vedams.com");
                 	 	
                 	 		
                 	 		//for admin acess
                 	 	
                 	 	
                 	 	if(admin)
                 	 		{
                 	 		
                 	 		%>
                 	 		
                 	 		 <li  ng-click="Assign()" ng-disable="admin.$invalid "><a href = "#"><span class="glyphicon glyphicon-pencil"></span> Assign Books</a></li>
                 			 <li ng-click="AddBooks()" ng-disable="admin"><a href = "#"><span class="glyphicon glyphicon-th-list"></span> Add to library</a></li>
                 			 <li ng-click="Duedate()" ng-disable="admin"> <a href = "#"><span class="glyphicon glyphicon-th-list"></span> Due List</a></li> 
                 			 <li ng-click="Showlist()"><a href = "#"><span class="glyphicon glyphicon-th-list"></span> Assigned Books</a></li>
                 			 <li ng-click="Totallist()"><a href = "#"><span class="glyphicon glyphicon-th-list"></span> Assigned History</a></li>
                 			 
                 			<%} 
                 			else{%>
                 			
                 			<!-- for User access -->
                	 		
                	 		 <li ng-click="Showlist()"><a href = "#"><span class="glyphicon glyphicon-th-list"></span> Assigned Books</a></li>
                	 		  
                	 		 <%} %>
                	 		 
                	 		 <!-- for both admin and user access -->
                	 		 
                	 		 
              		   		 <li ng-click="Hitcount()"><a href = "#"><span class="glyphicon glyphicon-th-list"></span> Popular books</a></li> 
              		   		
               		  		 <li class="nav navbar-nav navbar-right">
                 	      		 <form action = "/Registration/logout" method="post" style="margin-bottom:0px;"><a href ="#" >
                 	      		        <div class="dropdown">
                                             <button class="btn " type="button" data-toggle="dropdown">Welcome <%= session.getAttribute("email") %>
                                                <span class="caret"></span></button>
                                                  <ul class="dropdown-menu">
                                                       <li><button class = "signout" type = "submit"><span class="glyphicon glyphicon-log-out"></span> SignOut</button></li>
                                                  </ul>
                                        </div>
                  	            	
                  		      		</a></form>
                 			 </li>
            			</ul>
         		 	
     			</div>
  			 </div>
 		 </div>
	 
  	
  <br>
  <br>
  <br>
  
                 
         <!-- For displaying error if book is not there in library and if already assigned to that particular person-->
           
            <div ng-show="!error">
             <div class="assign">
             <div class = "message col-xs-offset-2 col-xs-6">
			       <%String login=(String)request.getAttribute("bookerror"); 
			       int count=1;
			       if(count ==1)
			       {
                     if(login!=null)
                     {
                    	 %><div ng-value="list=false"></div>
                    	 <%
                    	 out.println("<font color=red size=3px>"+login+"</font>");
 					%>
 		
                    
                
                   <div class="panel ">
                       <div class="panel-body">
                         <div class="form-horizontal">
                         <form class="form-horizontal" name="myForm" action ="/Registration/data" method = "post">
      		                  <div class="col-xs-8">
      		                     <div class="form-group">
                                    <div class="input-group">
                                      <span class="input-group-addon">
                                         <i class="glyphicon glyphicon-list-alt"></i>
                                      </span>
          			                  <input class="form-control" id="inputName" name="book" ng-model="Book" placeholder="Book Name" required>
        		                    </div>
      		                    </div>
      		                  </div>
                              <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-user"></i>
                                    </span>
          		                    <input class="form-control" id="inputPerson" name="person" ng-model="person" placeholder="Person name" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-envelope"></i>
                                    </span>
          		                    <input class="form-control" id="inputEmail" name="email" ng-model="email" placeholder="Email" type="email" required>
        		                 </div>
        		                 <span ng-show="myForm.email.$error.required && myForm.email.$dirty">required</span>                
                					<span ng-show="!myForm.email.$error.required && myForm.email.$error.email && myForm.email.$dirty">invalid email</span>                 
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-calendar"></i>
                                    </span>
          		                    <input class="form-control" id="inputDays" name="days" ng-model="days" type="number" placeholder="Duration" min="0" max="15"required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                <div class="form-group-primary">
                              <div class="col-xs-8">
                                   <button  class="btn btn-primary" >Submit</button>
                              </div>
                           </div>
                        </form>
                     </div>
                   </div>
                 </div>
            
              
              
                  <%}} %> </div> </div>
		    </div>
		   
		                <!--   Displaying success messge with form if book is successfully assigned   -->
		                
		                
		                
		                 <div ng-show="!$assign">
                       <div class="success">
		                <div ng-show="!error">
            
			       <%String su_as=(String)request.getAttribute("success_as");
			       
                     if(su_as!=null)
                     {
                     out.println("<div class='message col-xs-offset-3 col-xs-6'>"+"<font color=green size=3px>"+su_as+"</font></div>");
        		%><div ng-value="list=false"></div>
        		    <div class="assign">
               <div class="col-xs-offset-2 col-xs-6">
            
                   <div class="panel ">
                       <div class="panel-body">
                         <div class="form-horizontal">
                         	<form class="form-horizontal" name="myForm" action ="/Registration/data" method = "post">
      		                  <div class="col-xs-8">
      		                     <div class="form-group">
                                    <div class="input-group">
                                      <span class="input-group-addon">
                                         <i class="glyphicon glyphicon-list-alt"></i>
                                      </span>
          			                  <input class="form-control" id="inputName" name="book" ng-model="Book" placeholder="Book Name" required>
        		                    </div>
      		                    </div>
      		                  </div>
                              <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-user"></i>
                                    </span>
          		                    <input class="form-control" id="inputPerson" name="person" ng-model="person" placeholder="Person name" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-envelope"></i>
                                    </span>
          		                    <input class="form-control" id="inputEmail" name="email" ng-model="email" placeholder="Email" type="email" required>
        		                 </div>
        		                 <span ng-show="myForm.email.$error.required && myForm.email.$dirty">required</span>                
                					<span ng-show="!myForm.email.$error.required && myForm.email.$error.email && myForm.email.$dirty">invalid email</span>                 
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-calendar"></i>
                                    </span>
          		                    <input class="form-control" id="inputDays" name="days" ng-model="days" type="number" placeholder="Duration" min="0" max="15" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                <div class="form-group-primary">
                              <div class="col-xs-8">
                                   <button  class="btn btn-primary" >Submit</button>
                              </div>
                           </div>
                        </form>
                     </div>
                   </div>
                 </div>
              
            </div></div>
                  <%   }
                   %>
		    
		    </div></div></div>
		    
	  <!-- Displaying a from to assign books on clicking tab Assign Books and will goto data.java servlet function on submit -->
	  
               <div ng-show="assign" >
               
               <div class="assign">
               
               <div class = "col-xs-offset-2 col-xs-6">
                   <div class="panel ">
                       <div class="panel-body">
                         <div class="form-horizontal">
                         	<form class="form-horizontal" name="myForm" action ="/Registration/data" method = "post">
      		                  <div class="col-xs-8">
      		                     <div class="form-group">
                                    <div class="input-group">
                                      <span class="input-group-addon">
                                         <i class="glyphicon glyphicon-list-alt"></i>
                                      </span>
          			                  <input class="form-control" id="inputName" name="book" ng-model="Book" placeholder="Book Name" required>
        		                    </div>
      		                    </div>
      		                  </div>
                              <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-user"></i>
                                    </span>
          		                    <input class="form-control" id="inputPerson" name="person" ng-model="person" placeholder="Person name" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-envelope"></i>
                                    </span>
          		                    <input class="form-control" id="inputEmail" name="email" ng-model="formData.email" placeholder="Email" type="email" required>
        		                 </div>
        		                 <span ng-show="myForm.email.$error.required && myForm.email.$dirty">required</span>                
                					<span ng-show="!myForm.email.$error.required && myForm.email.$error.email && myForm.email.$dirty">invalid email</span>                 
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-calendar"></i>
                                    </span>
          		                    <input class="form-control" id="inputDays" name="days" ng-model="days" type="number" placeholder="Duration" min="0" max="15" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                <div class="form-group-primary">
                              <div class="col-xs-8">
                                   <button  class="btn btn-primary" >Submit</button>
                              </div>
                           </div>
                        </form>
                     </div>
                   </div>
                 </div>
              </div>
            </div>
      </div>
      
      
             <!-- Displaying success messsge if book is successfully added to the library with form to add books to library -->
            
            <div ng-show="!$add">
            <div class="success">
            <div ng-show="!error">
            
			       <%String su_ad=(String)request.getAttribute("success_ad");
			      
                     if(su_ad!=null)
                     {
                     out.println("<div class='message col-xs-offset-3 col-xs-6'>"+"<font color=green size=3px>"+su_ad+"</font></div>");
        		      %>
        		      <div ng-value="list=false"></div>
        		       <div class="add">
                <div class = "col-xs-offset-2 col-xs-6">
                   <div class="panel ">
                       <div class="panel-body">
                         <div class="form-horizontal">
                         	<form class="form-horizontal" name="myForm" action ="/Registration/addlibrary" method = "post">
      		                  <div class="col-xs-8">
      		                     <div class="form-group">
                                    <div class="input-group">
                                      <span class="input-group-addon">
                                         <i class="glyphicon glyphicon-list-alt"></i>
                                      </span>
          			                  <input class="form-control" id="inputName" name="book" ng-model="Book" placeholder="Book Name" required>
        		                    </div>
      		                    </div>
      		                  </div>
                              <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-user"></i>
                                    </span>
          		                    <input class="form-control" id="inputAuthor" name="author" ng-model="person" placeholder="Author name" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-plus"></i>
                                    </span>
          		                    <input class="form-control" id="inputNumber" name="number" ng-model="number" type="number" placeholder="No. of Copies" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                <div class="form-group-primary">
                              <div class="col-xs-8">
                                   <button  class="btn btn-primary" >Submit</button>
                              </div>
                           </div>
                        </form>
                     </div>
                   </div>
                 </div>
              </div>
            </div>
        		      
        		      
        		      <% } %>
		    </div>
		    </div></div>
		     
               <!-- Displaying a from to add books on clicking tab Add Books and will goto addlibrary.java servlet on submit -->
	  
               <div ng-show="add">
               <div class="add">
                <div class = "col-xs-offset-2 col-xs-6">
                   <div class="panel ">
                       <div class="panel-body">
                         <div class="form-horizontal">
                         	<form class="form-horizontal" name="myForm" action ="/Registration/addlibrary" method = "post">
      		                  <div class="col-xs-8">
      		                     <div class="form-group">
                                    <div class="input-group">
                                      <span class="input-group-addon">
                                         <i class="glyphicon glyphicon-list-alt"></i>
                                      </span>
          			                  <input class="form-control" id="inputName" name="book" ng-model="Book" placeholder="Book Name" required>
        		                    </div>
      		                    </div>
      		                  </div>
                              <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-user"></i>
                                    </span>
          		                    <input class="form-control" id="inputAuthor" name="author" ng-model="person" placeholder="Author name" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                 <div class="col-xs-8">
      		                    <div class="form-group">
                                  <div class="input-group">
                                    <span class="input-group-addon">
                                      <i class="glyphicon glyphicon-plus"></i>
                                    </span>
          		                    <input class="form-control" id="inputNumber" name="number" ng-model="number" type="number" placeholder="No. of Copies" required>
        		                 </div>
      		                   </div>
      		                 </div>
      		                <div class="form-group-primary">
                              <div class="col-xs-8">
                                   <button  class="btn btn-primary" >Submit</button>
                              </div>
                           </div>
                        </form>
                     </div>
                   </div>
                 </div>
              </div>
            </div>
         </div>
  
                    <!-- Displaying a table of assigned books on clicking tab Assigned Book List -->
                    
                    
               
                
                 <!-- getting the value typed in search box -->
                   
                <% String assignedbook =(String)request.getAttribute("assignsearch");
                    %> 
                
                
                <!--Displaying an error message in case of mutiple assignment of samebook to same person  -->
              
		     
		<div ng-show="!$search">
          <div class="assign">
            <div ng-show="!error">
			         <%
			             String as_msg=(String)request.getAttribute("assignerror");  
                         if(as_msg!=null)
                         {
                        	 %><div ng-value="list=false"></div><%
                       
                        
                     %>
		
            	  
		     <!--Displaying an error message in case of no entries in assigned table  -->
		     
		     
                     <!-- Searching particular book from Library -->
                     
          <div class="Library">           
               <form method="post" action="/Registration/AssignSearch">
                   <div class="row" >
                       <div class="col-sm-5">
                           <div class="input-group">
                               <input type="text" name="search1" class="form-control" placeholder="Search&hellip;" required>
                               <span class="input-group-btn">
                                  <button type="submit"  class="btn btn-primary"><span class = "glyphicon glyphicon-search"></span> Search</button>
                               </span>
                               
                          </div>
                       </div>
                 </div>
              </form>
              <div class="error">
                   <% out.println("<div class='col-xs-offset-3 col-xs-6'>"+"<font color=red size=3px>"+as_msg+"</font></div>");%>
                   </div>
                      <table class = "table table-bordered">
	                      <thead>
                              <tr>
                                  <th class="col-sm-3 text">BookName</th>
                                  <th class="col-sm-3 text">Author</th>
                                  <th class="col-sm-2 text">Assigned Person</th>
                                  <th class="col-sm-2 text">Date</th>
                                  <th scope="col" class="col-sm-2 text">Remove</th>
      
                              </tr>
                        </thead>
                   </table>
                   
                              <!-- Adding books to the table of assigned  -->
                   
                   <div class="scroll">
                    <table class = "table table-striped table-bordered">
                     					      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	
	                        ResultSet rs1;
	 
	                        if(assignedbook!=null)
	                        {
	        	              System.out.println(assignedbook);
		                      PreparedStatement ps1=con.prepareStatement("select * from Library where bookname like ? OR author like ? OR assignedname like ? and status = 'a' " ); 
		                      ps1.setString(1, assignedbook);
		                      ps1.setString(2, assignedbook);
		                      ps1.setString(3, assignedbook);
		                      rs1 =ps1.executeQuery();		 
		
	                        }
	                        else
	                        {
                              PreparedStatement ps2=con.prepareStatement("select * from Library where status = 'a' ");
		                      rs1 =ps2.executeQuery();
	
	                        }
                            while(rs1.next())
                             {
                            	String book=rs1.getString(1);
	
	                     %>
                       
                       <tbody>
                          <tr>
                              <td class="col-sm-3"  > <%= rs1.getString(1) %></td>
                              <td class="col-sm-3"> <%= rs1.getString(2) %></td>
                              <td class="col-sm-2"> <%= rs1.getString(3) %></td>
                              <td class="col-sm-2"> <%= rs1.getString(4) %></td>
                              <td class="col-sm-2"> 
             
                                <a href="Delete.jsp?bookname=<%=book%>&person=<%= rs1.getString(3)%>">Un Assign</a>
              
                             </td>
               
                
                        </tr>
	

                      </tbody>  

                            <%}%> 
                </table>
               
              
             </div>
            
              </div><%}
                         
                         
                         else 
                        	 
                        	 
                        	 if (assignedbook!=null){
                        		 
                        		 
                        		 // for dispalying normal list of assigned books if nothing is searched
                        		 
                        		 
                        	 %><div ng-value="list=false"></div><%
                        			 
            	  %>
       
              <table class = "table table-bordered">
	                      <thead>
                              <tr>
                                  <th class="col-sm-3 text">BookName</th>
                                  <th class="col-sm-3 text">Author</th>
                                  <th class="col-sm-2 text">Assigned Person</th>
                                  <th class="col-sm-2 text">Date</th>
                                  <th scope="col" class="col-sm-2 text">Remove</th>
      
                              </tr>
                        </thead>
                   </table>
                   
                              <!-- Adding books to the table of assigned  -->
                   
                   <div class="scroll">
                    <table class = "table table-striped table-bordered">
                     					      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	
	                        ResultSet rs1;
	 
	        	              System.out.println(assignedbook);
	        	              PreparedStatement ps1=con.prepareStatement("select * from Library where bookname like ? OR author like ? OR assignedname like ? and status = 'a' " ); 
		                      ps1.setString(1, assignedbook);
		                      ps1.setString(2, assignedbook);
		                      ps1.setString(3, assignedbook);
		                      rs1 =ps1.executeQuery();		 
		
                            while(rs1.next())
                             {
                            	String book=rs1.getString(1);
	
	                     %>
                       
                       <tbody>
                          <tr>
                              <td class="col-sm-3"  > <%= rs1.getString(1) %></td>
                              <td class="col-sm-3"> <%= rs1.getString(2) %></td>
                              <td class="col-sm-2"> <%= rs1.getString(3) %></td>
                              <td class="col-sm-2"> <%= rs1.getString(4) %></td>
                              <td class="col-sm-2"> 
             
                                <a href="Delete.jsp?bookname='<%=book%>'&person=<%= rs1.getString(3)%>">Un Assign</a>
              
                             </td>
               
                
                        </tr>
	

                      </tbody>  

                            <%}%> 
                </table>
               
              
             </div>
             <br><br><br><%} %>
             </div>
             </div>
             </div>
             
             
                                         
       <div ng-show="search">



      <!-- Allowing Admin to access assgned books history of all users and unassign books if submitted  -->
   
       <% if(admin)
       {
     
       %>
           
      
       <div class="assign">
       
         
		     <!--Displaying an error message in case of no entries in assigned table  -->
       
       
                      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_ae=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs_ae;
	                        PreparedStatement ps_ae=con_ae.prepareStatement("select * from Library");
		                      rs_ae =ps_ae.executeQuery();
		                      if(!rs_ae.next())
		                      {
		                    	  out.println("<div class='message col-xs-offset-3 col-xs-6' >"+"<font style: color='red' size:3px >"+"Currently there are no Assigned books Please assign "+"</font></div>");
		                    	  
		                      }
		                     
		                      
		               else{%>
					
      
             
                     <!-- Searching particular book from Library -->
                     
          <div class="Library">           
               <form method="post" action="/Registration/AssignSearch">
                   <div class="row" >
                       <div class="col-sm-5">
                           <div class="input-group">
                               <input type="text" name="search1" class="form-control" placeholder="Search&hellip;" required>
                               <span class="input-group-btn">
                                  <button type="submit"  class="btn btn-primary"><span class = "glyphicon glyphicon-search"></span> Search</button>
                               </span>
                          </div>
                       </div>
                 </div>
              </form>
          
                      <table class = "table table-bordered">
	                      <thead>
                              <tr>
                                  <th class="col-sm-3 text">BookName</th>
                                  <th class="col-sm-3 text">Author</th>
                                  <th class="col-sm-2 text">Assigned Person</th>
                                  <th class="col-sm-2 text">Date</th>
                                  <th scope="col" class="col-sm-2 text">Remove</th>
      
                              </tr>
                        </thead>
                   </table>
                   
                              <!-- Adding books to the table of assigned  -->
                   
                   <div class="scroll">
                    <table class = "table table-striped table-bordered">
                     					      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_s=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	
	                        ResultSet rs1_s;
	 
	                      
                              PreparedStatement ps2_s=con_s.prepareStatement("select * from Library where status = 'a' ");
		                      rs1_s =ps2_s.executeQuery();
	
	                        
                            while(rs1_s.next())
                             {
                            	String book=rs1_s.getString(1);
	
	                     %>
                       
                       <tbody>
                          <tr>
                              <td class="col-sm-3"  > <%= rs1_s.getString(1) %></td>
                              <td class="col-sm-3"> <%= rs1_s.getString(2) %></td>
                              <td class="col-sm-2"> <%= rs1_s.getString(3) %></td>
                              <td class="col-sm-2"> <%= rs1_s.getString(4) %></td>
                              <td class="col-sm-2"> 
             
                                <a href="Delete.jsp?bookname='<%=book%>'&person=<%= rs1_s.getString(3)%>">Un Assign</a>
              
                             </td>
               
                
                        </tr>
	

                      </tbody>  

                            <%}%> 
                </table>
                
              </div>
              <br><br><br>
             
             </div>
             </div>
               <%}%><%} 
          else {
          %>
          
          
          <!-- Allowing User to access books assigned only to that particular person -->
          
          
          <div class="userassign">
                     <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_ue=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs_ue;
	                        PreparedStatement ps_ue=con_ue.prepareStatement("select * from Library where email=? and status='a'");
	                        ps_ue.setString(1,userName);
		                      rs_ue =ps_ue.executeQuery();
		                      if(!rs_ue.next())
		                      {
		                    	  out.println("<div class='message col-xs-offset-3 col-xs-6' >"+"<font style: color='red' size:3px >"+"Currently there are no Assigned books for you"+"</font></div>");
		                    	  
		                      }
		                     
		                      
		                      else{%>
      
                      <table class = "table table-bordered">
	                      <thead>
                              <tr>
                                  <th class="col-sm-3 text">BookName</th>
                                  <th class="col-sm-3 text">Author</th>
                                  <th class="col-sm-2 text">Assigned Date</th>
                                  <th scope="col" class="col-sm-2 text">Expected Return</th>
      
                              </tr>
                        </thead>
                   </table>
                   
                              <!-- Adding books to the table of assigned  -->
                   
                   <div class="scroll">
                    <table class = "table table-striped table-bordered">
                     					      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_us=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	
	                        ResultSet rs_us;
                              PreparedStatement ps_us=con_us.prepareStatement("select * from Library where status = 'a' and email=?");
                              ps_us.setString(1,userName);
		                      rs_us =ps_us.executeQuery();
		                      
	
	                        
                            while(rs_us.next())
                            	
                             {
                            	String book_u=rs_us.getString(1);
	 
	                     %>
                       
                       <tbody>
                          <tr>
                              <td class="col-sm-3"  > <%= rs_us.getString(1) %></td>
                              <td class="col-sm-3"> <%= rs_us.getString(2) %></td>
                              <td class="col-sm-2"> <%= rs_us.getString(4) %></td>
                              <td class="col-sm-2"> <%= rs_us.getString(7) %></td>
               
                
                        </tr>
	

                      </tbody>  

                            <%}%> 
                </table>
              </div>
            
               <%} %>
           </div>
           <%} %>
          
          </div></div>
   

               <!-- Displaying a table of assigned books on clicking tab Assigned List Info-->
               
    <div ng-show="total">
    <div id="exportable">
       
       <div class="assign">
       
       <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_ie=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs_ie;
	                        PreparedStatement ps_ie=con_ie.prepareStatement("select * from Library");
		                      rs_ie =ps_ie.executeQuery();
		                      if(!rs_ie.next())
		                      {
		                    	  out.println("<div class='message col-xs-offset-3 col-xs-6' >"+"<font style: color='red'>"+"Currently there are no Assigned books in the library Please assign the Books"+"</font></div>");
		                    	  
		                      }
		                     
		                      
		                      else{ %>
      
                      <table class = "table table-bordered">
					      <thead id="header">
    					      <tr>
      						      <th scope="col" class="col-sm-3">BookName</th>
      							  <th scope="col" class="col-sm-3">Author</th>
      							  <th scope="col" class="col-sm-2">Assigned Person</th>
      							  <th scope="col" class="col-sm-2">Assigned Date</th>
      							  <th scope="col" class="col-sm-2">Returned Date</th>
      							  
      
    				          </tr>
  					     </thead>
  					     </table>
  					     <div class="scroll">
  					      <table class = "table table-striped table-bordered">
 					     <%
							 Class.forName("com.mysql.jdbc.Driver");
							 Connection con_t=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
							 ResultSet rs_t;
							 PreparedStatement ps_t=con_t.prepareStatement("select * from Library ");
	 						 rs_t =ps_t.executeQuery();
					
					 		  while(rs_t.next())
					 		  {
					 			  
					 			 %>
					    <tbody>
   						   <tr>
                			   <td class="col-sm-3" name="book"> <%= rs_t.getString(1) %></td>
                			   <td class="col-sm-3"> <%= rs_t.getString(2) %></td>
               				   <td class="col-sm-2"> <%= rs_t.getString(3) %></td>
               				   <td class="col-sm-2"> <%= rs_t.getString(4) %></td>
               				   <% String return_date=rs_t.getString(6);
               				   if(return_date == null)
               				   {
                      				%>
               					<td class="col-sm-2">NR</td>
               					<%} 
               					
               					else{
               					%>
               					<td class="col-sm-2"><%=return_date %></td><%} %> 
               				   

               				   
                           </tr>
	

				        </tbody>    
							<%}%> 
			       </table>
			    </div>
		  
		   <br>
		   <br>
		   <br>
		   
		   <!-- Generating the excel sheet of assigned books -->
                   
      <button class="btn btn-primary" ng-click="exportdata()" >
           <span class="glyphicon glyphicon-download-alt"></span> Generate Excel
      </button>
	    <%} %>
	    </div>
	    </div>
	    
	     
    </div>


               <!-- Displaying a table of hit list of assigned books in decreasing order  on clicking tab Popular Books List -->
               
               
         <div ng-show="hit">
         <div class="hit">
         
         
         <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_he=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs_he;
	                        PreparedStatement ps_he=con_he.prepareStatement("select * from List");
		                      rs_he =ps_he.executeQuery();
		                      if(!rs_he.next())
		                      {
		                    	  out.println("<div class='message col-xs-offset-3 col-xs-6' >"+"<font style: color='red' size:3px>"+"Currently there are no Assigned books in the library Please assign the Books"+"</font></div>");
		                    	  
		                      }
		                     
		                      
		               else{%>
		   
                      <table class = "table table-bordered">
				

					      <thead>
    					      <tr>
      						      <th scope="col" class="col-sm-2">BookName</th>
      							  <th scope="col" class="col-sm-1">Author</th>
      							 
      
    				          </tr>
  					     </thead>
  					     </table>
  					     <div class="scroll">
  					     <table class = "table table-bordered">
 					     <%
							 Class.forName("com.mysql.jdbc.Driver");
							 Connection con3=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
							 ResultSet rs2;
							 PreparedStatement ps4=con3.prepareStatement("select * from List order by hitcount desc");
	 						 rs2 =ps4.executeQuery();
					
					 		  while(rs2.next())
					 		  {
					    %>
					    <tbody>
   						   <tr>
                			   <td class="col-sm-2" name="book"> <%= rs2.getString(1) %></td>
                			   <td class="col-sm-1"> <%= rs2.getString(2) %></td>
               				  
                           </tr>
	

				        </tbody>    
							<%}%> 
			       </table>
			    </div>
		  
		   <br>
		   <br>
		   <br>
		   
		   <%} %>
	    </div>
	    </div>
	    
                     <!-- Displaying books and their no.of copies available in Library and searching particular book from Library -->
                     
                     
                     
      <div ng-show="list" >   
      <div class ="list">  
                     
                      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_e=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs_e;
	                        PreparedStatement ps_e=con_e.prepareStatement("select * from List");
		                      rs_e =ps_e.executeQuery();
		                      if(!rs_e.next())
		                      {
		                    	  out.println("<div class='message col-xs-offset-3 col-xs-6' >"+"<font style: color='red' size:3px>"+"Currently there are no books in the library Please add the Books"+"</font></div>");
		                    	  
		                      }
		                     
		                      
		               else{%>
       
		    
		    
      
                
          <div class="Library">           
               <form method="post" action="/Registration/Search">
                   <div class="row" >
                       <div class="col-sm-5">
                           <div class="input-group">
                               <input type="text" name="search" class="form-control" placeholder="Search&hellip;" required>
                               <span class="input-group-btn">
                                  <button type="submit"  class="btn btn-primary"><span class = "glyphicon glyphicon-search"></span> Search</button>
                               </span>
                          </div>
                       </div>
                 </div>
              </form>
           
       
                          <!-- getting the value typed in search box -->
                   
                <% String bookname =(String)request.getAttribute("booksearch");
             %> 
                
                <div class="col-xs-offset-3 col-xs-6">
			         <%
			             String msg=(String)request.getAttribute("liberror");  
                         if(msg!=null)
                         {
                         out.println("<font color=red size=3px>"+msg+"</font>");
                         }
                     %>
		     </div>
                
                
             
		     
		     
              <!-- Displaying a table for List of books in library -->
          
					   <table class = "table table-bordered">

						  <thead>
    						  <tr>
      							  <th scope="col" class="col-sm-3 ">BookName</th>
      							  <th scope="col" class="col-sm-3 ">Author</th>
      							  <th scope="col" class="col-sm-1 ">Available Copies</th>
      
    						  </tr>
  					      </thead>
  					      </table>
  					      <div class="scroll">
  					      <table class = "table table-bordered">
  					      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs;
	 
	                        if(bookname!=null)
	                        {
	        	              
		                      PreparedStatement ps1=con1.prepareStatement("select * from List where bookname like ? or author like ?"); 
		                      ps1.setString(1, bookname);
		                      ps1.setString(2, bookname);
		                      rs =ps1.executeQuery();		 
		
	                        }
	                        else
	                        {
                              PreparedStatement ps2=con1.prepareStatement("select * from List");
		                      rs =ps2.executeQuery();
	
	                        }
	                        
                            while(rs.next())
                             {
	           
	
	                     %>
 						
					     <tbody>
   							 <tr>
                				 <td class="col-sm-3"name="book"> <%= rs.getString(1) %></td>
                				 <td class="col-sm-3"> <%= rs.getString(2) %></td>
               					 <td class="col-sm-1"> <%= rs.getString(3) %></td>
            			    </tr>
					    </tbody>    
						<%
						}
                            %> 
						
				  </table>
				  
			   </div><br><br><br>
			   
    <% }%>
    </div>
    </div>

    </div>
    
                     <!-- Displaying the due list for that particular date if any -->
    
    
    <div ng-show="due">
    <div class="due">
     <%
    
     
     Calendar c = Calendar.getInstance();
     SimpleDateFormat DATE_FORMAT1 = new SimpleDateFormat("dd-MM-yyyy");
    // c.add(Calendar.DATE,1);
     String date = DATE_FORMAT1.format(c.getTime());
     
     
     
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_de=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	                        ResultSet rs_de;
	                        PreparedStatement ps_de=con_de.prepareStatement("select * from Library where daystoreturn=? and status='a'");
	                        ps_de.setString(1,date);
		                      rs_de =ps_de.executeQuery();
		                      if(!rs_de.next())
		                      {
		                    	  out.println("<div class='message col-xs-offset-3 col-xs-6' >"+"<font style: color='green' size:3px>"+"There Are No Due Books Today "+"</font></div>");
		                    	  
		                      }
		                     
		                      
		               else{%>
            
            <table class = "table table-bordered">
	                      <thead>
                              <tr>
                                  <th class="col-sm-3 text">BookName</th>
                                  <th class="col-sm-2 text">Author</th>
                                  <th class="col-sm-2 text">Assigned Person</th>
                                  <th class="col-sm-2 text">Expected Return</th>
                                  <th class="col-sm-3 text">Email</th>
         
                              </tr>
                        </thead>
                   </table>
            
                               <div class="scroll">
                    <table class = "table table-striped table-bordered">
                     					      <%
                            Class.forName("com.mysql.jdbc.Driver");
	                        Connection con_d=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	
	                        ResultSet rs_d;

							
						 	
	                    
	                        
                              PreparedStatement ps_d=con_d.prepareStatement("select * from Library where status = 'a' and daystoreturn<=? order by daystoreturn desc");
		                      ps_d.setString(1,date);
                              rs_d =ps_d.executeQuery();
                              
                              
                              
                            while(rs_d.next())
                             {
                            	
	                     %>
                       
                       <tbody>
                          <tr>
                              <td class="col-sm-3"  > <%= rs_d.getString(1) %></td>
                              <td class="col-sm-2"> <%= rs_d.getString(2) %></td>
                              <td class="col-sm-2"> <%= rs_d.getString(3) %></td>
                              <td class="col-sm-2"><%= rs_d.getString(7) %></td>
                              <td class="col-sm-3"><%= rs_d.getString(8) %></td>
                
                
                        </tr>
	

                      </tbody>  

                            <%}
                            %> 
                            
                </table>
              </div>
    
            
            
            
          <%} %>  
            
            </div>  
            </div>  
            
            
            
            <!-- For sending mail alert to the users to return the assigned books on one day before -->
            
     <% 
       
       
      
       SendEmail obj =new SendEmail();
       
       Calendar c1 = Calendar.getInstance();
       SimpleDateFormat DATE_FORMAT2 = new SimpleDateFormat("dd-MM-yyyy");
       c.add(Calendar.DATE, 1);
       String date2 = DATE_FORMAT1.format(c.getTime());
       Class.forName("com.mysql.jdbc.Driver");
       Connection con_demail=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
       PreparedStatement ps_demail=con_demail.prepareStatement("select distinct email from Library where status='a' and emailsent='F'and daystoreturn <=?");
       ps_demail.setString(1,date2);
       ResultSet rs_demail =ps_demail.executeQuery();
       String email=null;
     
       while(rs_demail.next())
        {
    	   PreparedStatement ps_email=con_demail.prepareStatement("select * from Library where status='a' and emailsent='F'and daystoreturn <=? and email=?");
           ps_email.setString(1,date2);
           ps_email.setString(2,rs_demail.getString(1));
           ResultSet rs_email =ps_email.executeQuery();
          
           System.out.println("1"+rs_demail.getString(1));
           String books="";
       		while(rs_email.next())
       		{

       			books = books + rs_email.getString(1) +", ";
       		}
       		
       		System.out.println(books);
       		PreparedStatement ps_semail=con_demail.prepareStatement("update Library set emailsent='T' where status = 'a' and daystoreturn <=? and emailsent='F' and email=? ");
     	   ps_semail.setString(1,date2);
     	  ps_semail.setString(2,rs_demail.getString(1));
     	     	   
         ps_semail.executeUpdate();
         
          obj.Email(rs_demail.getString(1),books);
        	
       	
        } 
  
      
     %>     
 

</div>

</body>
</html>
