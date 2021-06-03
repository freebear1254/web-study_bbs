<%@page import="java.util.ArrayList"%>
<%@page import="bbs.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.bbs"%>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.pageBtn {
		
		text-align: center;
	}
	th{
		background-color: #eeeeee;
		text-align: center;
	}
</style>
<title>bbs.jsp</title>
</head>
<body>

	<%
	int pageNumber = 1;
	int listLimit =5; // 1페이지 게시판 출력 수 
	String searchType =null;
	String searchCon=null;
	String searchSql =null;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("searchCon") != null){
		searchCon =request.getParameter("searchCon");
	}
		
	
	System.out.println(searchType + "  "+searchCon);
	
	
	if(searchType !=null){
		if(searchType.equals("bbsContents")){
			searchSql = "AND (bbsTitle LIKE '%" +searchCon+ "%' OR bbsContents LIKE '%"+searchCon+"%')";
		}else{searchSql = "AND " + searchType + " LIKE '%" +searchCon+ "%'";}		
	}else{
		searchSql ="";
	}
	
	
	System.out.println("searchSql :"+searchSql);
	
	userDAO userDAO = new userDAO();
	
	ArrayList<bbs> bbsList = userDAO.getList(pageNumber,listLimit,searchSql);
	
	
	%>


	<jsp:include page="nav.jsp" />
	<h1>bbs.jsp</h1>
	<div class ="container" style ="text-align: center; ">
		<form action="bbs.jsp"method="get">
			<select name = "searchType">
				<option value="userID">Author</option>
				<option value="bbsTitle">Title</option>
				<option value="bbsContents">Title + Contents</option>				
			</select>
			<input type="text" name="searchCon" placeholder="search">
			<input type = "submit" value="search">
		</form>
	</div>
	
	<div class="container">
		<div class="row">
		
		<a href="write.jsp" class="btn btn-primary pull-right">Write</a>
		
		
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center; width:10%">번호</th>
						<th style="background-color: #eeeeee; text-align: center; width:40% ">title</th>
						<th style="background-color: #eeeeee; text-align: center; width:20%">Authore</th>
						<th style="background-color: #eeeeee; text-align: center; width:20%">date</th>
						<th style="background-color: #eeeeee; text-align: center; width:5%">hit</th>
						<th style="background-color: #eeeeee; text-align: center; width:5%">good</th>
						<th style="background-color: #eeeeee; text-align: center; width:5%">bad</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < bbsList.size(); i++) {					
						
					%>
					<tr>
						<td><%=bbsList.get(i).getBbsID() %></td>
						<td>
						<a href = "bbsView.jsp?bbsID=<%=bbsList.get(i).getBbsID()%>"> 
						<%=bbsList.get(i).getBbsTitle().replaceAll("<", "&lt;")%>						
						</a>
						</td>
						<td><%=bbsList.get(i).getUserID() %></td>
						<td><%=bbsList.get(i).getBbsDate() %></td>
						<td><%=bbsList.get(i).getHit() %></td>
						<td><%=bbsList.get(i).getGood() %></td>
						<td><%=bbsList.get(i).getBad()%></td>
					</tr>
					<%
						}
					%>

				</tbody>
			</table><!-- 게시판 목록 출력 -->
			<div class = "pageBtn">
			<%
			System.out.println(pageNumber);
			String link; 
			if(searchType !=null){
				 link = "bbs.jsp?searchType="+searchType+"&searchCon="+searchCon+"&pageNumber=";
			}else{
				link = "bbs.jsp?pageNumber=";
			}
				
			if(pageNumber !=1){
				%>
				<a href = "<%=link+(pageNumber-1) %>" class="btn btn-primary">prev</a>	
				<%
			}else {
				%>
				
				<a href = "<%=link+(pageNumber) %>" class="btn btn-primary" onclick ="alert('first page');">prev</a>	
				<%
			}
			%>
			<%
				for(int i =3; i>0 ; i--){
					if(pageNumber>i){
						%>
							<a href = "<%=link + (pageNumber-i)%>"><%=pageNumber-i%></a>	
						<%
							}	
				}
			%>			
			<span style="font-size: 15px"><%=pageNumber%></span>

			<%
				for (int i = 1; i < 4; i++) {
					if (userDAO.isNextPage(pageNumber + i, listLimit, searchSql)) {
				%>
					<a href="<%=link + (pageNumber + i)%>"><%=pageNumber + i%></a>
				<%
					}
				}
			%>

			<%	
			if(userDAO.isNextPage(pageNumber+1,listLimit,searchSql)){
			%>
				<a href = "<%=link + (pageNumber+1)%>" class="btn btn-primary">next</a>	
			<%
				}else{
					%>
					
					<a href = "<%=link + (pageNumber)%>" class="btn btn-primary" onclick ="alert('last page');">next</a>	
					<%
				}			
			%>
			</div>
			
		</div>
	</div>
</body>
</html>