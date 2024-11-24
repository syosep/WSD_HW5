package com.example.jsp_file.common;

import com.example.jsp_file.bean.FileVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUpload {

    private MultipartRequest multipartRequest;

    public MultipartRequest getMultipartRequest() {
        return this.multipartRequest;
    }

    public FileVO uploadFile(HttpServletRequest request) {
        int sizeLimit = 15 * 1024 * 1024;
        String realPath = request.getServletContext().getRealPath("/upload");

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        try {
            this.multipartRequest = new MultipartRequest(
                    request,
                    realPath,
                    sizeLimit,
                    "UTF-8",
                    new DefaultFileRenamePolicy()
            );

            String filename = multipartRequest.getFilesystemName("photo");
            String title = multipartRequest.getParameter("title");

            return new FileVO(title, filename);
        } catch (IOException e) {
            System.out.println("File upload error!");
            e.printStackTrace();
            return null;
        }
    }

    public static boolean deleteFile(HttpServletRequest request, String filename) {
        String realPath = request.getServletContext().getRealPath("/upload");
        File file = new File(realPath, filename);

        if (file.exists()) {
            return file.delete();
        } else {
            System.out.println("파일이 존재하지 않습니다: " + filename);
            return false;
        }
    }
}