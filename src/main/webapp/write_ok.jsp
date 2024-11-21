<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.dao.BoardDAO" %>
<%@ page import="com.example.jsp_file.bean.BoardVO" %>
<%
    request.setCharacterEncoding("utf-8");
    FileUpload fileUpload = new FileUpload();
    BoardVO post = fileUpload.uploadFile(request);

    BoardDAO dao = new BoardDAO();
    int result = dao.insertBoard(post);
%>

<div class="container">
    <% if (result > 0) { %>
    <h2>Post Added!</h2>
    <% } else { %>
    <h2>Post Not Added!</h2>
    <% } %>
    <a href="list.jsp" class="button">Back to List</a>
</div>
<%@ include file="bottom.jsp" %>