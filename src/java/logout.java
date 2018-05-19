import java.io.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Pragma","no-cache");
        response.setDateHeader ("Expires", 0);
        Cookie ck=new Cookie("username","");
        ck.setMaxAge(0);
        response.addCookie(ck);
        response.sendRedirect("index.html?msg=YouLogOutSuccessfully");
    }
}
