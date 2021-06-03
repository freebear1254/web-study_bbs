<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>logout.jsp</title>
</head>
<body>
	<%
		String sessionUserID = (String) session.getAttribute("userID");
	if (sessionUserID != null) {
		System.out.println(sessionUserID);
		session.invalidate();
	}
	%>
	<script>
		alert("Log-out!");
		location.href = "index.jsp";
	</script>

</body>
</html>