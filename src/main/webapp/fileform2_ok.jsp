<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.bean.FileVO"%>
<%
    FileUpload fileUpload = new FileUpload();
    FileVO vo = fileUpload.uploadFile(request);
%>
제목 : <%=vo.getTitle()%><br>
파일명 : <a href="./upload/<%=vo.getFilename()%>"><%=vo.getFilename()%></a><br>
다운로드 : <a href="download.jsp?filename=<%=vo.getFilename()%>"><%=vo.getFilename()%></a>