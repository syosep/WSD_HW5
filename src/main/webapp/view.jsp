<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%
    com.example.jsp_file.dao.BoardDAO dao = new com.example.jsp_file.dao.BoardDAO();
    int seq = Integer.parseInt(request.getParameter("seq"));
    com.example.jsp_file.bean.BoardVO post = dao.getBoard(seq);
%>
<head>
    <title>View Post</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<h1>View Post</h1>
<table border="1">
    <tr>
        <td>ID:</td>
        <td><%= post.getId() %></td>
    </tr>
    <tr>
        <td>Title:</td>
        <td><%= post.getTitle() %></td>
    </tr>
    <tr>
        <td>Writer:</td>
        <td><%= post.getWriter() %></td>
    </tr>
    <tr>
        <td>Content:</td>
        <td><%= post.getContent() %></td>
    </tr>
    <tr>
        <td>Reg Date:</td>
        <td><%= post.getRegdate() %></td>
    </tr>
</table>
<a href="list.jsp">Back to List</a> |
<a href="edit.jsp?seq=<%= post.getId() %>">Edit</a> |
<a href="delete.jsp?seq=<%= post.getId() %>">Delete</a>
<%@ include file="bottom.jsp" %>