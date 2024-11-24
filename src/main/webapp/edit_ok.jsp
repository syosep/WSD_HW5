<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.jsp_file.dao.BoardDAO"%>
<%@ page import="com.example.jsp_file.bean.BoardVO"%>
<%@ page import="com.example.jsp_file.common.FileUpload"%>
<%@ page import="com.example.jsp_file.bean.FileVO" %>
<%@ include file="top.jsp" %>
<%
    request.setCharacterEncoding("utf-8");

    int seq = Integer.parseInt(request.getParameter("seq"));
    String title = request.getParameter("title");
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");
    String deleteFile = request.getParameter("deleteFile");

    System.out.println("게시물 ID: " + seq);
    System.out.println("삭제 요청 여부: " + deleteFile);

    BoardDAO dao = new BoardDAO();
    BoardVO post = dao.getBoard(seq);

    System.out.println("기존 파일명: " + post.getFilename());

    // 파일 삭제 로직
    if ("true".equals(deleteFile) && post.getFilename() != null) {
        boolean fileDeleted = FileUpload.deleteFile(request, post.getFilename());
        System.out.println("파일 삭제 결과: " + (fileDeleted ? "성공" : "실패"));
        if (fileDeleted) {
            post.setFilename(null); // 데이터베이스에서도 null로 설정
        }
    }

    // 새로운 파일 업로드 로직
    FileUpload fileUpload = new FileUpload();
    FileVO fileVO = fileUpload.uploadFile(request);

    if (fileVO != null && fileVO.getFilename() != null) {
        System.out.println("업로드된 새 파일명: " + fileVO.getFilename());
        // 기존 파일 삭제
        if (post.getFilename() != null) {
            boolean oldFileDeleted = FileUpload.deleteFile(request, post.getFilename());
            System.out.println("기존 파일 삭제 결과: " + (oldFileDeleted ? "성공" : "실패"));
        }
        post.setFilename(fileVO.getFilename());
    }

    post.setTitle(title);
    post.setWriter(writer);
    post.setContent(content);

    System.out.println("최종 업데이트된 파일명: " + post.getFilename());

    int result = dao.updateBoard(post);

    if (result > 0) {
        response.sendRedirect("list.jsp");
    } else {
        System.out.println("게시물 업데이트 실패");
%>
<div class="container">
    <h2 style="color: red;">Failed to Update Post</h2>
    <p>Please check your input and try again.</p>
    <a href="edit.jsp?seq=<%= seq %>" class="button">Go Back</a>
</div>
<%
    }
%>


<%@ include file="bottom.jsp" %>