<%@page import="config.configDirectory"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.bbs,bbs.userDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="file.fileDAO,file.fileDTO" %>
<%@page import ="java.io.File" %>
<%@page import="java.net.URLEncoder" %>
<%@page import = "config.configDirectory" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsView.jsp</title>
<style>
  summary {
    cursor: pointer;
  }

  /* 삼각형 없애기
  summary {
    list-style: none;
  }
  summary::-webkit-details-marker {
    display: none;
  }
  */
</style>
</head>
<body>
<jsp:include page="nav.jsp" />
	<%
		String userID = null;
	if (session.getAttribute("userID") == null) {
		%>
		<script>
			alert("please login");
			location.href = "login.jsp";
		</script>
		<%		
	}else{
		userID = (String)session.getAttribute("userID");
	}
	%>
	<%	int bbsID = 0;
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

	userDAO.plusHit(bbsID);
	ArrayList<bbs> bbsView = userDAO.getBbsView(bbsID);

	System.out.println("==========bbsWiew.jsp================");
	System.out.println("bbsID : " + bbsView.get(0).getBbsID());
	System.out.println("userID : " + bbsView.get(0).getUserID());
	System.out.println("bbsTitle : " + bbsView.get(0).getBbsTitle());
	System.out.println("bbsDate : " + bbsView.get(0).getBbsDate());
	System.out.println("Hit : " + bbsView.get(0).getHit());
	
	ArrayList<bbs> bbsCommentList = userDAO.getCommentList(bbsID);
	
	
	fileDAO fileDAO = new fileDAO();
	ArrayList<fileDTO> file = fileDAO.getFile(bbsID);	
	
	configDirectory fileDirectory = new configDirectory();
	String directory =fileDirectory.getUploadFileDirectory()+bbsID;	
	
	%>

	<h1>bbsView.jsp</h1>
	<div class="container">
		<div class="row" style="margin-bottom: 10px ">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">bbsView</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="20%">Title</td>
						<td><%=bbsView.get(0).getBbsTitle()%>[<%=bbsView.get(0).getHit()%>]</td>

					</tr>
					<tr>
						<td width="20%">Author</td>
						<td colspan="2"><%=bbsView.get(0).getUserID()%></td>
					</tr>
					<tr>
						<td width="20%">Date</td>
						<td colspan="2"><%=bbsView.get(0).getBbsDate().substring(0, 11)%></td>
					</tr>
					<tr>
						<td width="20%">file</td>
						<td colspan="2">
							<%
							File fileDir = new File(directory);
							String[] files ;
							if(fileDir.exists()){
								files = fileDir.list();
							
								for(int i=0 ;i<files.length;i++){
								%>
								<div>
									<a href="fileDownload.jsp?bbsID=<%=bbsID%>&fileRealName=<%=URLEncoder.encode(files[i], "utf-8")%>">
										<%=files[i]%>
									</a>
								</div> 	
								<%
								}
							}
							%>
							
						</td>
					</tr>
					<tr>
						<td width="20%" >Contents</td>
						<td colspan="2" style ="white-space: pre;  text-align: left"><div style="min-height: 350px; text-align: left"><%=bbsView.get(0).getBbsContents()%>	</div></td>
					</tr>
				</tbody>
			</table>
			<div><!-- 버튼리스트 -->
			<%
				if(userID !=null){
				if (userID.equals(bbsView.get(0).getUserID())) {
			%>
			<a href="bbsModify.jsp?bbsID=<%=bbsID%>" class="btn btn-primary" style="margin: 5px">Modify</a>
			<a href="bbsDelete.jsp?bbsID=<%=bbsID%>" class="btn btn-primary" style="margin: 5px">Delete</a>
			<a href="#" class="btn  pull-right" style="margin: 5px; border: 0px;" 
					onclick = "alert('니가썼음')">BAD&nbsp;<%=bbsView.get(0).getBad()%></a>					
			<a href="#" class="btn  pull-right"style="margin: 5px;  border: 0px;" 
					onclick = "alert('니가썼음')">GOOD&nbsp;<%=bbsView.get(0).getGood() %></a>
			<%
				}else{
					%>
					<a href="#" class="btn btn-primary pull-right" style="margin: 5px; border: 0px;" 
					onclick = "location.href='goodAndBadAction.jsp?goodAndBad=bad&bbsID=<%=bbsID%>'">BAD&nbsp;<%=bbsView.get(0).getBad()%></a>					
					<a href="#" class="btn btn-primary pull-right"style="margin: 5px;  border: 0px;" 
					onclick = "location.href='goodAndBadAction.jsp?goodAndBad=good&bbsID=<%=bbsID%>'">GOOD&nbsp;<%=bbsView.get(0).getGood() %></a>
					<%
				}}
			%>
			<a href="bbs.jsp" class="btn btn-primary pull-right"style="margin: 5px;  border: 0px;">bbs</a>
		</div><!-- 버튼리스트 -->
		
		</div>


		<div  class="row" style="border-top: 1px solid #cccccc; padding-top: 10px"><!-- comment 작성 -->
		<form action="writeComment.jsp" method="post" >
			<input type = "hidden" name = "parentBbsID" value ="<%=bbsID %>" >					
			<input type = "hidden" class="form-control" name = "userID" value ="<%=userID %>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
					<tr>
						<th colspan = "2">comment writer</th>
					</tr>
				</thead>
				<tbody>					
					<tr>
						<td width ="10%">Title : </td>
						<td>
							<input type = "text" class="form-control" name = "bbsTitle" value ="<%="re."+bbsView.get(0).getBbsTitle()%>" >
						</td>
					</tr>
					<tr>
						<td width ="10%">Comment : </td>
						<td>
							<textarea class="form-control" style="min-height: 20px" name = "bbsContents"></textarea>
							<input type ="submit" class = "btn pull-right" value="Write">
						</td>						
					</tr>				
				</tbody>
			</table>
		</form>		
	</div>
	<div>
		<div style="margin-bottom: 10px; font-size: 15px;">Comment &nbsp; [<%=userDAO.countComment(bbsID)%>] </div>
	</div>
	<div class = "row">
		<ul>
			<%
			for (int i = 0; i < bbsCommentList.size(); i++) {			
			%>
			<li style="border-bottom: 1px solid #cccccc; margin-bottom: 10px; padding-bottom: 10px; ">				
				<div>
					<span>
						<%=bbsCommentList.get(i).getUserID()%>
					</span> 
					<span style="color: blue;">
						&nbsp;|&nbsp; 
					</span> 
					<span>
						<%=bbsCommentList.get(i).getBbsTitle() %>
					</span>
				</div>
				<div><%=bbsCommentList.get(i).getBbsContents() %></div>
				<div style ="font:8px gray ">
					<span><%=bbsCommentList.get(i).getBbsDate()%></span>
				</div>
				<div>
						<div>
							<!-- 버튼리스트 -->
							<%
								
								if (userID.equals(bbsCommentList.get(i).getUserID())) {
							%>
							<a href="bbsModify.jsp?bbsID=<%=bbsCommentList.get(i).getBbsID()%>" class=""
								style="margin: 5px">Modify</a> <a
								href="bbsDelete.jsp?bbsID=<%=bbsCommentList.get(i).getBbsID()%>" class="b"
								style="margin: 5px">Delete</a> <a href="#"
								class="btn  pull-right" style="margin: 5px; border: 0px;"
								onclick="alert('니가썼음')">BAD&nbsp;<%=bbsCommentList.get(i).getBad()%></a>
							<a href="#" class="btn  pull-right"
								style="margin: 5px; border: 0px;" onclick="alert('니가썼음')">GOOD&nbsp;<%=bbsCommentList.get(i).getGood()%></a>
							<%
								} else {
							%>
							<a href="#" class="btn btn-primary pull-right"
								style="margin: 5px; border: 0px;"
								onclick="location.href='goodAndBadAction.jsp?goodAndBad=bad&bbsID=<%=bbsCommentList.get(i).getBbsID()%>'">BAD&nbsp;<%=bbsCommentList.get(i).getBad()%></a>
							<a href="#" class="btn btn-primary pull-right"
								style="margin: 5px; border: 0px;"
								onclick="location.href='goodAndBadAction.jsp?goodAndBad=good&bbsID=<%=bbsCommentList.get(i).getBbsID()%>'">GOOD&nbsp;<%=bbsCommentList.get(i).getGood()%></a>
							<%
								}
							
							%>
						
						</div>
						<!-- 버튼리스트 -->
						
				</div>	<!--댓글보기/ gooo/bad 버튼 -->	
				<%
			ArrayList<bbs> reCommentList = userDAO.getCommentList(bbsCommentList.get(i).getBbsID());
				%>
				<details>
				<summary>
				<div style="color:#333399">					
						 댓글보기[<%=userDAO.countComment(bbsCommentList.get(i).getBbsID()) %>]		
				</div>	
				</summary>
			
				<ul class = "">
				
					<div style="margin-top: 10px">
					
						<form action="writeComment.jsp" method="post">
							<input type="hidden" name="parentBbsID" value="<%=bbsCommentList.get(i).getBbsID()%>">
							<input type="hidden" class="form-control" name="userID"
								value="<%=userID%>">
							<table class="table table-striped"
								style="text-align: center; border: 1px solid #dddddd;">
								<thead class="table table-striped"
									style="text-align: center; border: 1px solid #dddddd;">
									<tr>
										<th colspan="2">comment writer</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td width="10%">Title :</td>
										<td><input type="text" class="form-control"
											name="bbsTitle"
											value="<%="re."+bbsCommentList.get(i).getBbsTitle()%>"></td>
									</tr>
									<tr>
										<td width="10%">Comment :</td>
										<td><textarea class="form-control"
												style="min-height: 20px" name="bbsContents"></textarea> <input
											type="submit" class="btn pull-right" value="Write"></td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
					
			<%
			for (int k = 0; k < reCommentList.size(); k++) {			
			%>
			<li style="border-top: 1px solid #cccccc;  padding-bottom: 10px">				
				<input type ="hidden" >
				<div>
					<span>
						<%=reCommentList.get(k).getUserID()%>
					</span> 
					<span style="color: blue;">
						&nbsp;|&nbsp; 
					</span> 
					<span>
						<%=reCommentList.get(k).getBbsTitle() %>
					</span>
				</div>
				<div><%=reCommentList.get(k).getBbsContents() %></div>
				<div style ="font:8px gray ">
					<span><%=reCommentList.get(k).getBbsDate()%></span>
					
				</div>
					<div>	<!-- 버튼리스트 -->
							<%
								if (userID.equals(reCommentList.get(k).getUserID())) {
							%>
							<a href="bbsModify.jsp?bbsID=<%=reCommentList.get(k).getBbsID()%>" class=""
								style=" ">Modify</a> 
							<a	href="bbsDelete.jsp?bbsID=<%=reCommentList.get(k).getBbsID()%>" class=""
								style="">Delete</a> 
							<a href="#"	class="  pull-right" style="margin: 5px; border: 0px;"
								onclick="alert('니가썼음')">BAD&nbsp;<%=reCommentList.get(k).getBad()%></a>
							<a href="#" class="  pull-right" style="margin: 5px; border: 0px;" 
								onclick="alert('니가썼음')">GOOD&nbsp;<%=reCommentList.get(k).getGood()%></a>
							<%
								} else {
							%>
							<a href="bbsModify.jsp?bbsID=<%=reCommentList.get(k).getBbsID()%>" class="btn btn-primary"
								style=" visibility:hidden">Modify</a> 
							<a	href="bbsDelete.jsp?bbsID=<%=reCommentList.get(k).getBbsID()%>" class="btn btn-primary"
								style=" visibility:hidden">Delete</a> 
							<a href="#" class="btn btn-primary pull-right"
								style="margin: 5px; border: 0px;"
								onclick="location.href='goodAndBadAction.jsp?goodAndBad=bad&bbsID=<%=reCommentList.get(k).getBbsID()%>'">BAD&nbsp;<%=reCommentList.get(k).getBad()%></a>
							<a href="#" class="btn btn-primary pull-right"
								style="margin: 5px; border: 0px;"
								onclick="location.href='goodAndBadAction.jsp?goodAndBad=good&bbsID=<%=reCommentList.get(k).getBbsID()%>'">GOOD&nbsp;<%=reCommentList.get(k).getGood()%></a>
							<%
								}
							%>
						</div> <!-- 버튼리스트 -->					
					</li>
			<%} %>
				</ul>	</details>			
				<%
			} 
			%>
			
			</li>
		</ul>	
	</div>
	</div>


</body>
</html>