<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
	<style>
		p{
			display: block;
			padding: 0 !important;
			width: 1000px;
			margin: 0 auto;
		}
	</style>
	<script>
		function notry() {
			//document.iu_form.reset();
			location.href = "/HRD0212/bookinfo0212/bookinfo0212_insert.jsp";
			//history.back(-1);
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		int no = 0;
		try{
			String sql = "select count(*) from bookinfo0212";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				no = rs.getInt(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<section>
		<h2>도서정보 목록</h2>
		<p>총 <%=no %>권의 도서정보가 있습니다.</p>
		<table id="s_table">
			<tr>
				<th width="200">no</th>
				<th width="200">도서코드</th>
				<th width="200">저자</th>
				<th width="400">도서명</th>
			</tr>
			<%
			no = 0;
			try{
				String sql = "select bookno,author,bookname from bookinfo0212 order by bookno";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					no++;
					String bookno = rs.getString(1);
					String author = rs.getString(2);
					String bookname = rs.getString(3);
					%>
					<tr>
						<td><%=no %></td>
						<td><a href="bookinfo0212_update.jsp?send_bookno=<%=bookno%>"><%=bookno %></a></td>
						<td><%=author %></td>
						<td><%=bookname %></td>
					</tr>
					<%
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			%>
		</table>
		<button id="btn" type="button" onclick="notry()">도서 정보 추가</button>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>