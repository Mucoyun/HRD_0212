<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
	<style>
		#iu_table td{
			width: 250px !important;
		}#iu_table input[type="text"]{
			width: 200px !important;
		}#iu_table select{
			height: 25px;
			width: 200px;
		}
		#btntd button{
			width: 100px !important;
			color: white;
			background-color: black;
		}
	</style>
	<script>
		function gotry() {
			if(document.iu_form.lentno.value == ""){
				alert("대출번호가 입력되지 않았습니다.");
				document.iu_form.lentno.focus();
			}else if(document.iu_form.custname.value == ""){
				alert("고객성명이 입력되지 않았습니다.");
				document.iu_form.custname.focus();
			}else if(document.iu_form.bookno.value == ""){
				alert("도서코드가 입력되지 않았습니다.");
				document.iu_form.bookno.focus();
			}else{
				document.iu_form.action = "reservation0212_insert_process.jsp";
				document.iu_form.submit();
			}
		}
		function notry() {
			document.iu_form.reset();
			//location.href = "";
			//history.back(-1);
		}
		function booknoChk() {
			document.iu_form.submit();
		}
		function indateChk(indate) {
			var status = document.getElementsByName("status");
			if(indate.value == ""){
				status[0].checked = true;
			}else{
				status[1].checked = true;
			}
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String bookno = request.getParameter("bookno");
		String bookname = "";
		
		String lentno = request.getParameter("lentno");
		String custname = request.getParameter("custname");
		String outdate = request.getParameter("outdate");
		String indate = request.getParameter("indate");
		String status = request.getParameter("status");
		String class1 = request.getParameter("class1");
		
		try{
			String sql = "select bookname from bookinfo0212 where bookno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bookname = rs.getString(1);
			}else if(bookno == null){
				bookno = "";
			}else{
				bookno = "";
				%><script>
					alert("등록되어 있지 앟은 도서코드 입니다.");
					booknoChk();
				</script><%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		if(lentno == null){ lentno = ""; }
		if(custname == null){ custname = ""; }
		if(outdate == null){ outdate = ""; }
		if(indate == null){ indate = ""; }
		if(status == null){ status = "1"; }
		if(class1 == null){ class1 = "S"; }
	%>
	<section>
		<h2>도서 대출 예약 정보 등록 화면</h2>
		<form name="iu_form" method="post" action="reservation0212_insert.jsp">
			<table id="iu_table">
				<tr>
					<th>대출번호</th>
					<td><input type="text" name="lentno" value="<%=lentno %>"></td>
					<th>고객성명</th>
					<td><input type="text" name="custname" value="<%=custname %>"></td>
				</tr>
				<tr>
					<th>도서코드</th>
					<td><input type="text" name="bookno" value="<%=bookno %>" onchange="booknoChk()"></td>
					<th>도서이름</th>
					<td><input type="text" name="bookname" value="<%=bookname %>" readonly></td>
				</tr>
				<tr>
					<th>대출일자</th>
					<td><input type="text" name="outdate" value="<%=outdate %>" maxlength="10"></td>
					<th>반납일자</th>
					<td><input type="text" name="indate" value="<%=indate %>" maxlength="10" onchange="indateChk(this)"></td>
				</tr>
				<tr>
					<th>대출상태</th>
					<td>
						<input type="radio" name="status" value="1" <%if(status.equals("1")){ %> checked <% } %> readonly> 대출
						<input type="radio" name="status" value="2" <%if(status.equals("2")){ %> checked <% } %> readonly> 반납
					</td>
					<th>등급</th>
					<td>
						<select name="class1">
							<option value="S" <%if(class1.equals("S")){ %> selected <% } %>>S</option>
							<option value="A" <%if(class1.equals("A")){ %> selected <% } %>>A</option>
							<option value="B" <%if(class1.equals("B")){ %> selected <% } %>>B</option>
							<option value="C" <%if(class1.equals("C")){ %> selected <% } %>>C</option>
						</select>
					</td>
				</tr>
				<tr>
					<td id="btntd" colspan="4">
						<button type="button" onclick="gotry()">저장</button>
						<button type="button" onclick="notry()">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>