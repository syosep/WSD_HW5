<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%@ page import="com.example.jsp_file.dao.BoardDAO" %>
<%@ page import="com.example.jsp_file.bean.BoardVO" %>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
    BoardDAO dao = new BoardDAO();

    dao.increaseViewCount(seq);

    BoardVO post = dao.getBoard(seq);
%>
<head>
    <title>View Post</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<div class="container">
    <h1>View Post</h1>
    <table border="1" class="view-table">
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
        <tr>
            <td>Views:</td>
            <td><%= post.getCnt() %></td>
        </tr>
        <tr>
            <td>File:</td>
            <td>
                <% if (post.getFilename() != null) { %>
                <a href="./upload/<%= post.getFilename() %>" class="button file-button">View File</a>
                <% } else { %>
                No File
                <% } %>
            </td>
        </tr>
    </table>
    <div class="button-group">
        <a href="list.jsp" class="button">Back to List</a>
        <a href="edit.jsp?seq=<%= post.getId() %>" class="button">Edit</a>
        <a href="delete.jsp?seq=<%= post.getId() %>" class="button cancel">Delete</a>
    </div>
</div>
<%@ include file="bottom.jsp" %>
</body>