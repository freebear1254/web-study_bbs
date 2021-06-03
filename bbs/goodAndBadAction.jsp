<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8"); %>
    <%@page import ="bbs.userDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodAndBadAction.jsp</title>
</head>
<body>
<h1>goodAndBadAction.jsp</h1>
<%
String goodAndBad = request.getParameter("goodAndBad");
int bbsID = Integer.parseInt(request.getParameter("bbsID"));
System.out.println("goodAndBad : " + goodAndBad);

userDAO userDAO = new userDAO();

if(goodAndBad.equals("bad")){
	userDAO.badAction(bbsID);
	%>
	<script>
		alert("비추 하셨습니다.");
		location.href = document.referrer; 
	</script>
	<%
}else if (goodAndBad.equals("good")){
	userDAO.goodAction(bbsID);
	%>
	<script>
		alert("추천 하셨습니다.");
		location.href = document.referrer; 
	</script>
	<%
}
%>

</body>
</html>