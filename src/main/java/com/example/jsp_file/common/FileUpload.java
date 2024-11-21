package com.example.jsp_file.common;

import com.example.jsp_file.bean.BoardVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUpload {

    public BoardVO uploadFile(HttpServletRequest request) {
        int sizeLimit = 15 * 1024 * 1024;
        String realPath = request.getServletContext().getRealPath("upload");

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        MultipartRequest multipartRequest = null;
        try {
            multipartRequest = new MultipartRequest(
                    request, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
        } catch (IOException e) {
            System.out.println("업로드 중 오류 발생!");
            e.printStackTrace();
        }

        String filename = multipartRequest.getFilesystemName("photo");
        String title = multipartRequest.getParameter("title");
        String writer = multipartRequest.getParameter("writer");
        String content = multipartRequest.getParameter("content");

        BoardVO post = new BoardVO();
        post.setTitle(title);
        post.setWriter(writer);
        post.setContent(content);
        post.setFilename(filename);

        return post;
    }

    public static void deleteFile(HttpServletRequest request, String filename) {
        String realPath = request.getServletContext().getRealPath("upload");
        File file = new File(realPath, filename);
        if (file.exists()) {
            file.delete();
        }
    }
}