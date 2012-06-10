<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%
    //仅做示例用，请自行修改
    String path = "e:/apache-tomcat-7.0.29/static/uploads/article/article-big";
    String imgStr = "";
    String realpath = path;//request.getRealPath("/") + path;
    String abpath = request.getRealPath("/");
    List<File> files = getFiles(realpath, new ArrayList());
    System.out.println(files.toString());
    for (File file : files) {
        System.out.println(file.getName());
        imgStr += path.substring(path.lastIndexOf("/") + 1, path.length()) + "/" + file.getName() + "ue_separate_ue";
    }
    if(!"".equals(imgStr)) {
        imgStr = imgStr.substring(0, imgStr.lastIndexOf("ue_separate_ue"));
    }
    out.print(imgStr);
%>
<%!
    public List getFiles(String realpath, List files) {
        File realFile = new File(realpath);
        if (realFile.isDirectory()) {
            File[] subfiles = realFile.listFiles();
            for (File file : subfiles) {
                if (file.isDirectory()) {
                    getFiles(file.getAbsolutePath(), files);
                } else {
                    Pattern reg = Pattern.compile("[.]jpg|png|jpeg|gif$");
                    Matcher matcher = reg.matcher(file.getName());
                    if (matcher.find()) {
                        files.add(file);
                    }
                }
            }
        }
        return files;
    }%>
