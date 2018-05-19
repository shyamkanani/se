<%-- 
    Document   : download
    Created on : 18 Apr, 2018, 3:42:03 PM
    Author     : MyHP
--%>

<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Downloading</title>
    </head>
    <body>
        <%
            try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
            Statement st=cn.createStatement();
            String key="";
            Cookie ck[]=request.getCookies();
            for(int i=0;i<ck.length;i++)
            {  
                key ="s"+ck[i].getValue();
            }
            ResultSet rs;
            key=String.valueOf(key);
            String sub=request.getParameter("sub");
            String filename="Assignment";
            rs=st.executeQuery("select file from "+key+" where subject='"+sub+"'");
            //File f=new File("assignment.pdf");
           // FileOutputStream fout=new FileOutputStream(f);
            
            if(rs.next())
            {
                Blob b=rs.getBlob("file");
                InputStream input = b.getBinaryStream();
                int length=input.available();
                String mimeType = "application/octet-stream";
                response.setContentType(mimeType);
                response.setContentLength(length);
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", filename);
                response.setHeader(headerKey, headerValue);
		byte[] buffer=new byte[4096];
                int bytesRead = -1;
                OutputStream outStream = response.getOutputStream(); 
                while ((bytesRead = input.read(buffer)) != -1) {
                    outStream.write(buffer,0,bytesRead);
                }
            }
            }
            catch(Exception e)
            {
                out.println(e);
            }
            %>
    </body>
</html>
