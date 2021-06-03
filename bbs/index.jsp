<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBS making</title>
</head>
<body>
	<h1>Hello World~!!</h1>
	<%
	String sessionUserID = (String) session.getAttribute("userID");
	if (sessionUserID != null) {
		System.out.println(sessionUserID);
	%><script type="text/javascript">
		location.href = 'main.jsp';
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		location.href = 'login.jsp';
	</script>
	<%
	}
	%>
</body>
</html>