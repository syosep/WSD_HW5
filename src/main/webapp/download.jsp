<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.FileInputStream" %>
<%
    String fileName = request.getParameter("filename");
    if (fileName != null) {
        fileName = URLDecoder.decode(fileName, "UTF-8");
    }

    String savePath = "./upload";
    ServletContext context = request.getServletContext();
    String realPath = context.getRealPath(savePath);
    String sFilePath = realPath + "/" + fileName;

    FileInputStream in = new FileInputStream(sFilePath);
    String sMimeType = request.getServletContext().getMimeType(sFilePath);
    if (sMimeType == null) sMimeType = "application/octet-stream";

    response.setContentType(sMimeType);
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
    ServletOutputStream file1 = response.getOutputStream();
    int numRead;
    byte[] b = new byte[4096];

    while ((numRead = in.read(b, 0, b.length)) != -1) {
        file1.write(b, 0, numRead);
    }
    file1.flush();
    file1.close();
%>