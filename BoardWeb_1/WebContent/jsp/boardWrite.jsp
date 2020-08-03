<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String msg="";
	String err = request.getParameter("err");
	if(err != null){
		switch(err){
		case "10":
			msg="등록할 수 없습니다.";
			break;
		case "20":
			msg="DB에러 발생";
			break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- css는 head아래에 적어도 되긴 하는데 번쩍이는 현상이 일어남. 헤드 안에 적어야 함. -->
<style>             
	#msg {color:red;}
</style>
</head>
<!-- 입력받는 창, 처리하는 창 따로 분리해서 만드는 것이 좋다. 하나의 메소드는 하나의 역할만! -->
<body>
	<div id="msg"><%=msg %></div>
	<div>											<!-- html에서 on으로 시작하는건 이벤트.onsubmit="return false" 하면 값이 전송되지 않음. 다른거 쓰면 다 전송됨. 그냥 chk()적으면 안되고 return chk() 써야 함.(onsubmit함수가 return해줘야 함)-->
		<form id="frm" action="/jsp/boardWriteProc.jsp?" method="post" onsubmit="return chk()">				<!-- post로 보내면 주소창에 정보가 나타나지 않고 정보를 캡슐화 해서 전달. (주소창에는 /jsp/boardWriteProc.jsp 까지만 나타남-->
			<div><label>제목: <input type="text" name="title"></label></div>
			<div><label>내용: <textarea name="ctnt"></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
		</form>
	</div>
	
	<script>
		//function 선언은 body안에 한다(head에 적어도 되지만 document가 다 로딩된 후 적는게 좋다. import는 헤드에.)
		
		function eleValid(ele, nm){
			if(ele.value.length == 0 ){
				alert(nm + '을(를) 입력해주세요');
				ele.focus();
				return true;
			}
		}
		
		//자바스크립트에서 체크하는건 사용자 편의를 위해서. 서버에서도 따로 더블체크 해줘야 한다.
		function chk() {
			//console.log(`title : \${frm.title.value}`);
			//console.log('title: ' + frm.title.value);
			
			if(eleValid(frm.title,'제목')) {
				return false;
			}else if(eleValid(frm.ctnt,'내용')){
				return false;
			}else if(eleValid(frm.i_student,'작성자')){
				return false;
			}
			
			/*if(frm.title.value==""){
				alert('제목을 입력해주세요');
				frm.title.focus();
				return false;		//값 전송 안됨.
			} else if(frm.ctnt.value.length==0){
				alert('내용을 입력해주세요');
				frm.ctnt.focus();
				return false;
			} else if(frm.i_student.value.length==0){
				alert('작성자을 입력해주세요');
				frm.i_student.focus();
				return false;
			}*/
		}
	</script>
</body>
</html>