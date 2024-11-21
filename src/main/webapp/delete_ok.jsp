<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%@ page import="com.example.jsp_file.dao.BoardDAO"%>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));

    BoardDAO dao = new BoardDAO();
    String filename = dao.getPhotoFilename(seq);
    int result = dao.deleteBoard(seq);

    if (filename != null) {
        FileUpload.deleteFile(request, filename);
    }
%>
<div class="container">
    <% if (result > 0) { %>
    <h2>Post Successfully Deleted!</h2>
    <% } else { %>
    <h2>Failed to Delete Post</h2>
    <% } %>
    <a href="list.jsp" class="button">Back to List</a>
</div>
<%@ include file="bottom.jsp" %>