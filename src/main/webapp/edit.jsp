<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="top.jsp" %>
<%
    com.example.jsp_file.dao.BoardDAO dao = new com.example.jsp_file.dao.BoardDAO();
    int seq = Integer.parseInt(request.getParameter("seq"));
    com.example.jsp_file.bean.BoardVO post = dao.getBoard(seq);
%>
<head>
    <title>Edit Post</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<h1>Edit Post</h1>
<form action="edit_ok.jsp" method="post">
    <input type="hidden" name="seq" value="<%= post.getId() %>" />
    <table>
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" value="<%= post.getTitle() %>" /></td>
        </tr>
        <tr>
            <td>Writer:</td>
            <td><input type="text" name="writer" value="<%= post.getWriter() %>" /></td>
        </tr>
        <tr>
            <td>Content:</td>
            <td><textarea cols="50" rows="5" name="content"><%= post.getContent() %></textarea></td>
        </tr>
        <tr>
            <td><a href="list.jsp">Cancel</a></td>
            <td><input type="submit" value="Update Post" /></td>
        </tr>
    </table>
</form>
<%@ include file="bottom.jsp" %>