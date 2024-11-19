<%@ page import="com.example.jsp_file.bean.BoardVO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Post List</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Post List</h2>
    <button class="add-post" onclick="location.href='write.jsp'">Write a New Post</button>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Writer</th>
            <th>Reg Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            com.example.jsp_file.dao.BoardDAO dao = new com.example.jsp_file.dao.BoardDAO();
            List<BoardVO> posts = dao.getBoardList();

            for (com.example.jsp_file.bean.BoardVO post : posts) {
        %>
        <tr>
            <td><%= post.getId() %></td>
            <td><%= post.getTitle() %></td>
            <td><%= post.getWriter() %></td>
            <td><%= post.getRegdate() %></td>
            <td class="actions">
                <a href="view.jsp?seq=<%= post.getId() %>">View</a>
                <a href="edit.jsp?seq=<%= post.getId() %>">Edit</a>
                <a href="delete.jsp?seq=<%= post.getId() %>" class="delete">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<%@ include file="bottom.jsp" %>
</body>
</html>