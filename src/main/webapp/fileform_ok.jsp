<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
    String filename = "";
    int sizeLimit = 15 * 1024 * 1024;

    String realPath = request.getServletContext().getRealPath("upload");
    System.out.println(realPath);

    File dir = new File(realPath);
    if (!dir.exists()) dir.mkdirs();

    MultipartRequest multipartRequest = null;
    multipartRequest = new MultipartRequest(request, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());

    filename = multipartRequest.getFilesystemName("photo");
    String imagepath = "";
    if (filename != "") {
        out.print("<img src='./upload/" + filename + "' height=400>");
    }
%>

<% if(filename != "") {
%>
    <h3>파일명 ㅣ <%=filename%></h3>
    <img src="./upload/<%=filename%>" width="400">
<%
    }
%>