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
			location.href = "/HRD0212/reservation0212/reservation0212_insert.jsp";
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
			String sql = "select count(*) from reservation0212";
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
		<h2>도서 예약정보 목록</h2>
		<p>총 <%=no %>명의 도서 예약 정보가 있습니다.</p>
		<table id="s_table">
			<tr>
				<th width="100">no</th>
				<th width="100">대출번호</th>
				<th width="100">고객성명</th>
				<th width="100">도서코드</th>
				<th width="200">도서명</th>
				<th width="100">대출일자</th>
				<th width="100">반납일자</th>
				<th width="100">대출상태</th>
				<th width="100">등급</th>
			</tr>
			<%
			no = 0;
			try{
				String sql = "select a.lentno,a.custname,a.bookno,b.bookname,to_char(a.outdate,'yyyy-mm-dd'),to_char(a.indate,'yyyy-mm-dd'),a.status,a.class1 from reservation0212 a, bookinfo0212 b where a.bookno=b.bookno order by a.bookno asc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					no++;
					String lentno = rs.getString(1);
					String custname = rs.getString(2);
					String bookno = rs.getString(3);
					String bookname = rs.getString(4);
					String outdate = rs.getString(5);
					String indate = rs.getString(6);
					String status = rs.getString(7);
					String class1 = rs.getString(8);
					
					if(outdate == null){ outdate = ""; }
					if(indate == null){ indate = ""; }
					
					if(class1 == null){ indate = "C"; }
					
					%>
					<tr>
						<td><%=no %></td>
						<td><a href="reservation0212_update.jsp?send_lentno=<%=lentno%>"><%=lentno %></a></td>
						<td><%=custname %></td>
						<td><%=bookno %></td>
						<td><%=bookname %></td>
						<td><%=outdate %></td>
						<td><%=indate %></td>
						<td><%=status %></td>
						<td><%=class1 %></td>
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