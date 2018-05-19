<%-- 
    Document   : demo
    Created on : 15 Apr, 2018, 7:42:25 PM
    Author     : MyHP
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' crossorigin='anonymous'>
        <script src='https://code.jquery.com/jquery-3.2.1.slim.min.js' crossorigin='anonymous'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js' crossorigin='anonymous'></script>
        <script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js' crossorigin='anonymous'></script> 
    </head>
    <body>
        <nav class='navbar navbar-light bg-light'>
            <a class='navbar-brand' href='#'><img src='my.png' width='30' height='30' alt='SK' >Online Submission</a>
            <ul class='nav nav-tabs'>
            <li class='nav-item'>
            <a class='nav-link active' href='pdisplay.jsp'>DashBoard</a>
            </li>
            <li class='nav-item'>
            <a class='nav-link' href='about.html'>About</a>
            </li>
            <li class='nav-item'>
            <a class='nav-link' href='logout'>Log Out</a>
            </li>
            </ul>
        </nav>
         <%
            try
            {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
            Statement st=cn.createStatement();
            String key="";
            Cookie ck[]=request.getCookies();
            for(int i=0;i<ck.length;i++)
            {  
                key =ck[i].getValue();
            }
            ResultSet rs;
            ResultSet rs2;
            key=String.valueOf(key);
            rs=st.executeQuery("select *from login ");
            while(rs.next())
            {
                String ch1=rs.getString("username");
                String ch=rs.getString("user");
                if(ch.equals("professor") && ch1.equals(key))
                {
            %>
            <div class='alert alert-info' role='alert' >
            <h2 style="color:red; ">Welcome <%=rs.getString("fnm")%>&nbsp;<%=rs.getString("lnm")%></h2>
            <h3>User : <%=ch%></h3>
            <h3>Subject : <%=ch1%></h3>
            <br/>
            </div>
            <% }
            } %>
            
            <br/>
            <table class='table table-striped table-dark' border='2'>
            <thead>
            <tr><th colspan='8'><a href='#' class='alert-link' ><h5 class='alert alert-light' role='alert' align='center'> DashBoard </h5> </a></th></tr>
            <tr><th>#</th><th>Enrollment No.</th><th>Submitted File</th><th>Comment</th><th>Review</th><th>Operation</th></tr>
            </thead>
           <%
            int i=0;
            key=String.valueOf(key);
            rs2=st.executeQuery("select * from login ");
            while(rs2.next())
            {
                String check=rs2.getString("user");
                if(check.equals("student"))
                {
                    String test=rs2.getString("username");
                    String tbl="s"+test;
                    ResultSet rs1=st.executeQuery("select * from  "+tbl );
            %>
                <tbody>
                <tr>
                <td><%= i=i+1%></td>
                <td><%=rs2.getString("username")%></td>
                <td><a href="#">Download</a></td>
                <td><%=rs1.getString("comment")%></td> 
                <td><%=rs1.getString("review")%></td>
                <td><a href='<%="update?uname="+rs2.getString("username")%>'>Edit</a></td>
                </tr>
                </tbody>
                </table>
            </form>
            <%}
            }            
            }
            catch(Exception e )
            {
                out.println(e);
            }
        %> 
    </body>
</html>
