<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="top.jsp" %>
<div class="container">
    <%
        int seq = Integer.parseInt(request.getParameter("seq"));
        com.example.jsp_file.dao.BoardDAO dao = new com.example.jsp_file.dao.BoardDAO();
        int result = dao.deleteBoard(seq);
    %>
    <% if (result > 0) { %>
    <h2>Post Successfully Deleted!</h2>
    <% } else { %>
    <h2>Failed to Delete Post</h2>
    <% } %>
    <a href="list.jsp" class="button">Back to List</a>
</div>
<%@ include file="bottom.jsp" %>