<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="en" ng-app="MyApp">
<head>
	
  <title>Sign</title>
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
angular.module('MyApp', [])
.controller('MainController', [ '$scope', function($scope) {
	$scope.myVar=false;
	$scope.myvar=false;
$scope.ShowBooks = function() {
$scope.myvar= !$scope.myvar;
};
$scope.toggle = function() {
$scope.myVar=!$scope.myVar;
};
  
  
$scope.removeRow = function(name){				
		var index = -1;		
		var comArr = eval( $scope.rows );
		for( var i = 0; i < comArr.length; i++ ) {
			if( comArr[i].Book === name ) {
				index = i;
				break;
			}
		}
		if( index === -1 ) {
			alert( "Something gone wrong" );
		}
		$scope.rows.splice( index, 1 );		
	};
$scope.exportdata= function() {

 var blob = new Blob([document.getElementById('exportable').innerHTML], {
            type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8"
        });
        saveAs(blob, "BooksList.xls");
    };
   
}]);
</script> 

<body ng-controller="MainController">
</br></br>
<div class = "col-xs-6"></div>
<div class = "col-xs-4">
<p align = "right" ><span class="glyphicon glyphicon-ok"></span> Welcome <%= session.getAttribute("email") %></p></div>
<% 
//allow access only if session exists

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
<div class="library">
<div class ="main-menu">
		    <div class="panel-heading" ><h2 align = "center">Vedams Library</h2></div>
		    </div>
		</div>
<header class="primary-header container group">
<nav class="navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Books Info</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li class="active" ng-click="toggle()"><button class = "btn btn-primary" ><span class="glyphicon glyphicon-pencil"></span> Add Books</button></li> 
        <li ><form action = "/Registration/logout" method="post"><button class = "btn btn-primary" type = "submit"><span class="glyphicon glyphicon-user"></span> SignOut</button></form></li>
        
      </ul>
    </div>
  </div>
</nav>
 </header>
<div class="container" >

<!--  Adding of Books-->
<div class="col-xs-offset-4 col-xs-6">
			<%String login=(String)request.getAttribute("bookerror");  
             if(login!=null)
              out.println("<font color=red size=3px>"+login+"</font>");
               %>
		</div>
<div ng-show="myVar">
<div class="panel panel-info">
  <div class="panel-heading">Signup</div>
  <div class="panel-body">
   <div class="form-horizontal">

	<form class="form-horizontal" name="myForm" action ="/Registration/data" method = "post">
      		<div class="form-group">
        		<label for="inputEmail" class="control-label col-xs-4"> Book Name <span class="glyphicon glyphicon-list-alt"></span> </label>
           <div class="col-xs-6">
          			<input class="form-control" id="inputName3" name="book" ng-model="Book" placeholder="Book Name" required>

        		</div>
      		</div>
      		<div class="form-group">
        		<label for="inputEmail" class="control-label col-xs-4"> Author <span class="glyphicon glyphicon-user"></span> </label>
           <div class="col-xs-6">
          			<input class="form-control" id="inputEmail3" name="author" ng-model="Author" placeholder="Author Name" required>
       			 </div>
      		</div>
      		<div class="form-group">
        		<label for="inputEmail" class="control-label col-xs-4"> Assign To <span class="glyphicon glyphicon-user"></span> </label>
           <div class="col-xs-6">
          		<input class="form-control" id="inputPassword3" name="person" ng-model="person" placeholder="Person name" required>
        		</div>
      		</div>
      		
      		<div class="form-group-primary">
        <div class="col-xs-offset-4 col-xs-6">
        <button  class="btn btn-primary" >Submit</button>
       </div>
       </div>
</form>
</div>
</div>
</div>
</div>


<div class="col-xs-offset-4 col-xs-6">
			<%String login_msg=(String)request.getAttribute("liberror");  
             if(login_msg!=null)
              out.println("<font color=red size=3px>"+login_msg+"</font>");
               %>
		</div>
<br>
<br>
<br>
<!-- Searching particular book from assigned book table -->
<form method="post" action="/Registration/Search">
<div class="row" >
        <div class="col-sm-5">
            <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Search&hellip;">
                <span class="input-group-btn">
                    <button type="submit"  class="btn btn-primary"><span class = "glyphicon glyphicon-search"></span> Search</button>
                </span>
            </div>
        </div>
        </div>
</form>
<h3 align="center"><b>List of books which are assigned </b></h3>

<!-- getting the value typed in search box -->

<% String bookname =(String)request.getAttribute("booksearch");%>
<div id="exportable">
<div id="table-wrapper">
<div id="table-scroll">
<table class = "table table-bordered">
	<thead>
    <tr>
      <th class="col-xs-3" class="text">BookName</th>
      <th class="col-xs-3" class="text">Author</th>
      <th class="col-xs-3" class="text">Assigned Person</th>
      <th class="col-xs-3" class="text">Date</th>
   <th scope="col" class="col-sm-2">Remove</th>
      
    </tr>
  </thead>
 <%
 Class.forName("com.mysql.jdbc.Driver");
	Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","root");
	
	
	 
	 
	ResultSet rs;
	
	if(bookname!=null)
	{
		PreparedStatement ps1=con1.prepareStatement("select * from Library where bookname=?"); 
		ps1.setString(1, bookname);
		 rs =ps1.executeQuery();
		 
		
	}
	else
	{
		PreparedStatement ps2=con1.prepareStatement("select * from Library");
		rs =ps2.executeQuery();
	
	}
	
	
 

%>
<% while(rs.next()){
	String book=rs.getString(1);
	
	%>
<tbody>
   <tr>
                <td class="col-sm-3"name="book"> <%= rs.getString(1) %></td>
                <td class="col-sm-3"> <%= rs.getString(2) %></td>
               <td class="col-sm-3"> <%= rs.getString(3) %></td>
               <td class="col-sm-3"> <%= rs.getString(4) %></td>
               
               <td>
               <form method="post" action="/Registration/Delete">
               <div>
               <input type="hidden" name="bookname" value="<%=book%>" />
               <button type="submit" class="btn btn-primary">
               <span class="glyphicon glyphicon-remove"></span> Delete</button>
               </div>
               </form>
               </td>
               
                
   </tr>
	

</tbody>  

<%}

	%> 


				
  		

</table>
</div>
</div>
</div>
<br>
<br>

<button class="btn btn-link" ng-click="exportdata()" >
        <span class="glyphicon glyphicon-share"></span> Generate Excel
    </button>
</div>




</body>
</html>