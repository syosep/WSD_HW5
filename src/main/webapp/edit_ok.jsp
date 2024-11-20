<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.dao.BoardDAO" %>
<%@ page import="com.example.jsp_file.bean.BoardVO" %>
<%
    com.example.jsp_file.dao.BoardDAO dao = new com.example.jsp_file.dao.BoardDAO();
    com.example.jsp_file.bean.BoardVO post = new com.example.jsp_file.bean.BoardVO();

    post.setId(Integer.parseInt(request.getParameter("seq")));
    post.setTitle(request.getParameter("title"));
    post.setWriter(request.getParameter("writer"));
    post.setContent(request.getParameter("content"));

    int result = dao.updateBoard(post);
    if (result > 0) {
        System.out.println("<h3>Post updated!</h3>");
    } else {
        System.out.println("<h3>Post not updated!</h3>");
    }
%>

<%
    request.setCharacterEncoding("utf-8");
    BoardDAO boardDAO = new BoardDAO();
    FileUpload upload = new FileUpload();
    BoardVO u = upload.uploadPhoto(request);

    int i = boardDAO.updateBoard(u);
%>

<a href="list.jsp">Back to List</a>
<%@ include file="bottom.jsp" %>