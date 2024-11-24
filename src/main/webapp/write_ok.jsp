<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.dao.BoardDAO"%>
<%@ page import="com.example.jsp_file.bean.BoardVO"%>
<%@ page import="com.example.jsp_file.bean.FileVO"%>
<%@ include file="top.jsp" %>
<%
    request.setCharacterEncoding("utf-8");

    FileUpload fileUpload = new FileUpload();
    FileVO fileVO = fileUpload.uploadFile(request);

    if (fileVO == null || fileVO.getFilename() == null) {
        System.out.println("File upload failed or no file uploaded.");
        fileVO = new FileVO(request.getParameter("title"), null);
    }

    BoardVO post = new BoardVO();
    post.setTitle(fileVO.getTitle());
    post.setFilename(fileVO.getFilename());

    String writer = fileUpload.getMultipartRequest().getParameter("writer");
    String content = fileUpload.getMultipartRequest().getParameter("content");

    if (writer == null || writer.trim().isEmpty()) {
        writer = "Anonymous";
    }
    if (content == null || content.trim().isEmpty()) {
        content = "No content provided.";
    }

    post.setWriter(writer);
    post.setContent(content);

    BoardDAO dao = new BoardDAO();
    int result = dao.insertBoard(post);

    if (result > 0) {
        response.sendRedirect("list.jsp");
    } else {
%>
<div class="container">
    <h2 style="color: red;">Failed to Add Post</h2>
    <p>Please check your input and try again.</p>
    <a href="write.jsp" class="button">Go Back</a>
</div>
<%
    }
%>
<%@ include file="bottom.jsp" %>