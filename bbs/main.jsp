<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>main.jsp</title>
<style >

</style>
</head>
<body>
	
	<%
	String sessionUserID = (String) session.getAttribute("userID");
	if (sessionUserID != null) {
		System.out.println(sessionUserID);
	%><script>
			alert("Welcome <%=sessionUserID%>");
		</script>
	<%
	} else {
	%><script>
			alert("Log-in Please");
			location.href = 'login.jsp';
		</script>
	<%
	}
	%>
	<jsp:include page="nav.jsp"/>
	
	<h1>main.jsp</h1>
	
	
	
	<article class="container">
	<h2>BBS 게시판 만들기 소개</h2>
	<hr>
		<h3>회원가입 및 로그인</h3>
		<p>
		1.로그인시 아이디와 비번을 받아 확인하여 로그인 성공과 실패로 구분한다.
		<p> 
		2.로그인 성공시 해당 아이디를 세션에 기록하여 다른페이지에서도 참조하도록 한다.
		<p>
		3.회원정보를 받아 user table 에 insert/update/delete 할수 있게 한다
		<p>
		+ 주소부분의 외부 API 사용 및 적용
		</p>
		
		<h3>BBS 게시판 글목록 출력</h3>
		<p>
		1.bbs table 의 내용을 출력한다
		<p>	
		 - 조건 : visible = 1;	
		</p>
		
		<h3>BBS 게시판 페이징 처리</h3>
		<p>
		1.bbs table 의 내용을 date DECR 순으로 pageLimt 만큼 출력한다.
		<p>
		2.page 수가 더 있을경우 페이지에 번호를 매기고 앞 뒤 n개의 page 번호 링크를 추가한다.
		<p>
		3.p /next 버튼을 만들어 페이지를 이동할 수 있게 한다 
			- 처음과 끝 페이지의 경우 이동하지 않고 경고 출력	
		</p>
		
		<h3>BBS 게시판 검색처리</h3>
		<p>
		1.검색 type : 글쓴이/글제목/글제목+글내용  / 내용 : user 입력
		<p>
		2.게시판 글목록 출력 쿼리에 WHERE 검색내용을 추가 한다
		<p>
		3.검색을 하지 않을 경우 WHERE 에 공백만 추가하여 글목록을 출력한다
		</p>
		
		<h3>BBS 게시판 글쓰기</h3>
		<p>
		1.새로운 bbsID 를 부여받는다
		<p>
		2.해당 ID로 bbs table에 내용을 추가한다.
		</p>
		
		<h3>BBS 게시판 글 수정</h3>
		<p>
		1.session 정보를 기준으로 글을 쓴 user 와 login 한 user 가 같은지 확인한다.
		<p>
		2.user 가 같을경우 - bbsID를 기준으로 DB의 내용을 출력한다.
		<p>
		3.user 가 수정한 값을 DB 에 반영한다.
		</p>
		
		<h3>BBS 게시판 글 삭제</h3>
		<p>
		1.session 정보를 기준으로 글을 쓴 user 와 login 한 user 가 같은지 확인한다.
		<p>
		2.user 가 같을경우 - bbsID를 기준으로 DB의 visible 컬럼의 값을 변경한다.
		</p>
		
		<h3>BBS 게시판 글 보기 페이지</h3>
		<p>
		1.bbsID를 기준으로 글의 내용을 출력한다 
		<p>
		2.session 과 bbsID 의 user를 비교하여 보여지는 메뉴를 다르게 설정한다
		<p>
		3.글수정/ 삭제 / 좋아요-싫어요 기능을 추가한다.
		</p>
		
		<h3>좋아요-싫어요 / 조회수 기능</h3>
		<p>
		1.bbsID의 기준으로 good/bad/hit 의 수를 +1 한다
		</p>
		
		<h3>BBS 게시판 댓글기능 추가</h3>
		<p>
		1.bbs table 에 parentID 컬럼을 추가한다
		<p>
		2.원글의 경우 parentID = 0; 으로 설정한다.-> 글목록 출력시 조건추가
		<p>
		3.bbsID 의 글보기 아래에 parentID == bbsID 의 내용을 출력한다 		
		</p>
		
		<h3>BBS 게시판 대댓글 추가</h3>
		<p>
		1.댓글의 bbsID == parentID 인 글을 댓글 아래 출력한다. 		
		</p>
		
		<h3>댓글 수정/삭제 기능 추가</h3>
		<p>
		1. 게시글의 수정/삭제 함수를 그대로 사용		
		</p>
		
		<h3>BBS 게시판 파일업로드 기능 추가</h3>
		<p>
		1.write / modify 에 파일 업로드 기능을 추가한다.
		<p>
		2.view 에 다운로드 기능을 추가한다. 
		<p>
		+ 여러 파일 업로드 기능 추가 / -> 3개 까지 허용/ 추후에 사용자가 원하는 만큼 업로드 할 수 있도록 할 예정	
		</p>
		
	</article>


</body>
</html>