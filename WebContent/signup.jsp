<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Signup</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> 
<script  src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.9/angular.min.js"></script>
<link rel="stylesheet" href="signup.css">
</head>


<script>
var app = angular.module('myapp', ['UserValidation']);

angular.module('UserValidation', []).directive('validPasswordC', function () {
    return {
        require: 'ngModel',
        link: function (scope, elm, attrs, ctrl) {
            
              ctrl.$setValidity('noMatch', true);

                attrs.$observe('validPasswordC', function (newVal) {
                    if (newVal == 'true') {
                        ctrl.$setValidity('noMatch', true);
                    } else {
                        ctrl.$setValidity('noMatch', false);
                    }
                });
        }
    }
})
</script>

<body>
<div ng-app="myapp">
	<div class="topnavContainer"></div>
	
				<div class="col-xs-8">
       							<div class="message form-group" >
          
									<%
										String login_msg=(String)request.getAttribute("error");  
             							if(login_msg!=null)
              							out.println("<div class='col-xs-offset-6 col-xs-6'>"+"<font color=red size=3px>"+login_msg+"</font></div>");
               						%>
		  						</div>
      						</div>
      						<div class="col-xs-8">
       							<div class="message form-group" >
          
									<%
										String msg=(String)request.getAttribute("success");  
             							if(msg!=null)
              							out.println("<div class='col-xs-offset-6 col-xs-6'>"+"<font color=green size=3px>"+msg+"</font></div>");
               						%>
		  						</div>
      						</div>
      	<div class = "signup">
		<div class="col-xs-offset-4 col-xs-6">

  			<div class="panel ">
  			<div class="panel-heading"><h3>Signup Form</h3></div>
  				<div class="panel-body">
   					<div class="form-horizontal">
    					<form name="myForm" action ="/Registration/register" method = "post">
    					
      						
        					<div  class="col-xs-8">
								<div class="form-group">
			 						 <div class="input-group">
										<span class="input-group-addon">
                       						 <i class="glyphicon glyphicon-envelope"></i>
                						</span>
               						 	<input type="email" id="email" name="email" ng-model="formData.email" placeholder = "Email" required/> 
                 					</div>
                					<span ng-show="myForm.email.$error.required && myForm.email.$dirty">required</span>                
                					<span ng-show="!myForm.email.$error.required && myForm.email.$error.email && myForm.email.$dirty">invalid email</span>                   
           						</div>
        					</div>
       
        					<div  class="col-xs-8">
								<div class="form-group">
			  						<div class="input-group">
										<span class="input-group-addon">
                        					<i class="glyphicon glyphicon-user"></i>
                						</span>
                						<input type="text" id="Employee_ID" name="Employee_ID" ng-model="formData.Employee_ID"  placeholder = "Employee_ID"  required/>
                 					</div>
                 					<span ng-show="myForm.Employee_ID.$error.required && myForm.Employee_ID.$dirty">required</span>
             
           					 	</div>
       						</div>

       						<div  class="col-xs-8">
								<div class="form-group">
			  						<div class="input-group">
										<span class="input-group-addon">
                        					<i class="glyphicon glyphicon-lock"></i>
                						</span>
                
                						<input type="password" id="password" name="password"  placeholder = "Password" ng-model="formData.password" ng-minlength="8" ng-maxlength="20" ng-pattern="/(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z])/" required />
                 					</div>
                 					<span ng-show="myForm.password.$error.required && myForm.password.$dirty">required</span>
                					<span ng-show="!myForm.password.$error.required && (myForm.password.$error.minlength || myForm.password.$error.maxlength) && myForm.password.$dirty">Passwords must be between 8 and 20 characters.</span>
                					<span ng-show="!myForm.password.$error.required && !myForm.password.$error.minlength && !myForm.password.$error.maxlength && myForm.password.$error.pattern && myForm.password.$dirty">Must contain one lower &amp; upper case letter, and one non-alpha character (a number or a symbol.)</span>
             
             
           						</div>
       						</div>

       						<div  class=" col-xs-8">
								<div class="form-group">
			 						 <div class="input-group">
										<span class="input-group-addon">
                       			 			<i class="glyphicon glyphicon-lock"></i>
                						</span>
                						<input type="password" id="password_c" name="password_c" ng-model="formData.password_c" placeholder = "Confirm_Password"  valid-password-c="{{formData.password==formData.password_c}}"  required />
                  					</div>
                 					<span ng-show="myForm.password_c.$error.required && myForm.password_c.$dirty">Please confirm your password.</span>
                               
               						<span ng-show="!myForm.password_c.$error.required && myForm.password_c.$error.noMatch && myForm.password_c.$dirty">Passwords do not match.</span>
            
           						</div>
       						</div>
       						
		
      <div class="form-group">
        <div class="col-xs-8">
          <button type="submit" class="btn btn-primary "  ng-disabled="myForm.$invalid">Submit</button>
        </div>
     </div>
       
   </form>
</div>
</div>
</div>
</div>
</div>
</div>
</body>

</html>
