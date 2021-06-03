<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write.jsp</title>
</head>
<body>

<%
String userID = null;
if(session.getAttribute("userID") !=null ){
	userID = (String)session.getAttribute("userID");
}else{
	%>
	<script>
		alert("Log-in please");
		location.href ="login.jsp";
	</script>
	<%
}

%>
<jsp:include page="nav.jsp"/>
<h1>write.jsp</h1>
 <div class="container">
        <div class="row">
        <form action="bbsWriteAction.jsp" method="post" enctype="multipart/form-data">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
                <thead>
                    <tr>
                        <th colspan = "2" style="background-color: #eeeeee; text-align: center;" >Write</th>                                         
                    </tr>
                 </thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="title" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td>
							<input type ="file" Name = "file1">
							<input type ="file" Name = "file2">
							<input type ="file" Name = "file3">
							</td>
						</tr>
						<tr>
							<td><textarea class="form-control"
									placeholder="contents" name="bbsContents" maxlength="2000" style="height : 350px"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type ="submit" class = "btn btn-primary pull-right" value="Write">
            </form>
            
        </div>
    </div>

</body>
</html>