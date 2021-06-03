<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import ="bbs.userDAO, bbs.bbs" %>
	<%@page import="java.util.ArrayList"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsDelete.jsp</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
		System.out.println("userID :" + userID);
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
	%>
	<script>
		alert("This access is not correct");
		location.href = "bbs.jsp";
	</script>
	<%
		}

	userDAO userDAO = new userDAO();

	ArrayList<bbs> bbsView = userDAO.getBbsView(bbsID);

	System.out.println("==========bbsWiew.jsp================");
	System.out.println("bbsID : " + bbsView.get(0).getBbsID());
	System.out.println("userID : " + bbsView.get(0).getUserID());
	System.out.println("bbsTitle : " + bbsView.get(0).getBbsTitle());
	System.out.println("bbsDate : " + bbsView.get(0).getBbsDate());
	System.out.println("Hit : " + bbsView.get(0).getHit());

	if (!userID.equals(bbsView.get(0).getUserID())) {
	%>
	<script>
			alert("Denign");
			location.href = "bbsView.jsp?bbsID=<%=bbsID%>
		";
	</script>
	<%
		} //session 과 현재 글의 아이디 비교

	int k = userDAO.deleteBbs(bbsID);

	if (k == 1) {
	%>
	<script>
			alert("Sucess");
			location.href = "bbs.jsp";
	</script>
	<%
		} else if (k == -1) {
	%>
	<script>
		alert("DB error");
		location.href = "bbs.jsp";
	</script>
	<%
		}
		
	%>

	<h1>bbsDelete.jsp</h1>
</body>
</html>