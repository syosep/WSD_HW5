<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%@ page import="com.example.jsp_file.bean.BoardVO"%>
<%@ page import="com.example.jsp_file.dao.BoardDAO"%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
    BoardDAO dao = new BoardDAO();
    BoardVO post = dao.getBoard(seq);
%>
<head>
    <title>Edit Post</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<div class="container">
    <h1>Edit Post</h1>
    <form action="edit_ok.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="seq" value="<%= post.getId() %>" />
        <table>
            <tr>
                <td>Title:</td>
                <td><input type="text" name="title" value="<%= post.getTitle() %>" required /></td>
            </tr>
            <tr>
                <td>Writer:</td>
                <td><input type="text" name="writer" value="<%= post.getWriter() %>" required /></td>
            </tr>
            <tr>
                <td>Content:</td>
                <td><textarea cols="50" rows="5" name="content" required><%= post.getContent() %></textarea></td>
            </tr>
            <tr>
                <td>Current File:</td>
                <td>
                    <% if (post.getFilename() != null && !post.getFilename().isEmpty()) { %>
                    <a href="./upload/<%= post.getFilename() %>"><%= post.getFilename() %></a> <!-- 기존 파일 링크 -->
                    <input type="checkbox" name="deleteFile" value="true" /> Delete this file
                    <% } else { %>
                    No file uploaded
                    <% } %>
                </td>
            </tr>
            <tr>
                <td>Upload New File:</td>
                <td><input type="file" name="photo" /></td>
            </tr>
            <tr>
                <td><a href="list.jsp">Cancel</a></td>
                <td><input type="submit" value="Update Post" /></td>
            </tr>
        </table>
    </form>
</div>
<%@ include file="bottom.jsp" %>