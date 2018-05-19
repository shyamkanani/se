import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig(maxFileSize = 16177215)
public class submission extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
                PrintWriter out =response.getWriter();
                response.setContentType("text/html");
        try
        {
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
                Statement st=cn.createStatement();
                String key="";
                Cookie ck[]=request.getCookies();
                for(int i=0;i<ck.length;i++)
                {  
                    key ="s"+ck[i].getValue();
                }
                String sub=request.getParameter("sub");
                InputStream inputStream = null;
                //File file = new File(request.getParameter("file"));
                key=String.valueOf(key);
                PreparedStatement ps=cn.prepareStatement("update "+ key +" set file=?, submit=? where subject=?");
                 Part filePart = request.getPart("file");
                 if (filePart != null) 
                 {
                    System.out.println(filePart.getName());
                    System.out.println(filePart.getSize());
                    System.out.println(filePart.getContentType());
                    inputStream = filePart.getInputStream();
                 }
                 if (inputStream != null) 
                 {
                    ps.setBlob(1, inputStream);
                 }
                //FileInputStream fin=new FileInputStream(file);
                // ps.setBinaryStream(1,fin,fin.available());
		ps.setString(2,"Yes");
                ps.setString(3,sub);
                ps.executeUpdate();
                response.sendRedirect("login.jsp");
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }
}
