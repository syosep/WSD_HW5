<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="top.jsp" %>
<div class="container">
    <h2>Confirm Deletion</h2>
    <p>Are you sure you want to delete this post?</p>
    <form action="delete_ok.jsp" method="post">
        <input type="hidden" name="seq" value="<%= request.getParameter("seq") %>">
        <button type="submit" class="button delete">Yes, Delete</button>
        <a href="list.jsp" class="button cancel">Cancel</a>
    </form>
</div>
<head>
    <title>Delete Post</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<a href="list.jsp">Back to List</a>
<%@ include file="bottom.jsp" %>