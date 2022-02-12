<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%
		String bookno = request.getParameter("bookno");
		String author = request.getParameter("author");
		String bookname = request.getParameter("bookname");
	
		try{
			String sql = "update bookinfo0212 set author=?,bookname=? where bookno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, author);
			pstmt.setString(2, bookname);
			pstmt.setString(3, bookno);
			pstmt.executeUpdate();
			%><script>
				alert("수정이 완료되었습니다");
				location.href = "/HRD0212/bookinfo0212/bookinfo0212_select.jsp";
			</script><%
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>