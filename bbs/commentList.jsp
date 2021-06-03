<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="bbs.userDAO,bbs.bbs" %>
    <%@page import ="java.util.ArrayList" %>
    <%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
int bbsID =Integer.parseInt(request.getParameter("bbsID"));

userDAO userDAO = new userDAO();
ArrayList<bbs> bbsCommentList = userDAO.getCommentList(bbsID);
%>

	<div class = "row comment">
		<ul>
			<%
			for (int i = 0; i < bbsCommentList.size(); i++) {	
				int thisBbsID = bbsCommentList.get(i).getBbsID();
			%>
			<li>				
				<input type ="hidden" >
				<div><span><%=bbsCommentList.get(i).getUserID() %></span> <span style="color: blue;">&nbsp;|&nbsp; </span> <span><%=bbsCommentList.get(i).getBbsTitle() %></span></div>
				<div><%=bbsCommentList.get(i).getBbsContents() %></div>
				<div style ="font:8px gray "><span><%=bbsCommentList.get(i).getBbsDate()%></span></div>
				<div>
					<a href ="#" class ="btn" onclick="include" style ="display: inline-block; background-color:#dddddd; font : white; margin: 0; padding:0;"> 댓글보기<% %></a>
					<div style="text-align: right;">
						<span><a class ="btn " style="background-color: #cccccc" href = "goodAndBadAction.jsp?bbsID=<%=bbsCommentList.get(i).getBbsID()%>&goodAndBad=good">Good :<%=bbsCommentList.get(i).getGood()%></a></span>
						<span><a class ="btn " style="background-color: #cccccc" href = "goodAndBadAction.jsp?bbsID=<%=bbsCommentList.get(i).getBbsID()%>&goodAndBad=bad">Bad :<%=bbsCommentList.get(i).getBad()%></a></span>
					</div>				
				</div>	
				<iframe id = "<%=bbsCommentList.get(i).getBbsID()%>">	</iframe>
				<script>
					function include() {
						document.getElementById("<%=bbsCommentList.get(i).getBbsID()%>").src = "naver.com";
					}
				</script>
		
			</li>
			<%
					}
			%>	
		</ul>	
	</div>


</body>
</html>