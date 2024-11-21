<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.dao.BoardDAO"%>
<%@ page import="com.example.jsp_file.bean.BoardVO"%>
<%
    request.setCharacterEncoding("utf-8");

    FileUpload fileUpload = new FileUpload();
    BoardVO post = fileUpload.uploadFile(request);
    post.setId(Integer.parseInt(request.getParameter("seq")));

    BoardDAO dao = new BoardDAO();
    String oldFilename = dao.getPhotoFilename(post.getId());
    if (oldFilename != null) {
        FileUpload.deleteFile(request, oldFilename);
    }

    int result = dao.updateBoard(post);
%>
<div class="container">
    <% if (result > 0) { %>
    <h2>Post Successfully Updated!</h2>
    <% } else { %>
    <h2>Failed to Update Post</h2>
    <% } %>
    <a href="list.jsp" class="button">Back to List</a>
</div>
<%@ include file="bottom.jsp" %>