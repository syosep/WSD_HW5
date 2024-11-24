<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.jsp_file.dao.BoardDAO"%>
<%@ page import="com.example.jsp_file.bean.BoardVO"%>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.bean.FileVO" %>
<%@ include file="top.jsp" %>
<%
    request.setCharacterEncoding("utf-8");

    int seq = Integer.parseInt(request.getParameter("seq"));
    String title = request.getParameter("title");
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");
    String deleteFile = request.getParameter("deleteFile");

    BoardDAO dao = new BoardDAO();
    BoardVO post = dao.getBoard(seq);

    if ("true".equals(deleteFile) && post.getFilename() != null) {
        boolean fileDeleted = FileUpload.deleteFile(request, post.getFilename());
        if (fileDeleted) {
            post.setFilename(null);
        }
    }

    FileUpload fileUpload = new FileUpload();
    FileVO fileVO = fileUpload.uploadFile(request);

    if (fileVO != null && fileVO.getFilename() != null) {
        post.setFilename(fileVO.getFilename());
    }

    post.setTitle(title);
    post.setWriter(writer);
    post.setContent(content);

    int result = dao.updateBoard(post);

    if (result > 0) {
        response.sendRedirect("list.jsp");
    } else {
        out.println("<h2>Failed to Update Post</h2>");
        out.println("<a href='edit.jsp?seq=" + seq + "'>Back</a>");
    }
%>
<%@ include file="bottom.jsp" %>