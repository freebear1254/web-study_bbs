<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.userDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkIDAction.jsp</title>
</head>
<body>

<h1>checkIDAction.jsp</h1>
<%
	System.out.println("======checkIDAction.jsp======");
	String userID = (String)request.getParameter("userID");
	userDAO userDAO = new userDAO();
	System.out.println("userID : "+userID);
	int isDoubleID = userDAO.checkID(userID);
	System.out.println("중복 체크 값 :"+isDoubleID);
	if(isDoubleID == 1){
		%>
			<script>
				alert("아이디 : <%=userID%>를 사용합니다.")
				opener.document.getElementById("userID").value = "<%=userID%>";
				window.close();
			</script>
		
		<%
		
	}else if(isDoubleID == 0){
		%>
			<script>
				alert("사용할 수 없는 ID 입니다.");
				location.replace("checkID.jsp");
			</script>
		<%		
	}else if(isDoubleID ==-1){
		%>
			<script >
				alert("오류가 발생하였습니다.");
				window.close();
			</script>
		<%
	}
%>


</body>
</html>