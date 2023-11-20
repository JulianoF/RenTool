import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class searchServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html");// setting the content type
        PrintWriter pw = res.getWriter();// get the stream to write the data

        // writing html in the stream
        pw.println("<html><body>");
        pw.println("Welcome to servlet SEARCH");
        pw.println("</body></html>");

        res.sendRedirect("searchResults.jsp");  
        pw.close();// closing the stream
    }
}