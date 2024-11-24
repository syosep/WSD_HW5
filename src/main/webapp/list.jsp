<%@ page import="com.example.jsp_file.bean.BoardVO" %>
<%@ page import="com.example.jsp_file.dao.BoardDAO" %>
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
    <form method="get" action="list.jsp">
        <label for="keyword">Search:</label>
        <input type="text" name="keyword" id="keyword" placeholder="Enter keyword" />
        <input type="submit" value="Search" />
    </form>
    <form method="get" action="list.jsp">
        <label for="sort">Sort By:</label>
        <select name="sort" id="sort">
            <option value="regdate">Registration Date</option>
            <option value="title">Title</option>
        </select>
        <input type="submit" value="Sort" />
    </form>
    <button class="add-post" onclick="location.href='write.jsp'">Write a New Post</button>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Writer</th>
            <th>Reg Date</th>
            <th>Views</th>
            <th>File</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            String keyword = request.getParameter("keyword");
            String sort = request.getParameter("sort");
            BoardDAO dao = new BoardDAO();
            List<BoardVO> posts;

            if (keyword != null && !keyword.isEmpty()) {
                posts = dao.searchPosts(keyword); // 검색 기능
            } else if (sort != null && !sort.isEmpty()) {
                posts = dao.getBoardList(sort); // 정렬 기능
            } else {
                posts = dao.getBoardList("regdate"); // 기본 정렬
            }

            for (BoardVO post : posts) {
        %>
        <tr>
            <td><%= post.getId() %></td>
            <td><%= post.getTitle() %></td>
            <td><%= post.getWriter() %></td>
            <td><%= post.getRegdate() %></td>
            <td><%= post.getCnt() %></td>
            <td>
                <% if (post.getFilename() != null) { %>
                <a href="./upload/<%= post.getFilename() %>"><%= post.getFilename() %></a>
                <% } else { %>
                No File
                <% } %>
            </td>
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