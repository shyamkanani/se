import java.io.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.*;

public class validation extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
                 response.setContentType("text/html;charset=UTF-8");
                 PrintWriter out = response.getWriter();
                 
            try
            {
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
            String sqlQuery = "select * from login where username=? and password=? and user=?";
            PreparedStatement pst = cn.prepareStatement(sqlQuery);
            pst.setString(1, request.getParameter("username"));
            pst.setString(2, request.getParameter("password"));
            pst.setString(3, request.getParameter("select"));
            ResultSet rs=pst.executeQuery();
            int flag=0;
            while(rs.next()){
                String st = rs.getString("user");
                if(st.equals("Student"))
                    flag=flag+1;
                else if(st.equals("professor"))
                    flag=flag+2;
                String s=String.valueOf(rs.getString("username"));
                Cookie ck=new Cookie("username",s);
                response.addCookie(ck);
            }
            if(flag==0)
            {
                 out.print("<h3 style=\"color:red; text-align:center \">Sorry UserName Or Password Are Incorrect! </h3>"); 
                 RequestDispatcher rd=request.getRequestDispatcher("index.html");  
                 rd.include(request, response);
            }
            else if(flag==1)
            {
                response.sendRedirect("login.jsp");
            }
            else if(flag==2)
            {
                response.sendRedirect("display.jsp");
            }
            }
            catch(ClassNotFoundException e)
            {
                   System.out.println(e.getMessage());
            }
            catch(SQLException e)
            {
                   System.out.println(e.getMessage());
            }
            catch(Exception e)
            {
                   System.out.println(e.getMessage());
            }
    }
}
