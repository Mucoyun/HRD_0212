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
		
		String lentno = request.getParameter("lentno");
		String custname = request.getParameter("custname");
		String bookno = request.getParameter("bookno");
		String outdate = request.getParameter("outdate");
		String indate = request.getParameter("indate");
		String status = request.getParameter("status");
		String class1 = request.getParameter("class1");
	
		try{
			String sql = "update reservation0212 set custname=?,bookno=?,outdate=?,indate=?,status=?,class1=? where lentno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, custname);
			pstmt.setString(2, bookno);
			pstmt.setString(3, outdate);
			pstmt.setString(4, indate);
			pstmt.setString(5, status);
			pstmt.setString(6, class1);
			pstmt.setString(7, lentno);
			pstmt.executeUpdate();
			%><script>
				alert("수정이 완료되었습니다");
				location.href = "/HRD0212/reservation0212/reservation0212_select.jsp";
			</script><%
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>