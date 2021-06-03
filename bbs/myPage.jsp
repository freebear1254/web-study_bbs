<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import ="bbs.userDAO"  %>
    <%@page import="java.util.Vector" %>
    <%@page import="bbs.user" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage.jsp</title>
</head>
<body>
<jsp:include page="nav.jsp"/>
<jsp:useBean id="user" class="bbs.user"/>
<jsp:setProperty property="*" name="user"/>

<%
	String sessionUserID = (String)session.getAttribute("userID");
	if(sessionUserID == null){
		%><script>
			alert("Login please");
			location.href ="login.jsp";
		</script><%
	}// login 여부 확인
	
	userDAO userDAO = new userDAO();
	Vector<user> userViewVector = userDAO.userView(sessionUserID);
	user = (user)userViewVector.elementAt(0);
	
	System.out.println(user.getUserID());
	
	
%>
  
<article class="container">
            <div class="page-header">
                <div class="col-md-6 col-md-offset-3">
                <h3>Join us</h3>
                </div>
            </div>
            <div class="col-sm-6 col-md-offset-3">
                <form role="form" action="changeUserInfo.jsp" method="post" name ="join">
               		<div class="form-group">
                        <label for="userID">ID</label>
                        <input type="text" class="form-control" id="userID" name ="userID" placeholder="<%=user.getUserID() %>"  value="<%=user.getUserID() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label for="userName">name</label>
                        <input type="text" class="form-control" id="userName" name="userName" placeholder="<%=user.getUserName()%>" value="<%=user.getUserName()%>">
                    </div>        
                    <div class="form-group">
                        <label for="inputPassword">password</label>
                        <input type="password" class="form-control" id="inputPassword" name ="userPassword" placeholder="<%=user.getUserPassword()%>" value="<%=user.getUserPassword()%>">
                    </div>
                    <div class="form-group">
                        <label for="inputPasswordCheck">return password</label>
                        <input type="password" class="form-control" id="inputPasswordCheck" placeholder="<%=user.getUserPassword()%>" value="<%=user.getUserPassword()%>">
                    </div>
                   
                    <div class="form-group">
                        <label for="eMail">Email</label>
                        <input type="text" class="form-control" id="eMail" name="userEmail" placeholder=" <%=user.getUserPassword()%>" value="<%=user.getUserEmail()%>">
                    </div> 
                    
                    <div class ="mapAPI"><!-- map api 사용 -->
                        <label for="sample6_postcode">Address</label>
						<input type="button" onclick="sample6_execDaumPostcode()" value="Zip-code">
                    	<input type="text" id="sample6_postcode" class="form-control" name = "zipcode" placeholder="<%=user.getZipcode()%>" value="<%=user.getZipcode() %>" readonly>
						<input type="text" id="sample6_address" class="form-control" name ="addr1" placeholder="<%=user.getUserAddr()%>" value="<%=user.getUserAddr()%>" readonly>
						<input type="text" id="sample6_detailAddress" class="form-control" name="addr2" placeholder="상세주소">
						<input type="text" id="sample6_extraAddress" class="form-control" name ="addr3" placeholder="참고항목">
                    </div><!-- map api 사용 -->
       
                    <div class="form-group text-center">
                        <button type="button" id="join-submit" class="btn btn-primary" onclick="inputCheck()">
                            chage Info<i class="fa fa-check spaceLeft"></i>
                        </button>
                        <button type="reset" class="btn btn-warning">
                            Reset<i class="fa fa-times spaceLeft"></i>
                        </button>
                    </div>
                </form>
            </div>
     

        </article>
        
<script src = "mapapi.js"></script>      
<script src="inputCheck.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>