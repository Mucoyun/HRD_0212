<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
	<script>
		function gotry() {
			if(document.iu_form.bookno.value == ""){
				alert("도서코드가 입력되지 않았습니다.");
				document.iu_form.bookno.focus();
			}else if(document.iu_form.author.value == ""){
				alert("저자가 입력되지 않았습니다.");
				document.iu_form.author.focus();
			}else if(document.iu_form.bookname.value == ""){
				alert("도서이름이 입력되지 않았습니다.");
				document.iu_form.bookname.focus();
			}else{
				document.iu_form.submit();
			}
		}
		function notry() {
			//document.iu_form.reset();
			location.href = "/HRD0212/bookinfo0212/bookinfo0212_select.jsp";
			//history.back(-1);
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String send_bookno = request.getParameter("send_bookno");
		try{
			String sql = "select bookno,author,bookname from bookinfo0212 where bookno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_bookno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				String bookno = rs.getString(1);
				String author = rs.getString(2);
				String bookname = rs.getString(3);
				%>
	<section>
		<h2>도서정보 수정</h2>
		<form name="iu_form" method="post" action="bookinfo0212_update_process.jsp">
			<table id="iu_table">
				<tr>
					<th>도서코드</th>
					<td><input type="text" name="bookno" value="<%=bookno%>" readonly></td>
				</tr>
				<tr>
					<th>저자</th>
					<td><input type="text" name="author" value="<%=author%>"></td>
				</tr>
				<tr>
					<th>도서이름</th>
					<td><input type="text" name="bookname" value="<%=bookname%>"></td>
				</tr>
				<tr>
					<td id="btntd" colspan="2">
						<button type="button" onclick="notry()">목록</button>
						<button type="button" onclick="gotry()">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<%@ include file="/footer.jsp" %>
</body>
</html>