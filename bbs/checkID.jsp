<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkID.jsp</title>
</head>
<body>
<h1>checkID.jsp</h1>
<p>중복체크할 ID 를 입력해 주세요.</p>

<div>

	<form action="checkIDAction.jsp" name ="checkID" method ="post">
		<label for ="checkID">ID : </label>
		<input type ="text" name = "userID" id="checkID" maxlength="20">		
		<input type ="submit" value ="중복확인">
	</form>

</div>
</body>
</html>