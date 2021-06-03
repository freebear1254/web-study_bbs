<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="bbs.userDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginAction.jsp</title>
</head>
<body>
	<jsp:useBean id="user" class="bbs.user" />
	<jsp:setProperty property="*" name="user" />
	
	
	
	<%
	userDAO userDAO = new userDAO();

	int k = userDAO.login(user.getUserID(), user.getUserPassword());

	System.out.println(k);

	if (k == 1) {
		out.print("로그인에 성공하였습니다.");
		String sessionID = user.getUserID();
		session.setAttribute("userID",sessionID);
	%><script type="text/javascript">
		 location.href = "main.jsp" ; 
		</script>
	<%
	} else if (k == 0) {
	out.print("비밀번호가 다릅니다.");
	%><script>
			alert("Wrong password!");
			location.href = "login.jsp";
		</script>
	<%
	} else if (k == -1) {
	out.print("없는 ID 입니다");
	%><script>
			alert("No ID");
			location.href = "login.jsp";
		</script>
	<%
	} else {
	out.print("DB 에 연동할 수 없습니다. ");
	%><script>
			alert("Sorry We can't connect DB");
			location.href = "login.jsp";
		</script>
	<%
	}
	%>
</body>
</html>