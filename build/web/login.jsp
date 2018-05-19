<%-- 
    Document   : login
    Created on : 9 Apr, 2018, 4:03:29 PM
    Author     : MyHP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.sql.*,javax.servlet.http.*,javax.servlet.*"%>
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
            <a class='nav-link active' href='login.jsp'>DashBoard</a>
            </li>
            <li class='nav-item'>
                <a class='nav-link' href='submission.html'>Submission</a>
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
            ResultSet rs;
            key=String.valueOf(key);
            rs=st.executeQuery("select * from login where username="+key);
            while(rs.next())
            {
            %>
            
            <div class='alert alert-info' role='alert' >
            <h2 style="color:red; ">Welcome <%=rs.getString("fnm")%>&nbsp;<%=rs.getString("lnm")%></h2>
            <h3>Enrollment No : <%=rs.getString("username")%></h3>
            <h3>User : <%=rs.getString("user")%></h3>
            <br/>
            </div>
            <% } %>
            <table class='table table-striped table-dark' border='2'>
            <thead>
            <tr><th colspan='8'><a href='#' class='alert-link' ><h5 class='alert alert-light' role='alert' align='center'> DashBoard </h5> </a></th></tr>
            <tr><th>#</th><th>Subject</th><th>Submitted File</th><th>Submitted</th><th>Comment</th><th>Reviewed</th></tr>
            </thead>            
        <%  
            key="s"+key;
            rs=st.executeQuery("select * from "+key);
            while(rs.next())
            {%>
                <tbody>
                <tr>
                <td><%=rs.getInt("id")%></td>
                <td><%=rs.getString("subject")%></td>
                <td><a  target="_blank" href="download.jsp?sub=<%=rs.getString("subject")%>">Download</a></td>
                <td><%=rs.getString("submit")%></td>
                <td><%=rs.getString("comment")%></td> 
                <td><%=rs.getString("review")%></td>
                </tr>
                <%
            }  
            %>
            </tbody>
            </table>
            <%
            }
            catch(Exception e )
            {
                out.println(e);
            }
        %>
    </body>
</html>