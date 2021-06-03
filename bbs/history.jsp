<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body >
<jsp:include page="nav.jsp"></jsp:include>
	<div class ="container">
		<h2>BBS 제작 일지</h2>	
		<ul>
			<li>
				<h4>2021-05-17</h4>
				<ul>
					<li>bbs db 생성</li>
					<li>bbs db 연동 DAO 구현</li>
					<li>user table 생성</li>
					<li>nav / login.jsp 화면 구현</li>
					<li>login/logout 기능 구현 - 세션에 user정보 추가 및 삭제</li>
				</ul>				
			</li>
			<li>
				<h4>2021-05-18</h4>
				<ul>
					<li>join us 화면구현</li>
					<li>form 유효성 확인 script 추가</li>
					<li>회원가입 기능 추가 </li>
					<li>주소정보 카카오API 적용 </li>										
				</ul>
			</li>
			<li>
				<h4>2021-05-19</h4>
				<ul>
					<li>join us 화면구현</li>
					<li>회원가입 기능 추가 </li>
					<li>주소정보 카카오API 적용 </li>										
				</ul>
			</li>
			<li>
				<h4>2021-05-20</h4>
				<ul>
					<li>nav 변경 -> 로그인 시와 로그아웃시 nav 의 목록이 다르게 출력</li>
					<li>웹호스팅 및 도메인 구매</li>
					<li>로컬에서 웹 호스팅 서버로 업로드</li>
											
				</ul>
			</li>
			<li>
				<h4>2021-05-21</h4>
				<ul>
					<li>Mypage 추가</li>
					<li>회원 정보 확인 및 수정 기능 추가</li>		
				</ul>
			</li>
			<li>
				<h4>2021-05-22</h4>
				<ul>
					<li>BBS 제작 시작</li>
					<li>BBS table 생성</li>
					<li>BBS write 페이지 추가</li>
					<li>BBS write 기능 구현</li>
					<li>게시판 화면 구현</li>
					<li>게시판 화면에 DB 정보 출력</li>
				</ul>
			</li>
			<li>
				<h4>2021-05-23</h4>
				<ul>
					<li>BBS.jsp 페이징 기능 추가</li>
					<li>bbsView 화면 구현</li>
					<li>bbsView 화면 데이터 출력</li>
					<li>bbsView 검색기능폼 추가</li>
					<li>bbsView 검색기능 추가 - 보완필요</li>
				</ul>
			</li>
			<li>
				<h4>2021-05-24</h4>					
				<ul>
					<li>bbsView 검색기능 보완완료</li>		
					<li>bbsView 화면 null 값 에러 수정</li>
					<li>bbsView 화면 modify/delete 버튼 추가</li>
					<li>게시글 수정/ 삭제 기능추가</li>
					<li>bbsView -  bbs버튼(목록으로 이동) 추가</li>
					
				</ul>
			</li>
			<li>
				<h4>2021-05-25</h4>			
				<ul>
					<li>bbsView 화면 script 코드 방지 기능 추가</li>
					<li>bbs db 수정 - good/bad 컬럼 추가</li>
					<li style="color: crimson;">good/bad(좋아요/싫어요) 기능추가 - 보완필요</li>
					<li>bbs db hti 컬럼 추가 </li>
					<li>bbs에 hit(조회수) 추가 </li>
					<li>hit 기능 추가 </li>				
				</ul>
			</li>
			<li>
				<h4>2021-05-26</h4>
				<ul>
					<li>bbsView 에 comment writer 추가 </li>
					<li>bbs db 수정 parent 컬럼 추가</li>
					<li>commet write 기능 추가 - </li>
					<li style="color: crimson;">comment 출력 기능 추가 - 보완 필요- 보안완료(06/01) + 추가 보완필요- 보완(06/02) </li>		
					<li>bbsView 화면 script 코드 방지 기능 추가</li>					
				</ul>
			</li>
			<li>
				<h4>2021-05-27</h4>
				<ul>
					<li>bbsView wihte space 에러 수정 </li>
					<li >bbsView file 입출력 기능 제작중 -제작완료(06/01)  </li>									
				</ul>
			</li>
			<li>
				<h4>2021-05-28</h4>
				<ul>
					<li>bbsView file 업로드 기능 추가 - 업로드 기능 추가(06/01)</li>									
					<li>write 함수 변경 - > 정상작동 확인 </li>									
					<li >파일 업로드는 정상/ file insert querry 에서 에러 확인 필요 - 정상 확인(05/31 )</li>									
				</ul>
			</li>
			<li>
				<h4>2021-05-31</h4>
				<ul>
					<li>file insert querry 정상작동 확인 </li>	
					<li>bbsView wihte space 에러 재수정 </li>
				</ul>
			</li>
			<li>
				<h4>2021-06-01</h4>
				<ul>
					<li>file Download 기능 추가 </li>	
					<li>file Upload 및 Download 시 한글깨짐 수정 </li>					
					<li>글쓰기 / 수정하기 / 삭제하기 에 파일 추가 기능 추가</li>					
					<li>파일이 null 인경우 오류 발생 - 수정완료(06/01)</li>	
					<li >comment 출력 기능 추가 summary 태그의 범위 확인 필요- 확인 및 수정 완료(06/02)</li>	
					<li>file 경로를 config 에서 참조하도록 요청 - 수정함 (06/02)</li>									
				</ul>
			</li>
			<li>
				<h4>2021-06-02</h4>
				<ul>
					<li>file 경로를 참조하는 경로로 수정 완료 </li>	
					<li>브라우저별 인코딩 추가</li>					
					<li>comment 의 &lt;detail&rt; 태그 수정</li>
					<li>글쓰기 및 글수정에서 여러개의 파일 동시 업로드 요청 - 글쓰기시 3개까지 파일 주가가 가능하도록 변경(06/02)</li>							
					<li>댓글 작성후 이동 경로 수정</li>							
				</ul>
			</li>
		</ul>

	</div>
	<div style ="min-height :200px">  </div>

</body>
</html>