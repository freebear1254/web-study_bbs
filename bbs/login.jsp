<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>bbc - login.jsp</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		%>
		<script>
			alert("로그인이 되어 있습니다. ");
			location.href = "main.jsp";
		</script>
		<%		
	}else{
		userID = (String)session.getAttribute("userID");
	}
	%>
<jsp:include page="nav.jsp"></jsp:include>
	
    <div class = "container">
    	<div class ="col-lg-4"></div>
    	<div class = "col-lg-4">
    		<div class = "jumbotron" style="padding-top : 20px;">
    			<form action="loginAction.jsp" method="post">
    				<h3 style = "text-align : center"> Log - in</h3>
    				<div class = "form-grup">
    					<input type="text" class="form-control" placeholder="ID" name="userID" maxlength="20">
    				</div>
    				<div class = "form-grup">
    					<input type="password" class="form-control" placeholder="Password" name="userPassword" maxlength="20">
    				</div>    
    				<input type="submit" class ="btn btn-primary form-control" value="Log in">	
    							
    			</form>
			</div>
     	</div>
		<div class="col-lg-4"></div>
	</div>



</body>
</html>