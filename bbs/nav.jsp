<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nav.jsp</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
<link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-taget="#bs-example-collapse-1"
				aria-expanded="false">

				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="main.jsp" class="navbar-brand">JSP BBS</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li><a href="history.jsp">제작일지</a></li>
				<li><a href="bbs.jsp">BBS</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<%
					String sessionUserID = (String) session.getAttribute("userID");
				if (sessionUserID == null) {
				%>
				<li><a href="login.jsp">Login</a></li>
				<li><a href="join.jsp">Join us</a></li>
				<%
					} else {
				%>
				<li><a href="logout.jsp">Logout</a></li>
				<li><a href="myPage.jsp">my page</a></li>
				<%
				}	
				%>
				
				
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expandede="false"> Connecting <span class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li class="active" onclick="location.href = 'logout.jsp'"><a
							href="logout.jsp">Log-out</a></li>

					</ul></li>
			</ul>
		</div>
	</nav>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>