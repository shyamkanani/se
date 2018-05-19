import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class update extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        try{
                Connection cn=null;
                Class.forName("com.mysql.jdbc.Driver");
                cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
                Statement st=cn.createStatement();
                String str=request.getParameter("cmt");
                String val=request.getParameter("select");
                String key="";
                Cookie ck[]=request.getCookies();
                for(int i=0;i<ck.length;i++)
                {  
                    key ="s"+ck[i].getValue();
                }
                String q="update key set comment="+str+"review="+val;
                st.executeUpdate(q);
                response.sendRedirect("pdisplay.jsp");
        }
        catch(Exception e)
        {
            System.out.println("<p> Error :</p>"+e.getMessage());
        }
    }
}
