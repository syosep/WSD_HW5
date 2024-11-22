<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>
<head>
    <title>Add Post</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h1>Add New Post</h1>
<form action="write_ok.jsp" method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" required /></td>
        </tr>
        <tr>
            <td>Writer:</td>
            <td><input type="text" name="writer" required /></td>
        </tr>
        <tr>
            <td>Content:</td>
            <td><textarea cols="50" rows="5" name="content" required></textarea></td>
        </tr>
        <tr>
            <td>File:</td>
            <td><input type="file" name="photo" /></td>
        </tr>
        <tr>
            <td><a href="list.jsp" class="button cancel">Cancel</a></td>
            <td><input type="submit" value="Add Post" class="button submit" /></td>
        </tr>
    </table>
</form>
<%@ include file="bottom.jsp" %>
</body>