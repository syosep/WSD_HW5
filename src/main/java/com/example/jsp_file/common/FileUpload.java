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

    /* 파일 업로드 메서드 */
    public FileVO uploadFile(HttpServletRequest request) {
        int sizeLimit = 15 * 1024 * 1024; // 업로드 파일 크기 제한
        String realPath = request.getServletContext().getRealPath("/upload"); // 업로드 파일 경로

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs(); // 경로가 존재하지 않으면 폴더 생성

        String originalFilename = null;
        String savedFilename = null;

        try {
            // 객체 생성
            multipartRequest = new MultipartRequest(
                    request,
                    realPath,
                    sizeLimit,
                    "UTF-8",
                    new DefaultFileRenamePolicy() // 파일명 중복 방지
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

    /* 전달된 파라미터를 가져오는 MultipartRequest 객체 반환 */
    public MultipartRequest getMultipartRequest() {
        return multipartRequest;
    }

    /* 저장된 파일 삭제 메서드 */
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