<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.userDAO, bbs.bbs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="config.configDirectory" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsModify.jsp</title>
</head>
<body>
<jsp:include page="nav.jsp"></jsp:include>
<%
	String userID = null;
	if(session.getAttribute("userID") !=null ){
		userID = (String)session.getAttribute("userID");
		System.out.println("userID " +userID);
	}
	int bbsID = 0;
	if(request.getParameter("bbsID") !=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID ==0){
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
	System.out.println("bbsID : " +bbsView.get(0).getBbsID());
	System.out.println("userID : " +bbsView.get(0).getUserID());
	System.out.println("bbsTitle : " +bbsView.get(0).getBbsTitle());
	System.out.println("bbsDate : " +bbsView.get(0).getBbsDate());
	System.out.println("Hit : " +bbsView.get(0).getHit());
	
	if(!userID.equals(bbsView.get(0).getUserID())){
		%>
		<script>
			alert("Denign");
			location.href = "bbsView.jsp?bbsID=<%=bbsID%>";
		</script>
	<%
	}
	configDirectory fileDirectory = new configDirectory();
	String directory = fileDirectory.getUploadFileDirectory() +bbsID;
	
 	

%>
<h1>bbsModify.jsp</h1>
<div class="container">
        <div class="row">
        <form action="bbsModifyAction.jsp?bbsID=<%=bbsID%>" method="post" enctype="multipart/form-data">
        
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
                <thead>
                    <tr>
                        <th colspan = "2" style="background-color: #eeeeee; text-align: center;" >Modify</th>                                         
                    </tr>
                 </thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="title" name="bbsTitle" maxlength="50" value="<%=bbsView.get(0).getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td>
							<input type ="file" Name = "file">
							</td>
						</tr>
						<tr>
							<td>
								<%
							File fileDir = new File(directory);
							String[] files ;
							if(fileDir.exists()){
								files = fileDir.list();							
								for(int i=0 ;i<files.length;i++){
								%>
								<div>
								<a href = "fileDownload.jsp?bbsID=<%=bbsID%>&fileRealName=<%=URLEncoder.encode(files[i],"utf-8")%>">
									<%=files[i] %>
								</a>
								
								<a href = "fileDeleteAction.jsp?bbsID=<%=bbsID%>&fileRealName=<%=URLEncoder.encode(files[i],"utf-8")%>"
									style="font : 15px;" title ="삭제" class="pull-right">
									&nbsp;&nbsp;&nbsp;&nbsp;X&nbsp;&nbsp;&nbsp;&nbsp; 
								</a>
								</div>							
								<%
								}
							}
							%>
							</td>
						</tr>
						<tr>
							<td><textarea class="form-control"
									placeholder="contents" name="bbsContents" maxlength="2000" style="height : 350px"><%=bbsView.get(0).getBbsContents() %></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type ="submit" class = "btn btn-primary pull-right" value="Modify">
            </form>
            
        </div>
    </div>


</body>
</html>