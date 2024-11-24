package com.example.jsp_file.common;

import com.example.jsp_file.bean.FileVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUpload {
    private MultipartRequest multipartRequest;

    public FileVO uploadFile(HttpServletRequest request) {
        int sizeLimit = 15 * 1024 * 1024;
        String realPath = request.getServletContext().getRealPath("/upload");

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        String originalFilename = null;
        String savedFilename = null;

        try {
            multipartRequest = new MultipartRequest(
                    request,
                    realPath,
                    sizeLimit,
                    "UTF-8",
                    new DefaultFileRenamePolicy()
            );

            originalFilename = multipartRequest.getFilesystemName("photo");

            if (originalFilename != null) {
                String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String baseName = originalFilename.substring(0, originalFilename.lastIndexOf("."));
                String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
                savedFilename = baseName + "_" + timestamp + extension;

                File oldFile = new File(realPath + "/" + originalFilename);
                File newFile = new File(realPath + "/" + savedFilename);
                if (oldFile.renameTo(newFile)) {
                    System.out.println("파일명 변경 성공: " + savedFilename);
                }
            }

            String title = multipartRequest.getParameter("title");

            return new FileVO(title, savedFilename);
        } catch (IOException e) {
            System.out.println("업로드 중 오류 발생!");
            e.printStackTrace();
            return null;
        }
    }

    public MultipartRequest getMultipartRequest() {
        return multipartRequest;
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