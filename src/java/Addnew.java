import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Addnew extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out =response.getWriter();
                response.setContentType("text/html");
        try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
                Statement st=cn.createStatement();
                String fnm=request.getParameter("fnm");
                String lnm=request.getParameter("lnm");
                String name=request.getParameter("username");
                String email=request.getParameter("email");
                String pwd=request.getParameter("password");
                String u="Student";
                String tbl="s"+name;
                String [] arr=new String[5];
                arr[0]="AdvanceJavaTechnology";
                arr[1]="WebTechnology";
                arr[2]="SoftwareEngineering";
                arr[3]="DotNetTechnology";
                arr[4]="TheoryOfComputation";
                
                String q = "create table "+ tbl +"(id int primary key,"+"subject varchar(99),"+"file longtext null,"+"submit varchar(99),"+"comment varchar(99),"+"review varchar(99))";
                st.executeUpdate(q);
                for(int i=0;i<5;i++)
                {
                    PreparedStatement pst1 = cn.prepareStatement("insert into "+tbl+" values(?,?,?,?,?,?)");
                    pst1.setInt(1,i+1);
                    pst1.setString(2,arr[i]); 
                    pst1.setString(3,null);
                    pst1.setString(4,"No");
                    pst1.setString(5,"No");
                    pst1.setString(6,"No");
                    pst1.executeUpdate();
                }
                PreparedStatement pst = cn.prepareStatement("insert into login values(?,?,?,?,?,?)");
                pst.setString(1,fnm);
                pst.setString(2,lnm); 
                pst.setString(3,name);
                pst.setString(4,pwd);
                pst.setString(5,u);
                pst.setString(6,email);
                pst.executeUpdate();
                response.sendRedirect("index.html");
            }
            catch(ClassNotFoundException e){
               System.out.println("<p> Error :</p>"+e.getMessage());
            }catch(SQLException e){
               System.out.println("<p> Error :</p>"+e.getMessage());
            }
            catch(Exception e){
                System.out.println("<p> Error :</p>"+e.getMessage());
            }
    }
}