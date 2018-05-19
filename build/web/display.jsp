<%-- 
    Document   : display.jsp
    Created on : 18 Apr, 2018, 6:03:52 PM
    Author     : MyHP
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DashBoard</title>
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
            try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/se","root","student");
            Statement st=cn.createStatement();
            String key="";
            Cookie ck[]=request.getCookies();
            for(int i=0;i<ck.length;i++)
            {  
                key =ck[i].getValue();
            }
            ResultSet rs,rs1,rs2;
            key=String.valueOf(key);
            rs=st.executeQuery("select * from login where username='"+key+"'");
            while(rs.next())
            {
            %>
            <div class='alert alert-info' role='alert' >
            <h2 style="color:red; ">Welcome <%=rs.getString("fnm")%>&nbsp;<%=rs.getString("lnm")%></h2>
            <h3>User : <%=rs.getString("user")%></h3>
            <h3>Subject : <%=rs.getString("username")%></h3>
            <br/>
            </div>
            <% } %>
            <table class='table table-striped table-dark' border='2'>
            <thead>
            <tr><th colspan='8'><a href='#' class='alert-link' ><h5 class='alert alert-light' role='alert' align='center'> DashBoard </h5> </a></th></tr>
            <tr><th>#</th><th>Enrollment No.</th><th>Submitted File</th><th>Comment</th><th>Review</th><th>Operation</th></tr>
            </thead> 
            <%  
                int i=0;
                rs=st.executeQuery("select * from login where user='Student'");
                while(rs.next())
                {
                    String tbl = "s"+rs.getString("username");
                    Statement st1=cn.createStatement();
                    rs2=st1.executeQuery("select * from "+tbl+" where subject='"+key+"'");
                    while(rs2.next())
                    {%>
                        <tbody>
                        <tr>
                        <td><%= i+1 %></td>
                        <td><%=rs.getString("username")%></td>
                        <td><a  target="_blank" href="download.jsp?sub=<%=key%>">Download</a></td>
                        <td><%=rs2.getString("comment")%></td>
                        <td><%=rs2.getString("review")%></td> 
                        <td><a href="update.html?id=<%=rs.getString("username")%>"></a></td>
                        </tr>
                    <%}
                }
                %>
                    </tbody>
            </table>
            
                        <%
            }
              catch(Exception e)
            {
                out.println(e);
            }
            %>
    </body>
</html>
